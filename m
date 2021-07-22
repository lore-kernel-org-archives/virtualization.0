Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7005C63793
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:56:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3CC60D07
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3CC60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 270CC400FB;
	Thu, 22 Jul 2021 09:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4CuAk53y_KUd; Thu, 22 Jul 2021 09:56:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C6307400D2;
	Thu, 22 Jul 2021 09:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E61CC0010;
	Thu, 22 Jul 2021 09:56:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B882C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3075E4031E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ErLthkXIxrPU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3738640270
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:56:50 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id q13so2931296plx.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=95+EWQpHPYU4UdkXqyGmVpXQnpCt50H8R7U1NdxVx1Y=;
 b=i3U8N+tEhW+LW38nVEAcGy2SDigyEJu5MrcAHdaCZnZvI3yoKV3rgKaPZvna1Qaee/
 wCFeLlbX3scqTlPnefRqOpyrBwWV+fjfK11fJYk1TDbvG6TjQDYEaJ/BcEyPL1QOPdWU
 hugqnJ3SWjVw6XQxsCzhB8WiAWjX7iPr279lZ1QAPF3CeyfNovM72NaMrayS6ZIkxx5Z
 UCfXcGquPRFyWbcJMr8CM+d2MDLywk6xC8Ib7XpyGyGSGPqRKckjNOQ7t8x3Ay12v3sy
 URMVl1JsyV/idSQIO9eV/THkJAYYljbfRVW9H1vcW6UMt9XPutSjOsR3ZU36asE8QJnh
 UiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=95+EWQpHPYU4UdkXqyGmVpXQnpCt50H8R7U1NdxVx1Y=;
 b=ZQcUd/ziRJRH6d4AkFcriqU4ZdaVwVsRCbjp2wqmLhDaANaoMWbfpZ9Vq8y1qTkBzA
 Y//BqlA9J/0luQit4bdTXQ2HucUYofKuqCIsrQb3aJdAur6dtBpOMHHtERh37d9dlMIw
 YY1hsYdZhmpIQ0KIkZQBlcc0ecL1xGTNRUKbO2vPxQoUwa/QCm0S/iJ3c2hWsaSJxfJn
 Kp+zHotYLpqX7yxG6Bo1st6NXouebQPmRC8Nky+A9KlHPuYbM0Pg9OTKMRsnu1ifK8NY
 /VBvzxcFyVUI7DWEDIpPOkCGw+kunV2TvT7LnhrqAFU/It+XGThGXHKs9qjWOo6TJEh8
 fxAg==
X-Gm-Message-State: AOAM531xKVi0kKXli2MAqJgC7mOAznh+pcMWufdr7eNrG4JLkMkYGe4J
 lIvuogaJ08dkLnynl2NdIMbxzg==
X-Google-Smtp-Source: ABdhPJzHw29QGU7w1n29t6HldkPP4fdUC6UQrBEYR9Zbf4pHntjA3REhqKrWZyLwpSmu9u5mGl6POg==
X-Received: by 2002:a63:2fc2:: with SMTP id v185mr20230069pgv.71.1626947809408; 
 Thu, 22 Jul 2021 02:56:49 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id r15sm25273137pje.12.2021.07.22.02.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 02:56:47 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/5] virtio: Add virtio-device bindings
Date: Thu, 22 Jul 2021 15:26:38 +0530
Message-Id: <cover.1626947324.git.viresh.kumar@linaro.org>
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

Here, each virtio-mmio corresponds to a virtio-device. But there is no way for
other users in the DT to show their dependency on virtio devices.

This patchset provides that support.

The first patch adds virtio-device bindings to allow for device sub-nodes to be
present and the second patch updates the virtio core to update the of_node.

Other patches add bindings for i2c and gpio devices.

Tested on x86 with qemu for arm64.

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

 .../devicetree/bindings/gpio/gpio-virtio.yaml | 60 +++++++++++++++++
 .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 ++++++++++++++
 .../devicetree/bindings/virtio/mmio.yaml      |  2 +-
 .../bindings/virtio/virtio-device.yaml        | 47 +++++++++++++
 drivers/virtio/virtio.c                       | 67 ++++++++++++++++++-
 include/uapi/linux/virtio_ids.h               | 12 ++++
 6 files changed, 235 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
 create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml

-- 
2.31.1.272.g89b43f80a514

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
