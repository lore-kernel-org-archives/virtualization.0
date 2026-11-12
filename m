Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458154;
	b=hr0AYYGZDGkCCjEgHxxyTdWjSrq3kH2etS3T7pbnU+P9ATCGcCYbXiLihKv3jQatpWd3
	 uQe6v/nodeCOJqSvEnPC/rjxoF07HFUkuJqvvLMQ2PgJNs7rTMkwAb62m9iRKFENh002q
	 KHUBZKivly/Ic9Z2/5QBSxiOk27V5mlKFc/XtPKDoumeNesKTm3gbe7OcflWLKiHz0sM4
	 wGvuizi2jcLSr+ZY0ibl/GqAadDBZNC13ZgBnyd13AcOqrg8wDe6yAUhXyiDMIkarciMN
	 9Qc9qMYn703LEmMJDpoKlaMSIWKUaTbiDC24v+puV7NDPREeBEOHImfaG8b0gKbZzRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HjEqMRpJHMxBlJx8PrvbXzsvZE9iPcCWrDVwQeSTNAI=;
	b=Fbh9AHcsLOyzvXi9m374ExumCJO2FMlvKtVhda27Ykwu3o9U9gXpnQmvXSyajL2ALtLa
	 nZ/pcRkf7tOaJceS9/1gyzcI2VbaMhZZKNIbSN/CWiI+CJiu8EmQTSIYX+ibK3jUq3yoh
	 B2llHdXbiTJ2IEPthiMnjL5d6gJdPapSOZNOqtrpbbiPCvDd+V7Iw8SnwaJkzEoBfGbj2
	 N7ifx6jt562rmbYhuiPtZvbJ6bXHsdHeAgr86IERrF84j1aWVj8w07grlEcV0kOcknN19
	 tdkPXKSHLl8e+PN9az0I8a+RAOVfhlaAr5cvJcLH8g8lzatIjlUidL+OPFV3C3kG9Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFQ6IzuQ;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2FF60A382E
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB2FF60A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JFQ6IzuQ
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1633182a12.1
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 20:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458153; x=1795062953; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HjEqMRpJHMxBlJx8PrvbXzsvZE9iPcCWrDVwQeSTNAI=;
        b=JFQ6IzuQamfx+wVNzkLngqEknQWarmkkF1xeLfPByxkxU+fS+GofTicHQ7wZM4nHJR
         XqpdUtgj5udmUt+/CcyMGf2FOrM9sjF/cWlVpiutr6e4w8XZfBtD6QFVtGGo9DeUIeib
         WZ2eSPQZHuIDSPZ28iQ0+0sndQUe2JcbJEp2oL/noXH30HSwy+daihmVn9L3BsDMsGy3
         Qq+pAbbTPstaxdvddFjmnFtwNvvkIU6bKScxDAo36MTsahtZShQH1LzOKy7tGZngn+fU
         R32unQ//8rkK30LeLlpPxSDoB3Wo3pN8TSk+D5przUi+G7yuql763DIoWaJF8UoksWnQ
         LY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458153; x=1795062953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HjEqMRpJHMxBlJx8PrvbXzsvZE9iPcCWrDVwQeSTNAI=;
        b=MYZPx+1b6BDbaamkLTqi6UT90139h5eJUJzfk55l+AzEvOFuNXHHq8T4x5IRQrc58E
         qQSjhm0w3ghqUH7wvaiVjey2K2SMrO0bJXhhO/8Hyftwf+10cqyiDhYBowCxQekgtDE5
         lLnfCHNKeYCnYode5h3aOL8mcXXnveF8B4YhMRp8khjyli2oY+kPPK7oafEyFBK+agFK
         mC5PyLNa83thr/vp3M42/FZbm539Ph8MhSX5N5K1zBPzwQ3BnKFq30rX5dQMmxE02qq5
         FZsKopwdPM0YfFKApbH79q/wdDhKWzgP/uewU9RtyyWC++iLTeoiFKMLS9mEOoHWe+Qn
         N+jQ==
X-Forwarded-Encrypted: i=1; AL+hErFJ0PvTfJOg3EOEx3pMbb+2qrI4SH2O7yw8CAzkHWt31s8wgFyPJIXTEMHTIz6icEFdpM051O9bRG/HkM/HLQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+qxA5HT7OA+LAb9IHjsT2nF3+tgmU8ICIQEjDsD+Qx5Dsj4Hih
	DMqFsPP53WycTHLgcBJrPQ7e0Igd66WX41XlCdkzk0Vnd2oMCzIwNGqz
X-Gm-Gg: AYBFou0E4Pk4lwpgq7AYBYLf9TivN5AjQITKq17NkUiHM0nC3aSoiGrdAEg2qiKXY3G
	AEZn+RRTn4rF7XSMJhnORduWJE9F0tLDJxiIwEqTiZhhdtE1mYOPY/RD49VEqxzRAnP0yBeuC7X
	qazHGuBUPk4SuxLkbTSosfKQpOA1LCBjf7PGADdJvXmp3mI6rEwbTWcgnK/mwU9qWAp1YEAFPBX
	NV+5PuCirLtSIqzBsiG4R6NVjkLe5BNWxQVJk8QrUGli8HlSs+SiRQutAkR5AE52CF4Tbe2H4lL
	CECc3JqzFnL5nwD9n/wSSfum+Fot/O0XGlS0zJftP64a4erzU7MOsDkONlid+tmfK6ymPBM9Vq2
	lByekJaHyh5td+0xLflymAZPXpyeiVjupIBmlhrG8Ymo+9c1LEHX1rwPHfHoVEaZFM1Olt05bZE
	0In+cCdmNa83CK0ODRpPm+YVYMjCd1t93O/PKa8hoxbqZv3z5hZGYbzk8xohNeBgkIQ3EZg3KTK
	7fN2GG7Sli9GjhVQUmYJp3Otl2wwFcVrEI2s6ipHyBfgxe1wpDr7ZDkxB+Zz/AXrTZ0qkzUwhTW
	lrCOdioiDKroAwcGnjYfMfvIOCqcKzkiLNrm2DixnD/5M5L7S3dvWvugVVIVl+cS+l49v2KZQEa
	W0BsDKgUT1efv/ofgUxDL9cke5bGJ1kG3bHFsc1DSI7h3Qgg=
X-Received: by 2002:a17:90a:e7cd:b0:3ad:6090:a189 with SMTP id 98e67ed59e1d1-3b182f93b3cmr4476458a91.45.1794458153019;
        Wed, 11 Nov 2026 20:35:53 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm2470466a91.15.2026.11.11.20.35.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:35:52 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v28 09/17] ALSA: virtio: bound PCM transfers and retain DMA buffers
Date: Thu, 12 Nov 2026 13:35:08 +0900
Message-ID: <20261112043516.37010-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112043516.37010-1-mynameisjune111@gmail.com>
References: <20261112043516.37010-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate ACK geometry, conversion bounds and queued-byte accounting
before submitting transfers. Retain the backing DMA pages until message
retirement. Check RX status and upper payload bounds while accepting
bounded short responses, including at STOP and PAUSE. Preserve the
legacy RX completion and ACK policy until the request-owned conversion,
including the legacy handling of empty PAUSE returns. The fixed-offset
layout still has short-response data gaps; request-owned capture and its
queue/accounting contract arrive together in patch 12. Non-MMU copies
use only the validated returned payload length.

Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for the PCM device")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |   11 +
 sound/virtio/virtio_pcm_msg.c |  306 +++++++++++++++++++++++++++++++++++------
 sound/virtio/virtio_pcm_ops.c |  113 +++++++++++++++
 3 files changed, 386 insertions(+), 44 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -13,6 +13,7 @@
 
 struct virtio_pcm;
 struct virtio_pcm_msg;
+struct page;
 
 /**
  * struct virtio_pcm_substream - VirtIO PCM substream.
@@ -42,6 +43,10 @@
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_count: Number of pending I/O messages in the virtqueue.
+ * @dma_pages: Pages backing DMA messages, retained until messages are freed.
+ * @ndma_pages: Number of retained pages.
+ * @owned_dma_area: Driver-owned PCM buffer backing asynchronous messages.
+ * @owned_dma_bytes: Size of @owned_dma_area.
  * @msg_empty: Notify when msg_count is zero.
  */
 struct virtio_pcm_substream {
@@ -68,6 +73,12 @@
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
 	unsigned int msg_count;
+	struct page **dma_pages;
+	unsigned int ndma_pages;
+#ifndef CONFIG_MMU
+	u8 *owned_dma_area;
+	size_t owned_dma_bytes;
+#endif
 	wait_queue_head_t msg_empty;
 };
 
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -3,6 +3,9 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/limits.h>
+#include <linux/mm.h>
+#include <linux/overflow.h>
 #include <sound/pcm_params.h>
 
 #include "virtio_card.h"
@@ -13,6 +16,7 @@
  * @xfer: Request header payload.
  * @status: Response header payload.
  * @length: Data length in bytes.
+ * @data_offset: Offset of the fixed PCM ring slice for ordinary I/O.
  * @sgs: Payload scatter-gather table.
  */
 struct virtio_pcm_msg {
@@ -20,6 +24,7 @@
 	struct virtio_snd_pcm_xfer xfer;
 	struct virtio_snd_pcm_status status;
 	size_t length;
+	size_t data_offset;
 	struct scatterlist sgs[];
 };
 
@@ -37,9 +42,8 @@
 };
 
 /**
- * virtsnd_pcm_sg_num() - Count the number of sg-elements required to represent
- *                        vmalloc'ed buffer.
- * @data: Pointer to vmalloc'ed buffer.
+ * virtsnd_pcm_sg_num() - Count the sg-elements for a page-backed buffer.
+ * @data: Pointer to the page-backed buffer.
  * @length: Buffer size.
  *
  * Context: Any context.
@@ -47,14 +51,18 @@
  */
 static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
 {
-	phys_addr_t sg_address;
-	unsigned int sg_length;
+	phys_addr_t sg_address = 0;
+	unsigned int sg_length = 0;
 	int num = 0;
 
 	while (length) {
 		struct page *pg = vmalloc_to_page(data);
-		phys_addr_t pg_address = page_to_phys(pg);
+		phys_addr_t pg_address;
 		size_t pg_length;
+
+		if (!pg)
+			return -EINVAL;
+		pg_address = page_to_phys(pg);
 
 		pg_length = PAGE_SIZE - offset_in_page(data);
 		if (pg_length > length)
@@ -75,11 +83,80 @@
 	return num;
 }
 
-/**
- * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
+#ifdef CONFIG_MMU
+/**
+ * virtsnd_pcm_dma_pages_put() - Release retained PCM buffer pages.
+ * @vss: VirtIO PCM substream.
+ *
+ * Context: Process context.
+ */
+static void virtsnd_pcm_dma_pages_put(struct virtio_pcm_substream *vss)
+{
+	while (vss->ndma_pages)
+		put_page(vss->dma_pages[--vss->ndma_pages]);
+	kfree(vss->dma_pages);
+	vss->dma_pages = NULL;
+}
+
+/**
+ * virtsnd_pcm_dma_pages_get() - Retain the pages backing the PCM buffer.
+ * @vss: VirtIO PCM substream.
+ * @data: PCM buffer address.
+ * @length: PCM buffer size.
+ *
+ * Keep the backing pages alive while virtqueue descriptors can still refer to
+ * them, even if ALSA releases the vmalloc mapping after a failed drain.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_pcm_dma_pages_get(struct virtio_pcm_substream *vss,
+				     u8 *data, size_t length)
+{
+	size_t i;
+	size_t npages;
+	size_t span;
+
+	if (!data || !length || !is_vmalloc_addr(data))
+		return -EINVAL;
+	if (vss->dma_pages || vss->ndma_pages)
+		return -EBUSY;
+
+	if (check_add_overflow(length, (size_t)offset_in_page(data), &span))
+		return -EOVERFLOW;
+
+	npages = span / PAGE_SIZE + !!(span % PAGE_SIZE);
+	if (npages > UINT_MAX)
+		return -EOVERFLOW;
+
+	vss->dma_pages = kcalloc(npages, sizeof(*vss->dma_pages), GFP_KERNEL);
+	if (!vss->dma_pages)
+		return -ENOMEM;
+
+	for (i = 0; i < npages; i++) {
+		struct page *page = vmalloc_to_page(data + i * PAGE_SIZE);
+
+		if (!page)
+			goto err_put_pages;
+
+		get_page(page);
+		vss->dma_pages[vss->ndma_pages++] = page;
+	}
+
+	return 0;
+
+err_put_pages:
+	virtsnd_pcm_dma_pages_put(vss);
+
+	return -EINVAL;
+}
+#endif
+
+/**
+ * virtsnd_pcm_sg_from() - Build an sg-list from a page-backed buffer.
  * @sgs: Preallocated sg-list to populate.
  * @nsgs: The maximum number of elements in the @sgs.
- * @data: Pointer to vmalloc'ed buffer.
+ * @data: Pointer to the page-backed buffer.
  * @length: Buffer size.
  *
  * Splits the buffer into physically contiguous parts and makes an sg-list of
@@ -132,36 +209,97 @@
 int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 			  unsigned int periods, unsigned int period_bytes)
 {
-	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+	struct snd_pcm_runtime *runtime;
+	size_t buffer_bytes;
 	unsigned int i;
+	int rc;
+
+	if (vss->msgs || vss->nmsgs || vss->dma_pages || vss->ndma_pages)
+		return -EBUSY;
+#ifndef CONFIG_MMU
+	if (vss->owned_dma_area || vss->owned_dma_bytes)
+		return -EBUSY;
+#endif
+	if (!periods || !period_bytes)
+		return -EINVAL;
+
+	if (check_mul_overflow((size_t)periods, (size_t)period_bytes,
+			       &buffer_bytes))
+		return -EOVERFLOW;
+
+	if (!vss->substream || !vss->substream->runtime)
+		return -EINVAL;
+	runtime = vss->substream->runtime;
+	if (!runtime->dma_area || buffer_bytes > runtime->dma_bytes)
+		return -EINVAL;
+
+#ifdef CONFIG_MMU
+	rc = virtsnd_pcm_dma_pages_get(vss, runtime->dma_area, buffer_bytes);
+	if (rc)
+		return rc;
+#else
+	vss->owned_dma_area = kzalloc(buffer_bytes, GFP_KERNEL);
+	if (!vss->owned_dma_area)
+		return -ENOMEM;
+	vss->owned_dma_bytes = buffer_bytes;
+#endif
 
 	vss->msgs = kzalloc_objs(*vss->msgs, periods);
-	if (!vss->msgs)
-		return -ENOMEM;
+	if (!vss->msgs) {
+		rc = -ENOMEM;
+		goto err_free_pages;
+	}
 
 	vss->nmsgs = periods;
 
 	for (i = 0; i < periods; ++i) {
-		u8 *data = runtime->dma_area + period_bytes * i;
-		int sg_num = virtsnd_pcm_sg_num(data, period_bytes);
+		int sg_num;
 		struct virtio_pcm_msg *msg;
+		u8 *data;
+#ifdef CONFIG_MMU
+		data = runtime->dma_area + (size_t)period_bytes * i;
+#else
+		data = vss->owned_dma_area + (size_t)period_bytes * i;
+#endif
+		sg_num = virtsnd_pcm_sg_num(data, period_bytes);
+		if (sg_num < 0) {
+			rc = sg_num;
+			goto err_free_msgs;
+		}
 
 		msg = kzalloc_flex(*msg, sgs, sg_num + 2);
-		if (!msg)
-			return -ENOMEM;
+		if (!msg) {
+			rc = -ENOMEM;
+			goto err_free_msgs;
+		}
 
 		msg->substream = vss;
+		vss->msgs[i] = msg;
 		sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], &msg->xfer,
 			    sizeof(msg->xfer));
 		sg_init_one(&msg->sgs[PCM_MSG_SG_STATUS], &msg->status,
 			    sizeof(msg->status));
+		msg->data_offset = (size_t)period_bytes * i;
 		virtsnd_pcm_sg_from(&msg->sgs[PCM_MSG_SG_DATA], sg_num, data,
 				    period_bytes);
-
-		vss->msgs[i] = msg;
 	}
 
 	return 0;
+
+err_free_msgs:
+	virtsnd_pcm_msg_free(vss);
+	return rc;
+
+err_free_pages:
+#ifdef CONFIG_MMU
+	virtsnd_pcm_dma_pages_put(vss);
+#else
+	kfree(vss->owned_dma_area);
+	vss->owned_dma_area = NULL;
+	vss->owned_dma_bytes = 0;
+#endif
+
+	return rc;
 }
 
 /**
@@ -177,6 +315,13 @@
 	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
 		kfree(vss->msgs[i]);
 	kfree(vss->msgs);
+#ifdef CONFIG_MMU
+	virtsnd_pcm_dma_pages_put(vss);
+#else
+	kfree(vss->owned_dma_area);
+	vss->owned_dma_area = NULL;
+	vss->owned_dma_bytes = 0;
+#endif
 
 	vss->msgs = NULL;
 	vss->nmsgs = 0;
@@ -228,8 +373,15 @@
 	bool notify = false;
 	int rc;
 
+	if (!bytes)
+		return 0;
+	if (!period_bytes || !vss->msgs || offset >= vss->buffer_bytes ||
+	    bytes > vss->buffer_bytes - offset)
+		return -EINVAL;
 	start = offset / period_bytes;
 	end = (offset + bytes - 1) / period_bytes;
+	if (end >= vss->nmsgs)
+		return -EINVAL;
 
 	for (i = start; i <= end; i++) {
 		struct virtio_pcm_msg *msg = vss->msgs[i];
@@ -248,6 +400,33 @@
 		if (msg->length == period_bytes) {
 			msg->xfer.stream_id = cpu_to_le32(vss->sid);
 			memset(&msg->status, 0, sizeof(msg->status));
+
+#ifndef CONFIG_MMU
+		if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			struct snd_pcm_runtime *runtime =
+				vss->substream ? vss->substream->runtime : NULL;
+			size_t data_bytes = msg->length;
+
+			if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
+			    msg->data_offset > runtime->dma_bytes ||
+			    data_bytes > runtime->dma_bytes - msg->data_offset ||
+			    msg->data_offset > vss->owned_dma_bytes ||
+			    data_bytes > vss->owned_dma_bytes - msg->data_offset) {
+				dev_err_ratelimited(&vdev->dev,
+						    "SID %u: invalid playback buffer for I/O message\n",
+					vss->sid);
+				msg->length -= n;
+				if (msg_count != vss->msg_count &&
+				    !(vss->features &
+				      (1U << VIRTIO_SND_PCM_F_MSG_POLLING)) &&
+				    virtqueue_kick_prepare(vqueue))
+					virtqueue_notify(vqueue);
+				return -EINVAL;
+			}
+			memcpy(vss->owned_dma_area + msg->data_offset,
+			       runtime->dma_area + msg->data_offset, data_bytes);
+		}
+#endif
 
 			if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
 				rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
@@ -356,42 +535,83 @@
 				     size_t written_bytes)
 {
 	struct virtio_pcm_substream *vss = msg->substream;
+	bool capture_invalid = false;
 
 	/*
-	 * hw_ptr always indicates the buffer position of the first I/O message
-	 * in the virtqueue. Therefore, on each completion of an I/O message,
-	 * the hw_ptr value is unconditionally advanced.
+	 * Completed requests can return captured data after STOP while the PCM
+	 * buffer remains prepared. Once preparation ends, completions only retire
+	 * queue ownership.
 	 */
 	guard(spinlock)(&vss->lock);
-	/*
-	 * If the capture substream returned an incorrect status, then just
-	 * increase the hw_ptr by the message size.
-	 */
-	if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK ||
-	    written_bytes <= sizeof(msg->status))
-		vss->hw_ptr += msg->length;
-	else
-		vss->hw_ptr += written_bytes - sizeof(msg->status);
-
-	if (vss->hw_ptr >= vss->buffer_bytes)
-		vss->hw_ptr -= vss->buffer_bytes;
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    (!vss->prepared || vss->xfer_xrun ||
+	     (vss->stopped && written_bytes <= sizeof(msg->status)))) {
+		msg->length = 0;
+		vss->msg_count--;
+		if (!vss->msg_count)
+			wake_up_all(&vss->msg_empty);
+		return;
+	}
+
+	/* Validate the returned payload before advancing the capture pointer. */
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    (written_bytes < sizeof(msg->status) ||
+	     le32_to_cpu(msg->status.status) != VIRTIO_SND_S_OK ||
+	     written_bytes - sizeof(msg->status) > msg->length)) {
+		dev_err_ratelimited(&vss->snd->vdev->dev,
+				    "SID %u: invalid capture position, status or length\n",
+			vss->sid);
+		vss->xfer_xrun = true;
+		capture_invalid = true;
+	}
+#ifndef CONFIG_MMU
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->prepared && !capture_invalid &&
+	    written_bytes > sizeof(msg->status)) {
+		struct snd_pcm_runtime *runtime =
+			vss->substream ? vss->substream->runtime : NULL;
+
+		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
+		    msg->data_offset > runtime->dma_bytes ||
+		    written_bytes - sizeof(msg->status) > runtime->dma_bytes - msg->data_offset ||
+		    msg->data_offset > vss->owned_dma_bytes ||
+		    written_bytes - sizeof(msg->status) > vss->owned_dma_bytes - msg->data_offset) {
+			dev_err_ratelimited(&vss->snd->vdev->dev,
+					    "SID %u: invalid capture buffer for I/O message\n",
+				vss->sid);
+			vss->xfer_xrun = true;
+			capture_invalid = true;
+		} else {
+			memcpy(runtime->dma_area + msg->data_offset,
+			       vss->owned_dma_area + msg->data_offset,
+			       written_bytes - sizeof(msg->status));
+		}
+	}
+#endif
+	/* Publish pointer progress only for a complete TX or valid RX request. */
+	if (!capture_invalid) {
+		vss->hw_ptr += vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+			written_bytes > sizeof(msg->status) ?
+			written_bytes - sizeof(msg->status) : msg->length;
+		if (vss->hw_ptr >= vss->buffer_bytes)
+			vss->hw_ptr -= vss->buffer_bytes;
+	}
 
 	msg->length = 0;
-
-	vss->xfer_xrun = false;
 	vss->msg_count--;
 
 	if (vss->xfer_enabled) {
-		struct snd_pcm_runtime *runtime = vss->substream->runtime;
-
-		runtime->delay =
-			bytes_to_frames(runtime,
-					le32_to_cpu(msg->status.latency_bytes));
-
+		if (!capture_invalid) {
+			struct snd_pcm_runtime *runtime = vss->substream->runtime;
+
+			runtime->delay =
+				bytes_to_frames(runtime,
+						le32_to_cpu(msg->status.latency_bytes));
+		}
 		schedule_work(&vss->elapsed_period);
-	} else if (!vss->msg_count) {
+	}
+	if (!vss->msg_count)
 		wake_up_all(&vss->msg_empty);
-	}
 }
 
 /**
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -25,6 +25,8 @@
  *   signal or due to a timeout. In this case, the device can still access
  *   messages even after calling ops->hw_free(). It can also issue an interrupt,
  *   and the interrupt handler will also try to access message structures.
+ *   The messages retain references to the PCM buffer pages until they are
+ *   freed, so late DMA does not target pages released by ALSA.
  *
  *   Therefore, freeing of already allocated messages occurs:
  *
@@ -262,10 +264,21 @@
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_device *vdev = vss->snd->vdev;
 	unsigned int msg_count;
+	size_t period_buffer_bytes;
 	bool stopped;
 	int rc;
 
 	virtsnd_pcm_close_ack(substream, false);
+
+	/* Fixed descriptors require whole-byte periods covering the buffer. */
+	if (check_mul_overflow((size_t)params_periods(hw_params),
+			       (size_t)params_period_bytes(hw_params),
+			       &period_buffer_bytes) ||
+	    period_buffer_bytes != params_buffer_bytes(hw_params) ||
+	    (params_period_size(hw_params) *
+	     (u64)snd_pcm_format_physical_width(params_format(hw_params)) *
+	     params_channels(hw_params)) % 8)
+		return -EINVAL;
 
 	scoped_guard(spinlock_irqsave, &vss->lock) {
 		msg_count = vss->msg_count;
@@ -608,6 +621,96 @@
 	int error;
 };
 
+/* Caller holds @vss->lock and the PCM stream lock. */
+static int virtsnd_pcm_playback_ack_validate(struct virtio_pcm_substream *vss,
+					     struct snd_pcm_runtime *runtime,
+					     const struct snd_pcm_indirect *rec)
+{
+	snd_pcm_uframes_t appl_ptr;
+	snd_pcm_uframes_t appl_diff;
+	snd_pcm_uframes_t signed_max;
+	snd_pcm_uframes_t back;
+	u64 buffer_bits;
+	u64 appl_bits;
+	size_t appl_bytes;
+	s64 queued_bytes;
+	s64 sw_ready_total;
+	s64 total_bytes;
+	s64 int_max;
+	unsigned int hw_queue_size;
+
+	if (!runtime->control || !runtime->boundary ||
+	    runtime->control->appl_ptr >= runtime->boundary ||
+	    rec->appl_ptr >= runtime->boundary)
+		return -EPIPE;
+
+	/* Keep the signed frame conversion used by frames_to_bytes() in range. */
+	signed_max = (~(snd_pcm_uframes_t)0) >> 1;
+	if (runtime->boundary > signed_max ||
+	    runtime->buffer_size > signed_max || !runtime->frame_bits ||
+	    check_mul_overflow((u64)runtime->buffer_size,
+			       (u64)runtime->frame_bits, &buffer_bits) ||
+	    buffer_bits > signed_max || buffer_bits % 8 ||
+	    buffer_bits / 8 != vss->buffer_bytes)
+		return -EPIPE;
+
+	/* Match the indirect helper's appl_ptr boundary-wrap calculation. */
+	appl_ptr = runtime->control->appl_ptr;
+	if (appl_ptr >= rec->appl_ptr) {
+		appl_diff = appl_ptr - rec->appl_ptr;
+	} else {
+		back = rec->appl_ptr - appl_ptr;
+		if (back <= runtime->boundary / 2)
+			return -EPIPE;
+		appl_diff = runtime->boundary - back;
+	}
+
+	if (appl_diff > runtime->buffer_size)
+		return -EPIPE;
+	/* The indirect helper advances appl_ptr even if frames_to_bytes truncates. */
+	if (!runtime->min_align || appl_diff % runtime->min_align)
+		return -EBADFD;
+	if (check_mul_overflow((u64)appl_diff,
+			       (u64)runtime->frame_bits, &appl_bits) ||
+	    appl_bits % 8)
+		return -EPIPE;
+
+	if (!rec->hw_buffer_size || !rec->sw_buffer_size ||
+	    rec->hw_buffer_size != vss->buffer_bytes ||
+	    rec->sw_buffer_size != vss->buffer_bytes || rec->hw_ready < 0 ||
+	    rec->sw_ready < 0 || rec->hw_data >= rec->hw_buffer_size ||
+	    rec->hw_io >= rec->hw_buffer_size ||
+	    rec->sw_data >= rec->sw_buffer_size ||
+	    rec->sw_io >= rec->sw_buffer_size ||
+	    (unsigned int)rec->sw_ready > rec->sw_buffer_size)
+		return -EPIPE;
+
+	hw_queue_size = rec->hw_queue_size ? rec->hw_queue_size :
+			rec->hw_buffer_size;
+	if (!hw_queue_size || hw_queue_size > rec->hw_buffer_size ||
+	    (unsigned int)rec->hw_ready > hw_queue_size)
+		return -EPIPE;
+
+	int_max = (int)(~0U >> 1);
+	if (hw_queue_size > int_max || appl_bits / 8 > int_max)
+		return -EPIPE;
+	appl_bytes = frames_to_bytes(runtime, (snd_pcm_sframes_t)appl_diff);
+	if (appl_bytes != (size_t)(appl_bits / 8) ||
+	    check_add_overflow((s64)rec->sw_ready, (s64)appl_bytes,
+			       &sw_ready_total) ||
+	    sw_ready_total > int_max)
+		return -EPIPE;
+
+	/* hw_ready already excludes device completions accounted by the pointer. */
+	if (check_add_overflow((s64)rec->hw_ready, (s64)rec->sw_ready,
+			       &queued_bytes) ||
+	    check_add_overflow(queued_bytes, (s64)appl_bytes, &total_bytes) ||
+	    total_bytes > (s64)vss->buffer_bytes)
+		return -EPIPE;
+
+	return 0;
+}
+
 static void virtsnd_pcm_trans_copy(struct snd_pcm_substream *substream,
 				   struct snd_pcm_indirect *rec, size_t bytes)
 {
@@ -670,7 +773,15 @@
 			rc = -EPIPE;
 		} else {
 			transfer.indirect = vss->pcm_indirect;
-			rc = snd_pcm_indirect_playback_transfer(substream,
+			rc = virtsnd_pcm_playback_ack_validate(vss,
+							       substream->runtime,
+							       &transfer.indirect);
+			if (rc == -EBADFD ||
+			    (rc && substream->runtime->state ==
+			     SNDRV_PCM_STATE_PAUSED))
+				return -EBADFD;
+			if (!rc)
+				rc = snd_pcm_indirect_playback_transfer(substream,
 							       &transfer.indirect,
 							       virtsnd_pcm_trans_copy);
 			if (!rc)
