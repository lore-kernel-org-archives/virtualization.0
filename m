Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93269C636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 10:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1316561297;
	Fri,  3 Feb 2023 10:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1316561297
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=jYZv7OSx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fUiZKR1q4hPE; Fri,  3 Feb 2023 10:04:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B055761294;
	Fri,  3 Feb 2023 10:04:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B055761294
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8624BC0033;
	Fri,  3 Feb 2023 10:04:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0158C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9761041579
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9761041579
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=jYZv7OSx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihDZLS-xjIQM
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3327042A03
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3327042A03
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 10:04:28 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id q9so3294549pgq.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 02:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F0kv5a1Ouh4vMX7sPloZ+hR6D+hnPzE8im5HYlS+lZI=;
 b=jYZv7OSx2S7yMJbkHfCV77RF52CkgBJ1CZT1B7jlWWDi4vMEwhmbumM4yR1lV1WBGV
 uYrQFiTlQqJ/pIzlwUlpG8sr50USWBB2cMIYdZ9HVMZTafuYeX0GAAilnLHA0j3ogfnq
 N2VUnoMqPEvoch2LcQndc/FwyssrOA8jdIRnYdPn+gNQIJFNjr+ftaYhTDfWGTPhOC5y
 9SNi2GyM+Lbbx3/YJrTH8TIOzGPSmZPk0H6BbU4NNL8aVxeWJSuwyG9vFTuXXSJ/nf92
 7ny27vqPu6RgtyD8+2y/ZgfsY2RpPZuSRtz5d+0LcB5Dx64s23YawaFGV9o0TyoChRIt
 lVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0kv5a1Ouh4vMX7sPloZ+hR6D+hnPzE8im5HYlS+lZI=;
 b=q1W9rXF8odZNE7UPZhW1OwzT+8t2wSAcW7Rr33J+ux9jqADJHz6bsQMHSTdILhR2hx
 +e0AnlwcAbBa89Z3pg0V0+UEwbJesHysTewYF8QnoRT+n/XsFE7oTxSVSblCx1nRAXjR
 HylPN+0NpNGEZZLx2SjA1Dd6YNTmbS+HOXjfxthhfa5cjlaMuwpJivpkg9ylMKx7hRuJ
 TXpmJvy+qxubUFLx7PHdUVfwIfPb7nMJoVqF4Z+crhskccm+wOBE/XBRnCP4WQtxLJB0
 +yvh2GJ1GojnTmtX8/d6mEr0l2efbp64C2eiPGJG4IQaDXfU5ZUeslNYpkrphyUs94pe
 zEZQ==
X-Gm-Message-State: AO0yUKWmtR6nQ7rSTT6Em/L4wQcgBkBme0ZNh9YwEW0Z5E0e8tl+vlwM
 Xi8midGcBpjrrvzmVKspkivfSQ==
X-Google-Smtp-Source: AK7set+wQNrnsgsVt2bCm9zX7QS3qmNX8U8vzPZvi2YGH3d4er1Kf8Z6gVN47DMi4Mi1GdlkcoXugA==
X-Received: by 2002:aa7:96ac:0:b0:58d:9ad4:adaa with SMTP id
 g12-20020aa796ac000000b0058d9ad4adaamr9100553pfk.17.1675418667936; 
 Fri, 03 Feb 2023 02:04:27 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d3-20020aa797a3000000b0058d8f23af26sm1278885pfq.157.2023.02.03.02.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 02:04:27 -0800 (PST)
From: Shunsuke Mie <mie@igel.co.jp>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
Date: Fri,  3 Feb 2023 19:04:14 +0900
Message-Id: <20230203100418.2981144-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Ren Zhijie <renzhijie2@huawei.com>,
 Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
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

This patchset introduce a virtio-net EP device function. It provides a
new option to communiate between PCIe host and endpoint over IP.
Advantage of this option is that the driver fully uses a PCIe embedded DMA.
It is used to transport data between virtio ring directly each other. It
can be expected to better throughput.

To realize the function, this patchset has few changes and introduces a
new APIs to PCI EP framework related to virtio. Furthermore, it device
depends on the some patchtes that is discussing. Those depended patchset
are following:
- [PATCH 1/2] dmaengine: dw-edma: Fix to change for continuous transfer
link: https://lore.kernel.org/dmaengine/20221223022608.550697-1-mie@igel.co.jp/
- [RFC PATCH 0/3] Deal with alignment restriction on EP side
link: https://lore.kernel.org/linux-pci/20230113090350.1103494-1-mie@igel.co.jp/
- [RFC PATCH v2 0/7] Introduce a vringh accessor for IO memory
link: https://lore.kernel.org/virtualization/20230202090934.549556-1-mie@igel.co.jp/

About this patchset has 4 patches. The first of two patch is little changes
to virtio. The third patch add APIs to easily access virtio data structure
on PCIe Host side memory. The last one introduce a virtio-net EP device
function. Details are in commit respectively.

Currently those network devices are testd using ping only. I'll add a
result of performance evaluation using iperf and etc to the future version
of this patchset.

Shunsuke Mie (4):
  virtio_pci: add a definition of queue flag in ISR
  virtio_ring: remove const from vring getter
  PCI: endpoint: Introduce virtio library for EP functions
  PCI: endpoint: function: Add EP function driver to provide virtio net
    device

 drivers/pci/endpoint/Kconfig                  |   7 +
 drivers/pci/endpoint/Makefile                 |   1 +
 drivers/pci/endpoint/functions/Kconfig        |  12 +
 drivers/pci/endpoint/functions/Makefile       |   1 +
 .../pci/endpoint/functions/pci-epf-vnet-ep.c  | 343 ++++++++++
 .../pci/endpoint/functions/pci-epf-vnet-rc.c  | 635 ++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-vnet.c | 387 +++++++++++
 drivers/pci/endpoint/functions/pci-epf-vnet.h |  62 ++
 drivers/pci/endpoint/pci-epf-virtio.c         | 113 ++++
 drivers/virtio/virtio_ring.c                  |   2 +-
 include/linux/pci-epf-virtio.h                |  25 +
 include/linux/virtio.h                        |   2 +-
 include/uapi/linux/virtio_pci.h               |   2 +
 13 files changed, 1590 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-ep.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet-rc.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vnet.h
 create mode 100644 drivers/pci/endpoint/pci-epf-virtio.c
 create mode 100644 include/linux/pci-epf-virtio.h

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
