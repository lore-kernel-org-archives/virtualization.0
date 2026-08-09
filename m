Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5791A6830
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786235204; cv=none; b=C9z7u0YYijS6qwMhv0ilZzJE51wI3kTXgydcJYW3BlR2XuNYWjNUHhZ4vhlcmlPXaV1H0WOgopmOrht1o0fuv6rBfCcbZbIX/CzQLSSVVvjavAso0ODn6UFQOxfQoGk7SRdnP8qiKL00Ba2erAmcjdOTJJ5AimC6z/t23+ZssSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786235204; c=relaxed/simple;
	bh=cD6iwbu7Yz4gJgFpHxHHjHRe6DiqimV0yMAD6yEPlqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXW11mObp+mc6NvMWm7/I43vjgFmhbCfD/+PS211Y2TDpJfWi2o+23sDFcQ2YRftZgaTXxwZSj4UQsZl1+MwZxbxh1a4pJRkxzgSn/oOable7ZIci3hY3BXhRLhTDa1Ic6qKcasgpOY90w9EcRpH2kUTnbqdcQzmt/QwroUm5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2a7VvQQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2a7VvQQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc97653887so7913725ad.1
        for <virtualization@lists.linux.dev>; Sat, 08 Aug 2026 17:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786235202; x=1786840002; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EgyjptlT6DdPuhzR18wm1dZCjjUWW4FZP2FThtl49rY=;
        b=j2a7VvQQt0fTkP0kcgRKajb3ENOslffbZnv9y9O0gbnTdRl0BpZRr1/GtWXTb8UVPt
         U/uurr6zMjQXTXMMjnoB+thKI5MlvczCd9aVHK7JKB/sjtiIBYMok0LhUagFAq1IcfdX
         vqX98LDAg+vDHGIO87Yi+iGIqgMKCTPwboPk2/5+nzoJwRbmitjhcMs+uHDvqC/Mvxij
         pZ1zLv+JeKVdJf0t86c1seUbtoGBXM/LZvCk1LZrMqr8d9oEfLUjpBOxNjzfUw5fS7lX
         GeJbGF5hVXK4JLrtV/SJWDWnQKSDlLpTf/odLzdZfaOVLRSnfzUnub1uFBUFG7rvtxJ9
         wDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786235202; x=1786840002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EgyjptlT6DdPuhzR18wm1dZCjjUWW4FZP2FThtl49rY=;
        b=KHtFocNm6Mt7dhZV60OyxobV1wSn7cshlf2mbqnHYFybZjNWFPamDB4dxmb66VqWrx
         nZSDJ62EvFxtJwjaLfzs5v7y5nEnSmlmYlRv7Z1+6UPNg4KQ5szmuon0x5EjCbSYgol7
         /7D1vfeHxDKi6J+YQuZhTIqkDnCIV8/hCQlTOIh3GlYlFTBPWES8nWhotqEP50ChOPWm
         KofV9ca9R7tsx7uMiXTA/MYl5w83tAFCNNKsJESR9bnjIPkTW1faCiJNepSFr4NwuUd9
         RfP6x9iczmJBVEthTCwwDbQ4C/wAnKRhKkNxNn6W1Y9qJRFRPY9nv1opecPi46ZLWysI
         0aEg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2+iLajbDuW++9r89/JTGnJdBWKmno8ucmsuelS27JvVCEk59qBQZDeIvLZ7hOEyVWKRwc5FVf1aWajyYndg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzaH0/YUv27K5VWRZE68+CX93ruhBy3H8uIkGlE32pMsFhX7I0
	vSDMaCCOqWuTRvczaAX1CXMgFvr+g6cJ1HRpkvAwfiO/DeUChlTZ+Jaz
X-Gm-Gg: AR+sD13kAZ6wVDAOTsH0d/DV707PLLCc7A8I2/us8NR4Qrshl2MFeZ9ltpJfu9QaIOx
	awa9q8LrU23AI6i4A8ObTGTUwfYUUUQmcywWXjRho1ij71JT054xVkZLAUmGcq3QlvxUR11Tcik
	D32A5nfiFPUM4/Ceh68O0Ojcmu6aB3OULPZbZId5jRUiQwCgo188ovBWYzlVfj7BtnodohoFMQT
	IEqKlwsafdct74mK6f2ctKgv8tVXFGspzQFRAB/EaxrbxHEJIzkOGno2mgZWr9Z3pMmcXcZ+xDa
	K6vVf32s3NOHmpU/RWhSHJeh+CFexRXcinAwt+bIwUYOaDuWpsKhYj8tCoNnR0086VcQfxQoIWr
	7M2q63C0oB1PQg3PUnDFwX9oC9GTYFTpoLIS/tzv3i0W8Rd0R/9XyNtAvVltDhIFl7IY3KlHkn8
	PdpcQfpeydm7iGoX0OvLrPVVQWCnpT0FNQNq6RH16R3SF+CJX6Fvj0cTBuULXs7Jw=
X-Received: by 2002:a17:90b:1843:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3903c53639amr35887499a91.8.1786235202259;
        Sat, 08 Aug 2026 17:26:42 -0700 (PDT)
Received: from beelink.. ([186.22.57.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb8844fsm25270201eec.16.2026.08.08.17.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 17:26:41 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2] drm/qxl: fix 32-bit overflow in the ALLOC_SURF size computation
Date: Sat,  8 Aug 2026 21:26:21 -0300
Message-ID: <20260809002621.122832-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qxl_alloc_surf_ioctl() works out the backing size of a surface with

	actual_stride = param->stride < 0 ? -param->stride : param->stride;
	size = actual_stride * param->height + actual_stride;

where size and actual_stride are int and param->height is __u32.  Every
operand comes straight from userspace through DRM_IOCTL_QXL_ALLOC_SURF,
which is DRM_AUTH, and the expression is evaluated modulo 2^32 with no
overflow check.

The wrapped value is what reaches qxl_bo_create(), which only rounds it
up to a page.  The original width, height and stride are kept verbatim
in bo->surf and are later handed to the device by qxl_hw_surface_alloc()
together with the address of that undersized allocation, so the driver
tells the host about a surface far larger than the memory backing it.

For example stride=4096, height=1048576 gives
4096 * (1048576 + 1) = 0x1_0000_1000, which truncates to 4096: a
one-page buffer object described to the device as a 4 GiB surface.
Measured on 6.12.101 by probing mmap() lengths against the resulting
GEM object, the backing is 4096 bytes while the surface declared to the
device is 4294967296 bytes.

Two smaller problems are fixed at the same time.  Negating param->stride
is undefined for INT_MIN, and unlike QXL_ALLOC there is no rejection of
a zero-sized request.

Compute the size in u64, which cannot wrap for the u32 inputs, reject
INT_MIN and zero dimensions, and bound the result so it still fits the
int parameter of qxl_gem_object_create().

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: compute the size in u64 instead of size_t, so the (height + 1)
    addition cannot wrap on 32-bit either (reported by Sashiko AI review);
    the v1 <linux/overflow.h> include is no longer needed.

 drivers/gpu/drm/qxl/qxl_ioctl.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index cd1901d5c7c0..75abfc1db0f5 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -385,12 +385,24 @@ int qxl_alloc_surf_ioctl(struct drm_device *dev, void *data, struct drm_file *fi
 	struct drm_qxl_alloc_surf *param = data;
 	int handle;
 	int ret;
-	int size, actual_stride;
+	int actual_stride;
+	u64 size;
 	struct qxl_surface surf;
 
 	/* work out size allocate bo with handle */
+	if (param->stride == INT_MIN)
+		return -EINVAL;
 	actual_stride = param->stride < 0 ? -param->stride : param->stride;
-	size = actual_stride * param->height + actual_stride;
+	if (!actual_stride || !param->width || !param->height)
+		return -EINVAL;
+	/*
+	 * size = actual_stride * (height + 1), computed in u64 so it cannot
+	 * wrap on any architecture, then bounded so it still fits the int
+	 * parameter of qxl_gem_object_create().
+	 */
+	size = (u64)actual_stride * ((u64)param->height + 1);
+	if (size > INT_MAX)
+		return -EINVAL;
 
 	surf.format = param->format;
 	surf.width = param->width;
-- 
2.43.0

