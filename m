From: Rudolf Streif <rstreif@blackberry.com>
Subject: [PATCH] virtio_input: Initialize multi-touch slots on ABS_MT_SLOT
Date: Thu, 2 Jan 2020 19:12:08 +0000
Message-ID: <cbf254cbfde249b99f275a38c5c8cc97@blackberry.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6518213072025702533=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: "kraxel@redhat.com" <kraxel@redhat.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============6518213072025702533==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_cbf254cbfde249b99f275a38c5c8cc97blackberrycom_"

--_000_cbf254cbfde249b99f275a38c5c8cc97blackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

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


----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_cbf254cbfde249b99f275a38c5c8cc97blackberrycom_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
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

--_000_cbf254cbfde249b99f275a38c5c8cc97blackberrycom_--

--===============6518213072025702533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============6518213072025702533==--
