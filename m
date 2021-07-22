Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5FAC6377D
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F1C61249
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F1C61249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17E5E40155;
	Thu, 22 Jul 2021 09:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQcca7gAHVGU; Thu, 22 Jul 2021 09:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91854400FC;
	Thu, 22 Jul 2021 09:57:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A278C0010;
	Thu, 22 Jul 2021 09:57:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49101C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37F39401D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jpmzhYUHmuUc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B9B1400D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:58 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 nt18-20020a17090b2492b02901765d605e14so3767201pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=muwPPr/wH77yClDsFJrEFYw3n7hGXGW3QcFllPO0brU=;
 b=n8ZC3AZw3jP2jJueB1RZMhR02tbalhWqKiFDjPykAogWMoM9xPPXZM/xXeT557iwV0
 zVxjo56XtoyPTXZ8dHUIGdZ0e5o9LsL9RZXeAHrIsa3vKQpuXZTfjQpIO2O74KzhGXSm
 ajmmB8uQiV8rYR/qUCw0LT+ue+IV0Jr8gpbssPKe7T01IU0QGDZ03V5pN2baNV47YW7g
 we02jklbUjKouKrsyHOvmp1DoGkFk5u6Yv14EDlWYZShNBF4I/Wd2BFKJu7eLZNtofoz
 5KeXpmJQBYvo7SWgXVkWNZVIaMsfLwqptLsh2DasM30eBzw+YOEAF2Z2hNOmnn0HwkuL
 v79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=muwPPr/wH77yClDsFJrEFYw3n7hGXGW3QcFllPO0brU=;
 b=b9jGIiwCna129AMqkvfDvLj/qK+7P9mto358KCE//aR4NFPNn9Lu7WUIM7g1Iuv9dE
 M0ZwifwmTEEVNKR/Gj3O5ilQwas4ii0kFCCIf+jZIuX23qCIxQ3fyYKi3UKlEEU6hPH3
 E9UaJPwQKFlO/VRIUsxjp64pTz4UjJXb3VRe2RWx4fXgVQ/fwMNZtmKn6e/WkEraeBwh
 IErDt7/csdWn6OBCBUCpJNX9dnu4CK7OsSN/DoG8YTJE5nKz+veRg3BocxSotDJFqNfT
 P1wY51RsK/oWG6pYqIWljzcuWqD6ZWXtz0UyVSsrHLXVHs4iPmw/tISzw4JG1Nj8Na+E
 I4BA==
X-Gm-Message-State: AOAM530LG0wbiqlAvXMYrXN25nHrJ3MPQP/NWxcbPS0/08hPGL37VUnk
 K0lV+pxzGf8CbHSNbCnFbwy2VA==
X-Google-Smtp-Source: ABdhPJyZN5CR9UcyY2gk0+/KtibNuktSAXGwPI2GxUo8LHTNu/01LbQ0OoVZsKSNKgm+Cc7KitP/dg==
X-Received: by 2002:a63:4d09:: with SMTP id a9mr40115746pgb.278.1626947817936; 
 Thu, 22 Jul 2021 02:56:57 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id u21sm29458630pfh.163.2021.07.22.02.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 02:56:57 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/5] dt-bindings: gpio: Add bindings for gpio-virtio
Date: Thu, 22 Jul 2021 15:26:41 +0530
Message-Id: <3257b21c1179b11a5c62a95e138735f2443c90aa.1626947324.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626947324.git.viresh.kumar@linaro.org>
References: <cover.1626947324.git.viresh.kumar@linaro.org>
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
