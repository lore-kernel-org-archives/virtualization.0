Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8C2285041
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012651; cv=none; b=f3nNp749fEiTI2BSuIrIIRsUU9Kqw0g8I0loXLIpjFMlvPcfA0zn3zmsf4fHUFfitllsDvDqKW8xm7ggoFiNA1xmigyCYUogS0PCpvCCj+dE127G+DuCwQoZd1EMeB5tmjqitB7twgsF52RsivjwRmEQLg+CAAOOsV6Pn9UrbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012651; c=relaxed/simple;
	bh=uA/Oq+aFKryWxvX5sF7kzB2l7t++59PiFSM5eUyo/5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcpayDxF2bkvUJ6cj7cCKO5jZZTlaR4R+lOKv1dazQJappXcIjMWyJVt3KgprHMvqmPCRQ+GD4rc9R1rQF5qfVvDeCejWXo/AAbCwnBRKhl+wSzHIDpdEqRPqCo9luUZmaqlbSzS1LCte4uNgz2rgt7zAgA4bk9SvUiO3Bdbb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com; spf=pass smtp.mailfrom=samsara.com; dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b=lvkmroH3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=samsara.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsara.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=samsara.com header.i=@samsara.com header.b="lvkmroH3"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-915d64fead9so203598585a.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=samsara.com; s=google; t=1781012649; x=1781617449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1JWiWZaW/N2lWwHNzLpmS8whQXMwigSGkRGvfGiit4=;
        b=lvkmroH3ljRmpRpikxMb1gl+gqDzDbEAkkEI3hg+GCLeiDC0BojxHnmlL7Q3zMQVrv
         3AKMmFCMVtQ4hE7PJgUFw15OAO2j+5RrF8vA58tkX27G9qxNfgIMGWEspq+UAPdiA4HB
         4Ltl54PwCNHfDtkSCUqKaS+SBoDHEcw5dX7q/yr2ol8jnrSWNNPd3Zs8UTMWnzhR/S0j
         qw36GvpATg4A5Vn440qAybhu4e6TXRKdgQuVD756rzLZTvmGlkYNlx84Er5EzFYHZRYb
         yXMytMMhwKDE8u9X2ivdKyMUbTSdXASSsxkXfwmR8bVoxOQj3V08D5qvUITXGiF7BEKR
         98/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012649; x=1781617449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o1JWiWZaW/N2lWwHNzLpmS8whQXMwigSGkRGvfGiit4=;
        b=YyFEwyoPbojhRIkaf2KwirxmLXRNjLzcMwkSVqSRpjYgVyXdzdsbigogVOfPAVTghX
         LKstAlqtPmoY/PHO8vUD7qifqlwj38EwbcgWoOnlFw8AS8S+xKPanigMphEI+1smVln7
         EI7W25/qh/OG9XvOY6stKrkjStFRKCMV5BhuEopJ6CraEyfqldhUkjitH6jy/DMtlyPm
         Z0b/vASElt67AxWL1tAZ1kjykw4bLbOFBJgCBTxCQKZILeL0ws+V36lJaUsPk/EoKO26
         C+qO4WEaEjeJrsottBt3Lk43DqlibHQrA7VMQPWoWLnx6tZEb1KIR4JbywHsr/rrJPtN
         DJzA==
X-Forwarded-Encrypted: i=1; AFNElJ/IjsOX85mHFTZoZZyhfLJTFV3cjIhj/t9mOV058h3yyrDP8ec/LHqVA7mtiek5lWvJEc874Pf/na6sLGPv/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3gCAKbxijoFrvghwRJuE6JqHbl6dN/DrY1nRwhh19SnRZDDfn
	/SExr79TTXHKP9rqy7hweC2pGj9/SiKBDQAHnDw9STaWB9agl41shw1i3qn+lCbNyA==
X-Gm-Gg: Acq92OHnfdJgkK2xa4ufNd7koXUXKQrsoa8BUv98Hto9jef+bS/1y5FXf2AtxsWPd5D
	c/a++LrG1qWujsKvXrMnNE8JGNDjWBfJrEuZo3Y81aQjcC+dsyuGdoelKXqn9LBW5cyT1eVWDn+
	Wwf4PeJ3JzfZKzdG0HbKbmErW8OOPNgaH64CbS7qDqMWjmhFcwbxGmnCmvoYx5b+GlD8dxqYthC
	FVOd1shVE6lJazug1DPrhGnccBRr4iQQvd764qZDf41ym213C5rbitrSI6Z4H+PwjfX2iQrUhY6
	oB0qpq1PfZzuypojB92r7aIcZd8e64wGIZjGE2jiGKXIKrmz3zh/iHdNj4UkfWmoOUd5CaoQwKo
	r5IkTnx/KCGKPn3dRibu5KPvN1cdSp6xAjg3O2X6jevLY6ElII0YWhSCJzgtsm5vXTjj7Z3UY3G
	DWswAzQJtzCRvTpTbTU/Ywnv7jzIE3hjfcXkpjNvELk45VuWXRRc6xpHkS//QIkwqFIlOC0ZihJ
	2qm7zbHByJJppI=
X-Received: by 2002:a05:620a:450c:b0:8cd:d688:7aef with SMTP id af79cd13be357-915ad197c8dmr2339201885a.19.1781012648347;
        Tue, 09 Jun 2026 06:44:08 -0700 (PDT)
Received: from localhost.localdomain ([170.85.76.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37cae4sm2109243085a.29.2026.06.09.06.44.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 06:44:07 -0700 (PDT)
From: Gavin Li <gavin.li@samsara.com>
To: linux-i2c@vger.kernel.org,
	viresh.kumar@linaro.org
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	andi.shyti@kernel.org,
	virtualization@lists.linux.dev,
	Gavin Li <gavin.li@samsara.com>
Subject: [PATCH v3] i2c: virtio: retain xfer with kref to fix UAF on interrupted wait
Date: Tue,  9 Jun 2026 09:43:58 -0400
Message-ID: <20260609134358.36583-1-gavin.li@samsara.com>
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
This results in an extra allocation+copy when I2C_M_DMA_SAFE is used.

Signed-off-by: Gavin Li <gavin.li@samsara.com>
---
 drivers/i2c/busses/i2c-virtio.c | 110 ++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec3..7ee96b08f6685 100644
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
@@ -31,39 +32,72 @@ struct virtio_i2c {
 	struct virtqueue *vq;
 };
 
+struct virtio_i2c_xfer;
+
 /**
  * struct virtio_i2c_req - the virtio I2C request structure
+ * @xfer: owning transfer
  * @completion: completion of virtio I2C message
  * @out_hdr: the OUT header of the virtio I2C message
- * @buf: the buffer into which data is read, or from which it's written
+ * @buf: bounce buffer for i2c_msg.buf, set to NULL upon free
  * @in_hdr: the IN header of the virtio I2C message
  */
 struct virtio_i2c_req {
+	struct virtio_i2c_xfer *xfer;
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
+		kfree(req->buf);
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
 
-static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
-				   struct virtio_i2c_req *reqs,
+static int virtio_i2c_prepare_xfer(struct virtqueue *vq,
+				   struct virtio_i2c_xfer *xfer,
 				   struct i2c_msg *msgs, int num)
 {
 	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
+	struct virtio_i2c_req *reqs = xfer->reqs;
 	int i;
 
 	for (i = 0; i < num; i++) {
 		int outcnt = 0, incnt = 0;
 
+		reqs[i].xfer = xfer;
 		init_completion(&reqs[i].completion);
 
 		/*
@@ -82,9 +116,16 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 		sgs[outcnt++] = &out_hdr;
 
 		if (msgs[i].len) {
-			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
+			/*
+			 * Even if msg->flags has I2C_M_DMA_SAFE set, a bounce
+			 * buffer is required because the transfer may be
+			 * interrupted, after which msg->buf is no longer valid.
+			 */
+			reqs[i].buf = kzalloc(msgs[i].len, GFP_KERNEL);
 			if (!reqs[i].buf)
 				break;
+			if (!(msgs[i].flags & I2C_M_RD))
+				memcpy(reqs[i].buf, msgs[i].buf, msgs[i].len);
 
 			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
 
@@ -97,38 +138,51 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
 		sgs[outcnt + incnt++] = &in_hdr;
 
+		/* This reference is released in virtio_i2c_msg_done(). */
+		kref_get(&xfer->ref);
+
 		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
-			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
+			kref_put(&xfer->ref, virtio_i2c_xfer_release);
+
+			kfree(reqs[i].buf);
+			reqs[i].buf = NULL; /* prevent free by virtio_i2c_xfer_release */
+
 			break;
 		}
 	}
 
+	xfer->num = i;
 	return i;
 }
 
-static int virtio_i2c_complete_reqs(struct virtqueue *vq,
-				    struct virtio_i2c_req *reqs,
-				    struct i2c_msg *msgs, int num)
+static int virtio_i2c_complete_xfer(struct virtio_i2c_xfer *xfer,
+				    struct i2c_msg *msgs)
 {
-	bool failed = false;
-	int i, j = 0;
+	struct virtio_i2c_req *reqs = xfer->reqs;
+	int i, fail_index = -1;
 
-	for (i = 0; i < num; i++) {
+	for (i = 0; i < xfer->num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
+		struct i2c_msg *msg = &msgs[i];
 
-		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
+		if (wait_for_completion_interruptible(&req->completion))
+			return -EINTR;
+
+		if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
+			/* Don't break yet. Try to wait until all requests complete. */
+			if (fail_index < 0)
+				fail_index = i;
 		}
 
-		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
+		if (fail_index < 0 && (msg->flags & I2C_M_RD))
+			memcpy(msg->buf, req->buf, msg->len);
+
+		kfree(req->buf);
+		req->buf = NULL; /* prevent free by virtio_i2c_xfer_release */
 	}
 
-	return j;
+	/* Return number of successful transactions */
+	return fail_index >= 0 ? fail_index : xfer->num;
 }
 
 static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
@@ -136,14 +190,16 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 {
 	struct virtio_i2c *vi = i2c_get_adapdata(adap);
 	struct virtqueue *vq = vi->vq;
-	struct virtio_i2c_req *reqs;
+	struct virtio_i2c_xfer *xfer;
 	int count;
 
-	reqs = kzalloc_objs(*reqs, num);
-	if (!reqs)
+	xfer = kzalloc(struct_size(xfer, reqs, num), GFP_KERNEL);
+	if (!xfer)
 		return -ENOMEM;
 
-	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
+	kref_init(&xfer->ref);
+
+	count = virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
 	if (!count)
 		goto err_free;
 
@@ -157,10 +213,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 */
 	virtqueue_kick(vq);
 
-	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
+	count = virtio_i2c_complete_xfer(xfer, msgs);
 
 err_free:
-	kfree(reqs);
+	kref_put(&xfer->ref, virtio_i2c_xfer_release);
 	return count;
 }
 
-- 
2.54.0

