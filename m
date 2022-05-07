Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD13C433EF
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 07:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B9CD405B4;
	Sat,  7 May 2022 07:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tt797fCfR92D; Sat,  7 May 2022 07:20:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ABDFC40025;
	Sat,  7 May 2022 07:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD02C0039;
	Sat,  7 May 2022 07:20:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46790C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E95060DFF
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mip0lepwGcAt
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72E5360DCB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651908007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G9fn9Vx3GvvQ05Jnhj8kd/SkzWXQ+qqrB/GBPEAxGNc=;
 b=D+lrq041TWrI6RUZWD33DOmWha2QXtDhqYMh5wmz0Qr3tUDGhcUTcYqcrxUE9WNqpPWEvn
 r9cjvFmh85zCV3Qb9PJ+khpMI5Y8NBlCpL+EHSQA5AlIJyBLfn1SH1CiA7Z+UrlPYEyTH8
 k9yAX9dpuuFRMdDoMugP9Vp/HAJdEMk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-gCj31TyTOUGDVpUyyrhcQA-1; Sat, 07 May 2022 03:20:04 -0400
X-MC-Unique: gCj31TyTOUGDVpUyyrhcQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B47880A0AD;
 Sat,  7 May 2022 07:20:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-216.pek2.redhat.com
 [10.72.13.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36DEE40D2971;
 Sat,  7 May 2022 07:19:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: jasowang@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/9] rework on the IRQ hardening of virtio
Date: Sat,  7 May 2022 15:19:45 +0800
Message-Id: <20220507071954.14455-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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

Changes since v1:

- Use transport specific irq synchronization method when possible
- Drop the module parameter and enable the hardening unconditonally
- Tweak the barrier/ordering facilities used in the code
- Reanme irq_soft_enabled to driver_ready
- Avoid unnecssary IRQ synchornization (e.g during boot)

Changes since V2:

- add ccw and MMIO support
- rename synchronize_vqs() to synchronize_cbs()
- switch to re-use vq->broken instead of introducing new device
  attributes for the future virtqueue reset support
- remove unnecssary READ_ONCE()/WRITE_ONCE()
- a new patch to remove device triggerable BUG_ON()
- more tweaks on the comments

Changes since V3:

- Rename synchornize_vqs() to synchronize_cbs()
- tweak the comment for synchronize_cbs()
- switch to use a dedicated helper __virtio_unbreak_device() and
  document it should be only used for probing
- switch to use rwlick to synchornize the non airq for ccw

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

 drivers/s390/virtio/virtio_ccw.c   | 27 +++++++++++++++++++++
 drivers/virtio/virtio.c            | 24 ++++++++++++------
 drivers/virtio/virtio_mmio.c       |  9 +++++++
 drivers/virtio/virtio_pci_legacy.c |  1 +
 drivers/virtio/virtio_pci_modern.c |  2 ++
 drivers/virtio/virtio_ring.c       | 32 +++++++++++++++++++++---
 include/linux/virtio.h             |  1 +
 include/linux/virtio_config.h      | 39 +++++++++++++++++++++++++++++-
 8 files changed, 123 insertions(+), 12 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
