function mydirectrad=mydirectrad(i0,ih,sinh)
      %����̫��������̫���ܷ��䣬̫���߶Ƚ�����ֵ
      %�������ֱ�����
        kt=ih/(i0*sinh);
        A1=-0.1556*(sinh^2)+0.1028*sinh+1.3748;
        A2=0.7973*(sinh^2)+0.1509*sinh+3.035;
        A3=5.4307*sinh+7.2182;
        A4=2.990;
        kn=A1*(A2^((0-A3)*(A2^((0-A4)*kt))));
        mydirectrad=kn*i0;
end