Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715772;
	b=Z0+c1UazBFdyULZX4yQPaTi4QjPZODr1Ivq6s50Oej2gjJPSLxnldlbH5gxbe6fAIt68
	 kzYJ3NUV/AGVUHg1t5Aq0CzEURyFIbU+eKPrk5mxEh9MSV1gbIEpt23kHUozo9FrCYjrK
	 zXCx1cj137PLlC1nw8Ly0dNZuWlFpc1MpvW6NL9rbD8Fc418as0i+JS5m1XVLsHmNwkrm
	 GmGdDcum8HwLql8KIi0FQY+Z0mjkLELnNbkVIY1DseXE65x8IMw5EddhM4W+CyXZLd2f1
	 6GtL/lD+79TovbS8Nv2K+qyxyJYIRTVr11c+iHM6Z3qvNmrOC7G1IszrA1b3K62lIbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715772;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=uRaOOdHNL2jhfSdxi+3Ia5TDewDrCzWyo2m09xbyvCE=;
	b=GEzLa/69zyZXSgDItxzHcO2uM6BdXMw+AH04eEDH09SpqF5/elu3aH4YMPlD/bzzogd3
	 VPeXa+BNmEX+9J3cz37ktOVun2YwAW16pHAmnKpyN5f/mqI+4Rgj945XHTrGQu8Q3iUia
	 GtHqNtRB7Td6Q/1q86aLbpGsuhEiV024O/gm7RwMNx5hWmUdOdRCJMCxNMBhfBe8v6Jn+
	 I0S00al0sDz4YLAGXlLAFp/TGMCn6/o/JvBqwfajgLNIntAX2S5vRtNy7jDP9v7J2vd3E
	 TgRDZ14ssYONB0bC2Ma+GxCHUrcKsUr2PQ229IoBsMiGAeBQnElzPGeNvvproQrxuFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=1r415yba;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C6606D810
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 14:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 801C6606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=1r415yba
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jJrPt42dvzFr0F;
	Tue, 03 Nov 2026 15:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793715762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRaOOdHNL2jhfSdxi+3Ia5TDewDrCzWyo2m09xbyvCE=;
	b=1r415ybabUbWERttLIgSIUOXUYJdcaNy+45+NslmLZle7yqJj5ZboXY7qB9cNsh/70AD1e
	KfH1sg7Fc2nDyCZRB1mXV+YQyYUHQGgI4h5IAFpdZ4Sw37N3Slx5f22o46Z9s1CsQKPbH5
	nOBB1YKoHnDKuA/9XP/x/E9SggiN12hentePUykIRa9yMV6c2tx09G9CHfedYOygiJNyEW
	c4BXss1cy0KWSxydga7YfzaAz9U31ORI4ox2PL3Run9iEhWWFYHib9SHj4py/MSVTbOxGU
	TIpTQpPZE1ojABDtYdS9W8SPglSF0AnrQdD8IWiYh8togfV463ephZR+aejdZg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	eperezma@redhat.com,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	maheshb@google.com,
	peterpenkov96@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v4 1/2] tun: bound the NAPI receive queue
Date: Tue,  3 Nov 2026 15:22:29 +0100
Message-ID: <20261103142232.1869185-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103142232.1869185-1-antonio@mandelbit.com>
References: <20261103142232.1869185-1-antonio@mandelbit.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4jJrPt42dvzFr0F

With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
an unbounded list. When the poll runs asynchronously (threaded NAPI)
and is slower than the writer, the queue grows until the system runs
out of memory. An unprivileged user can do this from its own user and
network namespaces, and the queued skbs are not charged to its memcg:
in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
in ~6 seconds. The socket send buffer cannot bound this: tun sets it to
INT_MAX, and the build_skb() and XDP batch paths do not check it.

Drop packets once more than netdev_max_backlog of them are queued, like
enqueue_to_backlog() does, and count them as rx_dropped: before
allocating and copying them where possible, and again under the queue
lock before queueing. This covers write(), sendmsg() and the batches of
XDP buffers vhost-net passes to tun_sendmsg(), which share the queue.
Zerocopy buffers of packets dropped early are completed.

The NAPI poll moves the whole queue out, processes up to its budget and
puts the rest back: while it runs, the queue looks empty to writers, so
with the poll on another CPU the backlog still grows without limit. Keep
the leftovers on a queue of their own and take the next batch only once
it is empty, like process_backlog() does, so that neither queue holds
more than the limit.

Dropping because the queue is full also schedules NAPI, in all three
places. vhost-net sends with MSG_MORE while it has more packets, and
tun_get_user() schedules NAPI only after the last one or once more than
NAPI_POLL_WEIGHT are queued. With a netdev_max_backlog below that, the
queue would not drain until vhost-net ran out of packets; with zerocopy,
vhost-net never would, as it stops sending when too many queued buffers
are pending.

Reproducer, as an unprivileged user in a new user and network
namespace, without kernel modifications or fault injection:
  ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
  ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
  ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
  install ~500 iptables FORWARD rules and a MASQUERADE rule on d0
  open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
  echo 1 > /sys/class/net/t0/threaded
  write() 1400-byte IPv4 packets for 10.20.0.2 in a loop

Tested in an x86-64 VM with 1 and 2 vCPUs: with the reproducer running
for 15 seconds, memory use stays flat and the forwarding rate is
unchanged; the tun kselftest passes, as it does without the patch; and
the tun_vhost kselftest added by the next patch, which drives the
vhost-net batch, copy and zerocopy paths, passes, while it fails without
the patch.

Still open: the limit counts packets rather than bytes and applies per
queue, up to about twice the limit can be in flight (queued plus taken
by the poll), and the queued skbs are still not charged to the writer's
memcg.

Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 82 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 770b8fe085c3..ea99ee0aee2b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -58,6 +58,7 @@
 #include <linux/nsproxy.h>
 #include <linux/virtio_net.h>
 #include <linux/rcupdate.h>
+#include <net/hotdata.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <net/rtnetlink.h>
@@ -140,6 +141,8 @@ struct tun_file {
 		unsigned int ifindex;
 	};
 	struct napi_struct napi;
+	/* NAPI poll only: skbs taken off sk_write_queue, not yet received */
+	struct sk_buff_head napi_process_queue;
 	bool napi_enabled;
 	bool napi_frags_enabled;
 	struct mutex napi_mutex;	/* Protects access to the above napi */
@@ -227,31 +230,40 @@ struct veth {
 static void tun_flow_init(struct tun_struct *tun);
 static void tun_flow_uninit(struct tun_struct *tun);
 
+/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
+ * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
+ * like the per-CPU backlog of netif_rx().
+ */
+static bool tun_napi_queue_full(const struct sk_buff_head *queue)
+{
+	return skb_queue_len_lockless(queue) >
+	       READ_ONCE(net_hotdata.max_backlog);
+}
+
 static int tun_napi_receive(struct napi_struct *napi, int budget)
 {
 	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
+	struct sk_buff_head *process_queue = &tfile->napi_process_queue;
 	struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
-	struct sk_buff_head process_queue;
 	struct sk_buff *skb;
 	int received = 0;
 
-	__skb_queue_head_init(&process_queue);
-
-	spin_lock(&queue->lock);
-	skb_queue_splice_tail_init(queue, &process_queue);
-	spin_unlock(&queue->lock);
-
-	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
+	while (received < budget) {
+		/* Refill only when empty: leftovers are not put back on the
+		 * queue writers check, so neither queue exceeds the limit.
+		 */
+		if (skb_queue_empty(process_queue)) {
+			spin_lock(&queue->lock);
+			skb_queue_splice_tail_init(queue, process_queue);
+			spin_unlock(&queue->lock);
+			if (skb_queue_empty(process_queue))
+				break;
+		}
+		skb = __skb_dequeue(process_queue);
 		napi_gro_receive(napi, skb);
 		++received;
 	}
 
-	if (!skb_queue_empty(&process_queue)) {
-		spin_lock(&queue->lock);
-		skb_queue_splice(&process_queue, queue);
-		spin_unlock(&queue->lock);
-	}
-
 	return received;
 }
 
@@ -572,6 +584,8 @@ static void tun_queue_purge(struct tun_file *tfile)
 		tun_ptr_free(ptr);
 
 	skb_queue_purge(&tfile->sk.sk_write_queue);
+	/* NAPI is disabled by now */
+	__skb_queue_purge(&tfile->napi_process_queue);
 	skb_queue_purge(&tfile->sk.sk_error_queue);
 }
 
@@ -1856,6 +1870,23 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			zerocopy = true;
 	}
 
+	/* NAPI queue full: drop before allocating, and schedule NAPI, which a
+	 * MSG_MORE sender may not have done yet. Rechecked under the lock.
+	 */
+	if (tfile->napi_enabled &&
+	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
+		local_bh_disable();
+		napi_schedule(&tfile->napi);
+		local_bh_enable();
+		if (msg_control) {
+			struct ubuf_info *uarg = msg_control;
+
+			uarg->ops->complete(NULL, uarg, false);
+		}
+		dev_core_stats_rx_dropped_inc(tun->dev);
+		return total_len;
+	}
+
 	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
 		/* For the packet that is not easy to be processed
 		 * (e.g gso or jumbo packet), we will do it at after
@@ -2045,6 +2076,17 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			goto free_skb;
 		}
 
+		/* NAPI queue full: drop, as above */
+		if (unlikely(tun_napi_queue_full(queue))) {
+			spin_unlock(&queue->lock);
+			napi_schedule(&tfile->napi);
+			local_bh_enable();
+			rcu_read_unlock();
+			dev_core_stats_rx_dropped_inc(tun->dev);
+			drop_reason = SKB_DROP_REASON_FULL_RING;
+			goto free_skb;
+		}
+
 		__skb_queue_tail(queue, skb);
 		queue_len = skb_queue_len(queue);
 		spin_unlock(&queue->lock);
@@ -2649,6 +2691,17 @@ static int tun_xdp_one(struct tun_struct *tun,
 			return -EBUSY;
 		}
 
+		/* NAPI queue full: drop, and schedule NAPI so that it drains
+		 * even if nothing in this batch gets queued
+		 */
+		if (unlikely(tun_napi_queue_full(queue))) {
+			spin_unlock(&queue->lock);
+			napi_schedule(&tfile->napi);
+			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
+			dev_core_stats_rx_dropped_inc(tun->dev);
+			return 0;
+		}
+
 		__skb_queue_tail(queue, skb);
 		spin_unlock(&queue->lock);
 		ret = 1;
@@ -3571,6 +3624,7 @@ static int tun_chr_open(struct inode *inode, struct file * file)
 	}
 
 	mutex_init(&tfile->napi_mutex);
+	__skb_queue_head_init(&tfile->napi_process_queue);
 	RCU_INIT_POINTER(tfile->tun, NULL);
 	tfile->flags = 0;
 	tfile->ifindex = 0;
-- 
2.56.0

