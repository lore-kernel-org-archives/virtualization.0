Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEA7C4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 16:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 565FD410DB;
	Wed, 14 Dec 2022 16:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 565FD410DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cDCSKc3s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nyRis8fUgn23; Wed, 14 Dec 2022 16:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7965F41830;
	Wed, 14 Dec 2022 16:31:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7965F41830
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49976C0033;
	Wed, 14 Dec 2022 16:31:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CCE2C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 128BF81F39
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 128BF81F39
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cDCSKc3s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9FfzYSebCB4i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7AB1181EFA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AB1181EFA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671035461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNeRnQ41YTwI7Dv9IlQ//H1saK0wcCg2ACIcfcXrP3k=;
 b=cDCSKc3sQC42VbblfYFB+8h0Oo49GJokUm+GB7G/amdu6Ej31FqXHAQAzPIrChp2QMfRxu
 C2IY8PunIKtaetdkTRT3Wt4haz0idtwJtMjm8eqX9FRuelEGB39uuTsXFLabOtEz7MMrp4
 Q9Io9N9N4ygMH+zxxo1c9SCRPPw3phA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-CuTxhJ5QMk6pCmeXDkmClw-1; Wed, 14 Dec 2022 11:31:00 -0500
X-MC-Unique: CuTxhJ5QMk6pCmeXDkmClw-1
Received: by mail-wr1-f69.google.com with SMTP id
 o8-20020adfba08000000b00241e80f08e0so60509wrg.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNeRnQ41YTwI7Dv9IlQ//H1saK0wcCg2ACIcfcXrP3k=;
 b=4GPCcB0vYsqTgD8d5M/L3+Fqw++rkLxUzK0vmCYcED+3eJv6ynfcARb4lPAWn0r430
 t/CHbwQIWYU1+fYdlMfBznzYU6nId8Gi+s1TQZAwccSmsFqSrpLdUhAeUWocC5DZyvdA
 dtFF9DRdQjKCnXCsmaukWWncbqo1/sajx7aZkvxNbbwhl7T+yCr9qpxUbZZ39ffBrNSh
 A6+fe3BbPsGTKqFoOrkh7Msh7LYY8GXrW/ZVEH3TwUjzuDhwp5QkNdvdEjHCxO6OiVof
 cCALU+TVmX/8O9z8XQMDx7X3RAFD9xl7hBH4I/OCFwGiGtOye5p5NWpT6aRnAn+AHYRw
 4REw==
X-Gm-Message-State: ANoB5pnaGjGxmFnb5jbftL9vHEGKgQiCey1KYS13aaXdl0s+1hpgGuWN
 Pqa5xbUDLKf8jFbqKhYXMKDDLdIAR8ifXL/HKVm21DA00BeZCp+ZWZpigc2h2NraKJwUSG5RjqB
 jaoeMA/cePXaXM0+TDvzLl1gWeaAdA3OxVUuxekERNkX2MBbaguxiK79KOm5gy81f7KZS5P3xs0
 FX4Wn5pwO9O+r06LIN8w==
X-Received: by 2002:a05:600c:3b15:b0:3d0:d177:cac1 with SMTP id
 m21-20020a05600c3b1500b003d0d177cac1mr19372606wms.36.1671035458617; 
 Wed, 14 Dec 2022 08:30:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf41TbDFZYAxyeY/6/VgR7BHHW22n4sdvEUddOO8zMQQsvGDfuNF6JjoQjUcHxV0WQ+cml5BAg==
X-Received: by 2002:a05:600c:3b15:b0:3d0:d177:cac1 with SMTP id
 m21-20020a05600c3b1500b003d0d177cac1mr19372586wms.36.1671035458429; 
 Wed, 14 Dec 2022 08:30:58 -0800 (PST)
Received: from step1.redhat.com (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 c6-20020a05600c0a4600b003d1e3b1624dsm3850323wmq.2.2022.12.14.08.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 08:30:57 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 5/6] vdpa_sim: use kthread worker
Date: Wed, 14 Dec 2022 17:30:24 +0100
Message-Id: <20221214163025.103075-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214163025.103075-1-sgarzare@redhat.com>
References: <20221214163025.103075-1-sgarzare@redhat.com>
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

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 17 ++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 7e6dd366856f..07ef53ea375e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -53,7 +53,8 @@ struct vdpasim_dev_attr {
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
index 9bde33e38e27..36a1d2e0a6ba 100644
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
@@ -245,7 +245,7 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
-static void vdpasim_work_fn(struct work_struct *work)
+static void vdpasim_work_fn(struct kthread_work *work)
 {
 	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
 
@@ -282,7 +282,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	}
 
 	vdpasim->dev_attr = *dev_attr;
-	INIT_WORK(&vdpasim->work, vdpasim_work_fn);
+
+	kthread_init_work(&vdpasim->work, vdpasim_work_fn);
+	vdpasim->worker = kthread_create_worker(0, "vDPA sim worker: %s",
+						dev_attr->name);
+	if (IS_ERR(vdpasim->worker))
+		goto err_iommu;
+
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
 
@@ -338,7 +344,7 @@ EXPORT_SYMBOL_GPL(vdpasim_create);
 
 void vdpasim_schedule_work(struct vdpasim *vdpasim)
 {
-	schedule_work(&vdpasim->work);
+	kthread_queue_work(vdpasim->worker, &vdpasim->work);
 }
 EXPORT_SYMBOL_GPL(vdpasim_schedule_work);
 
@@ -689,7 +695,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	int i;
 
-	cancel_work_sync(&vdpasim->work);
+	kthread_cancel_work_sync(&vdpasim->work);
+	kthread_destroy_worker(vdpasim->worker);
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
 		vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
