Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9348DC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 15:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB0FA404DA;
	Wed,  9 Feb 2022 15:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OlrR_kTF2UDr; Wed,  9 Feb 2022 15:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CE7BA4047F;
	Wed,  9 Feb 2022 15:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1590DC007B;
	Wed,  9 Feb 2022 15:56:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B724DC0079
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 90088400D0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQLutrLKUjWN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9732C40332
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 15:56:40 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4F431F391;
 Wed,  9 Feb 2022 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644422197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzH4L3CNaiS/mmU6hXQpWU0hk725l40p1DSoSUVyvXI=;
 b=EDhnF5lprMOJYMTPHe9jNAyPvfQ/Bz5TcUA3RVV/u2ZqFB11a0ajoo1EVNyagRq5UHKYr4
 V1Q3y2PFPKbJKFQxezQyU+6SRNVlVxffZBMpD7DTzKs0DzhFwW2AogF14nKQAQ7dCucPz7
 SvMtfDdn4zE2mb9mvfs8PYohrXPKnwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644422197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzH4L3CNaiS/mmU6hXQpWU0hk725l40p1DSoSUVyvXI=;
 b=RI4E0CRXemKqaiFINOwS9tK8/hr2DqtzCVzQHa9L/xiEoYrLMyMVIb0NaUeEe/iPWk1Wxg
 69B+xckHdKOod/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5081813D58;
 Wed,  9 Feb 2022 15:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KLefEjXkA2JxHAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Feb 2022 15:56:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, yuq825@gmail.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, emma@anholt.net, kraxel@redhat.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com
Subject: [PATCH v2 1/2] drm/gem-shmem: Set vm_ops in static initializer
Date: Wed,  9 Feb 2022 16:56:33 +0100
Message-Id: <20220209155634.3994-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209155634.3994-1-tzimmermann@suse.de>
References: <20220209155634.3994-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, lima@lists.freedesktop.org,
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

Initialize default vm_ops in static initialization of the GEM SHMEM funcs,
instead of the mmap code. It's simply better style. GEM helpers will later
set a VMA's vm_ops from the default automatically.

v2:
	* also update the drivers that build upon GEM SHMEM

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c  | 5 +++--
 drivers/gpu/drm/lima/lima_gem.c         | 1 +
 drivers/gpu/drm/panfrost/panfrost_gem.c | 1 +
 drivers/gpu/drm/v3d/v3d_bo.c            | 1 +
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 include/drm/drm_gem_shmem_helper.h      | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 621924116eb4..5991a22a9e22 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -46,6 +46,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
 static struct drm_gem_shmem_object *
@@ -585,11 +586,12 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 	drm_gem_vm_close(vma);
 }
 
-static const struct vm_operations_struct drm_gem_shmem_vm_ops = {
+const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 	.fault = drm_gem_shmem_fault,
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
 };
+EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
 
 /**
  * drm_gem_shmem_mmap - Memory-map a shmem GEM object
@@ -625,7 +627,6 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	if (shmem->map_wc)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	vma->vm_ops = &drm_gem_shmem_vm_ops;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index f9a9198ef198..6a6f6f2ead75 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -213,6 +213,7 @@ static const struct drm_gem_object_funcs lima_gem_funcs = {
 	.vmap = lima_gem_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = lima_gem_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
 struct drm_gem_object *lima_gem_create_object(struct drm_device *dev, size_t size)
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index ead65f5fa2bc..293e799e2fe8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -206,6 +206,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
 /**
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 6e3113f419f4..8b3229a37c6d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -59,6 +59,7 @@ static const struct drm_gem_object_funcs v3d_gem_funcs = {
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
 /* gem_create_object function for allocating a BO struct and doing
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index baef2c5f2aaf..f293e6ad52da 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -124,6 +124,7 @@ static const struct drm_gem_object_funcs virtio_gpu_shmem_funcs = {
 	.vmap = drm_gem_shmem_object_vmap,
 	.vunmap = drm_gem_shmem_object_vunmap,
 	.mmap = drm_gem_shmem_object_mmap,
+	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
 bool virtio_gpu_is_shmem(struct virtio_gpu_object *bo)
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 311d66c9cf4b..08e7846e8abc 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -135,6 +135,8 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
 void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 			      struct drm_printer *p, unsigned int indent);
 
+extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
+
 /*
  * GEM object functions
  */
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
