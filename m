Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6132BC19F2C
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 05:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B0FD405D7;
	Tue, 16 Aug 2022 05:37:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B0FD405D7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DomaXCDj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wpuw6yoVtLgA; Tue, 16 Aug 2022 05:37:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6938E405D6;
	Tue, 16 Aug 2022 05:37:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6938E405D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42440C0033;
	Tue, 16 Aug 2022 05:37:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 422D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:37:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C164405D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:37:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C164405D9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iH_TdQTKWTgk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:37:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D217405D7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D217405D7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 05:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660628224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cpgv5FAeV4Xgxidc6icz1XaUm6ZCyxEOOOfQnaAl0aE=;
 b=DomaXCDjYbqgffqH0X7x1qWybgOpwdD0brymW+Oone3LuxtDgcMkFs21djX0cTQsBwRZvR
 DH3ZoRlAKt/H5uImPPweDSZbNHH8Ur7/4ZAkdqglPyXTL0cZP/l0tucj9m/fERy9NJXNHr
 kEc29tiAEFtn0grjFH82QBXzeGQEDqQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-A11WUhk3MDOUUjojSx3-ug-1; Tue, 16 Aug 2022 01:36:59 -0400
X-MC-Unique: A11WUhk3MDOUUjojSx3-ug-1
Received: by mail-wm1-f72.google.com with SMTP id
 203-20020a1c02d4000000b003a5f5bce876so1165186wmc.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 22:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Cpgv5FAeV4Xgxidc6icz1XaUm6ZCyxEOOOfQnaAl0aE=;
 b=ID6Xt2vV1NSnKmCc+mGl65UZYgE5mmwX9ustxNVEPOsnstR7brn5M3azbWbFubvLS4
 ZcSDcZdV//ZlGaXXQNqFQ/vXkULvWuV5vp6u12EddB7yg+apRujniXVJdc28dtrjkP0T
 CePGUDdAHHhumPOfoQpFW3UTBWN/2fvno/6JjgeUa39r+x8h1NDdPxMr5zauLvOx8la5
 OMcoOER+r/gNl8vhASGrArphtHgB3dgrX1yyEosjm9ZBtict2DtO9ZCKG9nybMwEk0Vj
 MPimxICF2u6RDOd3lXR7R3Y1Xbi6oaqyyGtDmF1IzL3Z8kh9e/sSMrqry72KASpo4iNP
 TBTg==
X-Gm-Message-State: ACgBeo0sw2KexeEICk9KXvD2rYBrk9XfgQlv9VOf+kEBwGpAu0M5LvrF
 jr+p//djvn3jPhdstDZk9YrO7Mqp7W2DDmw2YPRiYFvMi2rtDTc4Zx5DnoH+jC3LMJ2xrIhK+SC
 z/f/WrzCR7uRx+CLudywFcbDgwCg2yG8LOW0QFEOZfQ==
X-Received: by 2002:adf:f5cc:0:b0:221:7e3f:41eb with SMTP id
 k12-20020adff5cc000000b002217e3f41ebmr10278827wrp.551.1660628218609; 
 Mon, 15 Aug 2022 22:36:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5WDnzBpzupB051dVdRKYw1crDTF90RoLhqKzZL00iu8qEeaHBRmDf/lNXmgrH/YzznHXnhuA==
X-Received: by 2002:adf:f5cc:0:b0:221:7e3f:41eb with SMTP id
 k12-20020adff5cc000000b002217e3f41ebmr10278814wrp.551.1660628218337; 
 Mon, 15 Aug 2022 22:36:58 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 f16-20020adfb610000000b002237fd66585sm8918606wre.92.2022.08.15.22.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 22:36:57 -0700 (PDT)
Date: Tue, 16 Aug 2022 01:36:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/6] virtio: Revert "virtio: find_vqs() add arg sizes"
Message-ID: <20220816053602.173815-8-mst@redhat.com>
References: <20220816053602.173815-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220816053602.173815-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, kvm@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Johannes Berg <johannes@sipsolutions.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

This reverts commit a10fba0377145fccefea4dc4dd5915b7ed87e546: the
proposed API isn't supported on all transports but no
effort was made to address this.

It might not be hard to fix if we want to: maybe just
rename size to size_hint and make sure legacy
transports ignore the hint.

But it's not sure what the benefit is in any case, so
let's drop it.

Fixes: a10fba037714 ("virtio: find_vqs() add arg sizes")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/um/drivers/virtio_uml.c             |  2 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c |  1 -
 drivers/remoteproc/remoteproc_virtio.c   |  1 -
 drivers/s390/virtio/virtio_ccw.c         |  1 -
 drivers/virtio/virtio_mmio.c             |  1 -
 drivers/virtio/virtio_pci_common.c       |  2 +-
 drivers/virtio/virtio_pci_common.h       |  2 +-
 drivers/virtio/virtio_pci_modern.c       |  7 ++-----
 drivers/virtio/virtio_vdpa.c             |  1 -
 include/linux/virtio_config.h            | 14 +++++---------
 10 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 79e38afd4b91..e719af8bdf56 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1011,7 +1011,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 
 static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		       const char * const names[], u32 sizes[], const bool *ctx,
+		       const char * const names[], const bool *ctx,
 		       struct irq_affinity *desc)
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 8be13d416f48..1ae3c56b66b0 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -928,7 +928,6 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 					struct virtqueue *vqs[],
 					vq_callback_t *callbacks[],
 					const char * const names[],
-					u32 sizes[],
 					const bool *ctx,
 					struct irq_affinity *desc)
 {
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 81c4f5776109..0f7706e23eb9 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -158,7 +158,6 @@ static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 struct virtqueue *vqs[],
 				 vq_callback_t *callbacks[],
 				 const char * const names[],
-				 u32 sizes[],
 				 const bool * ctx,
 				 struct irq_affinity *desc)
 {
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 896896e32664..a10dbe632ef9 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -637,7 +637,6 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			       struct virtqueue *vqs[],
 			       vq_callback_t *callbacks[],
 			       const char * const names[],
-			       u32 sizes[],
 			       const bool *ctx,
 			       struct irq_affinity *desc)
 {
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index dfcecfd7aba1..3ff746e3f24a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -474,7 +474,6 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		       struct virtqueue *vqs[],
 		       vq_callback_t *callbacks[],
 		       const char * const names[],
-		       u32 sizes[],
 		       const bool *ctx,
 		       struct irq_affinity *desc)
 {
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 7ad734584823..ad258a9d3b9f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -396,7 +396,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], u32 sizes[], const bool *ctx,
+		const char * const names[], const bool *ctx,
 		struct irq_affinity *desc)
 {
 	int err;
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index a5ff838b85a5..23112d84218f 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -110,7 +110,7 @@ void vp_del_vqs(struct virtio_device *vdev);
 /* the config->find_vqs() implementation */
 int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], u32 sizes[], const bool *ctx,
+		const char * const names[], const bool *ctx,
 		struct irq_affinity *desc);
 const char *vp_bus_name(struct virtio_device *vdev);
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index be51ec849252..c3b9f2761849 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -347,15 +347,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			      struct virtqueue *vqs[],
 			      vq_callback_t *callbacks[],
-			      const char * const names[],
-			      u32 sizes[],
-			      const bool *ctx,
+			      const char * const names[], const bool *ctx,
 			      struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq;
-	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, sizes, ctx,
-			     desc);
+	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
 
 	if (rc)
 		return rc;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 832d2c5b1b19..9670cc79371d 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -269,7 +269,6 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				struct virtqueue *vqs[],
 				vq_callback_t *callbacks[],
 				const char * const names[],
-				u32 sizes[],
 				const bool *ctx,
 				struct irq_affinity *desc)
 {
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 888f7e96f0c7..36ec7be1f480 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -55,7 +55,6 @@ struct virtio_shm_region {
  *		include a NULL entry for vqs that do not need a callback
  *	names: array of virtqueue names (mainly for debugging)
  *		include a NULL entry for vqs unused by driver
- *	sizes: array of virtqueue sizes
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
@@ -104,9 +103,7 @@ struct virtio_config_ops {
 	void (*reset)(struct virtio_device *vdev);
 	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[],
-			u32 sizes[],
-			const bool *ctx,
+			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
@@ -215,7 +212,7 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 	const char *names[] = { n };
 	struct virtqueue *vq;
 	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names, NULL,
-					 NULL, NULL);
+					 NULL);
 	if (err < 0)
 		return ERR_PTR(err);
 	return vq;
@@ -227,8 +224,7 @@ int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			const char * const names[],
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL,
-				      NULL, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
 }
 
 static inline
@@ -237,8 +233,8 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL,
-				      ctx, desc);
+	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
+				      desc);
 }
 
 /**
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
