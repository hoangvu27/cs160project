'use strict';
/*jshint esversion: 6 */
/*jslint node: true */
 
//these 2 functions can reduce repeated codes, but somehow, they contain bugs 
//maybe, them problem is that can only access private variables of Game through methods 
function updateHand(player, Game) {
//      if ( Game.cardLeft === 0 ) { 
//          Game.state = 10 
////                this is the only way for game to end 
//          return undefined
//      }
//
//          while ( Game.personInTurn.getHand().length === 0 ) {
//              Game.personInTurn =  Game.personInTurn.next()
//          }
//      
}
 
function updateFailHand(Game) {
//  let z =  Game.getActualIndexTrack() + 1
//  
//  if ( z < 52) {
//      let newCard = Game.getDeck().getCard( z )
//      Game.personInTurn.addCard(newCard)
//      Game.cardLeft = Game.cardLeft - 4 * Game.personInTurn.setScore( newCard.getNumber() )
//  }
//
//      Game.personInTurn = Game.personInTurn.next() // here, personInTurn has to pass turn to next player
//      while ( Game.personInTurn.getHand().length === 0 ) {
//              Game.personInTurn =  Game.personInTurn.next()
//      }
}
 
 
class Game {
    constructor(deliverCard) {
        this.state = 0; 
        this.turn = 0;
        this.indexTrack = 19;
        this.level = [ 'easy', 'normal', 'hard']
        this.cardLeft = 52;
         
        this.playerLeft = new Player('2')
        this.playerMiddle = new Player('3')
        this.playerRight = new Player('4')
        this.mainPlayer = new Player('1')
        this.cardDeck = new cardDeck(shuffle);
         
        this.mainPlayer.setNext(this.playerLeft)
        this.playerLeft.setNext(this.playerMiddle)
        this.playerMiddle.setNext(this.playerRight)
        this.playerRight.setNext(this.mainPlayer)
         
        for (let i = 0; i < 20; i++) {
            if (i % 4 === 0) { this.mainPlayer.addCard(this.cardDeck.getCard(i))  }
            else if (i % 4 === 1) { this.playerLeft.addCard(this.cardDeck.getCard(i))  }
            else if (i % 4 === 2) { this.playerMiddle.addCard(this.cardDeck.getCard(i))  }
            else { this.playerRight.addCard(this.cardDeck.getCard(i)) ;}
        }
        this.playerLeft.sort() 
        this.playerMiddle.sort() 
        this.playerRight.sort() 
        this.mainPlayer.sort() 
         
        this.mainPlayer.lucky() 
        this.playerLeft.lucky() 
        this.playerMiddle.lucky() 
        this.playerRight.lucky() 
         
        this.personInTurn = this.mainPlayer; // the main always starts the game 
    }
     
    next() {
        let targetPerson;
        let targetCard;
        let found = false
        let taken = false
        let targetCount = 0
        let lastTargetIndex = -1
         
        if ( this.state === 1 ) {
            let targetValue = document.getElementById('askPlayer').value
            targetCard = document.getElementById('askCard')
 
            if (targetValue == 'Left') { targetPerson = this.playerLeft }
            else if  (targetValue == 'Middle') { targetPerson = this.playerMiddle }
            else { targetPerson = this.playerRight }
             
            if (targetPerson.getHand().length === 0) {
                document.getElementById('Message').innerHTML += "this person now has 0 cards"
                return undefined
            }
            document.getElementById('Message').innerHTML = ""
            this.mainPlayer.getHand().forEach( function(element) {   
                                if (element.getNumber() == targetCard.value) { found = true }
                    })
 
             
            if  (found === false ) { 
                    document.getElementById('Message').innerHTML += "choose number in your hand"
                    return undefined        
            }
                document.getElementById('Message').innerHTML = ""
                 
                let reply = targetPerson.reply(targetCard.value)
                document.getElementById('Highlight').innerHTML = ""
                document.getElementById('Highlight').innerHTML += this.personInTurn.getName() + " ask " + targetPerson.getName() + " about " + targetCard.value + " <br>"
             
                if (reply.taken === true) {
                    let takenCards = targetPerson.getHand().splice( reply.lastTargetIndex - reply.targetCount + 1, reply.targetCount)
                    let newHand = this.mainPlayer.getHand().concat(takenCards)
                    this.mainPlayer.setHand(newHand)
                    document.getElementById('Highlight').innerHTML += "Yes, " + targetPerson.getName() + " has " + takenCards.length + " card(s) of " + targetCard.value + " <br>"
                    this.cardLeft = this.cardLeft - 4 * this.mainPlayer.setScore( takenCards[0].getNumber() )
                     
//                  updateHand( this)
                    if ( this.cardLeft === 0 ) { 
                        this.state = 10
                        return undefined
                    }
                    if ( this.mainPlayer.getHand().length === 0) {
                        document.getElementById('End').display = "block"
                        this.personInTurn =  this.mainPlayer.next()
                        this.state = 3
                        while ( this.personInTurn.getHand().length === 0 ) {
                            this.personInTurn =  this.personInTurn.next()
                        }
                        document.getElementById('Highlight').innerHTML += "Now is " + this.personInTurn.getName() + " turn " + " <br>"
                    }
                     
                }
                else {
                    this.state = 3
//                  updateFailHand( this)
                    this.indexTrack++
                    document.getElementById('Highlight').innerHTML += "No, " + targetPerson.getName() + " does not have the card "  + targetCard.value + " <br>"
                     
                    if ( this.indexTrack < 52) {
                        let newCard = this.cardDeck.getCard( this.indexTrack )
                        this.mainPlayer.addCard(newCard)
                        document.getElementById('Highlight').innerHTML += this.personInTurn.getName() + " draws a new card " + newCard.getImgName() + " <br>"
                        this.mainPlayer.drawCard()
//                      this.mainPlayer.showCard()
                        setTimeout(this.mainPlayer.showCard(), 1000)
                        this.cardLeft = this.cardLeft - 4 * this.mainPlayer.setScore( newCard.getNumber() )
 
                    }
                    this.personInTurn = this.mainPlayer.next()
                    while ( this.personInTurn.getHand().length === 0 ) {
                                this.personInTurn =  this.personInTurn.next()
                    }
                    document.getElementById('Highlight').innerHTML += "Now is " + this.personInTurn.getName() + " turn " + " <br>"
             }
           
             
        } else if ( this.state === 3 ) { 
            let ask;
            ask = this.personInTurn.ask()
            let p = ask.personIndex - 1
 
            if ( p  === 0 ) {targetPerson = this.mainPlayer }
            else if (p  === 1) { targetPerson = this.playerLeft }
            else if (p  === 2 ) {  targetPerson = this.playerMiddle }
            else if (p  === 3 ) { targetPerson = this.playerRight } 
     
            while ( targetPerson.getHand().length === 0) {
                p = (p + 1) % 4 
                if ( p  === 0 ) {targetPerson = this.mainPlayer }
                else if (p  === 1) { targetPerson = this.playerLeft }
                else if (p  === 2 ) {  targetPerson = this.playerMiddle }
                else if (p  === 3 ) { targetPerson = this.playerRight } 
            }
             
            let reply = targetPerson.reply(ask.targetCardNumber)
            console.log(ask)
            console.log(reply)
            document.getElementById('Highlight').innerHTML = ""
            document.getElementById('Highlight').innerHTML += this.personInTurn.getName() + " ask " + targetPerson.getName() + " about " + ask.targetCardNumber + " <br>"
            if (reply.taken === true ) {
                let takenCards = targetPerson.getHand().splice( reply.lastTargetIndex - reply.targetCount + 1, reply.targetCount)
                let newHand = this.personInTurn.getHand().concat(takenCards)
                this.personInTurn.setHand(newHand)
                this.personInTurn.sort()
                document.getElementById('Highlight').innerHTML += "Yes, " + targetPerson.getName() + " has " + takenCards.length + " card(s) of " + ask.targetCardNumber + " <br>"
                this.cardLeft = this.cardLeft - 4 * this.personInTurn.setScore(takenCards[0].getNumber())
                 
                 
//              updateHand(this)
                    if ( this.cardLeft === 0 ) { 
                        this.state = 10
                        return undefined
                    }
                    if ( this.personInTurn.getHand().length === 0) {
                            this.personInTurn =  this.personInTurn.next()
                         
                            while ( this.personInTurn.getHand().length === 0 ) {
                                this.personInTurn =  this.personInTurn.next()
                            }
                            document.getElementById('Highlight').innerHTML += "Now is " + this.personInTurn.getName() + " turn " + " <br>"
                    }
            } else {
//              in any situation, & in last 2 players, when this else happens, that means the current player still has cards to sort  
//              in other words, the game can only end when the personInTurn succesfully take the last cards from one other oponent 
                     
//                  updateFailHand( this)
                    this.indexTrack++
                    this.personInTurn.sort()
                    document.getElementById('Highlight').innerHTML += "No, " + targetPerson.getName() + " does not have the card "  + ask.targetCardNumber + " <br>"
                    if ( this.indexTrack < 52) {
                        let newCard = this.cardDeck.getCard( this.indexTrack )
                        this.personInTurn.addCard(newCard) 
                        this.personInTurn.drawCard()
                        this.personInTurn.showCard()
                        this.cardLeft = this.cardLeft - 4 * this.personInTurn.setScore( newCard.getNumber() )
                    }
                     
                    this.personInTurn = this.personInTurn.next()
                    while ( this.personInTurn.getHand().length === 0 ) {
                                this.personInTurn =  this.personInTurn.next()
                    }
                     
                    if (this.personInTurn === this.mainPlayer) { 
                        this.state = 1
                    }
                    document.getElementById('Highlight').innerHTML += "Now is " + this.personInTurn.getName() + " turn " + " <br>"
            }
        } 
        document.getElementById('stat').innerHTML = ""
        document.getElementById('stat').innerHTML += this.mainPlayer.getName() + " cards left : " + this.mainPlayer.getHand().length + " <br>" +
                this.playerLeft.getName() + " cards left : " + this.playerLeft.getHand().length + " <br>" +
                this.playerMiddle.getName() + " cards left : " + this.playerMiddle.getHand().length + " <br>" +
                this.playerRight.getName() + " cards left : " + this.playerRight.getHand().length + " <br>"
    }
     
    getPlayer() {
        let theArray = []
        theArray.push(this.mainPlayer)
        theArray.push(this.playerLeft)
        theArray.push(this.playerMiddle)
        theArray.push(this.playerRight)
         
        return theArray
    }
     
    getDeck() { return this.cardDeck}
     
    setState(i) { this.state = i }
    getState() { return this.state }
    getIndexTrack() {  
        if (this.indexTrack >= 52) { return -1 }
        return this.indexTrack 
    }
	
	getActualIndexTrack() {
		return this.this.indexTrack
	}
 
    getCardLeft() {
        return this.cardLeft
    }
}