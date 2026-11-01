Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552005;
	b=Y0prIJ6ovrk1qdX7MfMV4v0oZYR7c62G1mkirjsSpBxigwzUd0xwp1VEvDLSj9ty+n34
	 CPp1FsReaDHiUXyNRyvYVop+BSfAuKU6965jm25py/n0otwYlwqmeF4nPJN1NSfwo1P09
	 b8EnzonmRSjZf7xZcHZwifEJJL5HKSBKFku81rqVxKmQ3kCFfAR9AdjpkvyybYfZkTfYg
	 aa+1JcInqIBh6tfXsNZ0vspxu30+GnoCtiSa1QcrPuyI9V/pBN1RLWFO3YYTwTB60gxuH
	 PtNVXyH3S3VKNfg+b42BQd6Ehkif+FKy0cABKFfVRzk8TpBynvly0I8smbhYmLpZ/MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YRHZXduhT/aAWrLeGZjblkuPs/VioNEprpmzptkEp3Q=;
	b=g2bw2nw5BGgi/pssv2hjaWuW97QBDBAThmm+xxoPAkDwp0AQsz6JJJXzJESNeYEIehAF
	 JZrzM4Fwvr4SV4m+mDgT0Pm6H4H25LdfEopqX7n4QCszaLr9P4WucgzMf0RpuESFL2Gui
	 q/glir/5AeLDp3IOsV9aceSzF/TpwFSLtwWY7HnwYBpV9kLYj6UmNRQtLcjOcrtkxoCWV
	 /Phu3fh8KLcEjHBe/ly2yjSV2iUIQE0py+B/RVrnarRhoHoFlrtYEplt7VWaXLcyUwW9u
	 3pQJ1tpc8QjHgV+YXydC37mS7EdBJoW1fzLQ1Kt5xUOjJPIQzuLo4B/rBDSCQnppBvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g6kIB8jg;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26A606A338
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 16:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E26A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g6kIB8jg
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so23419515e9.3
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 08:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552004; x=1794156804; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRHZXduhT/aAWrLeGZjblkuPs/VioNEprpmzptkEp3Q=;
        b=g6kIB8jgyzrJ9BXZr4LDs2FcZevxDVtgcNqsChDSBLBASiUwvX1+/zF5ivRACMd5fu
         7uNsiUnMN8vgXJ7mA+F47/7INzmcuWkzm8B4gorRTTGlM0vhXHAvXOidQzVCrLnjgj0+
         /cF0U2nEelPDC6g627PpY72xUqBZCWlH61bzQNpn7BvYDua5FWLv7+0ucNnWH/bPzvol
         Emt0Waujkf39XwGPONM3WZrN4qlqWgrO5vz4BSahfyJeLRSYMAvR1D/ePYSaQZbQQezZ
         92lzCKzws3+Yo20I6i88IVf0NCbBS/PGVzkO+Ctzbqfc9XyZrLy5DoIq6wzhNSWmjW5r
         gVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552004; x=1794156804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YRHZXduhT/aAWrLeGZjblkuPs/VioNEprpmzptkEp3Q=;
        b=lxUZTu0kWh84sL631ZVywmRtggU8v1r+vPqkrrhWZaiVyn2SBYJFaR0Ah0LXID7/Rr
         8/aIIERMQHZNSpXoGaWJyscWZu7et7prU89lG5ho+2fX6w2S3iCj2rFYoOY9Za2TNWUj
         abLuMyYaiZcAZs/TP4CdqJI/egRBDUq1nFbBVwmitGklhNIuKAgq238Pdy0LSA8iIzX5
         kZv6oEKcTAUbaQC6ixhuWr+9jDPP6UqhaURmclFJf7dB6Ek9NEGdQbJlDYBpzIMrH79o
         jGEi2MBzx0+SX4fK4sQei9xziIcHRxAADxU5gJnFB1yJlFE3QvI4QdzSz5JiYcnZhL2W
         +Yrg==
X-Forwarded-Encrypted: i=1; AKwUvBxc3uTIqyG+CxaS2WbSiEFnsB6gg1UbmWavlYpI05t3IFNajdM++lKFBUlCNEvoPQYABswUNMzIQwJDWXnm3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKX7RpMl1UCx/QLX3JmFDADOcCQlZKdCbPXWFe6+fv8h1IQfuQJ
	4MZdP9M7akiv6LRHhOAg2OZxJwd9DbffGsRMVkqWqbMozpaGnmAF6+Vw
X-Gm-Gg: AYBFou0uXaN3/Ywqx5EyWMvEw29/BhskmCA7p0OyGcPRHECbIDb2gOW4yvodVfnRV+M
	OWycBMo+ohP1wkJ88doT8ls07EiskO1YhcRlBhUi/COe667vtqkyOP61OJx6enppHmcbP8FAnFG
	Qv1kbaLfttXbqcA0vtxwHzzBL484EA0zusrzCFCvi2TIODrVhaVulUd2netDu4qgMJqgSG7iXHf
	5xVfk8zetGZNos+hXKBdDlYqdWFBBiR2HsX49LrqFVQziRjuRhbO13twq4F78sxaEwo2zvzE1Sh
	zu4lSovPj2Q1h3TvfbZc/E7xt+lPXnhNSrdjttz6GnxQhIdAuKMQPlsVl3+bFMDoS35i0m9noEd
	fUTWg82jEuwYJROSaKXd+GpyYyVKzmmqM4heJQvS96FwlRCnJQDxpvZ2dUCtGYqgBuDf4W473el
	7oaAEgkbcZxbW4mU2XF4JL7t8B6RhGFfE8uBmG50z93ld7I9uA3XU8N5UdsN1BAwcvz427g9X5D
	HEE7HLwi1V5ml4eFWhcx41A79PdrDG6l10ZTPG07B/E99WXTPOj0Q/0HZvgaOaSwrXdHVTsgtO6
	DmCvoHHOkzznF6s6Qd0YngtE5JudNggvGgbmdmKWEKJf00AaJx7k5i57FfueueNT0PkTb2ZjT0m
	z
X-Received: by 2002:a05:600c:818e:b0:49f:fd40:80fa with SMTP id 5b1f17b1804b1-4ac1932aa2amr179580105e9.34.1793552003842;
        Sun, 01 Nov 2026 08:53:23 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:5058:2b49:7a78:eb6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm223903095e9.10.2026.11.01.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:53:23 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virtio_blk: fail the probe when a virtqueue is too small for a request
Date: Sun,  1 Nov 2026 17:53:06 +0100
Message-ID: <20261101165307.2557421-2-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
References: <20261101165307.2557421-1-stjepan.poljak@gmail.com>
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

Without VIRTIO_RING_F_INDIRECT_DESC a request takes at least three ring
descriptors: the header, one segment and the status. Nothing checks
that the virtqueues hold that many, and a smaller one fails in a way
that depends on the queue depth. With the default depth, num_free / 2,
a virtqueue of one descriptor gives a depth of 0, which
blk_mq_alloc_tag_set() refuses, and the probe fails without saying why:

  virtio_blk virtio0: probe with driver virtio_blk failed with error -22

With a depth of at least one, from a virtqueue of two or from
virtio_blk.queue_depth, the probe succeeds and the first request never
fits: virtqueue_add_split() warns and returns -ENOSPC, and the hardware
queue is stopped to wait for descriptors that even an empty ring does
not have.

Check the virtqueue sizes right after the virtqueues are set up, before
the queue depth is derived from them, and fail the probe with a reason
when the smallest one cannot hold a request:

  virtio_blk virtio0: virtqueue size 1 is too small for a request

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
 drivers/block/virtio_blk.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c8bfbf8435ac..0a2af22f2365 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1244,6 +1244,18 @@ static const struct blk_mq_ops virtio_mq_ops = {
 static unsigned int virtblk_queue_depth;
 module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
 
+/* The size of the smallest virtqueue, which every request has to fit. */
+static unsigned int virtblk_min_vring_size(struct virtio_blk *vblk)
+{
+	unsigned int vring_size = UINT_MAX;
+	int i;
+
+	for (i = 0; i < vblk->num_vqs; i++)
+		vring_size = min(vring_size,
+				 virtqueue_get_vring_size(vblk->vqs[i].vq));
+	return vring_size;
+}
+
 static int virtblk_read_limits(struct virtio_blk *vblk,
 		struct queue_limits *lim)
 {
@@ -1474,6 +1486,21 @@ static int virtblk_probe(struct virtio_device *vdev)
 	if (err)
 		goto out_free_vblk;
 
+	/*
+	 * Without indirect descriptors the smallest request, a header, one
+	 * segment and the status, takes three descriptors. Check before the
+	 * queue depth is derived from the ring, which would come out as 0
+	 * for a ring of one and fail without saying why.
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+	    virtblk_min_vring_size(vblk) < 3) {
+		dev_err(&vdev->dev,
+			"virtqueue size %u is too small for a request\n",
+			virtblk_min_vring_size(vblk));
+		err = -EINVAL;
+		goto out_free_vq;
+	}
+
 	/* Default queue sizing is to fill the ring. */
 	if (!virtblk_queue_depth) {
 		queue_depth = vblk->vqs[0].vq->num_free;
-- 
2.53.0

