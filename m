Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9852749FE
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567275; cv=none; b=QvtIv562kHE12UMc75P70Ji2hXsMeB6fJR/kDwHIu7GpYy23z0Q9YBKlRb5SzjJuQe6LLo/KLZU7ZuwYV4Ounv6Jy6XQt1YloyNoNedenvnkvtXpSkoKstwayqtkc9eR6NgWr+Lpz8y4V4XTSAVsD2ZpHLhOWbjqbodtWXrzEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567275; c=relaxed/simple;
	bh=pq/C3cfo0vze0YrRtbI53MOwVidnN9JELp+REsipRVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRARzT7WPpBWRO746AeU66jdrm7f344x3DQcj1jlbCWESVHIUIAf1vNF99o2iC7T9HhWbOGg81Pko5i6w4tsurtwl8KQsmqDbIMwNvc9Gn+eBTWTnGXNLVFKOTj6PmLdd3eeZcTA5Thqpcja7y6LjiEOeCQqmXS9cr5Py4dMM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEE251F445;
	Tue, 15 Jul 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55F8D13A6C;
	Tue, 15 Jul 2025 08:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KN7RE+cNdmgJUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 08:14:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	christian.koenig@amd.com,
	torvalds@linux-foundation.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	l.stach@pengutronix.de,
	linux+etnaviv@armlinux.org.uk,
	kraxel@redhat.com,
	christian.gmeiner@gmail.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2 1/7] Revert "drm/virtio: Use dma_buf from GEM object instance"
Date: Tue, 15 Jul 2025 10:07:52 +0200
Message-ID: <20250715081121.34473-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715081121.34473-1-tzimmermann@suse.de>
References: <20250715081121.34473-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[etnaviv]
X-Rspamd-Queue-Id: DEE251F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

This reverts commit 415cb45895f43015515473fbc40563ca5eec9a7c.

The dma_buf field in struct drm_gem_object is not stable over the
object instance's lifetime. The field becomes NULL when user space
releases the final GEM handle on the buffer object. This resulted
in a NULL-pointer deref.

Workarounds in commit 5307dce878d4 ("drm/gem: Acquire references on
GEM handles for framebuffers") and commit f6bfc9afc751 ("drm/framebuffer:
Acquire internal references on GEM handles") only solved the problem
partially. They especially don't work for buffer objects without a DRM
framebuffer associated.

Hence, this revert to going back to using .import_attach->dmabuf.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 722cde5e2d86..97aaee26cb02 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -204,15 +204,16 @@ static void virtgpu_dma_buf_free_obj(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
 	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+	struct dma_buf_attachment *attach = obj->import_attach;
 
 	if (drm_gem_is_imported(obj)) {
-		struct dma_buf *dmabuf = bo->dma_buf;
+		struct dma_buf *dmabuf = attach->dmabuf;
 
 		dma_resv_lock(dmabuf->resv, NULL);
 		virtgpu_dma_buf_unmap(bo);
 		dma_resv_unlock(dmabuf->resv);
 
-		dma_buf_detach(dmabuf, obj->import_attach);
+		dma_buf_detach(dmabuf, attach);
 		dma_buf_put(dmabuf);
 	}
 
-- 
2.50.0

