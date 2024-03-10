///Created by jdz on 2024/3/2 0002 23:12
///@brief 图表绘制额外信息
class BaseDrawInfo{
  double w;
  double h;
  double xMax;
  double xMin;
  double yMax;
  double yMin;

  BaseDrawInfo(
      {required this.w,
      required this.h,
      required this.xMax,
      required this.xMin,
      required this.yMax,
      required this.yMin});
}
