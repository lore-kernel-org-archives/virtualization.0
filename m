Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3882E7398
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087703; cv=none; b=FPmMQS7g02aSV7bAGYW01eDYKbVilTlYzUL/SqOw6nVpgBX0IId69P/2g+f6ASDKXdOu0PCV2SpsRmN6zHug3QtFglJooyyTzIgeN3aqhBqrM4NSnrrsUWIHHzgHPP2N+JWiElbvJt8KSMqhB/V4sN4qG1B2fOAUVJOHv/4PvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087703; c=relaxed/simple;
	bh=J3R/p2U5DYsg3b7//+5cI5cAg6TSkLfCdvd3m078P7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWeF8ETYJ/Fe7K2tz945HdG0C1MmPUC4l1TMN6NISxYGgpC3U4Q/TjvV5tXCuSEkXfBNuMBaeUZrfukNHMhhLD+G6tqwI9073JiPbOTw7obhoA1SAepN5rcKoBQnkegOYTY1GixmCBt50fftki0PjvagAF5FdvwnUEGIZ0pmTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gJwLoLnS; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gJwLoLnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087702; x=1818623702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/EaqlfWWY+/app7OnxnVIcNENm07G0GFDaqHOfKsvYw=;
  b=gJwLoLnSij4kipat5eti/1AXlSwHeRCjv5pGW44Ve5OU8kftErKHig/X
   kE31apj654OfB3ZwhveiJmYNpf5V7hknOYOMaf5BULXRe3GUEkHTsK6re
   SAtR9WZ+Tv5UOjs67E2gKFprtsuppa49DkOcLvPxdop6wMIs/y9v3Hw56
   Wmi8b8wtrGJFHgM+/yfdUT8z/aLfUWFQEG7JqMBsgLdUXqxto+vER4gMc
   dBJrIikMfPaFKSsFfI033b6nsbzQU4BwfSeE5TvzdW2PSeYWHP/eUucfm
   ENKlVL/h3Ahl6lPyoFZnVoBe/UsppUGVO8IAKP8WwGPhULGW2n6DP2Oc+
   w==;
X-CSE-ConnectionGUID: BkC8m3FFTOCKeVNOZLWWfg==
X-CSE-MsgGUID: 5RbKFW2tS+ar6Sr8TRPLbg==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="26307973"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:15:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:13867]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id fe877bb6-90ce-4c58-b408-6d88bad3d6bf; Tue, 18 Aug 2026 21:15:01 +0000 (UTC)
X-Farcaster-Flow-ID: fe877bb6-90ce-4c58-b408-6d88bad3d6bf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:15:00 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:14:58 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>, Halil Pasic
	<pasic@linux.ibm.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: [PATCH v2 04/12] virtio_ring: return -ENOMEM when a packed ring mapping fails
Date: Tue, 18 Aug 2026 21:14:17 +0000
Message-ID: <20260818211425.91009-5-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260818211425.91009-1-graf@amazon.com>
References: <20260818211425.91009-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit f7728002c1c7 ("virtio_ring: fix return code on DMA mapping
fails") moved virtqueue_add_split() and virtqueue_add_indirect_packed()
to -ENOMEM, because virtio_queue_rq() maps -EIO to BLK_STS_IOERR and
the request fails. We still return -EIO from virtqueue_add_packed(),
and virtqueue_add_packed_in_order() copied that when it was added later.

Guests that bounce their I/O through swiotlb (SEV-SNP, TDX, s390 secure
execution) run the pool out with enough I/O in flight. On a split ring
virtio_queue_rq() reports BLK_STS_RESOURCE and the block layer requeues
the request. On a packed ring virtio_queue_rq() reports BLK_STS_IOERR
instead and the error reaches the filesystem.

Return -ENOMEM from the packed unmap_release paths too. Both are reached
from a single goto on a failed mapping, which is where
vring_map_one_sg() already produces -ENOMEM.

That way every ring layout reports the same errno, and the block layer
requeues the request instead of failing it.

Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
Fixes: f6a15d854986 ("virtio_ring: add in order support")
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ea8e774b6d8e..b7b03166a301 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1810,7 +1810,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 	}
 
 	END_USE(vq);
-	return -EIO;
+	return -ENOMEM;
 }
 
 static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
@@ -1966,7 +1966,7 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 	}
 
 	END_USE(vq);
-	return -EIO;
+	return -ENOMEM;
 }
 
 static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
