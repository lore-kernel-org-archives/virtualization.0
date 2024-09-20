Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538E4D8D0
	for <virtualization@lists.linux.dev>; Fri, 20 Sep 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823535; cv=none; b=r8BLU3lSz83GlNSA7T9lZSsEWDYZL/2om3uEdnoEF7AZwC/awciLBUl6VdAmPPt/8dBEhYhBFgayoiYS94CZcARAAJTn4TAfOsBGwWyDqOB3ChEXp9kwjcXntnPp0CUVOfPuavK6/Hkmjxh+TASqyK5ufISN4TYX0yhGp5kJHVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823535; c=relaxed/simple;
	bh=6JzuYeb24Kmaxy7umZRplSMqeLZL1onFukYnl7n11Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUTYEr6IBfUyoppuZTZqMyJWXi+/TLUtvjVQgcfxEZI6VtxJwwssmqmK2pCRbHnRekCmD9CRQgtny6Ky4xDoB0f2APNM2SQgRqMaGBCknE1ElcYaksjg1O8dTe8BSWEKOIQW9/GYtEt7iR36okCvW/PwCbxN/+FJZTlzeIKHldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UW3Uoyo8; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UW3Uoyo8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726823530; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QOOB9wRRaHtT9YTqQvwjC7TRokT5tIh8RHto7Jjb4GA=;
	b=UW3Uoyo8Gsq1GvkkRm7tV29yc/Lq23eHQJmkv85DqQ8qNdGrXZAXWXqDcRXcD62nQvZE76ZPZ748BOEvrhPzhidLCXaD19U/wyNZswiyOlgzis/W94++zLr5F523bksFn3TM/7kQhsLvuY1baug9zyMFow4lhhXxbeW5e5Sll9c=
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0WFKdz4I_1726823212)
          by smtp.aliyun-inc.com;
          Fri, 20 Sep 2024 17:06:53 +0800
From: Eryu Guan <eguan@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH] virtio-pmem: reset device before delete vqs on device removal
Date: Fri, 20 Sep 2024 17:06:49 +0800
Message-Id: <20240920090649.42295-1-eguan@linux.alibaba.com>
X-Mailer: git-send-email 2.26.1.107.gefe3874
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should not update virtqueue status while device is in DRIVER_OK
status, so reset device first then delete vqs.

Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 drivers/nvdimm/virtio_pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index c9b97aeabf85..55ffb0e6976b 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -139,8 +139,8 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
 	struct nvdimm_bus *nvdimm_bus = dev_get_drvdata(&vdev->dev);
 
 	nvdimm_bus_unregister(nvdimm_bus);
-	vdev->config->del_vqs(vdev);
 	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
 }
 
 static unsigned int features[] = {
-- 
2.26.1.107.gefe3874

