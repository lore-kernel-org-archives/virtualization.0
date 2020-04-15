From: Rudolf Streif <rstreif@blackberry.com>
Subject: Re: [PATCH] virtio_input: Initialize multi-touch slots on ABS_MT_SLOT
Date: Wed, 15 Apr 2020 00:24:12 +0000
Message-ID: <b5ebe49b77374d53a6cda0ac98f11560@blackberry.com>
References: <cbf254cbfde249b99f275a38c5c8cc97@blackberry.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0376603427194522209=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cbf254cbfde249b99f275a38c5c8cc97@blackberry.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============0376603427194522209==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_b5ebe49b77374d53a6cda0ac98f11560blackberrycom_"

--_000_b5ebe49b77374d53a6cda0ac98f11560blackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Resubmit. Thank you.


________________________________
From: Virtualization <virtualization-bounces@lists.linux-foundation.org> on=
 behalf of Rudolf Streif <rstreif@blackberry.com>
Sent: Thursday, January 2, 2020 11:12 AM
To: kraxel@redhat.com
Cc: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_input: Initialize multi-touch slots on ABS_MT_SLOT


For multi-touch devices the frontend needs to initialize the correct
number of slots for touch tracking. Hardware drivers do this by
calling input_mt_init_slots() on initialization. For virtio_input
the function must be called when the backend sends ABS_MT_SLOT.

Signed-off-by: Rudolf J Streif <rstreif@blackberry.com>
---
 drivers/virtio/virtio_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 5ae529671b3d..582ba808b955 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -3,6 +3,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/input.h>
+#include <linux/input/mt.h>

 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
@@ -164,6 +165,9 @@ static void virtinput_cfg_abs(struct virtio_input *vi, =
int abs)
        virtio_cread(vi->vdev, struct virtio_input_config, u.abs.flat, &fl);
        input_set_abs_params(vi->idev, abs, mi, ma, fu, fl);
        input_abs_set_res(vi->idev, abs, re);
+
+       if (abs =3D=3D ABS_MT_SLOT)
+               input_mt_init_slots(vi->idev, ma + 1, INPUT_MT_DIRECT | INP=
UT_MT_DROP_UNUSED);
 }

 static int virtinput_init_vqs(struct virtio_input *vi)
--
2.17.1



________________________________
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_b5ebe49b77374d53a6cda0ac98f11560blackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;=
,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&q=
uot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p>Resubmit. Thank you.<br>
</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Virtualization &lt;=
virtualization-bounces@lists.linux-foundation.org&gt; on behalf of Rudolf S=
treif &lt;rstreif@blackberry.com&gt;<br>
<b>Sent:</b> Thursday, January 2, 2020 11:12 AM<br>
<b>To:</b> kraxel@redhat.com<br>
<b>Cc:</b> virtualization@lists.linux-foundation.org<br>
<b>Subject:</b> [PATCH] virtio_input: Initialize multi-touch slots on ABS_M=
T_SLOT</font>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:rgb(0,0,0); font-family:Calibri,Helvetica,sans-serif,&quot;EmojiFont&quot;=
,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&q=
uot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols">
<p></p>
<div>For multi-touch devices the frontend needs to initialize the correct<b=
r>
number of slots for touch tracking. Hardware drivers do this by<br>
calling input_mt_init_slots() on initialization. For virtio_input<br>
the function must be called when the backend sends ABS_MT_SLOT.<br>
<br>
Signed-off-by: Rudolf J Streif &lt;rstreif@blackberry.com&gt;<br>
---<br>
&nbsp;drivers/virtio/virtio_input.c | 4 &#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 4 insertions(&#43;)<br>
<br>
diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c<=
br>
index 5ae529671b3d..582ba808b955 100644<br>
--- a/drivers/virtio/virtio_input.c<br>
&#43;&#43;&#43; b/drivers/virtio/virtio_input.c<br>
@@ -3,6 &#43;3,7 @@<br>
&nbsp;#include &lt;linux/virtio.h&gt;<br>
&nbsp;#include &lt;linux/virtio_config.h&gt;<br>
&nbsp;#include &lt;linux/input.h&gt;<br>
&#43;#include &lt;linux/input/mt.h&gt;<br>
<br>
&nbsp;#include &lt;uapi/linux/virtio_ids.h&gt;<br>
&nbsp;#include &lt;uapi/linux/virtio_input.h&gt;<br>
@@ -164,6 &#43;165,9 @@ static void virtinput_cfg_abs(struct virtio_input *=
vi, int abs)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; virtio_cread(vi-&gt;vdev, struct=
 virtio_input_config, u.abs.flat, &amp;fl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input_set_abs_params(vi-&gt;idev=
, abs, mi, ma, fu, fl);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input_abs_set_res(vi-&gt;idev, a=
bs, re);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (abs =3D=3D ABS_MT_SLOT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; input_mt_init_slots(vi-&gt;idev, ma &#43; 1, INPUT_MT_DIRECT=
 | INPUT_MT_DROP_UNUSED);<br>
&nbsp;}<br>
<br>
&nbsp;static int virtinput_init_vqs(struct virtio_input *vi)<br>
-- <br>
2.17.1<br>
<br>
</div>
<br>
<p></p>
</div>
<hr>
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information
 by anyone other than the intended recipient is prohibited. If you have rec=
eived this transmission in error, please immediately reply to the sender an=
d delete this information from your system. Use, dissemination, distributio=
n, or reproduction of this transmission
 by unintended recipients is not authorized and may be unlawful.<br>
</div>
</div>
</div>

<HR>This transmission (including any attachments) may contain confidential =
information, privileged material (including material protected by the solic=
itor-client or other applicable privileges), or constitute non-public infor=
mation. Any use of this information by anyone other than the intended recip=
ient is prohibited. If you have received this transmission in error, please=
 immediately reply to the sender and delete this information from your syst=
em. Use, dissemination, distribution, or reproduction of this transmission =
by unintended recipients is not authorized and may be unlawful.<BR>
</body>
</html>

--_000_b5ebe49b77374d53a6cda0ac98f11560blackberrycom_--

--===============0376603427194522209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0376603427194522209==--
