Received: from mail.noirlang.tr (mail.noirlang.tr [217.18.210.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A845D5C9
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.18.210.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322930; cv=none; b=kt5B7iC36VLJBa8ZpVdNK+w6kRmIupHGr4nIml7CJKmM/sk6yJt6VW5CZvdf8BiIVdDM7hQfh1ZU9MAJAvMx0wQjMpBXGDN+T0l1Hu+OZHNz9wDy83v4/YYG6swKOZONysPtvNy00Y333cxJslq1Amiwbqakzusnf6OCYa+cLo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322930; c=relaxed/simple;
	bh=uYAXWKh3pVi83U2Vt4WZSW9U0O1j5A3aF4lZLVxVC4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XENuM+iHvzk+GWJQP2SWDe5MkdCglpQu/y3eDZgb52gsABJMtI+rpz+cRBHhNGZzqIZPSK/29QyRCZYfG86DbuulGnIe3cPrSQ+BmiOBQGmBHFuU7oaunLwpgViw4iyZ/yDgVDQldtHNogYdJYTD0tMa4y5VXtmTr1fgpeQAGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr; spf=pass smtp.mailfrom=noirlang.tr; dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b=aUbD5ycH; arc=none smtp.client-ip=217.18.210.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noirlang.tr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noirlang.tr header.i=@noirlang.tr header.b="aUbD5ycH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noirlang.tr; s=mail;
	t=1792322926; bh=uYAXWKh3pVi83U2Vt4WZSW9U0O1j5A3aF4lZLVxVC4U=;
	h=From:To:Cc:Subject:Date:From;
	b=aUbD5ycH/a39AdXOVqbwiXaPwJ5BDksrSofak7odt2OPY5lFA8P8OC0pNn5NUG9/u
	 CHNccu6fOJORy39RdFiUZB2U8r93mjrziejkbqkQ8grok4NcL0AxFg8bQGaDVKopwY
	 m9w1i2yNaWfsNyXx9+7RkD5YgXyJHtSYBH+NBtjp1qJh850pEZBLdwxgoyTqW3PTsc
	 VEDfO4ieAwN6CuFmJdx7HJwcXCWDmY2ZLSwkpTZAxQ5ZMaS5PC+Luyupj2a0jQHMb/
	 5x8jDv7osNxA7120lP1dJrWZNmIb4YOSzmluCRCDizpfQhM+1SG8ZjLXhZdT+jTJMF
	 qSN2UTLlpj0Tw==
From: Melih Emik <melihemik@noirlang.tr>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com
Cc: gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: inline drm_simple_encoder_init()
Date: Sun, 18 Oct 2026 14:28:44 +0300
Message-ID: <20261018112844.360262-1-melihemik@noirlang.tr>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper drm_simple_encoder_init() is deprecated because it adds an
unnecessary intermediate layer between atomic modesetting and DRM drivers,
as documented in Documentation/gpu/todo.rst.

Inline the functionality by calling drm_encoder_init() directly with a
local instance of struct drm_encoder_funcs. This allows removing the
dependency on <drm/drm_simple_kms_helper.h> in favor of
<drm/drm_encoder.h>.

Signed-off-by: Melih Emik <melihemik@noirlang.tr>
---
Tested:
- Compiled with W=1 on x86_64 with zero warnings or errors.
- Verified with lockdep and debug mutexes enabled
  (CONFIG_PROVE_LOCKING=y, CONFIG_DEBUG_MUTEXES=y).
- Boot-tested full bzImage in QEMU with -device virtio-gpu-pci and
  initcall_debug, confirming successful probe and initialization
  (probe of virtio0 with driver virtio_gpu returned 0) and zero
  lockdep/kernel warnings.
- Verified with scripts/checkpatch.pl (0 errors, 0 warnings).

 drivers/gpu/drm/virtio/virtgpu_display.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index a1a875a0c706..1bdbf452d111 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -28,11 +28,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
 
@@ -232,6 +232,10 @@ static enum drm_mode_status virtio_gpu_conn_mode_valid(struct drm_connector *con
 	return MODE_BAD;
 }
 
+static const struct drm_encoder_funcs virtio_gpu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
 	.mode_set   = virtio_gpu_enc_mode_set,
 	.enable     = virtio_gpu_enc_enable,
@@ -306,7 +310,10 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret)
+		return ret;
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.56.0


