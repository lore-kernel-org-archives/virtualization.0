Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D51F5413
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435604; cv=none; b=NhYEY8GBxOh6z/Stbs3TgBcniF6CH+PkuHcAZeC2NUy8SNlRiHpMIrOQXiDRG1ekihBewHMSrkkFLXPGmjHkyUuE7103ioge6jJLmrFVCi0pBkSRaO6wGAfOJUW0iG3T5HtB0UNmqt15s+KkIUvfNJbOzAa8jk/qkvFnBz/48DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435604; c=relaxed/simple;
	bh=4ujhfnsD9gR0dVbtPkG6+9ZOl4u1TOz+cGHcmkSuqBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWJ/ZLZ42wj2p1W5mJn7QWhyQAIqg7iQlJ2ouTIWYjsZ3EUn19W1noxzKRXkYcvX2+3jN1knXXEPSogeioq6/daQacUUgBlUiX7A5rNhupX4rxefTIoMpIWM+SNSBt9DAAYnZP6GCOuCBtkzdAvr31HiTP8LlHoygrOUDlcT8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q9vVmqwh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9vVmqwh"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so25584155e9.2
        for <virtualization@lists.linux.dev>; Mon, 05 May 2025 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746435601; x=1747040401; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S92e1vh4VqkP6Isn8EhCS9MZeN0/LLF2cWcJYmEVWj4=;
        b=Q9vVmqwhAaDLBKctRa2fjOZkxfI+qUImZK86lQWnb93P7eFmQLl4kBns3PqoVSuZF5
         WQuyL1TlQbHfVHdFSTotjcIi93lh9JlzDDgZ/HT5zJiZLu+1mtmxh+/yJOtHxYKr9pZF
         m0i3GOUu6sSWLZWAzp3qfZufr0VHV9/xlRfBvkfvfavnK7dZfqVmnqx4hJgSZgReiaDH
         pH9FXaBRG5ZdTNJWTveF58beLNq318vUq+diPvFCKZKjTg11iQGA5DKZlL8d8sMTeoEz
         QSzRnrDa2nQRZmEFl11bJTl9odvvP6fN1dGwP39BCe6HAawCfa8j0R26j5HoDAZOc+e+
         Y9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435601; x=1747040401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S92e1vh4VqkP6Isn8EhCS9MZeN0/LLF2cWcJYmEVWj4=;
        b=IWqsI1oT0YuSrbsmZ8C0y3KsyF8ogQPYG7imlCOv4FLGLM6TMMIOh84EmYXAwIqLLH
         RNEQ9n55KrQdZJjaohu+Bj8Hiyz+dxOJtuGNiPVQGH0H9eZ4sCNNT0gM4FMNshE92yKS
         +Kmq6eWVoFpdmLDOI3qkKwQ6st8vfGOkIYQL+HLCYJr/byZc2GtwFyI90vkSXLuIOKR9
         iqBPCXWbEbcptOfgO4AcbMDsIVBUCCeD2aZWt1mC2kYjUo74a48emNvg7krSkPVtpmg/
         kDkZ2YJ7guc/QAvQQdkDs61m9uqBbqe341PS7Q8PdiekvkL0MMH3gqx7voETHp8c2Vtv
         fg4A==
X-Forwarded-Encrypted: i=1; AJvYcCXbXWtubrzlWUuZFpJjF5c792QUyx0v6lJzLf4zXYC5KzHuRtilZCks0NsoOLnyqTRYKxICNWnOHFNQVACkHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAJFME7+e3pDC8QrjDkZRjXeYP+TDarGddDqqA2thxCYbrdeA2
	3en6KoGwZOkDljoB252KqdKU9TpJTmrZ9GoUFfGP37xQtEWpGaGCycp4Lm24o10GAM0G8MhuN9G
	+YvQ=
X-Gm-Gg: ASbGncudm/lTRzgq8+IL7l3J3Fouio2N3Z/qHpo81uoYTQ6/N9pKoPCQJJC4su9dccs
	bfkP7XC1m9jUhrUldVj2YM9Y3AfcoTguROAHCxnf4aWLXMZH8DCDWyCLS2VE9cSXEqLh0s3GYw5
	ecXBwTZ99uvinRlBOFIqgDDRuHfBj3MMP13HtzAoDJLmaGs1XrbOphnHUCqcpPQwMXfaZrCxSnx
	h4ynEyvGJn3wJ+LioieHJlOcJCbcDVr5VNUJD7ElIyJ+ch1tWCZv1258ZX8xSKtTisGLdi3s2jN
	g9ijHSorgOzO5eiBWVFw/YYyUN/uShcPnn+15iS4vuiZ3UpaEs1vp2IbTpBodkPsL6H+hLgEvIy
	r7vN4aM4roHv8H+Y=
X-Google-Smtp-Source: AGHT+IHjn0WyAvaUOF4DlLpk6vtF8Nr+Hc5ikZjH0bnD+F7TX2WdfOdAMYnVE4VqixoQkEYwPJFamw==
X-Received: by 2002:a05:600c:37ce:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-441c48d16ddmr50750345e9.18.1746435600672;
        Mon, 05 May 2025 02:00:00 -0700 (PDT)
Received: from [127.0.1.1] (adsl-186.37.6.163.tellas.gr. [37.6.163.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm170432475e9.35.2025.05.05.01.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:00:00 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 05 May 2025 11:59:15 +0300
Subject: [PATCH 2/3] virtgpu: add virtio_gpu_fence_cleanup()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-virtgpu-queue-cleanup-v1-v1-2-810923da2b1e@linaro.org>
References: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
In-Reply-To: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2670;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=4ujhfnsD9gR0dVbtPkG6+9ZOl4u1TOz+cGHcmkSuqBg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9HSDRMSkxTOFIxYU8xdmI3Z2kyZkpSYUYwVWc5CnQzaGcwdkg1WUw0UkJzSXFU
 dnVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUJoK0N3QUt
 DUkIzS2Nkd2YzNEowUGhtRC85S0h6ZFVTRGdlZHdreWhPWHdiNWp5R0ZiY1NSRDNGczMxUHh2SA
 owMzBDK3ptczh3aFpRUWkyWjhIckp1NDZzb1pDcUlSREVkemRkWjBuUzZmbE4wVUlpSE5LTDdSV
 TFZcTBVT1R5CmpTMzdZbkx6NmlWQjlydFQxcUdnd05sOXM4bGZCdWxxNEFNUW5hd3lxRVhyd0ti
 UGw1SjcwbDBRMnVxSHNzcTIKTktjYVRQdThDUncrNkUwS3d4Wlh2Snd5dVBsRmo5YlRvZStJZXh
 BVUFSb0tteWtDNmtMUXpyYkMzVnNUc2pTaApzbUg0V093ZDUrMWkra2dYS0VKc3VvV25LZGFEcX
 FqL2dKSTBSUGtKc3FvazBoclF1S3BRSFFsaTBYWThpUStwCitoaElrQ0dvOERZSjVZR2V3bWxQR
 EMxbGtvR0h1K1ZUY0RSTW9iZk9mSVBrcWt0TjNmOTQyMEFHb0VYV01yYnEKb2JkUzd1VU52WW1B
 YUVnTzJaMVhZOUtZWkkrUW9TTzB5b3NrcWgyUjdOVkhrbG9iZ1FGWFBKYkpDejJ2U3FwaApXZkF
 DVTIvekxmencrdTNzaWNyaEQvc3dYVWErLzIxV2tzMnhWbWU2ZnJEREhXbzdZMXNWNmNFQk5uaz
 ArQXpyCkxkOHp4Nm14cFVaLzk0QlJWeG5waDJGbWhJZTUzVFpoS213bVlrdlJpcFRuUytuQ3R2T
 DkvOXdTZENtcFBIMjIKNy9HMjN4cVRNS0s4a2pwZncvNE13ZGhNSjcwVHl5UVh6UG94VERxQzAv
 ejIxN2lDQW9mZkdYUVh3MlBiWVhQbAorNncvY2MyZTk0RS9VbVlhUnVYUEpEejN4b1lHeUxSMyt
 kNVFjbi84N3d1dXdpVWxTalI4OTQ4TlFJMTNaMHk4CitTVEluQT09Cj1SY1FOCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

When virtio_gpu_remove() is called, there might be in-flight command
objects in the virtqueues that the VIRTIO device hasn't processed. These
commands might use fences, which end up being leaked, as reported by
/sys/kernel/debug/kmemleak.

This commit adds a cleanup function that lowers the reference count of
all in-flight fences, resulting in their de-allocation.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_fence.c | 12 ++++++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index b3d367be6f204dbc98bf1c6e5c43a37ac8c0d8b3..c94b5edb2aec42fe5cd6416e243cf40e4e2b060f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -465,6 +465,7 @@ void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
 			  struct virtio_gpu_fence *fence);
 void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
 				    u64 fence_id);
+void virtio_gpu_fence_cleanup(struct virtio_gpu_device *vdev);
 
 /* virtgpu_object.c */
 void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 44c1d8ef3c4d07881e2c4c92cc67f6aba7a5df4f..3e536d190c0464f4db8955605bbf0aa4aa3612bd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -157,3 +157,15 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vgdev,
 	}
 	spin_unlock_irqrestore(&drv->lock, irq_flags);
 }
+
+void virtio_gpu_fence_cleanup(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
+	struct virtio_gpu_fence *curr, *tmp;
+
+	list_for_each_entry_safe(curr, tmp, &drv->fences, node) {
+		dma_fence_signal_locked(&curr->f);
+		list_del(&curr->node);
+		dma_fence_put(&curr->f);
+	}
+}
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index da70d9248072b64786a5d48b71bccaa80b8aae8f..7b3c4d314f8eee692e2842a7056d6dc64936fc2f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -286,6 +286,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	flush_work(&vgdev->cursorq.dequeue_work);
 	flush_work(&vgdev->config_changed_work);
 	virtio_reset_device(vgdev->vdev);
+	virtio_gpu_fence_cleanup(vgdev);
 	virtio_gpu_queue_cleanup(vgdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 }

-- 
2.47.2

