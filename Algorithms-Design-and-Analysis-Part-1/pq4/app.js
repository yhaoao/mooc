var fs=require('fs');
var graph=require('./graph');

fs.readFile('SCC.txt',function(err,data){
	var arr=data.toString().split('\n').slice(0,-1);
	arr=arr.map(function(e){
		return e.split(' ').map(function(i){
			return parseInt(i);
		}).slice(0,-1);
	});
	console.log(arr);

});