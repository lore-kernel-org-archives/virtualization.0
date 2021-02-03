Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F7BC433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:17:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579EA64E3D
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579EA64E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F2A0E204C0;
	Wed,  3 Feb 2021 13:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4lfaEtggLvs; Wed,  3 Feb 2021 13:16:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E49BC21FA8;
	Wed,  3 Feb 2021 13:16:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDDE6C0174;
	Wed,  3 Feb 2021 13:16:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E126EC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C658F85F5F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dF1tVZOWnWit
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D4E0485F5E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612358187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJ+5jBM5Efq4pvimfFQZ7dr+IKl1CDbKtMOECooNzlA=;
 b=ImoANjiBl73kRGLc8vruCEXUNGep8jg0UU5OaB4GF5WMoSnX/TMZc649aydbWWn/GbTzH2
 8gSZYSRuSvo4V5FQDrnIrQh/yJaB30GXtmyAcxeFiPgKfesi68RfR9iVKIj3UJtwLGC9AL
 +1sJ5M52kjMVoQHtc2Pr6idFK5/Mxvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Jsa3RwqBPqevH1--Tt3m1A-1; Wed, 03 Feb 2021 08:16:26 -0500
X-MC-Unique: Jsa3RwqBPqevH1--Tt3m1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D34AECC620;
 Wed,  3 Feb 2021 13:16:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-27.ams2.redhat.com
 [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BBB5D9E3;
 Wed,  3 Feb 2021 13:16:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DECD71800859; Wed,  3 Feb 2021 14:16:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v5 5/6] drm/qxl: properly free qxl releases
Date: Wed,  3 Feb 2021 14:16:14 +0100
Message-Id: <20210203131615.1714021-6-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-1-kraxel@redhat.com>
References: <20210203131615.1714021-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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

Reorganize qxl_device_fini() a bit.
Add missing unpin() calls.

Count releases.  Add wait queue for releases.  That way
qxl_device_fini() can easily wait until everything is
ready for proper shutdown.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     |  2 ++
 drivers/gpu/drm/qxl/qxl_cmd.c     |  1 +
 drivers/gpu/drm/qxl/qxl_irq.c     |  1 +
 drivers/gpu/drm/qxl/qxl_kms.c     | 22 ++++++++++++++++++++--
 drivers/gpu/drm/qxl/qxl_release.c |  2 ++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 01354b43c413..6dd57cfb2e7c 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -214,6 +214,8 @@ struct qxl_device {
 	spinlock_t	release_lock;
 	struct idr	release_idr;
 	uint32_t	release_seqno;
+	atomic_t	release_count;
+	wait_queue_head_t release_event;
 	spinlock_t release_idr_lock;
 	struct mutex	async_io_mutex;
 	unsigned int last_sent_io_cmd;
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 54e3c3a97440..7e22a81bfb36 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -254,6 +254,7 @@ int qxl_garbage_collect(struct qxl_device *qdev)
 		}
 	}
 
+	wake_up_all(&qdev->release_event);
 	DRM_DEBUG_DRIVER("%d\n", i);
 
 	return i;
diff --git a/drivers/gpu/drm/qxl/qxl_irq.c b/drivers/gpu/drm/qxl/qxl_irq.c
index ddf6588a2a38..d312322cacd1 100644
--- a/drivers/gpu/drm/qxl/qxl_irq.c
+++ b/drivers/gpu/drm/qxl/qxl_irq.c
@@ -87,6 +87,7 @@ int qxl_irq_init(struct qxl_device *qdev)
 	init_waitqueue_head(&qdev->display_event);
 	init_waitqueue_head(&qdev->cursor_event);
 	init_waitqueue_head(&qdev->io_cmd_event);
+	init_waitqueue_head(&qdev->release_event);
 	INIT_WORK(&qdev->client_monitors_config_work,
 		  qxl_client_monitors_config_work_func);
 	atomic_set(&qdev->irq_received, 0);
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 4a60a52ab62e..616aea948863 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -286,8 +286,26 @@ int qxl_device_init(struct qxl_device *qdev,
 
 void qxl_device_fini(struct qxl_device *qdev)
 {
-	qxl_bo_unref(&qdev->current_release_bo[0]);
-	qxl_bo_unref(&qdev->current_release_bo[1]);
+	int cur_idx;
+
+	for (cur_idx = 0; cur_idx < 3; cur_idx++) {
+		if (!qdev->current_release_bo[cur_idx])
+			continue;
+		qxl_bo_unpin(qdev->current_release_bo[cur_idx]);
+		qxl_bo_unref(&qdev->current_release_bo[cur_idx]);
+		qdev->current_release_bo_offset[cur_idx] = 0;
+		qdev->current_release_bo[cur_idx] = NULL;
+	}
+
+	/*
+	 * Ask host to release resources (+fill release ring),
+	 * then wait for the release actually happening.
+	 */
+	qxl_io_notify_oom(qdev);
+	wait_event_timeout(qdev->release_event,
+			   atomic_read(&qdev->release_count) == 0,
+			   HZ);
+
 	qxl_gem_fini(qdev);
 	qxl_bo_fini(qdev);
 	flush_work(&qdev->gc_work);
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 28013fd1f8ea..43a5436853b7 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -196,6 +196,7 @@ qxl_release_free(struct qxl_device *qdev,
 		qxl_release_free_list(release);
 		kfree(release);
 	}
+	atomic_dec(&qdev->release_count);
 }
 
 static int qxl_release_bo_alloc(struct qxl_device *qdev,
@@ -344,6 +345,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 			*rbo = NULL;
 		return idr_ret;
 	}
+	atomic_inc(&qdev->release_count);
 
 	mutex_lock(&qdev->release_mutex);
 	if (qdev->current_release_bo_offset[cur_idx] + 1 >= releases_per_bo[cur_idx]) {
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
