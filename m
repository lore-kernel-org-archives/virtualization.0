Received: from mxout022.mail.hostpoint.ch (mxout022.mail.hostpoint.ch [217.26.49.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5043559D6;
	Sun, 20 Sep 2026 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.26.49.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789932177; cv=none; b=DqMORtUl9RP20WRkJ3QA36jOZnF3F/Bib0UDwdpWOi4xPZAxDLgdhZ0puBmJvpYfKH0J+jaUyeyJ2GOW0r3cErsk1f9QqcLgABOgVtYjO+1SYR7mv/nXHhoTfuQ0O1XQfVlF7qdLwlH0XMM7mKnJ1co3//a9yVgfT32Djea03Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789932177; c=relaxed/simple;
	bh=KfiKVqkGiI50aZKch9SuX0904yUARaE+2fx0b0z9Cx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiBHjA/7WlactoC9f8wF7GzPBbqycfXuAhcvC8uotm6HMm3lMkUnDCxpSRzdmwmml8BJ6QsBKxKCeZrKQ0qSvtWHyCi0VBvgXlVnmmUIPzU/NRE2/JIyNjs5IFkkkhHhjACW37hfCeka1ImV8Owhsl7juvV/oyRmO1y7eWrJ8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sebastianvonarx.ch; spf=pass smtp.mailfrom=sebastianvonarx.ch; arc=none smtp.client-ip=217.26.49.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sebastianvonarx.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sebastianvonarx.ch
Received: from asmtp012.mail.hostpoint.internal ([10.4.1.185] helo=asmtp012.mail.hostpoint.ch)
	by mxout013.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5 (FreeBSD))
	(envelope-from <linux@sebastianvonarx.ch>)
	id 1x8MXA-00000000G8V-0Xed;
	Sun, 20 Sep 2026 20:45:04 +0200
Received: from [2a02:aa13:e47f:2280:d4b0:56c5:656d:f4f1] (helo=omarchy)
	by asmtp012.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5 (FreeBSD))
	(envelope-from <linux@sebastianvonarx.ch>)
	id 1x8MX9-00000000NQ9-3uLY;
	Sun, 20 Sep 2026 20:45:04 +0200
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
Subject: [PATCH 2/2] drm/virtio: Propagate drm_encoder_init() errors
Date: Sun, 20 Sep 2026 20:42:44 +0200
Message-ID: <20260920184244.464343-3-linux@sebastianvonarx.ch>
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

vgdev_output_init() ignores errors from drm_encoder_init(), so output
setup continues even when encoder initialization fails, for example
because of an allocation failure.

Check the return value and propagate the error to the caller.

Assisted-by: LLM
Signed-off-by: Sebastian von Arx <linux@sebastianvonarx.ch>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index b01178027..1c790d6a6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -310,7 +310,11 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs, DRM_MODE_ENCODER_VIRTUAL, NULL);
+	ret = drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret)
+		return ret;
+
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.55.0

