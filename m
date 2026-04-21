Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E237B015
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791343; cv=none; b=gGyJCeGzQSBxuIQAf8B/MQNvn/tLbdnhp2sE7QvMRffoEVyZ/x5fCr6TljaVbmoOIGievRIo8mifyUDuVoswsO4XGuVAaqgNmMWfv9hcOJl6kiapNtfvX5VFbw775BSJF4Vn8lpAEiDt9/h11x6n9Wv8PalWCivhFOx2G8OeoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791343; c=relaxed/simple;
	bh=od8k5xtV8e4Z8osMhk6ok0xld4V4tOQnYwSKkBmiVjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvbxLCb5rH9sklpvfOoM/+6hUsCfFIIcv+dFr8lnhMXIc+d+caK60ETXWoGfme7x+/QDqGq/SsC6mV2Ek0ELvHyemORokSl1vksDEgLd3rKV3GtBF+FVdDelS+k4/uaBKhaSB/TTsXW68kog2kvs1lST0e5H/covFIVCVdhCn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEyaOBQy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEyaOBQy"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50e5bea4045so19973751cf.3
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791340; x=1777396140; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH0BlHlhoxLNNnKqBxOSLzwEDmUvu7SwzB/nxXf7+zI=;
        b=PEyaOBQyMZpih39w5+WSLIVYqFR1KVwrHqwO4l4cwobGorY5q2RI8c/qbA+AWcKgTj
         hOP0L/mlFw77oSDd8jdsYaY4M1RzXKubP2tsL4sLob7zHR4oQJ5K2EEPBYKwOhhFg2OM
         zpSe+h86/OxixGWRphmMQXiq3UIijtHXzTT7bYs8NYVJbrBaR8ldCbfM/mGzGOH/MeJc
         Casy5MqRC5J5Sf7Ti5fjlB9aib91Dl0DzCGJ8xk0U4RcVIFhR3Hayd1veizMLD39lVJs
         IJ1Wj4Q9lCD00LwL7x3FK+SR6ZxYIS0UgPri4AOZmVBf8eQ8xpa77dTaEq/73dDTa/vc
         l7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791340; x=1777396140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wH0BlHlhoxLNNnKqBxOSLzwEDmUvu7SwzB/nxXf7+zI=;
        b=nMtFzjPJW01lmKNei7EzWPKp1j4tMFWOKUraUT1k9ljusPLcBcCMlemzITaWxLyE8x
         HttVzkJ3HS4qgDr3nxKXNEm5o2oeSJDCBBiAG8g5US9hA669jcUJkTz4SsqIy8OsFSAE
         ri7G3234CHRDfemkk5IAdINXAalJAoNbmMbL9XuzZn/LGF+O+/pPaWJV2d/EF7qcv+oP
         aS9apFJa8jZzmuHe/OVZy4Uh5IDYK0bwKTdN1ZICS4kzhsThvFMGJbsDQ+Kfwt/QB52Z
         gO9LdE5O43M1Ng6sdc+5GlXXu16GpTRSox5fN6Sxw0KPy0Onv58wCrtKJBPPmnI+G+Ws
         nJyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Zek5RNg6Mo0HKSZ9XWEYf26RNmHyKncG64UDvbD29vgsp3LejdW5n76U1DJU3XFclkl/gxGwUADSbYc1k/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YypmRe0Eye9vp5mSFWqG5fEZcu+BXed6agqMhoI1IhoLp1824xW
	mbfyHdnHW1+gDGRIu8MUxNHQL7o7UCZn9p2C0qKCRPO14lQZaFHFYDoN
X-Gm-Gg: AeBDies9uZOi7F4l21F3DcVwXL1/Y/zhEcq9qHHWaDcQpPmbd2wxXZYu3bEUQWL6hQA
	EkgafNheuVMyLy5agCCSzbJi+Pb74tNWzztCMctk1Jk0DIfBTkoy0+8iSV4ldJ5yhrSwX2DNRSM
	QcUe/VWxm4hsmiBjeWrVfTUUgAY9DeNzqQeoi9uaZg/D8TP4eYgA+carkah01zcldv6leTT3tsi
	notCd11jZrM4u71HVifHlSZi6ouUZ3tu+MU82Uzp5PVfNN/klXDuhGqZ7jO+AN6SsFVX1WyDetH
	3GflS0vFFo0xX9B2e1SItMiPx2qgFmNW13rAnU9D/XQCMmEB86HMaQ2tPF6wuzFx25zmVVr49Ga
	ENswccHPwAa8OCbfo/wYH8wLfuFpC2SeKxlfK8buyEzm3KYBcB5jFA8jt9IV4YMUMAQ+AA4/wvm
	FD/h/+oGRNjIwVmNVDDfxWFO0Ugpmc6/IaC6SQc8ciiEz52Ncar5n+t3Wyr5qk9aptgsfKv25n0
	LHIXpVV5T97ok6xMWIUvZ6OcuYY20E=
X-Received: by 2002:a05:622a:aa46:10b0:50e:423e:2882 with SMTP id d75a77b69052e-50e423e40b5mr173188071cf.51.1776791340368;
        Tue, 21 Apr 2026 10:09:00 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb92db861sm13134471cf.5.2026.04.21.10.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:08:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Soenke Huster <soenke.huster@eknoes.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v3 1/2] Bluetooth: virtio_bt: clamp rx length before skb_put
Date: Tue, 21 Apr 2026 13:08:44 -0400
Message-ID: <20260421170845.3469513-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421170845.3469513-1-michael.bommarito@gmail.com>
References: <CABBYNZKqx4ureNbRGEghGjGWcmMQSoiY4oUCECme_Vgn8RvYYw@mail.gmail.com>
 <20260421170845.3469513-1-michael.bommarito@gmail.com>
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

Define VIRTBT_RX_BUF_SIZE once and reuse it in alloc_skb() and
sg_init_one(), and gate virtbt_rx_work() on that same constant so
the bound checked matches the buffer actually exposed to the device.
Reject used.len == 0 in the same gate so an empty completion can
no longer reach virtbt_rx_handle().

Use bt_dev_err_ratelimited() because the length value comes from an
untrusted backend that can otherwise flood the kernel log.

Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
overflow in USB transport layer"), which hardened the USB 9p
transport against unchecked device-reported length.

Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
Cc: stable@vger.kernel.org
Cc: Soenke Huster <soenke.huster@eknoes.de>
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v3:
- split off the per-pkt-type header-length check into its own
  patch (2/2) per Luiz's request; this patch now only covers the
  used.len vs buffer-size hazard and the len == 0 path

Changes in v2:
- validate used.len against VIRTBT_RX_BUF_SIZE (the 1000 bytes
  actually exposed to the device via sg_init_one()) rather than
  skb_tailroom(), which can exceed 1000 due to slab padding
- reject used.len == 0 before virtbt_rx_handle() reads the
  pkt_type byte, so zero-length completions can no longer pull an
  empty skb into hci_recv_frame()
- switch the error log to bt_dev_err_ratelimited() because the
  length value comes from an untrusted backend that can otherwise
  flood the kernel log

 drivers/bluetooth/virtio_bt.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 76d61af8a275..2c5c39356a1c 100644
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
@@ -227,8 +228,15 @@ static void virtbt_rx_work(struct work_struct *work)
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

