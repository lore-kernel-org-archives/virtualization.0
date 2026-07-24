Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204441D212
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885889; cv=none; b=lDx73pZF0FDP/RzeDYo9gUt1XjYqlHU8tbvGsiErjXJF4ssANyLfG6fdz8CkIhvCPaVYAEQgROd5h+WWBf9sRGIQTTGL9W9j74WFIF5QrGTDBXk53WHjoYuO84mhYJuGrOtiM9jS/9tF8KIqLwhnJ8MI2huvRn5mGiqwV6t0hjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885889; c=relaxed/simple;
	bh=XyRy16Ejp6cluVl+XrR3WtFTUNWzS/pRplxgqs30iLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1lACF1thtlfi5MvePXkkFWJyj+1btNECPi88sAojzq3IYxKenGG1kt9txK030TzlGg9bt8ZG0aXUaeIAoX85Tssy1jPlR/alBndMFSsNfa8KDvXzMwa24AO1qj35IXAzkTB/28aERQ4l+KLXQho9hEqnZurD6rEk1NZEv9qK3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NRgTfxh0; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NRgTfxh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tQ
	MTIxoYrelHX8Jqxj2vSJnnEKo5gsE1tXu7qnSMN1Q=; b=NRgTfxh0dR+uwTXld3
	FG3EGWqkhkmvbx/Qsta+gEiVI03XhSbpAAh8/dAF1tIN0hBjnDhTg1LG3FjJ/6y9
	YTDJfXQZh9dDKIFgGTUIxfab33gvM3biNOZwu6q6Xa95Yl4IPg8tetmxBLoyzbwA
	Ry9rTt/SVEGb/Hp+4YDUmawTI=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA3D6V3MmNq+dVkHg--.9949S3;
	Fri, 24 Jul 2026 17:37:59 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH 3/3] hw/virtio: Add error handling for vhost_virtqueue_mask failure
Date: Fri, 24 Jul 2026 17:37:59 +0800
Message-ID: <20260724093759.810108-2-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724093759.810108-1-xiongwm2026@163.com>
References: <20260724093759.810108-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA3D6V3MmNq+dVkHg--.9949S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF45tF1fXr1DJr17JF4xJFb_yoWfKFX_ZF
	1Uu3s7Ww4qkFn0kFsrCF15Zr18Ka1DGFyUWFsYkr1kZw1DJw15G34vyrnrGF4xurs09Fy3
	uw4kuryqqr1S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeZNVPUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8BcdrGpjMndHYAAA39

From: Xiong Weimin <xiongweimin@kylinos.cn>

In vhost_virtqueue_start(), the call to vhost_virtqueue_mask() has a
TODO comment indicating errors are not handled. Add proper error
checking and propagate errors to the caller.

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/virtio/vhost.c | 10 +++++++--
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1467,9 +1467,13 @@ static int vhost_virtqueue_start(struct VirtIODevice *vdev,
      * will do it later.
      */
     if (!vdev->use_guest_notifier_mask) {
-        /* TODO: check and handle errors. */
-        vhost_virtqueue_mask(dev, vdev, idx, false);
+        int r = vhost_virtqueue_mask(dev, vdev, idx, false);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_virtqueue_mask failed");
+            r = -1;
+            goto fail;
+        }
     }
 
     if (k->query_guest_notifiers &&

