From: "Chun-Hsian Huang" <huang@cs.ccu.edu.tw>
Subject: device virtualization
Date: Thu, 5 Nov 2009 02:50:25 +0800
Message-ID: <9EA1764517344ED4A898F14520D4A949@chunhsian>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3473966403560604585=="
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

This is a multi-part message in MIME format.

--===============3473966403560604585==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0003_01CA5DC2.B9F61030"

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01CA5DC2.B9F61030
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear all:

 

           In a Linux system, the access of a hardware device is to open and
close its device node. However, using device virtualization, the physical
device can be shared with one more guest OSes. Does the device node of the
shared physical device still need to be opened and closed turn by turn for
being accessed by the guest OSes? Does it mean that the device sharing
mechanism is performed in the user space and not kernel space? What are
performed in the kernel space if KVM is used? How about Xen, QEMU, and
VMWare, or other device virtualization techniques? I'm a beginner for
virtualization, and hope that someone can answer to my questions Thanks very
much!

 

Sincerely,

Huang.


------=_NextPart_000_0003_01CA5DC2.B9F61030
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 3 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:18.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DZH-TW link=3Dblue vlink=3Dpurple =
style=3D'text-justify-trim:punctuation'>

<div class=3DSection1 style=3D'layout-grid:18.0pt'>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Dear all:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; In
a Linux system, the access of a hardware device is to open and close its =
device
node. However, using device virtualization, the physical device can be =
shared
with one more guest OSes. Does the device node of the shared physical =
device still
need to be opened and closed turn by turn for being accessed by the =
guest OSes?
Does it mean that the device sharing mechanism is performed in the user =
space
and not kernel space? What are performed in the kernel space if KVM is =
used? How
about Xen, QEMU, and VMWare, or other device virtualization techniques? =
I&#8217;m
a beginner for virtualization, and hope that someone can answer to my =
questions
Thanks very much!<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Sincerely,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Times New Roman"><span =
lang=3DEN-US
style=3D'font-size:10.0pt'>Huang.<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0003_01CA5DC2.B9F61030--


--===============3473966403560604585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============3473966403560604585==--
