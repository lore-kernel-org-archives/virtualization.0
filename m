Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AADEC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 04:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F9A440121;
	Mon,  4 Jul 2022 04:35:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F9A440121
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFcmiqlX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogKavSzW5UfU; Mon,  4 Jul 2022 04:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3E7F40114;
	Mon,  4 Jul 2022 04:35:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3E7F40114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1933C0032;
	Mon,  4 Jul 2022 04:35:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7449CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57260826A8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:35:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57260826A8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFcmiqlX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YYZWpogNtczF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:35:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20A6782681
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20A6782681
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 04:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656909350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OCkbv3Cf/ewB5K2eBAbJzqiucJZei1sySPuP3qYRfnk=;
 b=FFcmiqlXd3r6zgs5LGqDVWm8mf0ISvB43tZJ+bwwOEndLZX0oVxvnX1ewedzbxUlsdlXOs
 h75UQCS+tl1foq5H4g+bdRDioqUkw0m7Lro0E5OyyLjhAeiN/ohzWUUjej4RzRI41X8mMw
 OEZQwLoHH738wKHKAsQv9cILjfTaM7Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-tDAIk2YpMX2av2ddNYMljA-1; Mon, 04 Jul 2022 00:35:50 -0400
X-MC-Unique: tDAIk2YpMX2av2ddNYMljA-1
Received: by mail-lf1-f71.google.com with SMTP id
 f29-20020a19dc5d000000b004811c8d1918so2570928lfj.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 21:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OCkbv3Cf/ewB5K2eBAbJzqiucJZei1sySPuP3qYRfnk=;
 b=osHGew11qCmsLZlJWmic+XtPRJc/NNyw8j5po2wL0YBnVxzMuzy2eHh5DhaadD/OaS
 +ErJSFANfRF4lTlkwgCS1Cr4GrZPTWFHtNhZADjE39WMcf5tCF9VITk6pB0hJqTUP0ij
 OzjsDBllajs8JkcSeHYhxemXfr9ZwtsZu3RpelxgBlfe7MpR7Z+3YmfQ5swOReRDFYfq
 f/KFLo5825TCG0g0H9B+Rh0jG35/sE0Vjcf0V2sv2QjF1n8yqahHPHO4whckvBD6F6Fq
 soAzrv9QFjZ0hHeLI8J+6f5Z0g5s7jdVn67mjai/jjWaiMSfPi9QfC5TVcaygz0O7H+M
 CIFw==
X-Gm-Message-State: AJIora8Ksz/yfh79IgG8IKI4GZ2FVStu1e6nNxX+LXQLCV5sRgml4BMy
 9cOnPr0b5CGnhsDJgTUiYvIO4+e5zzFfyheq9EcYid9wKJRpFxKsc8Ne+Aj+kjUD8yHVHtqVLkI
 h01xSSgTagsdsCHyiYt7lXFUNvUSqFEGUlKC9F4Y4laWCF/Hy/0b1FNhaIw==
X-Received: by 2002:a2e:9799:0:b0:25d:15f5:228e with SMTP id
 y25-20020a2e9799000000b0025d15f5228emr4942284lji.251.1656909347697; 
 Sun, 03 Jul 2022 21:35:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcvswtM6JMnT0NY9Gc4qiCju7VRajzTVCSlRuuO9lTUrwgo9jWzyBeZSF0aiVmkCjl7CaDYPK6X+E1ASeWrF8=
X-Received: by 2002:a2e:9799:0:b0:25d:15f5:228e with SMTP id
 y25-20020a2e9799000000b0025d15f5228emr4942267lji.251.1656909347454; Sun, 03
 Jul 2022 21:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
 <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
 <20220630152003-mutt-send-email-mst@kernel.org>
 <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
 <20220701021536-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220701021536-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 4 Jul 2022 12:35:36 +0800
Message-ID: <CACGkMEtkVmq2+NtDpp-XWZFD_WO6Dzm4=pcVwg-aKmStAqJCVg@mail.gmail.com>
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

On Fri, Jul 1, 2022 at 2:16 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jul 01, 2022 at 09:22:15AM +0800, Jason Wang wrote:
> > On Fri, Jul 1, 2022 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
> > > > + virtualization@lists.linux-foundation.org
> > > > + jasowang@redhat.com
> > > > + mst@redhat.com
> > > >
> > > > On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
> > > > <arnaud.pouliquen@foss.st.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On 6/29/22 19:43, Mathieu Poirier wrote:
> > > > > > Hi Anup,
> > > > > >
> > > > > > On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > > > > >> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > > > > >> fails due to both virtqueues (Rx and Tx) marked as broken by the
> > > > > >> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > > > > >> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> > > > > >>
> > > > > >> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > > > > >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > > >> ---
> > > > > >>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> > > > > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >>
> > > > > >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > > >> index 905ac7910c98..71a64d2c7644 100644
> > > > > >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > > >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > > >> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > > > >>      /* and half is dedicated for TX */
> > > > > >>      vrp->sbufs = bufs_va + total_buf_space / 2;
> > > > > >>
> > > > > >> +    /* From this point on, we can notify and get callbacks. */
> > > > > >> +    virtio_device_ready(vdev);
> > > > > >> +
> > > > > >
> > > > > > Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> > > > > > potentially be called (by way of rpmsg_recv_done()), which will race with
> > > > > > virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> > > > > > rpmsg_recv_done() will fail, potentially breaking remote processors' state
> > > > > > machines that don't expect their initial name service to fail when the "device"
> > > > > > has been marked as ready.
> > > > > >
> > > > > > What does make me curious though is that nobody on the remoteproc mailing list
> > > > > > has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> > > > > > i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> > > > > > their rig?
> > > > >
> > > > > I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> > > > > I confirm the issue!
> > > > >
> > > > > Concerning the solution, I share Mathieu's concern. This could break legacy.
> > > > > I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
> > > > >
> > > > > I this case the patch would be:
> > > > >
> > > > > +       /*
> > > > > +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> > > > > +        * to ready
> > > > > +        */
> > > > > +       __virtio_unbreak_device(vdev);
> > > > > +
> > > > >
> > > > >         /* set up the receive buffers */
> > > > >         for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > > >                 struct scatterlist sg;
> > > > >                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> > > >
> > > > This will indeed fix the problem.  On the flip side the kernel
> > > > documentation for __virtio_unbreak_device() puzzles me...
> > > > It clearly states that it should be used for probing and restoring but
> > > > _not_ directly by the driver.  Function rpmsg_probe() is part of
> > > > probing but also the entry point to a driver.
> > > >
> > > > Michael and virtualisation folks, is this the right way to move forward?
> > >
> > > I don't think it is, __virtio_unbreak_device is intended for core use.
> >
> > Can we fill the rx after virtio_device_ready() in this case?
> >
> > Btw, the driver set driver ok after registering, we probably get a svq
> > kick before DRIVER_OK?
> >
> > Thanks
>
> Is this an ack for the original patch?

Nope, I meant, instead of moving virtio_device_ready() a little bit
earlier, can we only move the rvq filling after virtio_device_ready().

Thanks

>
> > >
> > > > >
> > > > > Regards,
> > > > > Arnaud
> > > > >
> > > > > >
> > > > > > Thanks,
> > > > > > Mathieu
> > > > > >
> > > > > >>      /* set up the receive buffers */
> > > > > >>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > > > >>              struct scatterlist sg;
> > > > > >> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > > > >>       */
> > > > > >>      notify = virtqueue_kick_prepare(vrp->rvq);
> > > > > >>
> > > > > >> -    /* From this point on, we can notify and get callbacks. */
> > > > > >> -    virtio_device_ready(vdev);
> > > > > >> -
> > > > > >>      /* tell the remote processor it can start sending messages */
> > > > > >>      /*
> > > > > >>       * this might be concurrent with callbacks, but we are only
> > > > > >> --
> > > > > >> 2.34.1
> > > > > >>
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
