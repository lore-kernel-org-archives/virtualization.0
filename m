Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916A3C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E086135F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38E086135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 020E040426;
	Tue, 24 Aug 2021 11:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vznVNfylUo3S; Tue, 24 Aug 2021 11:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E374A40416;
	Tue, 24 Aug 2021 11:00:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9047CC001A;
	Tue, 24 Aug 2021 11:00:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AD91C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77CAC6058B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DvFXrDlKq8ia
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECBFC6060F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629802806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b832D+EXyszaBxwNcuDTgB1pwTGihDYZVkFT3v4m2hk=;
 b=DV3KPsokOYyRrK8W5og4C8z3bsaUmPMW3rmf/4xnuVXTyKgyB47+MX9/wc8Kfxm/R/ebpL
 /otFpLAkrA0lB1Iz5/NJ+5yx09qgZ+UeMraTheD07M4NOID4BJ5RozWHCu9O/oLeBPmfZP
 ToXfNL7FE6iSm59pvFjvC1sDuom5gzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-q3b7joqBNYiDAOHpiP__sw-1; Tue, 24 Aug 2021 07:00:05 -0400
X-MC-Unique: q3b7joqBNYiDAOHpiP__sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7D1E879A09;
 Tue, 24 Aug 2021 11:00:03 +0000 (UTC)
Received: from localhost (unknown [10.39.195.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 572F5226F0;
 Tue, 24 Aug 2021 10:59:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 0/1] virtio: false unhandled irqs from vring_interrupt()
Date: Tue, 24 Aug 2021 11:59:43 +0100
Message-Id: <20210824105944.172659-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 vgoyal@redhat.com
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

While investigating an unhandled irq from vring_interrupt() with virtiofs I
stumbled onto a possible race that also affects virtio_gpu. This theory is
based on code inspection and hopefully you can point out something that makes
this a non-issue in practice :).

The vring_interrupt() function returns IRQ_NONE when an MSI-X interrupt is
taken with no used (completed) buffers in the virtqueue. The kernel disables
the irq and the driver is no longer receives irqs when this happens:

  irq 77: nobody cared (try booting with the "irqpoll" option)
  ...
  handlers:
  [<00000000a40a49bb>] vring_interrupt
  Disabling IRQ #77

Consider the following:

1. An virtiofs irq is handled and the virtio_fs_requests_done_work() work
   function is scheduled to dequeue used buffers:
   vring_interrupt() -> virtio_fs_vq_done() -> schedule_work()

2. The device adds more used requests and just before...

3. ...virtio_fs_requests_done_work() empties the virtqueue with
   virtqueue_get_buf().

4. The device raises the irq and vring_interrupt() is called after
   virtio_fs_requests_done_work emptied the virtqueue:

   irqreturn_t vring_interrupt(int irq, void *_vq)
   {
       struct vring_virtqueue *vq = to_vvq(_vq);

       if (!more_used(vq)) {
           pr_debug("virtqueue interrupt with no work for %p\n", vq);
           return IRQ_NONE;
           ^^^^^^^^^^^^^^^^

I have included a patch that switches virtiofs from spin_lock() to
spin_lock_irqsave() to prevent vring_interrupt() from running while the
virtqueue is processed from a work function.

virtio_gpu has a similar case where virtio_gpu_dequeue_ctrl_func() and
virtio_gpu_dequeue_cursor_func() work functions only use spin_lock().
I think this can result in the same false unhandled irq problem as virtiofs.

This race condition could in theory affect all drivers. The VIRTIO
specification says:

  Neither of these notification suppression methods are reliable, as they are
  not synchronized with the device, but they serve as useful optimizations.

If virtqueue_disable_cb() is just a hint and might not disable virtqueue irqs
then virtio_net and other drivers have a problem because because an irq could
be raised while the driver is dequeuing used buffers. I think we haven't seen
this because software VIRTIO devices honor virtqueue_disable_cb(). Hardware
devices might cache the value and not disable notifications for some time...

Have I missed something?

The virtiofs patch I attached is being stress tested to see if the unhandled
irqs still occur.

Stefan Hajnoczi (1):
  fuse: disable local irqs when processing vq completions

 fs/fuse/virtio_fs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.31.1


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
