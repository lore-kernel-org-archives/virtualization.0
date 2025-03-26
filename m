Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7114433CB
	for <virtualization@lists.linux.dev>; Wed, 26 Mar 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953841; cv=pass; b=RMFNAtRsxrJfEJD/a4J2mGSQSVnNC5ZmL7z3ip+UDjnAOP+dL6UBcs05/m2TbrnmddSnHVmx7y6s+McXyVUKeunXU+53FpbbwuYfxyQSbGpauXEmpFYuajsnnwFH0BTphv8x8tcojipQbSDrUlsmaFH8BF6Bj+WlL7mgchyTFpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953841; c=relaxed/simple;
	bh=WiElSeMUOyEGNFlsbiNmliVgwdj8BFm+q52issSF4+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX3gqli/xuGvyU69Mp6F7lXjz1bztr1vCb7CNT/5OuIPHcwdPS7Rgu6it+jTFt3PqGylEU5FzeHoOK68+c5LHSyDCJh8VTI5+ec/G1HNccwJ8qwMgz2QY1GvqFRFRHSOSOEH1yF7mf3XabQqyncqMI5pAndrtoBhE3jGLQDFYHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=P3rn/UvG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="P3rn/UvG"
ARC-Seal: i=1; a=rsa-sha256; t=1742953827; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B1MLcSqipPQpu6A4nqcIb55jteYccNLAsMiJ5Tm0krkMD4eeUA9l1EpwhWzgV5eMBR6cRX6G37tBwlMxKzh33J59x8Butf7rmDwiZRVRljePoXRRXm1kfXu3cT2kF+CpGCBrdQ2n66556pb2rRIPlNeJk/leLgwiaBqCaxSuCPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742953827; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l+DegcWS6jElhGW6hWqdl4HD0X6U581FmZGc7lb2pgs=; 
	b=MKIH0CDdScfMwytDkH8Yh9xtF4A1yNmeLFxj2WMam4fmmW1045zk/x8LyCcohfuWKoCjUCaGJ0Us0DE944sLGYVKgOSIbuG8OJg0qYs48aWV3I8fKVJ4eR3vfrik6yu6p+qWroUjYUWTl+FYteM1vblXkegd3dDGY8e8Ghs0xwg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742953827;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l+DegcWS6jElhGW6hWqdl4HD0X6U581FmZGc7lb2pgs=;
	b=P3rn/UvGTsfPa3I9srK14xXOlrjke8z2UTnKfGYoVrZD5jolnGrtKYh3r8NWWuhj
	zZYF6Q3DdoT4OZdqvs8d/KODFHLWvOP8zbMMEf7sq2SYIV0MWtEDCkElAC/PWCaA1Nq
	i1CfbTgYm+PiEgXV6REa+/UbUvQq11BgGEcCffmM=
Received: by mx.zohomail.com with SMTPS id 1742953824533990.002553575539;
	Tue, 25 Mar 2025 18:50:24 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 2/2] drm/virtio: Fix missed dmabuf unpinning in error path of prepare_fb()
Date: Wed, 26 Mar 2025 04:49:02 +0300
Message-ID: <20250326014902.379339-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326014902.379339-1-dmitry.osipenko@collabora.com>
References: <20250326014902.379339-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Unpin imported dmabuf on fence allocation failure in prepare_fb().

Fixes: 4a696a2ee646 ("drm/virtio: Add prepare and cleanup routines for imported dmabuf obj")
Cc: <stable@vger.kernel.org> # v6.14+
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a6f5a78f436a..dc1d91639931 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -342,6 +342,16 @@ static int virtio_gpu_prepare_imported_obj(struct drm_plane *plane,
 	return ret;
 }
 
+static void virtio_gpu_cleanup_imported_obj(struct drm_gem_object *obj)
+{
+	struct dma_buf_attachment *attach = obj->import_attach;
+	struct dma_resv *resv = attach->dmabuf->resv;
+
+	dma_resv_lock(resv, NULL);
+	dma_buf_unpin(attach);
+	dma_resv_unlock(resv);
+}
+
 static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 				       struct drm_plane_state *new_state)
 {
@@ -376,23 +386,16 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 		vgplane_st->fence = virtio_gpu_fence_alloc(vgdev,
 						     vgdev->fence_drv.context,
 						     0);
-		if (!vgplane_st->fence)
+		if (!vgplane_st->fence) {
+			if (obj->import_attach)
+				virtio_gpu_cleanup_imported_obj(obj);
 			return -ENOMEM;
+		}
 	}
 
 	return 0;
 }
 
-static void virtio_gpu_cleanup_imported_obj(struct drm_gem_object *obj)
-{
-	struct dma_buf_attachment *attach = obj->import_attach;
-	struct dma_resv *resv = attach->dmabuf->resv;
-
-	dma_resv_lock(resv, NULL);
-	dma_buf_unpin(attach);
-	dma_resv_unlock(resv);
-}
-
 static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 					struct drm_plane_state *state)
 {
-- 
2.49.0

