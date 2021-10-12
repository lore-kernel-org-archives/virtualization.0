Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490B76103D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 490B76103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1629480E51;
	Tue, 12 Oct 2021 06:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mug3p7wn3DCp; Tue, 12 Oct 2021 06:53:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1D9980E5F;
	Tue, 12 Oct 2021 06:53:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95427C000F;
	Tue, 12 Oct 2021 06:53:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86347C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6554F40273
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e7az9CZCGxia
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:52:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 898A2401B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634021578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VYPjrfHoFryxA7atPdwxlCJUZlPks/b+YiU605lqPNo=;
 b=YfirmO1GPuHtPK99eDYtyjKhYuXyGpiMYbYHo7znxgpFyen3V/Xm+9nlPglJrGGYM+niGd
 wKKr8WTrDQ7RFBS+1gJJkZS6+NiZTpURqXvZPkNnF1RuAMEpWqaqIvgODML7sTtD/pv/Kl
 pknJBR57zoAXHFzg+tKObgQkufXXNEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-_gTnJdj7PqC_VRpApI3qhQ-1; Tue, 12 Oct 2021 02:52:56 -0400
X-MC-Unique: _gTnJdj7PqC_VRpApI3qhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A38100C67E;
 Tue, 12 Oct 2021 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com
 [10.72.13.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1048D5F4E0;
 Tue, 12 Oct 2021 06:52:29 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 00/12] More virtio hardening
Date: Tue, 12 Oct 2021 14:52:15 +0800
Message-Id: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
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

Hi All:

This series treis to do more hardening for virito.

patch 1 validates the num_queues for virio-blk device.
patch 2-4 validates max_nr_ports for virito-console device.
patch 5-7 harden virtio-pci interrupts to make sure no exepcted
interrupt handler is tiggered. If this makes sense we can do similar
things in other transport drivers.
patch 8-9 validate used ring length.
patch 9-11 let the driver to validate the used length instead of the
virtio core

Smoking test on blk/net with packed=on/off and iommu_platform=on/off.

Please review.

Changes since V1:
- fix and document the memory ordering around the intx_soft_enabled
  when enabling and disabling INTX interrupt
- for the driver that can validate the used length, virtio core won't
  even try to allocate auxilary arrays and validate the used length
- tweak the commit log
- fix typos

Jason Wang (12):
  virtio-blk: validate num_queues during probe
  virtio: add doc for validate() method
  virtio-console: switch to use .validate()
  virtio_console: validate max_nr_ports before trying to use it
  virtio_config: introduce a new ready method
  virtio_pci: harden MSI-X interrupts
  virtio-pci: harden INTX interrupts
  virtio_ring: fix typos in vring_desc_extra
  virtio_ring: validate used buffer length
  virtio-net: don't let virtio core to validate used length
  virtio-blk: don't let virtio core to validate used length
  virtio-scsi: don't let virtio core to validate used buffer length

 drivers/block/virtio_blk.c         |  4 +-
 drivers/char/virtio_console.c      | 51 +++++++++++++++++--------
 drivers/net/virtio_net.c           |  1 +
 drivers/scsi/virtio_scsi.c         |  1 +
 drivers/virtio/virtio_pci_common.c | 49 ++++++++++++++++++++----
 drivers/virtio/virtio_pci_common.h |  7 +++-
 drivers/virtio/virtio_pci_legacy.c |  5 ++-
 drivers/virtio/virtio_pci_modern.c |  6 ++-
 drivers/virtio/virtio_ring.c       | 60 +++++++++++++++++++++++++++++-
 include/linux/virtio.h             |  3 ++
 include/linux/virtio_config.h      |  6 +++
 11 files changed, 162 insertions(+), 31 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
