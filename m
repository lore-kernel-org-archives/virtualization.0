Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7541C2F8;
	Tue, 28 Jul 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785230805; cv=none; b=L73/73LJGjLnw9APIOn8o014MoD7lCGYloa4qrrRE338UuyIUmXuoSxVsq+5xpwhnJl7jLNZZYUnuX0Ti3T8a2w1R1UHxbMDXvIIwSQEJvr6tZgW5bheJePzVzmEiZ6myjFM4bpvyWCHwh4Iv4UUFEvXDGHsbouLUJAgxMvAmXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785230805; c=relaxed/simple;
	bh=jgqxR6+r5e6bkQb1ah2oqzR9TD02GFyh/d9fnPnwwjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K40+Mz9b/ax92P+Ths4xnlaLraOc5hSesHjdOYdDByMhdfX8xSWNR4Kuo9qdK6JUSP+OmnVqanZzhvB5eqTKkzQ86egZti0p1xdxNbJrKH5rOpHeI41X+3R25WcZCGO9O4Ym2Dk9uBinUBaX+h74on1O4iSvwAE9oszRorLVOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=LHmrUI7c; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="LHmrUI7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785230602;
	bh=GBJI/OtdJ01l0V1VfPr4MJTsrwiYWiI3pZ7p58KA9q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LHmrUI7cLxHO0UD4ri+432xQFYsdkRWTc5KVmrC8PtTTuEXUWBjBlsyKeRUcOsuaP
	 1y5J2fH4w9WJM6prKmQqu+oIfuMFcGf+24now/LhE5mInfNJKB4n9R3eB2tevA4Wrs
	 zCPIP6msVAvQ+AIpEFvbLG/g6qCFPVcP8XPl5eTo=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.117])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66S9NL4O004577
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 11:23:22 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, kvm@vger.kernel.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net 1/4] Revert "tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present"
Date: Tue, 28 Jul 2026 11:22:37 +0200
Message-ID: <20260728092240.250257-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
References: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1d6e569b7d0c0b2736636749e4be0a27f3cefcb3.

The commit stops the netdev queue when the ptr_ring is full instead of
dropping the packet. My own tests showed no relevant regression, but on
Brett Sheffield's librecast testbed an IPv6 multicast testcase got
slower. With 8 iperf3 TCP threads sending, the throughput dropped from
13.5 Gbit/s to 9.13 Gbit/s.

Reported-by: Brett Sheffield <brett@librecast.net>
Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ffbe6f13fb1f..ec5573f545af 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1018,7 +1018,6 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	int len = skb->len;
-	int ret;
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
@@ -1073,33 +1072,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nf_reset_ct(skb);
 
-	queue = netdev_get_tx_queue(dev, txq);
-
-	spin_lock(&tfile->tx_ring.producer_lock);
-	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
-	if (!qdisc_txq_has_no_queue(queue) &&
-	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
-		netif_tx_stop_queue(queue);
-		/* Paired with smp_mb() in __tun_wake_queue() */
-		smp_mb__after_atomic();
-		if (!__ptr_ring_check_produce(&tfile->tx_ring))
-			netif_tx_wake_queue(queue);
-	}
-	spin_unlock(&tfile->tx_ring.producer_lock);
-
-	if (ret) {
-		/* This should be a rare case if a qdisc is present, but
-		 * can happen due to lltx.
-		 * Since skb_tx_timestamp(), skb_orphan(),
-		 * run_ebpf_filter() and pskb_trim() could have tinkered
-		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
-		 * we must drop instead.
-		 */
+	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
 		drop_reason = SKB_DROP_REASON_FULL_RING;
 		goto drop;
 	}
 
 	/* dev->lltx requires to do our own update of trans_start */
+	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
 	/* Notify and wake up reader process */
-- 
2.43.0

