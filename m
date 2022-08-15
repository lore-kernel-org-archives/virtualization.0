Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E22C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 22:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 448A660BD1;
	Mon, 15 Aug 2022 22:00:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 448A660BD1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b+AjDAEs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id deCxOAXhKWHh; Mon, 15 Aug 2022 22:00:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A09B060C00;
	Mon, 15 Aug 2022 22:00:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A09B060C00
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76EC0C0033;
	Mon, 15 Aug 2022 22:00:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D8D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24E3B4091F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24E3B4091F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b+AjDAEs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WYHm11DTAp9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B85A940928
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B85A940928
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KUDnR7ITSXzGuGHvfD+T/glFccQWZ3L+AQhNkH7LGU=;
 b=b+AjDAEs+DdwtgnM8bqZLqMJkCm2Rn14rWWQtzRR43eREEhqapuoQqviNwBBSbQvR5Mm8B
 2foS3KJcBbrFpRjevVtJb4DLPyAAlxbWOTreoL5eJBL2aHUwP0ed/eAH/TDwwH9yVJFQl0
 zF3t9z9Qogs/uwI+U8I4qxqzi4hB3x8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-258-K1S78uooPBG9lBuLOi0tuQ-1; Mon, 15 Aug 2022 18:00:46 -0400
X-MC-Unique: K1S78uooPBG9lBuLOi0tuQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 r10-20020a1c440a000000b003a538a648a9so4059110wma.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 15:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=7KUDnR7ITSXzGuGHvfD+T/glFccQWZ3L+AQhNkH7LGU=;
 b=JM254COd8xgnsN2RLZ2W08LAU/u4lCqpGsAPzPelizmiyKc3dA5fzahiKobiGdANJa
 7Cv29yrUPfDRh4tRLxvFGl6lDaF1xolXxed1MRN40d6NmxvBaA20RU76Mr6WnsmenRcu
 DEs19/oAcaq1+M5GtHlNOxuVjglO47EQHdlNSd4Foxi2yhquxrvfYQjptsk/cxXrkn+b
 lceU47fznjU5qcOlVflURBX/Nb2Xj5momeshoPtwOA5EE/13IeW7vMRzKMWIIUAbicG6
 guwD1QSVnP2J54UxIDxTGtRSybA/tvbBnzrpgG6ZJ8Y0vUJyxJWUHyrGLaSjdCydCtuI
 VZ/Q==
X-Gm-Message-State: ACgBeo3G4FFcOz/cKBD6RpnS6TfUvjlCueY3CitRrk6njQlgPyVGkOwp
 XvTeqQYgXoyB6qKCRxTggy1XVx4Mj24qUR+nPvjT/chFkH4/LpKm/EZ1yc/9nXmeIlfiQq2Uubh
 tNghkIxQdC5G3fYKdU1YjOZoJaaZ5caCkk7Lpxw6zPw==
X-Received: by 2002:a05:600c:358f:b0:3a6:145:3500 with SMTP id
 p15-20020a05600c358f00b003a601453500mr2046650wmq.64.1660600844624; 
 Mon, 15 Aug 2022 15:00:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6WCFuGg9upvrqQLwAIMM4ryrLP+E8uF7ygRp/dZWuWUWEYADUwzC8oycIWsYI1j8TJ28ZrWw==
X-Received: by 2002:a05:600c:358f:b0:3a6:145:3500 with SMTP id
 p15-20020a05600c358f00b003a601453500mr2046641wmq.64.1660600844389; 
 Mon, 15 Aug 2022 15:00:44 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 h1-20020a5d4301000000b0021d221daccfsm8247911wrq.78.2022.08.15.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 15:00:43 -0700 (PDT)
Date: Mon, 15 Aug 2022 18:00:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] virtio_pci: Revert "virtio_pci: support the arg sizes
 of find_vqs()"
Message-ID: <20220815215938.154999-5-mst@redhat.com>
References: <20220815215938.154999-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220815215938.154999-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Andres Freund <andres@anarazel.de>,
 Greg KH <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

This reverts commit cdb44806fca2d0ad29ca644cbf1505433902ee0c: the legacy
path is wrong and in fact can not support the proposed API since for a
legacy device we never communicate the vq size to the hypervisor.

Reported-by: Andres Freund <andres@anarazel.de>
Fixes: cdb44806fca2 ("virtio_pci: support the arg sizes of find_vqs()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 18 ++++++++----------
 drivers/virtio/virtio_pci_common.h |  1 -
 drivers/virtio/virtio_pci_legacy.c |  6 +-----
 drivers/virtio/virtio_pci_modern.c | 10 +++-------
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 00ad476a815d..7ad734584823 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -174,7 +174,6 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 				     void (*callback)(struct virtqueue *vq),
 				     const char *name,
-				     u32 size,
 				     bool ctx,
 				     u16 msix_vec)
 {
@@ -187,7 +186,7 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, size, ctx,
+	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
 			      msix_vec);
 	if (IS_ERR(vq))
 		goto out_info;
@@ -284,7 +283,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], u32 sizes[], bool per_vq_vectors,
+		const char * const names[], bool per_vq_vectors,
 		const bool *ctx,
 		struct irq_affinity *desc)
 {
@@ -327,8 +326,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     sizes ? sizes[i] : 0,
-				     ctx ? ctx[i] : false, msix_vec);
+				     ctx ? ctx[i] : false,
+				     msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -358,7 +357,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 
 static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], u32 sizes[], const bool *ctx)
+		const char * const names[], const bool *ctx)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i, err, queue_idx = 0;
@@ -380,7 +379,6 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     sizes ? sizes[i] : 0,
 				     ctx ? ctx[i] : false,
 				     VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
@@ -404,15 +402,15 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, sizes, true, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, sizes, false, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
 	if (!err)
 		return 0;
 	/* Finally fall back to regular interrupts. */
-	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, sizes, ctx);
+	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
 }
 
 const char *vp_bus_name(struct virtio_device *vdev)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index c0448378b698..a5ff838b85a5 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -80,7 +80,6 @@ struct virtio_pci_device {
 				      unsigned int idx,
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name,
-				      u32 size,
 				      bool ctx,
 				      u16 msix_vec);
 	void (*del_vq)(struct virtio_pci_vq_info *info);
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index d75e5c4e637f..2257f1b3d8ae 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -112,7 +112,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  unsigned int index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
-				  u32 size,
 				  bool ctx,
 				  u16 msix_vec)
 {
@@ -126,13 +125,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_legacy_get_queue_enable(&vp_dev->ldev, index))
 		return ERR_PTR(-ENOENT);
 
-	if (!size || size > num)
-		size = num;
-
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
-	vq = vring_create_virtqueue(index, size,
+	vq = vring_create_virtqueue(index, num,
 				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
 				    true, false, ctx,
 				    vp_notify, callback, name);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f7965c5dd36b..be51ec849252 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -293,7 +293,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  unsigned int index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
-				  u32 size,
 				  bool ctx,
 				  u16 msix_vec)
 {
@@ -311,18 +310,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
-	if (!size || size > num)
-		size = num;
-
-	if (size & (size - 1)) {
-		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", size);
+	if (num & (num - 1)) {
+		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
 	}
 
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
-	vq = vring_create_virtqueue(index, size,
+	vq = vring_create_virtqueue(index, num,
 				    SMP_CACHE_BYTES, &vp_dev->vdev,
 				    true, true, ctx,
 				    vp_notify, callback, name);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
