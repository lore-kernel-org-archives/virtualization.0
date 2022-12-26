Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDA6C4332F
	for <virtualization@archiver.kernel.org>; Mon, 26 Dec 2022 07:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B013D60A6A;
	Mon, 26 Dec 2022 07:49:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B013D60A6A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PwZkLw+6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zk7qvGR4zdkd; Mon, 26 Dec 2022 07:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2BC9B607CE;
	Mon, 26 Dec 2022 07:49:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BC9B607CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04812C0035;
	Mon, 26 Dec 2022 07:49:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CDA6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7832E4036F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7832E4036F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PwZkLw+6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gF6_lBD-sYTF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA0D640359
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA0D640359
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672040981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQQAF2roIs1AkbrATZH+Dx5zgxJxII5XuDrBnrFmmR0=;
 b=PwZkLw+6tAA3JpNNGoYs02e5Tg4oP0LYzuxAa1V1Y4KfXSBg+qu1DN/BZladrz2waNZQgA
 dGKxn7esXsIVDfTNvxXB8S0vXVmYG1qlSrd11Y2LkelS2U8EaPMe7zLDmwiM8CobrGw8lt
 DqLcXXQUVFj1Wf6QAS1hRJcOVxciElo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-fpqLXZzLMJGNQN3y84BlPg-1; Mon, 26 Dec 2022 02:49:37 -0500
X-MC-Unique: fpqLXZzLMJGNQN3y84BlPg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4982101A52E;
 Mon, 26 Dec 2022 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-100.pek2.redhat.com
 [10.72.13.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE333492B00;
 Mon, 26 Dec 2022 07:49:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq command
Date: Mon, 26 Dec 2022 15:49:08 +0800
Message-Id: <20221226074908.8154-5-jasowang@redhat.com>
In-Reply-To: <20221226074908.8154-1-jasowang@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

We used to busy waiting on the cvq command this tends to be
problematic since:

1) CPU could wait for ever on a buggy/malicous device
2) There's no wait to terminate the process that triggers the cvq
   command

So this patch switch to use virtqueue_wait_for_used() to sleep with a
timeout (1s) instead of busy polling for the cvq command forever. This
gives the scheduler a breath and can let the process can respond to
asignal. If the device doesn't respond in the timeout, break the
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes since V1:
- break the device when timeout
- get buffer manually since the virtio core check more_used() instead
---
 drivers/net/virtio_net.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index efd9dd55828b..6a2ea64cfcb5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
 	vi->rx_mode_work_enabled = false;
 	spin_unlock_bh(&vi->rx_mode_lock);
 
+	virtqueue_wake_up(vi->cvq);
 	flush_work(&vi->rx_mode_work);
 }
 
@@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 	return !oom;
 }
 
+static void virtnet_cvq_done(struct virtqueue *cvq)
+{
+	virtqueue_wake_up(cvq);
+}
+
 static void skb_recv_done(struct virtqueue *rvq)
 {
 	struct virtnet_info *vi = rvq->vdev->priv;
@@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	return err;
 }
 
+static int virtnet_close(struct net_device *dev);
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
@@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	if (unlikely(!virtqueue_kick(vi->cvq)))
 		return vi->ctrl->status == VIRTIO_NET_OK;
 
-	/* Spin for a response, the kick causes an ioport write, trapping
-	 * into the hypervisor, so the request should be handled immediately.
-	 */
-	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
-		cpu_relax();
+	if (virtqueue_wait_for_used(vi->cvq)) {
+		virtqueue_get_buf(vi->cvq, &tmp);
+		return vi->ctrl->status == VIRTIO_NET_OK;
+	}
 
-	return vi->ctrl->status == VIRTIO_NET_OK;
+	netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
+	virtio_break_device(vi->vdev);
+	return VIRTIO_NET_ERR;
 }
 
 static int virtnet_set_mac_address(struct net_device *dev, void *p)
@@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 
 	/* Parameters for control virtqueue, if any */
 	if (vi->has_cvq) {
-		callbacks[total_vqs - 1] = NULL;
+		callbacks[total_vqs - 1] = virtnet_cvq_done;
 		names[total_vqs - 1] = "control";
 	}
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
