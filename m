Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496CEC07E9A
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 11:40:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF28613B6
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 11:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF28613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B5F02401B8;
	Wed, 14 Jul 2021 11:40:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWrtbRrnylm6; Wed, 14 Jul 2021 11:40:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CCEF140191;
	Wed, 14 Jul 2021 11:40:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB264C0010;
	Wed, 14 Jul 2021 11:40:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6E34C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D587F60A78
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ODh3hsuPUR33
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:40:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEA6360A51
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 11:40:11 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id bt15so1390757pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yyUS8t31cKqvw5DoqN9PIZycxPq1uskR9MDa2Ni3Aec=;
 b=Pq4gZXCFYLDjGDfUtxIOaow0QXrcR3Pv1tV9I0/aK++LfP3MjqyHs1jnYA82u6tWOs
 xb/TR85T/0G+fV7zO+27ibm0ZuzSnk3PSG7REXZT2hT8fC1fpzw7w6vg+n/EZLrTMrY3
 rQohrM/I+fgFXgP9fxVj3MwLfabyxZYjSeO7ZzABU8VDA0QROI5kNUCqSH2TmS0NqYCY
 8+PSoisVRkIREzIg7Slmr2rbn4SRbLg8Ubn/36pBeviyNJglRGlHWIEkIi9r250kVFzR
 aygxVBzsub/VVbeGoKzvvo8WKhln4QXhEMb+9uq8mw45e3L0CW3ytxf123b1CWafRzMa
 r0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yyUS8t31cKqvw5DoqN9PIZycxPq1uskR9MDa2Ni3Aec=;
 b=IofkDXzRxd1PuCm8AqsSIunUuL6PQQpZdc6RGSVr+ur8EtGAeThtluyJmBbAyZb0lv
 i8gL7lcrFUqwI0BUiydVtSR2oC554qjgiO6h+DVVQLmFOXdoT5VEtSMG53n/IGe6Dpqb
 GA38uU1WDRY43PMnU7MfvUiVpv4XaJ07xbhV+giN1RN/eMStE3O3ynWUGGUSE0cExCRw
 jcONjRzet1kUY35/Q5S0AKtK68d0X93hDmB1wbdd2CXpdgtmvQ+/IuyxJwpPop36RhvP
 wGGCukvRYwIU/wHgm9N89E+U5NwLDl8x3joBfI5Tgpr5AWh6va3mmi3g8jiLPjAxPD58
 0niw==
X-Gm-Message-State: AOAM533UEpIhMIjiBXJDeVVa/K02nFgzZfvV8cnj58SC6pvEjkVMsMka
 3yUksAhEjh/TDqSTSpYXxAC7PQ==
X-Google-Smtp-Source: ABdhPJz5jWZHVkciRR7sUsbqJ34y1n/TslfC+AkDBDsyHKF9eXQucvzkd6lyxnhhb5j1+lldvd8JCQ==
X-Received: by 2002:a17:90a:ad89:: with SMTP id
 s9mr3468344pjq.86.1626262811098; 
 Wed, 14 Jul 2021 04:40:11 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id w69sm2601002pfc.58.2021.07.14.04.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 04:40:10 -0700 (PDT)
Date: Wed, 14 Jul 2021 17:10:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210714114008.kohvyz57fvrd7syu@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
 <20210714022630.d7vrazygmbooflcf@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210714022630.d7vrazygmbooflcf@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, DTML <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>
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

On 14-07-21, 07:56, Viresh Kumar wrote:
> I agree that even if the device is discoverable at runtime, we should
> still have some sort of stuff in DT to distinguish the devices, and
> "virtio,deviceDID" sounds good enough for that, considering that we
> already do it for USB, etc.
> 
> And I am fine with both the ways, a new node or just using the parent
> node. So whatever you guys decide is fine.

I tried to write and see what it would look like after using the
existing nodes for mmio/pci and here is what I got.  (I couldn't find
any virtio-pci bindings and so stayed away from adding any reference
to it here).

Does that look better ?

-- 
viresh

-------------------------8<-------------------------
diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index d46597028cf1..324b810e51a5 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -15,7 +15,8 @@ title: virtio memory mapped devices
 
 properties:
   compatible:
-    const: virtio,mmio
+    contains:
+      const: virtio,mmio
 
   reg:
     maxItems: 1
@@ -36,7 +37,7 @@ title: virtio memory mapped devices
   - reg
   - interrupts
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/virtio/virtio-device.yaml b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
new file mode 100644
index 000000000000..9cfe090ea65f
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
@@ -0,0 +1,49 @@
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
+allOf:
+  - $ref: /schemas/virtio/mmio.yaml#
+
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+select:
+  properties:
+    compatible:
+      contains:
+        pattern: '^virtio,[0-9]+$'
+  required:
+    - compatible
+
+properties:
+  compatible:
+    contains:
+      oneOf:
+        - items:
+          - const: virtio,mmio
+          - pattern: '^virtio,[0-9]+$'
+
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+    i2c: i2c-virtio@3000 {
+        compatible = "virtio,mmio", "virtio,34";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
new file mode 100644
index 000000000000..8115ba794557
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
@@ -0,0 +1,63 @@
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
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - virtio,41
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: virtio,mmio
+        - const: virtio,41
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
+    gpio: gpio-virtio@3000 {
+        compatible = "virtio,mmio", "virtio,41";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
new file mode 100644
index 000000000000..43e9910920d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
@@ -0,0 +1,54 @@
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
+# We need a select here so we don't match all nodes with 'virtio,mmio'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - virtio,34
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: virtio,mmio
+        - const: virtio,34
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c: i2c-virtio@3000 {
+        compatible = "virtio,mmio", "virtio,34";
+        reg = <0x3000 0x100>;
+        interrupts = <41>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@1c {
+            compatible = "dynaimage,al3320a";
+            reg = <0x20>;
+        };
+    };
+
+...
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
