Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7713D619
	for <virtualization@lists.linux.dev>; Fri, 29 Nov 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895805; cv=pass; b=FEIjsBf72EzEn7b2W9NcpHuduiMGUJYtk+nf9wob/gwTGK1VIuR1R90ebZAChEme1WS914k1gMdW8qDF6qBY158zZQzQ7jXNPf7ySTsd0UptKzTfrrwkN71bdx6lR2wUPokGsE3VMBpl9HBlUoGWzxu73VH7miSPperIQ6O0IGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895805; c=relaxed/simple;
	bh=2oeyQZofW2ewahnY7DM1cwBEiJvAaxX6dlSVcTdh7sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z9j6aKLE72YpnYwfuQZbqw/U3MKWrX4WBkq88aiBhBI0W2pJ0lw/CAGVGJGtt+DR+tgzfu+KQq9ueZvSPy1T1Cv2nOC/K1zopp8Rze9Gu0yrTurXFjLNxM7rSAEVIRqtwbM7w6TNO4y9tZ3skxSCzT/31UkonNUu5xlXVBUVkYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=jStDHHxR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="jStDHHxR"
ARC-Seal: i=1; a=rsa-sha256; t=1732895794; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IqLUoYyKTo3n0TGyZeEphOuMc+1H8wvqeyrcWo+gSs3aYmKMCBa5EvAYzrhuj3/WOka/+8veIgW/duf33PodGWATC1OMesNXBRLVzccu/Nv8f2vdHYQonO5gRRuodtbh4GmzWfTuSmwuqhrZ79DVBf/UFha0QPUDNWvFHGUHCjc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732895794; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=L1n0P1PyrA42r5RgU2rWlUpygAiAbYbhSvSFfsMFi7Y=; 
	b=hmsYM/ZEylEpWoNJHDAbxBkaaxgen9SdqsBBQqua4fq2cFnI7dhoUW/q6mJvMmLKLLZ0L9IlF49kKciXdAH5CZiIzoyoMRUAATqC4zqRXcTUM5eEDzsl+BLDKBpqlnMyrwsYDZsTDKDXZlThKli8WZnlvyGGsYWDBRJXxXHsghQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732895794;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=L1n0P1PyrA42r5RgU2rWlUpygAiAbYbhSvSFfsMFi7Y=;
	b=jStDHHxRGzpaSWiQJPPb2SKgDWfFEgt9l38M1M8ATPfgt4/3d3iJh8zH0IW3GPya
	tj5YZS6Fch/B48tXbyBJph2ZADHeBEy8HZ2QMcPUKYhulgFT9GoPVXjbj2WjtKEOJlt
	nydq1c0t3OEEtqJ4+lcf2M6RFiTeuC3QE0868x6I=
Received: by mx.zohomail.com with SMTPS id 1732895792071583.5803474673253;
	Fri, 29 Nov 2024 07:56:32 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Kim Dongwon <dongwon.kim@intel.com>,
	Kasireddy Vivek <vivek.kasireddy@intel.com>
Cc: Rob Clark <robdclark@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1] drm/virtio: Set missing bo->attached flag
Date: Fri, 29 Nov 2024 18:53:57 +0300
Message-ID: <20241129155357.2265357-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

VirtIO-GPU driver now supports detachment of shmem BOs from host, but
doing it only for imported dma-bufs. Mark all shmem BOs as attached, not
just dma-bufs. This is a minor correction since detachment of a non-dmabuf
BOs not supported today.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 1 -
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 688810d1b611..33084ce1d01d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -249,7 +249,6 @@ static int virtgpu_dma_buf_init_obj(struct drm_device *dev,
 	virtio_gpu_cmd_resource_create_blob(vgdev, bo, &params,
 					    ents, nents);
 	bo->guest_blob = true;
-	bo->attached = true;
 
 	dma_buf_unpin(attach);
 	dma_resv_unlock(resv);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index ad91624df42d..062639250a4e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -1300,6 +1300,9 @@ virtio_gpu_cmd_resource_create_blob(struct virtio_gpu_device *vgdev,
 
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 	bo->created = true;
+
+	if (nents)
+		bo->attached = true;
 }
 
 void virtio_gpu_cmd_set_scanout_blob(struct virtio_gpu_device *vgdev,
-- 
2.47.0

