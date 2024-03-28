Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD21364
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633492; cv=none; b=Ut3Px20esQvkwMMNe3jN7RQ0uyOqx+PPWu4on2Wj2Ff/lDw7R+B6cW+wsr+0gQg1uwp9yNxwVj+jaRzuXAs/1ZZ6ukEajoyKcrXtUk7DJZoLmSTCxEEOf/idHGNJZzN3qIv4NRcnrWRR8EeB3Qtc8akW2Y9XByBh0R9xekqshvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633492; c=relaxed/simple;
	bh=1b0kDwcvNj5vH5K0pAK4HupQheat89mZSwQWjzdBGDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQ597jsuSHDOx3cUrXfZvdKdZt5l7bQR9SKfzD4DN5zRpmRzrzfs0usvXYJwRAEQ2bd/gTREgi7C85wo+tkcJ0nWM81bbZghJqlzsWzXhwLSfNknMd/uOjx3PPODNkqN5kKIGjOpdDfzzdWmowVbd1H0BmUwBpMM60DDxjt0cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKpHIemU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKpHIemU"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-515c3eeea5dso899046e87.1
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711633489; x=1712238289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0ld9ottGtMP3PSLHeDCuhhunV2RKSWGGUbt6pNFLTE=;
        b=BKpHIemUUoMPm/y3QyXr5Rfdila5m7e3eRfszvpHUTFuj+ELTjtRibTofoGC0bHeYO
         yrH59PCT2KlghX+RzV98UXddU3m6Dcme93rTXsmy6VZy6qlwMPqnQ/nhEInUUEHGuv0O
         35n7vkBHy2uP2fnemjmR+VNW1uQM3RL+4EuFL4yuRsmTvIGQ6fpRnP6jL4VdzJ85Q03H
         /ARiGxmTw7NdDcXVGCzfJHDnVxuqFuzUmv0Z2TvBefSRYrCCaN1i456BV3E5ZQb7Q3fp
         aW9XwVal52U/i42Dg0UVPJ4OGQb8aR246izGI5l5HBxcz3lvOuFDnw2DViQSUhfSEMN1
         w4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633489; x=1712238289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0ld9ottGtMP3PSLHeDCuhhunV2RKSWGGUbt6pNFLTE=;
        b=GK/+WG+9DR0/kSTZSXYKZYMuW24EZZgKj/YKCodMzAlDvYeJLrW9kZoNQRLMrABmlz
         jzOzY+izoaBHL+4m6XcfTVOVkilZKr4uQCzRb67ynJTTFJVB4FcfG0zcktC5cQYeJmmC
         fRJMc7dGcWFqUo0ore4OLBEXwxStDCNkHGk4cfxjJvFHMNW6jbT//ZL8xojUEuFkojTY
         DWw4U6aPzNU+46WiKOpHXQmNJbUbYXnpB1KAvhRseqs5PJ3+RXpveqLNnLmaymV0+xyB
         aPjA5CFJ+IRT9YahsCFUMwAOd9Oe9OucR7s6gcMHdQEC9Iw/jfn8vkugfJD/1g4Hw5KO
         ILhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVAHXmhyKpwVO7UygryZmBuJKs9JvbiJ/7eseXSZKlHbIsheobu+zeV5jxC1EZyEUmcSW4riwwN63QDBqUkA6nIXiY8uuxAuwXBsS0z+8=
X-Gm-Message-State: AOJu0YxwNRymev7+EhgpuvVhf396582c70HG4lxTBCT8v1Uz5brSG2f+
	ol+XgR1GjuDh1UmkXHWbp9eRZk/vkPhzuKMUbRbdAiT6KZ4DD84hOOuD8X4/uv7BaA==
X-Google-Smtp-Source: AGHT+IGgUYdZXvk1Jxa+qm2IRi+ZxbQKQ2cbC6z+k22XLHpAg517MrIY7J9tdrqnczVNq3X2Isc3Jw==
X-Received: by 2002:ac2:4642:0:b0:513:bf6e:bf05 with SMTP id s2-20020ac24642000000b00513bf6ebf05mr1858320lfo.14.1711633487520;
        Thu, 28 Mar 2024 06:44:47 -0700 (PDT)
Received: from localhost.localdomain ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id b26-20020ac247fa000000b005159b7007aesm212501lfp.153.2024.03.28.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:44:47 -0700 (PDT)
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
To: David Airlie <airlied@redhat.com>
Cc: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Emil Velikov <emil.velikov@collabora.com>,
	Ivan Kapranov <i.kapranov@securitycode.ru>,
	lvc-project@linuxtesting.org,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: add driver_priv validation in virtio_gpu_create_context
Date: Thu, 28 Mar 2024 16:43:51 +0300
Message-Id: <20240328134351.298050-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pointer file->driver_priv was dereferenced without checking
against NULL, but in the "virtio_gpu_transfer_to_host_ioctl" function
it was checked against NULL after calling virtio_gpu_create_context
function.

Found by Security Code and Linux Verification Center(linuxtesting.org)
Fixes: 72b48ae800da ("drm/virtio: enqueue virtio_gpu_create_context after the first 3D ioctl")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e4f76f315550..98fe9ad4ed15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -64,6 +64,9 @@ void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file)
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 
+	if (!vfpriv)
+		return;
+
 	mutex_lock(&vfpriv->context_lock);
 	if (vfpriv->context_created)
 		goto out_unlock;
-- 
2.34.1

