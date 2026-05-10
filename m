Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BA39EF1E;
	Sun, 10 May 2026 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426278; cv=none; b=n8KWzI3YUBcV5lTS4VMLrjLVO4BXXSTaOB3xZk337tpqN5cdkhJBFUmUzwIbpv2Vcf71n4OkdtIRYBGui1cR18jw6OrynSLeDBhbD5iLK+PeIjvFXpFyeg+mmJGIOq5AU4AVWT25ltN+ASWt4pRgQKkmkDU4+FXlL+tccvA2d48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426278; c=relaxed/simple;
	bh=+mcQTZU20sAWYXW9EG7YpT2irSTxXUzAf5dqIb6jXm4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUcphPVhUQPRB6PBvPJlyYGFCoOnOkbYTNrl6rcnD7wIv5LBRZprCkrmO+E7BEHxEZvLV4m8Gzaiw5HSV/22gp3oj1sNCmzoNwFLJCRZvAa3LQGwoMaztMbXrplwerISmHyAONlGfVwg+7r4uuw/LB/iUDM9nBX4YaaIK9iGa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=JfrOTYLw; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="JfrOTYLw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778426260;
	bh=+mcQTZU20sAWYXW9EG7YpT2irSTxXUzAf5dqIb6jXm4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=JfrOTYLwvlTRFJQfheFjDwLdrq7sYgTFwJ/ehOf2gmY2R7/LOIwQJnOnapiktoDt/
	 E+WLzqY+k7z5p0YpDi4YKhL6hpzcdnLx29FOduagrhrdwvEaGPbWzoZ796iBoVKQBg
	 pXs7JYTpY34ZHL8LrVGb1BjkpwiHyGPXGFYeG5/0=
Received: from simon-Latitude-5450.fritz.box (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64AFHaTG009831
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 17:17:40 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v12 4/4] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
Date: Sun, 10 May 2026 17:15:29 +0200
Message-ID: <20260510151529.43895-5-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit prevents tail-drop when a qdisc is present and the ptr_ring
becomes full. Once the ring reaches capacity after a produce attempt,
the netdev queue is stopped instead of dropping subsequent packets.
If no qdisc is present, the previous tail-drop behavior is preserved.

If producing an entry fails anyway due to a race, tun_net_xmit() drops
the packet. Such races are expected because LLTX is enabled and the
transmit path operates without the usual locking.

The __tun_wake_queue() function of the consumer races with the producer
for waking/stopping the netdev queue, which could result in a stalled
queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
with the smp_mb() of the consumer. It follows the principle of store
buffering described in tools/memory-model/Documentation/recipes.txt:

- The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
  followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
  ring with __ptr_ring_check_produce().

- The consumer in __tun_wake_queue() first writes zero to the ring in
  __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
  status with netif_tx_queue_stopped().

=> Following the aforementioned principle, it is impossible for the
   producer to see a full ring (and therefore not wake the queue on the
   re-check) while the consumer simultaneously fails to see a stopped
   queue (and therefore also does not wake it).

Benchmarks:
The benchmarks show a slight regression in raw transmission performance
when using two sending threads. Packet loss also occurs only in the
two-thread sending case; no packet loss was observed with a single
sending thread.

Test setup:
AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
mitigations disabled.

Note for tap+vhost-net:
XDP drop program active in VM -> ~2.5x faster; slower for tap due to
more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)

+--------------------------+--------------+----------------+----------+
| 1 thread                 | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 1.132 Mpps   | 1.123 Mpps     | -0.8%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 3.857 Mpps   | 3.901 Mpps     | +1.1%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+

+--------------------------+--------------+----------------+----------+
| 2 threads                | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 1.115 Mpps   | 1.081 Mpps     | -3.0%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 8.490 Mpps   | 391 pps        |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 3.664 Mpps   | 3.555 Mpps     | -3.0%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 5.330 Mpps   | 938 pps        |          |
+------------+-------------+--------------+----------------+----------+

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index cbec66646a4b..bfa49fa9e3a1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	int len = skb->len;
+	int ret;
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
@@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nf_reset_ct(skb);
 
-	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
+	queue = netdev_get_tx_queue(dev, txq);
+
+	spin_lock(&tfile->tx_ring.producer_lock);
+	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
+	if (!qdisc_txq_has_no_queue(queue) &&
+	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
+		netif_tx_stop_queue(queue);
+		/* Paired with smp_mb() in __tun_wake_queue() */
+		smp_mb__after_atomic();
+		if (!__ptr_ring_check_produce(&tfile->tx_ring))
+			netif_tx_wake_queue(queue);
+	}
+	spin_unlock(&tfile->tx_ring.producer_lock);
+
+	if (ret) {
+		/* This should be a rare case if a qdisc is present, but
+		 * can happen due to lltx.
+		 * Since skb_tx_timestamp(), skb_orphan(),
+		 * run_ebpf_filter() and pskb_trim() could have tinkered
+		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
+		 * we must drop instead.
+		 */
 		drop_reason = SKB_DROP_REASON_FULL_RING;
 		goto drop;
 	}
 
 	/* dev->lltx requires to do our own update of trans_start */
-	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
 	/* Notify and wake up reader process */
-- 
2.43.0

