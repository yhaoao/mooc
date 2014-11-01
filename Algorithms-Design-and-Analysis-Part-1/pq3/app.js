var fs=require('fs');
var util=require('util');
var _=require('lodash');

//数据结构
// [
	// [[0],[1,2,3,7]],
	// [[1],[0,2,3]],
	// [[2],[0,1,3]],
	// [[3],[0,1,2,4]],                                           
	// [[4],[3,5,6,7]],             
	// [[5],[4,6,7]],
	// [[6],[4,5,7]],
	// [[7],[0,4,5,6]]
//]

function Graph(arr){
	this.graph=[];
	for(var i=0;i<arr.length;i++){
		this.graph.push([[arr[i][0]],arr[i].slice(1)]);
	}
}

Graph.prototype.randomMerage=function(){
	var rand1=Math.floor(Math.random()*this.graph.length);
	var rand1Adjs=this.graph[rand1][1];
	var randVertex=_.sample(rand1Adjs);
	var rand2=this.getVertexListIndex(randVertex);

	if(rand1!=rand2){
		this.graph[rand1][0]=this.graph[rand1][0].concat(this.graph[rand2][0]);
		this.graph[rand1][1]=this.graph[rand1][1].concat(this.graph[rand2][1]);
		this.graph.splice(rand2,1);
	}
	
};

Graph.prototype.getVertexListIndex=function(k){
	var result=undefined;
	for(var i=0;i<this.graph.length;i++){
		if(this.graph[i][0].indexOf(k)>=0){
			result= i;
		}
	}

	return result;
};

Graph.prototype.getVertexListLength=function(){
	return this.graph.length;
};

Graph.prototype.toString=function(){
	var result='';
	for(var i=0;i<this.graph.length;i++){
		for(var j=0;j<this.graph[i][0].length;j++){
			result+=this.graph[i][0][j]+' ';
		}
		result+=':';
		for(var k=0;k<this.graph[i][1].length;k++){
			result+=this.graph[i][1][k]+' ';
		}
		result+='\n';
	}
	return result;
};

Graph.prototype.cutCount=function(){
	while(this.getVertexListLength()>2){
		this.randomMerage();
	}
	var count=0;

	for(var i=0;i<this.graph[0][1].length;i++){
		if(this.graph[1][0].indexOf(this.graph[0][1][i])>=0){
			count+=1;
		}
	}

	return count;
};


fs.readFile('kargerMinCut.txt',function(err,data){
	var arr=data.toString().split('\r\n').slice(0,-1);
	
	arr=arr.map(function(e){
		return e.split('\t').map(function(i){
			return parseInt(i);
		}).slice(0,-1);
	});


	var min=Number.MAX_VALUE;

	for(var i=0;i<100000;i++){
		var graph=new Graph(arr);
		var cutCount=graph.cutCount();
		if(cutCount<min){
			min=cutCount;
		}
	}

	console.log(min);

});