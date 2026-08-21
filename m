Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797535F164
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323260; cv=none; b=NGAqhmiPFUoNQsq2lqcFtmbdZhRzz/pUI2GuNSQdv4q3tQ++zymevxfYofCgf2oAaHb+c6CqW9ml2pI8ODKgiMGMqJq4VvqextXjE8i63HS9Pb+pLPTv7D6x15DBQ9PWAVk+Hfqisa4ZL/C+DTr3vF53oPG2BAPHAkgWHFOrwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323260; c=relaxed/simple;
	bh=f9XtDyuCF8q3dFTH/dUWkN+PU6BsrizgHtChfYfOCJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bshTbGaXtafAYVJdCXlFO5i3YLuro9b18cXb4y7jYguLGhuDNvLyqfB1WauXsaBuQyQZ5DzAysLk9R7uytPoWjjOMW2voy9W3oJpCWjTUPE5XUYmd5u0r5nWnYSQJlctHpa7TIKCk+A2upBiQ6kiJFlc7Jud5lK2hyGcUy51wtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUBl9fTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUBl9fTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFB81F000E9;
	Fri, 21 Aug 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323256;
	bh=rcQR/P7J9ROu3FgfslSQMzpe0RyerJnArHhtAL9GON0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hUBl9fTj+CAg6NzatBR6CFP4YyQ30XFcy9ifAyprAXZAgr5LrwkJ7bkQ99OcAzCnC
	 LVEJ+a2ryqzfYC1WosxR9E/HzhNMHSUyqk6P6hKtC1vAoG3DtUDciiLKMdFjsYdWdd
	 1Fu1PxtGuGoaOvDtUcdpei86YwK67JdxtlTwoYjZFEz7CT/d6DrLGUfKl18s2+hSXL
	 l0P2TqHZ2X11kAStGh3CqL+m1F3CsNspx4zZ2n/1y+20Fw5ldOuTlh/Rdsl+kFIKjj
	 5H5Zr+21ineqj+2vWi1hCMvYD2ykONHzGhwPiVGwLKKPeH1TtAV3tH1DRWHWOfJWO7
	 Ga2kohh9iLLHg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:15 +0200
Subject: [PATCH 39/70] drm/virtio: Switch to
 drm_atomic_helper_crtc_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-39-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=mripard@kernel.org;
 h=from:subject:message-id; bh=f9XtDyuCF8q3dFTH/dUWkN+PU6BsrizgHtChfYfOCJI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyZzJzLYVxwS2MZkdPTTjKu+VuuOLCrPsftn/mPpkV
 5cIl8W8jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRY9aMtaISz9huyxY99vuX
 fbKw+nRq142dqZLyB81dBESTXecXvuaUW3BT1DGn+f29HXFqT4R5GOu0DvqrvvkuFnB627v30nP
 Ytf5UJLD3hgQ+YttiY7mfR+dj9aX3YbqyB3N773WsspkQ6Q0A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The virtio crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..c0b71fdae330 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -53,11 +53,11 @@
 static const struct drm_crtc_funcs virtio_gpu_crtc_funcs = {
 	.set_config             = drm_atomic_helper_set_config,
 	.destroy                = drm_crtc_cleanup,
 
 	.page_flip              = drm_atomic_helper_page_flip,
-	.reset                  = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
 	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 

-- 
2.55.0

