Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB85EC07E95
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:50:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547B261363
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 10:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547B261363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00DE46087A;
	Tue, 13 Jul 2021 10:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuGJTjKhktkZ; Tue, 13 Jul 2021 10:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9C3956071D;
	Tue, 13 Jul 2021 10:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C8B2C001A;
	Tue, 13 Jul 2021 10:50:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA36BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B381A60802
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ggvbJLqFFs1L
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74CC56071D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 10:50:47 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 p4-20020a17090a9304b029016f3020d867so1836293pjo.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4xLUJ1dW1Qt0KgF3pEuea/62PVc6DCT7EsaU/Szp0Bg=;
 b=E2vCdTP4Dqtla5LUcohrAy+3w9yg8TqQrenrE5K9FTm+s6OAAqAP4MkvIUanmoewVh
 p9Xoha8+yUnUYTMCuoC0YpI5U+SKq2/0jW9vqhW6ACR2JbmbQlA9mE3k0V9hJ0hd8oan
 tTlxN5pFfvjiYWIdZqviVCBXIrYVnUuADNxLHBtHQAw7pqzSDE/xUbphfgNvfjOHqS5u
 JeJ0nuh0WIXCgIrUZzo3opYAS5jkLPFYAnwd+nwZ+eSIYIbqkkdOPQeqgg2Mc7wm6yd8
 LE1lVaUisP/flFiy87qUDrIeegoszDgg1BVBZsTYuXAIoMCvvY120W27WX3hWkBNqpEq
 uoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4xLUJ1dW1Qt0KgF3pEuea/62PVc6DCT7EsaU/Szp0Bg=;
 b=jYKULWEeMIMqgq7Nw3htXBNl3YvKrLUZtNqwxh0Ab+AOstwiaTALUxB9u2JDEGRG10
 I16vUxqnJNH1LRMVEI9HLcV8dSU1I9j4ls61IsIianRekzHGCk0Z8nGg2SBXNHvfbSpE
 PV+Q6ZjIZcV69F7rzsOK9VgwbBInzgXuRl40aoedRfVgjaFWdQa3osxADzxAjWEESG2Q
 Y1SRFOIoRzE+PX2R/BeNqCiaw01fDFZdZGDFZyNq4PF2OanbElnJjIf7E701+k397oAT
 gxINHka8ZpSEmF775iJbFXXK0MgG9pl3UjLBzOYZpbtWOFHA3oDM/UaB7ydAhKR7ZgBl
 eSTQ==
X-Gm-Message-State: AOAM533BHeiPNLP0RI5OcsNQlNqLVHrHva5adGEL/Oi5y6hCgDMArU4m
 5E0tSQEZY8m1S3JSxpr1C9sk4Q==
X-Google-Smtp-Source: ABdhPJxwSt+fW6q6oLmsbQWUpPWMZxVQMEC0vEz1IMyhrgYVT2WsxbkoAvR6ROOjdRLOSHodWNX0Yg==
X-Received: by 2002:a17:90b:957:: with SMTP id
 dw23mr12591539pjb.123.1626173446842; 
 Tue, 13 Jul 2021 03:50:46 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id lj13sm15276916pjb.53.2021.07.13.03.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 03:50:46 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/5] virtio: Parse virtio-device nodes from DT
Date: Tue, 13 Jul 2021 16:20:29 +0530
Message-Id: <cover.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, "Enrico Weigelt,
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

Hi,

Currently the DT only provides support for following node types for virtio-mmio
nodes:

	virtio_mmio@a000000 {
		dma-coherent;
		interrupts = <0x00 0x10 0x01>;
		reg = <0x00 0xa000000 0x00 0x200>;
		compatible = "virtio,mmio";
	};

And each virtio-mmio corresponds to a virtio-device. But there is no way for
other users in the DT to show their dependency on virtio devices.

This patchset provides that support.

The first patch update virtio,mmio bindings to allow for device subnodes to be
present and the second patch updates the virtio-mmio driver to update the
of_node.

Other patches add bindings for i2c and gpio virtio devices (they have some
dependencies, mentioned in the patches).

Tested on x86 with qemu for arm64.

--
Viresh

Viresh Kumar (5):
  dt-bindings: virtio: mmio: Add support for device subnode
  virtio_mmio: Bind virtio device to device-tree node
  dt-bindings: i2c: Add bindings for i2c-virtio
  i2c: virtio: Update i2c-adapter's of_node
  dt-bindings: gpio: Add bindings for gpio-virtio

 .../devicetree/bindings/gpio/gpio-virtio.yaml | 67 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 59 ++++++++++++++++
 .../devicetree/bindings/virtio/mmio.yaml      | 41 ++++++++++++
 drivers/i2c/busses/i2c-virtio.c               |  1 +
 drivers/virtio/virtio_mmio.c                  | 44 ++++++++++++
 include/dt-bindings/virtio/virtio_ids.h       |  1 +
 6 files changed, 213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 create mode 120000 include/dt-bindings/virtio/virtio_ids.h

-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
