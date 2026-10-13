Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4273AD513
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869451; cv=none; b=lKZJtS0WAbgGVLcKDuxWBFubejQws2qpDlTSlo1IGxz7Y30lgjkoA1VfldclBcDrvD1QszOm5yWMnJdm+VTzyj8J5myG4mQyDTQAJE7VAvOwTYCtv9qS1YU3ftjn6tGDUFZPDvhucq23WaECgVP3Hhi+AxlBebRazYNlyAktj2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869451; c=relaxed/simple;
	bh=AZpMcQVd242wNsymyeLV+kUSdiW8V59Q0tvwcs6k848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBWPgdk3ayCScJJO6Z6ZloZktkz9eAJadK7GJm2PcuiTyto2vnhyLQZ+enyr32JTxkWC8ABbn27u3KPnqOqAaiUbTUczarsfCqLooreKqRgiK+Tq1ygxPaDcJC3cxoReU73dkxBI4VVfuVWVlMqocg3iamXcpnJWAq4guIlAPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAwv4sC2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAwv4sC2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2dd76b1361dso14330115ad.1
        for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 22:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791869446; x=1792474246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgSlMltKjH9fZj/9bm3MvgD0zfBRnf6rS+vp3uicNHM=;
        b=ZAwv4sC2s7X/kFJCVL3zEPYGGk0YT2yyI9ZimIMzbtZjg0BhroIRpHNjYh+SapN4xY
         Y7sMtFPZW3loQtaX4sEdu18Ku3ER+BP/jEwxeBZPVN3cKnDdH+Kfd/3O6TmawbNOh61D
         bxNFPdoHgBPfAUwG5e+TBkr9fEtYWrRxI9mv0hbxnKG2CNbusX93xOUmdPbBPo5MN9Ra
         RYgaB/NIWkmSK/HQw5vXY6/7J5q5F3FFznjylm2WcGyqiZ2lnRGur59l9RWVD2XkGFzg
         4tjsn4u3pm0jSksEwkUK2tim+WwXiOOHXA1kTyGiMqkaiJHyjqZioO78MM9XkiApfKbK
         cC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869446; x=1792474246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mgSlMltKjH9fZj/9bm3MvgD0zfBRnf6rS+vp3uicNHM=;
        b=WFSCdKFKd2jVQaHAulWfE0yOq9Mjlj9SvSlZa0DJQo2nLAN3zULJu9bu7sdDhaVvUK
         qk/b+Jf0HCQXJPbYNvoLiOqGvO7PU29wWAkpausdzFrjvHypKh32B72ikBGCCvoXL3bu
         1FmXiHVMYdLjpQxDSkV1f5u8lVtTqFH2KWJ/pVpUegHcZaUA32/yPLNUffEEhGs7Qhos
         wNBvPhHd8CWnv9orVDn1YgqM9Fu3+kdyWGJKeap44BO7eP+ztxWEalfuYBnGFYVAVHz8
         URU+wqTDermTTCmM033VdMYxVp07DCuf8wxOnZWkIrvCdV8+NF4YhNh4EmJzAaxrXual
         L2hw==
X-Forwarded-Encrypted: i=1; AKwUvByq4J2Rh+u8J83s7HCqTju4T1NLOMpDiaMMfDLR7HXz33tgb2oxmCaWVgtiwF8ujqVkv3n6CN/WiaGVjLAqLA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJXSkILJrz/SBVfCJ9e58GjL1nb8/IiI/zfB9ZjI00U/1vNLPWA
	Ax6dtfbFqI3EAoiKbeGgXYEK2HBJthKkPNOIWUkkQjVj4oPQR24K9Of+
X-Gm-Gg: AYBFou0D71wuCtoSKPcl4lPBn/Zr5B4v8EnXXkPP7UB9KcBl2mBAuqJoVjf/hOZa/bO
	N3WhTBAQGDAK/HAxW9Nyp8YnMj2X7ySs04P389uQHzDNwMjlmkNqjIJmW/IZqK/TPO7fshZM/hB
	Ufwg1ZbvMhlrxJL673WOfa2zHEeTgQe2ITL8Izzlb+J6efWinv1w9AEoxntyubWBmaYn2ql+yG9
	XLdrNzs7Ua7FdKXMhkukKG7lfHt0WSaEU0raAIyGLljRPdtPnhMxHgjPprgYdvYy5jHKRSn3tyX
	+wkKSLY6d20eVQ4BQ4YerXIZQWxFh9NLqS56kbUe1+tFH5LHaKPu3Qhw8psTb8GrziG0GldOSJr
	wd4zkye4wpIgRfzAXj3SHygxvGVxtxrSDEOKC/thNTY1U3YBF64Cex10zSdt553OZjx7Gi2ViTI
	jB6b+VlKXHXALLcrF0mvtN4xzWlJWpJyF8HX1EOZknjsYfPb+BsF9XHbcIRBqz9VGrJ2DDwblwu
	5puJ4z/BQuPmlrbiJMHE7ncQpUA+LihnsOd7FywNZepZISGieifEQmJuEIbKNv+l1754ym4fBVt
	Fu8jX+CEFNt9eL2K
X-Received: by 2002:a17:903:3c45:b0:2e5:64ad:2da4 with SMTP id d9443c01a7336-2e842e0b50bmr113874005ad.56.1791869445546;
        Mon, 12 Oct 2026 22:30:45 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm50820915ad.60.2026.10.12.22.30.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 22:30:44 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Takashi Iwai <tiwai@suse.com>
Cc: Joonho Lee <mynameisjune111@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] ALSA: virtio: Retain PCM DMA pages until messages are freed
Date: Tue, 13 Oct 2026 14:30:25 +0900
Message-ID: <6b6421f719a49ce0195c3d43f58b50e40a6e9347.1791867377.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCM I/O scatterlists point directly into the ALSA runtime's vmalloc
buffer. If RELEASE or queue draining times out, ALSA still frees that
managed buffer during hw_free/close while the device may retain the
queued descriptors. Keeping only the virtio_pcm_msg objects alive does
not keep their backing pages allocated.

Take a reference to each page backing the PCM buffer before building the
I/O scatterlists, and release those references only when the messages
are freed after device ownership ends. This keeps late device DMA away
from pages that the allocator could otherwise reuse after ALSA releases
the vmalloc mapping.

Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for the PCM device")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Validation: separate ARM64 W=1 module build at this commit. With the
full series, delayed capture completion passed two KASAN/QEMU runs;
the tree through patch 3 reproduced freed-page reads. Playback late
access and allocation-failure paths also have ASan/UBSan shim tests.

 sound/virtio/virtio_pcm.h     |   5 ++
 sound/virtio/virtio_pcm_msg.c | 110 ++++++++++++++++++++++++++++++++--
 sound/virtio/virtio_pcm_ops.c |   2 +
 3 files changed, 112 insertions(+), 5 deletions(-)

diff --git a/sound/virtio/virtio_pcm.h b/sound/virtio/virtio_pcm.h
index 8837dfc12828..56ac2769b05b 100644
--- a/sound/virtio/virtio_pcm.h
+++ b/sound/virtio/virtio_pcm.h
@@ -13,6 +13,7 @@
 
 struct virtio_pcm;
 struct virtio_pcm_msg;
+struct page;
 
 /**
  * struct virtio_pcm_substream - VirtIO PCM substream.
@@ -38,6 +39,8 @@ struct virtio_pcm_msg;
  * @msgs: Allocated I/O messages.
  * @nmsgs: Number of allocated I/O messages.
  * @msg_count: Number of pending I/O messages in the virtqueue.
+ * @dma_pages: Pages backing DMA messages, retained until messages are freed.
+ * @ndma_pages: Number of retained pages.
  * @msg_empty: Notify when msg_count is zero.
  */
 struct virtio_pcm_substream {
@@ -60,6 +63,8 @@ struct virtio_pcm_substream {
 	struct virtio_pcm_msg **msgs;
 	unsigned int nmsgs;
 	unsigned int msg_count;
+	struct page **dma_pages;
+	unsigned int ndma_pages;
 	wait_queue_head_t msg_empty;
 };
 
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 5371f4985fd0..46bf4df65974 100644
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
@@ -75,6 +78,73 @@ static int virtsnd_pcm_sg_num(u8 *data, unsigned int length)
 	return num;
 }
 
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
+
 /**
  * virtsnd_pcm_sg_from() - Build sg-list from vmalloc'ed buffer.
  * @sgs: Preallocated sg-list to populate.
@@ -133,22 +203,42 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 			  unsigned int periods, unsigned int period_bytes)
 {
 	struct snd_pcm_runtime *runtime = vss->substream->runtime;
+	size_t buffer_bytes;
 	unsigned int i;
+	int rc;
+
+	if (vss->msgs || vss->nmsgs || vss->dma_pages || vss->ndma_pages)
+		return -EBUSY;
+
+	if (check_mul_overflow((size_t)periods, (size_t)period_bytes,
+			       &buffer_bytes))
+		return -EOVERFLOW;
+
+	if (!runtime->dma_area || buffer_bytes > runtime->dma_bytes)
+		return -EINVAL;
+
+	rc = virtsnd_pcm_dma_pages_get(vss, runtime->dma_area, buffer_bytes);
+	if (rc)
+		return rc;
 
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
+		u8 *data = runtime->dma_area + (size_t)period_bytes * i;
 		int sg_num = virtsnd_pcm_sg_num(data, period_bytes);
 		struct virtio_pcm_msg *msg;
 
 		msg = kzalloc_flex(*msg, sgs, sg_num + 2);
-		if (!msg)
-			return -ENOMEM;
+		if (!msg) {
+			rc = -ENOMEM;
+			goto err_free_msgs;
+		}
 
 		msg->substream = vss;
 		sg_init_one(&msg->sgs[PCM_MSG_SG_XFER], &msg->xfer,
@@ -162,6 +252,15 @@ int virtsnd_pcm_msg_alloc(struct virtio_pcm_substream *vss,
 	}
 
 	return 0;
+
+err_free_msgs:
+	virtsnd_pcm_msg_free(vss);
+	return rc;
+
+err_free_pages:
+	virtsnd_pcm_dma_pages_put(vss);
+
+	return rc;
 }
 
 /**
@@ -177,6 +276,7 @@ void virtsnd_pcm_msg_free(struct virtio_pcm_substream *vss)
 	for (i = 0; vss->msgs && i < vss->nmsgs; ++i)
 		kfree(vss->msgs[i]);
 	kfree(vss->msgs);
+	virtsnd_pcm_dma_pages_put(vss);
 
 	vss->msgs = NULL;
 	vss->nmsgs = 0;
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index f2362f0dd80a..82f2d2f9dd64 100644
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

