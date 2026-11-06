Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981948;
	b=rbo21SmZTseo6iEiu/ghmOzsFo8JPXRjNQ/dyeEEIqsSJ3Z8S5XbNqqwujbV0LaYqcKc
	 LkFVP6jxbUTfN46zrIk0A5ZpB52noMy5qVSC2gKIRZdCPGeZjOlEoYaEusAtioTFBsp9e
	 WOW+eo53hxBak7luWTuUTA4/BTog6a9PrkP9uRrlZkq79gYB5GhyHR6nrBSkhBT3p8/mR
	 MMhMmthYX6T14vXstjVpFMyTa0igvWuWUpdb+M20r/vXLfxEZwWo3A0kjzYH/zf/NS2yL
	 a4tOwyCfTgxh0lm+0EhxwC5XjuDuNfq6vdTzxXzS9tdhP0I/XzirZJJN+MvSBwBpfkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kIRHRKpmI6vYSEEVGp2u0oyp5rIlyTIsWQ0MTdM6dUc=;
	b=n7s1ewihzju+IKDansYXiLlOnIj9sGTh2whSuUEO0lbjO3SfLuEs/arPbyLsIgeJrcty
	 ic3ywaSI6x1zliGh1QNEw6BjJ/5cz59PDfRta2DyZR1xwxspVdwWO8keQm9o1zhCecUIm
	 9EzIRvylk7PE4hG53IM0q+4bH3rOeiphN5QWr466jX5lZAQlTqAFDE10okgsuTRcgH91F
	 r/fxbYlnGn5ZJlrIs+u/JyPeo96RmOla1mFF0w5nijzIRZBSq8RB+4rzNFErshw3ZD0hU
	 d6CjivecnNHKg4ZoHFwVw5m7j0amzYqi2l/+2atdXGB8Io1w2PfqyyZKjnx8epHAfvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vfR2M6TW;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69826082BD4
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 16:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C69826082BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vfR2M6TW
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1931ff67a29so2496102c88.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981947; x=1794586747; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIRHRKpmI6vYSEEVGp2u0oyp5rIlyTIsWQ0MTdM6dUc=;
        b=vfR2M6TWIEzD87YIRJFHK5qtgTTOqOJoVZnptCQxuIUeaLHk82rCbUMBLJIqj4mbdI
         qqATAF7IXo0KkAo11g8qQcJjUpq5Q+i4bFQnUbQY3ntJshL23MbTaqOw9dpkkrzKsGl3
         DGwD4NffTnw3KnvXEIydawutTtSyQxxhwma0eHBXR1XJ1svfJGhYKWey8Dt+PG2N0ef8
         xgdUOg5hvAK50rc6ifb/UZxWkdrrU4i5eBdybEPMS6AJBBIeewrs+p2lLpo0dMMCuc2z
         ufm0OFYXykULNjVnWk/sskmQIUqEXI1IpueUYBONtJlx3QoqmzNOfecxM3mXuUPBwPji
         y/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981947; x=1794586747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kIRHRKpmI6vYSEEVGp2u0oyp5rIlyTIsWQ0MTdM6dUc=;
        b=uUE+OrCYJXnmWP2Mviz8pBlErfoWAhi+aLU+r62P4wSKRzM8Vx9UW+io6dGanKYHYO
         LhXSTjVolMJgNxSIpxGz5bA8lVR06la+OnLQQ26vwyT0NwcUCOtXxdewaedLt4FSNBm0
         Sa8vFoBg3gJBJEXRS9LFvIQqVwp9JdLUF2WoDJSpTC+dQJd+e/L4wg8xcdLnHatnckgR
         JVnMWSM8gnnssits9HLqs5YLSS2kHOXzR7iX9CQyE490t93QE1m6ywmDdbkXZzh2/hEQ
         csUJ2KzMAfKp15CDUSl0dBtW6nRBYBTCX88e+vAMMFzXwp1ZDE1Xiw5X4xY/5/Onyi4D
         4FQA==
X-Forwarded-Encrypted: i=1; AKwUvBx50H+KcKS0KkxuAl/6HZ5ux49pC+d3ACUPc0W9/By6pbvPxry0tcXIl2IFLZJFFNLJm6MH9mx6A1sdLTAtdA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9DtPaeOw8IONT2vyqVeDZAnTzUN9Ezc1d619lewM/mBY9wyLCR
	lbkShK3ifVeURYdBe9cKj6yunekJvqigZogdbAfd0lm3E/dxX951Kdxf
X-Gm-Gg: AYBFou3U6X5ig17HSkuJQk/vfK9I1bomp0ndZOikSUL4Vvj2h6MkrYPgOSSW7SIfWYh
	y0hj2kziSjkgtYcaKZuhBZx8EW1ST4O2ExYb74xs0tlqCDWmrhmZEj7X8pWW4PYOKHaesbvCgB5
	8zvnKSQkn2E7J7ZHFbkliUFpjIgQqAbrTfFpTCxktDVcgPBBhfuY3oVefSmv7/E5S9ZEpYIhw8s
	/qYG7hs+cHS4KHIui9h8Rr6XZsNGaCTijMlvcAhLODdp7d/FXWq65yn0FuNVQbzhZb+sPxwwM3l
	zxMOy3fe6YIx2tzNNQB35GflGvTBKrh/3ddvajqTwtJUWROKHSckX4fSNJqeHVC6hb1RfQh8ai9
	5sNNE/EuvbIDR4xAq0X+WiQ31sM4zF8Nq4bq5nC7H6bn6dboML8/0dnWJMWp10ZOKPQ3GNqhEam
	ll2Ai+B4uI5zoJWLoU25I17JFwzQKGLDtWAw+mcZn76+HzPDumM/6NILHRWOPvUMGmVTD+n7WF7
	ZA20vKidyyA8PQ/BIgAXc2MA5H/htLunSb4AAq7krqydeeLW300kiYlnRFxY620lJroLtnmC3IX
	8xjkZlFbrz2AyN/a5GYn7VmJbeXZOu9q0t+Xc7CKcaVG8lVEM1pakEif95ofV75Q3+H1b+ZQlzL
	34maGa7taUpIRwgDOlUZn+JOw4kjMPoSbbUd9C3PFsX6FGg==
X-Received: by 2002:a05:701b:4194:20b0:1af:d88f:fc51 with SMTP id a92af1059eb24-1b25d3399famr3634582c88.30.1793981946586;
        Fri, 06 Nov 2026 08:19:06 -0800 (PST)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4840f3sm13139526c88.5.2026.11.06.08.19.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 08:19:06 -0800 (PST)
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
Subject: [PATCH v19 07/12] ALSA: virtio: validate indirect capture appl_ptr accounting
Date: Sat,  7 Nov 2026 01:18:33 +0900
Message-ID: <20261106161838.94308-8-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261106161838.94308-1-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
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
including late non-empty completions after STOP. If the source or
runtime range is invalid, retire the request and latch XRUN without
publishing progress for bytes that could not be copied.

Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for the PCM device")

Keep the fixed ring-slice offset available on MMU and NOMMU builds.
Accept capture data only when the completed slice matches hw_ptr, and
retire empty stopped completions without advancing capture state. Once
an XRUN is latched, later completions only retire queue ownership. An
out-of-order full completion reports XRUN rather than publishing an
unwritten ring slice; this path does not reorder completed requests.

Retain PCM DMA pages and validate full fixed-slot completions. Account the successfully seeded RX ring as full so completed capture data stays reserved until appl_ptr consumes it.

Bound ordinary indirect capture appl_ptr consumption to completed, unacknowledged capture bytes before invoking the indirect transfer helper. Reject nonzero appl_ptr advances before RX ring seeding.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_pcm.h     |   13 ++
 sound/virtio/virtio_pcm_msg.c |  303 +++++++++++++++++++++++++++++++++++------
 sound/virtio/virtio_pcm_ops.c |  109 ++++++++++++++-
 3 files changed, 375 insertions(+), 50 deletions(-)

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
@@ -433,8 +446,15 @@
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
 			if (rc) {
 				vss->stopped = true;
 				substream->runtime->stop_operating = true;
@@ -598,6 +618,69 @@
 	struct snd_pcm_indirect indirect;
 	int error;
 };
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
 
 static void virtsnd_pcm_trans_copy(struct snd_pcm_substream *substream,
 				   struct snd_pcm_indirect *rec, size_t bytes)
@@ -686,6 +769,7 @@
 	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
 	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
 	struct virtsnd_pcm_transfer transfer = {};
+	bool skip_transfer = false;
 	int rc;
 
 	rc = virtsnd_pcm_ack_state(substream);
@@ -704,13 +788,22 @@
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
