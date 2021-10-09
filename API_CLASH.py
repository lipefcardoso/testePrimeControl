
class API_CLASH:
    import requests
    import csv
    import traceback

    def get_clan_information(self, obj_api):
        self.header = {'content-type': 'application/json','Authorization':'Bearer ' +  obj_api['api_key']}
        url = obj_api['url']
        try:
            r = self.requests.get(url=url, headers=self.header, verify=False)
            return r.json()
        except Exception as e: 
            print(self.traceback.format_exc())
            return 

    def get_clan_tag(self, obj_clan):
        items = obj_clan["items"]
        try:
            for item in items:
                if "#9V2Y" in item["tag"] and item["name"] == 'The resistance' and item["location"]["name"] == "Brazil":
                    return self.requests.utils.quote(item["tag"])
        except Exception as e:
            print(self.traceback.format_exc())
            return 

    def get_clan_member_information(self, obj_api):
        self.header = {'content-type': 'application/json','Authorization':'Bearer ' +  obj_api['api_key']}
        url = obj_api['url']
        try:
            r = self.requests.get(url=url, headers=self.header, verify=False)
            return r.json()
        except Exception as e: 
            print(self.traceback.format_exc())
            return 

    def write_to_csv(self, csv_path, obj_clan_members):
        fieldnames = ["Nome", "Level", "Troféu", "Papel"]
        try:
            with open(csv_path, 'w',encoding='utf-8-sig', newline="") as file:
                writer = self.csv.DictWriter(file, delimiter = ";", fieldnames = fieldnames)
                writer.writeheader()
                for item in obj_clan_members["items"]:
                    writer.writerow({"Nome" : item["name"], "Level" : item["expLevel"], "Troféu" : item["trophies"], "Papel" : item["role"]})
            return True
        except Exception as e:
            print(self.traceback.format_exc())
            return 



import requests
import traceback
def teste(obj_api):
        header = {'content-type': 'application/json','Authorization':'Bearer ' +  obj_api['api_key']}
        url = obj_api['url']
        try:
            r = requests.get(url=url, headers=header, verify=False)
            return r.json()
        except Exception as e: 
            print(traceback.format_exc())
            return traceback.format_exc()

api = {

    "url":"https://api.clashroyale.com/v1/clans?name=The Resistance",
    "api_key":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjJkYjdhMTM5LTY3MzUtNDg2YS05ZGMyLTk1ODEwODRhMGQzZiIsImlhdCI6MTYzMzc2Nzg5NSwic3ViIjoiZGV2ZWxvcGVyL2QwNDM0NzA1LTliZDYtZWYxMS1hYmEzLTViODg0OWVmNjM5YyIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIxNzkuMTExLjM4LjE5MCJdLCJ0eXBlIjoiY2xpZW50In1dfQ.GE24eKM7ag8ZgGF1wQkGHDHve-s_biIVpa_aXtE5aey5VCf5y2hLfOFICHt-Y8V0KwsgZ8kbQAN8l3Uu-z1ukg"

}

retorno_teste = teste(api)
print(retorno_teste)
