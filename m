Received: from njjs-sys-mailin01.njjs.baidu.com (mx310.baidu.com [180.101.52.44])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B742AA0
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963167; cv=none; b=YgsigQwabCmHiAyd0JJc+EtJf2yN6CH7snhsxDj6U9TRosksbU06u15YCskA9vXHMOCshfX4NDZ6bFF2FWLQj33bvcwoDv4xoOWIn1ulqZZNJujVDaIEkyaC1iNmx7x753yHopx22tAJvb+CRjSB+kVs8LK1FcFRygoPldEJPqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963167; c=relaxed/simple;
	bh=RhdzXVFz4Xo1lAuzWabpcI8mML2J2v7AdIOCjiCEc4k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NN9MTxU23xCkzNJBJtxUxakRphOpuDPPes+ktkh49nTcI+PqhY4WQLhRy44vHAQ1fS4Q0jdmKEZiFkDB1M85vo5eK7nDWyFpZB2j6gV+8aZT+Q5mtJz7nIFN+BYYvRXzCUaEdwvJHFPvA7WI4971WCUqbdGjy0U1wnZ0IC19BEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 2BFA47F00045;
	Fri, 21 Jun 2024 17:45:54 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	hengqi@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	kuba@kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next,v2] virtio_net: Remove u64_stats_update_begin()/end() for stats fetch
Date: Fri, 21 Jun 2024 17:45:52 +0800
Message-Id: <20240621094552.53469-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

This place is fetching the stats, u64_stats_update_begin()/end()
should not be used, and the fetcher of stats is in the same context
as the updater of the stats, so don't need any protection

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d1..6604339 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2336,12 +2336,12 @@ static void virtnet_rx_dim_update(struct virtnet_info *vi, struct receive_queue
 	if (!rq->packets_in_napi)
 		return;
 
-	u64_stats_update_begin(&rq->stats.syncp);
+	/* Don't need protection when fetching stats, since fetcher and
+	 * updater of the stats are in same context */
 	dim_update_sample(rq->calls,
 			  u64_stats_read(&rq->stats.packets),
 			  u64_stats_read(&rq->stats.bytes),
 			  &cur_sample);
-	u64_stats_update_end(&rq->stats.syncp);
 
 	net_dim(&rq->dim, cur_sample);
 	rq->packets_in_napi = 0;
-- 
2.9.4

