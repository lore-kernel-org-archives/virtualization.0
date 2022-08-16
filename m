Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAB2C19F2C
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 05:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00653404B7;
	Tue, 16 Aug 2022 05:36:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00653404B7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFDNSbvK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NCTimURorKXi; Tue, 16 Aug 2022 05:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6A97440537;
	Tue, 16 Aug 2022 05:36:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A97440537
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5222FC0033;
	Tue, 16 Aug 2022 05:36:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49EF1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 159C481AD1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 159C481AD1
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFDNSbvK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jEqcIn6t_pM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3141681AC4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3141681AC4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660628203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7KUDnR7ITSXzGuGHvfD+T/glFccQWZ3L+AQhNkH7LGU=;
 b=FFDNSbvKIMyhgkWAHIlH9TLopnddZ1QYJdfEI5zcoeTR2+l12UDZ4RP6SVqkFjrReeN8nt
 3eZlyQXfOtmWetqEq0IOi2KxrRN7F70jgZmNSNbjrTZk9Y6VhEZHHhEIR54ZPYQoKLrgXs
 aNaJI3YeOs4xp4ulJDcv5h38hp9x0N4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-UuXRw3rzPDe8fKwKHdu5cg-1; Tue, 16 Aug 2022 01:36:42 -0400
X-MC-Unique: UuXRw3rzPDe8fKwKHdu5cg-1
Received: by mail-wm1-f70.google.com with SMTP id
 b4-20020a05600c4e0400b003a5a96f1756so9752901wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=7KUDnR7ITSXzGuGHvfD+T/glFccQWZ3L+AQhNkH7LGU=;
 b=uJIGd9ccNNw71/+AhDbs32OWa6el3cWhSKqxaR+IaSkeOIxNU1t3Yj4y/fC2b+Ge3h
 DyUAn4o5M084V53UqmxcT4HQov6DcwxKtUMud61vOW3/+U1gLY/Z8XsSDEJA1GYz6els
 /ubvy3iatWgoW+1M7+IjXiisHXoTnv4KPBB3JDW9cvJM38d5qDBqDaTjDqy5ZRvKlzTM
 oUy7H7lCaY80Z/iBS3JAg4jGfm3KjYQOfucIaN2Oz+uj9oTRaY8RJHREqL93crkqyhkR
 gc7jd4FA7TO56Z3HMtheyKODJTBZGB6Z7l5ykKjtKug3ptZmHya263FLRsui2M9gT+Ah
 zlqg==
X-Gm-Message-State: ACgBeo1N2a8qKR92OhjqXP+2bx12KTXU+bh63vLCUFHiydfAWyFmrmz0
 gz3WfF46NanP086FCmucncm1snmta9HQJBOdUx+ywfo0ceK7jcXYAiQZjfsnq239WGQ6SuwrdpA
 fpvLSTodZ2nfFNWaOJqQ9tAIpXJ9bbOnl2XEr6d0/Sg==
X-Received: by 2002:a05:600c:1c83:b0:3a3:1f70:25a5 with SMTP id
 k3-20020a05600c1c8300b003a31f7025a5mr18412699wms.54.1660628201009; 
 Mon, 15 Aug 2022 22:36:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4kzmUA2mS0iZBrt5q7gKzWHCvCko36MWp8hTvWspyQu/9LQBLLi7D8U8GszfgwIHA29QVLJw==
X-Received: by 2002:a05:600c:1c83:b0:3a3:1f70:25a5 with SMTP id
 k3-20020a05600c1c8300b003a31f7025a5mr18412690wms.54.1660628200817; 
 Mon, 15 Aug 2022 22:36:40 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 q18-20020adff952000000b00222ed7ea203sm8819074wrr.100.2022.08.15.22.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 22:36:40 -0700 (PDT)
Date: Tue, 16 Aug 2022 01:36:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] virtio_pci: Revert "virtio_pci: support the arg sizes
 of find_vqs()"
Message-ID: <20220816053602.173815-5-mst@redhat.com>
References: <20220816053602.173815-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220816053602.173815-1-mst@redhat.com>
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
