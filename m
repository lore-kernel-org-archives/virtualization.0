Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26069C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 06:19:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A65C64E60
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 06:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A65C64E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 381938562D;
	Tue, 23 Feb 2021 06:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rzrlc8dChFY1; Tue, 23 Feb 2021 06:19:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C9EA3847C5;
	Tue, 23 Feb 2021 06:19:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9771C000B;
	Tue, 23 Feb 2021 06:19:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E322C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27BDA605AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f2iQpo3FN9hK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A66D7605AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614061161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iD5VZEbLGdRDyqWEmS8M17jSN2GBbzyhJ7LgE67oj7Y=;
 b=PYGKOO34H37fcziAOUfZsEOO/oS3jJcdGPhEFiP8W+d54IArfwIriCJ1qa8ruuU0sgm+yI
 OIVZvaN4IjP4HQye7pP0bENciHA8rYwaygHMP4glzgPQ9ncN51I7WWYSooJgeLBKUrpwx3
 m1s8b6xvhjP2FYkMbYnXAOQsEsl65nA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-MyeH8IcNOTaHgI71nW5BqA-1; Tue, 23 Feb 2021 01:19:15 -0500
X-MC-Unique: MyeH8IcNOTaHgI71nW5BqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0DD81020C20;
 Tue, 23 Feb 2021 06:19:13 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-6.pek2.redhat.com [10.72.13.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3B955D9D0;
 Tue, 23 Feb 2021 06:19:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V4 0/3] virtio-pci: introduce modern device module
Date: Tue, 23 Feb 2021 14:19:02 +0800
Message-Id: <20210223061905.422659-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: shahafs@mellanox.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Hi all:

This series tries to implement a vDPA driver for virtio-pci device
which will bridge between vDPA bus and virtio-pci device.

This could be used for future feature prototyping and testing.

Please review

Changes since V4:
- include the patch to let VIRTIO_PCI_LIB to be auto selected
- style fixes in the Kconfig for vp-vdpa driver
- fix the err value returned during vp-vdpa driver probing

Changes since V3:
- rebase to vhost.git

Changes since V2:

- tweak config prompt
- switch from 'cb' to 'config_cb' for vp_vdpa config interrupt
- use a macro for vp_vdpa msix name length

Changes since V1:

- don't try to use devres for virtio-pci core
- tweak the commit log
- split the patches furtherly to ease the reviewing

Changes since RFC:

- Split common codes from virito-pci and share it with vDPA driver
- Use dynamic id in order to be less confusing with virtio-pci driver
- No feature whitelist, supporting any features (mq, config etc)

Jason Wang (3):
  virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
  vdpa: set the virtqueue num during register
  vdpa: introduce virtio pci driver

 drivers/vdpa/Kconfig                 |   7 +
 drivers/vdpa/Makefile                |   1 +
 drivers/vdpa/ifcvf/ifcvf_main.c      |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c    |   4 +-
 drivers/vdpa/vdpa.c                  |  18 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c     |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   2 +-
 drivers/vdpa/virtio_pci/Makefile     |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa.c    | 458 +++++++++++++++++++++++++++
 drivers/virtio/Kconfig               |  11 +-
 drivers/virtio/Makefile              |   2 +-
 include/linux/vdpa.h                 |  10 +-
 12 files changed, 496 insertions(+), 26 deletions(-)
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
