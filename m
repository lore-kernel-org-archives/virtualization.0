Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0669FECAAD8
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 07:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71EBB83E52;
	Fri, 23 Sep 2022 07:52:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71EBB83E52
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x1m7c9FB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zyVBq3ZJ3ukX; Fri, 23 Sep 2022 07:52:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 977E482AB6;
	Fri, 23 Sep 2022 07:52:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 977E482AB6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA0BC0033;
	Fri, 23 Sep 2022 07:52:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB10C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52B354177E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:52:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52B354177E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=x1m7c9FB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sMTqRuM-Kf0S
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:52:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7B5E4156E
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7B5E4156E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:52:16 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id cc5so19125894wrb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 00:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=5OTJLPTHaCGUvxTLzQpX9KkfWgyXUXuxIB5BfRQ2its=;
 b=x1m7c9FB2/aG357kotIOofarUV5AJycibbv0fUUoWZJeVTfnQH/MIzMT6EXnNi2ctJ
 jUv3wFiTpjQ5VhjFEzPJTDC/FvoEDtjSMiMamcK6YYkyJnW8+EN9atDCEJqROh5/YX/N
 WCLc3fI5mKElNSS/XwD2pYU9mcOZ4e9nU3HLHfOJSoKjfcwpV9e99NRTc8UjNxTZSQ1f
 cnmNn0yPoZ25IW49lgPPjQAkkYbdr7f52IX2BMgXYX2ZS9v312aucw3Kiw4a+uyScsZ9
 otiHlWNHW60WGy+9nCrv8kEQoVpEt+SexqvjZNIJnd6Wj7hZBD2wiIj5Igjd/ebYlC6T
 OhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=5OTJLPTHaCGUvxTLzQpX9KkfWgyXUXuxIB5BfRQ2its=;
 b=vzr0dferlYsz0TWgipueSFaI/Xqp3g5psw0/e6RHeyUY76NUCT6Rxn8cg7ocWLcEeM
 ERdBF5/qxV3ScZYEPE187IlhNlwKWECXobOte2qQ7VCZTZpWQPYSwESylROeyFSQyZLo
 WqaWjZQNZ78B3tr2LbQE4rO0AUGSSsS/aKZTK2fq75kQfoCNleKELjge/GTgtHUjEEKU
 paVOMnyUYftyujZzQ30gg9tK5X7PkEMQY2PrueXTp0ATChC6pwWiZ4wtfcQGcf1fHOcB
 F+7PyGjWFTw7aiNEE36zEe4j9Y/sEzK2EECYAUTWOBlv0Vgo2oCwKT4rq0SnM3MWDX5k
 JUqw==
X-Gm-Message-State: ACrzQf3qdye1CcLrPHOUQErZTlRRqYy+xORlLZeeB3sMM7Nc3H0xNHLO
 Jd8RKFX7C3Om/yroYNco23wZ1A==
X-Google-Smtp-Source: AMsMyM5K0BL3MUCQCX1SoMJdGVMS00+U0AY6LIti26t6MQPtQ9C3GKO8ZB2URqjLBBsBFou6vC/jIw==
X-Received: by 2002:a05:6000:80a:b0:229:4632:d1d1 with SMTP id
 bt10-20020a056000080a00b002294632d1d1mr4510716wrb.73.1663919534600; 
 Fri, 23 Sep 2022 00:52:14 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c19cf00b003a2f2bb72d5sm2089319wmq.45.2022.09.23.00.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Sep 2022 00:52:14 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v3] dt-bindings: virtio: Convert virtio, pci-iommu to DT schema
Date: Fri, 23 Sep 2022 08:44:38 +0100
Message-Id: <20220923074435.420531-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Convert the binding that describes the virtio-pci based IOMMU to DT
schema. Change the compatible string to "pci<vendor>,<device>", which is
defined by the PCI Bus Binding, but keep "virtio,pci-iommu" as an option
for backward compatibility.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v3: Renamed file and type to pci-iommu
v2: https://lore.kernel.org/linux-devicetree/20220922161644.372181-1-jean-philippe@linaro.org/
---
 .../devicetree/bindings/virtio/iommu.txt      |  66 ------------
 .../devicetree/bindings/virtio/pci-iommu.yaml | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 Documentation/devicetree/bindings/virtio/pci-iommu.yaml

diff --git a/Documentation/devicetree/bindings/virtio/iommu.txt b/Documentation/devicetree/bindings/virtio/iommu.txt
deleted file mode 100644
index 2407fea0651c..000000000000
--- a/Documentation/devicetree/bindings/virtio/iommu.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-* virtio IOMMU PCI device
-
-When virtio-iommu uses the PCI transport, its programming interface is
-discovered dynamically by the PCI probing infrastructure. However the
-device tree statically describes the relation between IOMMU and DMA
-masters. Therefore, the PCI root complex that hosts the virtio-iommu
-contains a child node representing the IOMMU device explicitly.
-
-Required properties:
-
-- compatible:	Should be "virtio,pci-iommu"
-- reg:		PCI address of the IOMMU. As defined in the PCI Bus
-		Binding reference [1], the reg property is a five-cell
-		address encoded as (phys.hi phys.mid phys.lo size.hi
-		size.lo). phys.hi should contain the device's BDF as
-		0b00000000 bbbbbbbb dddddfff 00000000. The other cells
-		should be zero.
-- #iommu-cells:	Each platform DMA master managed by the IOMMU is assigned
-		an endpoint ID, described by the "iommus" property [2].
-		For virtio-iommu, #iommu-cells must be 1.
-
-Notes:
-
-- DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
-  virtio-iommu node doesn't have an "iommus" property, and is omitted from
-  the iommu-map property of the root complex.
-
-Example:
-
-pcie@10000000 {
-	compatible = "pci-host-ecam-generic";
-	...
-
-	/* The IOMMU programming interface uses slot 00:01.0 */
-	iommu0: iommu@0008 {
-		compatible = "virtio,pci-iommu";
-		reg = <0x00000800 0 0 0 0>;
-		#iommu-cells = <1>;
-	};
-
-	/*
-	 * The IOMMU manages all functions in this PCI domain except
-	 * itself. Omit BDF 00:01.0.
-	 */
-	iommu-map = <0x0 &iommu0 0x0 0x8>
-		    <0x9 &iommu0 0x9 0xfff7>;
-};
-
-pcie@20000000 {
-	compatible = "pci-host-ecam-generic";
-	...
-	/*
-	 * The IOMMU also manages all functions from this domain,
-	 * with endpoint IDs 0x10000 - 0x1ffff
-	 */
-	iommu-map = <0x0 &iommu0 0x10000 0x10000>;
-};
-
-ethernet@fe001000 {
-	...
-	/* The IOMMU manages this platform device with endpoint ID 0x20000 */
-	iommus = <&iommu0 0x20000>;
-};
-
-[1] Documentation/devicetree/bindings/pci/pci.txt
-[2] Documentation/devicetree/bindings/iommu/iommu.txt
diff --git a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
new file mode 100644
index 000000000000..972a785a42de
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/pci-iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: virtio-iommu device using the virtio-pci transport
+
+maintainers:
+  - Jean-Philippe Brucker <jean-philippe@linaro.org>
+
+description: |
+  When virtio-iommu uses the PCI transport, its programming interface is
+  discovered dynamically by the PCI probing infrastructure. However the
+  device tree statically describes the relation between IOMMU and DMA
+  masters. Therefore, the PCI root complex that hosts the virtio-iommu
+  contains a child node representing the IOMMU device explicitly.
+
+  DMA from the IOMMU device isn't managed by another IOMMU. Therefore the
+  virtio-iommu node doesn't have an "iommus" property, and is omitted from
+  the iommu-map property of the root complex.
+
+properties:
+  # If compatible is present, it should contain the vendor and device ID
+  # according to the PCI Bus Binding specification. Since PCI provides
+  # built-in identification methods, compatible is not actually required.
+  compatible:
+    oneOf:
+      - items:
+          - const: virtio,pci-iommu
+          - const: pci1af4,1057
+      - items:
+          - const: pci1af4,1057
+
+  reg:
+    description: |
+      PCI address of the IOMMU. As defined in the PCI Bus Binding
+      reference, the reg property is a five-cell address encoded as (phys.hi
+      phys.mid phys.lo size.hi size.lo). phys.hi should contain the device's
+      BDF as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be
+      zero. See Documentation/devicetree/bindings/pci/pci.txt
+
+  '#iommu-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@40000000 {
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x0 0x40000000  0x0 0x1000000>;
+            ranges = <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0x0f000000>;
+
+            /*
+             * The IOMMU manages all functions in this PCI domain except
+             * itself. Omit BDF 00:01.0.
+             */
+            iommu-map = <0x0 &iommu0 0x0 0x8
+                         0x9 &iommu0 0x9 0xfff7>;
+
+            /* The IOMMU programming interface uses slot 00:01.0 */
+            iommu0: iommu@1,0 {
+                compatible = "pci1af4,1057";
+                reg = <0x800 0 0 0 0>;
+                #iommu-cells = <1>;
+            };
+        };
+
+        pcie@50000000 {
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            reg = <0x0 0x50000000  0x0 0x1000000>;
+            ranges = <0x02000000 0x0 0x51000000  0x0 0x51000000  0x0 0x0f000000>;
+
+            /*
+             * The IOMMU also manages all functions from this domain,
+             * with endpoint IDs 0x10000 - 0x1ffff
+             */
+            iommu-map = <0x0 &iommu0 0x10000 0x10000>;
+        };
+
+        ethernet {
+            /* The IOMMU manages this platform device with endpoint ID 0x20000 */
+            iommus = <&iommu0 0x20000>;
+        };
+    };
+
+...
-- 
2.37.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
