Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399343D6491
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784640; cv=none; b=H5FQcLYi1a9rEi75J8Rm/vbjf6sxGIF8W8qhYDbEYMqAqqAKAzU9+jcTqDsGA4+ZDBYEkuBSwWTF8FrW6t5XJJbKrKkI/zsvcMyucw7UPcM1glXuzalgwp+bAjgpgEKqLQrh1c0fgP28M7HxAeV4bPvDGoNJVAKOTkv6ZSP0gLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784640; c=relaxed/simple;
	bh=d34uF+hsdZTzsatp98ogV2Hl8SC6bqoAe1+5QxrA/mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXYEDxDcQINpOTTHy9sYDSs6XfhEk416sl/96cPt4DrsECouyUCBU7UBSNvwzfTRLVZuqq48W1bwoUtjy0ZXqbQPzbs+xC+U7AEjZiZOBcHThPtMTFzlUqgrDJfChc8hHfYL40XEgJX54am2lG9p4XLHNtr54At147Ic43MD8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7KSCxa8; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7KSCxa8"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899a5db525cso35442616d6.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784637; x=1777389437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh27/PHUFrOVQPAWeMBLmjTu68znzQeEkGjIXTc62VQ=;
        b=Y7KSCxa8XvnPmTdGYvUTmmlS76R8p/vL+Bpjn1c/htZxEGYeSdyZAO/EcSpGlw2YeE
         gxC2AhGrhGazizHo+TztNLAmTnNnqJQfDlnlFcm3X+p4CTwlgGp4z+KjDHKDlzUxmUGj
         JKbfSa9Qela5Xg/q7PXXEts4Z0q7A3VuhmQR9KJyb2X1jmlPga4yON73hQcLjjB+o+cN
         vWqLitUeZz06Dw9VfSRiXDT69GQL/ttkkYRUB/DIonig2av5yzDigFBUxsR6sVb5JmGy
         vOywaOTalR/o7Nodw47aX6z0MQMv6zoYKCZ6x+16xnrmOTfu1hnSoywqMEy+4K2Znddg
         EIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784637; x=1777389437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sh27/PHUFrOVQPAWeMBLmjTu68znzQeEkGjIXTc62VQ=;
        b=gTlA2aSXxjysd6w6A3kzl5RztffCBx3PaRffcz13tyg5nuQoLeIuddH7v9KJnfFY/o
         gOjxlcOM/wpQIMymh2aqkiH/PxZPI/DOCMO+YSVogYUQttoR2MGIjPROQ45a+tqcnsHj
         pH/2LM2yfEHUGux/GLI2woRixltCmq6s2iCbXwRQvsTPgrBzyEKgINKvjU1ifjw12WJ9
         7RUU6cU9DHQrYak8LS0buZWRvhwsPxD/xKT85alyCPMWQ/X3fejE4vy7hZm2M/x+MEd9
         5cflZw95S/eUUE7ZTmRhPtv+EkwHslU1+DqR6Aj/V4uhbtRtOOjzajBbdDo2JoG9WkSo
         YcQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8A4miUEWjMIDXPZY7F/em2YT/PlGULFHlVv7bHE6/PYo9icOtjNLkBc5sr8P3qpaVSTmXYkmYTG6tbC1t+oQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6S+aIbe+0Xi0UqLTef3Gw/rIwki2fEYz8uQNoj8gNITlcTw/t
	M6xZYXjVKBzJxi0V4PI7X9XHkqg4BAkVvDO8a0D1FV9PhERIXQNkIgBs
X-Gm-Gg: AeBDietISoKeC4Qye6tc2Xny+hMSCWygonnB1mLwO70mrdoqbRfMyMRXSbhbu1hZ5wf
	eHOkeyp1Tul1IgefOSDMYj9Zd808GtsoI19zFfDTP0BFCocsoh6Q56tFxmJTwVTdWCscqAeDh9M
	je4wokPdjTXriNoa/DUa6XBRSuq9D9JC2tkasr1fgLPumzUTBr1wZJJKxE7Vz00vOkhDIf0TF9T
	JRbH0iOFCKkMUi3l2pHb1UOi+RCGpPqF6aPRx4kITvlqJSPCE7HT1LB86S908AZYePKzripAykn
	WQMQOGFJVx3F/7FkTKwg45dXY11wUFTLXDt/dK6NSW3lrm52B0VVRwj6U4s7vloQofq92vx2yqb
	TiUSL7HOF2OdM3PypuKHepBPC04y5n0m0qc8hmJFVnz3VJHFORo1FJJKe5ueyh1yvstZu4wAFOj
	I2x7BsTQrGJCb/wPxVU6DYhMXe2Hkg5d8JMT40utIy3bn93stmQgWEq0+7IFCZxG4OOdyJ9GxHL
	hDqZUBwDsee4VLQ0uGnL6BOGmLZgjc=
X-Received: by 2002:ad4:5ec8:0:b0:8a2:97cc:af82 with SMTP id 6a1803df08f44-8b0280ecde7mr293949096d6.27.1776784637005;
        Tue, 21 Apr 2026 08:17:17 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae797eesm104553876d6.34.2026.04.21.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:17:15 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v2] Bluetooth: virtio_bt: clamp rx length before skb_put
Date: Tue, 21 Apr 2026 11:16:59 -0400
Message-ID: <20260421151659.3326690-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
References: <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtbt_rx_work() calls skb_put(skb, len) where len comes directly
from virtqueue_get_buf() with no validation against the buffer we
posted to the device. The RX skb is allocated in virtbt_add_inbuf()
and exposed to virtio as exactly 1000 bytes via sg_init_one().

Checking len against skb_tailroom(skb) is not sufficient because
alloc_skb() can leave more tailroom than the 1000 bytes actually
handed to the device. A malicious or buggy backend can therefore
report used.len between 1001 and skb_tailroom(skb), causing skb_put()
to include uninitialized kernel heap bytes that were never written by
the device.

The same path also accepts len == 0, in which case skb_put(skb, 0)
leaves the skb empty but virtbt_rx_handle() still reads the pkt_type
byte from skb->data, consuming uninitialized memory.

A single-byte completion also reaches hci_recv_frame() with skb->len
already pulled to 0. If the byte happened to be HCI_ACLDATA_PKT, the
ACL-vs-ISO classification fast-path in hci_dev_classify_pkt_type()
dereferences hci_acl_hdr(skb)->handle whenever the HCI device has an
active CIS_LINK, BIS_LINK, or PA_LINK connection, reading two bytes
of uninitialized RX-buffer data. The same hazard exists for every
packet type the driver accepts because none of the switch cases in
virtbt_rx_handle() check skb->len against the per-type minimum HCI
header size before handing the frame to the core.

Close all three paths:

  - define VIRTBT_RX_BUF_SIZE once, reuse it in alloc_skb() and
    sg_init_one() and as the upper bound on used.len, so the gate
    matches the buffer actually exposed to the device
  - reject used.len == 0 before virtbt_rx_handle() reads pkt_type
  - after stripping pkt_type, require skb->len to cover the fixed
    header size for the selected type (event/ACL/SCO/ISO) before
    calling hci_recv_frame(); drop ratelimited otherwise

Use bt_dev_err_ratelimited() because the length and packet-type
values come from an untrusted backend that can otherwise flood the
kernel log.

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
overflow in USB transport layer"), which hardened the USB 9p
transport against unchecked device-reported length.

Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
Cc: stable@vger.kernel.org
Cc: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v2:
- validate used.len against VIRTBT_RX_BUF_SIZE (the 1000 bytes
  actually exposed to the device via sg_init_one()) rather than
  skb_tailroom(), which can exceed 1000 due to slab padding
- reject used.len == 0 before virtbt_rx_handle() reads the pkt_type
  byte, so zero-length completions can no longer pull an empty skb
  into hci_recv_frame()
- in virtbt_rx_handle(), require skb->len to cover the fixed HCI
  header size for the selected pkt_type (event 2, ACL 4, SCO 3,
  ISO 4) before calling hci_recv_frame(); this prevents a one-byte
  HCI_ACLDATA_PKT completion from reaching
  hci_dev_classify_pkt_type() and dereferencing hci_acl_hdr(skb)
  over uninitialized RX buffer data when CIS/BIS/PA connections
  are present
- switch the error log to bt_dev_err_ratelimited() because the
  length and pkt_type values come from an untrusted backend that
  can otherwise flood the kernel log

 drivers/bluetooth/virtio_bt.c | 39 ++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 76d61af8a275..140ab55c9fc5 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -12,6 +12,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #define VERSION "0.1"
+#define VIRTBT_RX_BUF_SIZE 1000
 
 enum {
 	VIRTBT_VQ_TX,
@@ -33,11 +34,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 	struct sk_buff *skb;
 	int err;
 
-	skb = alloc_skb(1000, GFP_KERNEL);
+	skb = alloc_skb(VIRTBT_RX_BUF_SIZE, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-	sg_init_one(sg, skb->data, 1000);
+	sg_init_one(sg, skb->data, VIRTBT_RX_BUF_SIZE);
 
 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
 	if (err < 0) {
@@ -197,6 +198,7 @@ static int virtbt_shutdown_generic(struct hci_dev *hdev)
 
 static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 {
+	size_t min_hdr;
 	__u8 pkt_type;
 
 	pkt_type = *((__u8 *) skb->data);
@@ -204,16 +206,32 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
 
 	switch (pkt_type) {
 	case HCI_EVENT_PKT:
+		min_hdr = sizeof(struct hci_event_hdr);
+		break;
 	case HCI_ACLDATA_PKT:
+		min_hdr = sizeof(struct hci_acl_hdr);
+		break;
 	case HCI_SCODATA_PKT:
+		min_hdr = sizeof(struct hci_sco_hdr);
+		break;
 	case HCI_ISODATA_PKT:
-		hci_skb_pkt_type(skb) = pkt_type;
-		hci_recv_frame(vbt->hdev, skb);
+		min_hdr = sizeof(struct hci_iso_hdr);
 		break;
 	default:
 		kfree_skb(skb);
-		break;
+		return;
+	}
+
+	if (skb->len < min_hdr) {
+		bt_dev_err_ratelimited(vbt->hdev,
+				       "rx pkt_type 0x%02x payload %u < hdr %zu\n",
+				       pkt_type, skb->len, min_hdr);
+		kfree_skb(skb);
+		return;
 	}
+
+	hci_skb_pkt_type(skb) = pkt_type;
+	hci_recv_frame(vbt->hdev, skb);
 }
 
 static void virtbt_rx_work(struct work_struct *work)
@@ -227,8 +245,15 @@ static void virtbt_rx_work(struct work_struct *work)
 	if (!skb)
 		return;
 
-	skb_put(skb, len);
-	virtbt_rx_handle(vbt, skb);
+	if (!len || len > VIRTBT_RX_BUF_SIZE) {
+		bt_dev_err_ratelimited(vbt->hdev,
+				       "rx reply len %u outside [1, %u]\n",
+				       len, VIRTBT_RX_BUF_SIZE);
+		kfree_skb(skb);
+	} else {
+		skb_put(skb, len);
+		virtbt_rx_handle(vbt, skb);
+	}
 
 	if (virtbt_add_inbuf(vbt) < 0)
 		return;
-- 
2.53.0

