Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA748004E
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871918; cv=none; b=PJ9SfRtt+/yPcpAmLMyzYv1+SqXMJ6DxGRMCmg78D0piyihKOWfWetIEwnmHf1vwLtDbsdSfmZd7l3h9tmHUr3dhk5hZC5dJLKG1dPlTugflX2L9brvPezEJfci8t2luopF0MAmd6SIgpHD8PXZmQ+YM+EQRbru6lstiywZW5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871918; c=relaxed/simple;
	bh=jWC62fYV+ZTF5Fvowh93EkbOaVU7iP1h7ukt4bOLETs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9xv5qAQb5FTlIZ/fQoqRLQFPFtxRvVC/8/VBpYoC0P5F6TkAJbl2JtrrtGSLuwejhLmDqyQicZm3kvvzZGnY3CS1JPfjav6QdpEwe6gYFHouz/sFCjErOOFoGbCCpU2slOkzHRf8xQZIz5B4CZjbV+1LCkOZ9Fjnmzd4/RABCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vt1hEGQ+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vt1hEGQ+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713871914; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=b6216Qqmhhv5PtdUjYLEcywMguoHZfNZiQFsGWmMQII=;
	b=vt1hEGQ+Y2q30PRp3gDh5m/6AwRXzlvMyt3vROHLNCJbfBtXl4ENv5691AgHLmvCiynr4nRTcujUr4Ls2W+aV2kIg48cPmZTRHWXXmMitlkcG0AlS6qIXKIMoK3vfet8kXMSy9mbKAbcQ0Y2dqEK2dThMgjAE1b5pfbe2P0rJiA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W591ZAE_1713871911;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W591ZAE_1713871911)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:31:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v6 6/8] virtio_net: rename stat tx_timeout to timeout
Date: Tue, 23 Apr 2024 19:31:39 +0800
Message-Id: <20240423113141.1752-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 75c95ace5f2d
Content-Transfer-Encoding: 8bit

Now, we have this:

    tx_queue_0_tx_timeouts

This is used to record the tx schedule timeout.
But this has two "tx". I think the below is enough.

    tx_queue_0_timeouts

So I rename this field.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8a4d22f5f5b1..51ce2308f4f5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -87,7 +87,7 @@ struct virtnet_sq_stats {
 	u64_stats_t xdp_tx;
 	u64_stats_t xdp_tx_drops;
 	u64_stats_t kicks;
-	u64_stats_t tx_timeouts;
+	u64_stats_t timeouts;
 };
 
 struct virtnet_rq_stats {
@@ -111,7 +111,7 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 	VIRTNET_SQ_STAT("xdp_tx",       xdp_tx),
 	VIRTNET_SQ_STAT("xdp_tx_drops", xdp_tx_drops),
 	VIRTNET_SQ_STAT("kicks",        kicks),
-	VIRTNET_SQ_STAT("tx_timeouts",  tx_timeouts),
+	VIRTNET_SQ_STAT("timeouts",     timeouts),
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
@@ -2691,7 +2691,7 @@ static void virtnet_stats(struct net_device *dev,
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
 			tpackets = u64_stats_read(&sq->stats.packets);
 			tbytes   = u64_stats_read(&sq->stats.bytes);
-			terrors  = u64_stats_read(&sq->stats.tx_timeouts);
+			terrors  = u64_stats_read(&sq->stats.timeouts);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 
 		do {
@@ -4639,7 +4639,7 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_inc(&sq->stats.tx_timeouts);
+	u64_stats_inc(&sq->stats.timeouts);
 	u64_stats_update_end(&sq->stats.syncp);
 
 	netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name: %s, %u usecs ago\n",
-- 
2.32.0.3.g01195cf9f

