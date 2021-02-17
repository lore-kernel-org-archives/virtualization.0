Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB6C433E0
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:32:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D48A64E0F
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 12:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D48A64E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4BFFA87257;
	Wed, 17 Feb 2021 12:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UH0cDhArHNr1; Wed, 17 Feb 2021 12:32:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE29987267;
	Wed, 17 Feb 2021 12:32:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8D72C0174;
	Wed, 17 Feb 2021 12:32:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8892FC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70AF56F49B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nvLW9nhI6dDJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:32 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 3E8E36F48C; Wed, 17 Feb 2021 12:32:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDB306F48C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 12:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613565147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PrAFBJvVVYODkUICutXeBfli8yoFz//LCVZCLaIAVbA=;
 b=S85O3IDx61sXrJvrS74VFHfO7IY8+KAO61j85gajurx0UPgR2WbPiQ4vejOJDRBTuLjDZe
 Ho7lJFQQcWn7ODM6BBdmLdOyv8cDgiLGsec44Lbamx1qtd5DRMI7jKFns+zqJPtrZF4tzr
 J7/qInH/4TtwJ5RQvoTPt3Lei8RNnOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-En2lN0AvPHWyb8kfuG3KOg-1; Wed, 17 Feb 2021 07:32:25 -0500
X-MC-Unique: En2lN0AvPHWyb8kfuG3KOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 475E21020C21;
 Wed, 17 Feb 2021 12:32:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com
 [10.36.114.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 008251349A;
 Wed, 17 Feb 2021 12:32:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EA60818003BD; Wed, 17 Feb 2021 13:32:14 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v2 09/11] drm/qxl: move shadow handling to new
 qxl_prepare_shadow()
Date: Wed, 17 Feb 2021 13:32:11 +0100
Message-Id: <20210217123213.2199186-10-kraxel@redhat.com>
In-Reply-To: <20210217123213.2199186-1-kraxel@redhat.com>
References: <20210217123213.2199186-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Pure code motion, no functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 61 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index f106da917863..b315d7484e21 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -771,13 +771,45 @@ static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
 		DRM_DEBUG("%dx%d\n", surf->width, surf->height);
 }
 
+static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
+			       int crtc_index)
+{
+	struct qxl_surface surf;
+
+	qxl_update_dumb_head(qdev, crtc_index,
+			     user_bo);
+	qxl_calc_dumb_shadow(qdev, &surf);
+	if (!qdev->dumb_shadow_bo ||
+	    qdev->dumb_shadow_bo->surf.width  != surf.width ||
+	    qdev->dumb_shadow_bo->surf.height != surf.height) {
+		if (qdev->dumb_shadow_bo) {
+			drm_gem_object_put
+				(&qdev->dumb_shadow_bo->tbo.base);
+			qdev->dumb_shadow_bo = NULL;
+		}
+		qxl_bo_create(qdev, surf.height * surf.stride,
+			      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
+			      &surf, &qdev->dumb_shadow_bo);
+	}
+	if (user_bo->shadow != qdev->dumb_shadow_bo) {
+		if (user_bo->shadow) {
+			qxl_bo_unpin(user_bo->shadow);
+			drm_gem_object_put
+				(&user_bo->shadow->tbo.base);
+			user_bo->shadow = NULL;
+		}
+		drm_gem_object_get(&qdev->dumb_shadow_bo->tbo.base);
+		user_bo->shadow = qdev->dumb_shadow_bo;
+		qxl_bo_pin(user_bo->shadow);
+	}
+}
+
 static int qxl_plane_prepare_fb(struct drm_plane *plane,
 				struct drm_plane_state *new_state)
 {
 	struct qxl_device *qdev = to_qxl(plane->dev);
 	struct drm_gem_object *obj;
 	struct qxl_bo *user_bo;
-	struct qxl_surface surf;
 
 	if (!new_state->fb)
 		return 0;
@@ -787,32 +819,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_update_dumb_head(qdev, new_state->crtc->index,
-				     user_bo);
-		qxl_calc_dumb_shadow(qdev, &surf);
-		if (!qdev->dumb_shadow_bo ||
-		    qdev->dumb_shadow_bo->surf.width  != surf.width ||
-		    qdev->dumb_shadow_bo->surf.height != surf.height) {
-			if (qdev->dumb_shadow_bo) {
-				drm_gem_object_put
-					(&qdev->dumb_shadow_bo->tbo.base);
-				qdev->dumb_shadow_bo = NULL;
-			}
-			qxl_bo_create(qdev, surf.height * surf.stride,
-				      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
-				      &surf, &qdev->dumb_shadow_bo);
-		}
-		if (user_bo->shadow != qdev->dumb_shadow_bo) {
-			if (user_bo->shadow) {
-				qxl_bo_unpin(user_bo->shadow);
-				drm_gem_object_put
-					(&user_bo->shadow->tbo.base);
-				user_bo->shadow = NULL;
-			}
-			drm_gem_object_get(&qdev->dumb_shadow_bo->tbo.base);
-			user_bo->shadow = qdev->dumb_shadow_bo;
-			qxl_bo_pin(user_bo->shadow);
-		}
+		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
 	}
 
 	return qxl_bo_pin(user_bo);
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
