Received: from njjs-sys-mailin01.njjs.baidu.com (mx310.baidu.com [180.101.52.44])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F7A38
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765748; cv=none; b=OPioFG22Mu9CGaxNTKO3Pfaf1S94PNK2UfphEHHNyrHdCsjAX3yahujxLDvYpHGVirT/9J+gDdDqrzc8Vuw884DlJNjErg2hzq6UWGmw3DRWguqPlsyCncW4RUpp1xaZCRsnLNa/4OrL5G2ZFZoBrEzusjRXLiViPpnceGziT4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765748; c=relaxed/simple;
	bh=wGJOMI9F3HjDPA9CT6zl3UIl0vsv1PL8ihKpH1anPFw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DLrjwH2t6q5GRbxSbi7cp0FbmaybW/Eq/6yBRLr8wXRxxcifEiJN+JEoEzbHeMPiUkud4OojG1BgK/5rfN0/DkT2O9CDha5+m/31/mj7A0KK03jsh73KHgf9XMB+b/sjvVYcD9Y+Qb+jabwukq1AgD+RFzYmOcdcqleokkDl3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 1343E7F0004B;
	Wed, 19 Jun 2024 10:55:35 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hengqi@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
Date: Wed, 19 Jun 2024 10:55:29 +0800
Message-Id: <20240619025529.5264-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

This place is fetching the stats, so u64_stats_fetch_begin
and u64_stats_fetch_retry should be used

Fixes: 6208799553a8 ("virtio-net: support rx netdim")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/virtio_net.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d1..b669e73 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2332,16 +2332,18 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue *rq)
 {
 	struct dim_sample cur_sample = {};
+	unsigned int start;
 
 	if (!rq->packets_in_napi)
 		return;
 
-	u64_stats_update_begin(&rq->stats.syncp);
-	dim_update_sample(rq->calls,
-			  u64_stats_read(&rq->stats.packets),
-			  u64_stats_read(&rq->stats.bytes),
-			  &cur_sample);
-	u64_stats_update_end(&rq->stats.syncp);
+	do {
+		start = u64_stats_fetch_begin(&rq->stats.syncp);
+		dim_update_sample(rq->calls,
+				u64_stats_read(&rq->stats.packets),
+				u64_stats_read(&rq->stats.bytes),
+				&cur_sample);
+	} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 
 	net_dim(&rq->dim, cur_sample);
 	rq->packets_in_napi = 0;
-- 
2.9.4

