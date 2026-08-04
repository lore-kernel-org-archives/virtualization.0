Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511C446069
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833625; cv=none; b=LaWehjuniQRrqleV4fniUizkiGq8z4oL2OuHDedhX+P8Umk9BoHzsaIwU2h+w5QqB6egMekaYkoBfYMXgs0wx9KZq5KIjeqPOl6TNxNu6mDba/y+VOkhbOLTrqoBok4/cLgTeD7wIVQI+NX2GQ0WacCbJmeenhzZQJLGupm3epY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833625; c=relaxed/simple;
	bh=FGB0pzjgkMcvCsdYI2JBh77SS9vY5Qpxv9fJYcEcKnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XprNEjFZYrkT4RD+yhsMbItQiioAXix3PpXyGSyrL0ggwiyX9cQvV+1u8jlHHSIz58/AmWcO1Q0+YleDkCR5NCRb4bFVVGkOFy+udzRQFpX/OIYHFnpH5cK3/lqjw56yoGiZ5Yw++4Fathti0RdbVyUjgwhIG1SpYr3SYEwknaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f9d30f1e8fe111f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:19184ce3-2157-4415-af71-d15282bc5246,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:51f877212722d72e1d95012732bfb843,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9d30f1e8fe111f1aa26b74ffac11d73-20260804
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 602898929; Tue, 04 Aug 2026 16:53:34 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH net 1/2] virtio_net: check AF_XDP queue index before use
Date: Tue,  4 Aug 2026 16:53:28 +0800
Message-ID: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate the AF_XDP queue index before dereferencing the receive or
send queue arrays in virtnet_xsk_pool_enable().  This keeps an out of
range queue id from reaching vi->rq[qid] while checking page_pool.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c..6160aa8ba 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5896,15 +5896,15 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (vi->hdr_len > xsk_pool_get_headroom(pool))
 		return -EINVAL;
 
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
 	 */
 	if (!vi->rq[qid].page_pool)
 		return -ENOENT;
 
-	if (qid >= vi->curr_queue_pairs)
-		return -EINVAL;
-
 	sq = &vi->sq[qid];
 	rq = &vi->rq[qid];
 
-- 
2.43.0

