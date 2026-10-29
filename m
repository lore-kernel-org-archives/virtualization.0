Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252657;
	b=5Ub/SWlqbotZV8L3TsQRCXSL5eG1hgKa8GYYaGhz/KZkEw5OV2qQBo7NgHGREx4P24O/
	 y2m7nmhYw3uABAKzOxJ4qeuydPFbOI7u3kfk2wodFUwyyxSd8dt/wkHiXOHy5+xPgGU4a
	 YBIT13VIrQP6rx0gKgXiWEClh/dX5cNlkxoKdzaBKi2u8BDDUoCKgCQXBpBRHGuFaQmxy
	 I2pwLmwhxg1c1i2+URp18rB75KN8hmx2lVvTSSRplyf/DyWmETdwrxlqg8t6PMJSzS3Pr
	 Bp/vwr1rYGdD13sxEJOI2N4AKXiRkqAQBTZOlrUQSYG63sjQO1dqyDXUyOe9a5ODrvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n9g1tKYzqW6A6/VclGCCUru0GVAqNvSf/Qi/8iraz/U=;
	b=ice2zN1SMG6HEsHUDYavVBQN5mkRfV7PVyCjnIJayW3hW7aJuA0IbStPgwvaxWuEH7it
	 3HwS4hlKud2GCfcLWHGOwPDx48Tz7h4x9n38KIFVcSo7xlUvgkHRExhvKnWiH/YPa9t9Z
	 pkvoLgqVCsgQf2ox5LlSQYysrr2rF0rbUOQpNB36ihl0AuCF9sMhMJ848UyF5itDQvp4v
	 L9lv1adM+2w1IQ7piL+uPJS0IXvk8hBqGHtp9eU5vCbHyeyAio3xgOgeFgdN6bmjJTiXu
	 g+vVdJmVPftBlQtVtHlNZ2BQUHY9TBkHioZ51cH90/9NMZa7/d4987L+9DAp1lxEGhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OsTzYGKc;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E130606A320
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E130606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OsTzYGKc
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e5378b281aso9271205ad.2
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793252656; x=1793857456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9g1tKYzqW6A6/VclGCCUru0GVAqNvSf/Qi/8iraz/U=;
        b=OsTzYGKchBIgQRVIwJxPiRXftTbFCOS0681IDrAfZILnq1dMXr01KMJDEPqR3R3XMB
         IkhCPp02wKOHWRKG5+yl17/SeuLAk49Ac/AR7DjGRZ+8OOit3wsKyCiXzmIfDRfM6MpJ
         tKswqFs26VAr/wo3Aq33dBJQ3pY63dhU3DQFdMOiu99ghtBysX7LEamlX4//9Upr7rEc
         bAnrj9mMWizN/qnOQ/xcuA8jG0kOwULniFfgJk1qxtLkJ0RtWsm8SR0rltuadzZe/jaa
         QlQWrgqc0Y4Xc5AeRlc2XXX/W2DDLm+ywxuktaI8P3ocrqKdlhx3bNhtrcklJ0ii0R6U
         Oemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793252656; x=1793857456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9g1tKYzqW6A6/VclGCCUru0GVAqNvSf/Qi/8iraz/U=;
        b=wJS50yphKW3oU2WkqyjXE49As30YvxBH9dfeUjpddH1imRoGgW/tBLFj5ZdsFrMtne
         BZZhLZ8kVOG/YbFCMNhQTII0LhgZBRautE59CfZmoj6uGotjn69h/SADNptDIDQuqa/G
         UToi8xc8CqVasY9OplZlxnmXEt2VgQePeyz1zVDUVcDMMzr5Nb0WCToTB8nQ7+F7eYja
         iXkTcHLKyD+aINkBWdUdi/zq/Dz0KtjWfJS3g1ywct9JsN0dgxnOq5iEBqAfiHxbnsOA
         3Q1wqlTCYO2aK5JoMX/O9aJS1FdtDBEbig9Azc/U/3RVstOFMhMjABSfwbwuFZLs6IuP
         eryg==
X-Forwarded-Encrypted: i=1; AKwUvBzFFUfc0XCQQXeX6S3qic2pr6MuP2tSWMFa3QTlivhjq2pN91V7WKOsSEryszL6Yf0JV6jmFsoU38fK8m+1Mw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKzcTW43eYI49X8UPoSTZ9DUor6GCxAG5iUD7ZJF/++iUrNAIEa
	6Zxl8VvEuWkWRilpxOrApWqx2yyDZ3AxoYh4kAFwOD/yd0wwwr3zU04vZ4nyuQ==
X-Gm-Gg: AYBFou0b8AEzLhf31P4jqjMybePHCPY0kdzBIXgeI42T1nhsLBGGu3I8DvDQpWqy0Lx
	tpyp5fPoaBTXOF0x+CgovKJLaGHsCae5aOcA0b4FxjCNmmKb6l5SZRWY00up1gWabjXf6zu6589
	473njLSLV4LDtfPO44xpSnDOs1VMgbjYNcAz3BOZ8lH1SIrV7Ekn3CHGYVm6BB+NwxrfAP8qBOd
	ms+ZLSYmXafVRdcP8/UFc+j7eS/CPWD2hEaLDvkd9+xUrOVgnYSKnMyA1fQN5ao95mso7JMUjUH
	+Du+NfWO664j67piPrPa5EIE6dTbhewytAva4KtK7yd0XHFtv2VFZLzBJWjUSU5V9oJ17TE/myl
	uT72BQx06FZvqbe+8WANGpgAMpMUFNsYF1R8ma4lfRY/ijVpMwu64gSCFMlxOZl/5SREAWeoBQT
	ffB1pGSpCNeY38y1U0BxkRgsTy3Aha/eXx+9/dbwhbVmfh+AIdQPXz45qmRTzv85wgfvnXyS943
	m0Kb9fNW7t+Url315AKrL4VMQhP3EuXsvZ1Vl+xf9h47oSyZDfMPgZY+iuNO5Z4PJbSbtx62hHX
	anU+Zmfn4xsixdn/Yx4VkKT5RbaN06p2jVMMk6VbOanZAZzZp9fxcjn4dFEoJVhVy6INQbDn4Wq
	/H/gzNIHA8l9W4Y71cLno8hZYNX/AA92pY58gpN/iAEE/Q8+wdnCq3zjH1cv0mR4/mHuK
X-Received: by 2002:a17:90b:54c5:b0:3ad:4bfc:1e77 with SMTP id 98e67ed59e1d1-3ae58195ed0mr3125643a91.66.1793252656280;
        Wed, 28 Oct 2026 22:44:16 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e83127csm2433520a91.10.2026.10.28.22.44.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 22:44:15 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
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
Subject: [PATCH v8 04/14] ALSA: virtio: Keep PCM DMA buffers alive through device ownership
Date: Thu, 29 Oct 2026 14:43:44 +0900
Message-ID: <20261029054354.2931-5-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029054354.2931-1-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
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
