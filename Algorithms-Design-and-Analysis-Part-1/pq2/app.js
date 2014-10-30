//first 162085
//last 164123
//mid 138382

var fs=require('fs');
var test = [3, 9, 8, 4, 6, 10, 2, 5, 7, 1];

var swap = function(arr, i, j) {
	var temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
};

var median=function(x,y,z){
	arr=[x,y,z];
	arr=arr.sort(function(i,j){
		return i-j;
	});

	if(y==arr[1]){
		return 'mid';
	}
	if(z==arr[1]){
		return 'end';
	}
	return 'start';

}

var partition = function(arr, start, end) {
	if(end-start<1){
		return 0;
	}
	var pivotIndex=end;
	// var mid=Math.floor((end-start)/2)+start;
	// var result=median(arr[start],arr[mid],arr[end]);

	// if(result=='mid'){
	// 	pivotIndex=mid;
	// }else if(result=='end'){
	// 	pivotIndex=end;
	// }
	
	swap(arr,pivotIndex,start);
	
	var pivot = arr[start];
	for (var i = start+1 , j = start+1; j <= end; j++) {

		if (arr[j] <pivot) {
			swap(arr, i, j);
			i++
		}
	}
	swap(arr, start, i-1);
	return (end-start)+partition(arr, start,i-2)+partition(arr, i, end);
};

var sort = function(arr) {
	return partition(arr,0,arr.length-1);
}

fs.readFile('QuickSort.txt',function(err,data){
	var arr=data.toString().split('\r\n').slice(0,10000);
	
	arr=arr.map(function(e){
		return parseInt(e);
	});

	console.log(sort(arr));


});
