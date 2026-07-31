Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C733537C8
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488559; cv=none; b=DC0iY1hua23uRoKbAjq0tF4ZP540SSGCJGD5M2EbGEOI9gXWTPOlRaMdxW33LwEwHFPs62YiDqOfAo7dBvGwwoD+odkuabKh8DS9tWvL1RlQTp3JdqE502bJKsg3i3w3Hc+H6JqH4JL42/s9XvIJw+GyjqYkWyTEzlf7em0n3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488559; c=relaxed/simple;
	bh=9Wu6ni//RDTH89qZ+fJlVozr4RuTN3CSIw7M8u4LoE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKmtEzXJFR4NiCoW2xlfEewAJl0KWec2Ackfcg0eCZDGeImWl9YR3kP3hbhnh6WNTNJ8C9++IFrSgJ23w8IkJ9RuevB7WhhHRV0n1sbmeygAlXkllAPE51lvskaO+KEeOhUmFsYXw5j2X3NMmEdx9w0T2ZiuTFEJLYfi2wzL49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dpaW7WGX; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dpaW7WGX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RXooLrgPteym4eqT+GWS7grT4yqXGxjvsdJATgOtNMM=;
	b=dpaW7WGXfikih8MbQkrpwT5ctXP4U5mcQIJmVRD8frdBwDBgk2cOjOBOf0TPKW52lv2X9z10o
	d5SVN1jJcdhBdnIwhlnBTIzMdDFO4NJC4J67cMPNfyUt+50bL3xXzX8NsjsZueCa8dgrW18qj8P
	GgavTYuXIrKBDNlP9cRa+7w=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hBKbF54hQz1prKd;
	Fri, 31 Jul 2026 16:52:57 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id F38112025F;
	Fri, 31 Jul 2026 17:02:27 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jul 2026 17:02:27 +0800
From: Yao Kai <yaokai34@huawei.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<liuyongqiang13@huawei.com>, <jifa@huawei.com>
Subject: [PATCH 1/2] drm/virtio: release object array when device is unplugged
Date: Fri, 31 Jul 2026 17:22:35 +0800
Message-ID: <20260731092236.2262403-2-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731092236.2262403-1-yaokai34@huawei.com>
References: <20260731092236.2262403-1-yaokai34@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr500006.china.huawei.com (7.185.36.185)

Unbinding virtio-gpu while fbdev damage work is active can leave the VMA
offset manager non-empty when the DRM device is released:

  Console: switching to colour VGA+ 80x25
  ------------[ cut here ]------------
  Memory manager not clean during takedown.
  WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown+0x28/0xc0
  Call Trace:
   drm_managed_release+0x95/0x130
   drm_dev_put+0x54/0x70
   virtio_dev_remove+0x3c/0x90
   device_release_driver_internal+0x19a/0x200
   unbind_store+0x9c/0xb0

The remaining node belongs to the fbdev GEM object:

  [drm:drm_mm_takedown] *ERROR* node [00100000 + 00000300]:
   drm_mm_insert_node_in_range+0x2bf/0x530
   drm_vma_offset_add+0x58/0x60
   __drm_gem_shmem_create+0x71/0x150
   virtio_gpu_object_create+0x41/0x3a0
   virtio_gpu_mode_dumb_create+0xdc/0x190
   drm_client_buffer_create_dumb+0x75/0xf0
   drm_fbdev_shmem_driver_fbdev_probe+0x8b/0x230
   __drm_fb_helper_initial_config_and_unlock+0x359/0x600
   drm_fbdev_client_hotplug+0x61/0xb0
   drm_client_register+0x5c/0x90
   drm_fbdev_client_setup+0xd6/0x1d0
   drm_client_setup+0x81/0xb0
   virtio_gpu_probe+0xd6/0x180

fbdev damage work can race with drm_dev_unplug(). It may build
vbuf->objs and take GEM references after the device has been marked
unplugged. drm_dev_enter() then fails, and the existing failure path
unlocks fenced reservations and frees the vbuffer without releasing the
object array. The unreachable array keeps the GEM object, and therefore
its VMA offset node, alive through device release.

Release the object array before freeing a control buffer rejected by
drm_dev_enter().

Fixes: b1df3a2b24a9 ("drm/virtio: add drm_driver.release callback.")
Cc: stable@vger.kernel.org
Reported-by: Ji Fa <jifa@huawei.com>
Signed-off-by: Yao Kai <yaokai34@huawei.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e5e1af8b8e8a..a470339b6747 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -383,6 +383,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	if (!drm_dev_enter(vgdev->ddev, &idx)) {
 		if (fence && vbuf->objs)
 			virtio_gpu_array_unlock_resv(vbuf->objs);
+		virtio_gpu_array_put_free(vbuf->objs);
 		free_vbuf(vgdev, vbuf);
 		return -ENODEV;
 	}
-- 
2.43.0

