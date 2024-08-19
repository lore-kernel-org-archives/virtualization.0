Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE716132F
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076736; cv=none; b=TxhhZ8lLoe8iI7h2T3zwjmPa/CU+63zW8gjq9qcUO7QLDos7gN6rvI6ukZdwZUcj++cVxliEauBoWFlvWrR4wDF6vhFBG40ihH7r+vfLk818Gq7/5MmEL+bZ+Djs2ejF5VZ7U9ms1BnooUDRGXCyggHHBAM4PURlKggWXViC64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076736; c=relaxed/simple;
	bh=ikNtBVm4suV+DfgBlZNcZWbXHwtst49HFL/I4U2o3tc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=umvJ3ZFpOmsD6CXKCw3Wz2kYUlm3nR4R8CJH2KSdLlbIDvG93vWaMdMqgWE6faWMvXJmbX29x9a2gMP8tSTntZIxUQKgUTRg8A5ec2W3mgMNlaeKCvMZhtzRb4nQcsOukVei/UTy5QClFtg4dHs8jiC1EPOnEl92tbqRMfGQ0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnZJ16VkwzpSw2;
	Mon, 19 Aug 2024 22:10:41 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7825D140159;
	Mon, 19 Aug 2024 22:12:10 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 22:12:09 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <lingshan.zhu@kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>,
	<shannon.nelson@amd.com>, <yuehaibing@huawei.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] vdpa: Remove unused declarations
Date: Mon, 19 Aug 2024 22:09:30 +0800
Message-ID: <20240819140930.122019-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

There is no caller and implementation in tree.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.h | 3 ---
 drivers/vdpa/pds/cmds.h         | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index 0f347717021a..aa36de361c10 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -112,15 +112,12 @@ void ifcvf_write_dev_config(struct ifcvf_hw *hw, u64 offset,
 			    const void *src, int length);
 u8 ifcvf_get_status(struct ifcvf_hw *hw);
 void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
-void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
 void ifcvf_reset(struct ifcvf_hw *hw);
 u64 ifcvf_get_dev_features(struct ifcvf_hw *hw);
 u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
 int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
 u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
 int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
-struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
-int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
 u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
 u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector);
 u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector);
diff --git a/drivers/vdpa/pds/cmds.h b/drivers/vdpa/pds/cmds.h
index e24d85cb8f1c..6b1bc33356b0 100644
--- a/drivers/vdpa/pds/cmds.h
+++ b/drivers/vdpa/pds/cmds.h
@@ -14,5 +14,4 @@ int pds_vdpa_cmd_init_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
 			 struct pds_vdpa_vq_info *vq_info);
 int pds_vdpa_cmd_reset_vq(struct pds_vdpa_device *pdsv, u16 qid, u16 invert_idx,
 			  struct pds_vdpa_vq_info *vq_info);
-int pds_vdpa_cmd_set_features(struct pds_vdpa_device *pdsv, u64 features);
 #endif /* _VDPA_CMDS_H_ */
-- 
2.34.1

