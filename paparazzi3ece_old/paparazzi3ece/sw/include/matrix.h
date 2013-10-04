
#define sum3x3and3x3(A,B,res) {\
	res[0]=A[0]+B[0]; \
	res[1]=A[1]+B[1]; \
	res[2]=A[2]+B[2]; \
	res[3]=A[3]+B[3]; \
	res[4]=A[4]+B[4]; \
	res[5]=A[5]+B[5]; \
	res[6]=A[6]+B[6]; \
	res[7]=A[7]+B[7]; \
	res[8]=A[8]+B[8]; \
}

#define sum2x2and2x2(A,B,res) {\
	res[0]=A[0]+B[0]; \
	res[1]=A[1]+B[1]; \
	res[2]=A[2]+B[2]; \
	res[3]=A[3]+B[3]; \
}

#define sum3x1and3x1(A,B,res) {\
	res[0]=A[0]+B[0]; \
	res[1]=A[1]+B[1]; \
	res[2]=A[2]+B[2]; \
}
#define sum2x1and2x1(A,B,res) {\
	res[0]=A[0]+B[0]; \
	res[1]=A[1]+B[1]; \
}



#define mult3x3by3x3(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[3]+A[2]*B[6]; \
	res[1]=A[0]*B[1]+A[1]*B[4]+A[2]*B[7]; \
	res[2]=A[0]*B[2]+A[1]*B[5]+A[2]*B[8]; \
	res[3]=A[3]*B[0]+A[4]*B[3]+A[5]*B[6]; \
	res[4]=A[3]*B[1]+A[4]*B[4]+A[5]*B[7]; \
	res[5]=A[3]*B[2]+A[4]*B[5]+A[5]*B[8]; \
	res[6]=A[6]*B[0]+A[7]*B[3]+A[8]*B[6]; \
	res[7]=A[6]*B[1]+A[7]*B[4]+A[8]*B[7]; \
	res[8]=A[6]*B[2]+A[7]*B[5]+A[8]*B[8]; \
}

#define mult3x3by3x2(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[3]+A[2]*B[6]; \
	res[1]=A[0]*B[1]+A[1]*B[4]+A[2]*B[7]; \
	res[2]=A[3]*B[0]+A[4]*B[3]+A[5]*B[6]; \
	res[3]=A[3]*B[1]+A[4]*B[4]+A[5]*B[7]; \
	res[4]=A[6]*B[0]+A[7]*B[3]+A[8]*B[6]; \
	res[5]=A[6]*B[1]+A[7]*B[4]+A[8]*B[7]; \
}

#define mult2x3by3x2(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[2]+A[2]*B[4]; \
	res[1]=A[0]*B[1]+A[1]*B[3]+A[2]*B[5]; \
	res[2]=A[3]*B[0]+A[4]*B[2]+A[5]*B[4]; \
	res[3]=A[3]*B[1]+A[4]*B[3]+A[5]*B[5]; \
}

#define mult3x2by2x3(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[3]; \
	res[1]=A[0]*B[1]+A[1]*B[4]; \
	res[2]=A[0]*B[2]+A[1]*B[5]; \
	res[3]=A[2]*B[0]+A[3]*B[3]; \
	res[4]=A[2]*B[1]+A[3]*B[4]; \
	res[5]=A[2]*B[2]+A[3]*B[5]; \
	res[6]=A[4]*B[0]+A[5]*B[3]; \
	res[7]=A[4]*B[1]+A[5]*B[4]; \
	res[8]=A[4]*B[2]+A[5]*B[5]; \
}

#define mult3x2by2x2(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[2]; \
	res[1]=A[0]*B[1]+A[1]*B[3]; \
	res[2]=A[2]*B[0]+A[3]*B[2]; \
	res[3]=A[2]*B[1]+A[3]*B[3]; \
	res[4]=A[4]*B[0]+A[5]*B[2]; \
	res[5]=A[4]*B[1]+A[5]*B[3]; \
}

#define mult2x3by3x3(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[3]+A[2]*B[6]; \
	res[1]=A[0]*B[1]+A[1]*B[4]+A[2]*B[7]; \
	res[2]=A[0]*B[2]+A[1]*B[5]+A[2]*B[8]; \
	res[3]=A[3]*B[0]+A[4]*B[3]+A[5]*B[6]; \
	res[4]=A[3]*B[1]+A[4]*B[4]+A[5]*B[7]; \
	res[5]=A[3]*B[2]+A[4]*B[5]+A[5]*B[8]; \
}


#define mult3x3by3x1(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[1]+A[2]*B[2]; \
	res[1]=A[3]*B[1]+A[4]*B[1]+A[5]*B[2]; \
	res[2]=A[6]*B[0]+A[7]*B[1]+A[8]*B[2]; \
}

#define mult3x3by3x1(A,B,res) {\
	res[0]=A[0]*B[0]+A[1]*B[1]+A[2]*B[2]; \
	res[1]=A[3]*B[1]+A[4]*B[1]+A[5]*B[2]; \
	res[2]=A[6]*B[0]+A[7]*B[1]+A[8]*B[2]; \
}

#define mult2x3by3x1(A,B,res) { \
	res[0]=A[0]*B[0]+A[1]*B[1]+A[2]*B[2]; \
	res[1]=A[3]*B[0]+A[4]*B[1]+A[5]*B[2]; \
}

#define mult3x2by2x1(A,B,res) { \
	res[0]=A[0]*B[0]+A[1]*B[1]; \
	res[1]=A[2]*B[1]+A[3]*B[1]; \
	res[2]=A[4]*B[0]+A[5]*B[1]; \
}

#define diag3x3(a,b,c,res) { \
	res[1]=0; res[2]=0; res[3]=0; res[5]=0; res[6]=0; res[7]=0; \
	res[0]=a; \
	res[4]=b; \
	res[8]=c; \
}

#define diag2x2(a,b,res) {\
	res[0]=a; \
	res[1]=0; \
	res[2]=0; \
	res[3]=b; \
}

#define multconstby3x3(c,res) {\
	res[0]*=c; \
	res[1]*=c; \
	res[2]*=c; \
	res[3]*=c; \
	res[4]*=c; \
	res[5]*=c; \
	res[6]*=c; \
	res[7]*=c; \
	res[8]*=c; \
}

#define multconstby2x1(c,res) {\
	res[0]*=c; \
	res[1]*=c; \
}

#define inv2x2(A,res,det) {\
	det=A[0]*A[3]-A[1]*A[2]; \
	res[0]=A[3]/det; \
	res[1]=-A[1]/det; \
	res[2]=-A[2]/det; \
	res[3]=A[0]/det; \
}

#define ones3x3(res) {\
	res[0]=1; \
	res[1]=1; \
	res[2]=1; \
	res[3]=1; \
	res[4]=1; \
	res[5]=1; \
	res[6]=1; \
	res[7]=1; \
	res[8]=1; \
}

#define transpose3x3(A,res) {\
	res[0]=A[0]; \
	res[1]=A[3]; \
	res[2]=A[6]; \
	res[3]=A[1]; \
	res[4]=A[4]; \
	res[5]=A[7]; \
	res[6]=A[2]; \
	res[7]=A[5]; \
	res[8]=A[8]; \
}

#define transpose2x3(A,res) {\
	res[0]=A[0]; \
	res[1]=A[3]; \
	res[2]=A[1]; \
	res[3]=A[4]; \
	res[4]=A[2]; \
	res[5]=A[5]; \
}

#define printf9(A,s) {\
	printf("%s={%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f}\n",s,A[0],A[1],A[2],A[3],A[4],A[5],A[6],A[7],A[8]); \
}

#define printf6(A,s) {\
	printf("%s={%f\t%f\t%f\t%f\t%f\t%f}\n",s,A[0],A[1],A[2],A[3],A[4],A[5]); \
}

#define printf3(A,s) {\
	printf("%s={%f\t%f\t%f}\n",s,A[0],A[1],A[2]); \
}

#define printf2(A,s) {\
	printf("%s={%f\t%f}\n",s,A[0],A[1]); \
}
