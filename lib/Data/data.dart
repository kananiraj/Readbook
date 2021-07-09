class slidermodel {
  String imagepath, title, desc;

  slidermodel({required this.imagepath, required this.title, required this.desc});

  void setimagepath(String getimagepath) {
    imagepath = getimagepath;
  }

  void settitle(String settitle) {
    title = settitle;
  }

  void setdescription(String setdesc) {
    desc = setdesc;
  }

  String getimagepath() {
    return imagepath;
  }

  String gettitle() {
    return title;
  }

  String getdesc() {
    return desc;
  }
}

List<slidermodel> getlist() {
  List<slidermodel> slides = <slidermodel>[];
  slidermodel slidermdl = new slidermodel(desc: '', imagepath: '', title: '');

  slidermdl.setimagepath("images/book12.png");
  slidermdl.settitle("Learn IT!");
  slidermdl.setdescription("We read to know we're not alone.");
  slides.add(slidermdl);

  slidermdl = new slidermodel(desc: '', imagepath: '', title: '');

  slidermdl.setimagepath("images/book13.png");
  slidermdl.settitle("Grab IT!");
  slidermdl.setdescription("Books are a uniquely portable magic.");
  slides.add(slidermdl);

  slidermdl = new slidermodel(desc: '', imagepath: '', title: '');

  slidermdl.setimagepath("images/Ebook11 (1).png");
  slidermdl.settitle("Enjoy IT!");
  slidermdl.setdescription("Think before you speak. Read before you think.");
  slides.add(slidermdl);

  return slides;
}
