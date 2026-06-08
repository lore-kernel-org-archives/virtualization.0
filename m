Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E1352012
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940689; cv=none; b=A96Xyzc82Wfe0O/vWqCU0eUeH9xChUWv3YkfFT66Mc5dWhqtFAcUssuk7LDMUBeUUiGRHD2Q19ajlx16vbhqc+HLmxhp5Ix07kodJJz/kIQjZhBOzXkq11iwYninhkSyncyEO8L42pVsmXDKbsqyyXZg4GFktXq+n1ZdRPaa7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940689; c=relaxed/simple;
	bh=OhU4AxzBAhYZv/SZor+DR/lP7Px9D5NTpnT7bDJT5Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCjk/UPpfPfZLCzl7eaIa9JmPmx8IReic4x4dl7rAOv4z/Dtb1PkO1J3nKcTHltsq3dP5JvZV/LWp8+DpaFZ8qICGoVK+Y1FWA1P77zPglwW6BinexjZgyYJHc4u+lyZwDxCx7bnVakPUn8A8XdD95gpxbdgyKjAJ4EpyNZuXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=BAPdODIj; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="BAPdODIj"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91591f19716so584523885a.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1780940686; x=1781545486; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dm/d3Jnd6Hr4BxVQhy9XpRcA4KLKCPKP1lviiVOsRhs=;
        b=BAPdODIjB9utLC6oEJQ8aS5RrLsHUIuPRk3ReXcVoibQ8TgaMG/yrKq44wobYcU7qZ
         p0LfnHxycuKY1Mu4eKxZAvymRI2ZHCWOq4HtCgPjMipXkG9A7bILNpW2addIRGRCIjj8
         HcO4ji2HACOcEE3PcR3QE9xX19KLoBfcekGzN4sVLPPHHgAs/GbjALlPZeDACywq8Sdr
         LmEDyoeFgxCezAdaWeYSVMDUZdwMWyBYxK4ma/KnTUFsoPvj8ioCuw+JcDvJCnvBTNZV
         oh5o9o2vE0eaSRZ2yA+i52PnHUG+eTsBTcD2/LubZxgR7syTn7cwhqm+UsWcNGIm9OPN
         y9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940686; x=1781545486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dm/d3Jnd6Hr4BxVQhy9XpRcA4KLKCPKP1lviiVOsRhs=;
        b=O2FYOq+I8jHxOoEXaLzMji8IbIOWNcqklbTOHFhfhZ3vaoh+O+V4WGTyYGdqkz4snm
         hMnYNkHHlwg6oIwVcEq9b2A3Urwle8qFaF6GT1T31OKztYIFL3yVkF75MvGv1JIYg2PX
         DA93B+e4MQKtDb7T/w/If2mGjxb9HN/sYgBgRXVTMkF/1nljzkNAbo5zZa/0yz9EtPFr
         LSXEJ09E2Sypa099OK352FYF4Yx5R/mEXuSYu4R4yFsQgx8hwdxANHuw5RM7emdloC4j
         cFWsRq+Ms8tTPxOwtPZ+l5ODpKYdaDv09bHRRwdNbz9YVxLlyn2/XMf+qRWj9lcKWW42
         gMyw==
X-Forwarded-Encrypted: i=1; AFNElJ/Eq1nLkRaN7aWWWzAUraCtIAtXjwOI2HH+nsvxHGc6yI2uDt5zg0YhRPkk5XoCjPoHCBmLTBt+NKEi70JRxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNMUx5vV0Eyu6F1GrutP82YCkxbLTyz6DKw3xKPg54usQCiDGw
	V8Y/1Qs4p5wTRB2v+VgpJh1QeOSmC+xW7zznBO5lL1kKivMpIpMetfdWekoM4ruJnw==
X-Gm-Gg: Acq92OFBPQQkeimmDVR4KRfHFYj0vfD5wm7wSQjqjxzjdRe/y91Io7slCqVPCn2HpZ1
	tsLnn5r/VXHQ+AXrvlnVwmUz5tR90YSLzzwbo8H7H6IaTFTil1obr0WxRiVf3ZXXNuODHl7UZbK
	m2Sbj8um6f5iz8OYtjHUUPFaJq3FJPfpbs7nmN0mAVY+AqbCgh4HqxyuL6jL8WJJRJdAgHvBwdG
	ci1NGvh9qSGJtYXdTKez0wrdNQGJ4EsBfN+MDXc/rCSy5+6nx+vA36Mj3y8sffGlBtCHKzf0y+b
	JMY+ATWgaY809kdjCdafiHX8/fyFC6i0Ej3Q7kTrHp426mVRTR9rcaMhRROHFi77aEOE6JSDb//
	c6nzFcfLt5XBaoIaOUapzsMD2QPTKNLzAWNOt9YvmEu3Qs+yH1SOgHrR2yh3uuX08dcnskAALsf
	MN5B7nsurraKyeMQ0yNq6lPWPkubjYCh5PGDD9Hwmaz/hWpYUygyDIWA+NmFaDbicdzTejBnMlR
	fKhVwyBD4Fid/Q=
X-Received: by 2002:a05:620a:468e:b0:915:db15:4e39 with SMTP id af79cd13be357-915db155b3emr473644985a.28.1780940685714;
        Mon, 08 Jun 2026 10:44:45 -0700 (PDT)
Received: from localhost.localdomain ([170.85.76.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37bae6sm1815778185a.31.2026.06.08.10.44.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Jun 2026 10:44:45 -0700 (PDT)
From: Gavin Li <gavin.li@samsara.com>
To: linux-i2c@vger.kernel.org,
	viresh.kumar@linaro.org
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	andi.shyti@kernel.org,
	virtualization@lists.linux.dev,
	Gavin Li <gavin.li@samsara.com>
Subject: [PATCH v2] i2c: virtio: retain xfer with kref to fix UAF on interrupted wait
Date: Mon,  8 Jun 2026 13:44:35 -0400
Message-ID: <20260608174435.62359-1-gavin.li@samsara.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607143608.76122-1-gavin.li@samsara.com>
References: <20260607143608.76122-1-gavin.li@samsara.com>
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
completes the request. The virtio spec provides no way to cancel an
in-flight transfer, so that is not an acceptable tradeoff.

This commit makes two changes:

- Manage the freeing of the xfer allocations via kref, and ensure that
  each in-flight request holds a reference. This fixes the
  use-after-free by ensuring that the virtio device has a valid location
  to write to until the request completes. This will cause a memory
  leak in cases where the device hangs, but that is much preferable to
  memory corruption.

- Use wait_for_completion_killable() instead of _interruptible(). Even
  partial I2C transactions can have side effects, so the only time it
  makes sense to interrupt a transaction is when a process needs to be
  killed. Most existing I2C drivers don't support interruption at all,
  so this should not break userspace applications. This also addresses
  issues with Go programs accessing devices via the I2C userspace API,
  since the Go runtime stochastically signals SIGURG to running threads;
  leaving this as _interruptible() may cause partial side effects from
  which it is impossible to cleanly restart.

Signed-off-by: Gavin Li <gavin.li@samsara.com>
---
 drivers/i2c/busses/i2c-virtio.c | 89 ++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 726c162cabd86..f7320a67a3409 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
@@ -31,39 +32,77 @@ struct virtio_i2c {
 	struct virtqueue *vq;
 };
 
+struct virtio_i2c_xfer;
+
 /**
  * struct virtio_i2c_req - the virtio I2C request structure
+ * @xfer: owning transfer
+ * @msg: copy of the I2C message for virtio_i2c_xfer_release
  * @completion: completion of virtio I2C message
  * @out_hdr: the OUT header of the virtio I2C message
  * @buf: the buffer into which data is read, or from which it's written
  * @in_hdr: the IN header of the virtio I2C message
  */
 struct virtio_i2c_req {
+	struct virtio_i2c_xfer *xfer;
+	struct i2c_msg msg;
 	struct completion completion;
 	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
 	uint8_t *buf				____cacheline_aligned;
 	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
 };
 
+/**
+ * struct virtio_i2c_xfer - a queued I2C transfer
+ * @ref: one ref for the caller, plus one per in-flight virtqueue request
+ * @num: number of messages
+ * @reqs: the virtio I2C requests
+ */
+struct virtio_i2c_xfer {
+	struct kref ref;
+	int num;
+	struct virtio_i2c_req reqs[];
+};
+
+static void virtio_i2c_xfer_release(struct kref *ref)
+{
+	struct virtio_i2c_xfer *xfer = container_of(ref, struct virtio_i2c_xfer, ref);
+	int i;
+
+	for (i = 0; i < xfer->num; i++) {
+		struct virtio_i2c_req *req = &xfer->reqs[i];
+		i2c_put_dma_safe_msg_buf(req->buf, &req->msg, false);
+	}
+
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
 
 static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
-				   struct virtio_i2c_req *reqs,
+				   struct virtio_i2c_xfer *xfer,
 				   struct i2c_msg *msgs, int num)
 {
 	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
+	struct virtio_i2c_req *reqs = xfer->reqs;
 	int i;
 
+	kref_init(&xfer->ref);
+
 	for (i = 0; i < num; i++) {
 		int outcnt = 0, incnt = 0;
 
+		reqs[i].xfer = xfer;
+		reqs[i].msg = msgs[i];
 		init_completion(&reqs[i].completion);
 
 		/*
@@ -99,36 +138,36 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 
 		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
 			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
+			reqs[i].buf = NULL; /* prevent free by virtio_i2c_xfer_release */
 			break;
 		}
+
+		kref_get(&xfer->ref); /* released in virtio_i2c_msg_done() */
 	}
 
+	xfer->num = i;
 	return i;
 }
 
-static int virtio_i2c_complete_reqs(struct virtqueue *vq,
-				    struct virtio_i2c_req *reqs,
-				    struct i2c_msg *msgs, int num)
+static int virtio_i2c_complete_reqs(struct virtio_i2c_xfer *xfer)
 {
-	bool failed = false;
-	int i, j = 0;
+	struct virtio_i2c_req *reqs = xfer->reqs;
+	int i, fail_index = -1;
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < xfer->num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
-
-		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
+		if (wait_for_completion_killable(&req->completion)) {
+			return -EINTR;
+		} else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
+			/* Don't break yet. Try to wait until all requests complete. */
+			if (fail_index < 0)
+				fail_index = i;
 		}
-
-		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
+		i2c_put_dma_safe_msg_buf(req->buf, &req->msg, fail_index < 0);
+		req->buf = NULL; /* prevent free by virtio_i2c_xfer_release */
 	}
 
-	return j;
+	return fail_index >= 0 ? fail_index : xfer->num; /* number of successful transactions */
 }
 
 static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
@@ -136,14 +175,14 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 {
 	struct virtio_i2c *vi = i2c_get_adapdata(adap);
 	struct virtqueue *vq = vi->vq;
-	struct virtio_i2c_req *reqs;
+	struct virtio_i2c_xfer *xfer;
 	int count;
 
-	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
-	if (!reqs)
+	xfer = kzalloc(struct_size(xfer, reqs, num), GFP_KERNEL);
+	if (!xfer)
 		return -ENOMEM;
 
-	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
+	count = virtio_i2c_prepare_reqs(vq, xfer, msgs, num);
 	if (!count)
 		goto err_free;
 
@@ -157,10 +196,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 */
 	virtqueue_kick(vq);
 
-	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
+	count = virtio_i2c_complete_reqs(xfer);
 
 err_free:
-	kfree(reqs);
+	kref_put(&xfer->ref, virtio_i2c_xfer_release);
 	return count;
 }
 
-- 
2.54.0

