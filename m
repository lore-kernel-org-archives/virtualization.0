Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D4C432BE
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 04:52:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22C060F39
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 04:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F22C060F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACB544043B;
	Mon, 26 Jul 2021 04:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PgFsfHLWm1W6; Mon, 26 Jul 2021 04:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05EEC40350;
	Mon, 26 Jul 2021 04:52:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2751C001A;
	Mon, 26 Jul 2021 04:52:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C9DFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B7B84042D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DkY0oBrB-fd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C3B040350
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 04:52:06 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id i1so10138087plr.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 21:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=25stCq9hJ2wceSqg94GCYZ0IegUstb1Ha6+CpcC6mxE=;
 b=w3jI5G4dOmRLxP2MlxkQOM2/L+5kcH9M9Un+WZvOEFtFgbL1253v+O6A900H9pX1OR
 qw9GFzKgAHqsrSJv+xKzkMtnxu1u/k2FsfUMM1jvwQ7qiqwCBoEnT2kKN5BFtfFCrJrT
 zLaW0eb8OTIpMtSe7SRO+IeJrGQkCkhy0oq2jYpTMgEpeBMMX1acx7jWiBTtABkWiX09
 Naj0FNAJXC7dcbn4cIjgDHkKmWbDsYNlvr19r4z7ob4upxnluKGyAwX8INWrwqjTjOeW
 +xVP8Pg8xLAdzd55q5lvBBX9Vr/Nv+DCBhy7jd1sGD2JEonDcgIvAs5XUlq2VGQwP95Y
 AsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=25stCq9hJ2wceSqg94GCYZ0IegUstb1Ha6+CpcC6mxE=;
 b=I19ePmexFreDMNqbr5AOhldjKOPiNS1KDfdxtubXbhBdtB1NYXUGQma07T+J+AL6lh
 01LUHYG6JA4sef7ptUslqrGXikQymDBgyLqooVH6tZF0ah2XvNRm/osKuSHLcXMnL8D7
 HYqGYrUer4m6Mpll6cxbw3ZmoIbCxl5v4NoZfD2AJhHkLKmwhDqfrVqbCjNat2Vtd2VP
 /vHJc+n9+uafig1ROaLp8I0koZt7gk+FFgPdKxWC8UhUOi46Mxje/wBKOKSjbn6tgTSF
 xLtB/RS9/EVDzixU5JnepdT0QwDRpUFSv2Ph+/GETYtaq4Q+/QIS1zh+FVELsHo5/oyG
 61gg==
X-Gm-Message-State: AOAM532T0g5Y46BI+YijbkENF1Z12Ut5ARpI2qObjtUDWQopMfI3PvSG
 9UgLWmg2Iu9KfLDL6NuhUclL9Q==
X-Google-Smtp-Source: ABdhPJwNPhh3+pdzKQ+M8usE3bVyjxSjNPWjsz7M3m6jZ8gVABNHZmWDEQUzTbhje9b+6aWj/M6+jg==
X-Received: by 2002:a65:6a0d:: with SMTP id m13mr16774454pgu.356.1627275126102; 
 Sun, 25 Jul 2021 21:52:06 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id q18sm41345108pfj.178.2021.07.25.21.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jul 2021 21:52:04 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date: Mon, 26 Jul 2021 10:21:42 +0530
Message-Id: <4182aff2d1437b30025f3d17d11e5fdc21845239.1627273794.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627273794.git.viresh.kumar@linaro.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
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

Acked-by: Wolfram Sang <wsa@kernel.org>
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
