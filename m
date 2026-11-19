Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102274;
	b=XxI9qkIIEaWqccxceIAvkdFdol9PRSx6MgRpbmr6WjVjgqw3TAS2LBSkvEVwwFBJLdr5
	 Wp/ESYbgDgjdd79ODrcuRfTL2v81jZW2+EEfrBO+gDhMy1X1OUkvFgxLJx/JZ9ESo96S+
	 Ho1ryKRKdZLQ1F0/shUH6Xi+EEmEnoyn8O+BZUsCukK8u71dK8JNbmm80UEs6eHeT5iKY
	 04NtxzxwJr2rwWBI0e3+lz0F72igZ2mYF4bM8R18Yj1VJjIiU52pw4+RRVF2zWK8MNh9h
	 S9lJu3OzV25d3Brs8ZOU2SnFVzN9bwcUxVIn6nTrWjeESbZI+xA9a2nQ6ZqexovCn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102274;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=0k8H3WhqvZLrLdrKeN3pxsTCp80tQHj2NUfIp60honc=;
	b=jf8HLWr1Fp7DxCoNp33vMcZrWoM2I/GxjtrE50hjCUczjisp22W3u8aO8s1nTJZ4TCU6
	 Ww82e5wW37nfQyYvAHJeoNQJa+YrPJ9SCNnMM19CRXW/Y9xCKAGXUam9T5LLULYk4o9DR
	 k3tzqGjVtvr/k5o9h0lx9ZKBGUECE31YfLUCXibrN95Mch+ihZQ2c3/QQtWqg3npJrHSG
	 bttTTGqgnV9BLvcDQC4e0Z8gFa+cVN7QptQZfdagvUrMnY5gG9B7hET+F9Lfg3rEMiLSe
	 2fxIl+/hFPB7W4hbZpvNgCLbUVTJ5Jwm+5qlNxq7OQRVLihhvGfuL0cgVNGddPxEVcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=PfH2lDzH;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E7606A324
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 15:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795E7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=PfH2lDzH
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jVj9S4FRdz3xTD;
	Thu, 19 Nov 2026 16:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795102268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0k8H3WhqvZLrLdrKeN3pxsTCp80tQHj2NUfIp60honc=;
	b=PfH2lDzH7DFYDEO0JjZgj9hFIaMAF2Eb93achjUr7i8Mz7TOZJXikkZn28r6p7MxEmJS+4
	ekR8jN9JR40ZU59TtJL5/ZOTSaUMEcJ5syiRglTNxY2Yl9m9Cc9bjqqnYi+3xjikcxsJiS
	EiY0eUbHFYcwfhU2uCHqVtGwQeClGukb6kpLRaYlwzGOwv4WXoxS+DFFfEar8o2CbsVXpA
	iQlykGs5jTzL2lHlrMobPlARUtLqk3cVgzHa+GLoBYNj1bDYi1UFX6KwwDt6z74fNPGLHO
	YIDQgQfHKOD6R72bhHPVYXU0JuFCR/2QZAiW2HKcw5njxb072JM8v4GRc6g7fQ==
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
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	maheshb@google.com,
	peterpenkov96@gmail.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net v7] tun: bound the NAPI receive queue
Date: Thu, 19 Nov 2026 16:30:55 +0100
Message-ID: <20261119153056.353156-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
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
X-Rspamd-Queue-Id: 4jVj9S4FRdz3xTD

With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
an unbounded list. When the poll runs asynchronously (threaded NAPI or
ksoftirqd) and is slower than the writer, the queue grows until the
system runs out of memory. An unprivileged user can do this from its own
user and network namespaces, and the queued skbs are not charged to its
memcg: in a test VM, a uid 1000 process limited to 128 MB caused a
global OOM in ~6 seconds. The socket send buffer does not help: tun sets
it to INT_MAX by default, the build_skb() path is only used while it is
INT_MAX, and the XDP batch path never checks it.

Drop packets once more than netdev_max_backlog of them are queued, like
enqueue_to_backlog() does, and count them as rx_dropped; the write still
reports success, as for a full backlog. The check sits where packets are
queued for NAPI, in tun_get_user() and in tun_xdp_one() for the batches
vhost-net passes, so packets consumed by XDP or delivered through
IFF_NAPI_FRAGS are not affected. A dropped zerocopy skb completes its
buffer when freed. The check is lockless, so concurrent writers can each
still add one packet.

The NAPI poll moved the whole queue out, processed up to its budget and
put the rest back: while it ran, the queue looked empty to writers, so
with the poll on another CPU the backlog could still grow without limit.
Take at most budget packets instead: the rest stays on the queue writers
check.

Dropping also schedules NAPI. vhost-net sends with MSG_MORE while it has
more packets, and tun_get_user() schedules NAPI only for a packet
without it or once more than NAPI_POLL_WEIGHT are queued. With a
netdev_max_backlog below that, the queue fills first and the packet
without MSG_MORE is dropped too: nothing would schedule NAPI, and the
queued packets, with zerocopy also their buffers, would wait forever.

Reproducer, as an unprivileged user in a new user and network
namespace, without kernel modifications or fault injection:
  ip tuntap add t0 mode tun; ip addr add 10.11.0.1/24 dev t0
  ip link add d0 type dummy; ip addr add 10.20.0.1/24 dev d0
  ip link set t0 up; ip link set d0 up; sysctl net.ipv4.ip_forward=1
  install ~500 iptables FORWARD rules, to slow down the poll, and a
  MASQUERADE rule on d0
  open t0 with IFF_TUN | IFF_NO_PI | IFF_NAPI
  echo 1 > /sys/class/net/t0/threaded
  write() 1400-byte IPv4 packets for 10.20.0.2 in a loop

Found by code inspection while analysing the performance of the tun
write path. Tested in an x86-64 VM on net, with 1 and 2 vCPUs: the
reproducer causes a global OOM without the patch, while with it memory
use stays flat and the forwarding rate is unchanged; the tun kselftest
passes; a local vhost-net test of the batch, copy and zerocopy paths
with netdev_max_backlog set to 8 passes, and fails without the patch;
an XDP program on the device sees every packet while the excess is
dropped.

Still open: neither the packet size nor the queued memory is bounded,
and the skbs are not charged to the writer's memcg. A single write can
create an skb of several hundred KB, so even one queue can hold a lot,
and IFF_MULTI_QUEUE (allowed in a user namespace) and more devices
multiply it. This bounds the queue as enqueue_to_backlog() bounds the
per-CPU backlog; charging the skbs to the writer is left to a follow-up.

Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
v7:
- Check where packets are queued, after XDP and not for IFF_NAPI_FRAGS
  (Sashiko); a dropped zerocopy skb now completes its buffer when freed
- Fix the poll comment and the commit message (Sashiko)
- Drop the vhost-net selftest (Willem, Sashiko)

v6: https://lore.kernel.org/netdev/20261113212237.1742984-1-antonio@mandelbit.com/
v5: https://lore.kernel.org/netdev/20261111014208.1795777-1-antonio@mandelbit.com/
v4: https://lore.kernel.org/netdev/20261103142232.1869185-1-antonio@mandelbit.com/
v3: https://lore.kernel.org/netdev/20261031231444.1528758-1-antonio@mandelbit.com/
v2: https://lore.kernel.org/netdev/20261030152540.1409884-1-antonio@mandelbit.com/

Stable: kernels before v6.9 have no net_hotdata; a backport reads
netdev_max_backlog instead.

 drivers/net/tun.c | 52 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 86fd44e10755..b7432bd4d3f0 100644
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
@@ -227,6 +228,16 @@ struct veth {
 static void tun_flow_init(struct tun_struct *tun);
 static void tun_flow_uninit(struct tun_struct *tun);
 
+/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
+ * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
+ * like the per-CPU backlog.
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
@@ -237,21 +248,22 @@ static int tun_napi_receive(struct napi_struct *napi, int budget)
 
 	__skb_queue_head_init(&process_queue);
 
+	/* At most budget skbs: the rest stays on the queue writers check */
 	spin_lock(&queue->lock);
-	skb_queue_splice_tail_init(queue, &process_queue);
+	if (skb_queue_len(queue) <= budget) {
+		skb_queue_splice_tail_init(queue, &process_queue);
+	} else {
+		while (skb_queue_len(&process_queue) < budget &&
+		       (skb = __skb_dequeue(queue)))
+			__skb_queue_tail(&process_queue, skb);
+	}
 	spin_unlock(&queue->lock);
 
-	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
+	while ((skb = __skb_dequeue(&process_queue))) {
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
 
@@ -2043,6 +2055,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
 		int queue_len;
 
+		/* Queue full: drop, and schedule NAPI, which a MSG_MORE sender
+		 * may not have done yet. Lockless: concurrent writers can each
+		 * still add one.
+		 */
+		if (unlikely(tun_napi_queue_full(queue))) {
+			local_bh_disable();
+			napi_schedule(&tfile->napi);
+			local_bh_enable();
+			rcu_read_unlock();
+			drop_reason = SKB_DROP_REASON_FULL_RING;
+			goto drop;
+		}
+
 		spin_lock_bh(&queue->lock);
 
 		if (unlikely(tfile->detached)) {
@@ -2658,6 +2683,17 @@ static int tun_xdp_one(struct tun_struct *tun,
 
 	if (tfile->napi_enabled) {
 		queue = &tfile->sk.sk_write_queue;
+
+		/* Queue full: drop, and schedule NAPI so that it drains even if
+		 * nothing in this batch gets queued.
+		 */
+		if (unlikely(tun_napi_queue_full(queue))) {
+			napi_schedule(&tfile->napi);
+			kfree_skb_reason(skb, SKB_DROP_REASON_FULL_RING);
+			dev_core_stats_rx_dropped_inc(tun->dev);
+			return 0;
+		}
+
 		spin_lock(&queue->lock);
 
 		if (unlikely(tfile->detached)) {

base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
-- 
2.56.1

