Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A763E3DA7
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052798; cv=none; b=WuS43R9tc2hUiJjlXFH/z01DEKjbIcy9dYUqphwJ1GRA54cMD88BOsxCVT1seRC9g8vNUywDg68FQnxDgTbRLJmPoVO7Z1nR+V5iwT6V6eIn3RrhA7FaO19iH0BPNLjETP5DNC0yCVADNlmP5WBXxXkTPwL5/1PASI1G1bF9tI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052798; c=relaxed/simple;
	bh=4D1vUM88O6c8JHx4tYs9LNhi9yvrNGvDHgy4bVWWi4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpzIJz9BwFJseRUP0P5w/caM+3dqa9P5ewPF9TXR9jPVSTEWI05HAQrVGkOdmtfFdHXJXlfzcnKfFd9Thu2j1ywnyKr2njSfYnA0rBMPGA9wzWouEl5beyCsRr6KlgiXxih9TXuBpvwSS97Jph8YFTWKGg32aYsA4LViBBJI+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjx9+7fj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjx9+7fj"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c96c92c0980so2641095a12.3
        for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787052796; x=1787657596; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ErnJauar7zJkf51R9QKk9qiVc4qZQuim79mLl/qt+gE=;
        b=kjx9+7fjwPAqraVv376kyzYpijZlK9qpgk5xrq4BhK+sq6/KVVSozoqTy/awJOI7Gg
         DYVZXdPWNexdkQr7/DLZJ1lCUBocbvXHXyt5jUV4aRzaPf8RQuf7/APAbZyVCH/JgZD6
         /PjOopzq5xEjDdTHB7ixnxXH/wjxbHKcSM9pWOeFKDTllqKgAyn5JvuWX27QMZhYQa3+
         jEekS5MSOAkaE2Og6YrjfPl2egz2eBgN0RKR4xpdY3EdPjli/hiBpAulp2oRMtDfV9Vg
         TnxdaDucCEd+AoCeGlN3oRdWmUcw8qywWBGiPoEL+qivWlfaosqjpxs1hkOb1wo9IB9D
         jssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052796; x=1787657596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ErnJauar7zJkf51R9QKk9qiVc4qZQuim79mLl/qt+gE=;
        b=bOMZVKVkyyvnM6hr0e01gbSH44+EE10HGydPlTAQr9qb2HrEZYYi4o/CGy7fUGMam4
         NXEy5IJ6jJt/ZZv7HF0g5KMYo4DH2AydkWJeCneXONlTgxUO9HTFpIxbmzCbm41z4DLq
         K10Uz7noLnAp4+eYhwWrnKnGFzPQVoD3fJpqb4c4HroyVRZL1wHcxi8kQKyNUy+/XIwm
         GrSUJBcF8jh8xMlDsoA/9Tb0oOUXvoVB3ItbfqsGBEYBhO0Z/Q8vxj/nL1Q7pr/45uaB
         NABDJbiDkLJw42VbPmM9M4JXswl/zpLypJpcuz0CgAooEgGdUMSs47l9TccyeFm0g5wR
         tXAw==
X-Gm-Message-State: AOJu0YzPKJR12tzbTKyCYuOadoRyaremN9ywO9uU8BWAfztPijHlSw/w
	cPpu8c3T9AWLm5pfWSOHOhliiPMGXOAkct6TgM1xDb/gT+cVkafkBjg=
X-Gm-Gg: AR+sD108GPjTiof9uo6vPg2L+U7ANXrJDiNQT/oZuRax5QHshn/1ScYUeRoXzHSZqGh
	xEp2kMqFz7Bu89q2k0Q/NgnIwBNPYh9b8AdZCraVVE5LPFkQh1zrTGawUj6iHFG0iCaJ07JphYx
	WzIsbmr5Ib/bfSbv7QTVr9TbeM6Xk40yzkb5pfcrXJAjYjZqc1ikQXsAIqv4rbUvHMBok+g88EA
	8niHDD56Om1fSnv9zwb3/OV4F21csMa6DDwmup6xWMNADXP7rH53ftrP/GhgZW1q7kY8pLYMZkB
	EwHPAunKe7tsklGy0bq00gEGkuKdJa3z+ntwWfoUVEPFxoNLbxNDJuGdWZC/0f+Nu4kaZIgdZDa
	lX94gAAWSMsq06XWn5hAxUYCVr6qcN8Q6HxGKoWox/s+HtqUbBmqcQihlyD0pKFwv1iAUy6n1VH
	rqYeruMfI1OKpmpi8AoHnedXiqBgpH+Lt3wsRmupe9NspcTtVErM0o6BgQIE8Fl3uQSPhN14uBx
	ch1yNt03jWHdUPMdcrmvFcvm1DrO8t//+7N1c2/0Wci+cYa+31QvJQkwJdEUoZcNSNQ
X-Received: by 2002:a05:6a20:72a7:b0:3cc:4f34:3733 with SMTP id adf61e73a8af0-3cc71a6804bmr34073028637.10.1787052796166;
        Tue, 18 Aug 2026 04:33:16 -0700 (PDT)
Received: from codespaces-2db70c.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net ([23.97.62.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c00dbc2sm2036427a12.15.2026.08.18.04.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:33:15 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/virtio: Fix possible memory allocation failure
Date: Tue, 18 Aug 2026 11:32:56 +0000
Message-ID: <20260818113256.27848-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kmem_cache_zalloc in virtio_gpu_get_vbuf fails, it will return
an error code. But none of its callers checks this error code, and
a core dump will take place.

Add __GFP_NOFAIL flag when calling kmem_cache_zalloc to make sure
it won't fail

Fixes: 6f3d9d0dd335 ("drm/virtio: Add drm_panic support")
Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e5e1af8b8e8a..fdf0f3c2d3b7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -93,7 +93,7 @@ virtio_gpu_panic_get_vbuf(struct virtio_gpu_device *vgdev, int size)
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC);
+	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC | __GFP_NOFAIL);
 
 	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
 	vbuf->size = size;
-- 
2.53.0

