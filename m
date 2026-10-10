Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97136C5BF
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619873; cv=none; b=mEWSp3fvdii6QWzNSkPC4C4fr3dlXjA+04pFK/2H1xIZm7qz9Putdl5e0vhrUxJlsyyDa3RxbaRneaRL063l4gz6xehrg9kf1gv7Ur2HrD4FOfbhJFgXii0Unx0qAoU71688hZpHOZyXfAbhA8aBGZW3zfyedZakFM276VInML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619873; c=relaxed/simple;
	bh=2VHfLRIfl//L6nxU1RLK9B1KHUYa2JWZ2ZmYu7rexyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQu+JZtFd6eis+jjJPW6V2dm0++D1PJdpg1vFrpW17p7sW+Q/AbqdJqhZNriJcuYaTdP5PC6BvZBZb3ybMsHruYh8maxiX/szxkJbRZaT67oprMyXr+1/UBPNLWrujE/jIQFj1s11OMvNjwZyYSh8RsbPj36r0tVycCeqmiL77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O18pzLVU; arc=none smtp.client-ip=74.125.231.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O18pzLVU"
Received: by mail-oa2-f8.google.com with SMTP id 586e51a60fabf-48f1c6a7779so281669fac.0
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791619870; x=1792224670; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2ha4Gusp7rfS5qI3QalwE3wIPhVWRGc9MjXkvhjipc=;
        b=O18pzLVU9VUfcyUyXEFFv+aLAHtLHXsd7/1HDeaw5iS9WB1L+T+TVhU2haZpbT0rYJ
         plc5XdXOw85KlzGmry5DsV2Hk4ZumB17wu2tbuSW3HcbPMxtDYp2bFX7PvqpZUENGFNi
         I8+MdIjCFqYfidJ1aixGuKLycs4TCRmpQ4Mtk3/UZmpaBAbdx6rGGcqyPrnXQAS6lono
         ZJantZiDU2sNd1ohZqwAiBVFrVMaar6nWad8JFJHK4n1NUW2I+044ROz8x1GW+4YYD6y
         aa35mw40GTwYBLz+uWHy9k5QcVFsdCv5KfAfk5xLYSVO0OFTSTjq8lhrrzzrn/TfrIij
         6t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791619870; x=1792224670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2ha4Gusp7rfS5qI3QalwE3wIPhVWRGc9MjXkvhjipc=;
        b=Ae14UcoRfbacJlFHN1fg/GbEyKcyAdYOcD+ukrMs1rD2+l1h47HXeehbkptsq8wazP
         k79N+yZJBe7XBUZTWYBDPEG3wl9w8CoRb+mLBeRyie6nqw4peKPgSnBAgPIhh1hCJSUh
         qvOMeCuiG01jzYxQFNEGvD9XtnXTp4nfmVgNLhyfFDmKZllP+Yf9RUramtoCkMEW2Uhd
         TtBeeh10d+K7Cn+iALPnz5oxC7a03u24Gb8Uv75VzcRnvrP1y7+QZgzMh63pwzUtvoCz
         mD195F22w+1PMLho1javTLRu6SF1503GOGPWl4ar7lyJCc7gieJvrSN3ZngmoGtE1VmQ
         yElw==
X-Forwarded-Encrypted: i=1; AKwUvBygeSiZXEAFmoplk0GtgN8G75vsiQhniJlKrIi20Jbqk2x2cQtIg/CdBRZSvsGMwHhhC3bmJjqc49mNN4T8BA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIGQO+XfE1oGynOXB2KPlT/2kv/S1Go7PUeAa+DN9g6wjI20F32
	fqsexgisf5G93MR9edmDgVd5w64l2O0P0CrA70xlSqPnbb0uNpW569DL
X-Gm-Gg: AYBFou1Ra6dArgJ2+pzkFw1sd0GDN8it2njstnYTEgH5s7MY3DRXFieNQx4J+MZ+aQb
	aVBnjdYb41xRA+A+d5qe0GInK+9HtH0C0GnzRAuCcAnzwVjogstnV7KMOnL1pYIUqTggGmhmAd8
	UNaz2MFZ/i7ZWuOhad+bVF9fbloAXb9DyepI4zorUFdmFyljPDs4MCaRHhxwk3jgNcbHpBhSqQZ
	DyQPqogfhwME6G/QY5UkoxE6ctrAOzWu7zx/qeo6yrPERMLxBRkkMf8UkmWIYhPm7fATdg2nuCB
	7IGP7yGiVZgc+FlUYbSovB30x1SzTW4F3mgH8cfNywwBpeHG0VlNVyEwb+wdeGpPqnt1Q/9/Wqa
	B2Ztf3csV1loNBOVlaQiCCqccpi8rd3iDJEcKRp+mmFmfPKzyImNV94fur1svPz13K5HOTh7M7l
	NzwQ1AsmN3xPRSfl+jUfrHWDmGsGYJtmTTL9Kg50ik+7/wpM6plUnGd3IXtrzYjlJvORiyH1L+8
	tTgld47Krx1OAS4694RfMrocJvi+D8xCU4kPQ/11RKFwCa6
X-Received: by 2002:a05:6808:f8c:b0:4c1:f40e:b697 with SMTP id 5614622812f47-50c56bf8ed8mr3581941b6e.38.1791619870362;
        Sat, 10 Oct 2026 01:11:10 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.38])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c16755587sm4665356b6e.5.2026.10.10.01.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:11:08 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Junrui Luo <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/virtio: reject mappable HOST3D blobs without host-visible memory
Date: Sat, 10 Oct 2026 16:10:59 +0800
Message-ID: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
blob flags, memory type, context and alignment, but never checks
VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.

For blob_mem == VIRTGPU_BLOB_MEM_HOST3D the blob is created via
virtio_gpu_vram_create(), and on a device without host-visible
memory (plain virtio-gpu-pci,blob=on with no hostmem) the failure
comes too late: the GEM object has been allocated, a host resource
id taken and the create_blob command issued when
virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
virtio_gpu_vram_free(), which is a no-op while bo->created is still
false (the host response has not been processed yet).  Every such
blob creation permanently leaks the vram object and its resource
id; /dev/dri/renderD* is reachable by unprivileged users.

Guest-backed blobs (VIRTGPU_BLOB_MEM_GUEST and
VIRTGPU_BLOB_MEM_HOST3D_GUEST) mmap through the shmem path and do
not need host-visible memory, so only the HOST3D case is rejected.

Commit 036d28db1818a ("drm/virtio: release the GEM object on
virtio_gpu_vram_create() errors") fixed the sibling error paths but
missed this one.  Reject the impossible combination at ioctl entry,
making the failure mode unreachable.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vram object")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 81e70a12b3569..e3edade4a62dd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -533,6 +533,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 			return -EINVAL;
 	}
 
+	if ((rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) &&
+	    rc_blob->blob_mem == VIRTGPU_BLOB_MEM_HOST3D &&
+	    !vgdev->has_host_visible)
+		return -EINVAL;
+
 	params->blob_mem = rc_blob->blob_mem;
 	params->size = rc_blob->size;
 	params->blob = true;
-- 
2.43.7
