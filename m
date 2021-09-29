Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4636DC4332F
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEAE061108
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 15:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEAE061108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7281610D8;
	Wed, 29 Sep 2021 15:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id evgtzWIMI4AQ; Wed, 29 Sep 2021 15:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 337C960EAA;
	Wed, 29 Sep 2021 15:11:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05632C0011;
	Wed, 29 Sep 2021 15:11:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14B0AC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67B9560C1B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A0iBfhy_tPhT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24EC760E8F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1632928287;
 x=1664464287; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=I+ZMDQoEY380qKi1YymoFVScbq3gPR3k5KyEBTna3rA=;
 b=ofCnioe64Jgl2tehEN04FooySNEf2QNyQQ0OB4yXG0pM29XZ+vh4KRHk
 wo6Kw1NGOxNPkZpvr6wVsBzlDNNZf7ZzWX7D2ITJom0BaG1WB90z21Ltm
 K7Sa/P+6zHJ9zNln0iULJvBMrgI9eVEfpxNhYrxZ5vbBPBNNF5KTEXn2l
 11hm+b6waMNe4jMaazf0nhmxOwGAy9pVPrFJwY5E7u20bKpDgdYxrtdCN
 RWDhfPSJWcgak5UDdrHjfhx0bEUnn1wqXynQ58frguUxrZ4YNmpkxqT2X
 2tx+Q89m5zrEeSlSSa730Fy8LtSmvbonFLev6AZ+hwbndT5xvkqpWP4Up w==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <mst@redhat.com>, <jasowang@redhat.com>
Subject: [RFC PATCH 06/10] vhost: extract ioctl locking to common code
Date: Wed, 29 Sep 2021 17:11:15 +0200
Message-ID: <20210929151119.14778-7-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210929151119.14778-1-vincent.whitchurch@axis.com>
References: <20210929151119.14778-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@axis.com,
 stefanha@redhat.com, pbonzini@redhat.com
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

Extract the mutex locking for the vhost ioctl into common code.  This
will allow the common code to easily add some extra handling required
for adding a kernel API to control vhost.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/vhost/common.c |  7 ++++++-
 drivers/vhost/net.c    | 14 +-------------
 drivers/vhost/vhost.c  | 10 ++++++++--
 drivers/vhost/vhost.h  |  1 +
 drivers/vhost/vsock.c  | 12 ------------
 5 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/vhost/common.c b/drivers/vhost/common.c
index 27d4672b15d3..a5722ad65e24 100644
--- a/drivers/vhost/common.c
+++ b/drivers/vhost/common.c
@@ -60,8 +60,13 @@ static long vhost_ioctl(struct file *file, unsigned int ioctl, unsigned long arg
 {
 	struct vhost_dev *dev = file->private_data;
 	struct vhost *vhost = dev->vhost;
+	long ret;
 
-	return vhost->ops->ioctl(dev, ioctl, arg);
+	mutex_lock(&dev->mutex);
+	ret = vhost->ops->ioctl(dev, ioctl, arg);
+	mutex_unlock(&dev->mutex);
+
+	return ret;
 }
 
 static ssize_t vhost_read_iter(struct kiocb *iocb, struct iov_iter *to)
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8910d9e2a74e..b5590b7862a9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1505,7 +1505,6 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	struct vhost_net_ubuf_ref *ubufs, *oldubufs = NULL;
 	int r;
 
-	mutex_lock(&n->dev.mutex);
 	r = vhost_dev_check_owner(&n->dev);
 	if (r)
 		goto err;
@@ -1573,7 +1572,6 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		sockfd_put(oldsock);
 	}
 
-	mutex_unlock(&n->dev.mutex);
 	return 0;
 
 err_used:
@@ -1587,7 +1585,6 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 err_vq:
 	mutex_unlock(&vq->mutex);
 err:
-	mutex_unlock(&n->dev.mutex);
 	return r;
 }
 
@@ -1598,7 +1595,6 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	long err;
 	struct vhost_iotlb *umem;
 
-	mutex_lock(&n->dev.mutex);
 	err = vhost_dev_check_owner(&n->dev);
 	if (err)
 		goto done;
@@ -1613,7 +1609,6 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	vhost_dev_reset_owner(&n->dev, umem);
 	vhost_net_vq_reset(n);
 done:
-	mutex_unlock(&n->dev.mutex);
 	if (tx_sock)
 		sockfd_put(tx_sock);
 	if (rx_sock)
@@ -1639,7 +1634,6 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 		vhost_hlen = 0;
 		sock_hlen = hdr_len;
 	}
-	mutex_lock(&n->dev.mutex);
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&n->dev))
 		goto out_unlock;
@@ -1656,11 +1650,9 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 		n->vqs[i].sock_hlen = sock_hlen;
 		mutex_unlock(&n->vqs[i].vq.mutex);
 	}
-	mutex_unlock(&n->dev.mutex);
 	return 0;
 
 out_unlock:
-	mutex_unlock(&n->dev.mutex);
 	return -EFAULT;
 }
 
@@ -1668,7 +1660,6 @@ static long vhost_net_set_owner(struct vhost_net *n)
 {
 	int r;
 
-	mutex_lock(&n->dev.mutex);
 	if (vhost_dev_has_owner(&n->dev)) {
 		r = -EBUSY;
 		goto out;
@@ -1681,7 +1672,6 @@ static long vhost_net_set_owner(struct vhost_net *n)
 		vhost_net_clear_ubuf_info(n);
 	vhost_net_flush(n);
 out:
-	mutex_unlock(&n->dev.mutex);
 	return r;
 }
 
@@ -1721,20 +1711,18 @@ static long vhost_net_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_BACKEND_FEATURES)
 			return -EOPNOTSUPP;
-		vhost_set_backend_features(&n->dev, features);
+		__vhost_set_backend_features(&n->dev, features);
 		return 0;
 	case VHOST_RESET_OWNER:
 		return vhost_net_reset_owner(n);
 	case VHOST_SET_OWNER:
 		return vhost_net_set_owner(n);
 	default:
-		mutex_lock(&n->dev.mutex);
 		r = vhost_dev_ioctl(&n->dev, ioctl, argp);
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&n->dev, ioctl, argp);
 		else
 			vhost_net_flush(n);
-		mutex_unlock(&n->dev.mutex);
 		return r;
 	}
 }
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9354061ce75e..9d6496b7ad85 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2821,18 +2821,24 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 }
 EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
 
-void vhost_set_backend_features(struct vhost_dev *dev, u64 features)
+void __vhost_set_backend_features(struct vhost_dev *dev, u64 features)
 {
 	struct vhost_virtqueue *vq;
 	int i;
 
-	mutex_lock(&dev->mutex);
 	for (i = 0; i < dev->nvqs; ++i) {
 		vq = dev->vqs[i];
 		mutex_lock(&vq->mutex);
 		vq->acked_backend_features = features;
 		mutex_unlock(&vq->mutex);
 	}
+}
+EXPORT_SYMBOL_GPL(__vhost_set_backend_features);
+
+void vhost_set_backend_features(struct vhost_dev *dev, u64 features)
+{
+	mutex_lock(&dev->mutex);
+	__vhost_set_backend_features(dev, features);
 	mutex_unlock(&dev->mutex);
 }
 EXPORT_SYMBOL_GPL(vhost_set_backend_features);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 562387b92730..408ff243ed31 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -302,6 +302,7 @@ void vhost_enqueue_msg(struct vhost_dev *dev,
 struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 					 struct list_head *head);
 void vhost_set_backend_features(struct vhost_dev *dev, u64 features);
+void __vhost_set_backend_features(struct vhost_dev *dev, u64 features);
 
 __poll_t vhost_chr_poll(struct file *file, struct vhost_dev *dev,
 			    poll_table *wait);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 93f74a0010d5..062767636226 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -583,8 +583,6 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	size_t i;
 	int ret;
 
-	mutex_lock(&vsock->dev.mutex);
-
 	ret = vhost_dev_check_owner(&vsock->dev);
 	if (ret)
 		goto err;
@@ -614,7 +612,6 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 	 */
 	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
 
-	mutex_unlock(&vsock->dev.mutex);
 	return 0;
 
 err_vq:
@@ -629,7 +626,6 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
 		mutex_unlock(&vq->mutex);
 	}
 err:
-	mutex_unlock(&vsock->dev.mutex);
 	return ret;
 }
 
@@ -638,8 +634,6 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock)
 	size_t i;
 	int ret;
 
-	mutex_lock(&vsock->dev.mutex);
-
 	ret = vhost_dev_check_owner(&vsock->dev);
 	if (ret)
 		goto err;
@@ -653,7 +647,6 @@ static int vhost_vsock_stop(struct vhost_vsock *vsock)
 	}
 
 err:
-	mutex_unlock(&vsock->dev.mutex);
 	return ret;
 }
 
@@ -821,7 +814,6 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if (features & ~VHOST_VSOCK_FEATURES)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&vsock->dev.mutex);
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&vsock->dev)) {
 		goto err;
@@ -841,11 +833,9 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		vq->acked_features = features;
 		mutex_unlock(&vq->mutex);
 	}
-	mutex_unlock(&vsock->dev.mutex);
 	return 0;
 
 err:
-	mutex_unlock(&vsock->dev.mutex);
 	return -EFAULT;
 }
 
@@ -893,13 +883,11 @@ static long vhost_vsock_dev_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 		vhost_set_backend_features(&vsock->dev, features);
 		return 0;
 	default:
-		mutex_lock(&vsock->dev.mutex);
 		r = vhost_dev_ioctl(&vsock->dev, ioctl, argp);
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&vsock->dev, ioctl, argp);
 		else
 			vhost_vsock_flush(vsock);
-		mutex_unlock(&vsock->dev.mutex);
 		return r;
 	}
 }
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
