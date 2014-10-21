var fs=require('fs');

var x=[1,2,7,8];
var y=[3,4,5,6];

var splitCountMerage=function(lsx,lsy){
	var xi=0;
	var xl=lsx.length;

	var yi=0;
	var yl=lsy.length;

	var result=[];
	var count=0;

	while(xi<xl&&yi<yl){

		if(lsx[xi]<lsy[yi]){
			result.push(lsx[xi]);
			xi++;
		}else{
			result.push(lsy[yi]);
			yi++;
			count+=xl-xi;
		}
	}

	if(xi<xl){
		result=result.concat(lsx.slice(xi));
	}else{
		result=result.concat(lsy.slice(yi));
	}

	return {ls:result,count:count};
};

var inverseCount=function(ls){
	var len=ls.length;

	if(len<=1){
		return {
			count:0,
			ls:ls
		};
	}else{
		var mid=Math.floor(len/2);
		var rsx=inverseCount(ls.slice(0,mid));
		var rsy=inverseCount(ls.slice(mid));
		var rss=splitCountMerage(rsx.ls,rsy.ls);

		return {
			count:rsx.count+rsy.count+rss.count,
			ls:rss.ls
		}
	}

};

fs.readFile('IntegerArray.txt',function(err,data){
	var arr=data.toString().split('\r\n').slice(0,100000);
	
	arr=arr.map(function(e){
		return parseInt(e);
	});

	console.log(inverseCount(arr).count);

});

