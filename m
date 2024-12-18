Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F581F931
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491557; cv=none; b=He4Y+KkMD9zw4Ycy5XDhvjZiTc8oWLI8bn2AmgRzZC4SxuOax/xWMTvkeRIla9wU4WIaKPp/VgD+/hqW/S6AoBMMnwTiJgBJezbG4F0mNxTn7PP3fqoU5qqipXdNX1IFglq1FX19O4XQy9xQ/AsfYz/bKCLJDD4PzAMMGwWEnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491557; c=relaxed/simple;
	bh=M1YFIBnEAGL4iYun/168E/pCBZDCohC2vG8p9/Mu/wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=En4vhQN9W4hdJK9wco6LNGP54fB5bQ8uwJpOLAxfgs3PzDZpRXR2Jr8Q0nZ8a5mBj5oGb2qZmaGnsx7gUx7v70JxYH72ridBBEGRoiljYvGfEDM/pGGMntr4OFCZt2WbJA5b1rsOycjeMSWfveZjZCtxpP3UNS4GVzDpGl87OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RotmdLRx; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RotmdLRx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jy6A0
	Cma7FA8Mc0GsrpEj8FXjIQ6ESmSb3IJInjwgPw=; b=RotmdLRxyYElWf/Wuk0di
	FLrZipjzPwj5pJP22ddXEYM2/eizy6XRDVsJTSy+V9eEBMHkL31ZU6HceyGL0c9s
	eVVwN+F4eDqTJPoQ8uW0IDMN4vEpMWkFWY0I3DRJge+QS3K4f+exDA93p5Jt0y3p
	RRNT0DpkMlqLf1NNCJgxdU=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHRwSKPWJn3r02BQ--.12880S4;
	Wed, 18 Dec 2024 11:12:24 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	zhangweiping@didichuxing.com,
	cohuck@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] virtio: fix reference leak in register_virtio_device()
Date: Wed, 18 Dec 2024 11:12:01 +0800
Message-Id: <20241218031201.2968918-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHRwSKPWJn3r02BQ--.12880S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy3ur4xKw4DWw45JryxZrb_yoWkWFg_tw
	409r92qr1UGa10yrZxAr4rZr1S9asFqFZxWr45tFykJ342vrWDXr1qqrn0qF1Uu3W7Cr4D
	JFW3Gws5Zw1fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNyxRDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizRi5C2diNI0PdgABsj

Once device_add(&dev->dev) failed, call put_device() to explicitly
release dev->dev. Or it could cause double free problem.

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: f2b44cde7e16 ("virtio: split device_register into device_initialize and device_add")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the bug description to make it more clear;
- changed the Fixes tag.
---
 drivers/virtio/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43b..ac721b5597e8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -503,6 +503,7 @@ int register_virtio_device(struct virtio_device *dev)
 
 out_of_node_put:
 	of_node_put(dev->dev.of_node);
+	put_device(&dev->dev);
 out_ida_remove:
 	ida_free(&virtio_index_ida, dev->index);
 out:
-- 
2.25.1

