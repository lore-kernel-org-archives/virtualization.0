Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B21C5479D
	for <virtualization@archiver.kernel.org>; Wed, 11 Jan 2023 06:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABE6780F59;
	Wed, 11 Jan 2023 06:28:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABE6780F59
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LuPlvOY0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iySQUQjS_c7P; Wed, 11 Jan 2023 06:28:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4CBF780DA5;
	Wed, 11 Jan 2023 06:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CBF780DA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A564C0032;
	Wed, 11 Jan 2023 06:28:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CF60C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B75960769
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B75960769
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LuPlvOY0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MHRw7edJNGrA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD089605B5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD089605B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 06:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673418511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZckiIF9GKaRv3ubvyyEtlLgDTx5PNnpA2vEzhFHbOU=;
 b=LuPlvOY0KuHe/Vt3AEb7etGK1dFN1k0m5nOX4eBUbH5bUYXL7LhjgHYlAz1zOUzD7TXNm3
 Hz21ZiF/hx5Cbd3rCXpynQsm6av74XxT85BY9s7YbxpHWAadb3Ti265xzt7r4gyokeAAsi
 GpIjywyKoaxHBPjvXTZNu5ftobA214k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-KCRmC12MPgyLAFenQKKLJw-1; Wed, 11 Jan 2023 01:28:28 -0500
X-MC-Unique: KCRmC12MPgyLAFenQKKLJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DCD187B2A0;
 Wed, 11 Jan 2023 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-175.pek2.redhat.com
 [10.72.13.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90A174078903;
 Wed, 11 Jan 2023 06:28:22 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/5] virtio-vdpa: support per vq dma device
Date: Wed, 11 Jan 2023 14:28:07 +0800
Message-Id: <20230111062809.25020-4-jasowang@redhat.com>
In-Reply-To: <20230111062809.25020-1-jasowang@redhat.com>
References: <20230111062809.25020-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: gdawar@amd.com, elic@nvidia.com, linux-kernel@vger.kernel.org,
 tanuj.kamde@amd.com, virtualization@lists.linux-foundation.org
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

This patch adds the support of per vq dma device for virito-vDPA. vDPA
parents then are allowed to use different DMA devices. This is useful
for the parents that have software or emulated virtqueues.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_vdpa.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9670cc79371d..d7f5af62ddaa 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -135,6 +135,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
+	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct virtio_vdpa_vq_info *info;
 	struct vdpa_callback cb;
@@ -175,9 +176,15 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
-	vq = vring_create_virtqueue(index, max_num, align, vdev,
-				    true, may_reduce_num, ctx,
-				    virtio_vdpa_notify, callback, name);
+
+	if (ops->get_vq_dma_dev)
+		dma_dev = ops->get_vq_dma_dev(vdpa, index);
+	else
+		dma_dev = vdpa_get_dma_dev(vdpa);
+	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
+					true, may_reduce_num, ctx,
+					virtio_vdpa_notify, callback,
+					name, dma_dev);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
