Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837388;
	b=W16kfU8zVIQEqqUx0rOiAgplYWDzUIAbjDXlde8Ujzo6p4hlh9C+McYp5BbDxBHzM4Mp
	 bXJHJmm0vsTwLgEgTW0YwjeIYr0NtI500y90Ae8F+pUekRlaVhwnwJObnN6GZTTcxetm9
	 wuPyVhTt9GdvTZV4/WzPQx4pO8CLQm6ZNu0WlXw9grKIpBld04kc1OLv+eJJX+XsClEAr
	 oEkhbsZunTxLiLeykvsdisbZty9wMtk6va58lbXz2Jq2LghDOohnd9b0JkvDS/1QmIyc+
	 BQ0LJkp55+jdVXAHnmP+3Wv+iMBDMK5fBcOBSSxCRVXWQzI1+mRPk4BHBVr1OrzICEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ou5DTxFRIAfZgr9oN+TY/le3J9DrhMtumZQqimzQ6q8=;
	b=X+YtnFXOWw5KGm9Iic8IlEj9G6P12wtz5SMh7Qeojkcdm9cRg0ol7Ug9yTLe7vYUI/tM
	 1gIzN4V/hI2hvEabtyluH6jobJIGzIw77gjlvzulEvpShlGz5aIbQn5poOLuHVXJ0hreQ
	 vro9UBPy8Hqvw778sJZ7NrJdRn7qw9DzN0MQTCDCC8ZftwhAF4/ft6rTr7umWuxq9NHOZ
	 /h54L5cGNcikB89lGkuBJ4QC16Jw4s4sXGoPHKwvSaRogEujUED4d9xuzB7aTWWN7B4OR
	 scdbW+Dn/aXXlxiDqaFLA3mfy7jZaH/zABGBDxjMJPOTYr+tUizjwdQtyEb/jIjxLfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L3pnxTpo;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96B606D82B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC96B606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L3pnxTpo
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so142684a91.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837387; x=1794442187; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ou5DTxFRIAfZgr9oN+TY/le3J9DrhMtumZQqimzQ6q8=;
        b=L3pnxTpo6JPNt0nSVvQ4j7Q5bAjAmBcStuvWZvjfd9auWHfAuDGwFZemkJQ8g3GxD7
         RfT8ADDDhEPQ+W5BM9mwqRp12jibDkhc47FtjojgqhtVTHTD7jAGLFKBaRNfff01iZwC
         QMSexVvulcbGTRUyt++8khKQsfJAoTYR/twUOIS5ENufSTInjHbOhl3yMYcoYgRpxXYm
         cKeaEioS2RWojWUYxy4vVVh2/dZetBYGuZr4lVnMvFGpkOAF4BHalXwqiSgxSVlZKrU5
         uRuUi2uxVFk6/kqcImI53DXBZXxFjE00ZgF/DfGZQVz+z67iy5k3u02AVaGbmpBq+EIS
         pNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837387; x=1794442187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ou5DTxFRIAfZgr9oN+TY/le3J9DrhMtumZQqimzQ6q8=;
        b=jHK4GngpFNQKG6K5TWysh2DH74i3EGCgfvnm/sBT9mhwn0fITPATD5WHWlEV6fPYcr
         CqbFGequ7ODxBiI7L2jyMZlwOw5rY8F6jqOWlV15IlZJxe+z29eJru3vDc5IyHOCTrD5
         tQA+qfRFACSfAUTF4mpfQjLpZyn+bIBeLgyWpTWmPoYXG4hHCrEdN4fVF5TVuJSTkyns
         Jbku1VefZbdq8PasLU/9jLly2hYQQ8ZRFuCULBV5J4I3lY87zyaKrxKobGwy/K81WZ5I
         rQYsVndxDn421j4rO3Y3M5HRN50TBg00o5sCZJDjUyUsXw/0x+yuFARMXQKTSdXZ3iP1
         4iRA==
X-Forwarded-Encrypted: i=1; AKwUvBxb/wuUXFjOMwA+jQw5X0zzzxVQb+fEyaLpAOm+ipkW8JYnN0O3qCiVMLaz74uGhDf+cSOh7+3je0OtgRf+iw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yMw/qSvV13E4uL+vrFHmZKAKL/SL18yfdDbBDuDpxzvYFq8eS
	JzxARTMDpOizS8/pPqDHXzFq+TGjFsdXpKbN7Fy9eW7NIrDE7sNvpHSf
X-Gm-Gg: AYBFou2RFDvcDzV15eBFumpzi/3j2l+eubBe0LQ15Rh9Z0BxWjXuA6EdXN8yxur6z+b
	lxMe830029zWv/nEoiLmZkqOR7EFNvkz3vcqFuRfOI98oCo1mcUguBlII+jGBemyQpKTn6HqTwy
	QsmMBfrjMuPlG6rweqrepswvDyBZwGPz3zYyMMCMO6iypDouz1NeCis1w8lp29FmcZdZY08BFmR
	u8bF/POwLz2b+evrH9OAUcXH7UkGqWbYiCmlh2lZdAJd6ljX6EExtUEj33/vlVx7jzlxc8KVrCC
	+1LEkvR6TPLfS3fDnJgZ4/jPG4BbTjdM9nr18bgYU5zTrdFkiq5b/PIhSYKBG01ID9frXgWQyAo
	abhLgQDYGzMmPh7FoJIBdF5WLlHtzdsvE83ShFkri+izeXSgGt+whK+HUzcSSqjs1xLq2cKt03S
	s2LMjo+n3wd+7kyeB8G7jiDZagnLizjieBlMzrPAzVmTSbpYrlVNlwKILa5OG/qHfyZcxtEMqqJ
	9WNkiekWOcBgx1f9dzlOpQ76KinAoUNaJJRO3gwLbTlR7vrd8yfjRcTPj1v6SM82MdA3YOX4Fzx
	rpfJnb27CVWlL+7T9s+urGJlPeVIzY+lfp6PCrHxlI1GsHZoHBxRJR+twgPN2ib1mEUTG5f/i3b
	YEwYjCSx26gjEHDC2Hm5KBPaIK2JwjIKeZ7cqmCGqT2jStA0=
X-Received: by 2002:a17:90b:580d:b0:3ac:7378:be04 with SMTP id 98e67ed59e1d1-3ae891717d5mr14589236a91.0.1793837386956;
        Wed, 04 Nov 2026 16:09:46 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.09.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:09:46 -0800 (PST)
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
Subject: [PATCH v15 07/12] ALSA: virtio: Keep PCM DMA buffers alive through device ownership
Date: Thu,  5 Nov 2026 09:09:10 +0900
Message-ID: <20261105000915.15177-8-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105000915.15177-1-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
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
Require a successful full-period response for ordinary capture before
advancing its pointer. Each descriptor targets a fixed ring slice, so a
short response would expose the unwritten remainder as captured data.

Require whole-byte periods whose total matches the negotiated buffer.
Check offset, length and the final message index before indexing the
message array, including empty transfers and arithmetic wraparound.

Seed the ordinary capture ring once per prepare. Native STOP preserves
queued requests and unread samples, so PAUSE_RELEASE must retain their
ownership. Re-enqueuing the entire ring adds another period to pending
message lengths and exposes unread DMA slots to the device. Return
consumed space through the existing indirect ACK path.

Copy valid NOMMU capture payloads while their runtime is still prepared,
including late non-empty completions after STOP. If the source or runtime
range is invalid, retire the request and latch XRUN without publishing
progress for bytes that could not be copied.

Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for the PCM device")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |   13 ++
 sound/virtio/virtio_pcm_msg.c |  306 +++++++++++++++++++++++++++++++++++------
 sound/virtio/virtio_pcm_ops.c |   19 ++-
 3 files changed, 295 insertions(+), 43 deletions(-)

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
+ * @data_offset: Offset in the driver-owned PCM buffer on NOMMU systems.
  * @sgs: Payload scatter-gather table.
  */
 struct virtio_pcm_msg {
@@ -20,6 +24,9 @@
 	struct virtio_snd_pcm_xfer xfer;
 	struct virtio_snd_pcm_status status;
 	size_t length;
+#ifndef CONFIG_MMU
+	size_t data_offset;
+#endif
 	struct scatterlist sgs[];
 };
 
@@ -37,9 +44,8 @@
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
@@ -47,14 +53,18 @@
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
@@ -75,11 +85,80 @@
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
@@ -132,36 +211,99 @@
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
@@ -177,6 +319,13 @@
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
@@ -199,6 +348,7 @@
 	guard(spinlock_irqsave)(&vss->lock);
 	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
 		vss->msgs[i]->length = 0;
+	vss->capture_rx_seeded = false;
 }
 
 /**
@@ -228,8 +378,15 @@
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
@@ -248,6 +405,33 @@
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
@@ -356,42 +540,80 @@
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
+	    (!vss->prepared ||
+	     (vss->stopped && written_bytes <= sizeof(msg->status)))) {
+		msg->length = 0;
+		vss->msg_count--;
+		if (!vss->msg_count)
+			wake_up_all(&vss->msg_empty);
+		return;
+	}
+
+	/* A non-staged capture request must return its full payload. */
+	if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+	    (written_bytes < sizeof(msg->status) ||
+	     le32_to_cpu(msg->status.status) != VIRTIO_SND_S_OK ||
+	     written_bytes - sizeof(msg->status) != msg->length)) {
+		dev_err_ratelimited(&vss->snd->vdev->dev,
+				    "SID %u: invalid capture status or length\n",
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
@@ -260,10 +262,21 @@
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
@@ -433,8 +446,12 @@
 				substream->runtime->stop_operating = true;
 				return -EBADFD;
 			}
-			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE)
+			if (vss->direction == SNDRV_PCM_STREAM_CAPTURE &&
+			    !vss->capture_rx_seeded) {
 				rc = virtsnd_pcm_msg_send(vss, 0, vss->buffer_bytes);
+				if (!rc)
+					vss->capture_rx_seeded = true;
+			}
 			if (rc) {
 				vss->stopped = true;
 				substream->runtime->stop_operating = true;
