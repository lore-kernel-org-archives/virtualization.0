Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE4C433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 09:31:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C966120D
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 09:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4C966120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6784C6078E;
	Mon,  8 Nov 2021 09:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wmjyvbNpKExm; Mon,  8 Nov 2021 09:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A0B4600CA;
	Mon,  8 Nov 2021 09:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D142AC0012;
	Mon,  8 Nov 2021 09:31:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6AFDFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57C296077D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Te4dcWIJFOa1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7B5F6059A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 09:31:55 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 653D221AFD;
 Mon,  8 Nov 2021 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636363913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07JoL4bBvlgW7FAbTjLwbLbhqbJPxRNwzr5W+o8JB8E=;
 b=10yYSekUU4TZrgWNMKqRVO/BJghCmR2I7vqDwV2A4Ml/ZYwIfaaf9gYBdNJ4th/VNl1qYE
 nJUKxASX3BBSTfkofvCMspVF0xPMULT96/2ONV0DUDSytf4v1Lf+3EYYFEAkCl8tXzdP0y
 /R4P4CUN9S43cobtpVmGTRLRHPknWGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636363913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07JoL4bBvlgW7FAbTjLwbLbhqbJPxRNwzr5W+o8JB8E=;
 b=uRBR26mpU30UTPA5bFqVfBcy5TISNqd6b39cYGCwnr2kfcDYhy2Yt7OLmk56CKZufD1/QN
 LmnB1W/tGw2ZbtAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 328F713B04;
 Mon,  8 Nov 2021 09:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MNlUC4nuiGFXfAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Nov 2021 09:31:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Subject: [PATCH v2 1/3] drm/shmem-helper: Unexport
 drm_gem_shmem_create_with_handle()
Date: Mon,  8 Nov 2021 10:31:47 +0100
Message-Id: <20211108093149.7226-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108093149.7226-1-tzimmermann@suse.de>
References: <20211108093149.7226-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, lima@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

Turn drm_gem_shmem_create_with_handle() into an internal helper
function. It's not used outside of the compilation unit.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +--
 include/drm/drm_gem_shmem_helper.h     | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index a5b743a83ce9..cd93e91b3487 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -410,7 +410,7 @@ void drm_gem_shmem_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 }
 EXPORT_SYMBOL(drm_gem_shmem_vunmap);
 
-struct drm_gem_shmem_object *
+static struct drm_gem_shmem_object *
 drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 				 struct drm_device *dev, size_t size,
 				 uint32_t *handle)
@@ -434,7 +434,6 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 
 	return shmem;
 }
-EXPORT_SYMBOL(drm_gem_shmem_create_with_handle);
 
 /* Update madvise status, returns true if not purged, else
  * false or -errno.
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 434328d8a0d9..6b47eb7d9f76 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -128,11 +128,6 @@ static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_object *shmem
 void drm_gem_shmem_purge_locked(struct drm_gem_object *obj);
 bool drm_gem_shmem_purge(struct drm_gem_object *obj);
 
-struct drm_gem_shmem_object *
-drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
-				 struct drm_device *dev, size_t size,
-				 uint32_t *handle);
-
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
 
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
