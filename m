Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798426A08F
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782356534; cv=none; b=X+8twSTKKALgh1asvr9Ep4796nC4TwHde/9IaXZyWvAUwHdrU8gR+0dRjeTnopvHlo18CUzspa1BGrrHZzPwETXE3e3vxZCuwizHu2nhiz/Y823ytMJ6vACj3YJWMBR4prnSbCIAvFvnlBWN/yh4Fcw7upwHMVYQhGNySyefkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782356534; c=relaxed/simple;
	bh=Ul7tF3v5ZCiw4hHEfoIUXgzn4b3JNcT8aytpm3Xh3t0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tf1/msaKdZ2PO9QlyUPethVq2sKjg2bczxX8kmhD5+3LiN3PIM121CeXwWrJdplffR6mpGeaaLZqP0P1szAMPG82wlJVdtVb1xEomp6xYANWYajLiNQi2Lh2PFGRXuHrrRkBdz9DYXZXDoQ5r24KsnmW1roH1PhEEtwNs956lEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACXO9Qsmjxq_kEkAw--.51729S2;
	Thu, 25 Jun 2026 11:02:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] drm/virtio: fail init on display-info timeout
Date: Thu, 25 Jun 2026 11:02:02 +0800
Message-ID: <20260625030202.82590-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXO9Qsmjxq_kEkAw--.51729S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4kCryfAFW8JFy7Kw4DArb_yoW8XF48pF
	47GFyayrW3Aa9rKayrAF18uF98uasaka1xGr9xu345Kwn8Ar17Gr90kFyjvry7ZFZ7Ar4x
	tF4kur4Du3Z5uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOlkVUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

virtio_gpu_init() sends GET_DISPLAY_INFO when scanouts are present and
waits for display_info_pending to clear. If the response never arrives,
the wait result is ignored and probe still succeeds.

Return -ETIMEDOUT on display-info timeout. Because this happens after
virtio_device_ready(), reset the device and tear down modesetting before
using the existing vbuf and virtqueue cleanup path.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index cfde9f573df6..31209bea97ae 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -262,11 +262,19 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 			virtio_gpu_cmd_get_edids(vgdev);
 		virtio_gpu_cmd_get_display_info(vgdev);
 		virtio_gpu_notify(vgdev);
-		wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
-				   5 * HZ);
+		if (!wait_event_timeout(vgdev->resp_wq,
+					!vgdev->display_info_pending,
+					5 * HZ)) {
+			DRM_ERROR("timed out waiting for display info\n");
+			ret = -ETIMEDOUT;
+			goto err_ready;
+		}
 	}
 	return 0;
 
+err_ready:
+	virtio_reset_device(vgdev->vdev);
+	virtio_gpu_modeset_fini(vgdev);
 err_scanouts:
 	virtio_gpu_free_vbufs(vgdev);
 err_vbufs:
-- 
2.50.1 (Apple Git-155)

