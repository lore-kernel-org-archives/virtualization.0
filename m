Received: from mxout023.mail.hostpoint.ch (mxout023.mail.hostpoint.ch [217.26.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA630471D16;
	Sun, 20 Sep 2026 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.26.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789930847; cv=none; b=p7KtvZijslknutw1MYX7OrWSQReVX1UIgHkCwGlEU9u5IS8anqoxgw71U+T3Aq7fu7wO6qT5SEITlRpMQsMRz+KEpbke3lTZZkLTPdXyGQ1l+nYr80GUYP4lK0QZe17JjrjzTny0reAX0sfZsNvz0jc5ounMlinXe65QuuMfY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789930847; c=relaxed/simple;
	bh=8Stw3Y0zlGIEn2TMydnWTmjMB7Ei6HOaSjbgjRO56WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbCl7KHHWmrmy5ngaDwZq2TlnzR2in6sj0ioeqoxlFnb9uvEbtXPy92EmBpRc4HLjYVdz2denFgKeR4MsjMIFdFM7NtAzeTbrVBFRg3elxgvPlFGwC5auUC8FzApqF5HKRRscBIJXqTraxAAc2W+SYsGoOrwffcu2sPz2l5uaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sebastianvonarx.ch; spf=pass smtp.mailfrom=sebastianvonarx.ch; arc=none smtp.client-ip=217.26.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sebastianvonarx.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sebastianvonarx.ch
Received: from asmtp012.mail.hostpoint.internal ([10.4.1.185] helo=asmtp012.mail.hostpoint.ch)
	by mxout014.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5 (FreeBSD))
	(envelope-from <linux@sebastianvonarx.ch>)
	id 1x8MX9-0000000054R-39rE;
	Sun, 20 Sep 2026 20:45:03 +0200
Received: from [2a02:aa13:e47f:2280:d4b0:56c5:656d:f4f1] (helo=omarchy)
	by asmtp012.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5 (FreeBSD))
	(envelope-from <linux@sebastianvonarx.ch>)
	id 1x8MX9-00000000NQ9-2FZ3;
	Sun, 20 Sep 2026 20:45:03 +0200
X-Authenticated-Sender-Id: linux@sebastianvonarx.ch
From: Sebastian von Arx <linux@sebastianvonarx.ch>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sebastian von Arx <linux@sebastianvonarx.ch>
Subject: [PATCH 1/2] drm/virtio: Open-code drm_simple_encoder_init()
Date: Sun, 20 Sep 2026 20:42:43 +0200
Message-ID: <20260920184244.464343-2-linux@sebastianvonarx.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920184244.464343-1-linux@sebastianvonarx.ch>
References: <20260920184244.464343-1-linux@sebastianvonarx.ch>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_simple_encoder_init() only wraps drm_encoder_init() with a
cleanup callback. Open-code the helper in preparation for removing
drm_simple_encoder_init().

Assisted-by: LLM
Signed-off-by: Sebastian von Arx <linux@sebastianvonarx.ch>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index a1a875a0c..b01178027 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -271,6 +271,10 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static const struct drm_encoder_funcs virtio_gpu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 {
 	struct drm_device *dev = vgdev->ddev;
@@ -306,7 +310,7 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs, DRM_MODE_ENCODER_VIRTUAL, NULL);
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.55.0

