Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58967C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:17:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C1964E38
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C1964E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 80F008683D;
	Wed,  3 Feb 2021 13:17:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bH17IAEVVAK3; Wed,  3 Feb 2021 13:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 74D948685F;
	Wed,  3 Feb 2021 13:17:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57C77C013A;
	Wed,  3 Feb 2021 13:17:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C7DBC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7CDFD2001A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRbKaK2rug9T
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:16:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id CFA48204F3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612358189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIQiGfgSUKUQ4lTI2ex1yiuCPVjrmXrlcR2znxklmvA=;
 b=UrWKaFWkeoKezU3w0TCMahcFdy69bgyfan81OhEFxc/kFMCrG/xcnXjViB5mKsgIHqpcQf
 kCHxbHTiEpJGEquLgazp7AoaV5rGNXy7wdBAKhaKKP5lpmACGCnBOdH7l8qxES7Wreu/iQ
 T4PMCPR/xcKTgWOOItUmcYlV6SClj2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-P3MjeksvMd-vYzW12ilQag-1; Wed, 03 Feb 2021 08:16:26 -0500
X-MC-Unique: P3MjeksvMd-vYzW12ilQag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7B6C107ACE6;
 Wed,  3 Feb 2021 13:16:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-27.ams2.redhat.com
 [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7D8C60C5F;
 Wed,  3 Feb 2021 13:16:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 09075180085A; Wed,  3 Feb 2021 14:16:16 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v5 6/6] drm/qxl: simplify qxl_fence_wait
Date: Wed,  3 Feb 2021 14:16:15 +0100
Message-Id: <20210203131615.1714021-7-kraxel@redhat.com>
In-Reply-To: <20210203131615.1714021-1-kraxel@redhat.com>
References: <20210203131615.1714021-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Now that we have the new release_event wait queue we can just
use that in qxl_fence_wait() and simplify the code alot.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 42 +++----------------------------
 1 file changed, 4 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 43a5436853b7..b6f4b8dcf228 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -59,53 +59,19 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 {
 	struct qxl_device *qdev;
 	struct qxl_release *release;
-	int count = 0, sc = 0;
-	bool have_drawable_releases;
 	unsigned long cur, end = jiffies + timeout;
 
 	qdev = container_of(fence->lock, struct qxl_device, release_lock);
 	release = container_of(fence, struct qxl_release, base);
-	have_drawable_releases = release->type == QXL_RELEASE_DRAWABLE;
-
-retry:
-	sc++;
 
 	if (dma_fence_is_signaled(fence))
 		goto signaled;
 
 	qxl_io_notify_oom(qdev);
-
-	for (count = 0; count < 11; count++) {
-		if (!qxl_queue_garbage_collect(qdev, true))
-			break;
-
-		if (dma_fence_is_signaled(fence))
-			goto signaled;
-	}
-
-	if (dma_fence_is_signaled(fence))
-		goto signaled;
-
-	if (have_drawable_releases || sc < 4) {
-		if (sc > 2)
-			/* back off */
-			usleep_range(500, 1000);
-
-		if (time_after(jiffies, end))
-			return 0;
-
-		if (have_drawable_releases && sc > 300) {
-			DMA_FENCE_WARN(fence, "failed to wait on release %llu "
-				       "after spincount %d\n",
-				       fence->context & ~0xf0000000, sc);
-			goto signaled;
-		}
-		goto retry;
-	}
-	/*
-	 * yeah, original sync_obj_wait gave up after 3 spins when
-	 * have_drawable_releases is not set.
-	 */
+	if (!wait_event_timeout(qdev->release_event,
+				dma_fence_is_signaled(fence),
+				timeout))
+		return 0;
 
 signaled:
 	cur = jiffies;
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
