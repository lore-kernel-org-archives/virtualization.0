Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DF7C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 01:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CC27813EC;
	Fri,  1 Jul 2022 01:22:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CC27813EC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQAxS48R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sviG8aO4TAHV; Fri,  1 Jul 2022 01:22:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1DBE813CC;
	Fri,  1 Jul 2022 01:22:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1DBE813CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99F3DC002D;
	Fri,  1 Jul 2022 01:22:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3AFCDC0011
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05C7360FAF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:22:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05C7360FAF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aQAxS48R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SO_fMy9Y_IxG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:22:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BABB60F40
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BABB60F40
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 01:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656638549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2KH53Wl1gr5UMbynLfVT+FjBM4ZDGlsSeHT6iWm6OnU=;
 b=aQAxS48R1Lnx1vlEDG9WdVZ/k6U/4yWAr4kdTOqZ3NYMcRFzgWOtTPeEiVT0MqDlgV3Vx+
 I78i5ndM77LFzFqpQGfjuKtfOiyWjn8hJohtbKGm8yIPf1BcElr12H6MXx06dMa+9DCKIE
 9l02JafxDLFaTEWftOxjarUwa8NTp8o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-N0rEDQ07OuODfkI-S-VxwA-1; Thu, 30 Jun 2022 21:22:28 -0400
X-MC-Unique: N0rEDQ07OuODfkI-S-VxwA-1
Received: by mail-lj1-f198.google.com with SMTP id
 y8-20020a2eb008000000b0025bf6ec0c6cso55036ljk.20
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 18:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2KH53Wl1gr5UMbynLfVT+FjBM4ZDGlsSeHT6iWm6OnU=;
 b=fwoS/N0Gr4NEr6UrTcDwZx4g/uL+FBCxiEG2V4gdDUAwzxx74hrynLKxQUUe8Fida3
 wYAdYIgGSoBq72erfN4BgPCIKQG6WLzDzcFqSInZCByLwK7wyOeQKyPMvUQm7hpZ1iNM
 Lqe2fDnaBryEO+kN5rEE9jgvVGxvpTLUvTVewWZou0+6fx7grh75JTSiHqGs6m+rcAJe
 mOo1e99Z+Po17fYuDNb6r4yhLVRAIJmAKOLgE2q9oV98dSQBhMo/suwtlt//nC82LaHS
 09WUU9JpyJ46zTzr/hFN+QA1kYztq7J7GN+YiZBz9vFmfJ4vactSXidaDYO/QZihDu91
 GZMQ==
X-Gm-Message-State: AJIora8m4m0JP9iLmHk3DIM+WeWqO/VG9oMHPm/2DoTVgDZYBmyhO9TM
 oZOsR5lBSVtKAncDPfLoMTBuQe+F2r6H6vYGtCcSHYd6GsG2oQrPgtAVLS3vLR1YVvzPVU95+Jx
 1F2hcwyiyaGwRAxKhJlR+9sEaEntKgve1Q/O7qErPMX/E/xCACrVqcO1aWA==
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7390622lfu.411.1656638546148; 
 Thu, 30 Jun 2022 18:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vr8HxTtR3VyCNAME9Etu0HGTUwoK8NFuuJdU03zhtIJfCQW8P7Cfwl91EkAy5W/C6W4aZiLeDVgXy6h3cd8Cw=
X-Received: by 2002:a05:6512:22c3:b0:47f:704b:3820 with SMTP id
 g3-20020a05651222c300b0047f704b3820mr7390605lfu.411.1656638545914; Thu, 30
 Jun 2022 18:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
 <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
 <20220630152003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220630152003-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Jul 2022 09:22:15 +0800
Message-ID: <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Anup Patel <apatel@ventanamicro.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Anup Patel <anup@brainfault.org>,
 linux-remoteproc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, kvm-riscv@lists.infradead.org,
 Atish Patra <atishp@atishpatra.org>,
 Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
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

On Fri, Jul 1, 2022 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
> > + virtualization@lists.linux-foundation.org
> > + jasowang@redhat.com
> > + mst@redhat.com
> >
> > On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
> > <arnaud.pouliquen@foss.st.com> wrote:
> > >
> > > Hi,
> > >
> > > On 6/29/22 19:43, Mathieu Poirier wrote:
> > > > Hi Anup,
> > > >
> > > > On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > > >> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > > >> fails due to both virtqueues (Rx and Tx) marked as broken by the
> > > >> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > > >> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> > > >>
> > > >> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > > >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > >> ---
> > > >>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> > > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >>
> > > >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > >> index 905ac7910c98..71a64d2c7644 100644
> > > >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > >> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > >>      /* and half is dedicated for TX */
> > > >>      vrp->sbufs = bufs_va + total_buf_space / 2;
> > > >>
> > > >> +    /* From this point on, we can notify and get callbacks. */
> > > >> +    virtio_device_ready(vdev);
> > > >> +
> > > >
> > > > Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> > > > potentially be called (by way of rpmsg_recv_done()), which will race with
> > > > virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> > > > rpmsg_recv_done() will fail, potentially breaking remote processors' state
> > > > machines that don't expect their initial name service to fail when the "device"
> > > > has been marked as ready.
> > > >
> > > > What does make me curious though is that nobody on the remoteproc mailing list
> > > > has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> > > > i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> > > > their rig?
> > >
> > > I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> > > I confirm the issue!
> > >
> > > Concerning the solution, I share Mathieu's concern. This could break legacy.
> > > I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
> > >
> > > I this case the patch would be:
> > >
> > > +       /*
> > > +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> > > +        * to ready
> > > +        */
> > > +       __virtio_unbreak_device(vdev);
> > > +
> > >
> > >         /* set up the receive buffers */
> > >         for (i = 0; i < vrp->num_bufs / 2; i++) {
> > >                 struct scatterlist sg;
> > >                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> >
> > This will indeed fix the problem.  On the flip side the kernel
> > documentation for __virtio_unbreak_device() puzzles me...
> > It clearly states that it should be used for probing and restoring but
> > _not_ directly by the driver.  Function rpmsg_probe() is part of
> > probing but also the entry point to a driver.
> >
> > Michael and virtualisation folks, is this the right way to move forward?
>
> I don't think it is, __virtio_unbreak_device is intended for core use.

Can we fill the rx after virtio_device_ready() in this case?

Btw, the driver set driver ok after registering, we probably get a svq
kick before DRIVER_OK?

Thanks

>
> > >
> > > Regards,
> > > Arnaud
> > >
> > > >
> > > > Thanks,
> > > > Mathieu
> > > >
> > > >>      /* set up the receive buffers */
> > > >>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > >>              struct scatterlist sg;
> > > >> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > >>       */
> > > >>      notify = virtqueue_kick_prepare(vrp->rvq);
> > > >>
> > > >> -    /* From this point on, we can notify and get callbacks. */
> > > >> -    virtio_device_ready(vdev);
> > > >> -
> > > >>      /* tell the remote processor it can start sending messages */
> > > >>      /*
> > > >>       * this might be concurrent with callbacks, but we are only
> > > >> --
> > > >> 2.34.1
> > > >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
