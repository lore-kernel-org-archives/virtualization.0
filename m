From: Sucheta Chakraborty <sucheta.chakraborty@qlogic.com>
Subject: KVM: Vlans not working with vlan hw rx acceleration
Date: Thu, 12 May 2011 02:20:09 -0500
Message-ID: <13A253B3F9BEFE43B93C09CF75F63CAA6E9601F19B@MNEXMB1.qlogic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3417150118135395366=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
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
To: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============3417150118135395366==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_13A253B3F9BEFE43B93C09CF75F63CAA6E9601F19BMNEXMB1qlogic_"

--_000_13A253B3F9BEFE43B93C09CF75F63CAA6E9601F19BMNEXMB1qlogic_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
Setup info:
(a) Using RHEL6 kvm. (b) Loaded driver on RHEL6 setup.
(c) Created 2 bridges on top of two interfaces.
(d) Assigned these bridges to 2 VMs.
(e) Created vlans in VMs.
Problem:
When vlan acceleration support is enabled in driver, traffic stops b/w VMs =
on vlan interfaces inside virtual m/c.
Without, vlan acceleration, everything works fine.
Thanks,
Sucheta.

________________________________
This message and any attached documents contain information from QLogic Cor=
poration or its wholly-owned subsidiaries that may be confidential. If you =
are not the intended recipient, you may not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.

--_000_13A253B3F9BEFE43B93C09CF75F63CAA6E9601F19BMNEXMB1qlogic_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
-->
</style><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"margin-bottom:.25in;line-height:160%;backgr=
ound:white">
<span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:&qu=
ot;Arial&quot;,&quot;sans-serif&quot;;
color:black">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:.25in;line-height:160%;backgr=
ound:white">
<span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:&qu=
ot;Arial&quot;,&quot;sans-serif&quot;;
color:black">Setup info:<br>
(a) Using RHEL6 kvm. (b) Loaded driver on RHEL6 setup.<br>
(c) Created 2 bridges on top of two interfaces.<br>
(d) Assigned these bridges to 2 VMs.<br>
(e) Created vlans in VMs.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:.25in;line-height:160%;backgr=
ound:white">
<span lang=3D"EN" style=3D"font-size:9.0pt;line-height:160%;font-family:&qu=
ot;Arial&quot;,&quot;sans-serif&quot;;
color:black">Problem:<br>
When vlan acceleration support is enabled in driver, traffic stops b/w VMs =
on vlan interfaces inside virtual m/c.<br>
Without, vlan acceleration, everything works fine.<o:p></o:p></span></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Sucheta.<o:p></o:p></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1">This message and any attache=
d documents contain information from QLogic Corporation or its wholly-owned=
 subsidiaries that may be confidential. If you are not the intended recipie=
nt, you may not read, copy, distribute,
 or use this information. If you have received this transmission in error, =
please notify the sender immediately by reply e-mail and then delete this m=
essage.<br>
</font>
</body>
</html>

--_000_13A253B3F9BEFE43B93C09CF75F63CAA6E9601F19BMNEXMB1qlogic_--

--===============3417150118135395366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============3417150118135395366==--
