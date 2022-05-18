Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D09AC433F5
	for <virtualization@archiver.kernel.org>; Wed, 18 May 2022 04:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E6D960B18;
	Wed, 18 May 2022 04:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nz-lx0UrW103; Wed, 18 May 2022 04:00:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A645660AF0;
	Wed, 18 May 2022 04:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79036C0032;
	Wed, 18 May 2022 04:00:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A67FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71D02831EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o7ZmCAHwDgXG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:00:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FDE3831B0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 May 2022 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652846413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sQSarlYDnaAFmVqXdbZbyqAzuLDjmcIJCLw8YOJHsoM=;
 b=SESRINBzfwB6xH1PxW4ZxmiGUMx1ilyHqRTAU9K1OEU8+il6n45WOqx33T860pvxh1metJ
 jTLMF5ne3LhNjpD7MG5s6Le1aV4MR66bg4BnQkz3wHMTHIZ62HOMxJWXF8sZ96pkw1M6N9
 F7tyZlkEyT7/44uaBufFiSCd0Vp3n2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669--WpAWRoRPgO2WkF_gsXx9Q-1; Wed, 18 May 2022 00:00:09 -0400
X-MC-Unique: -WpAWRoRPgO2WkF_gsXx9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B923811E78;
 Wed, 18 May 2022 04:00:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-14-27.pek2.redhat.com [10.72.14.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F6431121314;
 Wed, 18 May 2022 03:59:53 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/9] rework on the IRQ hardening of virtio
Date: Wed, 18 May 2022 11:59:42 +0800
Message-Id: <20220518035951.94220-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: lulu@redhat.com, paulmck@kernel.org, peterz@infradead.org, maz@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, eperezma@redhat.com,
 tglx@linutronix.de
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

This is a rework on the IRQ hardening for virtio which is done
previously by the following commits are reverted:

9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
080cd7c3ac87 ("virtio-pci: harden INTX interrupts")

The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
with the assumption of the affinity managed IRQ that is used by some
virtio drivers. And what's more, it is only done for virtio-pci but
not other transports.

In this rework, I try to implement a general virtio solution which
borrows the idea of the INTX hardening by re-using per virtqueue
boolean vq->broken and toggle it in virtio_device_ready() and
virtio_reset_device(). Then we can simply reuse the existing checks in
the vring_interrupt() and return early if the driver is not ready.

Note that, I only did compile test on ccw and MMIO transport.

Please review.

Changes since V4:

- use spin_lock_irq()/spin_unlock_irq() to synchronize with
  vring_interrupt() for ccw
- use spin_lock()/spin_unlock() to protect vring_interrupt() for non
  airq
- add comment to explain the ordering implications of set_status() for
  PCI, ccw and MMIO
- various tweaks on the comments and changelogs

Changes since V3:

- Rename synchornize_vqs() to synchronize_cbs()
- tweak the comment for synchronize_cbs()
- switch to use a dedicated helper __virtio_unbreak_device() and
  document it should be only used for probing
- switch to use rwlock to synchornize the non airq for ccw

Changes since V2:

- add ccw and MMIO support
- rename synchronize_vqs() to synchronize_cbs()
- switch to re-use vq->broken instead of introducing new device
  attributes for the future virtqueue reset support
  - remove unnecssary READ_ONCE()/WRITE_ONCE()
  - a new patch to remove device triggerable BUG_ON()
  - more tweaks on the comments

Changes since v1:

- Use transport specific irq synchronization method when possible
- Drop the module parameter and enable the hardening unconditonally
- Tweak the barrier/ordering facilities used in the code
- Reanme irq_soft_enabled to driver_ready
- Avoid unnecssary IRQ synchornization (e.g during boot)

Jason Wang (8):
  virtio: use virtio_reset_device() when possible
  virtio: introduce config op to synchronize vring callbacks
  virtio-pci: implement synchronize_cbs()
  virtio-mmio: implement synchronize_cbs()
  virtio-ccw: implement synchronize_cbs()
  virtio: allow to unbreak virtqueue
  virtio: harden vring IRQ
  virtio: use WARN_ON() to warning illegal status value

Stefano Garzarella (1):
  virtio: use virtio_device_ready() in virtio_device_restore()

 drivers/s390/virtio/virtio_ccw.c       | 31 +++++++++++++++++
 drivers/virtio/virtio.c                | 24 +++++++++----
 drivers/virtio/virtio_mmio.c           | 14 ++++++++
 drivers/virtio/virtio_pci_legacy.c     |  1 +
 drivers/virtio/virtio_pci_modern.c     |  2 ++
 drivers/virtio/virtio_pci_modern_dev.c |  5 +++
 drivers/virtio/virtio_ring.c           | 32 +++++++++++++++---
 include/linux/virtio.h                 |  1 +
 include/linux/virtio_config.h          | 47 +++++++++++++++++++++++++-
 9 files changed, 145 insertions(+), 12 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
