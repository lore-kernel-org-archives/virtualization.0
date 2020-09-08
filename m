Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD484C43461
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 09:39:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A482166E
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 09:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUfq8M92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A482166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CC88C2733D;
	Tue,  8 Sep 2020 09:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H9c64XNyG7+W; Tue,  8 Sep 2020 09:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C3EC52051A;
	Tue,  8 Sep 2020 09:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE1DCC0859;
	Tue,  8 Sep 2020 09:39:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39BBFC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 32EE98726C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pRcF727zuv9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:39:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D676587267
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0KEVHWP2GiLQz9DhPmZh/HeQE3DHcZKHvJrF/RegTIU=;
 b=QUfq8M92LX7WvSdzzdvWIMmeoKsqcIvz+fQGzdV63UccYDv5SvGJzvo8OVGEldAXJCw4yv
 bqJ3Vgf244u/ZXuXRvzBYn56BUB0awbalnHQSD3gxzhTzP+82Hp0x1WrM4Pdr7dtjQA4EO
 H+lpTm6Sjv/V/FgMJJe/DPiFqSgSTTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-FQLYQ8IjMDq3GhQpyAEKYw-1; Tue, 08 Sep 2020 05:39:18 -0400
X-MC-Unique: FQLYQ8IjMDq3GhQpyAEKYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856CF802B61;
 Tue,  8 Sep 2020 09:39:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59DF060C15;
 Tue,  8 Sep 2020 09:39:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 95CBC204AE; Tue,  8 Sep 2020 11:39:12 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/qxl: handle shadow in primary destroy
Date: Tue,  8 Sep 2020 11:39:12 +0200
Message-Id: <20200908093912.26792-4-kraxel@redhat.com>
In-Reply-To: <20200908093912.26792-1-kraxel@redhat.com>
References: <20200908093912.26792-1-kraxel@redhat.com>
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

qxl_primary_atomic_disable must check whenever the framebuffer bo has a
shadow surface and in case it has check the shadow primary status.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 85dcb7fe56a9..3dcbb359e0f5 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -560,6 +560,8 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
 	if (old_state->fb) {
 		struct qxl_bo *bo = gem_to_qxl_bo(old_state->fb->obj[0]);
 
+		if (bo->shadow)
+			bo = bo->shadow;
 		if (bo->is_primary) {
 			qxl_io_destroy_primary(qdev);
 			bo->is_primary = false;
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
