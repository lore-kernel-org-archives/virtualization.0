Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0B0C07E96
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:51:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81E361260
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81E361260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86365405F2;
	Tue, 13 Jul 2021 10:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kmefOF9T9Xqb; Tue, 13 Jul 2021 10:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DBA8D40407;
	Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B95BC0023;
	Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91D72C001A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88CF5400F3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Su9ZwwACAud4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1245A4024F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:55 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id 62so21285892pgf.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EnYeCy+chnb7U/9RWgipxfZ5cRd0rbKv0JJVnp8Co5Y=;
 b=uQicnpu80puHC1nV5JPxVpt/PFOS7yVYWyaQTg4Uwxzc4iiZk+ry2Cx73baKppSbd4
 S1Wse1LRZHJlQ16GIA6bUJUSbYpSOzn2g3Kbqyhvhs1B1XsdFEjn64Q5XJh6cambq301
 z1PnI1cya47F89QVVf3lMh1zNiIO0ljJ4R03zP+/pRZ3uv3l+vQPtfdOSVgtAnwqNNzG
 7xluKvxfcU8k8H3ZRG8bRYBUyCRyVGEpQCp5uN8SS9iCJow6P+QZuIyXWtpIQu9UwS5C
 ZbspVAbJIVcxm3Bpk4dxPbudsz5ZfItF2VMrj72D+yM6NRLpOA4daWGQUW1YMimZPZEh
 uzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EnYeCy+chnb7U/9RWgipxfZ5cRd0rbKv0JJVnp8Co5Y=;
 b=OM7NiXdbZIPNwxzeWQm10hUQ4KF13u7PPJjs6LtvX9PbolFYgywYlrbihcKGJ1d1+o
 0ynnCxjrjXGrw2CB3+5UMW+KG1ntMVEgS2ZbJEJ78dDkPUbKLC37w2UN/Hj3f7VMoq5n
 sE7/uUsan3xjtZ0RjRJbqC7vevwHefJY1FF8EISYnvqnt5RnaiLirmkDihIBPis22UBN
 nELSRiVgYbnj/OxXib52+UHTNQO1my4CSKcVIZZryWMwfioFEuCOBuAe+q9vgR6AlIam
 cKAU6yOj7zo5fh/Bv48bK0cS8z5+dhXXVXhYYLCg3xX8AoKH7Pl9JBjHeHDUMmP3uwZT
 T/9A==
X-Gm-Message-State: AOAM533HoY6ToRxWbvUmiQ0CaOZoB1nW+AmtWi24HM1Bnds9f5AVUIqB
 FL0GMYN2nMyMMnNRMZ/j06qEJw==
X-Google-Smtp-Source: ABdhPJzFwJQQV87UPyudup1orSZesAxle9qt6HNR9V+7tkc+MisiAKwdUthQ6nJGgGCAmI7jR7v9Zg==
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr4096815pfh.73.1626173455525; 
 Tue, 13 Jul 2021 03:50:55 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id gb10sm2411155pjb.43.2021.07.13.03.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 03:50:55 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date: Tue, 13 Jul 2021 16:20:32 +0530
Message-Id: <e650cecb3bc6a0ed16eb37460ac57cb191ba92e4.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
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

i2c-virtio represents a virtio I2C device and this patch adds binding
for the same. The i2c-virtio subnode can be part of a virtio,mmio node
and is based on its binding.

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
new file mode 100644
index 000000000000..6b6538f9a3d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio memory mapped I2C Adapter
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+description:
+  Virtio I2C device, see /schemas/virtio/mmio.yaml for more details.
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+properties:
+  $nodename:
+    pattern: '^i2c-virtio@[0-9]+$'
+
+  reg:
+    description:
+      The cell is the device ID of the I2C device (VIRTIO_ID_I2C_ADAPTER) as per
+      dt-bindings/virtio/virtio_ids.h.
+    const: 34
+    $ref: /schemas/virtio/mmio.yaml#/properties/reg
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/virtio/virtio_ids.h>
+
+    virtio@3000 {
+        compatible = "virtio,mmio";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-virtio@0 {
+            reg = <VIRTIO_ID_I2C_ADAPTER>;
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
