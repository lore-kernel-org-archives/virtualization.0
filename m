Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A1C432BE
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 04:52:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5559060F4D
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 04:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5559060F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FAC282B5E;
	Mon, 26 Jul 2021 04:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p8c_BPPMLz_q; Mon, 26 Jul 2021 04:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C869682C8F;
	Mon, 26 Jul 2021 04:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A49D5C001A;
	Mon, 26 Jul 2021 04:52:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 751A7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 634CE82C8F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egst3fzJe3Hy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A55C782B5E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:02 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 g23-20020a17090a5797b02901765d605e14so12495872pji.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 21:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
 b=ZNxdofEazuCanYJelkULP0+4OuqXw2vw2lLc6piV+972Mo2ZMLPaKvvgt0IeKeeOz4
 qfs1uZUtM4SK2si8JRoCdtymsO11GLCcE3dvHNw2RvTb81Op5nV3XSybxbruXjNV/k6U
 uiyQKL2dOkyLbTmCQBvIoJtmU76+bBYUQVsrfwV3/4etV2OplljWvUKFedVvS7S4tLz6
 qPuZ+xPD58dVHGWU4gnH8urTbFlJBUS+bsnPJyDWy308Hc2jbeOdFnFrxxxWDgIdduZj
 VPVm09fCKAnFZMjSZUk7opAUFtgLYbqIHx32jSDW934DBT3Vwqk5DlaMbp1F2DzXks5/
 bL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BKW8SJUXD86+uZHpTY6dXOSgo09YOklrbve/i0ZpdAI=;
 b=PefnARSSNsnt+P2POXa63RgBgsSpffnwQLe3QYCymFA4POqXkLCWYCEEZp/xjJBIx4
 u1kemTssU65UcGRTCVWNX2XxzkSsENE5MOKUHyD3e8IPHYtPxI+RdFzLENMGOdiOrMfM
 yVVZ0yXwAhRlaG129aXLq9qWsrVMboY7opxijgZbM9HZxpr6L6ykKwMjhLYFa7qblIxR
 vVEmmeC4lTLluOK7aIFxjAMalct1Jw3PdnPoEpksqwSrxlggwirFlVqRlzd4w6DB/EdH
 3B6kSxwRM9rxAqxixNiafRlQlcgRF+AVRoII1eAmsIBuHuyehpgvCTypHqwVBkPETjVJ
 8vXQ==
X-Gm-Message-State: AOAM533yKD2DGI9oCGVGR9GW42joMfpg6kJSWC+K3Nlo1eON81vEmcay
 xYPqWFJDgLGr6+YniRE9EkrUuQ==
X-Google-Smtp-Source: ABdhPJwh6XJFEYFMK7YevFdXoJw8PPRK9tlakcKK8pDpbEwvvOlo+Oz2Ts8NSM0+usN9h6aj3YsOuw==
X-Received: by 2002:aa7:9687:0:b029:337:3b49:df24 with SMTP id
 f7-20020aa796870000b02903373b49df24mr15887381pfk.35.1627275122181; 
 Sun, 25 Jul 2021 21:52:02 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id t26sm45725593pgu.35.2021.07.25.21.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 21:51:57 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 1/5] dt-bindings: virtio: Add binding for virtio devices
Date: Mon, 26 Jul 2021 10:21:41 +0530
Message-Id: <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627273794.git.viresh.kumar@linaro.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
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
