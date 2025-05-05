Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC511F4612
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435601; cv=none; b=OxqBqGXinz8CjcbbL1Exdh6QTtRY6ShH/h8pYrgQIEtTf3Do46SYgD60uUrEMLUNiH+sHxzKgK85XOwyJIbDc9xAykCnm6aEKVvLmWAUci+nr2r8UthBi6Q2jM6jbjGHI2C4IPbKpHTp/W4AI8fkJa8TTlktKYSBq2Osb9Sre2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435601; c=relaxed/simple;
	bh=sjhErN8ONkfCqIGOTbBvg7YELbUIF3vZ82Dti970nCg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jv87aq6zidp7JwneOdeIiPsbawjXMpU0rHOKmIXzPfXKtoGvzWEOnTOXy/xRyq8yhZbW5lb/H+rMy7FUunfQCzZl272eM8Q8q3nRMzJI14dGpp2DfK2MMgKDUlS7P6tZsobKZLrP6QaZc8OxYQzyrYtBY3LSxfJmYblzNL+Hjxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NPajfKSk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPajfKSk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso26089285e9.2
        for <virtualization@lists.linux.dev>; Mon, 05 May 2025 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746435597; x=1747040397; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6RkMkpBzcyjYKHLAajmFVhljeyOe8/zIRKVfPqj3cNg=;
        b=NPajfKSkzZHvHhjjubuxOk4svlBjlKOAmQfDH5KYhBGQtjRFDagO8yOtt2t8X/gFHi
         mIQl7blNuZVK6pIA+BQCMzCSnmzvXGbqq5UsT30tTLeNyKih3UHxB7Jx3lpUWj6mZniG
         HX5lbxM/tWdHg9Y8jJu5fY2tPG9RUsxdYP6DeyJEoM2RMGVyJu907QfUZb8BFgFl7cFt
         Dw7iejnJcOJa2kycc20FTDuOTlme0QZrp2+OCHIYUkLsXfDM5N/5r16LIblLUhDScA9e
         9ZRHEAmJ+uDuxnkTonmfRUGppF6Y9FOSmzh7uuIsaXUg4wSuUWuWDeBD9Asi92sDwXlo
         y3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435597; x=1747040397;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6RkMkpBzcyjYKHLAajmFVhljeyOe8/zIRKVfPqj3cNg=;
        b=aeRgKTUZWVSRgDMCrbtQlNz3RFDLJpkPUuw2D7Zu8U61S0QYCImw0RPMpoNggbB3Xg
         twnFOFl0xB1YxbWfpNGJhWmPIHmZPpwyXuwsAAwhxOPbWa06eSaAcojSefBxYXr390gn
         yFo8aB8sDHgf/ElgMlBXz//P+KVBfFavBmfLLGy97WMgiwKXFskIDQvkctppHVeF460U
         6Jn/TnJyVtQsn+BHvF15EFuulS5eTVdldS7wOmOGNy1pJYxSfuEdMfbjJuV/dhGCYgk4
         pvEc7SPh1F7gh7Gw0CFxQNFd1aKZ9IPKDfZG37S70Lm4+byJV01pZIC2WrOYXtMA9PW0
         JPPg==
X-Forwarded-Encrypted: i=1; AJvYcCUEXxPLygJXua9871/eFQlXhib6247CL2cfSMHl/uUxtHjQ+9NQloa6Rpf7+Tzo3zvzmTRIcyl7JyB72B5oXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+tarSsj60G2eVglCiOCPmVn4nD9283cQbEeYJwaiYChKcsDUt
	utUqN7YzSKwWeZC9Jry4pAN3S5poSK/fn9Q/FBj1TgGtfq7X45uIU/Vj1tc/3Zg=
X-Gm-Gg: ASbGncshme7cM9OiM9/NHjGyGfDqK/wURP8U9NNcd5gVVDz07J5uIPjGrN6CatkC+xc
	YXVm+PN2tYxrUbbpVUzRSpU/xw2AhuZOZ27Av0WRGf/UjyfBJpt6QJUv0KdwPfl2XkCnNYi9GIb
	87U6DtvK0xrBIO9K7MWVmhWaJyAnLHUISVL9o/M0Aklh2ypPaHr2wSebEN5NTjGCxN52IS6lVcR
	P7mDDEct+TQHLyYZAtjC2viwSGrAnAp7dakj5liDkIbjR8KSn6cOiknqB5SwEyak1pakqqHHH4H
	cMAa+ZqHZpRMSu0MyImnZQcaCzxGBrREFsBJrLxFziz0WFz4GMMMWBz3nt6L4xXQThjNOzGIVFD
	nuF2s
X-Google-Smtp-Source: AGHT+IGz03kxWiSqV9ePHTaEbXPJFvgSx8RYWlEikxqBVx5QFRHF98Oz1fX+szduVQOs2J05BoLuWw==
X-Received: by 2002:a05:600c:1987:b0:43d:49eb:963f with SMTP id 5b1f17b1804b1-441bbf33b31mr92931135e9.24.1746435597433;
        Mon, 05 May 2025 01:59:57 -0700 (PDT)
Received: from [127.0.1.1] (adsl-186.37.6.163.tellas.gr. [37.6.163.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm170432475e9.35.2025.05.05.01.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:59:57 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 0/3] virtgpu: fix memory leak on device removal
Date: Mon, 05 May 2025 11:59:13 +0300
Message-Id: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOF9GGgC/x2MQQqAIBAAvyJ7biEND/aV6GC21UKYaUoQ/T2JO
 c1h5oFEkSlBLx6IVDjx4avIRoDbrF8Jea4OqlW6rWDheK0h45kpE7qdrM8Bi8SuM8oY7eykF6h
 5iLTw/a+H8X0/UBzqqWoAAAA=
X-Change-ID: 20250505-virtgpu-queue-cleanup-v1-3392995cab5f
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=sjhErN8ONkfCqIGOTbBvg7YELbUIF3vZ82Dti970nCg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9HSDRMNVJZZVc0VW84d0ZUemw5MXpVb3UwRGxLCk5JT21sQmpCc1p4aGJUdU01
 Z2VKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUJoK0N3QUt
 DUkIzS2Nkd2YzNEowSGkzRC85aHdCZ2NOR3RsNHJGVDFPa0NxMDlLRDc0aU1FYW5Ec0J0eUlaMQ
 p0OTVJK2hVVmFsL3UyZDYydTgwZUFObzRYMmdKb3V6enRPSjRtMUUyYW9JWWt5Mzl5cW82QTJqV
 XJKQXBCQ21WCm1ld1cwQ2NmNVpaS0VaYy9jUU8raFExalgxbC9xclA0MGRERDBWdWhHY2NEQkpl
 QkJ5QTRIZFlqS1RIZDUzYlMKVHBKZ256ZFFBWVlkT214U2J3em5RT0FhbEV0RmJqUk1SU01QZjB
 LWkJ2T09wTGprOEhUQktMQURRVTVqMW93dQpTYzlXRFU4dy9uS3hCTU90ZmdraElTUTc0emlKRW
 ZGdjRTd29BMVFsM0NaZ213TTRDdkg0dXZFZ25nQnIxakVFCm96WGVlRFZHcFdJaURCT1ZUdnRud
 zM2YUdPOTl4SUFrVmMwV1BFV3lKVk1QcUlCd0FXRWF3Vlh0SFVMY25jb0oKWUJ5YXVCUS9JdEd0
 R2hBNzhvcDFpZXNkRTZXajJHbUtYd3pRNjFNeG4rWTlOWHordE4wNE0xK3V3UmJ3bkFUUgo0RjF
 tRGF1MnRUa3ZCcld0NXR4L2VpMGtwRGJka3Z4bXllWVRMaWFHQm9CUEY1QmJQckxmbW00d3FVcl
 VqY0x3CnNnVGR5emZGRzBsYlhSS1RGcm9OUUZtWmVGNkJzemJJQmZtSWFGUndBNVNYTnVURXdze
 ExlakhsSFFia0dheWwKRjg5RHNabG5JZG1hNU1XTWNnNWJtMXR4dG05NGNyejhLbElERXorSXZG
 Y3JwK1UwVXYyK3ZramMvWlpXS1AwTwp5c2xVVWs5SG9DbWpVODJhd0s0NEdGaW00SEcxVTZON3J
 kcWtGZ2RtUS8zcGJtQmlUaVVuc0xMM1FCZWdvVS9RCjk2STlOZz09Cj04MU4vCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

When a VIRTIO GPU device is removed, it cleans up any command buffers
that the VIRTIO frontend has responded to. It however ignores commands
that have yet to be replied to, which still reside in the avail rings of
the virt queues. This leaks two type of objects:

- VIRTIO command buffers
- Fences

Furthermore, if the virtio config has num_capsets > 0, the capsets field
of the device is also leaked.

These memory leaks are reported by:

- /sys/kernel/debug/kmemleak
- slab debug options "BUG virtio-gpu-vbufs: Objects remaining in
  virtio-gpu-vbufs on __kmem_cache_shutdown()"
- drm:drm_mm_takedown "Memory manager not clean during takedown."

This patch series adds cleanup logic in virtio_gpu_deinit(), after
calling virtio_reset_device(), to free any such allocations.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Manos Pitsidianakis (3):
      virtgpu: add virtio_gpu_queue_cleanup()
      virtgpu: add virtio_gpu_fence_cleanup()
      virtgpu: deallocate capsets on device deinit

 drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_fence.c | 12 ++++++++
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  6 ++++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 55 ++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
---
base-commit: ad10b82c2bcac7f87ac6eaecfca33378b43425ee
change-id: 20250505-virtgpu-queue-cleanup-v1-3392995cab5f

--
γαῖα πυρί μιχθήτω

