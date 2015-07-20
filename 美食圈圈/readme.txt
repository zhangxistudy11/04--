


1、增加设置显示文字、状态和颜色的接口


2、一个奇怪的问题:

//View1
[self addSubview:view2];

//super


//在view2里面的函数，，，superView一定是View1吗
-(void)willMoveToSuperView:(UIView)superView
{

}
