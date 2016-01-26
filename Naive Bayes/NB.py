import csv

with open('voting_train.data', 'r') as f:
    reader = csv.reader(f)
    train_data = list(reader)

with open('voting_test.data', 'r') as f:
    reader = csv.reader(f)
    test_data = list(reader)

label_count = {'republican':0.0,'democrat':0.0}
attr_prob = {1:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},2:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},3:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},4:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},5:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},6:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},7:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},8:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},9:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},10:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},11:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},12:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},13:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},14:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},15:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}},16:{'republican':{'y':0.0,'n':0.0},'democrat':{'y':0.0,'n':0.0}}}

for i in range(0,len(train_data)):
    if('?' not in train_data[i]):
        label = train_data[i][0]
        label_count[label] +=1
        for j in attr_prob.keys():
                attr_prob[j][label][train_data[i][j]] += 1

for i in attr_prob.keys():
    for j in attr_prob[i].keys():
        for k in attr_prob[i][j].keys():
            attr_prob[i][j][k] = ( (attr_prob[i][j][k]) / (label_count[j]) )
            
hit_count = 0.0
line_count = 0.0

for i in range(0,len(test_data)):
    if('?' not in test_data[i]):
        line_count += 1
        act_label = test_data[i][0]
        prob = {'republican':( label_count['republican']/(label_count['republican']+label_count['democrat']) ) ,'democrat': ( label_count['democrat']/(label_count['republican']+label_count['democrat']) ) }
        for j in attr_prob.keys():
            prob['republican'] = prob['republican'] * (attr_prob[j]['republican'][test_data[i][j]])
            prob['democrat'] = prob['democrat'] * (attr_prob[j]['democrat'][test_data[i][j]])
        if( prob['republican'] > prob['democrat'] ):
            if(act_label == 'republican'):
                hit_count += 1
        else:
            if(act_label == 'democrat'):
                hit_count += 1

print(" Correctly Classified: %d\n Total Instances: %d\n Accuracy: %f" %(hit_count,line_count, 100 * ( hit_count/line_count ) ) )
