From: Patrick Archibal <bugpb60@hotmail.com>
Subject: About virtualization, kvm and xen
Date: Tue, 24 Feb 2009 13:02:28 +0000
Message-ID: <COL103-W644D390F3C81F48DF3630CABAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0683792762419753998=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============0683792762419753998==
Content-Type: multipart/alternative;
	boundary="_ce9f9b78-df75-4ec4-a3be-6388a45cd81f_"

--_ce9f9b78-df75-4ec4-a3be-6388a45cd81f_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C

I have understand that :

----------------------------
           guest
----------------------------
    driver_device0_guest
----------------------------
         hypervisor
----------------------------
  driver_device0_hypervisor
----------------------------
         device0
----------------------------

in order to access to a device=2C a guest use driver_device0_guest
The driver_device0_guest is modified to ask the hypervisor instead of the d=
evice0 directly.
Then the hypervisor uses the driver_device0_hypervisor in order to ask the =
device0.

It's my understant=2C maybe it's false.

I have few questions :

1 - what is the difference between libvirt and virtio.

2 - why developpers for xen=2C kvm... must develop drivers each time there =
are new devices ?
Because the driver must ask the hypervisor instead of device directly.

3 - The devices presented to the guest are real or emulated ? (for xen and/=
or kvm)
if devices are real=2C for example=2C i can use my graphic card with a virt=
ual machine ??

4 - Can you tell me why kvm is best or xen is best in enterprise.

In my understand=2C in the future=2C kvm is in good position because the de=
veloppment is integrated in=20

the kernel. Also=2C i feel xen progress because firms like citrix contribut=
e but it's seems there is=20

no big update since few years.

My vision is xen is best for production environnement because it takes adva=
ntages of minimal=20

hypervisor code while kvm must be install with the kernel.

Also=2C it seems=2C performance will be better in kvm with virtio. Can we u=
se virtio with xen ?
_________________________________________________________________
In=E9dit ! Des Emotic=F4nes D=E9jant=E9es! Installez les dans votre Messeng=
er !=20
http://www.ilovemessenger.fr/Emoticones/EmoticonesDejantees.aspx=

--_ce9f9b78-df75-4ec4-a3be-6388a45cd81f_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Hello=2C<br><br>I have understand that :<br><br>---------------------------=
-<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=
=3B&nbsp=3B guest<br>----------------------------<br>&nbsp=3B&nbsp=3B&nbsp=
=3B driver_device0_guest<br>----------------------------<br>&nbsp=3B&nbsp=
=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B hypervisor<br>---------=
-------------------<br>&nbsp=3B driver_device0_hypervisor<br>--------------=
--------------<br>&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&nbsp=3B&=
nbsp=3B device0<br>----------------------------<br><br>in order to access t=
o a device=2C a guest use driver_device0_guest<br>The driver_device0_guest =
is modified to ask the hypervisor instead of the device0 directly.<br>Then =
the hypervisor uses the driver_device0_hypervisor in order to ask the devic=
e0.<br><br>It's my understant=2C maybe it's false.<br><br>I have few questi=
ons :<br><br>1 - what is the difference between libvirt and virtio.<br><br>=
2 - why developpers for xen=2C kvm... must develop drivers each time there =
are new devices ?<br>Because the driver must ask the hypervisor instead of =
device directly.<br><br>3 - The devices presented to the guest are real or =
emulated ? (for xen and/or kvm)<br>if devices are real=2C for example=2C i =
can use my graphic card with a virtual machine ??<br><br>4 - Can you tell m=
e why kvm is best or xen is best in enterprise.<br><br>In my understand=2C =
in the future=2C kvm is in good position because the developpment is integr=
ated in <br><br>the kernel. Also=2C i feel xen progress because firms like =
citrix contribute but it's seems there is <br><br>no big update since few y=
ears.<br><br>My vision is xen is best for production environnement because =
it takes advantages of minimal <br><br>hypervisor code while kvm must be in=
stall with the kernel.<br><br>Also=2C it seems=2C performance will be bette=
r in kvm with virtio. Can we use virtio with xen ?<br /><hr />Souhaitez vou=
s =A0=AB=A0=EAtre au bureau sans y =EAtre=A0=BB=A0? <a href=3D'http://www.m=
icrosoft.com/france/windows/bts/default.mspx' target=3D'_new'>Oui je le veu=
x !</a></body>
</html>=

--_ce9f9b78-df75-4ec4-a3be-6388a45cd81f_--

--===============0683792762419753998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============0683792762419753998==--
