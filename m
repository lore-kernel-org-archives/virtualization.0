Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1B2586C2
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572160; cv=pass; b=CAPSA/qD94brK0uccq3wRpcNZqoXhUUJplmMJ5zyVSw89Zv5lXLaNjepK6/AEfT2j1AEf+NmaYJzwS8+X/rqfhFuy/VugYeiJxwvlyxuMkmsPu2lZRcipWPcUja3AoetUT/AoaPimHpvA29/ky09G3oLkTOpje0NXu2rAoqDOTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572160; c=relaxed/simple;
	bh=PkvL1LSHddhFS4RHqPVgHzwit9Tza51vcw4DAjp7N2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svOybLcqURnQ5ACASuKNPhwwB70EoHs2eJqX4Shw0FJttnxIeQTeaCGQ5iPquEFYgSciMnMFY4sS1Bgf+s5mPlL8quFkcg3BK+YD5hU3kMwjkf50o/01Cc9hX8eTdcIIxAzDa9aruCuo9c1F0gdNgOeXXeFyaK6NeEfAlLNbWe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b=NutCNxY8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b="NutCNxY8"
ARC-Seal: i=1; a=rsa-sha256; t=1754572150; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R2gHgl2RBD5TQSlEkFxLvNcqXVKL+U9s0Z6yh4Qal+Lb8vyOYyZq7bVfRLaLF1hz9R9J2lF4HuXuWmZlHELki7xIAuuGdrDb6KvNTNVfXZSZc7WEH83GevuON1FOC3wh52PeuS8O7kcQ6stttMq1NxY072eP4BGXXydG/wYAox8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754572150; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GOKWd7XAOCSunMtdz4EmOG9p2XcFDVXG0DrG+q6pUT4=; 
	b=NaiuWOuW4dIcOIdWoZklmtapdZvPZcaxlEgG35WIBLVM/kbmOinUyedBgj+gQDSoF8FgfJN+CFnPxyGYF6LpjJXcqHK/y7vQgbdXtIqMtdJ05svkt33/4QYE6lcHmfSoJjgYlXRoDKyt0hGg78zwkUAK9PmLRTY2JJQQww52hDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
	dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754572150;
	s=zohomail; d=collabora.com; i=igor.torrente@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GOKWd7XAOCSunMtdz4EmOG9p2XcFDVXG0DrG+q6pUT4=;
	b=NutCNxY8Ad+l+5BtNcw9Rx9eAAW3X2dlRcDxjph7CUZu807rbBhdoFTcIowdlHK6
	iU8IY6VT5c+4cCTX58cDLDlsdlGlfgyRwbhdR8LICRiTRgTfLmC9sC+4b5PIOY/D5US
	Y4muNZr2mF2djLCYjy+P+1HrDUM/0vLLdWbYq13M=
Received: by mx.zohomail.com with SMTPS id 1754572148318644.6251951352543;
	Thu, 7 Aug 2025 06:09:08 -0700 (PDT)
From: Igor Torrente <igor.torrente@collabora.com>
To: mst@redhat.com
Cc: sami.md.ko@gmail.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	jasowang@redhat.com,
	dmitry.osipenko@collabora.com,
	Igor Torrente <igor.torrente@collabora.com>
Subject: [PATCH v2] Revert "virtio: reject shm region if length is zero"
Date: Thu,  7 Aug 2025 10:03:29 -0300
Message-ID: <20250807130326.82662-4-igor.torrente@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The commit 206cc44588f7 ("virtio: reject shm region if length is zero")
breaks the Virtio-gpu `host_visible` feature.

Right now in the Virtio-gpu code, `host_visible_region.len` is zero because
the struct comes directly from the `kzalloc` allocation. And Virtio-gpu
is using the `vm_get_shm_region` (drivers/virtio/virtio_mmio.c:536) to read
the `addr` and `len` from Qemu/Crosvm.

```
drivers/gpu/drm/virtio/virtgpu_kms.c
132 vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
[...]
177 if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
178                           VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
```
Now it always fails.

As the Virtio-gpu relies on the previous behavior, this patch reverts
the offending commit.

Fixes: 206cc44588f7 ("virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible")

This reverts commit 206cc44588f72b49ad4d7e21a7472ab2a72a83df.

Signed-off-by: Igor Torrente <igor.torrente@collabora.com>
---
v2: Improve the commit message (Michael S. Tsirkin)

 include/linux/virtio_config.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b3e1d30c765b..169c7d367fac 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -329,8 +329,6 @@ static inline
 bool virtio_get_shm_region(struct virtio_device *vdev,
 			   struct virtio_shm_region *region, u8 id)
 {
-	if (!region->len)
-		return false;
 	if (!vdev->config->get_shm_region)
 		return false;
 	return vdev->config->get_shm_region(vdev, region, id);
-- 
2.49.0

