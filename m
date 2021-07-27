Return-Path: <SRS0=8N1b=MT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0CDC4320E
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4BC610A5
	for <virtualization@archiver.kernel.org>; Tue, 27 Jul 2021 05:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F4BC610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 523C8607D5;
	Tue, 27 Jul 2021 05:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vF3M-5CN6WDO; Tue, 27 Jul 2021 05:24:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CF76E607BF;
	Tue, 27 Jul 2021 05:24:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B57D6C0010;
	Tue, 27 Jul 2021 05:24:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62795C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 510F9607BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIcpVXmJfCsN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:23:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56684605EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jul 2021 05:23:58 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 k4-20020a17090a5144b02901731c776526so2468639pjm.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 22:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m4PnQ7w4ZXIbpbMOd9mPAvOkoi0Otfkeze5HMzWqDSM=;
 b=o00HtKxdOf6pgzaZcv7v0RCIAoZcftZntng7XdmVuSjqtZ2b8wjG0kSMM7lu+GX68P
 2rGAKWvz/uQTh7cL6jW438A+V9TeI9mbi7wXXpHEaCUsQO3V1v4i0tPJOb0ngMv0Bs+3
 M9LJQEIBANelTQ65JuIiInXty805GkKN7ycj23u1RGZ6a/GCtZlF8xOOaDiuOcC7b8mI
 iengHNowfdX5rLoqaQAOYI41O5sesvJCvfaY/KTyhE0bpWP0nsq021X7Jjh657Cqg/eO
 0GRu4vqdaCm4aOorJ9S1mFCYSrxF5VM0sNpLMnvGF5x3CVa7NcLr3JdNlz1zonTq6BAo
 paYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m4PnQ7w4ZXIbpbMOd9mPAvOkoi0Otfkeze5HMzWqDSM=;
 b=X4ZquDykHqZG+eQlyRVCJlDzoDwXTMaYulcXqYg1m1JqKHv7ypYhvWqR6iRVs3kdKe
 3A8bxt8BOxFdKWZvQh9RFZjG/nuqMtRWF38uyXGp4dIGRx968TluMSdTpRNDH8yquaPH
 1eu8VXCF6Y9CHmxpWDsIxllPEBUikUTgoElEKTcTtOTDZtpeEYhbUHwsFV72AoVnLZMi
 f2URGux3pr/j7/xIh9qwFUaBWo56XsYT8iJAgKMIqBQ75WBEQpi/zJ2Gcq3ogxWcH3Tp
 tmF0y5vmRsiwPTD5CwG0h8epcxvsjj4YNqffeVJ3/tdsWrSKBuALNK8jQCh2RxlEykJ1
 w0DA==
X-Gm-Message-State: AOAM533Kfawp8PdbOq8L5XtSk7H7sL1mDNy9jXgQirnYtJsAjbuIzx+B
 oIyHQcOss3JVwCcz237geHJXbw==
X-Google-Smtp-Source: ABdhPJy/IRVuyZuRXHBDpEnTOVpnPmvmUefMG1xV1ZaD3TQ9HJ4t8TjZaCD2LotwfkdOo+epC0N74Q==
X-Received: by 2002:a17:90b:1d84:: with SMTP id
 pf4mr20491531pjb.166.1627363437795; 
 Mon, 26 Jul 2021 22:23:57 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id f18sm1903790pfe.25.2021.07.26.22.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 22:23:57 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/5] virtio: Add virtio-device bindings
Date: Tue, 27 Jul 2021 10:53:47 +0530
Message-Id: <cover.1627362340.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-gpio@vger.kernel.org,
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

Hi,

Currently the DT only provides support for following node types for virtio-mmio
nodes:

        virtio_mmio@a000000 {
                dma-coherent;
                interrupts = <0x00 0x10 0x01>;
                reg = <0x00 0xa000000 0x00 0x200>;
                compatible = "virtio,mmio";
        };

Here, each virtio-mmio corresponds to a virtio-device. But there is no way for
other users in the DT to show their dependency on virtio devices.

This patchset provides that support.

The first patch adds virtio-device bindings to allow for device sub-nodes to be
present and the second patch updates the virtio core to update the of_node.

Other patches add bindings for i2c and gpio devices.

Tested on x86 with qemu for arm64.

V3->V4:
- The binding is named "virtio,deviceXXXXXXXX" now.
- The virtio binding doesn't restrict the node names anymore.
- The i2c/gpio nodes are named i2c and gpio now.
- Dropped including gpio.yaml.
- Updated code to match the new binding name.
- Use "type: object" in additional-property.

V2/2.1->V3:
- Added review-tags from Arnd and Wolfram.
- Only the 5th patch changed otherwise:
  - Use of_device_is_compatible() instead of keeping a list of devices.
  - Use snprintf (with BUG_ON on return value) to create the compatible string,
    whose length is fixed using "virtio,XXXXXXXX".
  - Use dev_of_node().

V1->V2:
- The changes (both binding and code) are made at virtio level, instead of
  virtio-mmio. This allows the same to be used by all device types, irrespective
  of the transport mechanism.

- Dropped the reg property and used compatible in the form "virtio,<DID>".

- Dropped dt-bindings/virtio/virtio_ids.h.

- Add a patch to sync virtio-ids from spec, required for the last patch.

--
Viresh

Viresh Kumar (5):
  dt-bindings: virtio: Add binding for virtio devices
  dt-bindings: i2c: Add bindings for i2c-virtio
  dt-bindings: gpio: Add bindings for gpio-virtio
  uapi: virtio_ids: Sync ids with specification
  virtio: Bind virtio device to device-tree node

 .../devicetree/bindings/gpio/gpio-virtio.yaml | 59 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 ++++++++++++++++
 .../devicetree/bindings/virtio/mmio.yaml      |  3 +-
 .../bindings/virtio/virtio-device.yaml        | 41 +++++++++++++
 drivers/virtio/virtio.c                       | 57 +++++++++++++++++-
 include/uapi/linux/virtio_ids.h               | 12 ++++
 6 files changed, 219 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml

-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
