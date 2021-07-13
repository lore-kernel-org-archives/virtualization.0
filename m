Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A900C07E96
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D51561279
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D51561279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FF0083AB9;
	Tue, 13 Jul 2021 10:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXduPfk13lcS; Tue, 13 Jul 2021 10:50:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5C3683AB8;
	Tue, 13 Jul 2021 10:50:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B153DC001A;
	Tue, 13 Jul 2021 10:50:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45B08C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 343804038F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FB8JERfHfki6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ED834039C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:50 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 p4-20020a17090a9304b029016f3020d867so1836372pjo.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 03:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VovCFljnf1vTBUJ7EdFbbYpvvdVza8LaWe5CrOJSY7g=;
 b=POuW7HR8+JRq0XcNb2gwX87+Cdjg734uF/GDz9PpL8tv7tfi4R7JI4s3lyzjd2HTky
 etuO4Xl+zc7ofYqTlHgCoeEuDnEJAUvuD59GNUTQJofDM4e9n8MVO2Udb5UWRTw9AQWE
 QgYDoVAvfyhm1eK6OHAJen6/cxYL6xox1/+zVUMCQQ4rD83iGXwWdj5AMUl6DhxxS3b5
 8TVnfRubFFifGeIY6CRsrgy4lJeF25GP00i+yiscR/aM4wYTi2rRgT3SzaGeuxkZ2aBY
 HGFkrDpEonK2gGrgOrQIJvCVmsz2HQbt5ijEbpE3Z0DmCaTBIxFT788zMADnVE8F4MQM
 Gk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VovCFljnf1vTBUJ7EdFbbYpvvdVza8LaWe5CrOJSY7g=;
 b=BoDUsE80Sbv30ix2wchHVqYbn7RSIttEYonpi0iVMf3kqIDCHalxJHgQAcZlk9nXGn
 nIdXl3k8CpHlB0VrZJUgCDKNwrGjtF+Wp70tZr/7YAdtP441DGJYk5tnjBR0yzsEf4DH
 KTlx5J49Fx+5DjHsNYu5QRRVY+fKjPixThNY7jzu29ddQQYHXh8aZrOs3FXf6Ai8i3It
 wJjlEfAM0Ms2gxGZvRPO/vnilOB9fzYaLUihB/6xZdDuJ5MiQR1yZ84om8yfAS9v2enH
 5btbrdpOAXqIj7/2AY+sFGxlXkomhxsPJBt73cAlVAlMDshUWMvC29f84N4eu1d/Cq3M
 /6yA==
X-Gm-Message-State: AOAM533KzPbgK4AUdM72l7BV2V17rhwYqSzLGH5LF/RAchlCJDWPMlzw
 M236m0r2CxejcevYd2bZdWDF6w==
X-Google-Smtp-Source: ABdhPJxfSRrVqHX7TowizBcJeXp3Vooup9t0ZmJr+Y2H9dkwyZZxmOQynaJr596l4TvHmyCKKrHzzg==
X-Received: by 2002:a17:903:184:b029:12b:3b0f:a7a3 with SMTP id
 z4-20020a1709030184b029012b3b0fa7a3mr472500plg.24.1626173449854; 
 Tue, 13 Jul 2021 03:50:49 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id h11sm5086664pjv.57.2021.07.13.03.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 03:50:49 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device subnode
Date: Tue, 13 Jul 2021 16:20:30 +0530
Message-Id: <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Allow virtio,mmio nodes to contain device specific subnodes. Since each
virtio,mmio node can represent a single virtio device, each virtio node
is allowed to contain a maximum of one device specific subnode.

The device subnode must have the "reg" property, and its value must
match the virtio device ID used by the virtio mmio node.

A phandle to this device subnode can then be used by the users of the
virtio device.

Also add a symbolic link to uapi/linux/virtio_ids.h in order to use the
definitions here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/virtio/mmio.yaml      | 41 +++++++++++++++++++
 include/dt-bindings/virtio/virtio_ids.h       |  1 +
 2 files changed, 42 insertions(+)
 create mode 120000 include/dt-bindings/virtio/virtio_ids.h

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
index d46597028cf1..e5f9fe6ecb5e 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
@@ -31,6 +31,31 @@ title: virtio memory mapped devices
     description: Required for devices making accesses thru an IOMMU.
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+    description:
+      The cell is the device ID if a device subnode is used.
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  '^[a-z0-9]+-virtio@[0-9]+$':
+    type: object
+    description: |
+      Exactly one node describing the virtio device. The name of the node isn't
+      significant but its phandle can be used to by an user of the virtio
+      device.
+
+    properties:
+      reg:
+        description:
+          Must contain the Virtio ID of the device.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    required:
+      - reg
+
 required:
   - compatible
   - reg
@@ -57,4 +82,20 @@ additionalProperties: false
         #iommu-cells = <1>;
     };
 
+  - |
+    #include <dt-bindings/virtio/virtio_ids.h>
+
+    virtio@3200 {
+        compatible = "virtio,mmio";
+        reg = <0x3200 0x100>;
+        interrupts = <43>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-virtio@0 {
+            reg = <VIRTIO_ID_I2C_ADAPTER>;
+        };
+    };
+
 ...
diff --git a/include/dt-bindings/virtio/virtio_ids.h b/include/dt-bindings/virtio/virtio_ids.h
new file mode 120000
index 000000000000..6e59ba332216
--- /dev/null
+++ b/include/dt-bindings/virtio/virtio_ids.h
@@ -0,0 +1 @@
+../../uapi/linux/virtio_ids.h
\ No newline at end of file
-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
