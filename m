Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2890DC63797
	for <virtualization@archiver.kernel.org>; Tue, 17 Jan 2023 15:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F08E81F4B;
	Tue, 17 Jan 2023 15:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F08E81F4B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IaaJyCgc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCKVYTuQhEYM; Tue, 17 Jan 2023 15:16:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C4A581FCE;
	Tue, 17 Jan 2023 15:16:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C4A581FCE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA5FC0032;
	Tue, 17 Jan 2023 15:16:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 121D9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2D7160BDD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2D7160BDD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IaaJyCgc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DKoiGoXnXcoZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 178C660BCE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 178C660BCE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Jan 2023 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673968573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asTM0g0Ag1HWYFfqMWuusWwOifr4sTs9wZ4Ph94PRks=;
 b=IaaJyCgcjpfir7yymzgASs1ESVevY3g8D1e7pc6OGZz+EZiq8OAbjkv2uBqtdWiWW4PMwM
 dQtounFQI387Mv70+jkSDms2xYeYMz77dr2hT9ohN1FKmWcFkgxG0wwwkh+GXXq+uubqi6
 J+ZwUNJLBi61dQ9eXBSmYUaZbp/sVTY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-3VwgVySaOGu7fIeoVyop0w-1; Tue, 17 Jan 2023 10:16:09 -0500
X-MC-Unique: 3VwgVySaOGu7fIeoVyop0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE44D3C5C966;
 Tue, 17 Jan 2023 15:15:22 +0000 (UTC)
Received: from qualcomm-amberwing-rep-06.khw4.lab.eng.bos.redhat.com
 (qualcomm-amberwing-rep-06.khw4.lab.eng.bos.redhat.com [10.19.240.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8383540C6EC4;
 Tue, 17 Jan 2023 15:15:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] vhost/net: Clear the pending messages when the backend is
 removed
Date: Tue, 17 Jan 2023 10:15:18 -0500
Message-Id: <20230117151518.44725-3-eric.auger@redhat.com>
In-Reply-To: <20230117151518.44725-1-eric.auger@redhat.com>
References: <20230117151518.44725-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: lvivier@redhat.com
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

When the vhost iotlb is used along with a guest virtual iommu
and the guest gets rebooted, some MISS messages may have been
recorded just before the reboot and spuriously executed by
the virtual iommu after the reboot.

As vhost does not have any explicit reset user API,
VHOST_NET_SET_BACKEND looks a reasonable point where to clear
the pending messages, in case the backend is removed.

Export vhost_clear_msg() and call it in vhost_net_set_backend()
when fd == -1.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")

---

Without this patch, with QEMU virtio-iommu, on reboot, we get
spurious messages such as

qemu-kvm: virtio_iommu_translate no mapping for 0xff732800 for sid=1536
---
 drivers/vhost/net.c   | 3 +++
 drivers/vhost/vhost.c | 3 ++-
 drivers/vhost/vhost.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 135e23254a26..383f8f2ae131 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1511,6 +1511,9 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	nvq = &n->vqs[index];
 	mutex_lock(&vq->mutex);
 
+	if (fd == -1)
+		vhost_clear_msg(&n->dev);
+
 	/* Verify that ring has been setup correctly. */
 	if (!vhost_vq_access_ok(vq)) {
 		r = -EFAULT;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 34458e203716..f11bdbe4c2c5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -661,7 +661,7 @@ void vhost_dev_stop(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_stop);
 
-static void vhost_clear_msg(struct vhost_dev *dev)
+void vhost_clear_msg(struct vhost_dev *dev)
 {
 	struct vhost_msg_node *node, *n;
 
@@ -679,6 +679,7 @@ static void vhost_clear_msg(struct vhost_dev *dev)
 
 	spin_unlock(&dev->iotlb_lock);
 }
+EXPORT_SYMBOL_GPL(vhost_clear_msg);
 
 void vhost_dev_cleanup(struct vhost_dev *dev)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 4bfa10e52297..1647b750169c 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -181,6 +181,7 @@ long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
 bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
 bool vhost_log_access_ok(struct vhost_dev *);
+void vhost_clear_msg(struct vhost_dev *dev);
 
 int vhost_get_vq_desc(struct vhost_virtqueue *,
 		      struct iovec iov[], unsigned int iov_count,
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
