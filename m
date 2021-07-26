Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C4DC4320A
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 04:52:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26C160F0F
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 04:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E26C160F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF64160609;
	Mon, 26 Jul 2021 04:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 97GdOR-3fGjg; Mon, 26 Jul 2021 04:52:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4EBD66078B;
	Mon, 26 Jul 2021 04:52:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18673C001A;
	Mon, 26 Jul 2021 04:52:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6BA8C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 890338350A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UOlMIs4F-DlR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 873A582EF1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:09 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id n10so10268312plf.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=muwPPr/wH77yClDsFJrEFYw3n7hGXGW3QcFllPO0brU=;
 b=ycpwrBVDwGd3Ld3v1W5tGdLHkVB1bJPYN1wrP6W6KB0X3EJPQBADk6S/2yCJy6YoIb
 CMjXIMA7JeZJrWSHKQIeMbTDlKhkex5g3KPI99HW0FUzbflO2F8JG/DSxOvg3Vr9oMx5
 +3FJjFdZbbzEvubq3LP0cjPPk43QYpjvukKxiqn3TQZoyQF72iOSJYLR/+gT7+tNMxES
 EzOMkKRg48/0AcFriy2csYJHtgUtDVH+ZMJ5R5K4mDm5kuuPJ/b8B639fKzbd10hCmTD
 zwOyEwPH0mmxUadbtLGlt0JD1DI9QBKl8jEfeGZPXdE3CgVRdrJIRizl1hhyN4xs9QdV
 nwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=muwPPr/wH77yClDsFJrEFYw3n7hGXGW3QcFllPO0brU=;
 b=cjcJM9MlTnq1mecEsKMeyZs06oX1EXG22Y0uukfut6b3niawE5G5MvigCofvPSchKc
 5pD0oYpVcC+eXrcchXkoT8yHMPIg3Rm7DqZpkJjFAdY+10kMi9Rq9QczVMIStFtG5d+7
 WmgNqf1UVJyIEGDnI3esNcuOCnZLTVfwUSDHZL2L6opxMwMZr3oEleO2T/Pv4apC1VoJ
 8NjulxonUmAGPtHRCieygHGIz1UqG9fC/2zQsa+EsTs/qNdz7pyfuhn0Q0egp39RuSyU
 xXKa+sTPvuWNRDRtr4jWepMy7x4BGdJR+pLmaNGSZY2O/X76kSDSLaOp+MlYu7PgJ+k1
 5Isg==
X-Gm-Message-State: AOAM533mTyCbOxLHG3i8qPoF5Dav46b6DExbonsIiBEZA4KKMrAT8RHi
 ZZy88N/eBJ97WDeCdhfjKGgWbA==
X-Google-Smtp-Source: ABdhPJywYWAbpqqkEOa/qttwkvPQCjhdQ454v7qZzG2V+o1+YfpG93FpHj+tl77I79vdxChXD9nrXA==
X-Received: by 2002:a17:902:9046:b029:12c:e88:429c with SMTP id
 w6-20020a1709029046b029012c0e88429cmr5300973plz.77.1627275128984; 
 Sun, 25 Jul 2021 21:52:08 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id z5sm16448583pgz.77.2021.07.25.21.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 21:52:08 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
Date: Mon, 26 Jul 2021 10:21:43 +0530
Message-Id: <605b87ce93b9a528810a5857984bfe6b913d5e73.1627273794.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627273794.git.viresh.kumar@linaro.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 "Enrico Weigelt, metux IT consult" <info@metux.net>
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

This patch adds binding for virtio GPIO controller, it is based on
virtio-device bindings.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/gpio/gpio-virtio.yaml | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
new file mode 100644
index 000000000000..96108cfb7a08
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtio GPIO controller
+
+maintainers:
+  - Viresh Kumar <viresh.kumar@linaro.org>
+
+allOf:
+  - $ref: /schemas/gpio/gpio.yaml#
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+description:
+  Virtio GPIO controller, see /schemas/virtio/virtio-device.yaml for more
+  details.
+
+properties:
+  $nodename:
+    pattern: '^gpio-virtio(-[a-z0-9]+)?$'
+
+  compatible:
+    const: virtio,29
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+required:
+  - compatible
+  - gpio-controller
+  - "#gpio-cells"
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
+        gpio: gpio-virtio {
+            compatible = "virtio,29";
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
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
