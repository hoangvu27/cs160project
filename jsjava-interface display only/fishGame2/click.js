'use strict';
/*jshint esversion: 6 */
/*jslint node: true */
function deliverCard(index) {
		let a = document.createElement('img')
		a.setAttribute('src', 'cardFace/back.png')
		a.setAttribute('alt', '')
		a.style = "width:100px ;  height: 140px;  position: absolute; " 
		
	
	if (index % 4 === 0) {
		a.setAttribute('class', 'main')
		a.style.animation = "moveToMain 0.5s 1"		
		setTimeout(	() => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 540px;  left: 0px; "
						  	let temp = 350 + 50*( index / 4 )
						  	a.style.left = "" + temp + "px"
						  } , 500 )	
		
	} else if (index % 4 === 1) {
		a.style = "width:100px ;  height: 140px;  position: absolute; transform: rotate(90deg); " 
		a.setAttribute('class', 'left')
		a.style.animation = "moveToLeft 0.5s 1 "		
		setTimeout(	() => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 20px;  left: 0px; transform: rotate(90deg); "
						  		let temp = 20 + 35*( index / 4 )
						  	a.style.top = "" + temp + "px"
						  } , 500 )	
		
	} else if (index % 4 === 2) {
		a.setAttribute('class', 'middle')
		a.style.animation = "moveToMiddle 0.5s 1"		
		setTimeout(	() => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 60px;  left: 350px; "
						   	let temp = 350 + 35*( index / 4 )
						   	a.style.left = "" + temp + "px"
						  } , 500 )						  	
		
	} else {
		a.setAttribute('class', 'right')
		a.style = "width:100px ;  height: 140px;  position: absolute; transform: rotate(90deg); " 
		a.style.animation = "moveToRight 0.5s 1 "		
		setTimeout(	() => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 20px;  left: 1250px; transform: rotate(90deg); "
						  		let temp = 50 + 35*( index / 4 )
						  	a.style.top = "" + temp + "px"
						  } , 500 )		
	}
	try {
		document.getElementById('imgContainer').appendChild(a)
	}
	catch(err) {
	
	}
}

function showMainHand(mainPlayer) {
//	try {
//		for ( let element of document.getElementsByClassName('main') ) {
//			element.remove()
//		}
//	} catch (err) {
//		
//	}
//
//	for (let i=0; i< mainPlayer.getHand().length; i++) {
//		
//		let cardURL = 'cardFace/' + mainPlayer.getHand()[i].getImgName() + '.png'
//		let a = document.createElement('img')
//		a.setAttribute('class', 'main')
//		a.setAttribute('src', cardURL)
//		a.setAttribute('alt', '')
//		a.style = "width:100px ;  height: 140px;  position: absolute; top: 540px; left: 0px" 
//		let temp = 350 + 50*i
//		a.style.left = "" + temp + "px"
//		document.getElementById('imgContainer').appendChild(a)
//	}
	
	let elements = document.getElementsByClassName('main')
	let originalElementLength = elements.length
	let mainHand = mainPlayer.getHand()
	if (elements.length < mainHand.length) {
		for (let i=0 ; i < mainHand.length - elements.length; i++ ) {
			let a = document.createElement('img')
			a.setAttribute('class', 'main')
			a.setAttribute('src', 'cardFace/back.png')
			a.setAttribute('alt', '')
			a.style = "width:100px ;  height: 140px;  position: absolute; top: 540px; left: 0px" 
			let temp = 350 + 50 * ( i + originalElementLength ) 
			a.style.left = "" + temp + "px"
			document.getElementById('imgContainer').appendChild(a)
		}
	}
	elements = document.getElementsByClassName('main')
	
	for (let i=0; i< mainPlayer.getHand().length; i++) {
		
		let cardURL = 'cardFace/' + mainPlayer.getHand()[i].getImgName() + '.png'
		let b = elements[i].src = cardURL
	}
}

function loadGame(deliverCard) {
	let i = 0;
	let a = setInterval( () => {   deliverCard(i);
									i++;
									if (i === 20) { clearInterval(a); } 
							}, 100); 
//    for (let card of mainHand ) {
//		let b = card.getNumber()
//		let c = card.getType()
//	}	
}

let game;
function startGame(loadGame, deliverCard) {
			document.getElementById('play').style.display = "none";
			document.getElementById('next').style.display = "block";
			document.getElementById('ask').style.display = "block";
		document.getElementById('Replay').style.display = "block";
	
		let imgContainer = document.createElement('div')
		imgContainer.setAttribute('id', 'imgContainer')
		document.body.appendChild(imgContainer)
		game = new Game(deliverCard, updateHand, updateFailHand)
	
		game.setState(11)
		let temp = game.getPlayer()
		console.log(temp[0].getHand() );
		console.log(temp[1].getHand() );
		console.log(temp[2].getHand() );
		console.log(temp[3].getHand() );
		
		loadGame(deliverCard, temp[0].getHand())
		document.getElementById('music').autoplay = true;
		document.getElementById('music').play()
	}

function next() {
	game.next()
	if ( game.getIndexTrack() === -1 ) {
		document.getElementsByClassName('cardDeck')[0].style.display = "none"
	}
	
	let players = game.getPlayer()
	if ( game.getState() === 3 ) {
	
	}
	else if (game.getState() === 10) {
		let players = game.getPlayer()
		let max = 0
		let winnerIndex = -1
		for (let i = 0; i < players.length; i++) {
			if ( max <= players[i].getScore() ) { 
				max = players[i].getScore()
				winnerIndex = i
			}
		}
		alert('The game has ended and the winner is ' + players[winnerIndex].getName() + ' with ' + max)
	}
	else if (game.getState() === 11) {
		showMainHand(players[0])
		game.setState(1)
	}
		
	
	
		console.log(players[0].getHand() );
		console.log(players[1].getHand() );
		console.log(players[2].getHand() );
		console.log(players[3].getHand() );
	console.log(game.getState() );
	console.log(game.getIndexTrack() );
	console.log(game.getCardLeft() );
}

function confirmReplay() {
	let  modal = document.getElementById("myModal");
	modal.style.display = "block";
}

function closeConfirm() {
	let  modal = document.getElementById("myModal");
	 modal.style.display = "none";
}

function restart() {
	document.getElementById('play').style.display = "block";
	document.getElementById('next').style.display = "none";
	document.getElementById('ask').style.display = "none";
	document.getElementById('Replay').style.display = "none";
	document.getElementById("myModal").style.display = "none";
	let temp = document.getElementById('imgContainer')
	document.body.removeChild(temp)
}

function engGame() {
	game.setState(10)
	document.getElementById('ask').style.display = "none";
	
}
