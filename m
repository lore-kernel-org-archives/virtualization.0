Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F72AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 03:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D9F34013A;
	Wed, 23 Mar 2022 03:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CQG3GISwUAFg; Wed, 23 Mar 2022 03:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67CF9403A4;
	Wed, 23 Mar 2022 03:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D00FC0031;
	Wed, 23 Mar 2022 03:10:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4CF6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCF4860E64
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HxNTkl0fqgu9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:10:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7755760E50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 03:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648005041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGgo2QAozxKREy7KkTi56vaqwR7d3TFN694TEyxqgzw=;
 b=IbjZ2AEfx/JDT0e7XEyZwxp2o/iLKQ36d1nueCSLOL/4mwbmDVhIz2Sj7+/oJYVJ9/EsEP
 FuULSxq+LddPvHQ3Asjl1NFEGWNFAenbfTPPXZKx1V5QhmqNNjfcZabsSM0+namRAxMTff
 to4xiqO4LpbZHYXOLSO+DAFu3+I7WrY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-zVaVnLFdPEuqM-euNqMsGg-1; Tue, 22 Mar 2022 23:10:40 -0400
X-MC-Unique: zVaVnLFdPEuqM-euNqMsGg-1
Received: by mail-lj1-f200.google.com with SMTP id
 s24-20020a2e98d8000000b00249800e5b87so51760ljj.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 20:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oGgo2QAozxKREy7KkTi56vaqwR7d3TFN694TEyxqgzw=;
 b=nPr1gXLr64v21QgoNhuNlmVIudFSl/Bx+9kbUbwXU246vEWVUt2E9bq3ISyn54lMjT
 xj8XznAJCI6qIUu7umaL3E/kpujU6426eCyrZsja1GKG0jkGvhNPcweIC+AtviEnZ1Eo
 gh3EowobJWsO4+PzgHtyr4W3/4QWOVSyxJMxIFsUnYvT+D6AjaaX8eNIAzmdaUVc1/ur
 ZOPifFI4aHu3XO2Gx/kYeVQWI7G9A73w08P53dbLcoL9FsG2Sf/h8E2/yfk0YGFKZI6y
 tmi1NYkViHmQYZPVIjPrRegUZZC3reCkKQ+V1OEClYFOJN0EuHsi77wTIN+8hPAVSKHe
 SVBg==
X-Gm-Message-State: AOAM5314nfewTyRJNmPm4vuTLMR95+6SpexIjaEc2WGQZeJFa12+vZ0J
 t8e0e3Ov9XBFRGTC/sPEk9YTY4gNcY/hOBozg5oBerO+CpywnERhalSmv8TTxG5znSqDTZL709F
 n1XmQc/8Av5vosI/ClN+dzgoFnuMzMSf+rbs8tFQLhCZDbsPRz483A2ivTw==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr20337157lfv.257.1648005038328; 
 Tue, 22 Mar 2022 20:10:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiqwJ/kbpPgsK45vw/El7oQ7v37X0Q2cKgv7r1FOUy5FXu/SiMPslSTD1xQjyEymdBzlAsxwuQghtxfpQChsg=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr20337143lfv.257.1648005038112; Tue, 22
 Mar 2022 20:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220322114313.116516-1-sgarzare@redhat.com>
 <20220322100635-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220322100635-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Mar 2022 11:10:27 +0800
Message-ID: <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in
 virtio_device_restore()
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Mar 22, 2022 at 10:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
> > After waking up a suspended VM, the kernel prints the following trace
> > for virtio drivers which do not directly call virtio_device_ready() in
> > the .restore:
> >
> >     PM: suspend exit
> >     irq 22: nobody cared (try booting with the "irqpoll" option)
> >     Call Trace:
> >      <IRQ>
> >      dump_stack_lvl+0x38/0x49
> >      dump_stack+0x10/0x12
> >      __report_bad_irq+0x3a/0xaf
> >      note_interrupt.cold+0xb/0x60
> >      handle_irq_event+0x71/0x80
> >      handle_fasteoi_irq+0x95/0x1e0
> >      __common_interrupt+0x6b/0x110
> >      common_interrupt+0x63/0xe0
> >      asm_common_interrupt+0x1e/0x40
> >      ? __do_softirq+0x75/0x2f3
> >      irq_exit_rcu+0x93/0xe0
> >      sysvec_apic_timer_interrupt+0xac/0xd0
> >      </IRQ>
> >      <TASK>
> >      asm_sysvec_apic_timer_interrupt+0x12/0x20
> >      arch_cpu_idle+0x12/0x20
> >      default_idle_call+0x39/0xf0
> >      do_idle+0x1b5/0x210
> >      cpu_startup_entry+0x20/0x30
> >      start_secondary+0xf3/0x100
> >      secondary_startup_64_no_verify+0xc3/0xcb
> >      </TASK>
> >     handlers:
> >     [<000000008f9bac49>] vp_interrupt
> >     [<000000008f9bac49>] vp_interrupt
> >     Disabling IRQ #22
> >
> > This happens because we don't invoke .enable_cbs callback in
> > virtio_device_restore(). That callback is used by some transports
> > (e.g. virtio-pci) to enable interrupts.
> >
> > Let's fix it, by calling virtio_device_ready() as we do in
> > virtio_dev_probe(). This function calls .enable_cts callback and sets
> > DRIVER_OK status bit.
> >
> > This fix also avoids setting DRIVER_OK twice for those drivers that
> > call virtio_device_ready() in the .restore.
> >
> > Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >
> > I'm not sure about the fixes tag. That one is more generic, but the
> > following one I think introduced the issue.
> >
> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
>
> Jason what should we do about this one BTW? Just revert? We have other
> issues ...

Let me post a patch to revert it and give it a rework.

Thanks

>
>
> > Thanks,
> > Stefano
> > ---
> >  drivers/virtio/virtio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 22f15f444f75..75c8d560bbd3 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
> >                       goto err;
> >       }
> >
> > -     /* Finally, tell the device we're all set */
> > -     virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > +     /* If restore didn't do it, mark device DRIVER_OK ourselves. */
> > +     if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             virtio_device_ready(dev);
> >
> >       virtio_config_enable(dev);
> >
> > --
> > 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
