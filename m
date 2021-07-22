Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC5C63793
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:57:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157D861248
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157D861248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D89C240375;
	Thu, 22 Jul 2021 09:56:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7d3yhWkvKcTq; Thu, 22 Jul 2021 09:56:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E9A44031E;
	Thu, 22 Jul 2021 09:56:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23421C0010;
	Thu, 22 Jul 2021 09:56:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F492C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 810B94031E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LqbUnQB9QI9H
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 88B784035B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:55 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id n11so3860178plc.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LFAzq1cRRdIrI+QwSGEpAIXO66croLV9YsUkTYMA32Q=;
 b=PsrOoWAkqh6dkfonRpDr/SK5Ku7QwJrkh6mKhluNLjg5DjbVNMFlGXZw4a7YGAkdZm
 UqZJ8F2/JN9Ph8FlGK0B9aVzABv+AR24uG84Bn1qAu8XaJ1M5OVR/QU/EQq6/M1+tNeM
 3i6uxRk5VLJvwL4DIigV3L50d0zf6f688z3RfxIgjWnMZ1eyHAREjpjPyJvNnZfwi5Qa
 Fa8EFUYBur8UmwAJnSel2XjzEGfUyx+qiIr3RbHM7qIShqzQMJpH4fyq/A4lRdKWhsvR
 bDrmM4NSQTn28JrQDtrJuFT+9dO59RUp8+HluBSYizWcrftarjvpZw7b7z/17eDM8Dmi
 cEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LFAzq1cRRdIrI+QwSGEpAIXO66croLV9YsUkTYMA32Q=;
 b=QuWowWOhsjJuTn6Af+8lLB53Rgzmt//xGr99VfbiYMQfoaAFj4tikxRZZsywVXINJc
 GVWI6DzbXrv9bGDs6sB79xzwb8GVBOELN9RL9W4aujW1VYsny0A1nPI0/O7VkK5pRRfZ
 5jtYSQNbfNZxTJ6aGmiAxFEuhdtZKX/LPQrC9jFKSkUqwI5olR9oa8f3gsriWEVCNVw4
 txexIGIC/nUONRwghuENUVYAQFdbx2rsSO86Bhw/BbYlX8qaCLAfSD+R1kHI36paAhAk
 sQWdQoqYwrlKEhTqEGkq8DFtDSkelXUZHuwq48EhnNeaev+Fkxik2AHDWGGqKYD/Z5BG
 30cQ==
X-Gm-Message-State: AOAM532DPCkvcSMxn88Y9K6JlKwPwn0vUTBbJ32TDmgk1Y2vl54+IKXZ
 gcjJPshsUwikMzaJIWnDcbGx3A==
X-Google-Smtp-Source: ABdhPJze27vHgBf6eiFDra5TYfTzpjUkBnln1aIygHD9XY8Tsdi4Y9Lf6xpc29kX3KftmTw+79L18w==
X-Received: by 2002:a17:90a:bf88:: with SMTP id
 d8mr39945553pjs.222.1626947815074; 
 Thu, 22 Jul 2021 02:56:55 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id l10sm6274768pjg.11.2021.07.22.02.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 02:56:54 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date: Thu, 22 Jul 2021 15:26:40 +0530
Message-Id: <705f4426a17a395bf190ee6ed6c341ac25550f6b.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626947324.git.viresh.kumar@linaro.org>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org, "Enrico Weigelt, metux IT consult" <info@metux.net>
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

This patch adds binding for virtio I2C device, it is based on
virtio-device bindings.

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
new file mode 100644
index 000000000000..0381d9065287
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio I2C Adapter
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+description:
+  Virtio I2C device, see /schemas/virtio/virtio-device.yaml for more details.
+
+properties:
+  $nodename:
+    pattern: '^i2c-virtio(-[a-z0-9]+)?$'
+
+  compatible:
+    const: virtio,22
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        i2c-virtio {
+            compatible = "virtio,22";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            light-sensor@1c {
+                compatible = "dynaimage,al3320a";
+                reg = <0x20>;
+            };
+        };
+    };
+
+...
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
