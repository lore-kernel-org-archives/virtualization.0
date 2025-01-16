Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BC22BADF;
	Thu, 16 Jan 2025 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069797; cv=none; b=j72LsVWIAtDF+QjoRZshPWr6U2Okpk6MYwYN5nSn4LvcXjrX+VCOujM8RHWZtTWnFMaOyv2Mwj3KDbmm+pHEmZMkW6jrJeP0o+8NA8R7W9cyUsC/7y1Am9jHQVnHYY8A7E16FV66pMTwjvtGFO545TOK1ookEBUAmFzNptqZMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069797; c=relaxed/simple;
	bh=ONbSvt/X6XSuRpBg/kxhZca6Mzje0CmqRYDOxvJrZ+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+l8KeEr70OskVS47+A1WWfpJ9H7jzzI61ajcA+hBo/wUySzIqu5pHREpJJ40gcJnFKQYzkJ6hUYkQkwCtU/f7uvIjew2BpdzZYV9KbLywfEj7A2qA+S3sDyKuQ8MDOQMWENzUrtN2kAEsjj2j3VUVbovxXfMj2kQRHSRMVrxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fsY2vTPs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fsY2vTPs"
Received: from thinkpad-p16sg1.corp.microsoft.com (unknown [20.236.10.66])
	by linux.microsoft.com (Postfix) with ESMTPSA id 00E9220591AB;
	Thu, 16 Jan 2025 15:23:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00E9220591AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737069795;
	bh=bH78J9VP5ficnGV2dvBvEUQV0y++qVoeHqjErfV0eHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsY2vTPsopRlT2ivKJccsz24SyonfDNFDTJtw8mQp86qab/2OYgIJv4cfi6g957io
	 6kNe61Orz/E2fYfbuTokuulXEEB39uGSRqYBGsvA/UiNVIwp3P2tRgIAEJzFSyfSsk
	 sV7wfkaIeEvMZybLUmt51QezKGMG0Gg4b5gfh++w=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: will@kernel.org,
	jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com,
	code@tyhicks.com,
	eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH 1/3] dt-bindings: iommu: add "arm,smmu-pci-msi-iova-data" property
Date: Thu, 16 Jan 2025 15:23:07 -0800
Message-Id: <20250116232307.1436693-4-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
References: <20250116232307.1436693-1-shyamsaini@linux.microsoft.com>
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
"arm,smmu-pci-msi-iova-data" which can be used to hold custom
PCI MSI IOVA address and its address length. This property can be passed
to ARM SMMU drivers via device tree to reserve specified memory range
for MSI.

Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
---
 .../devicetree/bindings/iommu/arm,smmu-v3.yaml       | 12 ++++++++++++
 .../devicetree/bindings/iommu/arm,smmu.yaml          | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9f..dbad612886604 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -56,6 +56,17 @@ properties:
       NOTE: this only applies to the SMMU itself, not masters connected
       upstream of the SMMU.
 
+  arm,smmu-pci-msi-iova-data:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies a custom PCI MSI base I/O Virtual Address and its memory range
+      size for ARM SMMU drivers. This allows setting a custom address and
+      memory size pair if the default MSI_IOVA_BASE_DEFAULT address and
+      MSI_IOVA_LENGTH_DEFAULT size are not suitable for the intended platform.
+    items:
+      - description: MSI IOVA base address
+      - description: MSI IOVA address length
+
   msi-parent: true
 
   hisilicon,broken-prefetch-cmd:
@@ -92,4 +103,5 @@ examples:
             dma-coherent;
             #iommu-cells = <1>;
             msi-parent = <&its 0xff0000>;
+            arm,smmu-pci-msi-iova-data = <0xa0000000 0x100000>;
     };
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 032fdc27127bf..d080b13765d1f 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -207,6 +207,17 @@ properties:
       NOTE: this only applies to the SMMU itself, not masters connected
       upstream of the SMMU.
 
+  arm,smmu-pci-msi-iova-data:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies a custom PCI MSI base I/O Virtual Address and its memory range
+      size for ARM SMMU drivers. This allows setting a custom address and
+      memory size pair if the default MSI_IOVA_BASE_DEFAULT address and
+      MSI_IOVA_LENGTH_DEFAULT size are not suitable for the intended platform.
+    items:
+      - description: MSI IOVA base address
+      - description: MSI IOVA address length
+
   calxeda,smmu-secure-config-access:
     type: boolean
     description:
@@ -679,6 +690,7 @@ examples:
             #iommu-cells = <1>;
             /* always ignore appended 5-bit TBU number */
             stream-match-mask = <0x7c00>;
+            arm,smmu-pci-msi-iova-data = <0xa0000000 0x100000>;
     };
 
     bus {
-- 
2.34.1

