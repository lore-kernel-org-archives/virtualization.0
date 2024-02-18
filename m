Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41350264
	for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253752; cv=none; b=qdDgLk9zK7r16Qr985UgGUoBHXuf03ZEqQ2XGCwnbWcCLc87yjtfQ9FKn4BL8aoBfjN2xezS2XQWWbv+ZYAbfoSdhg+VGsPnnN/9wrpbWEpVJstmBY+a8uyrg9tDdedys1Om+zhgVnrt2ttMs81g2Fi9YFqoQ2l2qg5se/IDQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253752; c=relaxed/simple;
	bh=59O93k57D+ytSzyO816SaewqX/X9PF3iROMB89FOs74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QDo8S1qJsaq8S+uzvOCZYrTtj+GnQBN3rnifnHVdDWw1/fqp77hoEfVQA8MLmqOtvGWarfLANQ9kW7oq2J1726Qj5qmZvQhd0Yf07mL34aa9bKyLUUHFAFSPTuLdrLFdfK+n4iHGIeTbCxb/VfDB0C29u7w82154qaY5Ode5KeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bq3Vhb2H; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bq3Vhb2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708253751; x=1739789751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=59O93k57D+ytSzyO816SaewqX/X9PF3iROMB89FOs74=;
  b=bq3Vhb2HdkdBHrcBztmywg67+rU1ObFVTWwPiAh5sagsplQAXwGaPpvN
   UBfqTGXH68OyC18dkP3G9Z+yyLkX1gJ9tOBZWvuhclSvDEGuMTASyT46Q
   TiSln3kvcexlN0vDpJ2rPOZtzxlV7UdlxxCb3G5k8Wv+mZAU6me3b99Og
   SQuGIpnGxzUNce+7HkW6bvubZ/w3qfmDkc6Pb4qRd6c6jI4LvctqZ4N97
   u4USsF8pyu0l8zEIVurT9hX2L3Vj2BV+UeYjRDZPTG/N0280MnPPKtdQF
   P5StfNVVu46mb4lYychHHQy5EXu85qzo2RJy2nqv50SXDqpWhQI0D+SqT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2204646"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="2204646"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="912691646"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="912691646"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 02:55:48 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 06/10] vDPA: report virtio-block topology info to user space
Date: Mon, 19 Feb 2024 02:56:02 +0800
Message-Id: <20240218185606.13509-7-lingshan.zhu@intel.com>
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

This commit allows vDPA reporting topology information of
virtio-blk devices to user space, includes:
1) the number of logical blocks per physical block
2) offset of first aligned logical block
3) suggested minimum I/O size in blocks
4) optimal (suggested maximum) I/O size in blocks

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/vdpa.c       | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/vdpa.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 26e8768b869a..dfd9aa5779dc 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -1012,6 +1012,35 @@ static int vdpa_dev_blk_mq_config_fill(struct sk_buff *msg, u64 features,
 	return nla_put_u16(msg, VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES, val_u16);
 }
 
+static int vdpa_dev_blk_topology_config_fill(struct sk_buff *msg, u64 features,
+				       const struct virtio_blk_config *config)
+{
+	u16 min_io_size;
+	u32 opt_io_size;
+
+	if ((features & BIT_ULL(VIRTIO_BLK_F_TOPOLOGY)) == 0)
+		return 0;
+
+	min_io_size = __virtio16_to_cpu(true, config->min_io_size);
+	opt_io_size = __virtio32_to_cpu(true, config->opt_io_size);
+
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_PHY_BLK_EXP,
+	    config->physical_block_exp))
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_ALIGN_OFFSET,
+	    config->alignment_offset))
+		return -EMSGSIZE;
+
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_BLK_CFG_MIN_IO_SIZE, min_io_size))
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_OPT_IO_SIZE, opt_io_size))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 				    struct sk_buff *msg)
 {
@@ -1041,6 +1070,9 @@ static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
 	if (vdpa_dev_blk_mq_config_fill(msg, features_device, &config))
 		return -EMSGSIZE;
 
+	if (vdpa_dev_blk_topology_config_fill(msg, features_device, &config))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 3c8e3c87a864..5cc70614c97a 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -61,6 +61,10 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
 	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
+	VDPA_ATTR_DEV_BLK_CFG_PHY_BLK_EXP,	/* u8 */
+	VDPA_ATTR_DEV_BLK_CFG_ALIGN_OFFSET,	/* u8 */
+	VDPA_ATTR_DEV_BLK_CFG_MIN_IO_SIZE,	/* u16 */
+	VDPA_ATTR_DEV_BLK_CFG_OPT_IO_SIZE,	/* u32 */
 
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
-- 
2.39.3

