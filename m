Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38567C433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:32:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E720760232
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E720760232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9112860D2;
	Wed, 17 Feb 2021 12:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fONlNMDhMw_G; Wed, 17 Feb 2021 12:32:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2A0AF86099;
	Wed, 17 Feb 2021 12:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2BEC0893;
	Wed, 17 Feb 2021 12:32:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B69F2C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A67E086D19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6dH1toIKZ2SB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 15CFE86D2F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613565148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU9xqyDz+/JZ1pv9CUV7jElgPp7ezMbvPiq81Zym9Z8=;
 b=bn4ZD0RkdZxSH7iRT842RFgpdAOgf4MTY0yTtHCyYS+itgxi7XL+K9pqUd8/moMCFFrcnR
 lBWLWvUNwGDGrRCwmPp9X56+0C2+/JWXRUXVckWGdR7w7pwnD2MH3J9PFCAQDXZbafiqWz
 uTDPFcVOPlX6Iz6N5WzCCTCcMefZEb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-uUYTIYitMOy6UjmdQVRIAw-1; Wed, 17 Feb 2021 07:32:24 -0500
X-MC-Unique: uUYTIYitMOy6UjmdQVRIAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD3C580196C;
 Wed, 17 Feb 2021 12:32:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com
 [10.36.114.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D32310027A5;
 Wed, 17 Feb 2021 12:32:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9127D18003B7; Wed, 17 Feb 2021 13:32:14 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2 06/11] drm/qxl: add qxl_bo_vmap/qxl_bo_vunmap
Date: Wed, 17 Feb 2021 13:32:08 +0100
Message-Id: <20210217123213.2199186-7-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-1-kraxel@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
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

Add vmap/vunmap variants which reserve (and pin) the bo.
They can be used in case the caller doesn't hold a reservation
for the bo.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.h |  2 ++
 drivers/gpu/drm/qxl/qxl_object.c | 36 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_object.h b/drivers/gpu/drm/qxl/qxl_object.h
index 2495e5cdf353..ee9c29de4d3d 100644
--- a/drivers/gpu/drm/qxl/qxl_object.h
+++ b/drivers/gpu/drm/qxl/qxl_object.h
@@ -64,7 +64,9 @@ extern int qxl_bo_create(struct qxl_device *qdev,
 			 u32 priority,
 			 struct qxl_surface *surf,
 			 struct qxl_bo **bo_ptr);
+int qxl_bo_vmap(struct qxl_bo *bo, struct dma_buf_map *map);
 int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map);
+int qxl_bo_vunmap(struct qxl_bo *bo);
 void qxl_bo_vunmap_locked(struct qxl_bo *bo);
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, int page_offset);
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev, struct qxl_bo *bo, void *map);
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index f4a015381a7f..82c3bf195ad6 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -29,6 +29,9 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
+static int __qxl_bo_pin(struct qxl_bo *bo);
+static void __qxl_bo_unpin(struct qxl_bo *bo);
+
 static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct qxl_bo *bo;
@@ -179,6 +182,25 @@ int qxl_bo_vmap_locked(struct qxl_bo *bo, struct dma_buf_map *map)
 	return 0;
 }
 
+int qxl_bo_vmap(struct qxl_bo *bo, struct dma_buf_map *map)
+{
+	int r;
+
+	r = qxl_bo_reserve(bo);
+	if (r)
+		return r;
+
+	r = __qxl_bo_pin(bo);
+	if (r) {
+		qxl_bo_unreserve(bo);
+		return r;
+	}
+
+	r = qxl_bo_vmap_locked(bo, map);
+	qxl_bo_unreserve(bo);
+	return r;
+}
+
 void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
 			      struct qxl_bo *bo, int page_offset)
 {
@@ -223,6 +245,20 @@ void qxl_bo_vunmap_locked(struct qxl_bo *bo)
 	ttm_bo_vunmap(&bo->tbo, &bo->map);
 }
 
+int qxl_bo_vunmap(struct qxl_bo *bo)
+{
+	int r;
+
+	r = qxl_bo_reserve(bo);
+	if (r)
+		return r;
+
+	qxl_bo_vunmap_locked(bo);
+	__qxl_bo_unpin(bo);
+	qxl_bo_unreserve(bo);
+	return 0;
+}
+
 void qxl_bo_kunmap_atomic_page(struct qxl_device *qdev,
 			       struct qxl_bo *bo, void *pmap)
 {
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
