import 'package:flutter/material.dart';
import 'package:projecttaskmanager/style/style.dart';

ListView TaskList(TaskItms,DeleteItem,StatusChange){
  return ListView.builder(
      itemCount: TaskItms.length,
    itemBuilder: (context,index){

        Color statusColor = colorGreen;
        if(TaskItms[index]['status']=='New'){
          statusColor = colorBlue;
        }

        else if (TaskItms[index]['status']=='Progress'){
          statusColor = colorOrange;
        }

        else if (TaskItms[index]['status']=='Canceled'){
          statusColor = colorRed;
        }

        return Card (
          child: ItemSizeBox(
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TaskItms[index]['title'],style: Head6Text(colorDarkBlue),),
                Text(TaskItms[index]['description'],style: Head7Text(colorLightGray),),
                Text(TaskItms[index]['createdDate'],style: Head9Text(colorLightGray),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusChild(TaskItms[index]['status'],statusColor),
                    Container(
                      child: Row(
                        children: [
                          SizedBox(width: 50,height: 30,child: ElevatedButton(onPressed: (){
                            StatusChange(TaskItms[index]['_id']);
                          },child: Icon(Icons.edit_location_alt_outlined,size: 16,),style: AppStatusButtonStyle(colorBlue),),),

                          SizedBox(width: 10),

                          SizedBox(width: 50,height: 30,child: ElevatedButton(onPressed: (){
                            DeleteItem(TaskItms[index]['_id']);
                            }, child: Icon(Icons.delete_outlined,size: 16,),style: AppStatusButtonStyle(colorRed),
                          ),)
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ),


        );
    }
  );
}