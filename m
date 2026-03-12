Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530683B8BBD
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352722; cv=pass; b=AGbWP1Amz178JPYB7VmSYPK8ZeKlBXNsiaNQsyC9PgTzhxWDFgqvmL0p/weTTN9/mrJloLLJV+dPiHEDIQBj1yWonpqh/S/NaHzJTp8LoARbE7zCtx4A/bP08p8G9KnBnAs0pyQc9QTSm4DddLEBEihrwZTmFkBVQA4IY/iFEKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352722; c=relaxed/simple;
	bh=/UXbidtDU54/5v7kkzH9PAfgESqYtiigH9Z7woqu25w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=g5Ql/OJKlbVh4PXDYMs/RwVvDgtDK8lYclBCFNsX2PIV+KbbkComLq3DI2XUKKAbkJ45sGyBEbTl62kvpGb8KlJepDwIG35BbZQiGtIFICINlxa3TI0xoQ1X+e/6edZXI0ySzJS6sFDo7WjRzBH+oZOURQFetCKeL5PnysbIZyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShTG2viZ; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShTG2viZ"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-415b23dd6e5so584595fac.3
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 14:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773352719; cv=none;
        d=google.com; s=arc-20240605;
        b=FnHLVxJpOVPCpbIyRmraKmYKwGx3tFZnvMIr/JXV38tkAJqM5bJLwn4x+H0bzqf6+5
         6Nxnl90ZSG80CWLFe0YQFR/zYG+KQFGlUdN1ZeJTpN5a+0hKCdbuhnSBXkH8kI6pF3IH
         apT60ls8ptEe58MdDQWzhCGoI2X63B40TrjLCDrAzZ2gerZteWmomNSQuxQP3RFp+Usw
         Za7L4QO1IHFpnzOFBwbOaYRW4wWJfBzo8nSy5V5rlR//fnNFgzEfUtp7gfxPE1P1IMOy
         ed/AgA56o/At7zRBW6gpY9882qQuKNkJXTogFrRlb1QuRTCmJnjtD/Ln/gLCIY/2A1FG
         ODDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FqP84TGmgvyTgfJsFq+pkxpoA3lD0KYlwSD57EbzY8Y=;
        fh=wNQiHWOysDz7A/mtBhYaH6/0ku2xB2e1l/43WnipFm4=;
        b=gRtW+IK9+Eu+GUcQtiil6oLHJM6T3shUF/KGGJYHDf6KtoEHnwwTjfxc09auLOKrhe
         TbplnlAKQhM4QzDACLAlEN0I5bLRCd/HBq6cvy/Y892FbekT59EWp8j/QcGeFT2Leg/B
         LmwXmvIeJf9jFpSCp+WnYA4B8tlIHdQK7PZo1gMQx8/hTdtLevPpvIAfmbS1+msVp8/H
         1tO89JHH77tRi1Y1puNZ0BtOWP+GquUb310aaOyZ+VPfGQ4O3/8WukhuNjjjCk28Omm8
         uHFYjOQAb530tHho8Zu14Mi3bfDEzca1sozxfxfBh0iAyr9iyv7ZVfzyh/s71W4wsuHC
         Oelw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773352719; x=1773957519; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FqP84TGmgvyTgfJsFq+pkxpoA3lD0KYlwSD57EbzY8Y=;
        b=ShTG2viZdj57J1lvTmDlA7+/Isht/T9RHNra0uFmGzL8yaZczqtpgPaNUoJ7cWoG8h
         eodZ4nM0zbLWYP/aBLq2H0TaPwE9K7AGr61PxPUXq/LjfPeV8yHP0JSPG/755RbGQSn3
         6/R4vVmzg43r+AC85WOtjTSKJr7nSgyp+VHyBqhNZ+t2dkvyZ2lk/VBhib38+mF73y+6
         qEdNN6IHiLjaSJgsuCq+//llm9c6QV8682M2afC7eBVn5iVt0OEJKAt8/51gFQOYRJYw
         NARj5PMhJBHL3oWTgodvxn096T8Vt439zUpktdkH1UA+e5A1cWEcfOcIq6rIYbGz+Ynl
         Q9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773352719; x=1773957519;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqP84TGmgvyTgfJsFq+pkxpoA3lD0KYlwSD57EbzY8Y=;
        b=DPImewMZiv1aI5gletOOUWmx+5olOvOZ9b0xLZjmPZnf3X8EEKA+a9AK9/xVotAjfB
         krRY9/LWrP9nM5SjHZr4mxaIPElF4RY56Vp+Gw+ltdIe/3UJ8fRc0dtn1WXHxf3Tp7wX
         OxtcQa9wK0BQYjdM/Y97Xk03M6B7KdKnJNPIQ1aYEzGDUX3jAFFNyKqXBIhT80/OpnhC
         TMvj5ld0WP3tv1mcoS3uc9QB1DXxbB1DylYwcjYUpBiEfWnTy9KIbkW6GgTJaPrEseyx
         Eo6HbxK26m8c3dVddQba9QtGH3Rwo3ZojHbdMVgNh4ysRQbFUps9saffA8zB0/vCAHZZ
         4/lA==
X-Forwarded-Encrypted: i=1; AJvYcCVB3iklrZMePLBbHu/BGLlXxjoziQm3tQ8osyt0CKLUDcR+6kDGxu9ZGrqY0fz2/g5ff5q8vNQ0R4+pvS+ahg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuAwOy+7LJH4tY4R8CIGqx0QXdcp/kziQHCGtt/zrhb7tqO0rP
	QMaj+ABgCBnhrLWWygBRCs+Cw2OzrxtgixZz01eUim1xSXbjwmwF4uj2dTFgtPiyifRl2tg256R
	+kRPbkt5BReGv9bn4fDDZQI9DzjOydTw=
X-Gm-Gg: ATEYQzxG2aoVfbfIoDYIunyYYX41lZE+wNPGH6GQDiOo5J2Jhcv4ghc6iaK5frfcVxp
	oHbxeS8kMa7jpOsvZ1/FFtJZeB800RcNRRi31NLUELHZy0FILPFpjVK10/6ttzIBk6T6NjlxfcY
	t1aj1DQnYHzJKijKQYq7MjfO1TCoFCFS4l1/hQ/xBwh3/RbzS2nVy69KVnJc8A7+RxEYjxUjuQx
	IZ2/9nKjDLYzgW4C+jCVhtURCTjALV/dFg9fhLULWE6VTXiYAqZmlak8w7rLzbrQw3Y7D5AHYkS
	c8m40Op+W/yX7dLarZdyWPbKAbtISHKJ2J/eSHqw9G1jlqlVpb+pFDCHZ2ANfV+ksjd4IA==
X-Received: by 2002:a05:6871:582b:b0:417:5cf7:48f6 with SMTP id
 586e51a60fabf-417b9059c22mr617649fac.3.1773352719154; Thu, 12 Mar 2026
 14:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: John S <xaum.io@gmail.com>
Date: Thu, 12 Mar 2026 22:58:26 +0100
X-Gm-Features: AaiRm53jG2HdeSoWg3E3eUPDX7LBFweqaGa9oOaMogvds1ztn67HqyTh2Ab3FCg
Message-ID: <CAAZVx999y-DvB7Dp2ekoHk6s8aqqScd2gKSY4ySGAK6NNXeH5g@mail.gmail.com>
Subject: [PATCH] virtio: document the map API in the driver writing guide
To: mst@redhat.com, jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, virtualization@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

diff --git a/Documentation/driver-api/virtio/writing_virtio_drivers.rst
b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
index e5de6f5d061a..a3fcbf91ffe0 100644
--- a/Documentation/driver-api/virtio/writing_virtio_drivers.rst
+++ b/Documentation/driver-api/virtio/writing_virtio_drivers.rst
@@ -187,6 +187,78 @@ certain scenarios. The way to disable callbacks
reliably is to reset the
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
