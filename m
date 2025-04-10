Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA220D503;
	Thu, 10 Apr 2025 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744325437; cv=none; b=K+DeJsnYr5dOXSYxWfkHoemEZRe5+ikON4inzwXqPR9Fz2eRLw5oFYmtv7uoNZZruOsHmTN4TPu44ZO5AGUdi7LyUuUnjieUucYco1f2ST66S+65WUmScm0a5Q4mbLyO3JyA8ygfjmvgCDb9OpkYoVFyc2pFbwzrVPIIVnHwSFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744325437; c=relaxed/simple;
	bh=mOGKzLmsK/mvL+LgegeFZz6E4aD8kIxt8kxbHDVQVds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FINj16XiLgLvXG0nS2NF5fugdaOoChtzFvQLh6QuQJOs2PW8dqPmSbehHvIqk8iTz1zGiDBlZvMFeACBf7L82mYrgvsR8TDL6sVlN9023bAJ+RpNpaXrL2vhaz1OcoP7P38zzW95TuR6nCDLyfTUUNwqG+UH7gf5j54+nmkU6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kwuSM8mR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kwuSM8mR"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9CA892114DAD;
	Thu, 10 Apr 2025 15:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CA892114DAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744325435;
	bh=f4tDEWmcrI3cttYgef9jFAuJ7VDRpJ9tPVO1HUepdXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwuSM8mR5JE4ONOWRVD4F+0ZI8CKWi0X9AIXlxQavBUj+CMQu61nL5G4hCRbJTQLU
	 lLOQDPgLc2pgplhXcklE+vRd9iKNQ1lXAAl/Qj0zzBNLnUczOOf5mbvV0fhNqXpgRK
	 C396TsxzLDab0H9tEE7N8LxPqbrtxoqBf6EGQvPM=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: jgg@ziepe.ca,
	will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH v2 2/3] dt-bindings: iommu: add "arm,smmu-faulty-msi-iova" property
Date: Thu, 10 Apr 2025 15:50:29 -0700
Message-Id: <20250410225030.2528385-3-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
References: <20250410225030.2528385-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default ARM SMMU drivers use MSI_IOVA_BASE macro to reserve
PCI MSI IOVA memory range, this assumes that all the platforms have
MSI_IOVA_BASE address available for MSI reservation. However, this
is not always the case, as some platforms may have the default
address reserved for some other purposes and as a consequence ARM SMMU
drivers can't reserve MSI memory for those platforms.

To address this issue, add a new dts property
"arm,smmu-faulty-msi-iova" which can be used to hold faulty MSI IOVA
address. This property can be passed to ARM SMMU drivers via device
tree so that the drivers can select appropriate MSI IOVA base address
which doesn't intersect with the faulty MSI IOVA address.

Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml | 8 ++++++++
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9..13b615ca38e1 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -56,6 +56,13 @@ properties:
       NOTE: this only applies to the SMMU itself, not masters connected
       upstream of the SMMU.
 
+  arm,smmu-faulty-msi-iova:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specifies a faulty PCI MSI base I/O Virtual Address. If this is passed
+      via dts then arm SMMU driver appropriately select suitable MSI_IOVA base
+      which does not intersect with faulty MSI IOVA passed in this dts property.
+
   msi-parent: true
 
   hisilicon,broken-prefetch-cmd:
@@ -92,4 +99,5 @@ examples:
             dma-coherent;
             #iommu-cells = <1>;
             msi-parent = <&its 0xff0000>;
+            arm,smmu-faulty-msi-iova = <0x8000000>;
     };
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 7b9d5507d6cc..1aba9d59d495 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -208,6 +208,13 @@ properties:
       NOTE: this only applies to the SMMU itself, not masters connected
       upstream of the SMMU.
 
+  arm,smmu-faulty-msi-iova:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Specifies a faulty PCI MSI base I/O Virtual Address. If this is passed
+      via dts then ARM SMMU driver appropriately select suitable MSI_IOVA base
+      which does not intersect with faulty MSI IOVA passed in this dts property.
+
   calxeda,smmu-secure-config-access:
     type: boolean
     description:
@@ -680,6 +687,7 @@ examples:
             #iommu-cells = <1>;
             /* always ignore appended 5-bit TBU number */
             stream-match-mask = <0x7c00>;
+            arm,smmu-faulty-msi-iova = <0x8000000>;
     };
 
     bus {
-- 
2.34.1

