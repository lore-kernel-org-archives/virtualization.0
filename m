Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EE0C001B2
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 16:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D24E181F6A;
	Wed, 14 Dec 2022 16:31:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D24E181F6A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TBApN3X7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6-SprOPxe7JI; Wed, 14 Dec 2022 16:31:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 433C781F42;
	Wed, 14 Dec 2022 16:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 433C781F42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 093C1C0071;
	Wed, 14 Dec 2022 16:31:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14F48C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3321081EFA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3321081EFA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cfeyb8i0qiQg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF02481F18
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF02481F18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671035461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+wOP66zSvRhQYDjszQYz+C5vn4h5BGATu0cy0bUORc=;
 b=TBApN3X70e48JNCw5FWm6xr4iHVTKQAuAKzczQUTPCtN1lJwfkrSpFRsND3gDMl/23Yxc3
 yaVx0TqoVbTY1ZuUkQj087OQjBYUjmc6sVgooRbDmewT/QEkgImKz809j9/CvSfwamfK0l
 EFYPgBMskvBun1YwMrMh0bcIarPTHek=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-437-2g1DlRD1O8ee8jWldi_rMw-1; Wed, 14 Dec 2022 11:30:58 -0500
X-MC-Unique: 2g1DlRD1O8ee8jWldi_rMw-1
Received: by mail-wm1-f69.google.com with SMTP id
 p14-20020a05600c204e00b003cf4cce4da5so4399993wmg.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 08:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M+wOP66zSvRhQYDjszQYz+C5vn4h5BGATu0cy0bUORc=;
 b=bWCo3Ls4NEUmEuyGQ+mQGAdtdctppUSRpugy2sLSDQhYJGilZKsOdYXwG97yHXvOUJ
 LMrdKkGa9ctMXlPQktpLTrgiTiLXQp0K408jjvW5femJYZMImO8MX8kkQlVks1GlsxA8
 eSf3Ei0LlGoq9pSOdnft915PS6qBor7eCrURLmduv7rZVS0FAWGFrmV+WgTl1sO7qVpF
 vqr/wGbIx5jHj8DEdZ1cfS6ulKGMoMRn7H+yIB1uwkXT2TM28M6nGeuSeI9QUZ5AnFCX
 KUy25PedS6CGuXo6hlO0XkGCCWJLN9gXEXzy+g0ys/NSNqhV6QOcyUQEdAcK311siH0F
 fgmw==
X-Gm-Message-State: ANoB5plmCJuO9R+lK6bKRUTNWIGoS72iRzIFU9+JLH1tLoMXQy8BRXrP
 mW/56AwYZboUi+CyGW0wWOVLNNocr0K7S4YQYz0Hbz/XDe5wmahFbhE+sPs9P0PvLtlBDDt2sOC
 6KGO3E4vLzHg8IP+parZovWcj7u2b4hcD7rSuqsoi2m2yWrtBpFZLOA1BHnIRDyhvNewPQNQdjN
 xst7uV3Tf12uhZEMCimw==
X-Received: by 2002:a05:600c:3c95:b0:3d0:4af1:a36e with SMTP id
 bg21-20020a05600c3c9500b003d04af1a36emr19162751wmb.26.1671035456810; 
 Wed, 14 Dec 2022 08:30:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf60WGqYgsSKb75OsCZF9FEfxsX89v9hIf3pvnwfZ9ScHyDYE49t9+hNy2gQ3Yhy/2cfcsbUgg==
X-Received: by 2002:a05:600c:3c95:b0:3d0:4af1:a36e with SMTP id
 bg21-20020a05600c3c9500b003d04af1a36emr19162723wmb.26.1671035456529; 
 Wed, 14 Dec 2022 08:30:56 -0800 (PST)
Received: from step1.redhat.com (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 c6-20020a05600c0a4600b003d1e3b1624dsm3850323wmq.2.2022.12.14.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 08:30:55 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 4/6] vdpa_sim: make devices agnostic for work management
Date: Wed, 14 Dec 2022 17:30:23 +0100
Message-Id: <20221214163025.103075-5-sgarzare@redhat.com>
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

Let's move work management inside the vdpa_sim core.
This way we can easily change how we manage the works, without
having to change the devices each time.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 17 +++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  6 ++----
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  6 ++----
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 0e78737dcc16..7e6dd366856f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -44,7 +44,7 @@ struct vdpasim_dev_attr {
 	u32 ngroups;
 	u32 nas;
 
-	work_func_t work_fn;
+	void (*work_fn)(struct vdpasim *vdpasim);
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
 };
@@ -73,6 +73,7 @@ struct vdpasim {
 
 struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
 			       const struct vdpa_dev_set_config *config);
+void vdpasim_schedule_work(struct vdpasim *vdpasim);
 
 /* TODO: cross-endian support */
 static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 2e0ee7280aa8..9bde33e38e27 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -245,6 +245,13 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
+static void vdpasim_work_fn(struct work_struct *work)
+{
+	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
+
+	vdpasim->dev_attr.work_fn(vdpasim);
+}
+
 struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 			       const struct vdpa_dev_set_config *config)
 {
@@ -275,7 +282,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	}
 
 	vdpasim->dev_attr = *dev_attr;
-	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
+	INIT_WORK(&vdpasim->work, vdpasim_work_fn);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
 
@@ -329,6 +336,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 }
 EXPORT_SYMBOL_GPL(vdpasim_create);
 
+void vdpasim_schedule_work(struct vdpasim *vdpasim)
+{
+	schedule_work(&vdpasim->work);
+}
+EXPORT_SYMBOL_GPL(vdpasim_schedule_work);
+
 static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 				  u64 desc_area, u64 driver_area,
 				  u64 device_area)
@@ -357,7 +370,7 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
 	if (vq->ready)
-		schedule_work(&vdpasim->work);
+		vdpasim_schedule_work(vdpasim);
 }
 
 static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index c6db1a1baf76..ae2309411acd 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/blkdev.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
@@ -286,9 +285,8 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 	return handled;
 }
 
-static void vdpasim_blk_work(struct work_struct *work)
+static void vdpasim_blk_work(struct vdpasim *vdpasim)
 {
-	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
 	bool reschedule = false;
 	int i;
 
@@ -326,7 +324,7 @@ static void vdpasim_blk_work(struct work_struct *work)
 	spin_unlock(&vdpasim->lock);
 
 	if (reschedule)
-		schedule_work(&vdpasim->work);
+		vdpasim_schedule_work(vdpasim);
 }
 
 static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c3cb225ea469..a209df365158 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/etherdevice.h>
 #include <linux/vringh.h>
 #include <linux/vdpa.h>
@@ -143,9 +142,8 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 	}
 }
 
-static void vdpasim_net_work(struct work_struct *work)
+static void vdpasim_net_work(struct vdpasim *vdpasim)
 {
-	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
 	ssize_t read, write;
@@ -196,7 +194,7 @@ static void vdpasim_net_work(struct work_struct *work)
 		vdpasim_net_complete(rxq, write);
 
 		if (++pkts > 4) {
-			schedule_work(&vdpasim->work);
+			vdpasim_schedule_work(vdpasim);
 			goto out;
 		}
 	}
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
