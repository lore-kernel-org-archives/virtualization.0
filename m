Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34748C43381
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:43:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C058123383
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C058123383
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3838986D3C;
	Fri,  8 Jan 2021 09:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fq04HNZUn2Hj; Fri,  8 Jan 2021 09:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD7E886D28;
	Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9776C1E6F;
	Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02E8CC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E9551872E9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9eBUSSH19m8s
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9E438870BE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:50 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 38000AFD7;
 Fri,  8 Jan 2021 09:43:49 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, airlied@redhat.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kraxel@redhat.com, hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 sam@ravnborg.org
Subject: [PATCH v4 08/13] drm/udl: Use drm_gem_shmem_vmap_local() in damage
 handling
Date: Fri,  8 Jan 2021 10:43:35 +0100
Message-Id: <20210108094340.15290-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108094340.15290-1-tzimmermann@suse.de>
References: <20210108094340.15290-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linaro-mm-sig@lists.linaro.org, virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org
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

Damage handling in udl requires a short-term mapping of the source
BO. Use drm_gem_shmem_vmap_local().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_modeset.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 9d34ec9d03f6..46b55b4d03c2 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -290,14 +290,18 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 	else if ((clip.x2 > fb->width) || (clip.y2 > fb->height))
 		return -EINVAL;
 
+	ret = dma_resv_lock(fb->obj[0]->resv, NULL);
+	if (ret)
+		return ret;
+
 	if (import_attach) {
 		ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
 					       DMA_FROM_DEVICE);
 		if (ret)
-			return ret;
+			goto out_dma_resv_unlock;
 	}
 
-	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
+	ret = drm_gem_shmem_vmap_local(fb->obj[0], &map);
 	if (ret) {
 		DRM_ERROR("failed to vmap fb\n");
 		goto out_dma_buf_end_cpu_access;
@@ -307,7 +311,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 	urb = udl_get_urb(dev);
 	if (!urb) {
 		ret = -ENOMEM;
-		goto out_drm_gem_shmem_vunmap;
+		goto out_drm_gem_shmem_vunmap_local;
 	}
 	cmd = urb->transfer_buffer;
 
@@ -320,7 +324,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 				       &cmd, byte_offset, dev_byte_offset,
 				       byte_width);
 		if (ret)
-			goto out_drm_gem_shmem_vunmap;
+			goto out_drm_gem_shmem_vunmap_local;
 	}
 
 	if (cmd > (char *)urb->transfer_buffer) {
@@ -336,8 +340,8 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 
 	ret = 0;
 
-out_drm_gem_shmem_vunmap:
-	drm_gem_shmem_vunmap(fb->obj[0], &map);
+out_drm_gem_shmem_vunmap_local:
+	drm_gem_shmem_vunmap_local(fb->obj[0], &map);
 out_dma_buf_end_cpu_access:
 	if (import_attach) {
 		tmp_ret = dma_buf_end_cpu_access(import_attach->dmabuf,
@@ -345,6 +349,8 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 		if (tmp_ret && !ret)
 			ret = tmp_ret; /* only update ret if not set yet */
 	}
+out_dma_resv_unlock:
+	dma_resv_unlock(fb->obj[0]->resv);
 
 	return ret;
 }
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
