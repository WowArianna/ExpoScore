javascript:(function(){
    let calculateS1Score = function (score) {
        score = 4.379*(Math.pow(10,-7))*(Math.pow(score,3))-0.001542*(Math.pow(score,2))+2.4*score-859.2;
		score = Math.round(score);
        return score > 0 ? score : 0;
    };
    
    let calculateExpoScore = function (score) {
        score = 3.18*(Math.pow(10,-7))*(Math.pow(score,3))-0.0006889*(Math.pow(score,2))+0.9659*score+447.4;
		score = Math.round(score);
        return score > 0 ? score : 0;
    };
    
    let parseScoreFormHtml =  function (element) {
        if(element.hasAttribute('data-isexpo')){
            return null;
        }

        let scoreString = element.innerText;
        let score = parseInt(scoreString.replace(',',''));
        if(isNaN(score)){
            return null;
        }

        return score;
    };
    
    let selectorScore = [
        '.rio-rankings-table a.rio-realm-link[title="Mythic+ Score"]',
        '.rio-rankings-table a.rio-realm-link b',
        '.rio-badge.rio-badge-color--light[style]',
        'th span span[style]',
        '.rt-table .rio-realm-link[style^="color"]'
    ];

    let selectorsScoreKey = [
        'td[data-label="Rating"]'
    ];

    selectorScore.forEach(function(selector){
        document.querySelectorAll(selector).forEach(function(element){
            let score = parseScoreFormHtml(element);
            
            if( null === score) {
                return;
            }
			
            let s1Score = calculateS1Score(score);
            let expoScore = calculateExpoScore(score);
            element.setAttribute('data-isexpo',true);
            element.innerText = s1Score + ' | ' + expoScore;
        });
    });
    
    selectorsScoreKey.forEach(function(selector){
        document.querySelectorAll(selector).forEach(function(element){
            let score = parseScoreFormHtml(element);
            
            if( null === score) {
                return;
            }
            
            let s1Score = Math.round(calculateS1Score(score * 8) / 8);
            let expoScore = Math.round(calculateExpoScore(score * 8) / 8);
            element.setAttribute('data-isexpo',true);
            element.innerText = s1Score + ' | ' + expoScore;
        });
    });
})();
