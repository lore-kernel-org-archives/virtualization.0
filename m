Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56CC433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 11:37:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1182A64DEC
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 11:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1182A64DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA92486BE6;
	Tue, 16 Feb 2021 11:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T-oDPKuM46Yo; Tue, 16 Feb 2021 11:37:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 402CE86C19;
	Tue, 16 Feb 2021 11:37:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24B89C1DA9;
	Tue, 16 Feb 2021 11:37:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E0F8C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 11:37:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 23B5A6F4B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 11:37:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rvdMdABiQM-6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 11:37:31 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 339F16F56A; Tue, 16 Feb 2021 11:37:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C647600C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 11:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613475448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BNcwAgY2lWfqJewfJz+Q3AkCPMKcBiYlzER8aYP8gc=;
 b=F5yrq66hVJKQSnsZYO4dDL6cp2sxCiYiwLIMgdX7Cbt2vG3wSXUfH2kNw4GZgY99J6oBTV
 QB8SsqqVQ6iZmIrbEkJWxq0ZCorfFlz3LYvpkXVyZDRvx5qIHlI6ZugbU/5Lq9+HfjEamV
 kMm1E55+gvRJ476zXBJXe5UYh/2/7YA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-JoG8JbKEOXqO0suKiZDyqw-1; Tue, 16 Feb 2021 06:37:26 -0500
X-MC-Unique: JoG8JbKEOXqO0suKiZDyqw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DFEA195D564;
 Tue, 16 Feb 2021 11:37:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-184.ams2.redhat.com
 [10.36.114.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7D61002382;
 Tue, 16 Feb 2021 11:37:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 47B3F1800634; Tue, 16 Feb 2021 12:37:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 07/10] drm/qxl: fix prime kmap
Date: Tue, 16 Feb 2021 12:37:13 +0100
Message-Id: <20210216113716.716996-8-kraxel@redhat.com>
In-Reply-To: <20210216113716.716996-1-kraxel@redhat.com>
References: <20210216113716.716996-1-kraxel@redhat.com>
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

Use the correct kmap variant.  We don't have a reservation here,
so we can't use the _locked version.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_prime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index dc295b2e2b52..4aa949799446 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -59,7 +59,7 @@ int qxl_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 	struct qxl_bo *bo = gem_to_qxl_bo(obj);
 	int ret;
 
-	ret = qxl_bo_kmap_locked(bo, map);
+	ret = qxl_bo_kmap(bo, map);
 	if (ret < 0)
 		return ret;
 
@@ -71,7 +71,7 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj,
 {
 	struct qxl_bo *bo = gem_to_qxl_bo(obj);
 
-	qxl_bo_kunmap_locked(bo);
+	qxl_bo_kunmap(bo);
 }
 
 int qxl_gem_prime_mmap(struct drm_gem_object *obj,
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
