Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3F1AC44D
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859633; cv=none; b=NHD6mYEFmKy6Jy3bPvEKmpEtZsBUEzJH7AeZJANGqJ5hoWCfCVRAgWUpw2Wf0LEzqnWT7nAeoLKEacLiTGbti6lYlgQ1VExqG2sxTahs6nIY/0f7FDJ3cT4lv6tKlSCEpodvC8vYpJxumyQvPfoUE3WxTlDq6iQkGXIDo6hn6jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859633; c=relaxed/simple;
	bh=OIG3IUM0wvbjm9h+z19we3kd6TZt23Vrw6bYwWsgKwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/xCPB8FEN5KIkN5DNlOYS+cg4Yc/BVNoLmEHexuAG+M4KjWbx7tFoDhu9Vx4fMUVBaV1WH5HPCGW5omchwEaccejW2OK1hEPyZ7CjI1M/3RlUpKaRy6EFYTfYFNawZ1y5O0xmOHszXl6pGamzOU2E3OOluxhznPvIvvYVdvyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Lpj8q9Qy; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Lpj8q9Qy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qB
	nyWjv/850mGGrhNeeIMuqmu642ZeWUMG+CXj8caEY=; b=Lpj8q9Qy1sTFQHfpwB
	ykiFr4WCqdNbqkOy4+i7ywILQVjm56RG4rrHZprTPsYOtD5XC9bWZd/Y5zYoyIhC
	9Oz/oPmvemzXsp4apKCfmqyzDURRRLlBoh9dfZfdbSaprKzLUelIrUzgiPkqH/P4
	6SLdPGNgY5Hfo7EuVQ3y33HzI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Bf3X1J9qaBRdRg--.18019S5;
	Tue, 08 Sep 2026 17:26:51 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [RFC RESEND 3/3] virtio_net: add rx_timeouts per-queue statistic
Date: Tue,  8 Sep 2026 17:26:46 +0800
Message-Id: <20260908092646.108865-4-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908092646.108865-1-lange_tang@163.com>
References: <20260908092646.108865-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Bf3X1J9qaBRdRg--.18019S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4fXryDCr45Ary7Zw1UKFg_yoW8uFWDpF
	4Yy3ZFyFyrXw47Xa4xJ3yDZF15K3s3JrW7Gry7K34rCFn8KrnYyr10grWUKF9IvFZ5Zr1j
	vw4Fv398G3yUuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaE_NUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4RvtHGqf1NuicQAA3i

From: Longjun Tang <tanglongjun@kylinos.cn>

Add an rx_timeouts field to the per-queue RX statistics, expose
it via ethtool and increment it when the RX watchdog fires,
so RX watchdog timeouts can be observed per queue.

Assisted-by: Kilo:deepseek-v4-pro
Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c28de03c177b..a898e8e8fe53 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -134,6 +134,7 @@ struct virtnet_rq_stats {
 	u64_stats_t xdp_redirects;
 	u64_stats_t xdp_drops;
 	u64_stats_t kicks;
+	u64_stats_t rx_timeouts;
 };
 
 #define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
@@ -167,6 +168,7 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),
 	VIRTNET_RQ_STAT("xdp_drops",     xdp_drops),
 	VIRTNET_RQ_STAT("kicks",         kicks),
+	VIRTNET_RQ_STAT("rx_timeouts",   rx_timeouts),
 };
 
 static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
@@ -3061,8 +3063,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 /*
  * This watchdog detects that state: a queue is considered stalled when
  * it has a non-zero backlog, makes no consumption progress and receives
- * no new interrupt for rx_watchdog_timeo seconds. On detection it logs
- * a warning.
+ * no new interrupt for rx_watchdog_timeo seconds. On detection it
+ * records the event in the per-queue rx_timeouts statistic and logs a
+ * warning.
  */
 static void virtnet_rx_watchdog(struct timer_list *t)
 {
@@ -3094,6 +3097,10 @@ static void virtnet_rx_watchdog(struct timer_list *t)
 			unsigned int stall_ms =
 				jiffies_to_msecs(jiffies - rq->watchdog_jiffies);
 
+			u64_stats_update_begin(&rq->stats.syncp);
+			u64_stats_inc(&rq->stats.rx_timeouts);
+			u64_stats_update_end(&rq->stats.syncp);
+
 			netdev_warn(vi->dev, "RX queue %u stalled for %u ms\n",
 				    i, stall_ms);
 
-- 
2.25.1

