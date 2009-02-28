From: Patrick Archibal <bugpb60@hotmail.com>
Subject: Device Drivers in xen, looking also for a white book about how xen
	works exactly
Date: Sat, 28 Feb 2009 19:54:07 +0000
Message-ID: <COL103-W59467031B71F1DC083C226ABAB0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3011792839897572685=="
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

--===============3011792839897572685==
Content-Type: multipart/alternative;
	boundary="_bc784c74-dbd0-49b5-838d-a1b772453ccc_"

--_bc784c74-dbd0-49b5-838d-a1b772453ccc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello=2C

=20

I'm reading an excellent documentation about virtualisation in embedded sys=
tem.

 (available on open kernel labs site)

=20

I have read these things : (It talks about managing drivers in a virtualiza=
tion system)

=20

"A straight virtualization approach can accomodate this by running the devi=
ce the device driver inside the VMM. This requires porting all drivers to t=
he hypervisor environnement =2C with no reuse of guest os driver"

=20

A much better approach is to share a single driver between multiple vms=2C =
without including it in the hypervisor. This requires that ecah participati=
ng subsytem has a device modem for which it has a device driver. Typically=
=2C the real device driver is contained in one of the participating system=
=2C but a better  (safer) solution is to separate it out into in own subsys=
tem"

=20

I want to know how it works on xen.

I think that :

=20

 All drivers are in the hypervisor=2C when a guest requires to use a device=
=2C  guest uses drivers which has been rewriten for xen in order to contact=
 the hypervisor. Then=2C the hypervisor which has all real drivers (not mod=
ified) call the real device ?

=20

or that :

The real device driver is contained in the dom0 system=2C the dom0 manage d=
river for all domU.=20

=20

I have three questions :

=20

1 -  Which is the good scenario ? (if one is good ) :o)

2 - If drivers for guests are rewritten to call hypervisor or dom0 instead =
of the device directly=2C who devellops driver ?

(xen devellopers ? or developper for kernel mainline)

3- Which is the real utility of dom0 system ? (just I/O and administration =
of virtual machines) =20

=20

Last question=2C is someone have find a good white paper or doc which expla=
ins how xen works ?=20

(and where i can find probably answers for my questions ??)

=20

Thanks for all this details.

Best regards

=20

Patrick Archibal

=20

=20

=20

_________________________________________________________________
In=E9dit ! Des Emotic=F4nes D=E9jant=E9es! Installez les dans votre Messeng=
er !=20
http://www.ilovemessenger.fr/Emoticones/EmoticonesDejantees.aspx=

--_bc784c74-dbd0-49b5-838d-a1b772453ccc_
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
Hello=2C<BR>
&nbsp=3B<BR>
I'm reading an excellent documentation about virtualisation in embedded sys=
tem.<BR>
&nbsp=3B(available on open kernel labs site)<BR>
&nbsp=3B<BR>
I have read these things : (It talks about managing drivers in a virtualiza=
tion system)<BR>
&nbsp=3B<BR>
"A straight virtualization approach can accomodate this by running the devi=
ce the device driver inside the VMM. This requires porting all drivers to t=
he hypervisor environnement =2C with no reuse of guest os driver"<BR>
&nbsp=3B<BR>
A much better approach is to share a single driver between multiple vms=2C =
without including it in the hypervisor. This requires that ecah participati=
ng subsytem has a device modem for which it has a device driver. Typically=
=2C the real device driver is contained in one of the participating system=
=2C but a better&nbsp=3B (safer) solution is to separate it out into in own=
 subsystem"<BR>
&nbsp=3B<BR>
I want to know how it works on xen.<BR>
I think that :<BR>
&nbsp=3B<BR>
&nbsp=3BAll drivers are in the hypervisor=2C when a guest requires to use a=
 device=2C&nbsp=3B&nbsp=3Bguest uses drivers which has been rewriten for&nb=
sp=3Bxen&nbsp=3Bin order to contact the hypervisor. Then=2C the hypervisor =
which has all real drivers (not modified)&nbsp=3Bcall the real device ?<BR>
&nbsp=3B<BR>
or that :<BR>
The real device driver is contained in the dom0&nbsp=3Bsystem=2C the dom0 m=
anage driver for all domU.&nbsp=3B<BR>
&nbsp=3B<BR>
I have three questions :<BR>
&nbsp=3B<BR>
1 - &nbsp=3BWhich is the good scenario ? (if one is good ) :o)<BR>
2 - If drivers for guests are rewritten to call hypervisor or dom0&nbsp=3Bi=
nstead of the device directly=2C who devellops driver ?<BR>
(xen devellopers ? or developper for kernel mainline)<BR>
3- Which is the real utility of dom0 system ? (just I/O and administration =
of virtual machines) &nbsp=3B<BR>
&nbsp=3B<BR>
Last question=2C is someone have find a good white paper or doc which expla=
ins how xen works ? <BR>
(and where i can find probably answers for my questions&nbsp=3B??)<BR>
&nbsp=3B<BR>
Thanks for all this details.<BR>
Best regards<BR>
&nbsp=3B<BR>
Patrick Archibal<BR>
&nbsp=3B<BR>
&nbsp=3B<BR>
&nbsp=3B<BR><br /><hr />Souhaitez vous =A0=AB=A0=EAtre au bureau sans y =EA=
tre=A0=BB=A0? <a href=3D'http://www.microsoft.com/france/windows/bts/defaul=
t.mspx' target=3D'_new'>Oui je le veux !</a></body>
</html>=

--_bc784c74-dbd0-49b5-838d-a1b772453ccc_--

--===============3011792839897572685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============3011792839897572685==--
