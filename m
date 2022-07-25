Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90006C43334
	for <virtualization@archiver.kernel.org>; Mon, 25 Jul 2022 07:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05E3C4188E;
	Mon, 25 Jul 2022 07:22:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05E3C4188E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDMbpJuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GarhIO6us7bB; Mon, 25 Jul 2022 07:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 19CD241881;
	Mon, 25 Jul 2022 07:22:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19CD241881
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E257DC0033;
	Mon, 25 Jul 2022 07:22:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24EECC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F307583F23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:22:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F307583F23
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDMbpJuT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nGfq1Ebp6tR3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:22:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1FE8683F07
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1FE8683F07
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Jul 2022 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658733729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XpnZEgUDGFJ7/tPXmFNs0Qsxnf0jlZgl0StS1M1G4/k=;
 b=hDMbpJuTw+M1OXAqeXXdOVaybC8oVrC0wkbk/B/MUrZxP1EfejF9ftJxR8Pfj6AHDNDkAY
 dzJO6OvWUGJ4Gor7e32eLOZPeFcH6xREWd2qbPWXhGJThcW/X92GPIt4EzH1lpSQRP+uJj
 x1kWvUKELTHuKBiSOS6pev3vOtU+5jE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-QtdWvxcNOhGiduhTnmv9Rw-1; Mon, 25 Jul 2022 03:22:06 -0400
X-MC-Unique: QtdWvxcNOhGiduhTnmv9Rw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 251578032F6;
 Mon, 25 Jul 2022 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-203.pek2.redhat.com
 [10.72.13.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECB9EC27D95;
 Mon, 25 Jul 2022 07:22:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: [PATCH V6] virtio-net: fix the race between refill work and close
Date: Mon, 25 Jul 2022 15:21:59 +0800
Message-Id: <20220725072159.3577-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

We try using cancel_delayed_work_sync() to prevent the work from
enabling NAPI. This is insufficient since we don't disable the source
of the refill work scheduling. This means an NAPI poll callback after
cancel_delayed_work_sync() can schedule the refill work then can
re-enable the NAPI that leads to use-after-free [1].

Since the work can enable NAPI, we can't simply disable NAPI before
calling cancel_delayed_work_sync(). So fix this by introducing a
dedicated boolean to control whether or not the work could be
scheduled from NAPI.

[1]
==================================================================
BUG: KASAN: use-after-free in refill_work+0x43/0xd4
Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42

CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: events refill_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x34/0x44
 print_report.cold+0xbb/0x6ac
 ? _printk+0xad/0xde
 ? refill_work+0x43/0xd4
 kasan_report+0xa8/0x130
 ? refill_work+0x43/0xd4
 refill_work+0x43/0xd4
 process_one_work+0x43d/0x780
 worker_thread+0x2a0/0x6f0
 ? process_one_work+0x780/0x780
 kthread+0x167/0x1a0
 ? kthread_exit+0x50/0x50
 ret_from_fork+0x22/0x30
 </TASK>
...

Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 356cf8dd4164..ec8e1b3108c3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -242,9 +242,15 @@ struct virtnet_info {
 	/* Packet virtio header size */
 	u8 hdr_len;
 
-	/* Work struct for refilling if we run low on memory. */
+	/* Work struct for delayed refilling if we run low on memory. */
 	struct delayed_work refill;
 
+	/* Is delayed refill enabled? */
+	bool refill_enabled;
+
+	/* The lock to synchronize the access to refill_enabled */
+	spinlock_t refill_lock;
+
 	/* Work struct for config space updates */
 	struct work_struct config_work;
 
@@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }
 
+static void enable_delayed_refill(struct virtnet_info *vi)
+{
+	spin_lock_bh(&vi->refill_lock);
+	vi->refill_enabled = true;
+	spin_unlock_bh(&vi->refill_lock);
+}
+
+static void disable_delayed_refill(struct virtnet_info *vi)
+{
+	spin_lock_bh(&vi->refill_lock);
+	vi->refill_enabled = false;
+	spin_unlock_bh(&vi->refill_lock);
+}
+
 static void virtqueue_napi_schedule(struct napi_struct *napi,
 				    struct virtqueue *vq)
 {
@@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	}
 
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
-			schedule_delayed_work(&vi->refill, 0);
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
+			spin_lock(&vi->refill_lock);
+			if (vi->refill_enabled)
+				schedule_delayed_work(&vi->refill, 0);
+			spin_unlock(&vi->refill_lock);
+		}
 	}
 
 	u64_stats_update_begin(&rq->stats.syncp);
@@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i, err;
 
+	enable_delayed_refill(vi);
+
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
@@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
+	/* Make sure NAPI doesn't schedule refill work */
+	disable_delayed_refill(vi);
 	/* Make sure refill_work doesn't re-enable napi! */
 	cancel_delayed_work_sync(&vi->refill);
 
@@ -2792,6 +2820,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	enable_delayed_refill(vi);
+
 	if (netif_running(vi->dev)) {
 		err = virtnet_open(vi->dev);
 		if (err)
@@ -3535,6 +3565,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 
 	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
+	spin_lock_init(&vi->refill_lock);
 
 	/* If we can receive ANY GSO packets, we must allocate large ones. */
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
