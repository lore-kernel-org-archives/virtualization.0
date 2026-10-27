Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144643;
	b=qW+9+qS0+HXXvkfw6OYvRdDKUBmENcko45Qgte8NjdHMebxxbLlMq4tFQl8c/iEBloJo
	 OR+1WMfVDPPeLjDPoddqEjf9BJb/poBO2udXasXMjh3pm929SvkPTebVR5zyi0h9M5Fqp
	 7rNhs2KpOr4SzVJ8TNh9X2uh7THhDe5KT3JvCK7/bo2nIeCIWC53r7xxaYrw2QuV7xge2
	 hdGPv26VmWcEW1ul9UF41MaYshjo7NMh5MRX5pfK/B4/07pC5tVFmbbVaPkCXHs3AsGEp
	 Q4Kj9YxyV6jRr/rHJ4m2YuEQ6DPqoCSmY1aXsdD2drGDp63vTQSIoNqJsYHJIWAJ9UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kyQytzBiZOGLqfGD6DAtOxP6vHxS9tRRyPEOmCY+8K4=;
	b=C9WYxhBgu/Xw/dEQqmKn9/mYY+Y44MAqiLxHKkCrHs4S2j0018uFhrYo57/eB0TUaz/d
	 K36rqRfbCwggjoa+5r5sUBIyoCX8am9iJJzgM3DWOv3Zdh/anDk2mzDnXuuHuraOpLLRg
	 85nwV9D9WvrCN+O+SGLj2hGEGOb7WMDVHErsMWuULu+OcVpnkf0M7dikZKRU+S8mlFDdu
	 29Tzx/raEyzAiqb7jP/Z5x2JxeUQwBctMbPGWtxpJ8gdTYQHXa1q6NIyLjVxgUL/qhiMC
	 Q8qRuZq9K35nAqg0gE9uhsBrxlPQeheTakFQlHljyNMDvDQr+jsmQ/NvTl8JccvlxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBSrzsKs;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E130606A31E
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 23:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E130606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBSrzsKs
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a05da1cc1fso175211b3a.2
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144642; x=1793749442; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kyQytzBiZOGLqfGD6DAtOxP6vHxS9tRRyPEOmCY+8K4=;
        b=sBSrzsKsubcLKr19F1PDHz7GdNB3jtQji/rs7ESjfwSiwwEYsb0T0Q+k+fUFkVJtXo
         UQdzxI6Tp2zJvKPbwh7RrcgEu5e8eKEHjkF9NgqkDYMS+YbaqLgdJUFxhB3YJzeGADH8
         AElYJvDiJzH94bDV6fZ6L7cm4ea6qJl1QCG77pl2WqYASZxUT77zL2+ML4BWT/2kE1xo
         fRXi9JE6yDtwFDFxCDCH4ZqJViZPHrAlP//1AYnSj2hqgTz++S9842vsIyiypCHlDhqC
         O+Rfj2xrrZnjsZuny5zEjkP/YZdJIjDPQhDJ20e8HCZNbpLWJh8IblQelrBJaLvJHJEp
         QdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144642; x=1793749442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kyQytzBiZOGLqfGD6DAtOxP6vHxS9tRRyPEOmCY+8K4=;
        b=jQTN/tu5srQrj2ym+2ti0d9at44WM2hbi18tqPXjGRMjhSR14V/9kcLoGAo/FfTfKe
         JbRKr9vUCILCQLaG2LLn36FP7pL56fmLTpD59uT3OEnWYktanAGv+HuBUNgPk9uIj0hP
         GfFvO0oZ2D0cwxSwUQP9+bp7xkr8J8THiDGZ4fA7/A9E/v1pIq9VmaWEClU1S6irkl6F
         CFhTfgjLcX3ap6HJPl/slg5/GqlzZg5/reCt77feMR50U/PUMGm6FersS4z/tuZBxxaP
         fzZNfF/QTTypabFxy124Gn/GDzVYLKWFbHVYKn9wCLCSaZ27dMG5JxH9O91dTdn1Klxq
         +NAA==
X-Forwarded-Encrypted: i=1; AKwUvBwoSDnbZX8IZpLZpbiI92ZJ5nVSW0/z0vW5Siek0Pj/neHlDY3pOQbrTZJw9gQIdFJGBWEhJSZfQu2LVOpExg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIUyLCQ+K1RaWTd/5gYVkare5ImCGpgLu9iVzFLDGaMWTLuzVQM
	IIDlCMN80icm7oRv8+hjWrdGVwijWX9zpemH8sWSOrOSDX4105Z4vKxN
X-Gm-Gg: AYBFou1vKSErMp2bADf94XkBu9jWgoekImAtsJvEW+L8PJpzIxeeTnEfR4BS/bj8TMh
	I1XlaJAlwn1zEutZH0gLsQoIBcrnxrr+IOxS6L3NaKWCSPQSxpUNvGutHuEwf035ND1evrMePMf
	VQfc1LTj8fAt2zodeM4eH5vxWmya1OCo79RL4ITkWDjk3Wu0FFxl4xiyasulM/Yg0f+AlHlj1ls
	r5eRphuf34kYBeZVukcFkDic6/303/nC5+uDQ8pz/URwyLfw/XYtl/HH0EeswPh0gQKM4fhhDT/
	yjOjoo966oxaXtHVF7Sz1S171lHaJ3FvoT2qFepZbnvdaAxdqezkoGlGM3lrixpoWI3+uUj4X3U
	Bd+JAd3+Hr7Es23nJH4rW9CTNkFuUtkim1rH1mcrGccJxpQB/dizGWhXJRSkmImMQCYoj0K8iD8
	0RO5v7nmKeo+3RFwgCq4pwpwiW3/XSPwF51WCLwSTwdg7nkSV5EZKAN/VRm/LvF/t0HDBSg9JrP
	OjLewIGLGGUFSNTVAgXBFcmxucENURcb+uY8qbmjxswIAfNeVWREw0xJB/+O41SlXjS4GvJLVCJ
	9QQ7mFS/lxHgjl1My7oWwFNfxD4wqFOCJFQxn0eLZkA/M9h8C8QIEyRjAYtfo+Iz3rbpQhqXCQ=
	=
X-Received: by 2002:a05:6a00:2d1e:b0:8a0:70d8:a2ee with SMTP id d2e1a72fcca58-8a6e9746b24mr457329b3a.60.1793144641852;
        Tue, 27 Oct 2026 16:44:01 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662b9f5sm542507b3a.21.2026.10.27.16.43.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 16:44:00 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v5 04/11] ALSA: virtio: Keep PCM DMA buffers alive through device ownership
Date: Wed, 28 Oct 2026 08:43:27 +0900
Message-ID: <20261027234334.32551-5-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027234334.32551-1-mynameisjune111@gmail.com>
References: <20261027234334.32551-1-mynameisjune111@gmail.com>
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

Retain references to the pages backing ALSA's vmalloc buffer until its
queued I/O messages are freed. On NOMMU systems, use driver-owned memory
for DMA and copy playback data before submission and capture data after
completion, so ALSA buffer release cannot invalidate an active request.

Validate the PCM buffer and each period before building scatterlists.
Clamp device-reported capture lengths to the message capacity before
advancing the hardware pointer, preventing an oversized completion from
accounting bytes beyond the buffer actually submitted.

Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for the PCM device")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Changes in v3:
- No code or commit-message changes from v2.

 sound/virtio/virtio_pcm.h     |  11 ++
 sound/virtio/virtio_pcm_msg.c | 252 +++++++++++++++++++++++++++++++---
 sound/virtio/virtio_pcm_ops.c |   2 +
 3 files changed, 243 insertions(+), 22 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index e31f090a0124..61faf7b13cbc 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -13,6 +13,7 @@
 
 struct virtio_pcm;
 struct virtio_pcm_msg;
+struct page;
 
 /**
  * struct virtio_pcm_substream - VirtIO PCM substream.
@@ -38,6 +39,10 @@ struct virtio_pcm_msg;
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
@@ -60,6 +65,12 @@ struct virtio_pcm_substream {
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
index 762480363b86..b7f2334bb221 100644
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
+ * @data_offset: Offset in the driver-owned PCM buffer on NOMMU systems.
  * @sgs: Payload scatter-gather table.
  */
 struct virtio_pcm_msg {
@@ -20,6 +24,9 @@ struct virtio_pcm_msg {
 	struct virtio_snd_pcm_xfer xfer;
 	struct virtio_snd_pcm_status status;
 	size_t length;
+#ifndef CONFIG_MMU
+	size_t data_offset;
+#endif
 	struct scatterlist sgs[];
 };
 
@@ -37,9 +44,8 @@ enum pcm_msg_sg_index {
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
@@ -47,15 +53,19 @@ enum pcm_msg_sg_index {
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
 
+		if (!pg)
+			return -EINVAL;
+		pg_address = page_to_phys(pg);
+
 		pg_length = PAGE_SIZE - offset_in_page(data);
 		if (pg_length > length)
 			pg_length = length;
@@ -75,11 +85,80 @@ static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
 	return num;
 }
 
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
 /**
- * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
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
@@ -132,36 +211,99 @@ static void virtsnd_pcm_sg_from(struct scatterlist *sgs, int nsgs, u8 *data,
 int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 			  unsigned int periods, unsigned int period_bytes)
 {
-	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+	struct snd_pcm_runtime *runtime;
+	size_t buffer_bytes;
 	unsigned int i;
+	int rc;
 
-	vss->msgs = kzalloc_objs(*vss->msgs, periods);
-	if (!vss->msgs)
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
 		return -ENOMEM;
+	vss->owned_dma_bytes = buffer_bytes;
+#endif
+
+	vss->msgs = kzalloc_objs(*vss->msgs, periods);
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
+#ifndef CONFIG_MMU
+		msg->data_offset = (size_t)period_bytes * i;
+#endif
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
@@ -177,6 +319,13 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
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
@@ -249,6 +398,33 @@ int virtsnd_pcm_msg_send(struct virtio_pcm_substream *vss, unsigned long offset,
 			msg->xfer.stream_id = cpu_to_le32(vss->sid);
 			memset(&msg->status, 0, sizeof(msg->status));
 
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
+
 			if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK)
 				rc = virtqueue_add_sgs(vqueue, psgs, 2, 1, msg,
 						       GFP_ATOMIC);
@@ -363,15 +539,48 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 	 * the hw_ptr value is unconditionally advanced.
 	 */
 	guard(spinlock)(&vss->lock);
+#ifndef CONFIG_MMU
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    vss->xfer_enabled && written_bytes > sizeof(msg->status)) {
+		struct snd_pcm_runtime *runtime =
+			vss->substream ? vss->substream->runtime : NULL;
+		size_t reported_bytes = written_bytes - sizeof(msg->status);
+		size_t data_bytes = min_t(size_t, reported_bytes, msg->length);
+
+		if (!runtime || !runtime->dma_area || !vss->owned_dma_area ||
+		    msg->data_offset > runtime->dma_bytes ||
+		    data_bytes > runtime->dma_bytes - msg->data_offset ||
+		    msg->data_offset > vss->owned_dma_bytes ||
+		    data_bytes > vss->owned_dma_bytes - msg->data_offset)
+			dev_err_ratelimited(&vss->snd->vdev->dev,
+					    "SID %u: invalid capture buffer for I/O message\n",
+				vss->sid);
+		else
+			memcpy(runtime->dma_area + msg->data_offset,
+			       vss->owned_dma_area + msg->data_offset, data_bytes);
+	}
+#endif
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    written_bytes > sizeof(msg->status) &&
+	    written_bytes - sizeof(msg->status) > msg->length)
+		dev_err_ratelimited(&vss->snd->vdev->dev,
+				    "SID %u: capture length exceeds I/O message capacity\n",
+			vss->sid);
 	/*
 	 * If the capture substream returned an incorrect status, then just
-	 * increase the hw_ptr by the message size.
+	 * increase the hw_ptr by the message size. Clamp valid capture lengths to
+	 * the actual SG payload capacity before accounting them.
 	 */
 	if (vss->direction == SNDRV_PCM_STREAM_PLAYBACK ||
-	    written_bytes <= sizeof(msg->status))
+	    written_bytes <= sizeof(msg->status)) {
 		vss->hw_ptr += msg->length;
-	else
-		vss->hw_ptr += written_bytes - sizeof(msg->status);
+	} else {
+		size_t data_bytes = min_t(size_t,
+					  written_bytes - sizeof(msg->status),
+					  msg->length);
+
+		vss->hw_ptr += data_bytes;
+	}
 
 	if (vss->hw_ptr >= vss->buffer_bytes)
 		vss->hw_ptr -= vss->buffer_bytes;
@@ -387,7 +596,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 		runtime->delay =
 			bytes_to_frames(runtime,
 					le32_to_cpu(msg->status.latency_bytes));
-
 		schedule_work(&vss->elapsed_period);
 	} else if (!vss->msg_count) {
 		wake_up_all(&vss->msg_empty);
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 970499fe419b..f74bf365065b 100644
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
-- 
2.54.0 (Apple Git-157)

