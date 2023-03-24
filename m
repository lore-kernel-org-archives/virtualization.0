Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4023AC76196
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA76D61612;
	Fri, 24 Mar 2023 15:39:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA76D61612
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GyUdLEVf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-YLKgv7pu8R; Fri, 24 Mar 2023 15:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55FB460F42;
	Fri, 24 Mar 2023 15:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55FB460F42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23DEEC0035;
	Fri, 24 Mar 2023 15:39:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EDA6C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07F4D41F1F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 07F4D41F1F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GyUdLEVf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XbdpFe0MFiTw
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0438741DE9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0438741DE9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJgV3Uny0vAQYBeBkJItoY2HRKhsGCmVf+cCCim+XIk=;
 b=GyUdLEVf9Z1mYJ0haWXLzqC9842T2oi9/9XFQwRfaivw9ggl+qOeWrl/HOGoDSFlxE5dHB
 m7Xv45elktNCKRWJSaD9ZqUpaFBNGwtI9ddiSinh52sshDQRNXwG/llyciRSZuClaLQgFH
 6lFwRUi8vCgTR8WsItgtt4F/FK8dMd8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-IQLYO0j9Nc6ySEw9idboYA-1; Fri, 24 Mar 2023 11:39:41 -0400
X-MC-Unique: IQLYO0j9Nc6ySEw9idboYA-1
Received: by mail-ed1-f70.google.com with SMTP id
 q13-20020a5085cd000000b004af50de0bcfso3801587edh.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679672380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJgV3Uny0vAQYBeBkJItoY2HRKhsGCmVf+cCCim+XIk=;
 b=W0qeDkddLJgsdMQXtOVHDBl+MhAI86C4F2O47pYEn02yIR2oyAOo0ge8NisU1/lrBC
 o6aCzO4fiPyf/ur2kSs5dl6v3OBYXnVQ9o8EIhMxuZzAPh3YR+mu0+APk6zEyKwb+gYP
 3fd0rAPoshn9qWwrJdhUvpqEUGbQ45PntCHIphkK3mchC6RhNaaTa1hQJbz8OYb5AofD
 3wMIpMq7vK4X87eUbXqB14rDA1aM9O5d0Ml8srqRx8taesO3Ls3cBsILbEaD0nw35GzA
 k8+cBhqWP1FHJdWW3lSYg3G/2JpnENNOLygNI4hL7NCbSqrAeJHh8x9HapLNFuwqkXRs
 6/xg==
X-Gm-Message-State: AAQBX9cvPiudlLkDLx8pN685EMNtACB0k/gdPKxI2mTLG0AcJbmhuM+1
 +CiOiGbw4tAZR6jwyaiKDeqHHO9bLrJV7B57W+rhjj5xc/tTAn/xdnbYLh7Wluqy5qi7wOSv/Gf
 g+Emzm+BYvyw/35B4f4rM/B8eVQ0sr0XHt7RLR08/LJSzBMI4DqGW9vfoDBfRDLtYEon12liW2r
 Y2NOCoPmlWeLFdeHfLz1Z6/o5nBg==
X-Received: by 2002:a17:906:3607:b0:92d:44ca:1137 with SMTP id
 q7-20020a170906360700b0092d44ca1137mr3426170ejb.43.1679672380137; 
 Fri, 24 Mar 2023 08:39:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZQuqhsbvuSHiIdsu2eZ5X0BBjFSGXqn/HK1XIKT/7J7LjCnWt4PxmBEwCVvzRAmMqLhm8YIA==
X-Received: by 2002:a17:906:3607:b0:92d:44ca:1137 with SMTP id
 q7-20020a170906360700b0092d44ca1137mr3426143ejb.43.1679672379807; 
 Fri, 24 Mar 2023 08:39:39 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 ot17-20020a170906ccd100b008e51a1fd7bfsm10581350ejb.172.2023.03.24.08.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 08:39:38 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 6/9] vdpa_sim: make devices agnostic for work management
Date: Fri, 24 Mar 2023 16:39:29 +0100
Message-Id: <20230324153929.47670-1-sgarzare@redhat.com>
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
Content-Type: multipart/mixed; boundary="===============5481544400457137948=="
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

--===============5481544400457137948==
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Let's move work management inside the vdpa_sim core.
This way we can easily change how we manage the works, without
having to change the devices each time.

Acked-by: Eugenio Pérez Martin <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 17 +++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  6 ++----
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  6 ++----
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 144858636c10..acee20faaf6a 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -45,7 +45,7 @@ struct vdpasim_dev_attr {
 	u32 ngroups;
 	u32 nas;
 
-	work_func_t work_fn;
+	void (*work_fn)(struct vdpasim *vdpasim);
 	void (*get_config)(struct vdpasim *vdpasim, void *config);
 	void (*set_config)(struct vdpasim *vdpasim, const void *config);
 	int (*get_stats)(struct vdpasim *vdpasim, u16 idx,
@@ -78,6 +78,7 @@ struct vdpasim {
 
 struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
 			       const struct vdpa_dev_set_config *config);
+void vdpasim_schedule_work(struct vdpasim *vdpasim);
 
 /* TODO: cross-endian support */
 static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index eea23c630f7c..2df5227e0b62 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -127,6 +127,13 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
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
@@ -163,7 +170,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 
 	vdpasim = vdpa_to_sim(vdpa);
 	vdpasim->dev_attr = *dev_attr;
-	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
+	INIT_WORK(&vdpasim->work, vdpasim_work_fn);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
 
@@ -214,6 +221,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
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
@@ -248,7 +261,7 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
 	}
 
 	if (vq->ready)
-		schedule_work(&vdpasim->work);
+		vdpasim_schedule_work(vdpasim);
 }
 
 static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 5117959bed8a..eb4897c8541e 100644
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
index 862f405362de..e61a9ecbfafe 100644
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
@@ -192,9 +191,8 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
 	u64_stats_update_end(&net->cq_stats.syncp);
 }
 
-static void vdpasim_net_work(struct work_struct *work)
+static void vdpasim_net_work(struct vdpasim *vdpasim)
 {
-	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
 	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
 	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
 	struct vdpasim_net *net = sim_to_net(vdpasim);
@@ -260,7 +258,7 @@ static void vdpasim_net_work(struct work_struct *work)
 		vdpasim_net_complete(rxq, write);
 
 		if (tx_pkts > 4) {
-			schedule_work(&vdpasim->work);
+			vdpasim_schedule_work(vdpasim);
 			goto out;
 		}
 	}
-- 
2.39.2


--===============5481544400457137948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5481544400457137948==--
