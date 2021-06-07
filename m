Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4CDC47094
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 19:39:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289E8611BD
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 19:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289E8611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC916402D3;
	Mon,  7 Jun 2021 19:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OopBn9AXw-oq; Mon,  7 Jun 2021 19:39:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49333402D8;
	Mon,  7 Jun 2021 19:39:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C21EC000E;
	Mon,  7 Jun 2021 19:39:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 158BBC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBD5140179
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-04fsiGRUh0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:39:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0029D40171
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:39:30 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id v142so18799840oie.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Jun 2021 12:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oOu6y7k7gvZd3NLHH6tjzjQbm5rJW9mdNwcguV3ceu8=;
 b=MPsZIqTZSEktX7g/LCHAbVqJsiJqN14CA3NwNtnnKfW/NqiOg5M3L06wwUi6AU2MTX
 zhb4beYYo2JtT4rVBAM7LomjiHY/yEGOrCsgow12vs3U1MqpRnSLwQaPM0u2j1wY8n8w
 MEATNL2ZL1Obj9WN9hiyzPKCV9hrg+xyF/Jqu7/kRYY2BO4shtCtujOuMzN7I2IBgnDD
 U0TUFmFL1/2Yoh1aAhqGURodGHg2PLSBZCLWAUlqj1/HmheWxo7aFEEVxljonVVOWS5E
 Ba3wp0bD8c9WIybsWDvp9+eKZr4Lpiru9VyvQgY0hf8+rP6qvRvfUYPvp6S1oCidb962
 m0Fg==
X-Gm-Message-State: AOAM533vUct7k7nCraDP+ONQmszm9ykFXeuVjXTTWsytN8gwdNjxBcFO
 9aOswaau4rUUXVbU9lzhqg==
X-Google-Smtp-Source: ABdhPJy1JhjUryWudKnsLW7krc1Uq81vGLcMhgev+bY//vq2cMgyAxRFYH+SxAndyNHZTgnydxsn6Q==
X-Received: by 2002:a54:4684:: with SMTP id k4mr568744oic.20.1623094770024;
 Mon, 07 Jun 2021 12:39:30 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.googlemail.com with ESMTPSA id s6sm2540201otk.71.2021.06.07.12.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 12:39:29 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] dt-bindings: virtio: Convert virtio-mmio to DT schema
Date: Mon,  7 Jun 2021 14:39:28 -0500
Message-Id: <20210607193928.3092186-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.org>
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

Convert the virtio-mmio binding to DT schema format.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Jean-Philippe, hopefully you are okay with being listed as the 
maintainer here. You're the only active person that's touched this 
binding.

 .../devicetree/bindings/virtio/mmio.txt       | 47 ---------------
 .../devicetree/bindings/virtio/mmio.yaml      | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/virtio/mmio.txt
 create mode 100644 Documentation/devicetree/bindings/virtio/mmio.yaml

diff --git a/Documentation/devicetree/bindings/virtio/mmio.txt b/Documentation/devicetree/bindings/virtio/mmio.txt
deleted file mode 100644
index 0a575f329f6e..000000000000
--- a/Documentation/devicetree/bindings/virtio/mmio.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* virtio memory mapped device
-
-See https://ozlabs.org/~rusty/virtio-spec/ for more details.
-
-Required properties:
-
-- compatible:	"virtio,mmio" compatibility string
-- reg:		control registers base address and size including configuration space
-- interrupts:	interrupt generated by the device
-
-Required properties for virtio-iommu:
-
-- #iommu-cells:	When the node corresponds to a virtio-iommu device, it is
-		linked to DMA masters using the "iommus" or "iommu-map"
-		properties [1][2]. #iommu-cells specifies the size of the
-		"iommus" property. For virtio-iommu #iommu-cells must be
-		1, each cell describing a single endpoint ID.
-
-Optional properties:
-
-- iommus:	If the device accesses memory through an IOMMU, it should
-		have an "iommus" property [1]. Since virtio-iommu itself
-		does not access memory through an IOMMU, the "virtio,mmio"
-		node cannot have both an "#iommu-cells" and an "iommus"
-		property.
-
-Example:
-
-	virtio_block@3000 {
-		compatible = "virtio,mmio";
-		reg = <0x3000 0x100>;
-		interrupts = <41>;
-
-		/* Device has endpoint ID 23 */
-		iommus = <&viommu 23>
-	}
-
-	viommu: iommu@3100 {
-		compatible = "virtio,mmio";
-		reg = <0x3100 0x100>;
-		interrupts = <42>;
-
-		#iommu-cells = <1>
-	}
-
-[1] Documentation/devicetree/bindings/iommu/iommu.txt
-[2] Documentation/devicetree/bindings/pci/pci-iommu.txt
diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
new file mode 100644
index 000000000000..444bfa24affc
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/mmio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: virtio memory mapped devices
+
+maintainers:
+  - Jean-Philippe Brucker <jean-philippe@linaro.org>
+
+description:
+  See https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio for
+  more details.
+
+properties:
+  compatible:
+    const: virtio-mmio
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#iommu-cells':
+    description: Required when the node corresponds to a virtio-iommu device.
+    const: 1
+
+  iommus:
+    description: Required for devices making accesses thru an IOMMU.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        /* Device has endpoint ID 23 */
+        iommus = <&viommu 23>;
+    };
+
+    viommu: iommu@3100 {
+        compatible = "virtio,mmio";
+        reg = <0x3100 0x100>;
+        interrupts = <42>;
+
+        #iommu-cells = <1>;
+    };
+
+...
-- 
2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
