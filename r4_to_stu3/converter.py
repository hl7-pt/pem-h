import json
from os import listdir


def transform_bundle_sd(data):

    json_string = json.dumps(data)

    newdata = json_string.replace(
        "Bundle.signature.who", "Bundle.signature.whoReference"
    )  # print(newdata)
    return json.loads(newdata)


def transfrom_extension(data):

    # data["context"] = ["DataElement"]
    data["contextType"] = "resource"
    # json_string = json.dumps(data)

    # newdata = json_string.replace("Extension.url", "Extension.url")  # print(newdata)
    return data


def transform_med_req_sd(data):
    data["differential"]["element"].append(
        {
            "id": "MedicationRequest.requester.onBehalfOf",
            "path": "MedicationRequest.requester.onBehalfOf",
            "short": "Refer\u00eancia para um resource que cont\u00e9m informa\u00e7\u00f5es do profissional que inicialmente adicionou a prescri\u00e7\u00e3o. Este elemento n\u00e3o pode ser mais alterado em toda a vida do recurso.",
            "type": [
                {
                    "code": "Reference",
                    "targetProfile": [
                        "http://hl7.org/fhir/StructureDefinition/Organization"
                    ],
                }
            ],
        },
    )
    json_string = json.dumps(data)

    newdata = (
        json_string.replace("MedicationRequest.encounter", "MedicationRequest.context")
        .replace("MedicationRequest.requester", "MedicationRequest.requester.agent")
        .replace(
            "dosageInstruction.doseAndRate.doseQuantity",
            "dosageInstruction.doseQuantity",
        )
    )
    return json.loads(newdata)


def transform_msh_sd(data):

    data["differential"]["element"].append(
        {
            "id": "MessageHeader.timestamp",
            "path": "MessageHeader.timestamp",
            "short": "Time that the message was sent",
            "definition": "The time that the message was sent.",
            "requirements": "Allows limited detection of out-of-order and delayed transmission.  Also supports audit.",
            "min": 1,
            "max": "1",
            "type": [{"code": "instant"}],
            "isSummary": True,
            "mapping": [
                {"identity": "v2", "map": "MSH-7"},
                {"identity": "rim", "map": "./creationTime[isNormalDatatype()]"},
                {"identity": "w5", "map": "when.init"},
            ],
        }
    )
    json_string = json.dumps(data)

    newdata = json_string.replace(
        "MessageHeader.eventCoding", "MessageHeader.event"
    ).replace("destination.receiver", "receiver")
    # print(newdata)
    return json.loads(newdata)


def transform_to_stu3_sd(data, resourcetype):
    # print(resourcetype)
    if resourcetype == "MessageHeader":
        return transform_msh_sd(data)
    if resourcetype == "MedicationRequest":
        return transform_med_req_sd(data)
    if resourcetype == "Bundle":
        return transform_bundle_sd(data)
    return data


def transform_msh(data):
    # print(data)
    # print(data["eventCoding"])
    #  print("HEERE")
    data["event"] = data["eventCoding"]
    del data["eventCoding"]
    data["receiver"] = data["destination"][0]["receiver"]
    del data["destination"]
    data["timestamp"] = "2019-07-14T23:10:23+00:00"
    return data


def transfrom_location(data):
    data["type"] = data["type"][0]
    return data


def transfrom_medreq(data):
    # print(data)
    data["dosageInstruction"][0]["doseQuantity"] = data["dosageInstruction"][0][
        "doseAndRate"
    ][0]["doseQuantity"]
    del data["dosageInstruction"][0]["doseAndRate"]
    return data


def transfrom_med_req_group(data):

    #    //* action.label = 1
    data["action"]["label"] = 1

    return data


def transform_to_stu3(data, resourcetype):
    # print(resourcetype)
    if resourcetype == "MessageHeader":
        return transform_msh(data)
    if resourcetype == "Location":
        return transfrom_location(data)
    if resourcetype == "MedicationRequest":
        return transfrom_medreq(data)
    if resourcetype == "MedicationRequestGroup":
        return transfrom_med_req_group(data)
    return data


OUTPUT_FOLDER = "../input/profiles/"
INPUT_FOLDER = "fsh-generated/resources/"
EXTENSION_FOLDER = "../input/extensions/"
EXAMPLE_FOLDER = "../input/examples/"
VOCAB_FOLDER = "../input/vocabulary/"

# multiple elementsa
for file in listdir(INPUT_FOLDER):
    print(file)
    # n_file = file.split(".")[0]
    with open(INPUT_FOLDER + file) as jsonFile:
        data = json.load(jsonFile)
    if data.get("fhirVersion") is not None:
        data["fhirVersion"] = "3.0.2"
    restype = data.get("resourceType")
    # print(restype)
    type_ = data.get("type")
    # print(type_)
    if restype == "StructureDefinition":
        ndata = transform_to_stu3_sd(data, type_)

        if type_ == "Extension":
            ndata = transfrom_extension(data)
            with open(EXTENSION_FOLDER + file, "w") as file:
                json.dump(ndata, file)
        else:
            # print(type_)
            # transform_to_stu3(data, type_)
            with open(OUTPUT_FOLDER + file, "w") as file:
                json.dump(ndata, file)

    #  with open(EXTENSION_FOLDER + file, "w") as file:
    #      json.dump(data, file)
    elif data["resourceType"] == "ValueSet":
        pass
    # with open(VOCAB_FOLDER + file, "w") as file:
    #    json.dump(data, file)
    elif data["resourceType"] == "CodeSystem":
        pass
        # with open(VOCAB_FOLDER + file, "w") as file:
        #    json.dump(data, file)
    else:
        print(type_, restype)
        if restype == "Bundle" and type_ != "StructureDefinition":
            ndata = data.copy()
            for entry in ndata["entry"]:
                print(entry["resource"], "----")
                entry["resource"] = transform_to_stu3(
                    entry["resource"], entry["resource"]["resourceType"]
                )
        else:
            ndata = transform_to_stu3(data, restype)
        with open(EXAMPLE_FOLDER + file, "w") as file:
            json.dump(ndata, file)
