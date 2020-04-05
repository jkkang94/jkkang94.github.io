# "IntraOcular Lens Power Calculation-preview"

date: 2020-04-05 
categories: cataract

백내장 관련한 연구를 하고 있다. 백내장이 진행되면 인공 수정체 삽입술을 많이 사용한다.
인공수정체는 렌즈는 0.5D(Diopter : 빛의 굴절 단위) 단위로 구분되어 생산된다.

어쨋든 정확한 도수를 계산해서 환자에게 알맞은 렌즈를 삽입해야하는데
계산하는 공식이 이미 많이 나와있다. 


내가 하려고 하는것은 그 도수 계산을 머신러닝 regression을 통해 도수를 예측하는 모델을 만드는 것이다.
이미 몇 가지 논문이 나와있기는 하지만 정말 몇개 없다.



**********************************************************************************************************

[Using a multilayer perceptron in intraocular lens power calculation](https://www.sciencedirect.com/science/article/abs/pii/S0886335019305656)

[Improving clinical refractive results of cataract surgery by machine learning](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6611496/pdf/peerj-07-7202.pdf)

[Intraocular Lens Power Formula Selection Using Support Vector Machines](https://www.semanticscholar.org/paper/Intraocular-Lens-Power-Formula-Selection-Using-Yarmahmoodi-Arabalibeik/054a85ca78379bf2bf52011e33d12d6b565fcd37)

[Formula Selection For Intraocular Power Calculation Using Support Vector Machines and Self-organizing Maps](https://ieeexplore.ieee.org/document/6083823)

**********************************************************************************************************


일단은 이렇게 네 가지의 논문을 참고해서 실험 계획을 세웠다.
하지만 기존 공식의 정확도가 높게 나오지 않는다는 점이 문제이다.

포기하기는 조금 아까우니까 위의 논문도 리뷰하면서 백내장 도메인에 대해서도 좀 다루면서 실험을 설계하고 진행해야겠다는 생각이 들었다.

그나저나 깃허브 블로그 만들기 굉장히 어렵다
