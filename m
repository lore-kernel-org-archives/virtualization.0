Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696007;
	b=3UQc0bpqFN/01hu8J2XDmUk1qi9+cvrrxo1hMUddpkv/ZCojiKkTSqBhwDovX3/67HPJ
	 dV0edz6vEuF8cJ1szqveJldfeC3xEhfS/MBBsxPIaWvNOltWbQnEkru86QsfjN+8fk2NF
	 t28ZWZxLXckA+vtlxvfInHgdLPYI/hFR2pZtZZQlm9d3BQ/1dEJBbJOv1oPS982hUBQ/6
	 1ofvsxD0g/qqDvbD4gYZE/6viLXlTSUtj1VTCE52xUg4EnjijywTap6G41h5XXHzXbDee
	 wbubetBHFILNwqaRTkhrWPS6eY9R4/DEKbDP739Ur0g7PXKRoM1rdiidjAs+1T9Q7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696007;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EcSoxxnJMuvLP1xQ1FTzrMC+CsvkWlzyYnlR9skwhbc=;
	b=CjhmVZ43cb/VcOT2oz9vyUBuezN6wYGEcTi1CDLr26OBIsoj0Ds+/Ick6PYe1RW8hiEw
	 KKE3tc/x9FL1FkH1fdsSxOjdzcIw/6fC59rq1PX0JG4sFuuR8xh/xsfOd9sMnK6ns1OE5
	 kq4OWn/871wRqXrGhVnwwaIhM2f82Al+Prw+ht1LAIALUkZ89JC1FtHX+ydUQxv0aOD85
	 R1L6ISn//qlPiRaVi4mH0izZVyt16U/S/hp4uoMcH7VIlaIDTd1t8H/HRCvmDlgTy5CcR
	 ebe78skwzRUwny0sy/mUNUQB+d/OGn7a4GRfhWKLYIItufXWiNzfIyFktj2TzVzLW3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kWZQdAmA;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C6606A32F
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 08:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E67C6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kWZQdAmA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793696007; x=1825232007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p622XnqmTxgrIzjfBothae0z/U5tiui9rdZzVBu4Is4=;
  b=kWZQdAmAHWviGIfFlDM3zas+iVKaoD6CJckzrrrj0kNyG7Bvt4xGap5x
   0YaW3AFjosPoa+ryY8ZxKzeKxNl+ykVAf9XxAVku7WWsT5LM7/o2K2wj0
   DM7s0JJRGYfyCgdkh5Tk0UrtYWjCsV9UstJfhvR3KGW6k/w7+91A0nY/W
   SFImqHkmuMVSNALy8UH/F71x5kuBmeOUWsN6i/ImgZC8NWzz8NN7xcSBk
   JB/vd8P3T5iV5CHWXzDsmYIoftKO3wEfkO9rYJtZ/5RjMRtGgF2aF90Rw
   K6W0B2igXls0LSWnhYwr5mrEO8i5fYU3hLyPiyVlgCIZ++Kjxax0RBZBK
   Q==;
X-CSE-ConnectionGUID: Mk7Dfwu4SgaRfd02eNRGOw==
X-CSE-MsgGUID: wDo78TYeRuigyausjcg87Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2439717"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2439717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 00:53:07 -0800
X-CSE-ConnectionGUID: WZiypFdLTL2ooUY+g3QchA==
X-CSE-MsgGUID: aMbtfmTWR4S2MGK4pGQEuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6255554"
Received: from yufei-inspiron-3910.sh.intel.com ([10.239.92.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 00:53:05 -0800
From: "Yu, Fei" <fei.yu@intel.com>
To: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Hui Peng <benquike@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com,
	Fei Yu <fei.yu@intel.com>
Subject: [PATCH v2] drm/virtio: Put GEM objects when dropping a vbuf without queueing it
Date: Tue,  3 Nov 2026 16:53:14 +0800
Message-ID: <20261103085314.3102802-1-fei.yu@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
References: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
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

From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

virtio_gpu_queue_ctrl_sgs() drops the command when drm_dev_enter()
fails or when vqs_released is set during device removal. It unlocks the
reservations and frees the vbuf, but never releases the GEM object
references that the caller transferred in vbuf->objs. Those references
are normally dropped by the dequeue worker once the host completes the
command, which never happens for a command that was not queued.

If a framebuffer flush or transfer (e.g. the fbdev damage worker) races
with device removal, the GEM object backing the buffer keeps a stale
reference and is never freed. GEM objects do not hold a reference on the
drm_device, so the device is still released, with the object's node left
in the vma offset manager:

  Memory manager not clean during takedown.
  WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown+0x62/0x280
  Call Trace:
   drm_managed_release+0x1bb/0x540 drivers/gpu/drm/drm_managed.c:75
   drm_dev_release drivers/gpu/drm/drm_drv.c:924 [inline]
   drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:957
   virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
   ...
   virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:760
   ...
   remove_store+0x123/0x140 drivers/pci/pci-sysfs.c:524

The vmalloc_to_sgt() failure path in virtio_gpu_queue_fenced_ctrl_buffer()
has the same problem, and additionally leaks the vbuf itself.

Add a helper that releases a vbuf which was never added to the
virtqueue, including the object references it owns, and use it on all
three early-exit paths. None of the callers touches the object array
after handing it to the queue functions, so this cannot double-put.

Fixes: b1df3a2b24a9 ("drm/virtio: add drm_driver.release callback.")
Fixes: a46991b334f6 ("drm/virtio: abort virtqueue wait on device removal to avoid hung task")
Fixes: e1218b8c0cc1 ("drm/virtio: Use vmalloc for command buffer allocations.")
Reported-by: syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d93b9064fe5f74af3aa3
Link: https://lore.kernel.org/all/20260927040655.14531-1-ngocthang2710.1999@gmail.com/
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
[fei.yu: also handle the vmalloc_to_sgt() failure path, pass the fence
 to the helper instead of a bool, fix the Fixes tags]
Signed-off-by: Fei Yu <fei.yu@intel.com>
---
Testing: syzbot C reproducer (PCI remove/rescan loop) for 120s in QEMU
with fbcon on virtio-gpu: v7.4-rc1 printed "Memory manager not clean
during takedown" in 377 of 441 cycles (kmemleak: 4040 objects); with
this patch, 487 cycles, no warning, no kmemleak report.

v2 (Fei Yu, Nguyen's v1 got no review for weeks):
 - also handle the vmalloc_to_sgt() failure path in
   virtio_gpu_queue_fenced_ctrl_buffer(), which leaked the vbuf as well
 - pass the fence to virtio_gpu_drop_vbuf() instead of a bool
 - replace the Fixes tag: b7170f9457f2 only changed the return type;
   point at the commits that added the three early-exit paths

v1: https://lore.kernel.org/all/20260927040655.14531-1-ngocthang2710.1999@gmail.com/

Note: Hui Peng's "drm/virtio: fix vbuf->objs double-free, fence NULL
deref, and sgt error path" [1] touches the same paths (by moving the put
into free_vbuf()) and conflicts with this patch.

[1] https://lore.kernel.org/all/20260919223440.3884176-1-benquike@gmail.com/

 drivers/gpu/drm/virtio/virtgpu_vq.c | 30 +++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index d99fb9e32..21271966b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -208,6 +208,25 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	kmem_cache_free(vgdev->vbufs, vbuf);
 }
 
+/*
+ * Free a vbuf that never made it into the virtqueue.  The caller handed
+ * over the references in vbuf->objs, which would otherwise have been
+ * dropped by the dequeue worker once the host completed the command, so
+ * release them here.  If a fence was passed, the reservations are still
+ * locked and must be unlocked first.
+ */
+static void virtio_gpu_drop_vbuf(struct virtio_gpu_device *vgdev,
+				 struct virtio_gpu_vbuffer *vbuf,
+				 struct virtio_gpu_fence *fence)
+{
+	if (vbuf->objs) {
+		if (fence)
+			virtio_gpu_array_unlock_resv(vbuf->objs);
+		virtio_gpu_array_put_free(vbuf->objs);
+	}
+	free_vbuf(vgdev, vbuf);
+}
+
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
 {
 	struct virtio_gpu_vbuffer *vbuf;
@@ -437,9 +456,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	int ret, idx;
 
 	if (!drm_dev_enter(vgdev->ddev, &idx)) {
-		if (fence && vbuf->objs)
-			virtio_gpu_array_unlock_resv(vbuf->objs);
-		free_vbuf(vgdev, vbuf);
+		virtio_gpu_drop_vbuf(vgdev, vbuf, fence);
 		return -ENODEV;
 	}
 
@@ -459,9 +476,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		 * synchronize_srcu() wait in drm_dev_unplug().
 		 */
 		if (vgdev->vqs_released) {
-			if (fence && vbuf->objs)
-				virtio_gpu_array_unlock_resv(vbuf->objs);
-			free_vbuf(vgdev, vbuf);
+			virtio_gpu_drop_vbuf(vgdev, vbuf, fence);
 			drm_dev_exit(idx);
 			return -ENODEV;
 		}
@@ -542,8 +557,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
 					     &sg_ents);
 			if (!sgt) {
-				if (fence && vbuf->objs)
-					virtio_gpu_array_unlock_resv(vbuf->objs);
+				virtio_gpu_drop_vbuf(vgdev, vbuf, fence);
 				return -ENOMEM;
 			}
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: aa41f7089456b709927a2d1d5480fdc2f0f2ec76
prerequisite-patch-id: 78c30e7ee8bc1e8d2c9e0626e8988a021d61b3bc
-- 
2.43.0

