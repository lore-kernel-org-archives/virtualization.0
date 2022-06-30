Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08A5CCA473
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 19:20:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 476B740ABC;
	Thu, 30 Jun 2022 19:20:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 476B740ABC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BubFn39a
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzsF16L-l_gQ; Thu, 30 Jun 2022 19:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AFA3E405DF;
	Thu, 30 Jun 2022 19:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFA3E405DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E151C002D;
	Thu, 30 Jun 2022 19:20:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DFF2C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEA1D40A2A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:20:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEA1D40A2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TU-GHSlj0rxD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:20:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 15BCF405DF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15BCF405DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656616849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6CjSS5d5sjNHdItcbvsvU/YpM2uPYuOWoAxR2J1g4bg=;
 b=BubFn39aEU+qTu9xXfMnqcJSvBbEdB8hy8Bvjmo/zRGZbURbgZd6kJ+ChbdwW3iwubOvVZ
 lPBjIq8RBAYXCt1Y2VjOjgS99dZWB3PNpKv+kNw8ygD2NEvMUvAgacTq78j+WNwXjvm9Au
 ikI/e08upEF2ujPyc3YK8G72VnScv+o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-H3NJ0Cg0MJOpkIz1VK0_7A-1; Thu, 30 Jun 2022 15:20:48 -0400
X-MC-Unique: H3NJ0Cg0MJOpkIz1VK0_7A-1
Received: by mail-wm1-f70.google.com with SMTP id
 k5-20020a05600c0b4500b003941ca130f9so8363248wmr.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 12:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6CjSS5d5sjNHdItcbvsvU/YpM2uPYuOWoAxR2J1g4bg=;
 b=LpsbJt322qYlepI6carYBb1IPvEyAWTDgkvtf9VGZVrH/U4WQqDvN2WdfwOYk7z6vl
 U8crOxelc4b//wG8uiqX1UbQx0P4Cn8kgFz6g4IgeYVAdLSC3hNnFk0vKP4RgKe8oe5n
 kOTKDYxnUXx87DujNxxEDY5wJ890+43a3BblLy1IXJTrsOifuWM57Kb9cjYWvrvNrhlK
 YXrST0JUwuxpdjbWB5u6HiRgWpTNKzwORsXAMZcGw0EUT4HoYggLhuYIscbQKUIVZAtK
 5//0ec3jh8ZACxHzNYsoNWfvvzxl4xLJVqnS+w+7dh/gEeOZeMGPkjCnCIKaWhvV1rK5
 TXPA==
X-Gm-Message-State: AJIora/urOhFWuia6zKCcuPratfqnjYg1f3LepGd9Dhm7/P6ks6210Tv
 BDflFg2hiFHElzZU3fmejUi012YV5low/o/+JGHcLYhQuBRPUH9sEUyuFEDwaKi311Srpl3vVlY
 K9a4Y+yLx32eXOJ36rq/jRYyziq+8fNIXElkfLeqcmg==
X-Received: by 2002:a5d:66cc:0:b0:21b:8f5e:875b with SMTP id
 k12-20020a5d66cc000000b0021b8f5e875bmr10265275wrw.51.1656616846861; 
 Thu, 30 Jun 2022 12:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tgE4b+BImXUdY4JEm94kH9+IYij7gDCFCM6lWg999bdtkPXFWxXh65gicKcRT7llsoDvFGDw==
X-Received: by 2002:a5d:66cc:0:b0:21b:8f5e:875b with SMTP id
 k12-20020a5d66cc000000b0021b8f5e875bmr10265260wrw.51.1656616846615; 
 Thu, 30 Jun 2022 12:20:46 -0700 (PDT)
Received: from redhat.com ([2.55.35.209]) by smtp.gmail.com with ESMTPSA id
 q3-20020a1c4303000000b003a03185231bsm7512645wma.31.2022.06.30.12.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 12:20:46 -0700 (PDT)
Date: Thu, 30 Jun 2022 15:20:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Message-ID: <20220630152003-mutt-send-email-mst@kernel.org>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
 <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Anup Patel <apatel@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, kvm-riscv@lists.infradead.org,
 Atish Patra <atishp@atishpatra.org>,
 Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
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

On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
> + virtualization@lists.linux-foundation.org
> + jasowang@redhat.com
> + mst@redhat.com
> 
> On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
> >
> > Hi,
> >
> > On 6/29/22 19:43, Mathieu Poirier wrote:
> > > Hi Anup,
> > >
> > > On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > >> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > >> fails due to both virtqueues (Rx and Tx) marked as broken by the
> > >> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > >> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> > >>
> > >> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > >> ---
> > >>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > >> index 905ac7910c98..71a64d2c7644 100644
> > >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > >> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > >>      /* and half is dedicated for TX */
> > >>      vrp->sbufs = bufs_va + total_buf_space / 2;
> > >>
> > >> +    /* From this point on, we can notify and get callbacks. */
> > >> +    virtio_device_ready(vdev);
> > >> +
> > >
> > > Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> > > potentially be called (by way of rpmsg_recv_done()), which will race with
> > > virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> > > rpmsg_recv_done() will fail, potentially breaking remote processors' state
> > > machines that don't expect their initial name service to fail when the "device"
> > > has been marked as ready.
> > >
> > > What does make me curious though is that nobody on the remoteproc mailing list
> > > has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> > > i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> > > their rig?
> >
> > I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> > I confirm the issue!
> >
> > Concerning the solution, I share Mathieu's concern. This could break legacy.
> > I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
> >
> > I this case the patch would be:
> >
> > +       /*
> > +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> > +        * to ready
> > +        */
> > +       __virtio_unbreak_device(vdev);
> > +
> >
> >         /* set up the receive buffers */
> >         for (i = 0; i < vrp->num_bufs / 2; i++) {
> >                 struct scatterlist sg;
> >                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> 
> This will indeed fix the problem.  On the flip side the kernel
> documentation for __virtio_unbreak_device() puzzles me...
> It clearly states that it should be used for probing and restoring but
> _not_ directly by the driver.  Function rpmsg_probe() is part of
> probing but also the entry point to a driver.
> 
> Michael and virtualisation folks, is this the right way to move forward?

I don't think it is, __virtio_unbreak_device is intended for core use.

> >
> > Regards,
> > Arnaud
> >
> > >
> > > Thanks,
> > > Mathieu
> > >
> > >>      /* set up the receive buffers */
> > >>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> > >>              struct scatterlist sg;
> > >> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > >>       */
> > >>      notify = virtqueue_kick_prepare(vrp->rvq);
> > >>
> > >> -    /* From this point on, we can notify and get callbacks. */
> > >> -    virtio_device_ready(vdev);
> > >> -
> > >>      /* tell the remote processor it can start sending messages */
> > >>      /*
> > >>       * this might be concurrent with callbacks, but we are only
> > >> --
> > >> 2.34.1
> > >>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
