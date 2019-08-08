'use strict';
/*jshint esversion: 6 */
/*jslint node: true */
 
//this is same as main 
//import can only be used in type module & a http connection is required 
 
let turn = 0;
 
class Player {
    constructor(id) {
        this.hand = []
        this.id = parseInt(id)
        this.score = 0;
        this.nextPlayer = null;
    }
     
    addCard(card) {
        this.hand.push(card)
    }
     
    getHand() {
        return this.hand
    }
     
    setHand( newHand ) {
        this.hand = newHand
    }
     
    removeCard(card) {
        let removed = this.hand.splice(this.hand.indexOf(card), 1 )
    }
     
    sort() {
        this.hand.sort( function(card1, card2) {
            if (card1.getNumberIndex() < card2.getNumberIndex() ) { 
                return -1;
            }
            else if (card1.getNumberIndex() > card2.getNumberIndex() ) { 
                return 1;
            }
            return 0;
        })
    }
     
    ask() {
        let targetPerson;
        let temp = this.id
        while (temp == this.id) {
            temp = Math.floor(Math.random()*4) + 1
        }
         
        let targetCardNumber = this.hand[ Math.floor(Math.random()*this.hand.length) ].getNumber()
        return { targetCardNumber  : targetCardNumber , personIndex : temp , personName : this.getName() , id : this.id }
    }
     
    reply(targetCardNumber) {
        let taken = false
        let targetCount = 0;
        let lastTargetIndex = -1;
         
        for (let i=0 ; i < this.hand.length; i++ ) {
                if (this.hand[i].getNumber() == targetCardNumber ) { 
                    taken = true;
                    targetCount += 1; 
                    lastTargetIndex = i
                }
        }
        return { taken : taken , targetCount : targetCount , lastTargetIndex : lastTargetIndex , personName : this.getName() }
    }
     
    setNext(player) {
        this.nextPlayer = player    
    }
     
    next() {
        return this.nextPlayer
    }
     
    setScore(targetCardNumber) {
//      even though this code looks similar to some lines in game, it is hard to put these codes in one function 
        this.sort()
        let targetCount = 0
        let lastTargetIndex = -1
         
        for (let i=0 ; i < this.hand.length; i++) {
            if ( this.hand[i].getNumber() === targetCardNumber ) {
                targetCount += 1;
                lastTargetIndex = i
            }
        }
        if (targetCount === 4 ) {
            this.score++;
            let takenCards = this.hand.splice( lastTargetIndex - targetCount + 1, targetCount)
            console.log(this.getName() + ' ' + this.score)
            document.getElementById('Highlight').innerHTML += "" + this.getName() + "find all " + takenCards[0].getNumber() + "<br>" + this.getName() + " now has "+ this.score + " <br>"
             
            if (this.id === 1 ) { this.mainPlayer.showCard() }
			document.getElementById('wow').play();
            return 1;
        }
        return 0;
    }
     
    lucky() {
//      assume that this.hand is already sorted 
        this.sort()
        let compareTarget = this.hand[0]
        let count = 0;
        let lastTargetIndex = -1;
        for (let i=0 ; i < this.hand.length; i++) {
            if (compareTarget.getNumber() === this.hand[i].getNumber() ) {
                count++
            }
            else {
                count = 0
                compareTarget = this.hand[i]
            }
            if ( count === 4) {
                lastTargetIndex = i
            }
        }
        if (lastTargetIndex !== -1) {
            this.score++
            targetCards = this.hand.splice(i - 3 , 4)
            document.getElementById('Highlight').innerHTML += "<br>"
            document.getElementById('Highlight').innerHTML += "" + this.getName() + "find all " + targetCards[0].getNumber() + "<br>" + this.getName() + " now has "+ this.score + " <br>"
             
            if (this.id === 1 ) { this.mainPlayer.showCard() }
            document.getElementById('wow').play();
			return true
        }
        return false
    }
     
    getScore() {
        return this.score
    }
     
    getName() {
        if (this.id === 1 ) { return 'you'}
        else if ( this.id === 2) { return document.getElementById('player1').innerHTML }
        else if ( this.id === 3) { return document.getElementById('player2').innerHTML }
        else { return document.getElementById('player3').innerHTML }
    }
     
    getId() {
        return this.id
    }
     
    giveCard() {
         
    }
     
    drawCard() {
        let a = document.createElement('img')
        a.setAttribute('src', 'cardFace/back.png')
        a.setAttribute('alt', '')
        a.style = "width:100px ;  height: 140px;  position: absolute;"
         
        if (this.id === 1) {
            a.setAttribute('class', 'main')
            a.style.animation = "moveToMain 0.5s 1"    
            setTimeout( () => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 540px;  left: 0px; "
                            let temp = 350 + 50 * ( this.hand.length - 1 )
                            a.style.left = "" + temp + "px"
                          } , 500 ) 
         
        } else if (this.id === 2) {
            a.style = "width:100px ;  height: 140px;  position: absolute; transform: rotate(90deg); "
            a.setAttribute('class', 'left')
            a.style.animation = "moveToLeft 0.5s 1 "       
            setTimeout( () => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 20px;  left: 0px; transform: rotate(90deg); "
                                let temp = 20 + 35 * ( this.hand.length - 1 )
                            a.style.top = "" + temp + "px"
                          } , 500 ) 
         
        } else if (this.id === 3) {
            a.setAttribute('class', 'middle')
            a.style.animation = "moveToMiddle 0.5s 1"      
            setTimeout( () => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 60px;  left: 350px; "
                            let temp = 350 + 35 * ( this.hand.length - 1 )
                            a.style.left = "" + temp + "px"
                          } , 500 )                         
         
        } else {
            a.setAttribute('class', 'right')
            a.style = "width:100px ;  height: 140px;  position: absolute; transform: rotate(90deg); "
            a.style.animation = "moveToRight 0.5s 1 "      
            setTimeout( () => { a.style = "width:100px ;  height: 140px;  position: absolute;  top: 20px;  left: 1250px; transform: rotate(90deg); "
                                let temp = 50 + 35 * ( this.hand.length - 1 )
                            a.style.top = "" + temp + "px"
                          } , 500 )     
        }
         
        try {
            document.getElementById('imgContainer').appendChild(a)
        }
        catch(err) {
     
        }
    }
     
    showCard() {
        if ( this.id === 1) {
//          let elements = document.getElementsByClassName('main')
//          let originalElementLength = elements.length
//          console.log(originalElementLength)
//          
//          if (elements.length < this.hand.length) {
//              for (let i=0 ; i < this.hand.length - elements.length; i++ ) {
//                  let a = document.createElement('img')
//                  a.setAttribute('class', 'main')
//                  a.setAttribute('src', 'cardFace/back.png')
//                  a.setAttribute('alt', '')
//                  a.style = "width:100px ;  height: 140px;  position: absolute; top: 540px; left: 0px" 
//                  let temp = 350 + 50 * ( i + originalElementLength ) 
//                  a.style.left = "" + temp + "px"
//                  document.getElementById('imgContainer').appendChild(a)
//              }
//          }
//          elements = document.getElementsByClassName('main')
//  
//          for (let i=0; i< this.hand.length; i++) {
//              let cardURL = 'cardFace/' + this.hand[i].getImgName() + '.png'
//              let b = elements[i].src = cardURL
//          }
             
                try {
                    for ( let element of document.getElementsByClassName('main') ) {
                    element.remove()
                    }
                } catch (err) {
         
                }
 
                for (let i=0; i< this.hand.length; i++) {
         
                    let cardURL = 'cardFace/' + this.hand[i].getImgName() + '.png'
                    let a = document.createElement('img')
                    a.setAttribute('class', 'main')
                    a.setAttribute('src', cardURL)
                    a.setAttribute('alt', '')
                    a.style = "width:100px ;  height: 140px;  position: absolute; top: 540px; left: 0px"
                    let temp = 350 + 50*i
                    a.style.left = "" + temp + "px"
                    document.getElementById('imgContainer').appendChild(a)
             
                }
        } else {
            let label
            if (this.id === 2 ) { label = 'left'}
            else if (this.id === 3 ) { label = 'middle'}
            else if (this.id === 4 ) { label = 'right'} 
             
            try {
                    for ( let element of document.getElementsByClassName(label) ) {
                        element.remove()
                    }
            } catch (err) {
         
            }
 
                for (let i=0; i< this.hand.length; i++) {
                    let a = document.createElement('img')
                    a.setAttribute('class', label)
                    a.setAttribute('src', 'cardFace/back.png')
                    a.setAttribute('alt', '')
                     
                    if (this.id === 2) {
                        a.style = "width:100px ;  height: 140px;  position: absolute;  top: 20px;  left: 0px; transform: rotate(90deg); "
                        let temp = 20 + 35 * i
                        a.style.top = "" + temp + "px"       
                     
                    } else if (this.id === 3) {
                         a.style = "width:100px ;  height: 140px;  position: absolute;  top: 60px;  left: 350px; "
                         let temp = 350 + 35 * i
                         a.style.left = "" + temp + "px"
                         
                    } else if (this.id === 4) {
                        a.style = "width:100px ;  height: 140px;  position: absolute;  top: 20px;  left: 1250px; transform: rotate(90deg); "
                        let temp = 50 + 35 * i
                        a.style.top = "" + temp + "px"
                    }
                     
                     
                    document.getElementById('imgContainer').appendChild(a)
             
                }
             
//          let label
//          if (this.id === 2 ) { label = 'left'}
//          else if (this.id === 3 ) { label = 'middle'}
//          else if (this.id === 4 ) { label = 'right'} 
//          try {
//                  let element of document.getElementsByClassName(label) 
//                  
//              } catch (err) {
//      
//              }
        }
    }
     
    takeCard() {
         
    }
}