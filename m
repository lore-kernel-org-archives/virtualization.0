Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E67EADB
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253744; cv=none; b=H01okzfouhoFDUAsX721rZT5RG4tJnaC2enl1V1ssV7D2fFQ+eFdMtFk0rSFdwLyrkTGOfCF7M8TSOeVp4c/Sua+PXJco5JPHPrs0pU2UuJ14/zC9Cmt7DuHr9Z3mCznVZI8gdMLQ1BisyTyHyYYOW0ILisR3826TJ4a/n5L76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253744; c=relaxed/simple;
	bh=bjnc09Ts+tiD4qx8FN1UFUstAZq26XpSx4CEuqKf7MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/Y87A37VSW4D99HRcdJalnDjFIrp+j6Y92iUMsQOGbOZRIJedaj5oH5xPKg6q8aBjZ65if0KzKPDb1iVBLDBRH/yrOdrsh0AeG9u43c3xKrgCxgFPweAioTDWsd+QNjW4SWeqF7Nn8tELxBJOtk1EVBfduVLZHsWWOoZ/N+xOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QA87ytOA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QA87ytOA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253743; x=1739789743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bjnc09Ts+tiD4qx8FN1UFUstAZq26XpSx4CEuqKf7MM=;
  b=QA87ytOArCZZjT6w7HqR1DVPy9oyiCNfKS5iWhtnt5nTccy5eLZNBJ1i
   nNnyknsKuLjLe2MugqExpTKCO/j7O4cFvqLGFsl0mKa3o4RYleTjJb8y9
   tj6FuVLoS9vqMEOF28xlN3+83bVtDQVLSawWffvaaV7SipODE7Y6S/5xQ
   TaklGkWtQ7PcRrhl+UghsT/3cF1kDSt4FnP5c/+S4alFsTR4KdKmfYAWI
   L188yKl8KO/5lvU9uhgB+RnLyJedsTB7maIY6ttrj0L25ySBpQVqhxRnz
   22gbUJE35gLhE1R/TW80c4qa/4IQP/OfwoCqbBD+tRdl5bc9G4istCw+i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204612"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691618"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691618"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:39 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 01/10] vDPA: report virtio-block capacity to user space
Date: Mon, 19 Feb 2024 02:55:57 +0800
Message-Id: <20240218185606.13509-2-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240218185606.13509-1-lingshan.zhu@intel.com>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit allows userspace to query capacity of
a virtio-block device.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |  1 +
 include/uapi/linux/vdpa.h |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index d0695680b282..d5ccb618de2b 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -944,6 +944,38 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
 	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
 }
 
+static int
+vdpa_dev_blk_capacity_config_fill(struct sk_buff *msg,
+				  const struct virtio_blk_config *config)
+{
+	u64 val_u64;
+
+	val_u64 = __virtio64_to_cpu(true, config->capacity);
+
+	return nla_put_u64_64bit(msg, VDPA_ATTR_DEV_BLK_CFG_CAPACITY,
+				 val_u64, VDPA_ATTR_PAD);
+}
+
+static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
+				    struct sk_buff *msg)
+{
+	struct virtio_blk_config config = {};
+	u64 features_device;
+
+	vdev->config->get_config(vdev, 0, &config, sizeof(config));
+
+	features_device = vdev->config->get_device_features(vdev);
+
+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
+			      VDPA_ATTR_PAD))
+		return -EMSGSIZE;
+
+	if (vdpa_dev_blk_capacity_config_fill(msg, &config))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int
 vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
 		     int flags, struct netlink_ext_ack *extack)
@@ -988,6 +1020,9 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
 	case VIRTIO_ID_NET:
 		err = vdpa_dev_net_config_fill(vdev, msg);
 		break;
+	case VIRTIO_ID_BLOCK:
+		err = vdpa_dev_blk_config_fill(vdev, msg);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index db15ac07f8a6..a184aa6538cb 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -7,6 +7,7 @@
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
 #include <linux/virtio_net.h>
+#include <linux/virtio_blk.h>
 #include <linux/if_ether.h>
 
 /**
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 54b649ab0f22..1bf69226cb96 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -56,6 +56,8 @@ enum vdpa_attr {
 	/* virtio features that are provisioned to the vDPA device */
 	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
 
+	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
+
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
-- 
2.39.3

