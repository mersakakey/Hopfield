int num = 2; //記憶させるパターンの種類
node[] nodes = new node[63];//ノード

int[] kicks = {};//動作停止させるノードの番号（課題II用）
//登録しなければ通常通り動作する

class node {//ノードのクラス
  int x = 0;//値(0or1)
  int[] w = new int [63];//このノードと各他ノードとの結合の強さ

  //-----------------------
  //コンストラクタ
  node(int x) {
    this.x=x;
    for (int i=0; i<63; i++) {
      w[i]=0;
    }
  }
  //ここまで---------------
}



/*1に近似
 int[] input={//入力するパターン
 0,0,0,0,0,0,0,
 0,0,0,1,0,0,0,
 0,1,0,1,0,0,0,
 0,0,1,1,0,1,0,
 0,0,0,0,1,0,0,
 0,0,0,1,0,0,0,
 0,0,0,1,0,0,1,
 0,0,1,1,1,0,0,
 0,1,0,0,0,0,0
 };
 */

///*
//free
int[] input={//入力するパターン
  0, 0, 0, 0, 1, 0, 0, 
  0, 1, 1, 0, 1, 1, 0, 
  0, 0, 1, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 0, 0, 1, 0, 1, 1, 
  0, 0, 1, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 0, 1, 0, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};
//*/

/*
//ランダム入力用
 int[] input=new int[63];
 */

void setup() {

  size(400, 500);//画面サイズ
  frameRate(60); //フレームレート変更(デフォルトで60)

  /*
for(int l=0;l<63;l++){//inputランダマイズ用
   input[l]=int(random(0,2));
   }
   */


  int[][] mems ={one, eight}; //記憶させるパターン(num個)


  for (int i=0; i<63; i++) { //ノードのインスタンスを生成

    nodes[i]=new node(input[i]); //ノードのインスタンス生成

    for (int j=0; j<63; j++) { //w(i番目のノードのj番目のノードとの結合の強さ)を計算
      for (int n=0; n<num; n++) {//ここでエラーが出るときはnumを変えていない可能性があります！
        nodes[i].w[j] += (2*mems[n][i]-1)*(2*mems[n][j]-1);
      }
      if (kicks_include_check(i) || kicks_include_check(j))//iかjがkicksに含まれているなら
        nodes[i].w[j] = 0;//ノードの結合を0に(課題II用)
    }

    nodes[i].w[i] = 0;//w(i,i)を0に
  }
}

void draw() {
  background(255);//背景を白に

  int in = int(random(0, 62.999));//ランダムなノードを選択

  int Jsum=0;//変化判定変数
  for (int k=0; k<63; k++) {
    Jsum += nodes[in].w[k]*nodes[k].x;//変数を計算
  }

  if (Jsum > 0) {//変化の判定
    nodes[in].x = 1;
  } else if (Jsum < 0) {
    nodes[in].x = 0;
  } else {
  }



  //------------
  //ここから描画
  for (int i=0; i<9; i++) {//横に7つノードを並べるのを9回繰り返す
    for (int j=0; j<7; j++) {
      if (nodes[i*7+j].x==1)fill(255, 0, 0);//ノードのxが1であれば赤く描画
      ellipse(50+j*50, 50+i*50, 40, 40);
      fill(255);
    }
  }
  //------------


  //if(frameCount==60)noLoop();//初期パターンだけまたはnフレーム時点での状態を描画する用
}


//----------------------------
//入力パターン
int[] zero={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] one={
  0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 1, 1, 0, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] two={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] three={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] four={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 0, 1, 0, 0, 0, 
  0, 1, 1, 1, 1, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0
};


int[] five={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] six={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] seven={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 1, 0, 0, 
  0, 0, 0, 1, 0, 0, 0, 
  0, 0, 1, 0, 0, 0, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 1, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] eight={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

int[] nine={
  0, 0, 0, 0, 0, 0, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 0, 0, 0, 1, 0, 
  0, 1, 1, 1, 1, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 0, 1, 0, 
  0, 0, 0, 0, 0, 0, 0
};

//---------------------------

boolean kicks_include_check(int i) { //kicksにiが含まれているかどうかの判定
  for (int j=0; j<kicks.length; j++) {
    if (kicks[j]==i)return true;
  }
  return false;
}
