Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15523C4338F
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC20600CD
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAC20600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 86CAD403AB;
	Tue, 27 Jul 2021 05:24:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hQjp4N2Jh7rJ; Tue, 27 Jul 2021 05:24:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B5B4402C8;
	Tue, 27 Jul 2021 05:24:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0724EC0010;
	Tue, 27 Jul 2021 05:24:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F477C0021
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50C6E60A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gHU3BDwGIIy5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87104605EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:01 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 e2-20020a17090a4a02b029016f3020d867so3291581pjh.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pli4HJidOpxsK8M83Hgdvi+NbofSGQAN0jGG2SdYKog=;
 b=tmUUUVQweZacwI01RO3nQ+0SYtgnKAmFfjVdsxkSGafeGPRhnTcLzjTLff3NffemQY
 bZu8YkYmdFOpGUTi16lwRipdAGxhIG8f3gUx/zul1mAKBVuM/5a+U0P6tek/bCJMSmg7
 pAK9hhWPFL95tv8ujz7S8F4eboM80B5NqLUPXCd89AQ2M6d7jz8N0lVYykfcVJjqAUp/
 0rlneCGVpuCvfhLmjX4H+prUiaNneK6Rk4cD1d/wMkKpnhJy4srY0MDs3dQWjhHlKp4e
 MpvBBqv0iHX2esEKoBxiSfCvdzsjqGBlzRx/54ojkbKa5Kg/jJJ2wCBCrX+FSi+VgsrZ
 ltIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pli4HJidOpxsK8M83Hgdvi+NbofSGQAN0jGG2SdYKog=;
 b=clxkYQYgXCcdZYIevHqMmGX5487d3X0iWAZ5VmF/kGB9wVQErVuvcBxmXytVJbzdGX
 BaPHkeg4T/k018A709r+1L3nqa+crdbWi/t3mUOEzCRG9YZPJAbSsnRink+Cab9Dl+Rf
 jrqxAh6szm8L2tM5+u0QnU71YcrlLje1BVN22P7tKegH3nc66zBPxF/tW/Hy2Y8wjLw4
 QeezjuhUXktAVDaKkS+/f4sRzSboEtW58S4Aqhelit2T2LwmY0tc6IhEuM5zOQ8uPuQn
 OaDACUyUddo0p7cW38cIblGUzDsCgqHLKWwJYI+yEqnx9xl5nJN71bWCy7tvWG2eSFvd
 /H6A==
X-Gm-Message-State: AOAM530002xB2mVRcazfsuBlYWqtnPTXlVRplnp/knzInXP2Vq+tyOVf
 YuoARXcooTA2jcC/F39W4NF5HQ==
X-Google-Smtp-Source: ABdhPJwAnh3q4vqWYwvyBP9fDWHP5b7kHzp+NypFNMPFy81hzVzSo8ecGiy/KFxUx7hzVgSekIso8Q==
X-Received: by 2002:a17:90b:a0c:: with SMTP id
 gg12mr20634688pjb.165.1627363441015; 
 Mon, 26 Jul 2021 22:24:01 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id f3sm1433531pjt.19.2021.07.26.22.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 22:24:00 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 1/5] dt-bindings: virtio: Add binding for virtio devices
Date: Tue, 27 Jul 2021 10:53:48 +0530
Message-Id: <d8319fd18df7086b12cdcc23193c313893aa071a.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
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
nodes. The compatible property for virtio device must be of the format
"virtio,device<ID>", where ID is virtio device ID in hexadecimal format.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/virtio/mmio.yaml      |  3 +-
 .../bindings/virtio/virtio-device.yaml        | 41 +++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index d46597028cf1..4b7a0273181c 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -36,7 +36,8 @@ title: virtio memory mapped devices
   - reg
   - interrupts
 
-additionalProperties: false
+additionalProperties:
+  type: object
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/virtio/virtio-device.yaml b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
new file mode 100644
index 000000000000..1778ea9b5aa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
@@ -0,0 +1,41 @@
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
+  compatible:
+    pattern: "^virtio,device[0-9a-f]{1,8}$"
+    description: Virtio device nodes.
+      "virtio,deviceID", where ID is the virtio device id. The textual
+      representation of ID shall be in lower case hexadecimal with leading
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
+        i2c {
+            compatible = "virtio,device22";
+        };
+    };
+...
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
