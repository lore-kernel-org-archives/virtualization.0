Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1850264
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253755; cv=none; b=JI1vmAIgZA5cuv0nl6Y8HAw00m8Fq+cIFOuS9m/UPr/pAi7P0uilD4sIf+fl5PK7Ji7n6du3I+uHi2ajjXd8gVVHRdN8bFWjg0FViK1lixLvqVDAU6LFw92b4Vk8ohUvTQdneAuJI6Id5AvSs8Tjmv9waw9tR+L9MKBWlGzGFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253755; c=relaxed/simple;
	bh=diKU/La1qiUl2nog8mPuXVDl2pk/T/8iXWLuWQMQxZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZrpVNtVXw1qARLQ2ZtFn2WDuCOM/UG326624lDLOCvenLsKoahDLfcRSZp1cJ7IB/h9SrivPG/27YWA51ucFuk10qeJUgAvQGU7thfXmUhqNQeRf6GADGFaZnMvxyfQstf9RWLAJO4/8IAfaChmi6aFmsAentEAxOhVKRQD7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKdh4a4R; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKdh4a4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253754; x=1739789754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=diKU/La1qiUl2nog8mPuXVDl2pk/T/8iXWLuWQMQxZY=;
  b=kKdh4a4Re85BJxLHyb/7wRJNKPy8cReHqCQd1wqHL5/FDLdx+Sig8EmN
   ygV5ikeQqAse+UUVrcPZNv6FmcUZQvKHTTzV1Ex87o2jLOOvGEjwRevgG
   8HdvWWgR1EgiIA7p2KKtADGUng1GTMoeEC2KkitItookEyTf0drtXjKE7
   3Lphq2/vT8zZRXJNodwOdBXB0RWaJjv6YsqoD98Aons6dGybYKpNMQFgL
   40Mt1cL0Zyy1o2Isny/V4qB2c17g0fMCoDlOQt8/JWAyByLQGhpvGxTq5
   IfWihlXa8h7A60GS8hSZpV/DHLYJaOo5oq8LTA4f83rBJtrLHhxWng3nh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204668"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204668"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691654"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691654"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:51 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 08/10] vDPA: report virtio-block write zeroes configuration to user space
Date: Mon, 19 Feb 2024 02:56:04 +0800
Message-Id: <20240218185606.13509-9-lingshan.zhu@intel.com>
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

This commits reports write zeroes configuration of
virtio-block devices to user space, includes:
1)maximum write zeroes sectors size
2)maximum write zeroes segment number

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 23 +++++++++++++++++++++++
 include/uapi/linux/vdpa.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index bf3fa90908a7..adbcbc7b18b2 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1064,6 +1064,26 @@ static int vdpa_dev_blk_discard_config_fill(struct sk_buff *msg, u64 features,
 	return 0;
 }
 
+static int
+vdpa_dev_blk_write_zeroes_config_fill(struct sk_buff *msg, u64 features,
+				     const struct virtio_blk_config *config)
+{
+	u32 val_u32;
+
+	if ((features & BIT_ULL(VIRTIO_BLK_F_WRITE_ZEROES)) == 0)
+		return 0;
+
+	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_sectors);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC, val_u32))
+		return -EMSGSIZE;
+
+	val_u32 = __virtio32_to_cpu(true, config->max_write_zeroes_seg);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG, val_u32))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -1099,6 +1119,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_discard_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_write_zeroes_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 30887931a220..797d5708492f 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -68,6 +68,8 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEC,	/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_MAX_DISCARD_SEG,	/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
+	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

