Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD2B3B7B6E;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457988; cv=none; b=M7ILgeQLENbGKyMsgZQaGVEUD/FM414Mi4qQ1iwrPnnLhRioYmuMh3Kp/IddA57eg/JSDlXmIWyfIql5GGLHg9C5GjCJ7lwkq1ogSGwmc1DWj1mc/uuuagqIm7wCKfaN03EJQn9DIf4vT/BBnx1rkYqQXfiSQQVfGNcbFtSq4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457988; c=relaxed/simple;
	bh=zTFO9oTlX+pfOrYzO0SUc3KtS2BP0EOaEJ6XFg4DZzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g588v6NtDSUYrdoxkIZipY0ss5bB1QD4j6PHH6tB0FWwym869wiZVO+9c4l8Lx5x7jurMvkm1ox+XW+tFzx/Aat6vGnY7qjrBjT+ZEK8Yj4JNtm9C60EsKh/ncJigJXjprAR4/7m4W3NCldHD8nb5LAPbAQmODpk+Slc9xdoQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsPiko46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsPiko46"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FAB6C2BD04;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789457988;
	bh=zTFO9oTlX+pfOrYzO0SUc3KtS2BP0EOaEJ6XFg4DZzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qsPiko461+/rGtjYYzIIIr9O1zR9AcZ+NaKlAeKcDY1H1Y4dwvGvkWmVS6SIV3e6B
	 GCu0kNO+K92j0iQbhkDodyT3k9ViorOMVfqqllQPZ3WS2BAfA36TLjp8hGEJJ4xs1Y
	 TDQMKC73fbhTo7N00XswB8PG4XPP0xTcl9Lvx5P7WXWnCDgrZ+8dN9jc0oWKp0H/ZY
	 1PlJcjSLrCkZ7QYoIR9LJsi7ZH+3Z9V3W0AyDFTR6zmmoP6HdngeV4nqA2JcZYvpvQ
	 m6tyh4vBHqdSw651IFmeEQsL774ITQsy8PxHDpHdlDPNcGqiQsNHpAG+CCyTf4Oe6B
	 /dhws2C9zq79g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC0EC982C2;
	Tue, 15 Sep 2026 07:39:48 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 15 Sep 2026 15:39:13 +0800
Subject: [PATCH v2 4/4] drm/virtio: release the GEM object on
 virtio_gpu_vram_create() errors
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-fixes-v2-4-a0d799e4db66@outlook.com>
References: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
In-Reply-To: <20260915-fixes-v2-0-a0d799e4db66@outlook.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=uOmmSc9TIw8FhbYiw6eKAHWdQPO72b/48Wr4hLOpbhU=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrBXfnCo6Y9uvrPQ6knz8iXgAh57fXLs4oeXbcyI0g
 g9ZHdUQNegoZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAiayNZWRYdYD3pfd1v333
 Y0/XVyXbiKVp9cXdK7dg2arYFrArNX8Nwz/LRSdULy1e5P5L8VD9nM22TuZyXxs1zp05wLWnl9v
 iUiYbAPB5SXg=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

virtio_gpu_vram_create() frees the object with a bare kfree(vram) on
both error paths after drm_gem_private_object_init() has run, and on the
second one after drm_gem_create_mmap_offset() has linked obj->vma_node
into the device's VMA offset manager. The freed object stays in that
interval tree, so a later lookup or insertion walks freed memory, and
the dma_resv and gpuva lock are never destroyed.

Call drm_gem_object_release() before kfree() on both paths.

Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vram object")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/virtio/virtgpu_vram.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 5b4a3ab81cd5..01241ce4d07c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -215,16 +215,12 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
 
 	/* Create fake offset */
 	ret = drm_gem_create_mmap_offset(obj);
-	if (ret) {
-		kfree(vram);
-		return ret;
-	}
+	if (ret)
+		goto err_release_obj;
 
 	ret = virtio_gpu_resource_id_get(vgdev, &vram->base.hw_res_handle);
-	if (ret) {
-		kfree(vram);
-		return ret;
-	}
+	if (ret)
+		goto err_release_obj;
 
 	virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
 					    0);
@@ -240,6 +236,11 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
 
 	*bo_ptr = &vram->base;
 	return 0;
+
+err_release_obj:
+	drm_gem_object_release(obj);
+	kfree(vram);
+	return ret;
 }
 
 void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)

-- 
2.51.2


