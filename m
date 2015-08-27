From: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: A question about vring operation
Date: Thu, 27 Aug 2015 01:03:33 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7A115A4@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8475685274726226695=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Paolo Bonzini <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============8475685274726226695==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_286AC319A985734F985F78AFA26841F7A115A4shsmsx102ccrcorpi_"

--_000_286AC319A985734F985F78AFA26841F7A115A4shsmsx102ccrcorpi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

I have a question about the vring_avail:
It only includes an idx (equivalent to the ring tail), which is used by the=
 frontend (virtio_net) to fill bufs. The backend (e.g. vhost_net) maintains=
 the ring head (last_avail_idx) by itself. The frontend checks if the ring =
is full or empty via a counter (vq->num_free).
My question is why can't we include the ring head in the  vring_avail struc=
t, so that the vq->num_free is not needed, and the backend can directly use=
 it without maintaining its own copy?

Thanks,
Wei


--_000_286AC319A985734F985F78AFA26841F7A115A4shsmsx102ccrcorpi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a question about the vring_avail: <o:p></o:p>=
</p>
<p class=3D"MsoNormal">It only includes an idx (equivalent to the ring tail=
), which is used by the frontend (virtio_net) to fill bufs. The backend (e.=
g. vhost_net) maintains the ring head (last_avail_idx) by itself. The front=
end checks if the ring is full or
 empty via a counter (vq-&gt;num_free). <o:p></o:p></p>
<p class=3D"MsoNormal">My question is why can&#8217;t we include the ring h=
ead in the&nbsp; vring_avail struct, so that the vq-&gt;num_free is not nee=
ded, and the backend can directly use it without maintaining its own copy?<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Wei<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_286AC319A985734F985F78AFA26841F7A115A4shsmsx102ccrcorpi_--

--===============8475685274726226695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8475685274726226695==--
