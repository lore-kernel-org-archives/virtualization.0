Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348C7C433FE
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 08:40:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3B7684216;
	Thu, 24 Mar 2022 08:40:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gcQYhUTWLAXn; Thu, 24 Mar 2022 08:40:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 762A98420F;
	Thu, 24 Mar 2022 08:40:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ADBEC001A;
	Thu, 24 Mar 2022 08:40:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02495C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFE3B8420E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kpw4G0ZkCM3d
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2599584209
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648111228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8YEyrlmnQdg2INNFhefHDH4uWMgnQzaNh1TmwLtH5Fg=;
 b=SOrq2syG+AnYaGIupirzF7bGDyAG9P5t4dScZMdEa5/fevgxIEbSn0SpCQdKmirLuRmX/v
 dTB1YfKErjk7EY87MrkEd51YoP3T6XMWx5kYErpj+GHA2vdiQqewDLamnXH+BveFs5/Bgo
 IEaYJ7BPDu2GFdMDAoSOIE389o0VV4E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-IooITgx-PfeRHfchqbq6ug-1; Thu, 24 Mar 2022 04:40:25 -0400
X-MC-Unique: IooITgx-PfeRHfchqbq6ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02FB53C23FA2;
 Thu, 24 Mar 2022 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-240.pek2.redhat.com
 [10.72.13.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3505D40CF8ED;
 Thu, 24 Mar 2022 08:40:20 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/3] rework on the IRQ hardening of virtio
Date: Thu, 24 Mar 2022 16:40:01 +0800
Message-Id: <20220324084004.14349-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Cc: peterz@infradead.org, maz@kernel.org, keirf@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
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
borrows the idea of the INTX hardening by introducing a boolean for
virtqueue callback enabling and toggle it in virtio_device_ready()
and virtio_reset_device(). Then vring_interrupt() can simply check and
return early if the driver is not ready.

To unbreak legacy setups that may generate IRQ before DRIVER_OK, a
module parameter is introduced to disable the hardening by
default. The features can then be turned on the setups that the
hardening is needed (e.g the confidential computing and other cases).

Please review.

Thanks

Jason Wang (2):
  virtio: use virtio_reset_device() when possible
  virtio: harden vring IRQ

Stefano Garzarella (1):
  virtio: use virtio_device_ready() in virtio_device_restore()

 drivers/virtio/virtio.c       | 28 ++++++++++++++++++++++++----
 drivers/virtio/virtio_ring.c  |  9 ++++++++-
 include/linux/virtio.h        |  4 ++++
 include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 5 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
