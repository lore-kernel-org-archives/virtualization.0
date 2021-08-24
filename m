Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B338C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:31:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEC26135F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AEC26135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5AB840315;
	Tue, 24 Aug 2021 11:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0ON8LUl3zhR; Tue, 24 Aug 2021 11:31:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6E32240476;
	Tue, 24 Aug 2021 11:31:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 419AEC0010;
	Tue, 24 Aug 2021 11:31:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BD8BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:31:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEAA6401E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2KL_pUjmPPsu
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:31:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C7C240451
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629804697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tP5a6fccu03ylsrPCjFXQRJ2IVJ92J0bcnTBejvh2I4=;
 b=PwaNrcI3SIy0qU33W0C6VPPV/VXciiGtfxe++4sz0pzj3Y+RZ28/DKUsxaKsp6+2FO+Lch
 8x8HwoyiRQeGIqXtHT+5imCPBmXsT8lqdTJ8WrjWV1/ZuuwhQAehLS9vYGptJxq6/4z57r
 oYWxPM22xvNPDUFOKv2cIDiHO1C6Wvk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-Y9OmFzQAP2OD2agxybJX_Q-1; Tue, 24 Aug 2021 07:31:36 -0400
X-MC-Unique: Y9OmFzQAP2OD2agxybJX_Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 ne21-20020a1709077b95b029057eb61c6fdfso6920826ejc.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tP5a6fccu03ylsrPCjFXQRJ2IVJ92J0bcnTBejvh2I4=;
 b=AMhtQqGj1wIhweoTyOWuL2xmFOsogCkoCubRyH6ffymhCoQlsx0josdA18UahyycMV
 CUNEzEyF2jWBt+rlcoHc//mTVB1NA0sDHoose0lTMj8e7PDi1SJrVEszDkNajN3uuvL9
 FmPHuTLKbT9WsrkjiQ/445YcxK9pPf6xtQSPOxUQeQUu0pN+XXD57cdyOQ1jFMY519/W
 riXQaHrJgN/wPNlrkSJz/14SF+46Tct5rRAp82UFYdmMJ0e9F0HzrgHpHgF7lqw7tg6+
 0jrVrvEoGHZuVkR42tdjUM2v+exhKR23W9DAZSvoZWz4dzgr1okeDU4e+TiMAs5/pZWD
 L+Xg==
X-Gm-Message-State: AOAM530pND+sS6JKLJXMEDbLrIqjyadL1nI3YfQVTiNnzZzPZfxS3evZ
 8rk9AUui6R2taRByLwpCUuv0PTSAhEafL7m6NDHV8WSRFXRPA6lrFZ0v1Qvq2t8lvUnjFU7iCjx
 kExamMq0GYcy/rU1Y5w5THvTPjWP66fHmH+qKv5686A==
X-Received: by 2002:aa7:c5cb:: with SMTP id h11mr11572952eds.255.1629804694929; 
 Tue, 24 Aug 2021 04:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztfOKCpWkq+cpuotpu6M9IwGlTHyNsYPqN20t7g9LEX+64r23BIx9ole/wLFW5RU0jYEjk6Q==
X-Received: by 2002:aa7:c5cb:: with SMTP id h11mr11572937eds.255.1629804694767; 
 Tue, 24 Aug 2021 04:31:34 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
 by smtp.gmail.com with ESMTPSA id v8sm10674845edc.2.2021.08.24.04.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 04:31:34 -0700 (PDT)
Date: Tue, 24 Aug 2021 07:31:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 0/1] virtio: false unhandled irqs from
 vring_interrupt()
Message-ID: <20210824072622-mutt-send-email-mst@kernel.org>
References: <20210824105944.172659-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210824105944.172659-1-stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, vgoyal@redhat.com
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

On Tue, Aug 24, 2021 at 11:59:43AM +0100, Stefan Hajnoczi wrote:
> While investigating an unhandled irq from vring_interrupt() with virtiofs I
> stumbled onto a possible race that also affects virtio_gpu. This theory is
> based on code inspection and hopefully you can point out something that makes
> this a non-issue in practice :).
> 
> The vring_interrupt() function returns IRQ_NONE when an MSI-X interrupt is
> taken with no used (completed) buffers in the virtqueue. The kernel disables
> the irq and the driver is no longer receives irqs when this happens:
> 
>   irq 77: nobody cared (try booting with the "irqpoll" option)
>   ...
>   handlers:
>   [<00000000a40a49bb>] vring_interrupt
>   Disabling IRQ #77
> 
> Consider the following:
> 
> 1. An virtiofs irq is handled and the virtio_fs_requests_done_work() work
>    function is scheduled to dequeue used buffers:
>    vring_interrupt() -> virtio_fs_vq_done() -> schedule_work()
> 
> 2. The device adds more used requests and just before...
> 
> 3. ...virtio_fs_requests_done_work() empties the virtqueue with
>    virtqueue_get_buf().
> 
> 4. The device raises the irq and vring_interrupt() is called after
>    virtio_fs_requests_done_work emptied the virtqueue:
> 
>    irqreturn_t vring_interrupt(int irq, void *_vq)
>    {
>        struct vring_virtqueue *vq = to_vvq(_vq);
> 
>        if (!more_used(vq)) {
>            pr_debug("virtqueue interrupt with no work for %p\n", vq);
>            return IRQ_NONE;
>            ^^^^^^^^^^^^^^^^
> 
> I have included a patch that switches virtiofs from spin_lock() to
> spin_lock_irqsave() to prevent vring_interrupt() from running while the
> virtqueue is processed from a work function.
> 
> virtio_gpu has a similar case where virtio_gpu_dequeue_ctrl_func() and
> virtio_gpu_dequeue_cursor_func() work functions only use spin_lock().
> I think this can result in the same false unhandled irq problem as virtiofs.
> 
> This race condition could in theory affect all drivers. The VIRTIO
> specification says:
> 
>   Neither of these notification suppression methods are reliable, as they are
>   not synchronized with the device, but they serve as useful optimizations.
> 
> If virtqueue_disable_cb() is just a hint and might not disable virtqueue irqs
> then virtio_net and other drivers have a problem because because an irq could
> be raised while the driver is dequeuing used buffers. I think we haven't seen
> this because software VIRTIO devices honor virtqueue_disable_cb(). Hardware
> devices might cache the value and not disable notifications for some time...
> 
> Have I missed something?
> 
> The virtiofs patch I attached is being stress tested to see if the unhandled
> irqs still occur.
> 
> Stefan Hajnoczi (1):
>   fuse: disable local irqs when processing vq completions
> 
>  fs/fuse/virtio_fs.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Fundamentally it is not a problem to have an unhandled IRQ
once in a while. It's only a problem if this happens time
after time.


Does the kernel you are testing include
commit 8d622d21d24803408b256d96463eac4574dcf067
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Tue Apr 13 01:19:16 2021 -0400

    virtio: fix up virtio_disable_cb

?

If not it's worth checking whether the latest kernel still
has the issue.

Note cherry picking that commit isn't trivial there are
a bunch of dependencies.

If you want to try on an old kernel, disable event index.

> -- 
> 2.31.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
