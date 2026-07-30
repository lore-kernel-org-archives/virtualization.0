Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796E3CF69E;
	Thu, 30 Jul 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447624; cv=none; b=rA6EG9P5qM0TG0WvJjoNI1rslZcAvOxxiFYy7kfAzc28iuKGPJcs2Veydu8Pgz+4KiiJ0luQoLIAqQkvES8dJLtXwaWc+JsRCGGvuwCOa2fWhbazbWPgUctyweyy1vGkbtCIXpt35DODaKmef4PLiekH9ZZJZGOdATfAiRgEGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447624; c=relaxed/simple;
	bh=1qr9q1v9TLvQfI+TfJQGvv/ILYN2wymskVSQC4YJirI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYlVbmDd+tNl/XdXPqzOldinZEIZw9IJxA+DSRp9eBfX4MpTFLPkfUKiAwpxTeubT8qyL/MWQcKkXsC2kqt64dwr2KPT0uIWmZYiXcs836gcQii6+2cFE6SM/UfNLMppTKRMFDPjzRR2odM15fR6DXQFhTHHZrhJQ/HzdjFjPpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=ocd6rMOX; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="ocd6rMOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785447416;
	bh=ygdN/fp+8E+4V/JMmzAkNtos7EUVf6F+YqDb6wxePa8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ocd6rMOXNdxzbBC0VVwp7URLhqKIHFSkX3uYobjeiFytzuWZwlTVlyeQbxudQ43ZM
	 ZCyPWHAzvBbbcA8XImfZg2usyJOCA7k0XWDrvoXIglYjHmvsrfLZoxz6bJSmQm0AJB
	 r/8VCF3Qwq0q5/q88GCaeXWaS4KUFVmTG19GYUtI=
Received: from simon-Latitude-5450.fritz.box (pd9eaa9cd.dip0.t-ipconnect.de [217.234.169.205])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66ULan30027704
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 23:36:55 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, brett@librecast.net, corbet@lwn.net,
        skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH net-next v13 5/5] tun/tap & vhost-net: stop tail-drop when IFF_BACKPRESSURE is set
Date: Thu, 30 Jul 2026 23:36:39 +0200
Message-ID: <20260730213639.726381-6-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
References: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit prevents tail-drop when IFF_BACKPRESSURE is set, a qdisc is
present and the ptr_ring becomes full. Once the ring reaches capacity
after a produce attempt, the netdev queue is stopped instead of dropping
subsequent packets. Without the flag, or if no qdisc is present, the
previous tail-drop behavior is preserved.

The unconditional version of this behavior was reverted because it caused
a significant throughput drop in an IPv6 multicast testcase on Brett
Sheffield's librecast testbed: with 8 iperf3 TCP threads sending, the
throughput dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is why the queue
stopping is now gated on IFF_BACKPRESSURE.

If producing an entry fails anyway due to a race, tun_net_xmit() drops
the packet. Such rare races are expected because LLTX is enabled and the
transmit path operates without the usual locking.

Since the flag can be cleared again by a later TUNSETIFF, tun_set_iff()
calls tun_force_wake_queue() for the attached tfiles, so that no queue
stays stopped without a consumer that would wake it.

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

The documentation in tuntap.rst is updated accordingly.

Benchmarks:
My own benchmarks show a slight regression in raw transmission performance
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
Link: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 Documentation/networking/tuntap.rst | 22 ++++++++++++++++++
 drivers/net/tun.c                   | 36 +++++++++++++++++++++++++----
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..04155ef98e5b 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,28 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 qdisc backpressure
+----------------------
+
+IFF_BACKPRESSURE can be set to enable qdisc backpressure. Without it, TX
+drops occur when the internal ring buffer is full, so any attached qdisc
+is effectively bypassed and applications only learn about congestion
+through those drops.
+
+With it, the kernel stops instead, letting the qdisc hold and schedule
+packets, so its AQM, shaping and fairness actually apply. This helps
+protocols like TCP, which cut throughput in reaction to packet drops.
+With IFF_BACKPRESSURE, drops then only occur as a rare race. Backpressure
+requires a qdisc to be attached and has no effect with noqueue.
+
+The txqueuelen can be reduced alongside this flag to further shift
+buffering into the qdisc and reduce bufferbloat, but comes at possible
+performance cost.
+
+When running multiple network streams in parallel through a single
+TUN/TAP queue, the flag may reduce performance due to the extra overhead
+of the backpressure mechanism.
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 04275dcac456..5a927bbbda2f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1034,6 +1034,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	int len = skb->len;
+	int ret;
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
@@ -1088,13 +1089,34 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nf_reset_ct(skb);
 
-	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
+	queue = netdev_get_tx_queue(dev, txq);
+
+	spin_lock(&tfile->tx_ring.producer_lock);
+	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
+	if ((tun->flags & IFF_BACKPRESSURE) &&
+	    !qdisc_txq_has_no_queue(queue) &&
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
+		/* This should be a rare case if IFF_BACKPRESSURE is enabled and
+		 * a qdisc is present, but can happen due to lltx.
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
@@ -2767,7 +2789,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	struct tun_struct *tun;
 	struct tun_file *tfile = file->private_data;
 	struct net_device *dev;
-	int err;
+	int err, i;
 
 	if (tfile->detached)
 		return -EINVAL;
@@ -2896,8 +2918,12 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	/* Make sure persistent devices do not get stuck in
 	 * xoff state.
 	 */
-	if (netif_running(tun->dev))
-		netif_tx_wake_all_queues(tun->dev);
+	if (netif_running(tun->dev)) {
+		for (i = 0; i < tun->numqueues; i++) {
+			tfile = rtnl_dereference(tun->tfiles[i]);
+			tun_force_wake_queue(tun, tfile);
+		}
+	}
 
 	strscpy(ifr->ifr_name, tun->dev->name);
 	return 0;
-- 
2.43.0

