Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226307;
	b=hKw4ups1ByEabr3HVQKxdUtmz1hBocype3t/8HKVGCPve03VdoHih6lTdtsccQNNViqh
	 h2Ydsn6xmlNOrlLo3EorVYfbcmAqyTrYbg1dsC2ilC4YzNEPW7BaEGKpD6zfz85/Psxtf
	 B3SVdIv9+0GZ/nZ7Mp3DoQ32EQ6OiGPMEEwzdTji3RTSN3FyflnCfgGBSP6CNeK4H0zVd
	 WAdgywXRJpXPdBCQg23vSMPO+0OJTzB7JWmz4B7tLV8Q7AWVlWpu0uDQZGn0PMf5MH6NU
	 M4Db0Pxiq+tugOIco138n6N+xYPI/OIHIVmYJ6S9wRb8/fWoRCGoD58eD7zMg8g357A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aAFBHqSFELXCigxcRHp1sfmuof9NM3vLwNWTQKlbcIc=;
	b=D5ZWrk6XIO2p1hMGRXxuw8pcnIVgmC4qALnvZ5AEOWpIBSd0f457DgkoJYUAjh32hH5b
	 7B0MMC8XDENh5mQDQYdgq2PviXb7iky+a1kYvkf0nARBoQEMmUo279TCiAFBhFperNUog
	 ayRUJ2pHH2V9ccS2nVgBqNV9awS0F5lILKEbbaeEG75MCuSt5lse19+HuGtwJZECkD4Ur
	 LjWs/4FoxfIyoMeMvTTUhGKzGLeG0LvmDkcuIhDwEdBQ0uiNedXqkbtkcYTvUeQlI2IAG
	 gmwMrAe3JWA1AFGUkky0Djs1OFA8lkvEoLPblk+RRxuV+9UcDX85uVTBO5r1M6V278w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHH8ppaM;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6872606A31C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 22:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6872606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHH8ppaM
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e515769d3so123819985a.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793226306; x=1793831106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAFBHqSFELXCigxcRHp1sfmuof9NM3vLwNWTQKlbcIc=;
        b=SHH8ppaMijPtVPEabvpoHiWVKJpH7Y6LVd9UokBw5SVz/l/baydjP22/HdSGv5cOBW
         awyCnryeClgF7gE5BiJv25ai8nKrQoixIW7noPGisA4nvCO8DRnwK5yGXGv2bo17qwNh
         pC7mFx4cVulpVix4P2B2pQZRP6UeEkPtY08S62OZSuSqih3B4dvNAGGpZn0V80vcC0U8
         38toC4ioMvYCJoPzolsr8Iha0+kv0snT8c4mY2ybH2R8o1vdOwi03Q+ozyQvilCZYxld
         XcWVI/Uaiup9CAypnB4D8Vt7gcMdvFFzoweSEb3IJKTwLZdKG23+wFiOtNu1l7/ajdLY
         p7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793226306; x=1793831106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAFBHqSFELXCigxcRHp1sfmuof9NM3vLwNWTQKlbcIc=;
        b=1iJ0FMWQYClfuHjEMYpt4H9f5ZoEp33s/raTdTiFvX25GesScijxKI/BxpE28jXQPD
         mLsW5uen/MhJGpBdbMqetww2br8JSnXueowl8IoxqUXhTFBwgeBAi75PPZRmKAondyNM
         yQ0Aq5JZNcDqy04FPU9DWYI/0ZES0aFn5w0VMk0EsQN0o49eMzT2S59yyGYLqzB+fbds
         lWKTsu20d3Jq8QneicPMlEg/IoR/a+lYbxTVEvajSWRE+q1iBBZKWOWwjpFjuFPTsZFQ
         WNf5csOhYK//MmGN1ERix1l/zJEsQZ19OlknLeVcAha/RPwYSUbUSouTkeb5wZlCK29A
         lLbA==
X-Forwarded-Encrypted: i=1; AKwUvBwLW5mzhQUGY2cLoKZwKHUrwcDIW5LDxobVCqZO60sbtLCiaxPlXWwdHrJA7rNMLkHoIlNdecHasu5m4QKAZA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLnz3+120mBhs0WyWA/7bU/KHOV3+ijdlO5pyiSkZ0AxwwsWX8f
	GReOxBPH9SUSAxHIk2UpmBDiSx3DkTHaNA01yaYp2feH0WdqarSoEVZV
X-Gm-Gg: AYBFou1tBRnTtC3CfJ1YAPwdm26NmIy0W24ckLwpu6diOpxNyB4webNTwS3nGuyviso
	xAKa0F11lat2ho1FtYZhZyq3zaKOKpvkyaq+LPqdgTiC4CysMdUvzJV18h/EUKRF2qQlgVDpWLF
	X589YOQUS2Ovpr/uu2/xJtEwwNYdRU3qehlnE6xF+DmwVHxRt2D6lnIcvPxgxdZ7Cwvj1QhNICV
	ucecLRr3EQghr/qvchCtbOzAFpy9tnIyxF7eW9M7+QVNMJ9CyjCDX1H+JjiSPZp4HSV46Fxf/Mq
	HJt1veTCgwmmPPde/sPUfueUk6efOnUyHXXHareSJyKbR0l7Yjf0Ut0EovV1u9oYzbfceKZTPmN
	+gBwPGYUob8+bKaetS4HUroABv4flnZROU6zpCTCSUeNAC7ENwdQO9mQie1Jjk8Z3ALFIOE8g0X
	n/ykGzpoEYTqQFKlDaenIlSvZIIT/ozS1FFmXcE3kGjw569r8doBslVbEMKMCHfWF9MXSwr+xdZ
	RdtHHGHk5hyeh87vzEuddu5j6lf21hSTokNn5pyr0v4ZZCU2G3dcQIBNqFtFAVoVP+yks3LmUTP
	Fi00SVFAjf6g0fB5Bw==
X-Received: by 2002:a05:620a:17ab:b0:93a:f9:614a with SMTP id af79cd13be357-94408c91a29mr596917085a.34.1793226305765;
        Wed, 28 Oct 2026 15:25:05 -0700 (PDT)
Received: from linux.. ([8.34.174.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd2110sm142981306d6.13.2026.10.28.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:25:05 -0700 (PDT)
From: Changyul Lee <lcy8047@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	David Airlie <airlied@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/virtio: Propagate errors from deferred blob mapping
Date: Wed, 28 Oct 2026 18:25:00 -0400
Message-ID: <20261028222500.2575769-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_vram_map_deferred() ignores errors from
virtio_gpu_vram_map(). If mapping fails before RESOURCE_MAP_BLOB
is queued, virtio_gpu_vram_mmap() still waits for a response
that will never arrive.

This can happen when drm_mm_insert_node() finds no room in
host_visible_mm. Since no command is sent, map_state remains
STATE_INITIALIZING. The task then waits indefinitely while holding
mmap_lock, and SIGKILL cannot terminate it. Any user with render
node access can trigger this by mmapping a deferred-mapping blob
larger than the host visible region.

Propagate the error so mmap() returns instead of waiting.

Tested on Linux v7.3 with QEMU (virtio-gpu-gl, blob=true,
hostmem=256M).

Fixes: 4c26e162947f ("drm/virtio: Extend blob UAPI with deferred-mapping hinting")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h  |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f3bbbe4468bf..a3c52aa17ed8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -561,7 +561,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struct virtio_gpu_object *bo,
 void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir);
-void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
+int virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
 
 /* virtgpu_submit.c */
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 01241ce4d07c..7e0fab7fb2eb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -45,7 +45,9 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object *obj,
 	if (!(bo->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
 		return -EINVAL;
 
-	virtio_gpu_vram_map_deferred(vram);
+	ret = virtio_gpu_vram_map_deferred(vram);
+	if (ret)
+		return ret;
 
 	if (vram->map_state == STATE_INITIALIZING)
 		virtio_gpu_notify(vgdev);
@@ -243,13 +245,17 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
 	return ret;
 }
 
-void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
+int virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
 {
+	int ret = 0;
+
 	if (!(vram->base.blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
-		return;
+		return 0;
 
 	mutex_lock(&map_lock);
 	if (!drm_mm_node_allocated(&vram->vram_node))
-		virtio_gpu_vram_map(&vram->base);
+		ret = virtio_gpu_vram_map(&vram->base);
 	mutex_unlock(&map_lock);
+
+	return ret;
 }

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

