Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB2AC4320A
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65C2610A1
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B65C2610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87F7B83806;
	Tue, 27 Jul 2021 05:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zVjkZ9fiptVC; Tue, 27 Jul 2021 05:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5015B837DA;
	Tue, 27 Jul 2021 05:24:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36B34C0010;
	Tue, 27 Jul 2021 05:24:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95307C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83DD3607D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BOQCG5eh9M6b
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCB1C605EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:09 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 a4-20020a17090aa504b0290176a0d2b67aso2504412pjq.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xHUwfXrMCktpWTFh8tgPEYEudq0so6k6jsU7prpKKxM=;
 b=IUw/yKaT2Q1avrSaWO/Gu4k9VthmbqMHeBs5c8FGhtFdKAyTgXjTmNrLE5oim7W+Nz
 z2pGb2uJc57bBUq2TY0YF4ivQFhrWCWSAhVQ60/3uM8JhtbsdJ1zsKg327J9Fbp2qarn
 Dkz0bNo85bdqr0Gppo3GV1P0tU0IY6CSAv3oF3n0tml6DogIuCD0up0twu3esmt096yU
 l4DkTnFL226WUztDxN2hxLijlYeWHNtq+GMME0XKKICf8a8ajJ0b/v+RWeSBdMxePDPs
 yDne1HDTuUNw7sXtsK+66uPRpjqIpGS1IohIGIw9iIQzzuRcSk3O04WT6f0Y46tOBo4Q
 XB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xHUwfXrMCktpWTFh8tgPEYEudq0so6k6jsU7prpKKxM=;
 b=GjKJ47qo7rRso6dwdUgSXZtrUQdv79A1513LpsYjRd5rn8mgRgTHi787hZgJGxaNab
 e+hn2hzilCEawnP4rLje8tOuqllKgMKZ1TbA2R7YQeCExH4IIm/rfqt66N7E03jCiSYf
 9isN1iMCdwYrGedCoRoww9K/09g8Jc03Qf6ZkYB4a6+GIfmAz+0rUS7vpBcVv501C50x
 7AnMRebVHfxfW480C01W5SCyDCJDsg5GZSwz9mxlFmjgsDkjvDYDEI5BN8j9s3dRB0A9
 mSKwoxmEZXC0kW+uDzrno+JHNiVg01IaEiJ3XJzdTHodZ3Xrr173aDaBkqB3wgLk3jmW
 BU2Q==
X-Gm-Message-State: AOAM532h2aZxaKvtZ3WR8EjYEr/LMFuG3vH5dpqiCiWhhuhq/gs4bHFV
 IgYYVAA185BVZI5S/lyyAFWeCA==
X-Google-Smtp-Source: ABdhPJxC9KDHx+v2tl2AoWgFuDne8n7MbUIprrqPxQ66K7jIUhKfAYObHFAJ1+LulSKPVqbntsHnAA==
X-Received: by 2002:a63:550c:: with SMTP id j12mr21589541pgb.31.1627363449249; 
 Mon, 26 Jul 2021 22:24:09 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id s193sm1917237pfc.183.2021.07.26.22.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 22:24:03 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date: Tue, 27 Jul 2021 10:53:49 +0530
Message-Id: <33c317b95097ce491845c697db1e8285e3ec1d41.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, "Enrico Weigelt,
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

This patch adds binding for virtio I2C device, it is based on
virtio-device bindings.

Acked-by: Wolfram Sang <wsa@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
new file mode 100644
index 000000000000..7d87ed855301
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
+    const: i2c
+
+  compatible:
+    const: virtio,device22
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
+        i2c {
+            compatible = "virtio,device22";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            light-sensor@20 {
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
