Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E107BC6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 697F441F66;
	Fri, 24 Mar 2023 15:39:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 697F441F66
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWo9+qSW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nn-VU9xwReI8; Fri, 24 Mar 2023 15:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9622C41DE9;
	Fri, 24 Mar 2023 15:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9622C41DE9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DDBEC0035;
	Fri, 24 Mar 2023 15:39:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92A40C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6D39C81FBE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D39C81FBE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YWo9+qSW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6VkPp4zCmtxr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 989C681FA0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 989C681FA0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVAueuORiKGKOw5iPuuD3Ux7+pQ6EAyahLBg2nxd2sw=;
 b=YWo9+qSWC35TJKScyq4XNA3nwz4tA3j0eBwXR9yRaBIs9mIV8QKoGfB6dmACMeqZUsbd80
 itYYNY34xA9HTguN4jnMDyc4+sznBX2HGSAAEv+EFW32DlVwNts+SOBHNynMdmacjRhSlr
 onApVaCIYGStztqhDwXBCWGp6dj4urw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-BQJUM3c5NF6XVtlAjldWtA-1; Fri, 24 Mar 2023 11:39:51 -0400
X-MC-Unique: BQJUM3c5NF6XVtlAjldWtA-1
Received: by mail-ed1-f72.google.com with SMTP id
 c11-20020a509f8b000000b00501e2facf47so3749801edf.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679672390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVAueuORiKGKOw5iPuuD3Ux7+pQ6EAyahLBg2nxd2sw=;
 b=AAsmeyvV9ZIsH/srhEhm/Ni/rH9SGZYlMUHeh48VRUrQU5s3k/QipHuxM5N2C/RgrX
 6q3yQogmC0gpj2GF7s4ddm2h5DolBXvln3TmKkWaRUMEsS7TBlQ88tGRx9+IdpTe79m8
 90SVlIS4sUgr/mTeQZ23hW9eTIIbunsBvwn129I/eaR5cy1nkFs8wcnNA0NTYA7/qVbW
 W00XzDK3shpFYKUfqx2gHeV/XHyRu0StEu9NLRrg3akaBtyhvs6LHgEarI1yAhCXgZpP
 3xvWHHsN3PT9SLqoyUZuBoNyAASH5AvrIRVeWJ7NTB9XcLQtJenvdHNogYOhhLsgmBUN
 D9Vw==
X-Gm-Message-State: AAQBX9c4QoglfFsgGmRem0i0UAvryrsFJL45himZwz/t4G4EirXk3rwU
 CC+4mZ//yPWlypUdNc6VR/4vLUpu7vCDXYmO/av2Im7da1PpgH4IAaXE11RpZi9w4MrNLP2FQGN
 YiCySYQri/qQKqGoSTfl18GpRuOeCirQQlKxk1x1O0a+7gxnquFpxLkBVzuXegXXZmpeU/cUblD
 +AM3mp71wV4vrlXxKuGl1ORJflCQ==
X-Received: by 2002:a17:906:3850:b0:92f:13b9:d498 with SMTP id
 w16-20020a170906385000b0092f13b9d498mr3253856ejc.36.1679672389944; 
 Fri, 24 Mar 2023 08:39:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZS/Tv/2sZYKBNsok47ghj98jKMPgUDCYS3M35Ue86ZuX6HibK2LvWo/dM7n1M7/gbQt5E3Dg==
X-Received: by 2002:a17:906:3850:b0:92f:13b9:d498 with SMTP id
 w16-20020a170906385000b0092f13b9d498mr3253829ejc.36.1679672389708; 
 Fri, 24 Mar 2023 08:39:49 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 sd24-20020a170906ce3800b00931024e96c5sm10571246ejb.99.2023.03.24.08.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 08:39:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 7/9] vdpa_sim: use kthread worker
Date: Fri, 24 Mar 2023 16:39:40 +0100
Message-Id: <20230324153940.47710-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
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

Let's use our own kthread to run device jobs.
This allows us more flexibility, especially we can attach the kthread
to the user address space when vDPA uses user's VA.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v3:
    - fix `dev` not initialized in the error path [Simon Horman]

 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index acee20faaf6a..ce83f9130a5d 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -57,7 +57,8 @@ struct vdpasim_dev_attr {
 struct vdpasim {
 	struct vdpa_device vdpa;
 	struct vdpasim_virtqueue *vqs;
-	struct work_struct work;
+	struct kthread_worker *worker;
+	struct kthread_work work;
 	struct vdpasim_dev_attr dev_attr;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2df5227e0b62..bd9f9054de94 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -11,8 +11,8 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
 #include <linux/dma-map-ops.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
@@ -127,7 +127,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
-static void vdpasim_work_fn(struct work_struct *work)
+static void vdpasim_work_fn(struct kthread_work *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
 
@@ -170,11 +170,17 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 
 	vdpasim = vdpa_to_sim(vdpa);
 	vdpasim->dev_attr = *dev_attr;
-	INIT_WORK(&vdpasim->work, vdpasim_work_fn);
+	dev = &vdpasim->vdpa.dev;
+
+	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
+	vdpasim->worker = kthread_create_worker(0, "vDPA sim worker: %s",
+						dev_attr->name);
+	if (IS_ERR(vdpasim->worker))
+		goto err_iommu;
+
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
 
-	dev = &vdpasim->vdpa.dev;
 	dev->dma_mask = &dev->coherent_dma_mask;
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		goto err_iommu;
@@ -223,7 +229,7 @@ EXPORT_SYMBOL_GPL(vdpasim_create);
 
 void vdpasim_schedule_work(struct vdpasim *vdpasim)
 {
-	schedule_work(&vdpasim->work);
+	kthread_queue_work(vdpasim->worker, &vdpasim->work);
 }
 EXPORT_SYMBOL_GPL(vdpasim_schedule_work);
 
@@ -623,7 +629,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
-	cancel_work_sync(&vdpasim->work);
+	kthread_cancel_work_sync(&vdpasim->work);
+	kthread_destroy_worker(vdpasim->worker);
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
 		vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
