Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC63FC433F5
	for <virtualization@archiver.kernel.org>; Sat,  7 May 2022 05:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81F7D60D54;
	Sat,  7 May 2022 05:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ElMtnesJdq6x; Sat,  7 May 2022 05:07:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0E5C860B2D;
	Sat,  7 May 2022 05:07:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4704C0039;
	Sat,  7 May 2022 05:07:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4170C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 05:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A41AD60D4E
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 05:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4c9vCpx2In1t
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 05:07:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39E7860B2D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  7 May 2022 05:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651900047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WKFrTG6BT4XtoQUjOd0EJOeY4hUiJrW4gNuP1XW6bYk=;
 b=QVCNJLeE40eh+N8HX3oeda3JWyFnbEOvoEsgSfPQQB2RBW2ScxM6MgDEho/jb1D7ybqVYX
 qazdhV8i+tCH4i7vospJeJqcmhHmSem0zE+H2hAQmRo7ZvmlgY31xj11+lEI9mSkwvB1Bg
 zsysmdCi92yoF0Gn2Lx3J5CAcqomLGw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-sFuXg90wPB26M3HKCdUp9g-1; Sat, 07 May 2022 01:07:26 -0400
X-MC-Unique: sFuXg90wPB26M3HKCdUp9g-1
Received: by mail-lf1-f70.google.com with SMTP id
 k5-20020ac257c5000000b004723f6f25d6so4070012lfo.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 22:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WKFrTG6BT4XtoQUjOd0EJOeY4hUiJrW4gNuP1XW6bYk=;
 b=JxEgNJ9Ti+YH1MfP0Uz/CqfnW/KQPDEywE5Qa2KOkuP8l2oUP2u9lm+/LSEXUmpTKi
 VKaiHJRooc1F0YJwUEHMXxHqjFNz7zPpGY/0kp6oVnQFEXOtI+060Hi9w+4aB6u8pRb2
 ReiG+BZCBNajY0DH2UUdyiSTxuQcPlbT67U8WWwRn9aebwtW3d09kExYLlDuORpeRuZ6
 r7ESTJIjjC1hJI4dB90nRXIG29rFCo5lYWaJitnyICnbIgoLVA1W7rJaBRoF4mW8OLrT
 5YlSnRKZbwwiucsg+jRUhe/G9z6D6zOHDT5EKlcwlMx9cQJ04SRYJVYwremzXh3oyHsE
 RVaw==
X-Gm-Message-State: AOAM5306jaaTFlo3ZotCj+u+jMh8F+9ItCoAc9y1lgFofYod78l1D/Bv
 yqyx+hnGIIaBhkR+Z1rh6OH54WzihJ/94f6j6DK8OQzBO77TGvYZ6GiHM+h+/CFeaqmk8HVMpBK
 FhoLKcoP6xiuazfcNwRJ6vhUuUuUimA327JR/joPey2Ysf2EgURiau1Br2Q==
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr4951612lfg.98.1651900045340; 
 Fri, 06 May 2022 22:07:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZGP+pzBwvqTFnGLNL46r624MAOVl0Foh5oZRGkIyYHh3KQhYZ1Z+k+zg853w8U8aha7h4FUe6I44wlLfmAlE=
X-Received: by 2002:a05:6512:33d0:b0:473:a25e:f9fb with SMTP id
 d16-20020a05651233d000b00473a25ef9fbmr4951603lfg.98.1651900045134; Fri, 06
 May 2022 22:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151242.213824-1-sgarzare@redhat.com>
 <CACGkMEv=0VWh_NxhvM+6_TRHEx0f2RGRWbR1n5RhKfq0a7xJUw@mail.gmail.com>
 <20220429071449.pycbkk2dvvxmtvay@sgarzare-redhat>
 <CACGkMEtRwRb_jUdCcdrx77=O4bnRGssQ5z_81KJi1hEKdbMcCQ@mail.gmail.com>
 <20220505084045.xdh3xwgfr2spp3fj@sgarzare-redhat>
In-Reply-To: <20220505084045.xdh3xwgfr2spp3fj@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 7 May 2022 13:07:14 +0800
Message-ID: <CACGkMEsAyx2V_Q41MbrFu3eXoi+Qmg_aeEz9-Aw6qYHsFivCTg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, May 5, 2022 at 4:40 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, May 05, 2022 at 04:26:24PM +0800, Jason Wang wrote:
> >On Fri, Apr 29, 2022 at 3:14 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Fri, Apr 29, 2022 at 10:46:40AM +0800, Jason Wang wrote:
> >> >On Thu, Apr 28, 2022 at 11:13 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> >>
> >> >> The simulator behaves like a ramdisk, so we don't have to do
> >> >> anything when a VIRTIO_BLK_T_FLUSH request is received, but it
> >> >> could be useful to test driver behavior.
> >> >>
> >> >> Let's expose the VIRTIO_BLK_F_FLUSH feature to inform the driver
> >> >> that we support the flush command.
> >> >>
> >> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> ---
> >> >>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 12 ++++++++++++
> >> >>  1 file changed, 12 insertions(+)
> >> >>
> >> >> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> >> index 42d401d43911..a6dd1233797c 100644
> >> >> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> >> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> >> >> @@ -25,6 +25,7 @@
> >> >>  #define DRV_LICENSE  "GPL v2"
> >> >>
> >> >>  #define VDPASIM_BLK_FEATURES   (VDPASIM_FEATURES | \
> >> >> +                                (1ULL << VIRTIO_BLK_F_FLUSH)    | \
> >> >>                                  (1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
> >> >>                                  (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
> >> >>                                  (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
> >> >> @@ -166,6 +167,17 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> >> >>                 pushed += bytes;
> >> >>                 break;
> >> >>
> >> >> +       case VIRTIO_BLK_T_FLUSH:
> >> >> +               if (sector != 0) {
> >> >> +                       dev_err(&vdpasim->vdpa.dev,
> >> >> +                               "A driver MUST set sector to 0 for a VIRTIO_BLK_T_FLUSH request - sector: 0x%llx\n",
> >> >> +                               sector);
> >> >
> >> >If this is something that could be triggered by userspace/guest, then
> >> >we should avoid this.
> >>
> >> It can only be triggered by an erratic driver.
> >
> >Right, so guest can try to DOS the host via this.
>
> Yes, but I don't expect the simulator to be used in the real world, but
> only for testing and development, so the user should have full control
> of the guest.

Right, but from kernel POV it's better to avoid any guest triggerable behaviour.

>
> >
> >>
> >> I was using the simulator to test a virtio-blk driver that I'm writing
> >> in userspace and I forgot to set `sector` to zero, so I thought it would
> >> be useful.
> >>
> >> Do you mean to remove the error message?
> >
> >Some like dev_warn_once() might be better here.
>
> We also have other checks we do for each request (in and out header
> length, etc.) where we use dev_err(), should we change those too?

I think so.

>
> I don't know, from a developer's point of view I'd prefer to have them
> all printed, but actually if we have a totally wrong driver in the
> guest, we risk to hang our host to print an infinite number of messages.

Or we can use pr_debug() or tracepoints. Then the log is enabled conditally.

>
> Maybe we should change all the errors in the data path to
> dev_warn_once() and keep returning VIRTIO_BLK_S_IOERR to the guest which
> will surely get angry and print something.
>
> If you agree, I'll send a patch to change all the printing and then
> repost this with your suggestion as well.

Yes.

Thanks

>
> Thanks,
> Stefano
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
