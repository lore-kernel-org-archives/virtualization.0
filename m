Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5C188CA7
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103510; cv=none; b=TQCX6gIgrUr+z+UTeo8kGJ7ps+VeHtIRTVdzPMrx2h6Wz/0xUkzkNReWgLS1ItQXl67rw3jfcAdtyD3YWYRMkAMkaoROEFli91qAdckvcWZ1SsrFjb2mikeqq3j/mBAzyRzmR7xq0rzd9kIhWFSCjKaC6GoBkgO2hJkSquyaoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103510; c=relaxed/simple;
	bh=OiUqUtOQipDrumMss3QUV7sLIjOMyu4LKIKFiuv06FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZepSXk3S7I/ClL82U6bJqhTTQTg7AVgklEgu1PwMDhOKhUWI8fZ9g3F3E7aUXb4PfvGk1IOXNvDJocI2LLTJEymUasNePW03cQQs1Zs4d64tdORb5gOzpH3XsDLwrGeVUWwYK5MEtlAkaVmFNLXHvlwUUtkobfAN7DNodc5h70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Auxl7oDI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Auxl7oDI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723103509; x=1754639509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OiUqUtOQipDrumMss3QUV7sLIjOMyu4LKIKFiuv06FQ=;
  b=Auxl7oDINnWxNIgI7ezM7eVGbyYFIM2q1I4E6UGndz3/+PqWLN+XW0lR
   WMBApJWq+zooEHhxi+QWflgSLqicCVbqQ4m9snZKcPZqHafnF9h1q2hlT
   VjaAS5dZ3em/FopWe408JMYnW4Vr1ME1fFK5uTQeI1O3cK9zxT9HXMEda
   7fEQE+4rtYM2qcWcNhgsAR6tSVB61La6PDmIgrxrVn9uQRJjoJo59rFuA
   ivXDWutHirRHIdLfQiNwaVrKTV/BDkLpmq941F+uYCPjmLNttT1NirYb1
   LLWfiTIDh+648AjJOCIvZt/QI1t2gCIoLu3gbP9wQtfUOcYVHH+RrMMa0
   Q==;
X-CSE-ConnectionGUID: ayuP9YUtTL6+ToiYfk9eNw==
X-CSE-MsgGUID: LTHxLjqKRyKpfCWxkqgQeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="46615956"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="46615956"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:51:49 -0700
X-CSE-ConnectionGUID: P9PTDdDrQ4uvSAVMHhjNQg==
X-CSE-MsgGUID: RrDR6Z4vRDeHNsEeKhDicQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="61978459"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 08 Aug 2024 00:51:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 029C9206; Thu, 08 Aug 2024 10:51:44 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: [PATCH] virtio: Remove virtio devices on device_shutdown()
Date: Thu,  8 Aug 2024 10:51:41 +0300
Message-ID: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
accesses during the hang.

	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
	...

It was traced down to virtio-console. Kexec works fine if virtio-console
is not in use.

Looks like virtio-console continues to write to the MMIO even after
underlying virtio-pci device is removed.

The problem can be mitigated by removing all virtio devices on virtio
bus shutdown.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
---
 drivers/virtio/virtio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a9b93e99c23a..6c2f908eb22c 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+static void virtio_dev_shutdown(struct device *_d)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	if (drv && drv->remove)
+		drv->remove(dev);
+}
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
 	.uevent = virtio_uevent,
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
+	.shutdown = virtio_dev_shutdown,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
-- 
2.43.0

