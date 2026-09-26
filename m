Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE449D5A6
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454049; cv=none; b=QvGBt9NnNOMtvVBiFu1Ae4vsS15TCcm3S2T+k3qhfeo4qNkEZ7RHzFbstkqNxCnUh+7G3D4KaGx0Y94Z6w/WpwSDoanKVfhOjtLsK3/AUSYFPfG+12KepFZYBepA/V6EF7l3LQKK9L6J7lK/X7jX5pLnp9xWUZ8iJebQ6+WqDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454049; c=relaxed/simple;
	bh=TeA4rzx3tIqodbILhjQ27AMr7aKkw2UurfV3eDfJVl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qob1VSQiROHiGetN5nLhps4vzGM5i7JZf4USd0k7zFMVC9TbILu/06pnZMhodULmrmcBAzKun/o2dXjnKAWCushfivSwKugXwdoqPpjBVfc745U7wzpiUa74yS8Hp27CNjQ3E5CdH/S2U2pL/GhmmE9t2+2BjnJof/v3VkG4nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwYcbuNo; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwYcbuNo"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd3so17062251cf.0
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790454046; x=1791058846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yMSXbv0RzpnT7LQIOAfBfWiKfyiEPbJB+JqeZgxSJQ=;
        b=nwYcbuNoG/6gXGuiPZu9SRnVusW/B4f4R0nt+m4tu8gdkqI5AYAMEPQQpJitb2G62e
         jUpwwxuqStTEqD5i+cBmzBV7pOyZYZeRBNUt9mhIsEmnBUnEMTjySWNoE/wFfRT/5MvU
         OSwAaJ7UcrAyCIW9P3Y2qXqWoihKWmFU4mkXMBiA4qcGfE5N2z97d1QBNcq0VSSs+en8
         WDe8LGS1zG1Sl3W5EdKHopIazsd65AaypkL4JEHmwwYK56ga9fKMjLyYq/A9Rpj2yNYj
         cx4G3GuSf96/JbeNEh68xhkUf9WrBHVYkbTpQfrXAY4g4+CkZ5zBEC3EikciJb4sTi2d
         Gr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790454046; x=1791058846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yMSXbv0RzpnT7LQIOAfBfWiKfyiEPbJB+JqeZgxSJQ=;
        b=QfKuE9DFUhZU79xVd7o51Y57kMiRlqAcTa4aS1UzJCBxe5hd/epyU5v/eo80mLHO8K
         H/0tJV/wgQpReycQvwesbBe0TXthlgxR8N8Wu+Yr+MmldS9DnHqpKNYAaIOeRksOnbK9
         ZQIpJF/njseVrVbtILXn1xO71H+T2lGTOoo8wu7Al7kr7MU26yHqpjjG/36Hhqad45+k
         26N7elpXx1Nie845y4cUV8Jkantz0/2E/GkUFimhZ8eITjNvKJULAhmGtpAOPfv2j69F
         QWiuamCoi+YUZ9xjfZJkdY1XwYNAldS8OrAZJZIppgaD8oxx/5QNNmiV4KG7e4VIsihL
         ZpAQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2MsN0x+HouEXnLrBBGjWKjZfNjQfGKc8IoOe+FsDabRGmwG9SKdSTBmEhONrrcQjb9v4ycYkKFdopLICs4A==@lists.linux.dev
X-Gm-Message-State: AFuF++mCP7VzxPsiNLzyEonqNR+1da8Naqi7j1/EA3eGmIHDHcnvD2A6
	Vm0GTwNmHajrcTGh5+iG3gXJC5M2OVpfCeb2RaIxHMMrC8tIWZeedsuX
X-Gm-Gg: AYBFou25WhN7Wy+wuJcvJ7KFIV0Dnmm7isO+kNuN7RV/YyQYjWH22uDeUoLwQMmi8hY
	sOBVqR46SIlxcdU/AxYbhgBkrnFNaquPkGUClv0I9bVJxfMo/pVK3xQQJt029JNFMrrJ8NMyj9Q
	OHldMWksr3HHnrLm+a0Gt0xtaG/NW0FcIU/IVBOyD58+t7/6skFMzI+itJZRBtBZV5Eg/AFGGHX
	uQnwM/p6PnQQKE6GhPyNM8+CiXVqcuijP3nbv5ek2gwJTDeaWGA5m1bpSDawLF4qQEvIfV68MCx
	77BlaE/bzdQvOMBb/s2Q/Ri7XFTUf4QbdCLqu3ikaymP9H0KkprC9dVO/zjfC9zZ4wTFmrVTOFe
	NB2xKO5zmg33vzMv4/F6sW/K2b5HHgIJaBDVLbndR72R1PUeIlOsMKxK5MVbE7v9v1x4rP3vRD8
	+Ns4LEcFPXtafqKyR0p/V8wcayOwFrvzGQsWsKqt7zBseE76JdrJz1Sb+wP1yFJ3ocnpqKI4Azq
	XS8CKkHQ1UrKu1dWvqvCQ==
X-Received: by 2002:a05:622a:15c4:b0:530:178a:9dd8 with SMTP id d75a77b69052e-5330b556ae7mr122052901cf.8.1790454046528;
        Sat, 26 Sep 2026 13:20:46 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5332238c585sm25325811cf.20.2026.09.26.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 13:20:46 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Dongwon Kim <dongwon.kim@intel.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/virtio: Reset device before deleting virtqueues on freeze
Date: Sat, 26 Sep 2026 16:20:27 -0400
Message-ID: <20260926202040.1313385-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtgpu_freeze() waits for the control and cursor queues to drain and
then deletes the virtqueues, but nothing tells the device to stop first.
del_vqs() frees the vring backing, but does not provide a generic device
quiesce operation. In particular, modern virtio-pci keeps enabled queues
active until the device is reset, so the device is left DRIVER_OK with
its queues pointing at memory that has been freed and may be reused while
the guest is suspended. virtio_device_restore() only resets the device
later, on resume.

Reset the device before deleting the virtqueues, the way
virtio_gpu_deinit() already does on removal.

Fixes: cad6a879a7fb ("drm/virtio: Freeze and restore hooks to support suspend and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2aaa7cb08085..52c174f9bff7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -225,6 +225,7 @@ static int virtgpu_freeze(struct virtio_device *vdev)
 		goto err_resume;
 	}
 
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
 	return 0;
-- 
2.43.0

