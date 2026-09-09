Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2E634216C
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939315; cv=none; b=Ljmuobi0E4e5i+Er8i0vYMFtcHEqKee6i8EoNCn1V8wY8AjKFXUj6UG7V2jS3BY/WKKlLiPVUd69RyV39PUm7/AuMvyrXoTyxdgWPs3pxvAYogMl9B+2TRF14qyPPdhKaxIfxGGRbrungHtkdkG1E6KA4n/ANxU5rSfHRrxUu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939315; c=relaxed/simple;
	bh=9vP7F5wuPWbwJk3ltHNtDQR/ieD1hIKW7Aiaaw7mG/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3ZaALA/iegsCFsdeVer22LNobH8In8cXqmPEfrM/TUikF3c1wQF4+JiMrX6p0ohCk/DsUxrP6lKnGZZOH192m6RUgIlwVQ4AFkYgB3QGNjXVWoGaY2iVPs58/y7tviAsmWC4f1QjiLvQer6w/i9b8iDubxV7VYcinU+o7dnkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwFgM1uL; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwFgM1uL"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-484366874b0so359154f8f.2
        for <virtualization@lists.linux.dev>; Wed, 09 Sep 2026 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788939302; x=1789544102; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rwJskRf230nVoXvEhVqyDUFt4l3Cq8VmWwWkkc6yiy4=;
        b=CwFgM1uLL2L5JV6JsT0w1KK1DxcrhuTjL23/LBavoWlwL/mlDLZFnnbFxcG34JqGs8
         8gAoFFfieazOJLlakmgpUD+iYBoHTy75iPETyTT9N3IEincOxFRVL1XMYD1rjTxkp/oX
         paCZz5j633wcL3pElznGUzTW56FcfXoMTzuKf+JenOrTVyMLkNCGPZzXFq/5NS1XjNmh
         0n7laXWw4EpYi+3EUmcYYN2CAc5ySgqngsatO7ieqo5IlWhK1UKyCMEj0GqPlV3yGS8u
         nFNq+Hqz0SHGZ3100ukRT/pdRR5t2wIivuMwsa9rz2jhv1vN8tpJnLwRcu9vp5T+ZkMQ
         u65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939302; x=1789544102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rwJskRf230nVoXvEhVqyDUFt4l3Cq8VmWwWkkc6yiy4=;
        b=RYBfm83thXsgNajaQb8molGSStA+Zq8JZ+8cmeqLquhwh28e+wuaZuTLrgC9mtbbVi
         EbbjnfaTuZU/VVXpVyp/2OaqXWEL9+ykk7BPFZ1KBwXeNJ4hfvnN0OQ2Wc9tFftXeheH
         Pmt3Orok9oBEpu6mtUBbVhwyPFGT20Qnx6deK513d+Pw8Oe/DCcCDABdU/czJN33xiaR
         zXs4K2LS50G9In5nuBZ81nFZDIYvIktyXfRRd6/ZzxcGtblNG/3qf/qjbn4cQF52vE/a
         Q3Uipf3zH/lk5Xz7WCq9yZU3ddnIqXMyL8Xoo7oYzj4b/1HLlTLbj5YMJzRECFhnHmxT
         AzsA==
X-Forwarded-Encrypted: i=1; AKwUvBzoyEs3HUIVl+CgShFlrhTbbuAQ+pziVKgvKPixVnyrhABS7AL9NhgbIN8KKy9UEVk9wj9avbJiu/cLFZ5qMA==@lists.linux.dev
X-Gm-Message-State: AFuF++kMhvp6pOqpyJF34hjIkxdf4ZYkKqwlt9Y+Ba1U6EYBtHJW3+Nv
	9dgUw/c8vkybldqTlGQo7Ieb9VveI38tpoojqH/8mzy0MygZW2e6IpiL
X-Gm-Gg: AYBFou2ryKmt6no8gzN+osV3Wa9bjybUFLGCwip2jDBaDfy0mshpKONiS1THOXTeL/3
	dm0K+0KdKG+J1JaGA8NjaR6d7rK5WeOZ2eA2qw8/h4PO/5Kh184zm429+RGxzQjIgg6JOfK5Q9u
	ueEXuZ0ue42TB/Po39Nx93+uA2WhZIjsB733/ZM2r/kpwda0lSDH6d+8qJZ5k7YUONIYV+tQy0v
	0RcAnttmt7fsbD5xRNNwSDMqru0dnN0WRDOaM0y5DyVesVWdE8GFv355rOhCIGqcFIesU5HUKDu
	XWPJkd04GiMWdDJzIMzaxvdNgQvNZ9fnLd14H0AMl/zSEUv1bdm1A7PILvfYzwIvM9WNpHaCIts
	tjtBvOReEDprVpkdo0ZvylpeHNkC9aJFO5JcMdbItuEFCXC1WGDZyRo7vdeGzasZ/PbzQOj8yCe
	Rnl/wubnBW8YKo0cxyWK6xJg/ylB0PlJCGMeH0hRqjH+smuEY3z4aM7ru2gL1OZZGTG/xaTaiS3
	QzRl71AjakW+YSW+M80dYJZVN+LwumiA4AviwSJbudkZWGv/hIDr9MNU1Ddxhn3kAb2524RqxgB
	hcxfd7agUL8Inb1R2qbgs7S+GUobIWlSlRkjO3Q=
X-Received: by 2002:a05:600c:604a:b0:49d:1012:893a with SMTP id 5b1f17b1804b1-49d1f320b72mr55194575e9.7.1788939302009;
        Wed, 09 Sep 2026 00:35:02 -0700 (PDT)
Received: from PC-Davide.homenet.telecomitalia.it (host-79-24-252-102.retail.telecomitalia.it. [79.24.252.102])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm588770945e9.1.2026.09.09.00.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:35:01 -0700 (PDT)
From: Davide Bonatto <bonatto.davide@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Davide Bonatto <bonatto.davide@gmail.com>
Subject: [PATCH] drm/virtio: Replace deprecated drm_simple_encoder_init()
Date: Wed,  9 Sep 2026 09:34:38 +0200
Message-ID: <20260909073440.52641-1-bonatto.davide@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_simple_encoder_init() is deprecated as it introduces an unnecessary
intermediate layer between atomic modesetting and DRM drivers.

Inline the helper call in virtgpu_display by defining
virtio_gpu_encoder_funcs with the default drm_encoder_cleanup callback,
and migrate directly to drm_encoder_init()

Signed-off-by: Davide Bonatto <bonatto.davide@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index a1a875a0c706..85986578001f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -67,6 +67,10 @@ static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
 	.dirty = drm_atomic_helper_dirtyfb,
 };
 
+static const struct drm_encoder_funcs virtio_gpu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int
 virtio_gpu_framebuffer_init(struct drm_device *dev,
 			    struct virtio_gpu_framebuffer *vgfb,
@@ -306,7 +310,9 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs,
+		DRM_MODE_ENCODER_VIRTUAL, NULL);
+
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.43.0

