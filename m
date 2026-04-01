Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279E2E7F25
	for <virtualization@lists.linux.dev>; Wed,  1 Apr 2026 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023971; cv=none; b=uBkXj4XeOH8XFMQxzTwUd3h39/Nn2rKZiQaSee/d4EiHlHb0wLTloW7ysem3016Q4aTg3uFxYE/fCihkLsRzWPXbJcp4edgW2IIzyIPsAb3TWnQGEmKavC37e9uGlXF/575O4uKMpcT92ENYoofo5y/ZVw43T7bTvxD0PwPSMMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023971; c=relaxed/simple;
	bh=O34xXC6QS7UiPkBldM6k/wxVN2A+cLQXDvRFHgsdE5Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdXOM0DxPOd3fpW4LaBfMfGdpmYwWAa+U0TzpFNPqg7UKt6Jvwp75/IrbK2iw7IoqJTxoIu1UQGykrI/vzbuUxB3+BjCePxuxFiEVm5uISLpGmFeI0CesRAX3jQ/LCm4+P0dHkQp7UPAs3Yxss0FF+Lg/RgFFyxWyw1gFUk1K5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r7LMFFwo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r7LMFFwo"
X-UUID: caea3e462d9111f19a16598d5ca7f8ec-20260401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2W14g40vqxna88foZFfsDI/an1hpSc2sZgoHE3Dhm/0=;
	b=r7LMFFwoZbYg1nBnVhoTIOKmmqNq91f6VF/rSCRbOXnXtiJ4IXpIXYRKrT73+SXE9awog/iGGw58jV3ivWOBPY5wZdHvqWzeWimh6FaGbw4bGem8wLDM9hz93yHWkPNaWZeQQNXCSrkOJrdT3GuC8dnvI94e7s3BrOyZoPgUSmM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:60da354d-eeaa-436a-a70c-e3453edb1a46,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:c1c15fd5-060f-4ecc-9ee0-121eeeb4a682,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: caea3e462d9111f19a16598d5ca7f8ec-20260401
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <morris.pan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 110947584; Wed, 01 Apr 2026 14:12:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 1 Apr 2026 14:12:41 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 1 Apr 2026 14:12:41 +0800
From: Morris Pan <morris.pan@mediatek.com>
To: <airlied@redhat.com>, <kraxel@redhat.com>, <dmitry.osipenko@collabora.com>
CC: <srv_heupstream@mediatek.com>, <gurchetansingh@chromium.org>,
	<olvaffe@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <simona@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, Morris
 Pan <morris.pan@mediatek.com>
Subject: [PATCH] drm/virtgpu: Add PM support for suspend/resume
Date: Wed, 1 Apr 2026 14:10:50 +0800
Message-ID: <20260401061050.1035881-1-morris.pan@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add freeze/restore callbacks to handle system suspend/resume.
During freeze, delete virtqueues and reset device.
During restore, reinitialize virtqueues and mark device ready.

Signed-off-by: Morris Pan <morris.pan@mediatek.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 40 +++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..fbca0a82958c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -145,6 +145,40 @@ static void virtio_gpu_config_changed(struct virtio_device *vdev)
 	schedule_work(&vgdev->config_changed_work);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int virtgpu_freeze(struct virtio_device *vdev)
+{
+	vdev->config->del_vqs(vdev);
+	virtio_reset_device(vdev);
+
+	return 0;
+}
+
+static int virtgpu_restore(struct virtio_device *vdev)
+{
+	int ret;
+	struct virtqueue *vqs[2];
+	struct drm_device *dev = vdev->priv;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtqueue_info vqs_info[] = {
+		{ "control", virtio_gpu_ctrl_ack },
+		{ "cursor", virtio_gpu_cursor_ack },
+	};
+
+	ret = virtio_find_vqs(vdev, 2, vqs, vqs_info, NULL);
+	if (ret) {
+		DRM_ERROR("failed to find virtio queues\n");
+		return ret;
+	}
+
+	vgdev->ctrlq.vq = vqs[0];
+	vgdev->cursorq.vq = vqs[1];
+	virtio_device_ready(vdev);
+
+	return 0;
+}
+#endif
+
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_GPU, VIRTIO_DEV_ANY_ID },
 	{ 0 },
@@ -172,7 +206,11 @@ static struct virtio_driver virtio_gpu_driver = {
 	.probe = virtio_gpu_probe,
 	.remove = virtio_gpu_remove,
 	.shutdown = virtio_gpu_shutdown,
-	.config_changed = virtio_gpu_config_changed
+	.config_changed = virtio_gpu_config_changed,
+#ifdef CONFIG_PM_SLEEP
+	.freeze = virtgpu_freeze,
+	.restore = virtgpu_restore
+#endif
 };
 
 static int __init virtio_gpu_driver_init(void)
-- 
2.45.2

