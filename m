Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267686;
	b=1pc0xa6Y0I7mMK1K17Dvs2J/vB437Oggy3egNxJbRpehKOcBamAt1RHdXprwkSINbGak
	 rZRuaWCLFkDHL5gJai+p36yj3mHayoBjcPPJLIodzXf12gH40hEI0kxth/AkPgruZe8Qd
	 QUk12SK5GCbqwlx80wgWLpvwqMuoOO90Zj4KGUgT5w+4Uz17DCcSCE7Ib5JV6FLprRUk8
	 ayg+bwLT2xi3/fjc9fhDQq4KQ5Ex4CO1ftyh2yCrPBce4f15SZ76RhGCuf2Jl8AzKVcOZ
	 KIjlRZbglZEDOIE0F4U28Py7kg9oZ9d9banKZT8lIw3nQGp7MvsE97G5VeaD8FbMecw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v4jgtn3LxicURwQ+tcC9q6r+KSeE01D667aJem+AHPY=;
	b=F5HF+GbJ2HUu73CoATkzkAeVSM56MCf9BmSmhaChzida8FfVqTlUnFq7u7TSS+tYZkhV
	 Hnye+Gkf0NBeAIVQRG/6GX702tkN+S/MYsQWlQBC8wgWkuA6iPIB0+5LERtz7/m6duU4W
	 8eUHS1znPWvdos7IuoklUbEPQVhElPqXcuaIx8mP2PF5mPNHVaxrGIJqgZ417T3X6eMqs
	 dpaWNlUVLMAe2aMRic+Ofy5JOIEwLD/2ifVAg2iKYYfYD4f1jV50ej0ff0QP3loe0tEsZ
	 uAlKXdtTlhVvLQcpoVgF1DobkPzTqFEXNMDoxMlYzC32zHIO5vgWwue3I8wOb/4EpLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZXEJEtvK;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A78360A3806
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A78360A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZXEJEtvK
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3712b6d9843so1154364eec.1
        for <virtualization@lists.linux.dev>; Mon, 09 Nov 2026 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794267684; x=1794872484; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4jgtn3LxicURwQ+tcC9q6r+KSeE01D667aJem+AHPY=;
        b=ZXEJEtvKVu5v1x5yC2kzjsUM3U+MFbaQu/lNY1QHm99GMpIsIthZOFTi6Fu/mkM7Q1
         yh87sSo2wwJfK0UC4u6M3ViWVSMtMUxXQdQYVN6qBhTyp5QiD69IFGf/NIZ6h+mvnMs8
         H0yjgEwoGALrLYkTYBlo3aCrdid7ahrld5m/yKpJ29y90Bh8Cx5hOlTigb722DUHUJ1E
         ARV5MiN5w1RtfzNq0p5uawthJvOKtGGsCcNdbeQ7tHCJpFSq33eZXyB5gnFQOAXwqnwA
         +f1zr9ZeG1CRPz4x385EHqcWL7NU5JVMyJKO74Ke1NzLy7BXEpd/X8rBEVEjRiyl8Kac
         vNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794267684; x=1794872484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v4jgtn3LxicURwQ+tcC9q6r+KSeE01D667aJem+AHPY=;
        b=fbcU7wN4V5HXOBDDZ/pU9gYI6ZwKccEmb5mRtw5D26GSAzE91Ny/59sv67uGPDKIhk
         jKQPuT93HyL+R9qoCTUTy2VhGHj0xezVEco3nduwLJoUbtr3RUhXAD954tzO1Un2gcph
         BghfiauqOyiQoXbSCDvui7+jwavjwev4W2WnVqXZTGZDEyxd4dk8ekun/N+CBd4mS0L9
         sPhGLoBDvjvaTPrCRBjXAFY3JqMxTMfzbXX3JFHE1c66SnyivZ5g1GU+Encffnvx9pO3
         Oui1JhDmIobsmQT5IMAvKDJj4hT1qLzOBk8bklL6h4/J8F8iiCSeIph+gaYUdh1GqsYD
         jiRw==
X-Forwarded-Encrypted: i=1; AL+hErEuY668OPS8D8i6pCTFoMGZ1qpNEXtLbPFW/hyXOWx9elFNMxjiLqnSAHTr589PxOL49oLztr86SAeaD8GHdg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9o1wmz4nOXKgtq9cWX//NfFLO4+/YEmZCEIRr5RrBvsAcsWEYG
	ijA5GUoarOnaFLiCPlNYgoPIuBHab00CbYM05xd6XGRG6MooC4ld2cO6
X-Gm-Gg: AYBFou0PVajVw802Vdfa6+T5XuLPaXuMchK1InckjQvQgycYmvuNDM8nQcJ96uIvbuJ
	ETWWW+bR/RQTsrN29vYPrHvdJYtzo/RV3SgM7PtreT+N2/JOGx73rzsTGsecEE3THQhx23CmM45
	mX0kOSoOSR+XTkLACTb1SMK0LJQkb3njuOGUzP7Cn5Iq9gP1OCmYZ/WgpacnMCyP10VWTNlucVf
	5EC1Ay9djuZYZkfXD+scxRIUywjsb6NujEjnQ80PL0H/v7gTCCUZg/wXF5hVQ4xCQ0C0eQhC9Sk
	FKbnmfDuPhoaNiv97kSqqxhXPr3OutgfZA8FNJZildhHhRUStmOduPIcYlilRswS1LM8ZB/AAIO
	v/ENquWxfrjCUvGHCdJXbg13+r2QNuHnxFUUjC4CdibNx5TyaMJQvPLLly77XeIiDILh2O87pRL
	Nlu1lEzKwu37yo5AKimsQQzxzI0XFBL3yrj/jqGQP1nrfQfJm5lJproFhIiKTMK3vK5wTi9T5RF
	CeDF0N+eQns/DFWH6Bu1h92hTY8spSnP3YVMlzKAKMLwadsgl4RC91v/8kQGyDoae5g+XeTfC+r
	hv3DVLX3GuJkAnLFHdthCDhOe/95+fvJ3L33yBOSGUZO93emljT4bFXs0hCQ1seCu3bWo5G/GCr
	Hy90OETfdbyK/E99sI1RRGGuRhVBGsIcNAkfbJxrnqWIWcH4=
X-Received: by 2002:a05:7300:fe81:b0:36c:9af3:22eb with SMTP id 5a478bee46e88-375210e41a1mr994095eec.34.1794267684116;
        Mon, 09 Nov 2026 15:41:24 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe2ff5dsm1739049eec.5.2026.11.09.15.41.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 15:41:23 -0800 (PST)
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
Subject: [PATCH v23 09/14] ALSA: virtio: bound PCM transfers and retain DMA buffers
Date: Tue, 10 Nov 2026 08:40:44 +0900
Message-ID: <20261109234049.79534-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109234049.79534-1-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
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

A successful ACK must describe bytes that fit both the PCM ring and the
transport queue. Validate playback boundary wrap, frame alignment,
conversion bounds, ring offsets, signed ready counters and the combined
queued-byte budget before the indirect helper changes accounting.
Validate ordinary capture acknowledgments against completed unread RX
bytes and reject consumption before the first RX ring is submitted.

Retain references to vmalloc PCM pages until their message descriptors
are retired, including when a timed-out teardown releases the runtime
mapping. Non-MMU ordinary transfers use driver-owned bounce buffers.
Release these allocations with the message generation that owns them.

Check period and buffer geometry when applying hardware parameters,
reject out-of-range send offsets and lengths, and validate RX response
status and payload lengths before advancing the capture position.
Preserve completed capture tails during drain and report transfer
failures through the existing ACK and pointer error paths.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |   13 ++
 sound/virtio/virtio_pcm_msg.c |  303 +++++++++++++++++++++++++++++++++++------
 sound/virtio/virtio_pcm_ops.c |  213 ++++++++++++++++++++++++++++-
 3 files changed, 478 insertions(+), 51 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -13,6 +13,7 @@
 
 struct virtio_pcm;
 struct virtio_pcm_msg;
+struct page;
 
 /**
  * struct virtio_pcm_substream - VirtIO PCM substream.
@@ -29,6 +30,7 @@
  *        substream operators, including @stopped.
  * @buffer_bytes: Current buffer size in bytes.
  * @hw_ptr: Substream hardware pointer value in bytes [0 ... buffer_bytes).
+ * @capture_rx_seeded: Ordinary capture ring was queued since prepare.
  * @xfer_enabled: Data transfer state (0 - off, 1 - on).
  * @xfer_xrun: Data underflow/overflow state (0 - no xrun, 1 - xrun).
  * @stopped: True if the substream is stopped and must be released on the device
@@ -42,6 +44,10 @@
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
@@ -57,6 +63,7 @@
 	spinlock_t lock;
 	size_t buffer_bytes;
 	size_t hw_ptr;
+	bool capture_rx_seeded;
 	bool xfer_enabled;
 	bool xfer_xrun;
 	bool stopped;
@@ -68,6 +75,12 @@
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
@@ -199,6 +344,7 @@
 	guard(spinlock_irqsave)(&vss->lock);
 	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
 		vss->msgs[i]->length = 0;
+	vss->capture_rx_seeded = false;
 }
 
 /**
@@ -228,8 +374,15 @@
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
@@ -248,6 +401,33 @@
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
@@ -356,42 +536,81 @@
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
+	/* Only the next complete ring slice can extend captured data. */
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    (msg->data_offset != vss->hw_ptr ||
+	     written_bytes < sizeof(msg->status) ||
+	     le32_to_cpu(msg->status.status) != VIRTIO_SND_S_OK ||
+	     written_bytes - sizeof(msg->status) != msg->length)) {
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
+		    msg->length > runtime->dma_bytes - msg->data_offset ||
+		    msg->data_offset > vss->owned_dma_bytes ||
+		    msg->length > vss->owned_dma_bytes - msg->data_offset) {
+			dev_err_ratelimited(&vss->snd->vdev->dev,
+					    "SID %u: invalid capture buffer for I/O message\n",
+				vss->sid);
+			vss->xfer_xrun = true;
+			capture_invalid = true;
+		} else {
+			memcpy(runtime->dma_area + msg->data_offset,
+			       vss->owned_dma_area + msg->data_offset, msg->length);
+		}
+	}
+#endif
+	/* Publish pointer progress only for a complete TX or valid RX request. */
+	if (!capture_invalid) {
 		vss->hw_ptr += msg->length;
-	else
-		vss->hw_ptr += written_bytes - sizeof(msg->status);
-
-	if (vss->hw_ptr >= vss->buffer_bytes)
-		vss->hw_ptr -= vss->buffer_bytes;
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
@@ -442,8 +455,15 @@
 				substream->runtime->stop_operating = true;
 				return -EBADFD;
 			}
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+			    !vss->capture_rx_seeded) {
 				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
+				if (!rc) {
+					/* The full RX ring is reserved until userspace reads it. */
+					vss->pcm_indirect.sw_ready = vss->buffer_bytes;
+					vss->capture_rx_seeded = true;
+				}
+			}
 			if (!rc)
 				vss->xfer_enabled = true;
 		}
@@ -608,6 +628,163 @@
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
+/* Caller holds @vss->lock and the PCM stream lock. */
+static int virtsnd_pcm_capture_ack_validate(struct virtio_pcm_substream *vss,
+					    struct snd_pcm_runtime *runtime,
+					    bool *skip_transfer)
+{
+	const struct snd_pcm_indirect *rec = &vss->pcm_indirect;
+	snd_pcm_sframes_t appl_diff;
+	s64 unread_bytes;
+	size_t appl_bytes;
+	unsigned int hw_queue_size;
+
+	*skip_transfer = false;
+	if (!runtime->control || !runtime->boundary ||
+	    runtime->control->appl_ptr >= runtime->boundary ||
+	    rec->appl_ptr >= runtime->boundary)
+		return -EPIPE;
+
+	/* Match the indirect helper's appl_ptr boundary-wrap calculation. */
+	appl_diff = runtime->control->appl_ptr - rec->appl_ptr;
+	if (appl_diff < -(snd_pcm_sframes_t)(runtime->boundary / 2))
+		appl_diff += runtime->boundary;
+
+	/* Before START there is no RX data to consume or requeue. */
+	if (!vss->capture_rx_seeded) {
+		if (appl_diff)
+			return -EBADFD;
+		*skip_transfer = true;
+		return 0;
+	}
+
+	if (appl_diff < 0 || (u64)appl_diff > runtime->buffer_size)
+		return -EPIPE;
+	/* The indirect helper advances appl_ptr even if frames_to_bytes truncates. */
+	if (!runtime->min_align ||
+	    (snd_pcm_uframes_t)appl_diff % runtime->min_align)
+		return -EBADFD;
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
+	/* The RX ring reserves its full size; only the excess is unread data. */
+	unread_bytes = (s64)rec->hw_ready + (s64)rec->sw_ready -
+		       (s64)rec->sw_buffer_size;
+	if (unread_bytes < 0 || unread_bytes > (s64)hw_queue_size)
+		return -EPIPE;
+
+	appl_bytes = frames_to_bytes(runtime, (snd_pcm_uframes_t)appl_diff);
+	if ((u64)appl_bytes > (u64)unread_bytes)
+		return -EPIPE;
+
+	return 0;
+}
+
+
 static void virtsnd_pcm_trans_copy(struct snd_pcm_substream *substream,
 				   struct snd_pcm_indirect *rec, size_t bytes)
 {
@@ -670,7 +847,15 @@
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
@@ -696,6 +881,7 @@
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
 	struct virtsnd_pcm_transfer transfer = {};
+	bool skip_transfer = false;
 	int rc;
 
 	rc = virtsnd_pcm_ack_state(substream);
@@ -714,13 +900,22 @@
 		if (vss->xfer_xrun) {
 			rc = -EPIPE;
 		} else {
-			transfer.indirect = vss->pcm_indirect;
-			rc = snd_pcm_indirect_capture_transfer(substream,
-							       &transfer.indirect,
-							       virtsnd_pcm_trans_copy);
-			if (!rc)
-				rc = transfer.error;
-		}
+			rc = virtsnd_pcm_capture_ack_validate(vss,
+							       substream->runtime,
+							       &skip_transfer);
+			if (rc == -EBADFD)
+				return rc;
+			if (!rc && skip_transfer)
+				return 0;
+			if (!rc) {
+				transfer.indirect = vss->pcm_indirect;
+				rc = snd_pcm_indirect_capture_transfer(substream,
+								       &transfer.indirect,
+								       virtsnd_pcm_trans_copy);
+			}
+		}
+		if (!rc)
+			rc = transfer.error;
 		if (rc)
 			virtsnd_pcm_transfer_failed(vss);
 		else
