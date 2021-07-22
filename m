Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C48C6377D
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:56:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4FE6124B
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4FE6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54FAB608B0;
	Thu, 22 Jul 2021 09:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YwFTJY1cwI6v; Thu, 22 Jul 2021 09:56:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02EAB60649;
	Thu, 22 Jul 2021 09:56:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D39B2C0010;
	Thu, 22 Jul 2021 09:56:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEE2FC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCB2B40270
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T-IyDGqGNHLt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4C704031E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:52 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id h1so3835233plf.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
 b=rT0HWshXd8nGdtBqoZiI1S6Ws0VED0exTJOCWSfoURsHS8z0r1DP8kKfEqDzoWRlCk
 ZpyIVRq+7RxtvnBpF/zFFE08CrsMw0EhoJ8nRM8PVPIFOJnTWplPOoWfAKmDYHL4ujnR
 3qZlBy11EOkr7TNC6WkFIFv6XipygWZq0ACOPDtoAr+XVYhtSL04jKJm0PkgN42byHQy
 muaFvdyDV4bPBFwvtEIjNXV1HqZq2mXzlKkRLmkE3nLc2AXBt2V7XXKO2YmSQp4Fqn2O
 gZtBiljKKyxV6gOGkmJs1WN/00aAbmkNE/HBT/pch6yzRemSo64jG3TXfnuqM2Z39Dal
 zlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
 b=Zi5z+NCmpjBSo8pMGxQTgZpOVh+CGWeejUF+ZoAmqEgaUkpgz7xOdqZZuWOYxuYO7b
 1goZAZrRCdFiR+NPlQ6Xv8EZEL/n8F9xtFAoOB/D+GF2vnx/bM3rV4Ii0uU5FXGjhM7a
 E0D87P/0duyJ4xSGJHfY8q6t/O5dK85ZGnDgQ6drUu56qYCu2kY2Me3dyimkNzggFAk2
 dW0G8QURxBJUfJicdW0CKhtZUZ2daJsPKVfIUTURXlljcCdTDGUfIKsNTNumSLbZdj3G
 +fAk3aN7fpDWNLvKg8NjJXTzFxr9lLLSSYqdD/UGN35zvQFWdrSVXKIEbsAOQ/HHPT52
 h/WA==
X-Gm-Message-State: AOAM533uX0RIyAe6RaaGiof0rLxOxdBaPQd6qmAAKjHsJnKbzDAOODh9
 LY/Kl8lQu8jLgSbp5ncasCqlNA==
X-Google-Smtp-Source: ABdhPJzpK4LcdQ7DS4Wei+znEiWyuGaIxO/4odGAGPJsdCKZayHrfSHrgCHCp3fGr5RCDH5CY+jD2Q==
X-Received: by 2002:a17:90a:d598:: with SMTP id
 v24mr37859955pju.185.1626947812304; 
 Thu, 22 Jul 2021 02:56:52 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id j21sm24845767pjz.26.2021.07.22.02.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 02:56:51 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/5] dt-bindings: virtio: Add binding for virtio devices
Date: Thu, 22 Jul 2021 15:26:39 +0530
Message-Id: <fced2f2b9dcf3f32f16866d7d104f46171316396.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626947324.git.viresh.kumar@linaro.org>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

Allow virtio device sub-nodes to be added to the virtio mmio or pci
nodes. The compatible property for virtio device must be of format
"virtio,<DID>", where DID is virtio device ID in hexadecimal format.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/virtio/mmio.yaml      |  2 +-
 .../bindings/virtio/virtio-device.yaml        | 47 +++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index d46597028cf1..1b91553f87c6 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -36,7 +36,7 @@ title: virtio memory mapped devices
   - reg
   - interrupts
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/virtio/virtio-device.yaml b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
new file mode 100644
index 000000000000..15cb6df8c98a
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/virtio/virtio-device.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio device bindings
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+description:
+  These bindings are applicable to virtio devices irrespective of the bus they
+  are bound to, like mmio or pci.
+
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+properties:
+  $nodename:
+    pattern: '^[a-z0-9]+-virtio(-[a-z0-9]+)?$'
+    description: |
+      Exactly one node describing the virtio device. The name of the node isn't
+      significant but its phandle can be used to by a user of the virtio device.
+
+  compatible:
+    pattern: "^virtio,[0-9a-f]+$"
+    description: Virtio device nodes.
+      "virtio,DID", where DID is the virtio device id. The textual
+      representation of DID shall be in lower case hexadecimal with leading
+      zeroes suppressed.
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <43>;
+
+        i2c-virtio {
+            compatible = "virtio,22";
+        };
+    };
+...
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
