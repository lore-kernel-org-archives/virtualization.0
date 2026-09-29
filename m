Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258BA38E8CA
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665644; cv=none; b=kxLjz1Uzb567iFah3Yo+ZkDt5h6GcJeM5t/hSTqH/Dk+il3Imf9pCrodFUcYjGTyhwzhXojj2SChig+kCmGL8fdvPlCXwRm42P6TmXOxmoUmPdbSZ+iWny7tmbENW+pdlYOIWu1skCaOeuteU/TrRTHfqedamlyEPSyT+8mUg6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665644; c=relaxed/simple;
	bh=n2TenuQfS30jIvUa7/T0s//KY/39k2s4/cvb+SfW5ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2PdIP4PuEfYCJOz0MnzC1tZ+um57R81/UQyO10i91eJzq/OlwSlee3cMc1kfXZGFBAUhqT1YpKNypbfaA0kf53n5OP/64E8c70xXW/+16+WsOyPLBqAH42FTG6rfa1Tj9nwvTcj8bDTIavCT+NuaJU44mak8v971COLPny6IWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mo8OQIfS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo8OQIfS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso36236475e9.3
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790665641; x=1791270441; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kjavUluxIdj8vslb6mPPnH9lKklEmbuVjVAK6jlaIw=;
        b=Mo8OQIfSh9DKxj1YNAskfnwIb7LmicyIXiL3yzyUvdkZS+P+IbZ0hEv96gxLpUaprb
         4Nd7r6bAIUrK9PVRYhjM4XPlBw1Ly7YowI+8v8J9qRulCLDrwCTNgW5+896HbOCmCvrI
         uS6m7OKuiTk2BPYOLy/5saghG5n6GL7ocqELcqMiFmpvfVFOysQkKlDktUOgiCY+IWoe
         s/WVHodtaSZXjphSs7HMtNShG57c/SHvttT7IJHr/WxbHHNVhoZx8L2YiOsg3F2eOYCP
         vTkyfKBVTNW2gAzN/oUJythWRx0bd/MSJEEUFcmdFcqW8klQWTMVFVLz0xTuw2Is4mUh
         TBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790665641; x=1791270441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0kjavUluxIdj8vslb6mPPnH9lKklEmbuVjVAK6jlaIw=;
        b=PqWgZ8hUcDTPC+HcCwzG3C5KKtDXuh4ElhjoSGGaREcwh13U5N6WhvHPmxodjze+jz
         w2gvtju4pEp8CWwi3q1Kk5N2Jb18D15/3HmrWU1BSQq67AX3h8Ezz+zUpL3m37VgEzoL
         JyzvVYbLJ/lffLKW7feZ91/aYHiEwkc2Af9nokpEVJL7DCUjthzgBC/vdDLJlY4TLqTg
         dQN9l1qA2pZxWyq1YWpmpGAThUGrsfiOIL2ykmjtvNqtrfzLgF9DNdd7VrPdBmt7d/os
         5A/cWcYn9vZiwOFIcmF2FWdsAqNOKWR9NPTZBeZxtw3/BldwwtPyHj+DTBdgMqqPA2o9
         4nLg==
X-Forwarded-Encrypted: i=1; AKwUvBw4f2ivRLZGZKT0E5HKAxAH/GAOe2eWfJiqPkzS2r+tLPQEmaLizCWS5hNNjwZzB+cyCf/QR4EhC14KC/naiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lsn0qfLpt2oa+vGHsZFRC5JhbLf1H4uePyrMlEJGssgy1tgLrM
	2TiaeWDc9vly1l8gdfyF3bPE85LJdk6OIBAXZd2NbdQkYQ/ZdRm0s3D8
X-Gm-Gg: AYBFou11l4aZV9Kjq/0DojhX1/Ns11OaQpwk+TqUXCdiiTRyY46j2wddUk4OhaX2Vc2
	awr3r00Gz2mGNpyvWtEA9v78oI3wuvvQgazlUvb00YDBkgphldK5onV/4tvDQuZ2QiGAd/Vyl9J
	G2cXnYIwVzgmj6EN/aKYmOYgnrNhJsof7FIP/JBFaqRzjSqYISMPkK6f7JlsWlfels3awwlSZBz
	duquzWRDv1j4OrLV5lcWpUdGi7xru5Rh3OQ2zFJbgrM6j8J5vGOtm5shzi5uCNl6COzIgKZFS2c
	j9qtnH1oFx8xt8Z0hq+PuISlDvZuG0lmngsakCBn8IjK6wbj8wphupLsXqjITnvy8MFWXipbs46
	w7zZE4ZnEdYFViNhJy9YtTLL5zphWFXwYaxoAkgvGMOl01zzPL2wu2YfgwtLcZcjTnmcEv4ZkOC
	M0tv6Aozw3xTBhI4Kza1gUMBQSvOcZOKkkmfWSjr6LOXcavMqL7X0naIVql5nzlADrmhunUdTfn
	15EQ0UZAK6u0ZcSG0BhytIGI87eL6JY5Yy5fJdIi+wTetKYH8urGOotzY47aNUen94=
X-Received: by 2002:a05:600c:3556:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-49fe6708a46mr262115795e9.31.1790665640767;
        Tue, 29 Sep 2026 00:07:20 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-017-137.2.214.pool.telefonica.de. [2.214.17.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfec770sm57919625e9.8.2026.09.29.00.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:07:20 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	David Airlie <airlied@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Dongwon Kim <dongwon.kim@intel.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH] drm/virtio: Destroy obj_restore_lock on the final drm_dev_put()
Date: Tue, 29 Sep 2026 07:07:14 +0000
Message-ID: <20260929070714.169412-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
alive, and the fbdev DRM client holds a drm_device reference. When the
fd is finally closed, the buffer is freed and takes the destroyed lock:

  fb_release()
    drm_fbdev_shmem_fb_destroy()
      drm_client_buffer_delete()
        virtio_gpu_free_object()
          virtio_gpu_remove_from_restore_list()
            mutex_lock(&vgdev->obj_restore_lock)

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec

virtio_gpu_deinit() should only do hardware teardown in this case
related virtio, its queues and others. Software state that GEM callbacks
still use belongs in virtio_gpu_release(), which runs on the final
drm_dev_put().

There are two equivalent ways to tie the mutex lifetime to the
drm_device:

 1) Move mutex_destroy() from virtio_gpu_deinit() to the end of
    virtio_gpu_release(). This is what this patch does. It is the
    smallest change and keeps the teardown next to the rest of the
    final-put software cleanup.

 2) Initialise the lock with drmm_mutex_init() (checking its return
    value) and drop mutex_destroy() from virtio_gpu_deinit(), so DRM's
    managed release destroys it. This also covers the virtio_gpu_init()
    error path, where release returns early because dev_private is
    NULL. Skipping mutex_destroy() there is harmless, since it only
    matters for mutex debugging.

Either fix removes the WARN. Option 1 is sent as the smaller change,
and option 2 can be done instead if preferred.

Reproduced on arm64 QEMU (-device virtio-gpu-pci) with DEBUG_MUTEXES
and PROVE_LOCKING: open /dev/fb0, write 1 to
/sys/bus/pci/devices/0000:00:01.0/remove, then close the fd. With this
patch the WARN is gone, and rebinding brings back /dev/fb0 and
/dev/dri/card0.

Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring virtio_gpu_objects")
Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
Assisted-by: LLM
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1d4d3bf46a20..0ec755c35050 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -354,7 +354,6 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	virtio_reset_device(vgdev->vdev);
 	virtio_gpu_reclaim_vbufs(vgdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
-	mutex_destroy(&vgdev->obj_restore_lock);
 }
 
 void virtio_gpu_release(struct drm_device *dev)
@@ -370,6 +369,8 @@ void virtio_gpu_release(struct drm_device *dev)
 
 	if (vgdev->has_host_visible)
 		drm_mm_takedown(&vgdev->host_visible_mm);
+
+	mutex_destroy(&vgdev->obj_restore_lock);
 }
 
 int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.51.1

