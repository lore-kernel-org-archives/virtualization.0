Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604976;
	b=sUNJtPFm8goUGsgr3YCLrxc9e7911ICz/RYXUhMBsb5g/z+pP2k8Rc/g615BvgmGnwym
	 IkboCPGrO+7xp2isnGFTh5d15k8PvxedmL0axVDxUqZDb3cuHyOCO1XGEo0LSk1ktwDER
	 o+vF1itnIhuTckhj0jaKn+wPHoHVOYCliX6g3VU6K3BV4ytsnpcmp1zqN8pIJYSjMIFhf
	 /AD0XmrOvqcwD1cUbC+6rH4HxmxrZxbn5L8taOZFMsrVQos0GNwneAY6QzAFGhHBmW0Tv
	 v9fBILEqFZ5W8xlh+XG0pItiXWvIIWrTLAfWvS9itPpnjXptxsm8yA9F76obVk0GRfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604976;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=3XzSlHjuBy4Qvsl46C9fgktPPO+/nuAB7Rwpq6984qY=;
	b=iSSCGl+n+pVdqiRx4tfXyAJszuMD+3G1PJEtr3VH39hLRWoZqMGUfqbPmA1s3d1m33Mo
	 QEL2zALfenoBklviIiXXk0HDi75eYIupNcMjZA/SYnASgj+5SVbPeSquXw+TWmXYxM/xm
	 Py1WAxPZ1yAwqqYzhMAK+deC9n6oOpmXXchapNYraq3y2x17fs2NofGkL+EQGAegAS4tm
	 YFrYtaqJt+ohBYVBVQDCQqXZqNWg3Zdd+1oF+tbMaHLeExbplERqLj8Hl/ppDSjk/v+/I
	 piq4SCjRVDpH2qx0F/WIDsqq+YudNEHReRSXndJU1sysSc650tHZh/z+Dx1XsIhNYXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ccucQArS;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACC606A339
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 21:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77ACC606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=ccucQArS
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jR9Fy642nzFqs5;
	Fri, 13 Nov 2026 22:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1794604966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XzSlHjuBy4Qvsl46C9fgktPPO+/nuAB7Rwpq6984qY=;
	b=ccucQArSFRwlO+e/JBKid6LguO+INjNa8M92gkUaS0YoIPcQucfxxT3fyL64RGeFviV6Y6
	nCgE3Okx+hcGaRw+E7mKfEsXxiBTGIM5GZYe9UCr4KFCoalMYeGVTM7gBwYH0MWa6wJy+7
	GiCAnmc8Kb28P9LUzp4vHLvQT2Ay3GUmHJvIKOulYO9z5PeULNqQImHOydAwEGyWG3xfzP
	5wJdQr9Zh2Cbtk+TGyVPGvHr8Bas5MfW5+wJ5YTzkOqi1c/7sQKHftpzj9LKBzIefHJx7f
	TPXzqpA1QEv6Spde/obmacNfb+Y3G1CnUoEr1gWlc37zTEu7+LJFFZk4oLVKaA==
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
Subject: [PATCH net v6 1/2] tun: bound the NAPI receive queue
Date: Fri, 13 Nov 2026 22:22:33 +0100
Message-ID: <20261113212237.1742984-2-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113212237.1742984-1-antonio@mandelbit.com>
References: <20261113212237.1742984-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jR9Fy642nzFqs5

With IFF_NAPI, tun_get_user() queues every written packet for NAPI on
an unbounded list. When the poll runs asynchronously (threaded NAPI)
and is slower than the writer, the queue grows until the system runs
out of memory. An unprivileged user can do this from its own user and
network namespaces, and the queued skbs are not charged to its memcg:
in a test VM, a uid 1000 process limited to 128 MB caused a global OOM
in ~6 seconds. The socket send buffer cannot bound this: tun sets it to
INT_MAX, and the build_skb() and XDP batch paths do not check it.

Drop packets once more than netdev_max_backlog of them are queued, like
enqueue_to_backlog() does, and count them as rx_dropped, before
allocating and copying them. This covers write(), sendmsg() and the
batches of XDP buffers vhost-net passes to tun_sendmsg(), which share
the queue. Zerocopy buffers of dropped packets are completed. The check
is lockless, so concurrent writers can each still add one packet.

The NAPI poll moved the whole queue out, processed up to its budget and
put the rest back: while it ran, the queue looked empty to writers, so
with the poll on another CPU the backlog could still grow without limit.
Take at most budget packets instead, so that the queue never looks
emptier than it is.

Dropping because the queue is full also schedules NAPI. vhost-net sends
with MSG_MORE while it has more packets, and tun_get_user() schedules
NAPI only after the last one or once more than NAPI_POLL_WEIGHT are
queued. With a netdev_max_backlog below that, the queue would not drain
until vhost-net ran out of packets; with zerocopy, vhost-net never
would, as it stops sending when too many queued buffers are pending.

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
for 15 seconds, with 1400 to 65000-byte packets, memory use stays flat
and the forwarding rate is unchanged; the tun kselftest passes, as it
does without the patch; and a vhost-net test driving the batch, copy and
zerocopy paths (next patch) passes, while it fails without the patch.

Still open: the limit counts packets rather than bytes and applies per
queue, so with large packets and many queues (IFF_MULTI_QUEUE works in a
user namespace too) the queued skbs, which are not charged to the
writer's memcg, can still add up to an OOM. This is hard to reach in
practice: with large packets the writer's copy is slower than the NAPI
poll, so the queue does not fill. With 64 KB writes the reproducer never
reached the limit and memory use stayed flat.

Fixes: 943170998b20 ("tun: enable NAPI for TUN/TAP driver")
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/net/tun.c | 55 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 86fd44e10755..73f13684722e 100644
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
@@ -237,21 +248,24 @@ static int tun_napi_receive(struct napi_struct *napi, int budget)
 
 	__skb_queue_head_init(&process_queue);
 
+	/* Take at most budget skbs, so that the queue never looks emptier to
+	 * writers than it is.
+	 */
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
 
@@ -1862,6 +1876,20 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			zerocopy = true;
 	}
 
+	/* NAPI queue full: drop before allocating, and schedule NAPI, which a
+	 * MSG_MORE sender may not have done yet. Lockless: concurrent writers
+	 * can each still add one.
+	 */
+	if (tfile->napi_enabled &&
+	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
+		local_bh_disable();
+		napi_schedule(&tfile->napi);
+		local_bh_enable();
+		net_zcopy_put(msg_control);
+		dev_core_stats_rx_dropped_inc(tun->dev);
+		return total_len;
+	}
+
 	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {
 		/* For the packet that is not easy to be processed
 		 * (e.g gso or jumbo packet), we will do it at after
@@ -2568,6 +2596,17 @@ static int tun_xdp_one(struct tun_struct *tun,
 		return -EIO;
 	}
 
+	/* NAPI queue full: drop, and schedule NAPI so that it drains even if
+	 * nothing in this batch gets queued
+	 */
+	if (tfile->napi_enabled &&
+	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
+		napi_schedule(&tfile->napi);
+		put_page(virt_to_head_page(xdp->data));
+		dev_core_stats_rx_dropped_inc(tun->dev);
+		return 0;
+	}
+
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		if (gso->gso_type) {
-- 
2.56.0

