Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8172332CF7A;
	Tue,  9 Sep 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432777; cv=none; b=fhg/cTJbr37YhmNHGZLrrhFjdNIZcNTtl/iLDNsT4qNwOFxcO/T+QWb9YKxQZoDYdPb8bHV1BJsxFKmgakM5mMloiZs8iD320Uyyr/0KtlwfiF8aJIm/ZhZQlMShOHgyo2jNTkQchq4iL0Y7DFrf7UNIbVWZNri/Zca9qa/NmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432777; c=relaxed/simple;
	bh=jNxhQkc8hdtX4Jxr3ptiuzqe4gtZW9tZDz33fXOfPPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzyicJ/ssdl3hSynRPnk9dmlaPTCZj8d5tCKF+cygk0BtuCx023/j7ivG8tz9j0VVGpmtJ6jGamEKMnnr/790+dL+m46fv/efNTH4z3cuyweClFPQZPTJnIUsbaLtOUScEfr6PYNFNn45S/iaUkVnMNc80CjGYGrZi+De8Bd2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rUgCjrMF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rUgCjrMF"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id CB25E211AA0F;
	Tue,  9 Sep 2025 08:46:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB25E211AA0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757432768;
	bh=jtzDzkUv14rqdip4Y1gi77GlegBrcKG8mB/h5fAG9DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUgCjrMF9QQlMdbYFk8S6HEJ9YMMidqyd1MpKeSq2t53CdTLY9CXIIBtxDUa0nxIL
	 N0FwYY9UQxX8NllwXScpVYsyfL6NneVprceN7kbS9/DpmKZHZdeozj0DGUGpWhiMcN
	 dF1aNlaRRlwpqflEAX2VO5aAKQsBjgEBOuW7Nsgg=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: thierry.reding@gmail.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	joro@8bytes.org,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com,
	saravanak@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lizhi.hou@amd.com,
	clement.leger@bootlin.com
Subject: [PATCH v4 1/4] arm-smmu: move MSI_IOVA macro definitions
Date: Tue,  9 Sep 2025 08:45:57 -0700
Message-Id: <20250909154600.910110-2-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSI_IOVA* are common among different iommu/smu drivers,
so move them to common iommu.h header file.

Suggested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ---
 drivers/iommu/virtio-iommu.c                | 2 --
 include/linux/iommu.h                       | 3 +++
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc38402..16f5856b4c0e2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -505,9 +505,6 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define ARM_SMMU_POLL_TIMEOUT_US	1000000 /* 1s! */
 #define ARM_SMMU_POLL_SPIN_COUNT	10
 
-#define MSI_IOVA_BASE			0x8000000
-#define MSI_IOVA_LENGTH			0x100000
-
 enum pri_resp {
 	PRI_RESP_DENY = 0,
 	PRI_RESP_FAIL = 1,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4ced4b5bee4df..4a07650911991 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -50,9 +50,6 @@
  */
 #define QCOM_DUMMY_VAL -1
 
-#define MSI_IOVA_BASE			0x8000000
-#define MSI_IOVA_LENGTH			0x100000
-
 static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index b39d6f134ab28..f3d830656cf29 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -24,8 +24,6 @@
 
 #include "dma-iommu.h"
 
-#define MSI_IOVA_BASE			0x8000000
-#define MSI_IOVA_LENGTH			0x100000
 
 #define VIOMMU_REQUEST_VQ		0
 #define VIOMMU_EVENT_VQ			1
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473d..09a35af5a545d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1554,6 +1554,9 @@ static inline void iommu_debugfs_setup(void) {}
 #endif
 
 #ifdef CONFIG_IOMMU_DMA
+#define MSI_IOVA_BASE        0x8000000
+#define MSI_IOVA_LENGTH      0x100000
+
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
-- 
2.34.1

