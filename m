Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45C9C433EF
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 06:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BC038453C;
	Fri,  1 Jul 2022 06:16:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BC038453C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GA77VVPw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w_gOz0pDgE0R; Fri,  1 Jul 2022 06:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5AF884509;
	Fri,  1 Jul 2022 06:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5AF884509
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 954FFC0035;
	Fri,  1 Jul 2022 06:16:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB409C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A15B741821
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A15B741821
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GA77VVPw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ZUsdfPE61Vz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14FB341817
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14FB341817
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656656188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oQcqzOck2DuwcNM73kgG2jczvXmy2C2LBERQCOmlyiI=;
 b=GA77VVPwh3+6iH36hmXlr3pq9725qeOoNNtCNe4lNKcZNIu1XGsggWJTUmmxw+0UzHgedD
 XKolKDcEmyww3ul/oD9hkdEGNzFzYHhpV2lf6HwgMKpdig4e/rWKgIcz80vfWG3wUxRQHR
 S9DEe4ZrVXvPmz+djFHr/s5TnWmgcmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-YUj0rhNWMNC1W0x808Q-rA-1; Fri, 01 Jul 2022 02:16:28 -0400
X-MC-Unique: YUj0rhNWMNC1W0x808Q-rA-1
Received: by mail-wm1-f72.google.com with SMTP id
 j35-20020a05600c1c2300b003a167dfa0ecso900632wms.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 23:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oQcqzOck2DuwcNM73kgG2jczvXmy2C2LBERQCOmlyiI=;
 b=6I+FHk69Wg3EZCMg+MVoWEAziIlqBO3ssysYG7Pd14oGJ2vBKwGfAUN8a/mnQAgOsV
 Cx8aXXPATAGwPdkMR5Y4KZa93nE9A4w7vxJTiOFuDgmnzPs6JYiz8vM+VyDproE8LdSd
 4n4tCNxADAFkcBjaYvu8iaqUSwZWqMIrWDCWekZjnUBCxCYGYfbTADERxH4J0jV902YD
 w3PipNKrwHz6+n5g5QcvLHV4nI8ZfUyiQw5nBN/snwMYBTadOM2buRDZlUi7xhdAFn1M
 WM3IYfO1urwy0MP4LU51KHv7O+3FQ+VRYszJ/vE/ElVjHFbL5w9M6apO1V5NrxNot+Bg
 +Myg==
X-Gm-Message-State: AJIora/GvywoIRPUiB6zmLiB3FE3jRPC2i5e/nPXCvOvzXBH6tvoeOdJ
 8yBrmTER/5YJpHCz6yagnrbcMwuKGEWpe4K4FdIO6IBDuGFDheOrKJKQWLB8iR35Y+pNf+jm5QA
 Zx6JknaxUE2LxISRwkVU1pVl01C5/noS9Cc2KrMiajA==
X-Received: by 2002:a5d:66cc:0:b0:21b:8f5e:875b with SMTP id
 k12-20020a5d66cc000000b0021b8f5e875bmr12310702wrw.51.1656656186487; 
 Thu, 30 Jun 2022 23:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sMilVx6tjb5laNf/Aur4jV+NAQ//xh8lkTlel5AbEo0b2M+156IA+k0C6GVkoRBrkTGbOFHg==
X-Received: by 2002:a5d:66cc:0:b0:21b:8f5e:875b with SMTP id
 k12-20020a5d66cc000000b0021b8f5e875bmr12310670wrw.51.1656656186220; 
 Thu, 30 Jun 2022 23:16:26 -0700 (PDT)
Received: from redhat.com ([2.55.35.209]) by smtp.gmail.com with ESMTPSA id
 c16-20020adfe750000000b002103a7c5c91sm20925668wrn.43.2022.06.30.23.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 23:16:25 -0700 (PDT)
Date: Fri, 1 Jul 2022 02:16:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Message-ID: <20220701021536-mutt-send-email-mst@kernel.org>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
 <20220629174318.GB2018382@p14s>
 <bf87a50c-6d92-8657-72a9-75af81d2489f@foss.st.com>
 <CANLsYkzHZMV3eVUn3Xpk0eiAexyr9HC5__K9xfAwfm23nuQj=A@mail.gmail.com>
 <20220630152003-mutt-send-email-mst@kernel.org>
 <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtHuoHT6meHacsie8M87yjUX3jGEvP7BuU_Vrb3yqkDWw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Fri, Jul 01, 2022 at 09:22:15AM +0800, Jason Wang wrote:
> On Fri, Jul 1, 2022 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 30, 2022 at 11:51:30AM -0600, Mathieu Poirier wrote:
> > > + virtualization@lists.linux-foundation.org
> > > + jasowang@redhat.com
> > > + mst@redhat.com
> > >
> > > On Thu, 30 Jun 2022 at 10:20, Arnaud POULIQUEN
> > > <arnaud.pouliquen@foss.st.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 6/29/22 19:43, Mathieu Poirier wrote:
> > > > > Hi Anup,
> > > > >
> > > > > On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> > > > >> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> > > > >> fails due to both virtqueues (Rx and Tx) marked as broken by the
> > > > >> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> > > > >> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> > > > >>
> > > > >> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> > > > >> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > >> ---
> > > > >>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
> > > > >>  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >>
> > > > >> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > >> index 905ac7910c98..71a64d2c7644 100644
> > > > >> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > >> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > > > >> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > > >>      /* and half is dedicated for TX */
> > > > >>      vrp->sbufs = bufs_va + total_buf_space / 2;
> > > > >>
> > > > >> +    /* From this point on, we can notify and get callbacks. */
> > > > >> +    virtio_device_ready(vdev);
> > > > >> +
> > > > >
> > > > > Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
> > > > > potentially be called (by way of rpmsg_recv_done()), which will race with
> > > > > virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
> > > > > rpmsg_recv_done() will fail, potentially breaking remote processors' state
> > > > > machines that don't expect their initial name service to fail when the "device"
> > > > > has been marked as ready.
> > > > >
> > > > > What does make me curious though is that nobody on the remoteproc mailing list
> > > > > has complained about commit 8b4ec69d7e09 breaking their environment... By now,
> > > > > i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
> > > > > their rig?
> > > >
> > > > I tested on STm32mp1 board using tag v5.19-rc4(03c765b0e3b4)
> > > > I confirm the issue!
> > > >
> > > > Concerning the solution, I share Mathieu's concern. This could break legacy.
> > > > I made a short test and I would suggest to use __virtio_unbreak_device instead, tounbreak the virtqueues without changing the init sequence.
> > > >
> > > > I this case the patch would be:
> > > >
> > > > +       /*
> > > > +        * Unbreak the virtqueues to allow to add buffers before setting the vdev status
> > > > +        * to ready
> > > > +        */
> > > > +       __virtio_unbreak_device(vdev);
> > > > +
> > > >
> > > >         /* set up the receive buffers */
> > > >         for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > >                 struct scatterlist sg;
> > > >                 void *cpu_addr = vrp->rbufs + i * vrp->buf_size;
> > >
> > > This will indeed fix the problem.  On the flip side the kernel
> > > documentation for __virtio_unbreak_device() puzzles me...
> > > It clearly states that it should be used for probing and restoring but
> > > _not_ directly by the driver.  Function rpmsg_probe() is part of
> > > probing but also the entry point to a driver.
> > >
> > > Michael and virtualisation folks, is this the right way to move forward?
> >
> > I don't think it is, __virtio_unbreak_device is intended for core use.
> 
> Can we fill the rx after virtio_device_ready() in this case?
> 
> Btw, the driver set driver ok after registering, we probably get a svq
> kick before DRIVER_OK?
> 
> Thanks

Is this an ack for the original patch?

> >
> > > >
> > > > Regards,
> > > > Arnaud
> > > >
> > > > >
> > > > > Thanks,
> > > > > Mathieu
> > > > >
> > > > >>      /* set up the receive buffers */
> > > > >>      for (i = 0; i < vrp->num_bufs / 2; i++) {
> > > > >>              struct scatterlist sg;
> > > > >> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
> > > > >>       */
> > > > >>      notify = virtqueue_kick_prepare(vrp->rvq);
> > > > >>
> > > > >> -    /* From this point on, we can notify and get callbacks. */
> > > > >> -    virtio_device_ready(vdev);
> > > > >> -
> > > > >>      /* tell the remote processor it can start sending messages */
> > > > >>      /*
> > > > >>       * this might be concurrent with callbacks, but we are only
> > > > >> --
> > > > >> 2.34.1
> > > > >>
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
