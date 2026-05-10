Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C534575D
	for <virtualization@lists.linux.dev>; Sun, 10 May 2026 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391038; cv=none; b=Gp379+loNRYW2M1zy1E6Hquviy4ZlVmI7paiKAPPS/lnx/IDYAevoRV1rC3G1lO16iBgdX/EhkQ+YmOz/gQ/d7i2UtL5OOXiFFooSk7lxOn8g8W3KyTkFqlLD2WyH6SXZsTfTsC3P5/LXO6OpXWnMEPZ2jMMyPQmm78CtrQF2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391038; c=relaxed/simple;
	bh=KIsmtJOEOeNGwnrSKy5ZyFdD72rmOYFJWN7TY1z7kXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkX5AAUJyiRBZRJFF5oj5tjOttMzG77ocsoHvKibubI1+73ibkb1Zuy5EryStk+BuAw3+n9RFVRAfZSmB996jGo7DGjM+xb9p+/85ftrDnd8OwSoxqX2s9cba08i0GnuEjccpq70LCnTvSa9Q31n6Emohxe2kOCTIacFG38RDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUmz51GE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUmz51GE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso32150775ad.2
        for <virtualization@lists.linux.dev>; Sat, 09 May 2026 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778391036; x=1778995836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiZtT3KiED6Ar39Wsw4WFRof7QOLYq294txhwcfCtho=;
        b=pUmz51GEX3obAEP+ptp+pq/4P0fccS9bM9+PpLHCfCm+YIPIhnSsusE5+OvtQIRoZl
         XAcLjDe3h7rOWQ/b1O/+9/zUioc/ibh+hTCEKa/wGE5RIhNrmv6Lc9ImomlGRzX0OKbk
         J1WVms2nqnpXZa1aY0wPTmsyEFUOmPBQyLgPBnQG1bImUWMp9faY2+JeZbNCOjTEwbCk
         GGV7C0jgCU8r1dJgE0XJ50544YurKTExFn7kGwh/zYgc9rfEv+3nvKRc6wnaPJ8N6+oV
         n9UvxUyZ9Cz2Jtlz6ui5WDHKkyRm37OLvDLrCtfh7Qn3Ubu+A/H8YJdVV95WzcLoDsLI
         /rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778391036; x=1778995836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiZtT3KiED6Ar39Wsw4WFRof7QOLYq294txhwcfCtho=;
        b=A9BATGKVd5IluvBqdFCiyCo+CjoUdaBjd59aAhv4mgoL4okIArfTYZH6+Wfz2y5F+c
         FuTMO4fyYMGW2ciSOKj8ErWrp1HdZhG+yNY8IZQuxvRcuTe2pkheCvw3TatCl1EIDrg9
         g0rMNmJM+imEIQzwQlzp/WEfGGPhQ0MbQfZ5lQJOSEbzb6CNlxCp0AZzdQsq52+zE983
         0iczbvfwTBAJTT3Gmz+LChZtWI8VHGFdmso3QvLI5kVta1vpYOuM0T6NmyemMz47ITXl
         cevEOWXpuYnjQ3bLZqIec5Nf3Utfiqr96jMS0fqfyJ3ct+QYOfSjQ8uv7Q0KYcxWcMt8
         T2OQ==
X-Forwarded-Encrypted: i=1; AFNElJ9nAgfgoSFL2vkDzP6Q48HroPoGUe+E5Q1M2E6vK1zeKF7uJCpOCChy1hwSH+l2E/4nOcwy/Qm2CbJoxuVBDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFGRW71ZNdYu/z02ZkNgGeiWAog2QhQHaUeNhyV3J+RPjcdnP6
	5Z+QhAx7nAtZnCxmBJLsUPgDQgUTaqQOKWQdI/HetoyMszul0ulRRY9d
X-Gm-Gg: Acq92OHshST5rLXla8PP2dR0sG921hP/AQ17zE6skWVr8GlCuniomgDrEhumfd4TfnA
	d/mQWytqBHVd3KRa5v9Fi+F8ESevSQCcAiml28F/2MmKdufmX9m4kVTUhIyHo9CAWMOUzt0JVup
	hyfJnt5cigZD3SoqYWeNuyy0Nt2P3f3Iayg3hdWvhbn/UfCKvEf/luJf11c6afMnQTqF6DPCTYp
	WWohjbe1Ua3RipzFIwr38LoUSR0o9Hdc5/uGGqMgcmF0h5uaeXRFjon7EgqTE3FQ8JOJhiFuXiD
	E0cI2IWuJ2+OkP1ZqLpSKmMijZgaE/Bm9Rknuas/THsFSt1rRI6uAgmKQSCLBrggPCLqjnERbVv
	oiIpNcgCx3XDZRjCLdcmTlSZoj4Si8lwfi7UR8izI4S/MkIGYFZSEirG4HQJpr/EmsOwM+Npwci
	ed2u0obqhLeMpJcDeuoG8aakNQHpdLJun5U4iKyGz3SeD9wyaxYBLkq4UobLErSplQWg/83M5fb
	PsSgdM=
X-Received: by 2002:a17:903:388c:b0:2ba:307:4584 with SMTP id d9443c01a7336-2bc7aa40967mr50895195ad.32.1778391036502;
        Sat, 09 May 2026 22:30:36 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:5d23:3a35:10d1:5ed6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebea72sm67859095ad.77.2026.05.09.22.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 22:30:36 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/virtio: check virtio_gpu_array_lock_resv() return in cursor update
Date: Sun, 10 May 2026 11:00:25 +0530
Message-ID: <20260510053025.100224-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_cursor_plane_update() calls virtio_gpu_array_lock_resv()
but ignores its return value. The function can fail in two ways:

  - dma_resv_lock_interruptible() returns -ERESTARTSYS when a signal
    is delivered while waiting for the reservation lock.
  - dma_resv_reserve_fences() returns -ENOMEM if it fails to allocate
    a fence slot; in this case lock_resv unlocks before returning.

In both cases the resv lock is not held on return. The cursor path
proceeds to queue a fenced transfer command. The queue path then
walks the object array and calls dma_resv_add_fence() on the cursor
BO's reservation. dma_resv_add_fence() requires the resv lock to be
held; with lockdep enabled the missing lock trips
dma_resv_assert_held():

  WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
  Call Trace:
   virtio_gpu_array_add_fence+0xcd/0x140
   virtio_gpu_queue_ctrl_sgs
   virtio_gpu_queue_fenced_ctrl_buffer+0x578/0xfb0
   virtio_gpu_cursor_plane_update+0x411/0xbc0
   drm_atomic_helper_commit_planes+0x497/0xf10
   ...
   drm_mode_cursor_ioctl+0xd4/0x110
   drm_ioctl+0x5e6/0xc60
   __x64_sys_ioctl+0x18e/0x210

Beyond the WARN, mutating the dma_resv fence list without the lock
races with concurrent readers/writers and can corrupt the list.

Check the return value of virtio_gpu_array_lock_resv(). On failure,
drop the references taken by virtio_gpu_array_add_obj() with
virtio_gpu_array_put_free() (which does not unlock, matching the
not-locked state) and return without queueing the command. A
skipped cursor frame is harmless; the WARN and the underlying race
are not.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..ca379b08b9ec 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -459,7 +459,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0

