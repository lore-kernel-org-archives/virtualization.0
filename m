Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFBC433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 16:58:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3EA20780
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 16:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3EA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C40F867A1;
	Tue, 26 Jan 2021 16:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TKQqdrOB69m7; Tue, 26 Jan 2021 16:58:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CAAE586798;
	Tue, 26 Jan 2021 16:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8434C1825;
	Tue, 26 Jan 2021 16:58:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6A3C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 16:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 29C1020395
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 16:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eUsa3DdEuQHU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 16:58:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2F7CB2046E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 16:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611680304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnwMFEA3dHK0CEi+ABtFVAQ2zD+3yrKrWdST5Jn7sBk=;
 b=e19qYo/JCpZlwQaQ+Kfc8eujsNn7+uJ/oMOoHl76P4ePKB2OLUHlk81m7HWruD9eCnZZkg
 AbjQF0SYt52axU4tvZ8KOxEaYL1JJlLqBlM0B7YuHDPBRIq1u/jKKNfk64cUwiuRgIzEG9
 CY7wet0siT34k3Ffs2G/tK1g5jDjxUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-SmgUeXkUNx6JyluNqkBOfw-1; Tue, 26 Jan 2021 11:58:22 -0500
X-MC-Unique: SmgUeXkUNx6JyluNqkBOfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D746E802B48;
 Tue, 26 Jan 2021 16:58:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-27.ams2.redhat.com
 [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EEDB10013BD;
 Tue, 26 Jan 2021 16:58:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9325F18003A3; Tue, 26 Jan 2021 17:58:13 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v4 5/5] drm/qxl: properly free qxl releases
Date: Tue, 26 Jan 2021 17:58:12 +0100
Message-Id: <20210126165812.1661512-6-kraxel@redhat.com>
In-Reply-To: <20210126165812.1661512-1-kraxel@redhat.com>
References: <20210126165812.1661512-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     |  1 +
 drivers/gpu/drm/qxl/qxl_kms.c     | 22 ++++++++++++++++++++--
 drivers/gpu/drm/qxl/qxl_release.c |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 01354b43c413..1c57b587b6a7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -214,6 +214,7 @@ struct qxl_device {
 	spinlock_t	release_lock;
 	struct idr	release_idr;
 	uint32_t	release_seqno;
+	atomic_t	release_count;
 	spinlock_t release_idr_lock;
 	struct mutex	async_io_mutex;
 	unsigned int last_sent_io_cmd;
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 4a60a52ab62e..f177f72bfc12 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -25,6 +25,7 @@
 
 #include <linux/io-mapping.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 
 #include <drm/drm_drv.h>
 #include <drm/drm_managed.h>
@@ -286,8 +287,25 @@ int qxl_device_init(struct qxl_device *qdev,
 
 void qxl_device_fini(struct qxl_device *qdev)
 {
-	qxl_bo_unref(&qdev->current_release_bo[0]);
-	qxl_bo_unref(&qdev->current_release_bo[1]);
+	int cur_idx, try;
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
+	for (try = 0; try < 20 && atomic_read(&qdev->release_count) > 0; try++)
+		msleep(20);
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
