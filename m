Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202F29D291
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107126; cv=none; b=LHL6yF6+rid8fCkCp739UixTP2W4CDaKoJndJL+dlRHcUFlVfEVXy9yirPlDY32ecrTkRbN0kLKxSm8NNqe1sO3Pcj+5pJlCpE+ebeXvtbKhhu2Q+Le+2PPyG5bC3VkujUKRawUtBSB0lBQQcL8TVA+trBAc9DgMRqaqvn7IEOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107126; c=relaxed/simple;
	bh=T31JK0R2RoJnIzmzCTsoCEHIvFn+dWMXkWtQ8f/xR84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fb2le1/Psa94zjZKHpWt1Nj+bS2qYY43d1Gh0Ghv60cL133WzLpVxxbLfjhxQ+TjPRkdyc7lKs2Q9fXHarx846aAwleVPI3bjpLWwLSwURmjGRy1pkDt4UnlbDFl8qLFrtPzuU5eECMul5hFA41mBekNbFhRERHKiTzgEwGNhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=GbLT8UQG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="GbLT8UQG"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176d4c14f5so55571691cf.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781107123; x=1781711923; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ub62osLNDwHUKrBK1TwCuMDjmfhBT6YAzKGl5HkdoQ=;
        b=GbLT8UQGPwBZizBpSlI1o3x1z/dD/3A8i5c0ukZ1czonxgVZS8zBi7DN9zeB6iRS48
         ck4LkBhDCpbDCkNadb0KyxEYSxUkIjKVnFyxQ+XGmISut7bvJecV+0ikV0ohABER16gB
         VVubIrWQI8pgz8LhZ1YGmacJrwR9THp8T5uqL1DigNkm+M3E83bD7likeTUXHqRASixn
         nUknFpgHnCoLrYeSJuaNMWNP4vMQoBiH48RUCMzrskBpRiR7yS3WBK0mDF3ZDQLGejbb
         P4UO2PnaQX4XVXoRyqlRxuQulzskkCzfqCc0tAC6ZGE4388V/yPa/yBBV8LoC3LJxzPV
         v01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107123; x=1781711923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ub62osLNDwHUKrBK1TwCuMDjmfhBT6YAzKGl5HkdoQ=;
        b=B7HSuaJNhvRf5Ls7UgvPlaV3HkuaCAQWv5SFKNcCJkQ7mK0mOXDpF/0rK0HNgsQruk
         VL6Nrp1i7NWOHowjdNyPnZz4NIEJhXsiH60eOw9OPLsVUtM5rCvkxrgMbmduDh8zW1HG
         O2MngaRlIiBb4QnI4pHIRyjorUnWxYmKYha/PklUwGNoNm9fhg8kmpAk5H39exsorHzm
         Qlv1M5lBAFqOBfqLOQrwzr6Ruv2xelMb/VLNRybN1obYYsgkyQjh8OPr00vWmV9qlpip
         SrpD+XbNMs6SRh5GTfEfJVThIjRxm1a6SUc9dc4nb9LtEHz/mWXTT0vZLgXelWlSmY4p
         C3Pg==
X-Forwarded-Encrypted: i=1; AFNElJ/jF3mkyXCDCbzO9d+oQ2mQP4Y4jqfLeI+H1YQgPuD0hYmGFJ4PS3ybdXt5h55GIiCragwDlGll9y/8/sQ/Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfiLV/17VxWTnc4buBJD0OKvxanu5d834C0HVY4eJyMHYG7xua
	n5O2TqBwAv8kmaDJgQ5pLPjwU90nB5i7oSyD3qc6NiukN5WpnujEFvQy2UcC50QptQ==
X-Gm-Gg: Acq92OE7VZo9m2KAv9aov4+t5CXSIwPIXg4BRHIMp0kNL9nsnTbU12hj0vOnR+BcT8U
	Hl1Csip2jLZ29phdMTCpDOzRHyfATc5lg5bojv2DjRKRSedaETCZbCRSKA3zQ8qixuQMDWTP/9O
	jEePxuJ3uaOI1fEgdRr6Bs+eoP+s1orp/IU0PO1GW0ENTPugepgxwHmZIjhVEKrKQRzqmAPq7fC
	qG1KzRC5TlNhMPz/O+sd05IripeiQcrWnUdCVy0pf42P47IaF/0E2ADdvE0KkyZSclfaq6gDjkJ
	cSEv4zr6+40VzPZ19ipupZPrS/HjR6S3HnclGiCT23sZPNinCG5fx3K0nqeaivRrgBA/Yi+op9C
	OcCsi15Rbavr0DlKrTETZRicApHXy0x47kYsRxohtC4Jy2mpH91JSRv7vGuW/UeJvyozqAR2hk2
	3FE8cOPgtfKakc+DkME6hGYI0BxskDeACuHpQV5xWOCI6ZO0qmaGlGoYjMsTcTT7lF9ZK2gvL7B
	zuQPTPF4ZRpgBY=
X-Received: by 2002:a05:622a:6096:b0:517:917d:e3d3 with SMTP id d75a77b69052e-51795bbf2b1mr359199871cf.36.1781107123339;
        Wed, 10 Jun 2026 08:58:43 -0700 (PDT)
Received: from localhost.localdomain ([170.85.76.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fc7dsm239914466d6.5.2026.06.10.08.58.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 08:58:42 -0700 (PDT)
From: Gavin Li <gavin.li@samsara.com>
To: linux-i2c@vger.kernel.org,
	viresh.kumar@linaro.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	andi.shyti@kernel.org,
	virtualization@lists.linux.dev,
	Gavin Li <gavin.li@samsara.com>
Subject: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on interrupted wait
Date: Wed, 10 Jun 2026 11:58:34 -0400
Message-ID: <20260610155834.79207-1-gavin.li@samsara.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
completion wait") switched virtio_i2c_complete_reqs() to
wait_for_completion_interruptible() so a stuck device cannot hang a
task forever. That left a use-after-free: if the wait returns early on
a signal, virtio_i2c_xfer() frees reqs and DMA bounce buffers while the
device may still hold virtqueue tokens pointing at &reqs[i] and DMA
into read buffers. When those requests complete later,
virtio_i2c_msg_done() calls complete() on freed memory.

Waiting uninterruptibly for every completion before freeing avoids the
UAF but can hang the caller indefinitely if the virtio side never
completes the request. Performing a queue reset / device reset is
possible in this scenario, but adds complexity.

This commit manages the freeing of the xfer allocations via kref, and
ensures that each in-flight request holds a reference. This fixes the
use-after-free by ensuring that the virtio device has a valid location
to write to until the request completes. This will cause a memory leak
in cases where the device hangs, but that is much preferable to memory
corruption.

Additionally, force usage of a bounce buffer even if the i2c_msg buf is
DMA-safe, since the buffer passed to the virtqueue must remain valid
even if the transfer is interrupted. Remove usage of
i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directly.
All bounce buffers are part of the single xfer allocation, so there is
no additional allocation overhead.

Signed-off-by: Gavin Li <gavin.li@samsara.com>

---

Changes in v5:
- DMA-align all bounce buffers

Changes in v4:
- Pack bounce buffers into a single allocation after reqs[]
- Remove per-request buf pointer and xfer->num
- Remove req.msg, track message direction with req->read
- Simplify xfer release to a single kfree()
- Restore using j to track successful transfers in _complete_xfer()
---
 drivers/i2c/busses/i2c-virtio.c | 135 +++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec3..a5602865102d9 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -10,10 +10,13 @@
 
 #include <linux/acpi.h>
 #include <linux/completion.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
@@ -31,39 +34,80 @@ struct virtio_i2c {
 	struct virtqueue *vq;
 };
 
+struct virtio_i2c_xfer;
+
 /**
  * struct virtio_i2c_req - the virtio I2C request structure
+ * @xfer: owning transfer
  * @completion: completion of virtio I2C message
+ * @read: true if this is a read message (I2C_M_RD is set)
  * @out_hdr: the OUT header of the virtio I2C message
- * @buf: the buffer into which data is read, or from which it's written
  * @in_hdr: the IN header of the virtio I2C message
  */
 struct virtio_i2c_req {
+	struct virtio_i2c_xfer *xfer;
 	struct completion completion;
+	bool read;
 	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
-	uint8_t *buf				____cacheline_aligned;
 	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
 };
 
+/**
+ * struct virtio_i2c_xfer - a queued I2C transfer
+ * @ref: one ref for the caller, plus one per in-flight virtqueue request
+ * @bounce_buf_base: start of bounce buffer region
+ * @reqs: the virtio I2C requests
+ *
+ * Allocation layout:
+ * - struct virtio_i2c_xfer xfer
+ * - struct virtio_i2c_req reqs[num]
+ * - padding to dma_get_cache_alignment()
+ * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[0].len)]
+ *   ...
+ * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[num-1].len)]
+ */
+struct virtio_i2c_xfer {
+	struct kref ref;
+	u8 *bounce_buf_base;
+	struct virtio_i2c_req reqs[];
+};
+
+static size_t virtio_i2c_bounce_size(unsigned int len)
+{
+	return ALIGN(len, dma_get_cache_alignment());
+}
+
+static void virtio_i2c_xfer_release(struct kref *ref)
+{
+	struct virtio_i2c_xfer *xfer = container_of(ref, struct virtio_i2c_xfer, ref);
+	kfree(xfer);
+}
+
 static void virtio_i2c_msg_done(struct virtqueue *vq)
 {
 	struct virtio_i2c_req *req;
 	unsigned int len;
 
-	while ((req = virtqueue_get_buf(vq, &len)))
+	while ((req = virtqueue_get_buf(vq, &len))) {
 		complete(&req->completion);
+		kref_put(&req->xfer->ref, virtio_i2c_xfer_release);
+	}
 }
 
-static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
-				   struct virtio_i2c_req *reqs,
+static int virtio_i2c_prepare_xfer(struct virtqueue *vq,
+				   struct virtio_i2c_xfer *xfer,
 				   struct i2c_msg *msgs, int num)
 {
 	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
+	struct virtio_i2c_req *reqs = xfer->reqs;
+	u8 *bounce_buf = xfer->bounce_buf_base;
 	int i;
 
 	for (i = 0; i < num; i++) {
 		int outcnt = 0, incnt = 0;
 
+		reqs[i].xfer = xfer;
+		reqs[i].read = !!(msgs[i].flags & I2C_M_RD);
 		init_completion(&reqs[i].completion);
 
 		/*
@@ -82,23 +126,31 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 		sgs[outcnt++] = &out_hdr;
 
 		if (msgs[i].len) {
-			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
-			if (!reqs[i].buf)
-				break;
+			/*
+			 * Even if msg->flags has I2C_M_DMA_SAFE set, a bounce
+			 * buffer is required because the transfer may be
+			 * interrupted, after which msg->buf is no longer valid.
+			 */
+			if (!(msgs[i].flags & I2C_M_RD))
+				memcpy(bounce_buf, msgs[i].buf, msgs[i].len);
 
-			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
+			sg_init_one(&msg_buf, bounce_buf, msgs[i].len);
 
 			if (msgs[i].flags & I2C_M_RD)
 				sgs[outcnt + incnt++] = &msg_buf;
 			else
 				sgs[outcnt++] = &msg_buf;
 		}
+		bounce_buf += virtio_i2c_bounce_size(msgs[i].len);
 
 		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
 		sgs[outcnt + incnt++] = &in_hdr;
 
+		/* This reference is released in virtio_i2c_msg_done(). */
+		kref_get(&xfer->ref);
+
 		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
-			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
+			kref_put(&xfer->ref, virtio_i2c_xfer_release);
 			break;
 		}
 	}
@@ -106,26 +158,38 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 	return i;
 }
 
-static int virtio_i2c_complete_reqs(struct virtqueue *vq,
-				    struct virtio_i2c_req *reqs,
-				    struct i2c_msg *msgs, int num)
+static int virtio_i2c_complete_xfer(struct virtio_i2c_xfer *xfer,
+				    struct i2c_msg *msgs,
+				    int num)
 {
+	struct virtio_i2c_req *reqs = xfer->reqs;
+	u8 *bounce_buf = xfer->bounce_buf_base;
 	bool failed = false;
 	int i, j = 0;
 
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
+		struct i2c_msg *msg = &msgs[i];
+
+		if (wait_for_completion_interruptible(&req->completion))
+			return -EINTR;
+
+		if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
+			/*
+			 * Don't break yet. Try to wait until all requests
+			 * complete to ensure that the virtqueue has enough
+			 * descriptor slots for the next transfer.
+			 */
+			failed = true;
+		}
 
 		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
+			if (req->read)
+				memcpy(msg->buf, bounce_buf, msg->len);
+			j++;
 		}
 
-		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
+		bounce_buf += virtio_i2c_bounce_size(msg->len);
 	}
 
 	return j;
@@ -136,14 +200,31 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 {
 	struct virtio_i2c *vi = i2c_get_adapdata(adap);
 	struct virtqueue *vq = vi->vq;
-	struct virtio_i2c_req *reqs;
-	int count;
+	struct virtio_i2c_xfer *xfer;
+	size_t alloc_size;
+	int i, count;
+
+	alloc_size = struct_size(xfer, reqs, num);
+	if (check_add_overflow(alloc_size,
+			       dma_get_cache_alignment() - 1,
+			       &alloc_size)) /* padding for PTR_ALIGN() */
+		return -EOVERFLOW;
+	for (i = 0; i < num; i++) {
+		if (check_add_overflow(alloc_size,
+				       virtio_i2c_bounce_size(msgs[i].len),
+				       &alloc_size))
+			return -EOVERFLOW;
+	}
 
-	reqs = kzalloc_objs(*reqs, num);
-	if (!reqs)
+	xfer = kzalloc(alloc_size, GFP_KERNEL);
+	if (!xfer)
 		return -ENOMEM;
 
-	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
+	kref_init(&xfer->ref);
+	xfer->bounce_buf_base = PTR_ALIGN((u8 *)(xfer->reqs + num),
+					  dma_get_cache_alignment());
+
+	count = virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
 	if (!count)
 		goto err_free;
 
@@ -157,10 +238,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 */
 	virtqueue_kick(vq);
 
-	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
+	count = virtio_i2c_complete_xfer(xfer, msgs, count);
 
 err_free:
-	kfree(reqs);
+	kref_put(&xfer->ref, virtio_i2c_xfer_release);
 	return count;
 }
 
-- 
2.54.0

