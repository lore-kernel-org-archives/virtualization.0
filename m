Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD99AC4361A
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 04:04:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072D6222B6
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 04:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072D6222B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 54124873EB;
	Fri,  4 Dec 2020 04:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFoOJq2zaNKf; Fri,  4 Dec 2020 04:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F202C86F42;
	Fri,  4 Dec 2020 04:04:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D325CC163C;
	Fri,  4 Dec 2020 04:04:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88237C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 701C0204F5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AtikreDNHh1y
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 73038204E8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 04:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607054644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GCwhF1UDQGNxIZoX6aCwJAyJn0KIyBC+L23dEV6acK8=;
 b=Enb4WF7GwDB7bzcWv5Sn4kHbh+peUQwb74RkLLYYkTkOYLiU+LgS4eokpW/v7x9sErA3+y
 IZc500VhhvCK/jvnn8BhBClJaFi9GSjKJbyrXSKg2HKIEiOu0Ure2jCpHqaeiF5mdXLVRb
 JuIwuuRAsEuWq3vHJUwK6EkIVxyHT3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-0yg5IcYNNf6GoQ1XqCgAGA-1; Thu, 03 Dec 2020 23:04:02 -0500
X-MC-Unique: 0yg5IcYNNf6GoQ1XqCgAGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75040107ACE3;
 Fri,  4 Dec 2020 04:04:01 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-116.pek2.redhat.com [10.72.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BB3D1A838;
 Fri,  4 Dec 2020 04:03:55 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/19] vDPA driver for virtio-pci device
Date: Fri,  4 Dec 2020 12:03:34 +0800
Message-Id: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com
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

Changes from V2:

- don't try to use devres for virtio-pci core
- tweak the commit log
- split the patches furtherly to ease the reviewing

Changes from V1:

- Split common codes from virito-pci and share it with vDPA driver
- Use dynamic id in order to be less confusing with virtio-pci driver
- No feature whitelist, supporting any features (mq, config etc)

Thanks

Jason Wang (19):
  virtio-pci: do not access iomem via struct virtio_pci_device directly
  virtio-pci: split out modern device
  virtio-pci-modern: factor out modern device initialization logic
  virtio-pci-modern: introduce vp_modern_remove()
  virtio-pci-modern: introduce helper to set config vector
  virtio-pci-modern: introduce helpers for setting and getting status
  virtio-pci-modern: introduce helpers for setting and getting features
  virtio-pci-modern: introduce vp_modern_generation()
  virtio-pci-modern: introduce vp_modern_set_queue_vector()
  virtio-pci-modern: introduce vp_modern_queue_address()
  virtio-pci-modern: introduce helper to set/get queue_enable
  virtio-pci-modern: introduce helper for setting/geting queue size
  virtio-pci-modern: introduce helper for getting queue nums
  virtio-pci-modern: introduce helper to get notification offset
  virito-pci-modern: rename map_capability() to
    vp_modern_map_capability()
  virtio-pci: introduce modern device module
  vdpa: set the virtqueue num during register
  virtio_vdpa: don't warn when fail to disable vq
  vdpa: introduce virtio pci driver

 drivers/vdpa/Kconfig                   |   6 +
 drivers/vdpa/Makefile                  |   1 +
 drivers/vdpa/ifcvf/ifcvf_main.c        |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c      |   5 +-
 drivers/vdpa/vdpa.c                    |   8 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |   4 +-
 drivers/vdpa/virtio_pci/Makefile       |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa.c      | 455 +++++++++++++++++++
 drivers/virtio/Kconfig                 |  10 +-
 drivers/virtio/Makefile                |   1 +
 drivers/virtio/virtio_pci_common.h     |  22 +-
 drivers/virtio/virtio_pci_modern.c     | 506 +++------------------
 drivers/virtio/virtio_pci_modern_dev.c | 599 +++++++++++++++++++++++++
 drivers/virtio/virtio_vdpa.c           |   3 +-
 include/linux/vdpa.h                   |   7 +-
 include/linux/virtio_pci_modern.h      | 111 +++++
 16 files changed, 1273 insertions(+), 472 deletions(-)
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
 create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
 create mode 100644 include/linux/virtio_pci_modern.h

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
