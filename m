Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECA244AB8E
	for <virtualization@lists.linux.dev>; Wed,  7 Oct 2026 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791411783; cv=pass; b=PXSH2+FLuAwOIp/ieKkNP0ZLAKilQmRXbz/KUYv6lIynsj+jyKkb0mBWbsOzL/XUHUQcmZLerkZa5sGU0RRphwc/4kyf0GwPOT0fmZnsUzkOdilU1pooMc1wvVNZ+Um4zTgq7VaGeZzjiwsKfPKwln+6mkUGKlBHIC6zfRHRqTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791411783; c=relaxed/simple;
	bh=N68G1kNPC29Y3dj0xPRSwtB03/2aAzzJzyo9nJ4okvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOZbshuCBgpV91jZuq5M6bSiMKTQbtTLCp8XxQ1GDGUIpqMEY4eNfx881/N28OqQn7jrm2r+rE05cy6fBTtnI1V0K0548nNeTD7VE5HDduNYT8BtCtXb7puuBo/RIlYxKdE0oev7Sas2YxrauLSq3kbEFVPRM/vN/INEAxxvZ60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=AeAj9Llj; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="AeAj9Llj"
ARC-Seal: i=1; a=rsa-sha256; t=1791411775; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jvQFPzEiH3dqW0DGDSMLpVLaXoyJ4dv05KspH+dqEbEWsEsdXpWtZofhsUPZnwrBHzbBFWxK2R7Ji/vgtZw2RkUtHGY3vkhS2PW2J9QAZV0ja1f2YCy9Lno9hilLtmHdxQ85Tn+QTu89dU5sJq+fabcB6q28gt92yQr3squJvlA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791411775; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z2nIKukZw95dcKC5lhzGGPxFQ69nGF5VaLvHA5MuW3Y=; 
	b=ir1zmXvhuaHtgU5IYRJBC4A5vKIT0BkoatnRQtbC4hmiBepa1SllR7Y9lwDk0Li9YJuPhcpoFz2fqFJloNLjd4jVBcc2wg0vYujKma4MAr8QlhREznQVnV6/m2aYmh5VbTh48DIKw623X0vguZf7QohkSAIeEgGQcfqPxxfds80=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791411775;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Z2nIKukZw95dcKC5lhzGGPxFQ69nGF5VaLvHA5MuW3Y=;
	b=AeAj9Llj1w0I1954263tBAGt8nXp/9qvJr99VrxkoFK/oTDhT+dEjDCTtBDvsvd0
	eYvOU3kn80IXxlyOHbCrqsm8UeuEzhGv2amIfVwi3oPAXSYJQiSxacJgGD48VlVGa93
	15TpyUGo0ophcNJh6vUUhxM609aEaPNjS2HTLa+k=
Received: by smtp.zohomail.com with SMTPS id 1791411773989975.026492163321;
	Wed, 7 Oct 2026 15:22:53 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] Revert "drm/virtio: Add pixel blend mode property to cursor plane"
Date: Thu,  8 Oct 2026 01:22:44 +0300
Message-ID: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The cursor blending mode was added twice because the same change was
applied by accident from different patches. Revert the second patch.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com/
Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor plane")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index b422eba42a5f..640815af4098 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -589,7 +589,6 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 	struct drm_plane *plane;
 	const uint32_t *formats;
 	int nformats;
-	int ret;
 
 	if (type == DRM_PLANE_TYPE_CURSOR) {
 		formats = virtio_gpu_cursor_formats;
@@ -615,17 +614,5 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 		drm_plane_create_blend_mode_property(plane,
 						     BIT(DRM_MODE_BLEND_PREMULTI));
 
-	if (type == DRM_PLANE_TYPE_CURSOR) {
-		/*
-		 * The cursor plane exposes a format with an alpha channel,
-		 * which requires a blend mode property. The host blends
-		 * premultiplied alpha, matching the property's default.
-		 */
-		ret = drm_plane_create_blend_mode_property(plane,
-							   BIT(DRM_MODE_BLEND_PREMULTI));
-		if (ret)
-			return ERR_PTR(ret);
-	}
-
 	return plane;
 }
-- 
2.55.0

