import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr/Components/Themes.dart';
import 'package:qr/Components/TopBar.dart';
import 'package:qr/Screens/ContentView.dart';
import 'package:qr/Utils/Permissions.dart';
import 'package:url_launcher/url_launcher.dart';

class Denetim extends StatefulWidget {
  const Denetim({super.key});

  @override
  State<Denetim> createState() => _DenetimState();
}

class _DenetimState extends State<Denetim> {

  @override
  void initState() {
    super.initState();
    run();
  }

  String version = "";

  bool loading = true;

  run() async
  {
    setState(() {
      loading = true;
    });
    var status = await PackageInfo.fromPlatform();
    setState(() {
      version = status.version;
    });
    Permissions.notification = await Permissions.onlyControl(Permission.notification);
    Permissions.camera = await Permissions.onlyControl(Permission.camera);
    Permissions.location = await Permissions.onlyControl(Permission.location);
    setState(() {
      Permissions.camera;
      Permissions.notification;
      Permissions.location;
      loading = false;
    });
  }

  InkWell con(String text1, String text2, dynamic trailing, {VoidCallback? l}) {
    return InkWell(
      onTap: ()
      {
        if(l!=null)
        {
          l();
        }
      },
      child: Container(
        width: double.infinity,
        height: 100,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: Themes.decor,
        child: ListTile(
            title: Text(
              text1,
              style: TextStyle(color: Themes.text, fontSize: 12),
            ),
            subtitle: Text(
              text2,
              style: TextStyle(
                  color: Themes.text, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            trailing: trailing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.back,
      appBar: TopBar("Denetim Merkezi"),
      body: loading
        ? Center(child: CircularProgressIndicator(),)
          : ListView(
        children: [
          con(
            "Kamera erişimine izin veriyorum",
            "Kamera",
            Switch(
              hoverColor: Themes.mainColor,
              value: Permissions.camera,
              onChanged: (v) async
              {
                if(!await Permissions.onlyControl(Permission.camera))
                {
                Permissions.cameraRequest();
                }
                else
                {
                Permissions.camera = !Permissions.camera;
                }
                setState(() {
                });
              },
            ),
          ),
          con(
            "Bildirim göndermesine izin veriyorum",
            "Bildirim",
            Switch(
              hoverColor: Themes.mainColor,
              value: Permissions.notification,
              onChanged: (v) async
              {
                if(!await Permissions.onlyControl(Permission.notification))
                {
                Permissions.notificationRequest();
                }
                else
                {
                Permissions.notification = !Permissions.notification;
                }
                setState(() {
                });
              },
            ),
          ),
          con(
            "Arkaplanda yenilenmesine izin veriyorum",
            "Arkaplan",
            Switch(
              hoverColor: Themes.mainColor,
              value: Permissions.location,
              onChanged: (v) async
              {
                if(!await Permissions.onlyControl(Permission.location))
                {
                  Permissions.locationRequest();
                }
                else
                {
                  Permissions.location = !Permissions.location;
                }
                setState(() {
                });
              },
            ),
          ),
          con("Mevzuat Bilgilendirmesi", "Gizlilik Politikası", null,
              l: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContentView(
                    "Gizlilik Politikası",
                    """
                    İşbu Gizlilik Politikası, QR PDKS ile Kullanıcı Sözleşmesi'ni akdetmiş olan tarafların ("Şirket"), QR PDKS tarafından sunulmakta olan Personel Devam Kontrol Sistemini ("Platform") kullanımları sırasında paylaştıkları bilgi ve belgelerin kullanılmasına ilişkin hükümleri düzenlemektedir.
Üyelik aşamasında ve Platform'un kullanımı sırasında Şirket, Şirket yetkilileri veya çalışanlar tarafından sağlanan bilgilerin korunması ve bunların gizliliğinin sağlanması QR PDKS olarak birinci önceliğimizdir. Bu nedenle Şirket tarafından sağlanan ve Platform'da paylaşılan bilgiler, Kullanıcı Sözleşmesi'nde belirtilen kurallar ve amaçlar dışında herhangi bir kapsamda kullanılmayacak, üçüncü şahıslarla paylaşılmayacaktır.
QR PDKS, 6698 sayılı Kişisel Verilerin Korunması Kanunu kapsamında "veri işleyen" sıfatıyla Platform'da paylaşılan kişisel veriler ile ilgili mevzuata uygun şekilde işlemektedir. QR PDKS ilgili mevzuatta belirlenen kapsamda,
    kişisel verilerin hukuka aykırı olarak işlenmemesini,
    kişisel verilere hukuka aykırı olarak erişilmemesini ve
    kişisel verilerin muhafazasını sağlamak amacıyla uygun güvenlik düzeyini temin etmeye yönelik gerekli teknik ve idari tedbirleri almakta, gerekli denetimleri yaptırmaktadır.
    QR PDKS, Şirket, çalışanlar ve sair üçüncü kişiler hakkında elde ettiği kişisel verileri bu işbu Gizlilik Politikası ve 6698 sayılı Kişisel Verilerin Korunması Kanunu hükümlerine aykırı olarak başkasına açıklayamaz ve işleme amacı dışında kullanamaz.
QR PDKS sistemle ilgili sorunların tespiti ve söz konusu sorunların en hızlı şekilde giderilebilmesi için, gerektiğinde kullanıcıların IP adresini tespit etmekte ve bunu kullanmaktadır. IP adresleri, kullanıcıları genel bir şekilde tanımlamak ve kapsamlı demografik bilgi toplamak amacıyla da kullanılabilir.
QR PDKS, işbu Gizlilik Politikası'nı Platform üzerinden ya da e-posta vasıtasıyla bildirerek dilediği zaman değiştirebilir. QR PDKS'nın değişiklik yaptığı Gizlilik Politikası hükümleri bildirim tarihinde yürürlük kazanır.
Bu Gizlilik Politikası'nda düzenlenen hususlara ilişkin sorularınızı merhaba adresine e-posta göndererek QR PDKS'ya iletebilirsiniz.
                    """
                )));
              }
          ),
          con("Mevzuat Bilgilendirmesi", "Şartlar ve Koşullar", null,
              l: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContentView(
                    "KVKK Metni",
                    """
                    İşbu Kişisel Verilerin Korunması ve İşlenmesi Politikası'nın ("Politika") amacı, QR PDKS'ye ("QR PDKS") ait www.qrpdks..com internet sitesi ("Site") üzerinden sağlanan Personel Devam Kontrol Sistemi'nden ("Platform") faydalanacak olan, Personel Devam Kontrol Sistemi Kullanıcı Sözleşmesi'ni onaylayan Şirket'in çalışanlarından ("Çalışanlar") elde edilen kişisel verilerin kullanımına ilişkin koşul ve şartları tespit etmektir.

Hangi Veriler İşlenmektedir?

    Bu başlık altında, Çalışan tarafından QR PDKS'ya sağlanan ve/veya Platform'un kullanımı aşamasında Çalışanlar'dan elde edilen ve 6698 sayılı Kişisel Verilerin Korunması Kanunu (6698 sayılı Kanun) uyarınca kişisel veri sayılan verilerin hangileri olduğu sıralanmıştır. Aksi açıkça belirtilmedikçe, Politika kapsamında arz edilen hüküm ve koşullar kapsamında "kişisel veri" ifadesi aşağıda yer alan bilgileri ifade edecektir.

    QR PDKS, Çalışan tarafından hesap oluşturulması esnasında dijital ortamda sağlanan aşağıdaki verileri toplamaktadır.

    Ad, soyad vb. kimlik bilgileri, adres, iş veya özel e-posta adresi, telefon numarası vb. iletişim bilgileri kimlik doğrulama ve hesap erişimi için kullanılan parola ve benzer güvenlik ve işlem bilgileri QR PDKS, Çalışanlar'ın Site ve Platform'u kullanımı hakkındaki bilgileri teknik bir iletişim dosyası olan çerezleri (Cookie) kullanarak elde edebilmekte olup Platform üzerinde sunulmakta olan hizmetlere erişim ve kullanım alışkanlıklarının tespit edilmesi için çerez yoluyla IP bilgileri toplanmaktadır.

    Kanun'un 3 ve 7. maddesi doğrultusunda, geri döndürülemeyecek şekilde anonim hale getirilen veriler, anılan kanun hükümleri uyarınca kişisel veri olarak kabul edilmeyecek olup bu verilere ilişkin işleme faaliyetleri işbu Politika'nın hükümleri ile bağlı olmaksızın gerçekleştirecektir.

Veriler Hangi Amaçlarla Kullanılmaktadır?

    QR PDKS, Çalışanlar tarafından sağlanan kişisel verileri, Çalışan'ın Platform hesabının açılması ve Platform'a konu ve hizmetlerin sağlanması amacı ile kullanacaktır. QR PDKS ayrıca, bahsi geçen kişisel verileri sunduğu hizmetlerin iyileştirilmesi, hizmetin geliştirilmesi ve bu kapsamda Şirket'e veya Çalışanlar'a gerekli bilgilendirilmelerin yapılması ve sunduğu hizmetlerin doğasından kaynaklanan yükümlülüklerin yerine getirilmesi için işleyebilir.

    Söz konusu kişisel bilgiler Şirket veya Çalışan ile temas kurmak veya Şirket'in ve Çalışanlar'ın Platform'daki tecrübesini iyileştirmek (mevcut hizmetlerin geliştirilmesi, yeni hizmetler oluşturulması ve kişiye özel hizmetler sunulması gibi) amacıyla kullanılabileceği gibi, QR PDKS raporlama ve iş geliştirme faaliyetleri kapsamında kullanılabilecek, Çalışan'ın kimliği ifşa edilmeden çeşitli istatistiksel değerlendirmeler yapma, veri tabanı oluşturma ve pazar araştırmalarında bulunma amacıyla da kullanılabilecektir. Çalışan'ın ayrıca onay vermesi halinde onay kapsamında söz konusu bilgiler QR PDKS ve işbirliğinde olduğu kişiler tarafından doğrudan pazarlama yapmak amacıyla işlenebilecek, saklanabilecek, üçüncü kişilere iletilebilecek ve söz konusu bilgiler üzerinden çeşitli uygulama, ürün ve hizmetlerin tanıtımı, bakım ve destek faaliyetlerine ilişkin bildirimlerde bulunma amacıyla Çalışan ile iletişime geçilebilecektir.

    QR PDKS ayrıca, Kanun'un 5 ve 8. maddeleri uyarınca ve/veya ilgili mevzuattaki şartların varlığı halinde verileri Çalışanlar'ın ayrıca rızasını almaksızın işleyebilecek ve üçüncü kişilerle paylaşabilecektir. Çalışanlar'ın bilgilerinin açık rıza temin edilmeksizin işlenebileceği durumların başlıcaları aşağıda belirtilmiştir:

    Kanunlarda açıkça öngörülmesi,

    Fiili imkânsızlık nedeniyle rızasını açıklayamayacak durumda bulunan veya rızasına hukuki geçerlilik tanınmayan kişinin kendisinin ya da bir başkasının hayatı veya beden bütünlüğünün korunması için zorunlu olması,

    Sözleşmenin kurulması veya ifasıyla doğrudan doğruya ilgili olması kaydıyla, kişisel verilerin işlenmesinin gerekli olması,

    Hukuki yükümlülüklerin yerine getirebilmesi için zorunlu olması,

    Çalışan'ın kendisi tarafından alenileştirilmiş olması,

    Bir hakkın tesisi, kullanılması veya korunması için veri işlemenin zorunlu olması,

    Çalışan'ın temel hak ve özgürlüklerine zarar vermemek kaydıyla, QR PDKS'nın meşru menfaatleri için veri işlenmesinin zorunlu olması.

    Yukarıda da belirtildiği üzere QR PDKS, çerez (Cookie) kullanabilecek ve bu kapsamda veri işleyerek üçüncü kişiler tarafından sunulan analiz hizmetleri kapsamında işlenmesi amacıyla sadece bu analiz hizmetlerinin gerektirdiği ölçüde kullanılması amacıyla üçüncü kişilere iletebilecektir. Bahsi geçen teknik iletişim dosyaları, ana bellekte saklanmak üzere tarayıcıya (browser) gönderilen küçük metin dosyalarıdır. Teknik iletişim dosyası bir web sitesi hakkında durum ve tercih ayarlarını saklayarak internetin kullanımını bu anlamda kolaylaştırır. Teknik iletişim dosyası, internet sitelerini zamansal oranlamalı olarak kaç kişinin kullandığını, bir kişinin herhangi bir internet sitesini hangi amaçla, kaç kez ziyaret ettiği ve ne kadar kaldığı hakkında istatistiksel bilgileri elde etmek ve Çalışan için özel tasarlanmış kullanıcı sayfalarından dinamik olarak reklam ve içerik üretilmesine yardımcı olmak üzere tasarlanmış olup bu amaçlarla kullanılmaktadır. Teknik iletişim dosyası, ana bellekten başkaca herhangi bir kişisel veri almak için tasarlanmamıştır. Tarayıcıların pek çoğu başta teknik iletişim dosyasını kabul eder biçimde tasarlanmıştır, ancak Çalışanlar dilerse teknik iletişim dosyasının gelmemesi veya teknik iletişim dosyasının gönderildiğinde ikaz verilmesini sağlayacak biçimde tarayıcı ayarlarını her zaman için değiştirebilirler. QR PDKS ayrıca, online davranışsal reklamcılık ve pazarlama yapılabilmesi amacıyla Çalışanlar'ın Site ve Platform'daki davranışlarını tarayıcıda bulunan bir cookie (çerez) ile ilişkilendirme ve görüntülenen sayfa sayısı, ziyaret süresi ve hedef tamamlama sayısı gibi metrikleri temel alan yeniden pazarlama listeleri tanımlama hakkını haizdir.

Verilere Kimler Erişebilmektedir?

    QR PDKS, Çalışanlar'a ait kişisel verileri ve bu kişisel verileri kullanılarak elde ettiği yeni verileri, Şirket'e ve Çalışanlar'a karşı taahhüt ettiği edimlerin ifası amacıyla QR PDKS'nın hizmetlerinden faydalandığı üçüncü kişilere, söz konusu hizmetlerin temini amacıyla sınırlı olmak üzere aktarabilmektedir.

    QR PDKS, Çalışan deneyiminin geliştirilmesi (iyileştirme ve kişiselleştirme dâhil), Şirket'in ve Çalışan'ın güvenliğini sağlamak, hileli ya da izinsiz kullanımları tespit etmek, operasyonel değerlendirme araştırılması, Site'ye, Platform'a veya QR PDKS hizmetlerine ilişkin hataların giderilmesi ve işbu Politika'da yer alan amaçlardan herhangi birisini gerçekleştirebilmek için dış kaynak hizmet sağlayıcıları, barındırma hizmet sağlayıcıları (hosting servisleri), hukuk büroları, araştırma şirketleri, çağrı merkezleri gibi üçüncü kişiler ile paylaşabilecektir.

    Çalışan, yukarıda belirtilen amaçlarla sınırlı olmak kaydı ile bahsi geçen üçüncü tarafların Çalışanlar'ın kişisel verilerini dünyanın herhangi bir yerinde bulunan sunucularında saklayabileceğini, bu hususa peşinen muvafakat ettiğini kabul eder.

    Verilere Erişim Hakkı ve Düzeltme Talepleri Hakkında

    Çalışanlar, Kanun'un 11. Maddesi kapsamında QR PDKS'ya başvurarak kendisiyle ilgili;
        Kişisel veri işlenip işlenmediğini öğrenme,
        Kişisel verileri işlenmişse buna ilişkin bilgi talep etme,
        Kişisel verilerin işlenme amacını ve bunların amacına uygun kullanılıp kullanılmadığını öğrenme,
        Yurt içinde veya yurt dışında kişisel verilerin aktarıldığı üçüncü kişileri bilme,
        Kişisel verilerin eksik veya yanlış işlenmiş olması halinde bunların düzeltilmesini isteme,
        İlgili mevzuatta öngörülen şartlar çerçevesinde kişisel verilerin silinmesini veya yok edilmesini isteme,
        İlgili mevzuat uyarınca yapılan düzeltme, silme ve yok edilme işlemlerinin, kişisel verilerin aktarıldığı üçüncü kişilere bildirilmesini isteme,
        İşlenen verilerin münhasıran otomatik sistemler vasıtasıyla analiz edilmesi suretiyle kişinin kendisi aleyhine bir sonucun ortaya çıkmasına itiraz etme,
        Kişisel verilerin kanuna aykırı olarak işlenmesi sebebiyle zarara uğraması halinde zararın giderilmesini talep etme, haklarına sahiptir.

    Çalışanlar, yukarıda belirtilen taleplerini Atatürk Bulvarı No:120 Pasaport - İzmir adresine yazılı olarak iletebilecektir. QR PDKS, yukarıda yer alan talepler uyarınca, gerekçeli olumlu/olumsuz yanıtını, yazılı veya dijital ortamdan gerçekleştirebilir. Taleplere ilişkin gerekli işlemler için ücret alınmaması esastır. Bununla birlikte, işlemlerin bir maliyet gerektirmesi halinde, Kişisel Verilerin Korunması Kurulu tarafından, Kanun'un 13. maddesine göre belirlenen tarife üzerinden ücret talep edilmesi mümkündür.

    Çalışan, işbu Politika'ya konu bilgilerinin tam, doğru ve güncel olduğunu, bu bilgilerde herhangi bir değişiklik olması halinde bunları derhal güncelleyeceğini taahhüt eder. Çalışan'ın güncel bilgileri sağlamamış olması halinde QR PDKS'nın herhangi bir sorumluluğu olmayacaktır.

    Çalışan, kişisel verisinin QR PDKS tarafından kullanılamaması ile sonuçlanacak bir talepte bulunması halinde Personel Devam Kontrol Sistemi Kullanıcı Sözleşmesi'nde belirtilen hizmetlerden kendisinin ve/veya Şirket'in faydalanılamayabileceğini kabul ve bu kapsamda doğacak her türlü sorumluluğun kendisine ait olacağını beyan eder.

Kişisel Verilerin Saklama Süresi

    QR PDKS, Çalışanlar tarafından sağlanan kişisel verileri, Şirket'in ve Çalışan'ın Platform'dan faydalanabilmesi ve Platform'a konu hizmetlerin sağlanması için işbu Politika ile Personel Devam Kontrol Sistemi Kullanıcı Sözleşmesi'nde belirlenen ve Platform ve ilgili hizmetlerin mahiyetinden kaynaklanan yükümlülüklerin yerine getirilmesi amacıyla, hizmetlerin sağlandığı süre boyunca saklayacaktır. Buna ek olarak, QR PDKS, Şirket ve/veya Çalışan ile arasında doğabilecek herhangi bir uyuşmazlık durumunda, uyuşmazlık kapsamında gerekli savunmaların gerçekleştirilebilmesi amacıyla sınırlı olmak üzere ve ilgili mevzuat uyarınca belirlenen zamanaşımı süreleri boyunca kişisel verileri saklayabilecektir. Veri Güvenliğine İlişkin Önlemler ve Taahhütler QR PDKS, ilgili mevzuatta belirlenen veya işbu Politika'da ifade edilen şartlarda,

    kişisel verilerin hukuka aykırı olarak işlenmemesini,

    kişisel verilere hukuka aykırı olarak erişilmemesini, ve

    kişisel verilerin muhafazasını sağlamak amacıyla uygun güvenlik düzeyini temin etmeye yönelik gerekli teknik ve idari tedbirleri almayı, gerekli denetimleri yaptırmayı taahhüt eder.

    QR PDKS, Çalışanlar hakkında elde ettiği kişisel verileri bu işbu Politika ve Kanun hükümlerine aykırı olarak başkasına açıklayamaz ve işleme amacı dışında kullanamaz.

    Site ve Platform üzerinden başka uygulamalara link verilmesi halinde, QR PDKS uygulamaların gizlilik politikaları ve içeriklerine yönelik herhangi bir sorumluluk taşımamaktadır.

Politika'daki Değişiklikler

    QR PDKS, işbu Politika hükümlerini dilediği zaman değiştirebilir. Güncel Politika, Şirket'e ve/veya Çalışan'a herhangi bir yöntemle sunulduğu tarihte yürürlük kazanır.

                    """
                )));
              }
          ),
          con("Sürüm Güncelleme Derlemesi", version, null)
        ],
      ),
    );
  }
}
