Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E13E022C
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903030; cv=none; b=ptiy/kI7d7wYj3EeFm0RPOZLwZqlgoP4m44FzTNJ+k0Uah+zG7QoaUXFEFzA/JqHVX+zy781Pqzql3kvVjdrFCad25/i7Y/YDmM1+9eqPyscjwz5sJl6LV8z3O45MBlFD6gD2snt/9bHWaUJOkKkqjCkLJnPz5OgzcCeFNDSRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903030; c=relaxed/simple;
	bh=LI9Quol+nMgp/OX9SBZkoQDiofWyejDL3d7Pi2BEK6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GqoDDyO5pOUN2XeVHcUV+r5MIuOYPgVjiZdlqJkdR/w8Fn+eTchamEp2oWtuvZmN2vo7q0ETRVglHyOHOol1QOWPblU05i1M5nLT68LXbXUQBp4lX1fyqkriefIHjUawkk4OvC8SqTgw+bNiI667piXEUOxypyHIGC92reGKeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hCdty1Pw; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hCdty1Pw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wv
	1N4lWbfgZMBDJNbukHBckk+7/7CyVr7NXZ98QYgkw=; b=hCdty1PwkwUluBXdo+
	RaXUlupbAlzvbWlDby371kVbzorXaKphY+6W+z+xxOkjKkQ9BuS05t8MU8hl0ysL
	QfgsJ9L/iJYZaEtZHFZRNQ9jvDenqff3aPFGIXN+dChHFrxPkDRAkGHsCnZ+ggnU
	DCS1r0jvjm86TJ7VfNtgmz9sE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD31xMfPJFqXWYePg--.48947S5;
	Fri, 28 Aug 2026 15:43:29 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [RFC PATCH 3/3] virtio_net: add rx_timeouts per-queue statistic
Date: Fri, 28 Aug 2026 15:43:26 +0800
Message-Id: <20260828074326.65594-4-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260828074326.65594-1-lange_tang@163.com>
References: <20260828074326.65594-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD31xMfPJFqXWYePg--.48947S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4fXryDCr45Ary7Zw1UKFg_yoW8uFWfpF
	4Yy3ZFyFyrXw47Xa4fG3yDZF15K3s3JrW7Gry7K345CFn8KrnYyr10grWUKFyakFZ8Zr1j
	vwsYv398W3yUuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-2-nUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-QIWRGqRPCJZPQAA3s

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
index 02d0c4a67360..44a093604d82 100644
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
@@ -3069,8 +3071,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
  *
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
@@ -3102,6 +3105,10 @@ static void virtnet_rx_watchdog(struct timer_list *t)
 			unsigned int stall_ms =
 				jiffies_to_msecs(jiffies - rq->watchdog_jiffies);
 
+			u64_stats_update_begin(&rq->stats.syncp);
+			u64_stats_inc(&rq->stats.rx_timeouts);
+			u64_stats_update_end(&rq->stats.syncp);
+
 			netdev_warn(vi->dev, "RX queue %u stalled for %u ms\n",
 				    i, stall_ms);
 
-- 
2.43.0

