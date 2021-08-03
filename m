Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B9DC19F31
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4AE60F9C
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C4AE60F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87A918349A;
	Tue,  3 Aug 2021 12:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uk1cRxFd0FJt; Tue,  3 Aug 2021 12:59:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1335082B3E;
	Tue,  3 Aug 2021 12:59:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1A90C0026;
	Tue,  3 Aug 2021 12:59:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BEE2C0028
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0D2582980
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id usR7AcBcI_Kk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DE5A829B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:38 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91337200CF;
 Tue,  3 Aug 2021 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627995576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7ylt/LkXCFDYa0trOnuiQMZfBkOMCMsvTE5vWeTxxo=;
 b=03nHvHKcmElHbm95QNo2MKi4qepvs2P2xu9gsNwgST1B8H8y5nhu/OJPvkABzNbq2kYt0q
 OSVSf6jBKduaNFLtfhSe9+yNqZrqloTQ7VjI7xOasOrxJollu2r4AJuwiGnPy0MM8OGi7Y
 iG/+kAmtLPsmCXcCG8lA0q8ko+mDaeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627995576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7ylt/LkXCFDYa0trOnuiQMZfBkOMCMsvTE5vWeTxxo=;
 b=+sLddtzuh2lb/DJOhOg7H28j5jphT87tEFrrijEV4Z6O6Cd5eIJ1bWiB67MhmrbM+4Uona
 a0JI8LUeE2xPswCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19A2E13CD6;
 Tue,  3 Aug 2021 12:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ELDgBLg9CWExZwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Tue, 03 Aug 2021 12:59:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, noralf@tronnes.org,
 drawat.floss@gmail.com, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 sam@ravnborg.org
Subject: [PATCH 11/11] drm/vkms: Use offset-adjusted shadow-plane mappings and
 output
Date: Tue,  3 Aug 2021 14:59:28 +0200
Message-Id: <20210803125928.27780-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803125928.27780-1-tzimmermann@suse.de>
References: <20210803125928.27780-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
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

For framebuffers with non-zero offset fields, shadow-plane helpers
provide a pointer to the first byte of the contained data. Use it in
vkms.

Also provide use the offset-adjusted data address for the writeback
job's output buffers. Output framebuffers with non-zero offsets now
have their content written to the correct location.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/vkms/vkms_composer.c  | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h       | 1 +
 drivers/gpu/drm/vkms/vkms_plane.c     | 2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 49f109c3a2b3..9e8204be9a14 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -257,7 +257,7 @@ void vkms_composer_worker(struct work_struct *work)
 		return;
 
 	if (wb_pending)
-		vaddr_out = crtc_state->active_writeback->map[0].vaddr;
+		vaddr_out = crtc_state->active_writeback->data[0].vaddr;
 
 	ret = compose_active_planes(&vaddr_out, primary_composer,
 				    crtc_state);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 8bc9e3f52e1f..d48c23d40ce5 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -22,6 +22,7 @@
 
 struct vkms_writeback_job {
 	struct dma_buf_map map[DRM_FORMAT_MAX_PLANES];
+	struct dma_buf_map data[DRM_FORMAT_MAX_PLANES];
 };
 
 struct vkms_composer {
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index 8a56fbf572b0..32409e15244b 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -111,7 +111,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
 	memcpy(&composer->src, &new_state->src, sizeof(struct drm_rect));
 	memcpy(&composer->dst, &new_state->dst, sizeof(struct drm_rect));
 	memcpy(&composer->fb, fb, sizeof(struct drm_framebuffer));
-	memcpy(&composer->map, &shadow_plane_state->map, sizeof(composer->map));
+	memcpy(&composer->map, &shadow_plane_state->data, sizeof(composer->map));
 	drm_framebuffer_get(&composer->fb);
 	composer->offset = fb->offsets[0];
 	composer->pitch = fb->pitches[0];
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 3a8e2ed93e7c..8694227f555f 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -75,7 +75,7 @@ static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 	if (!vkmsjob)
 		return -ENOMEM;
 
-	ret = drm_gem_fb_vmap(job->fb, vkmsjob->map, NULL);
+	ret = drm_gem_fb_vmap(job->fb, vkmsjob->map, vkmsjob->data);
 	if (ret) {
 		DRM_ERROR("vmap failed: %d\n", ret);
 		goto err_kfree;
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
