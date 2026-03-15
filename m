Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30936F41D
	for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773586705; cv=none; b=fLgo2qGY3mtEWMfKzHE/SuALtiDNaz2x+QhJtd6gHm8fopmZq1mFeeNW43pE8eovWfvpLhd7/xXAjpA4qDAg7GrbHhArx/X7grDjzuXFghY4PIQl+dSxl12JfP6Pbjf0DMYMw42JxpSloCSR+7eJ8CBgr871CnFEFe8WfvNC7xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773586705; c=relaxed/simple;
	bh=6e81gTOFwcms8WF8rZ3PvV1TV21hTOBkP19QN0vMPcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pa1HybLLfuyP8KncNnjKekb7jz16PuRFHHxOGPxogn90EDHKfx0ruliCldmSJImWkv/1RpBI7u2h6EWpF9NIgYGsmVuztNds/0XYTGS7cuZlyd1WB5wWCQLwWf1EESQaOve9zcG7RMYbxpFlr6EP2Bz1ESlByD7Nj7Lo2RhVzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBK0JmX5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBK0JmX5"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-485409ab264so25754475e9.1
        for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773586703; x=1774191503; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sFIIHFtnDsPo18Tm8giyRmkIEx54O4WiipHf2L7azg=;
        b=SBK0JmX5tfb2TLLBQb3TItK8faEubIrPsOoJLs7IZBqHemVgRR1HGeYklYuizhqCAF
         /fwLyXHa1NQlO6z3hqWa4GX7aFlxSqFnqZvZjcrYATz/Tc53MGGmE6Sr0vZ2FNEBk/yD
         xOkt0DO40u7PRAQUL7CiOF1Km9BYz7L5HP5kvm4I8rh0rW+xSnI060Kn/R5E4tkL/UXm
         ZNwym6uV8yu30T9GdAblCTJAl8CrrBPXBGiXOfSEi0SRvQG+4COKexWUPElS7dAyL6gx
         eQZk7+iP0hcA82rE4QA83mA+DyZVp1iqg3NIfFbPIrmStAVLPv1ZVrn/y2ZgeMbuzP8e
         aE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773586703; x=1774191503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sFIIHFtnDsPo18Tm8giyRmkIEx54O4WiipHf2L7azg=;
        b=mYVp/jZj8LVtOWW7mXVtJGPZq703dnshDiZS3jfjGht8RMzees0uPR/fHe4mpF37mt
         CgeKfszgI3AzVoa48iaQ53C9xH/JOY9VfQt+xsxsuAj12NN7em+bwe73O91/2gP6BJi1
         J6m6+OkazjkE7QOae14gwJS6VnnewLfAhTz/b7yjN4McftyJqilrTrARmCRsFjF/n8L6
         oWodzl6PjXQPalaioK3Z6JzWxEH7dDPQHW6kaKA9zGM2/n46oRiXUhW9pCFdcPt2nILk
         PrZxGDs64YsHgFra4ZZMCm7b1DcdMWf9TwG0p4hoqcWruwuD28NoBK59IX98BSLdGDl2
         fmMA==
X-Forwarded-Encrypted: i=1; AJvYcCVxQFhvw0F1WY4EdGOKiXWSri0OBdifmwNnNk6FPzewTu8BvBnw07mGUgZDLzIy50B5TIFMfMk1sKMw/bWL2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsdf7R1lXx9lMAF3X+82N7Jm/i51EF8da44L2XuyRMGrk7KEps
	JxBLhX2X4bLueM0fmZnQILEkNYJJ+Sjw7Pqta0abNphSOli4j9/W9mQj
X-Gm-Gg: ATEYQzxEXafsZExdSPxBYnVnIPOlbOlEglIwNh59N21MoN1cGZZJ6+/EEWa2jWXjbZT
	Oo17uEn2fhM7+EyMRYcUFny4MI3ZvuN/f4JrQc2NfNDiS985/ygpZJt9sYWx7T4pFz5PS+JB7Gh
	kVsH7El1qH7Q0HXrvuPRul/vIlYbZEBIdIK7S1uo36fo2PF2jNOMziHmPcNbQ0FLLKOKy81Q0fD
	KXfDyK9bfD1lG4oAIcxBuhbeZ66J5YlMiIRFx7cmkw2u5MTfaWW0tISW7fnxu/fXuo4G3Cr1Yg6
	JdY9DrL+UTFf0oygSo218U1rZph7Z5vwLSg3Wu35SF05OG4JfF/PJ2yEm+7pMcYeTdMBCasJgUV
	wxRGbSfJqgkBfU9FmTSnNZcEkX34xDECyh7XbXyoOLZnItY01Rh8wSqqTit1Llq0tRvgRE0qMEo
	26ThSXTTp5cfFMMH+paY9APl0sLhBHTLBybkPsAiuWaYue3Pp8E3kK3gER4516M3/Z2c7FLlK3N
	btf59gcpOwvSNh7VCO+BiwKoeBj6A==
X-Received: by 2002:a05:600c:4fd5:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-48555b2c8fbmr163883565e9.11.1773586702402;
        Sun, 15 Mar 2026 07:58:22 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm348661125e9.3.2026.03.15.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:58:21 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	virtualization@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>
Subject: [PATCH 5/5] virtio: document the map API in the driver writing guide
Date: Sun, 15 Mar 2026 15:58:12 +0100
Message-ID: <20260315145812.24276-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new "Buffer mapping" section to the virtio driver writing guide
documenting the virtio map API (struct virtio_map_ops). This API was
introduced in commit bee8c7c24b73 ("virtio: introduce map ops in virtio
core") to allow transports and devices that do not perform DMA (such
as VDUSE) to provide their own buffer mapping logic instead of abusing
the DMA API.

The new section explains when and why custom map ops are used, documents
the virtio_map_ops structure and the union virtio_map token, and
references the driver-facing mapping helpers with their kernel-doc.

Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 .../virtio/writing_virtio_drivers.rst         | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/driver-api/virtio/writing_virtio_drivers.rst b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
index e5de6f5d061a..a3fcbf91ffe0 100644
--- a/Documentation/driver-api/virtio/writing_virtio_drivers.rst
+++ b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
@@ -187,6 +187,78 @@ certain scenarios. The way to disable callbacks reliably is to reset the
 device or the virtqueue (virtio_reset_device()).
 
 
+Buffer mapping
+==============
+
+Virtio devices need to map buffers so they can be accessed by the device.
+Historically, virtio relied exclusively on the kernel DMA API for this,
+which works well for hardware devices that perform real DMA. However, some
+virtio backends (such as VDUSE, a user-space vDPA device) do not perform
+DMA at all and previously had to abuse the DMA API with custom
+``dma_ops`` to make things work.
+
+The virtio map API, introduced via ``struct virtio_map_ops``, solves
+this by allowing transports and devices to provide their own mapping
+logic. When a device supplies custom map ops, those are used instead of
+the DMA API. When no custom ops are provided, the standard DMA API path
+is used as before, so existing drivers require no changes.
+
+Map operations
+--------------
+
+A transport or device that needs custom mapping implements
+``struct virtio_map_ops`` and assigns it to the ``map`` field of
+``struct virtio_device``. The ``vmap`` field carries opaque mapping
+metadata (a ``union virtio_map``) that is passed through to every map
+operation:
+
+.. kernel-doc:: include/linux/virtio_config.h
+    :identifiers: struct virtio_map_ops
+
+The ``union virtio_map`` holds the mapping token -- for DMA-capable
+devices this is a ``struct device *`` pointer, while for devices like
+VDUSE it can be a pointer to their own mapping context (e.g. an IOVA
+domain):
+
+.. kernel-doc:: include/linux/virtio.h
+    :identifiers: union virtio_map
+
+Driver-facing helpers
+---------------------
+
+Most virtio drivers do not need to call the map API directly -- the
+virtqueue helpers (``virtqueue_add_inbuf()``, ``virtqueue_add_outbuf()``,
+etc.) handle mapping internally. However, drivers that perform their own
+pre-mapping or need coherent allocations can use the following helpers:
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_map_single_attrs
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_unmap_single_attrs
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_map_page_attrs
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_unmap_page_attrs
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_map_alloc_coherent
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_map_free_coherent
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_map_mapping_error
+
+.. kernel-doc:: drivers/virtio/virtio_ring.c
+    :identifiers: virtqueue_map_need_sync
+
+After mapping a buffer, always check the returned address with
+``virtqueue_map_mapping_error()`` before using it.
+
+
 References
 ==========
 
-- 
2.53.0

