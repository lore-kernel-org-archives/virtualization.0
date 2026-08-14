Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE742E8C2
	for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705206; cv=none; b=W7HkECw2v66JEXqM9dkvLtc1KQth9XpY+cYalcAjumiJz2pl4fK/Lk0wCJ4F6CXkctDZr/vmFiJqIyiRmmIzResPu/9PxiT3mTU76rm9txJUXW9wPCnQ/iwJexTk056OGFjuCFxVPmGxLiFi3n5bdNMMH7ZumHO4P4VQHyZQhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705206; c=relaxed/simple;
	bh=9SCpO0d8EKOJ2fr8CJ50K5qiM4hnZYiFEoEwSLVYjgw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=isxUy+idWFWGDCVjAjugftGDNW2rBQMEOatsygiRNqeNnoWY5rXsIqiObaAwWKl/f+L4N+jk5Y41UKrutlwLwsbXXGfqOq+IJtosUuV1pfPvPp9L7mXUfTRzHcLuZsrJzv4WyOVcYYh+XLgYB6XEJVkgytCb8BSoaHs8GHpvu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSlpQ5mn; arc=none smtp.client-ip=209.85.218.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sergiiushakov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSlpQ5mn"
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c167e032f03so74393966b.1
        for <virtualization@lists.linux.dev>; Fri, 14 Aug 2026 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786705200; x=1787310000; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gog9zqUQ9ehoNQDgtaX5umKqholrbFjpKFs4tfUqxtw=;
        b=iSlpQ5mnrv6fF2haQ1NAVkd369ziVmJYRGdbJ3Sb7P1Ks4sHfvAxGoXmO83G2MNr19
         BYDJVeEmLeWjTqkaLwyRK3rYwRCcXX+y1ockT3SDwlJ6P3md4MeEDjes2sJ3HEs5IiKd
         1TIgeDnsJ0JUm1iMu+jibUvLb/5bqDpqI2eJc4Gzz3rdoS6mbrxhhJylRfInYGMWIg69
         umFDvS0s2XS8gf3EQPtd3a3ZB4O4zXllgnC95JPmw9XuTawF2ZyffoHDO5ItZ8DeNH48
         zEpx8SX1nWIgjZ7ATuuACbB+TxE93h9tfThbF6gr9ic81Jfq527hooFMY0nEJ42h7pFP
         6uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705200; x=1787310000;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gog9zqUQ9ehoNQDgtaX5umKqholrbFjpKFs4tfUqxtw=;
        b=sYEltxwaaijbjnBxWfABDmvjIdQYQPEICBb9dWoRFyAHjYRIGyeub+EqeT2Khhd7qN
         QQJakXZska+HaUyYPKHIP4WU4gRuTwmxVkf/YrT5YsjwGx5wh775YCuQ8yP11ViPzYIU
         2EyyducRz5JkI5IVDKhwN4gNUqxIMGQrCWevqo+Rou5ckF1r+NAR6NTpVmzjbxnLydxQ
         aB5mH5aVOH6GhCM7ZP2Zy1HgKaSFRcZ1MmZfgLBZbdKuz4ol/a6bnasEDcl8uZtt49bz
         UcDG2j4KZ2SMHH+p9d307ll05HPZR1O2NPCy1Bik60barLDWXO2yIGmzC2hd+r5dA4NZ
         5ATg==
X-Gm-Message-State: AOJu0YziK+ehljb6EOMCWF1SpCF4VoGWM80QTWHhHvnsjSVkzDGHTPzr
	jCVIH8C4X/a3L5lpigKJbWI2VUs9heqS0KQIdPDE/5+0fGyXWXLDPI78UzTuwcrj3SrBRPk8zbP
	kLh0uSx7jauCZYls+uiDi7nRfvpLsLg972uYIP/KaXkvwV9n2EKn2RxXm4S1fGFgWA/bbLY9DWZ
	6mL3aQ+A4aqKYzHYpIso8y4Rjwq73r9ubK7rM8UML6c2nNvAenGfNzVOA/ECfu9FkWownL3O4t/
	NVWPRVXvjRo
X-Received: from ejta11.prod.google.com ([2002:a17:906:6d4b:b0:c1c:22c5:732])
 (user=sergiiushakov job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:478f:b0:c1c:4a80:30c4 with SMTP id a640c23a62f3a-c212a11e26bmr211761966b.11.1786705199904;
 Fri, 14 Aug 2026 03:59:59 -0700 (PDT)
Date: Fri, 14 Aug 2026 12:59:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814105954.4060627-1-sergiiushakov@google.com>
Subject: [PATCH] virtio-blk: clamp max_segments when indirect descriptors are disabled
From: Sergii Ushakov <sergiiushakov@google.com>
To: virtualization@lists.linux.dev, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Sergii Ushakov <sergiiushakov@google.com>
Content-Type: text/plain; charset="UTF-8"

When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
scatter-gather segment in a request must consume a physical slot in
the virtqueue ring.

If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
compound bio arrives from the page cache, virtqueue_add_split() rejects
the request with -ENOSPC and triggers:

  WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
  WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);

This permanently wedges the blk-mq queue and blocks all subsequent disk
I/O in uninterruptible sleep (D state).

Add a virtio_blk.max_segments module parameter to allow runtime cmdline
overrides, and automatically clamp sg_elems to
(virtqueue_get_vring_size - 2) when indirect descriptors are disabled.

Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
---
 drivers/block/virtio_blk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..082acd90a02d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -41,6 +41,10 @@ static unsigned int poll_queues;
 module_param(poll_queues, uint, 0644);
 MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for polling I/O");
 
+static unsigned int max_segments;
+module_param(max_segments, uint, 0644);
+MODULE_PARM_DESC(max_segments, "Override maximum number of segments per request");
+
 static int major;
 static DEFINE_IDA(vd_index_ida);
 
@@ -1267,6 +1271,12 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	/* Prevent integer overflows and honor max vq size */
 	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
 
+	if (max_segments)
+		sg_elems = min_t(u32, sg_elems, max_segments);
+	else if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
+		sg_elems = min_t(u32, sg_elems,
+				 virtqueue_get_vring_size(vblk->vqs[0].vq) - 2);
+
 	/* We can handle whatever the host told us to handle. */
 	lim->max_segments = sg_elems;
 
-- 
2.55.0.691.gc56d675ccc-goog

