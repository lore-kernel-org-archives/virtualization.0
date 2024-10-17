Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC8A2D
	for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129371; cv=none; b=XiGz7nldf4sS3uQaFxf+YLrRmCizBv1u8FFy7PDn8AJbSfi1Ce9hxwcFzaeWTomV29pj6T7hS1CQYbvzXvGQgOX7OZrYatRlPqW9JAfa6qHaNKRIXxL8RT5+vBoHI+0pU7+dNn/2tCqS4//PaMUN17Yf7VB3jB6SyPdOjriSo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129371; c=relaxed/simple;
	bh=Ihb03p8vsMTn2RFebuAH9TF+e+1MH87AMFxn4/M1hQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MMPtyRZTyqGdPviTxGz7FLSzEzdWvnLt8J4HEqU6EjFX+cZuAQ6EAtFuLNlfcrMPMnV2ucNwYXDRR43rnYphS/lS7r6u4/zEp3hRgwxNLKWsclxKYoYgPUGZgRvMhgqM6L4dNNit7wWiaS5L0E0N4NwxZR0sH5xUGcWRCmRThLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XTVsb1hbszwW2H;
	Thu, 17 Oct 2024 09:40:51 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id CCE781400D4;
	Thu, 17 Oct 2024 09:42:44 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 09:42:44 +0800
From: Yuan Can <yuancan@huawei.com>
To: <lingshan.zhu@kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <xiao.w.wang@intel.com>,
	<tiwei.bie@intel.com>, <virtualization@lists.linux.dev>
CC: <yuancan@huawei.com>
Subject: [PATCH] vDPA/ifcvf: Fix pci_read_config_byte() return code handling
Date: Thu, 17 Oct 2024 09:38:12 +0800
Message-ID: <20241017013812.129952-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)

ifcvf_init_hw() uses pci_read_config_byte() that returns
PCIBIOS_* codes. The error handling, however, assumes the codes are
normal errnos because it checks for < 0.
Convert the error check to plain non-zero check.

Fixes: 5a2414bc454e ("virtio: Intel IFC VF driver for VDPA")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 472daa588a9d..d5507b63b6cd 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -108,7 +108,7 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
 	u32 i;
 
 	ret = pci_read_config_byte(pdev, PCI_CAPABILITY_LIST, &pos);
-	if (ret < 0) {
+	if (ret) {
 		IFCVF_ERR(pdev, "Failed to read PCI capability list\n");
 		return -EIO;
 	}
-- 
2.17.1

