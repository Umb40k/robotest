import pprint
from RPA.Salesforce import Salesforce
from RPA.Robocorp.Vault import FileSecrets

pp = pprint.PrettyPrinter(indent=4)
filesecrets = FileSecrets("secrets.json")
secrets = filesecrets.get_secret("salesforce")

sf = Salesforce()
sf.auth_with_token(
    username=secrets["USERNAME"],
    password=secrets["PASSWORD"],
    api_token=secrets["API_TOKEN"],
)
nokia_account_id = "0015I000002jBLDQA2"
account = sf.get_salesforce_object_by_id("Account", nokia_account_id)
pp.pprint(account)
billing_information = {
    "BillingStreet": "Nokia Bulevard 1",
    "BillingCity": "Espoo",
    "BillingPostalCode": "01210",
    "BillingCountry": "Finland",
}
result = sf.update_salesforce_object("Account", nokia_account_id, billing_information)
print(f"Update result: {result}")
