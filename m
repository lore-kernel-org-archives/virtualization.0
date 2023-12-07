Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD18107B2
	for <virtualization@lists.linux.dev>; Thu,  7 Dec 2023 04:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="V3ob07ZX"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b84e328327so434687b6e.2
        for <virtualization@lists.linux.dev>; Wed, 06 Dec 2023 20:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701923582; x=1702528382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f/Lf0+IIfQE0io2nHdmDYhVLqD8zUaOijlO0hMGWTXo=;
        b=V3ob07ZXGsuO0Zr09ulHiIQRgUdI7ChmPUCCIwCjVlbOJnAXG6Dd0pq0ih9ssnFUxt
         k1WNrlGjk7fkn+Em+qkAGDykfktiINENBp1v/R8PFj5CX7S+KiXsYCLzNXpqI4UADKNy
         ykmpwT5BdBFC4cOnautHiagkrnlhnHnPkiDueNQp7gPv95D2Y26aJnTHHqcVXPjpx55W
         AoQ7BvNxDj1IEuPowhYWREq20IRYwooW2fzRM4Jfl1XdtYOEpa9J0kRIJheG+SkZftks
         re+PvbLcCUbS6JvMNXhlqTfGiRYKuw0ouR4kOG2YAXEZ9t3Tj5ew5eWBe8I38bFO7AfV
         b0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701923582; x=1702528382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/Lf0+IIfQE0io2nHdmDYhVLqD8zUaOijlO0hMGWTXo=;
        b=Xt6+C5T3QKl50zlOGgNeg9Wz7SwGFsxz3g1YlSBjZJq7GscjCcGO6+cfEBVGR5bR9T
         jn93QkiYDMOH1gyOn2LXNR77cVBHRCqa7gOn2DBhzKT57Rq11ZAz6c58tRWKS/UO3oGf
         kvW62TehQbrm/KWDD/QV2tG7Iw8Cv+h/EE2OwKJkIipV/T3xJjVoB48I3LBRkhHabGOV
         KHp3NYmaXYjOs+/XsLI1tXzkIs8DksR0pudZVU7fQ+xA74QWY0j5DGyTJnoIWuqUA8cG
         TNY/4MpuI/KwpKAcP2Gj5iQIT4E+xnpv36Xoepl3udlgPq8HtalZ7aAj2ihlWyWnktYx
         PQ1Q==
X-Gm-Message-State: AOJu0Yy8GxmukI7+OABwYqEW/lmsq79awWTzI8c3lsFhP4cg+awjL/9j
	AiG/pNCPpP+45fp/bEoXgHtkFw==
X-Google-Smtp-Source: AGHT+IHJYbFIUTZB44VBOizgu6C4ZjGpZ8ov/2VlLfUy+pzKCRy95+hHpycf+1VuZxTdnNIi7xPU9A==
X-Received: by 2002:aca:1b02:0:b0:3b9:dcf0:63b9 with SMTP id b2-20020aca1b02000000b003b9dcf063b9mr615047oib.23.1701923581661;
        Wed, 06 Dec 2023 20:33:01 -0800 (PST)
Received: from localhost.localdomain.localdomain ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78513000000b006cea1e12564sm332971pfn.81.2023.12.06.20.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:33:01 -0800 (PST)
From: Li Feng <fengli@smartx.com>
To: Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list),
	virtualization@lists.linux.dev (open list:VIRTIO BLOCK AND SCSI DRIVERS)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH] virtio_blk: set the default scheduler to none
Date: Thu,  7 Dec 2023 12:31:05 +0800
Message-ID: <20231207043118.118158-1-fengli@smartx.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio-blk is generally used in cloud computing scenarios, where the
performance of virtual disks is very important. The mq-deadline scheduler
has a big performance drop compared to none with single queue. In my tests,
mq-deadline 4k readread iops were 270k compared to 450k for none. So here
the default scheduler of virtio-blk is set to "none".

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69..5183ec8e00be 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->tag_set.ops = &virtio_mq_ops;
 	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
-- 
2.42.0

