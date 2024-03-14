Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3CF6D1A9
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406518; cv=none; b=DSyGmhK8bhD7Bf0MUooIW5qtT/jHh1ncUGXD2AvhZQRmoEeMDoLy485QIgVeMn6BhS74cU9na2HVIBOZ9u9360jIx9NlSTHd/F7NqO+uiRZ1NRTMxqoBqgBTGJiDEanSiZj6cYBW31rQd+C7PaJcogvyjvtWJtqGdemOaP7KzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406518; c=relaxed/simple;
	bh=knR776SHMNPQJ00E4oDbj4KeKoOP+uVubaly2ukSyI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEtRcit6MVxStvSt6de1XU1xUScw7sl/XeHfG3pIG5EH2p4z/O0J5BMAeLdSo8FJo9kOdN3i7Gri4bqzhcQux/n3TvmLQ10vov/AB8M2ZFBpekeRcC99ChhsoEml5HK9EBIQl36pLRoHm3s3CF36cYif8Ct81LUY4bgbnwSFXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cce9jB6U; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cce9jB6U"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406509; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ca/Khyj1bqyPGyhRBOchsuycs6e/tayv50UWfG0gEBc=;
	b=Cce9jB6UIuE3ECeo4e93D74OrQThoUvGId0bCyhBN94EgBL00BpyozAl/+VpmirEvE5fXN3XSWO1XTq9kGTnVHeIT6ZYYkYUQcaD5N1RXd5lMfu2kuIbhFZ6+TmHhmkQ6ywU0bZIIcvc9wRkN+HvD6kfSyNZpGvUgosOTQuq9k4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W2S2VJm_1710406507;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S2VJm_1710406507)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:08 +0800
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
Subject: [PATCH net-next v4 6/8] virtio_net: rename stat tx_timeout to timeout
Date: Thu, 14 Mar 2024 16:54:57 +0800
Message-Id: <20240314085459.115933-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 76259b0090f3
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
index 784512406218..d48985d61418 100644
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
@@ -2780,7 +2780,7 @@ static void virtnet_stats(struct net_device *dev,
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
 			tpackets = u64_stats_read(&sq->stats.packets);
 			tbytes   = u64_stats_read(&sq->stats.bytes);
-			terrors  = u64_stats_read(&sq->stats.tx_timeouts);
+			terrors  = u64_stats_read(&sq->stats.timeouts);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 
 		do {
@@ -4568,7 +4568,7 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	u64_stats_inc(&sq->stats.tx_timeouts);
+	u64_stats_inc(&sq->stats.timeouts);
 	u64_stats_update_end(&sq->stats.syncp);
 
 	netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name: %s, %u usecs ago\n",
-- 
2.32.0.3.g01195cf9f

