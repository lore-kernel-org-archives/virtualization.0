Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F1815CD79
	for <virtualization@lists.linux.dev>; Tue, 17 Dec 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419858; cv=none; b=L2jP2lCNsL4HmRFvEjZSSTwet1XUKAjVVURZuey6rfgkazqjLJCGmSGC6X18HaIQEa4MGRNIqU7JLURyWktuWbp+x9UejulNagM9HCGQ4cRyUgWOlHMREZhj2mPEqrsO1YCSIIpxgQMeEv//YQVBqQ7hbTfZn3qWnVrIVwO7JJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419858; c=relaxed/simple;
	bh=Zrlk6LLf2G5/XLvrn/OJXQH8CFlPncDWlcWImq8hu8k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6Z6gzIsUcTK5P9O6IeWLX0ooEY8xBIljybRrdUViPkenUX2OgHTRz4Nvl1x+kyxk4MpTrknJHradnVXF46f4ZCj+LMyt0x1V+j2wsesq81bJ+mBIvTilINzks7HVwbHOSEE5jJss/fF/TABHxNNgDA7peWu7mb2lGqYU2WILXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=asPjhEeB; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="asPjhEeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B9qCC
	0utvM1hgVi7MOI0Z5r71VmyBlYIOULJl+wWQvs=; b=asPjhEeBKiDpIgGIXIBNO
	sOztCx5+mGHy/WMH5pIMOorDgedFdGNbUnven2JIBIWfLgd1Y/BpjA5BECGiNpG3
	ELobMjAtl5hVDwqCdYKPGyQchQhjWXCYp4jvWGlQYLXZ/C2AkifY75NCu3XIB7PP
	CW8sGoUkru/xHS8MkXn9Ik=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXDzR1JWFnhCKOBA--.64228S4;
	Tue, 17 Dec 2024 15:17:25 +0800 (CST)
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
Date: Tue, 17 Dec 2024 15:17:08 +0800
Message-Id: <20241217071708.2905142-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXDzR1JWFnhCKOBA--.64228S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr15GF4DCrW8try7Gw47CFg_yoWDJwbEgw
	1v9r93Xr48GF40yrW5Ar4rZrnayasrtan3Xr45tF93J3y2vF4DXrnrXrn8tF1Uu347Cr4D
	AF45Krs5Zw1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNyxRDUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQO4C2dhI2AwpwAAs3

The reference count of the device incremented in device_initialize() is
not decremented when device_add() fails. Add a put_device() call before
returning from the function.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: f2b44cde7e16 ("virtio: split device_register into device_initialize and device_add")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- modified the fixes tag according to suggestions;
- modified the bug description.
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

