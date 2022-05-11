Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C117FC433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 09:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B56C83298;
	Wed, 11 May 2022 09:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D5UFB5x6Bcky; Wed, 11 May 2022 09:28:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7F6183294;
	Wed, 11 May 2022 09:28:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B92D7C0032;
	Wed, 11 May 2022 09:28:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 668AFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F5C183294
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vzOQVwpfKn5P
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BBFF82FA2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652261280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehAdFMHQin7sBzIsjKPJMBNM1tNTUowv6Coiiw6E2YI=;
 b=bKKCg1m8r9y+gSruvmXUWmM9bQd7gUeWSwJ4cyCeE5kMK1sE79iAtWHBKmgyKdLmNsdEuO
 /+UZVlyZ6/Z2ATVDMJ3vDHHqUt9j2XXyv0QTG9cn0MuItUGTND3mQKxSe+9Tu/V48fcLxv
 M8YaiMo8PgiU97TbPh2ZowubOSlaVhg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-7v3BjiDVPC6tu2TopxOVAw-1; Wed, 11 May 2022 05:27:57 -0400
X-MC-Unique: 7v3BjiDVPC6tu2TopxOVAw-1
Received: by mail-lf1-f71.google.com with SMTP id
 br16-20020a056512401000b004739cf51722so600489lfb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ehAdFMHQin7sBzIsjKPJMBNM1tNTUowv6Coiiw6E2YI=;
 b=NBD609x+XvqRywEPB30Ffj22CD1ZX+CPHB4hdqSTjb56Dk8luQUYlM1NalEv1mYT0p
 bNcFn1jhRdWG9/SI25ax3igvYi+oOzzjUSD1kcBADpVU6Pc8J6/s14Ie44UZvpvawBbl
 5DJYk4Ue/9kDpZkrX2SzXS72Ub8Ev2VCIwH/wfC6RKC+SRorfZXnC6ul0MfkHGdPRi3v
 MDjW2Rr0MOOqicWy7gVB2hYa1bEI6iz2MAMtXVqADZwcuSx39/KdK9AQnJ0NqWIhuSjC
 teimuFYg5iObaEHv9fBu1/tAvOItksm3ncQQE0zwlnT223adM4JMjFEzGytvsMriJSgh
 l09w==
X-Gm-Message-State: AOAM530odx8ZgQ+ex4y488PEATkdEeM9BHAr7skIK/h9+XOIOmWh/X8h
 V1Ed/U3nW6RE446T5F11Gnok2HDzBauj4jCuvvUbpJzHovcu/sDhrunMlU0ad5J2lXum7zsvLZz
 pmTeaJHbAG8xdxcbGsFr+PjtVlUyWuHnrP9x8Ws4UiBIfQmx8zRP5XperOA==
X-Received: by 2002:a2e:b057:0:b0:24f:2668:833b with SMTP id
 d23-20020a2eb057000000b0024f2668833bmr16382003ljl.300.1652261276038; 
 Wed, 11 May 2022 02:27:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5pnyy7RM02GVjjr25zdMxywsAUXwIZXeHQ+BpJH/yZ8wlAwtqIUV0+RNxrlNjUJdUnXcetv7Su7hXh9EzXk4=
X-Received: by 2002:a2e:b057:0:b0:24f:2668:833b with SMTP id
 d23-20020a2eb057000000b0024f2668833bmr16381981ljl.300.1652261275822; Wed, 11
 May 2022 02:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org>
 <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
 <87o804bgrl.fsf@redhat.com>
In-Reply-To: <87o804bgrl.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 17:27:44 +0800
Message-ID: <CACGkMEt0WdaVCbzeJ9KJuLw273D6KjSOG85RCk675QW3ZxvEsQ@mail.gmail.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
To: Cornelia Huck <cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, May 11, 2022 at 4:44 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> >> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> >> > index d8a2340f928e..23f1694cdbd5 100644
> >> > --- a/include/linux/virtio_config.h
> >> > +++ b/include/linux/virtio_config.h
> >> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
> >> >       unsigned status = dev->config->get_status(dev);
> >> >
> >> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> >> > +
> >> > +     /*
> >> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> >> > +      * will see the driver specific setup if it sees vq->broken
> >> > +      * as false.
> >> > +      */
> >> > +     virtio_synchronize_cbs(dev);
> >>
> >> since you mention vq->broken above, maybe add
> >>         "set vq->broken to false"
> >
> > Ok.
> >
> >>
> >> > +     __virtio_unbreak_device(dev);
> >> > +     /*
> >> > +      * The transport is expected ensure the visibility of
> >>
> >> to ensure
> >
> > Will fix.
> >
> >>
> >> > +      * vq->broken
> >>
> >> let's add: "visibility by vq callbacks"
> >
> > Sure.
> >
> >>
> >> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
> >> > +      */
> >>
> >>
> >> Can I see some analysis of existing transports showing
> >> this is actually the case for them?
> >
> > Yes.
> >
> >> And maybe add a comment near set_status to document the
> >> requirement.
> >
> > For PCI and MMIO, we can quote the memory-barriers.txt or explain that
> > wmb() is not needed before the MMIO writel().
> > For CCW, it looks not obvious, it looks to me the IO was submitted via
> > __ssch() which has an inline assembly.  Cornelia and Hali, could you
> > help me to understand if and how did virtio_ccw_set_status() can
> > ensure the visibility of the previous driver setup and vq->broken
> > here?
>
> I'm not sure I completely understand the question here, but let me try:

It's something like the following case:

CPU 0: vq->broken = false
CPU 0: set_status(DRIVER_OK)
CPU 1: vring_interrupt() { if (vq->broken) return IRQ_NONE; }

We need to make sure the CPU 1 sees the vq->broken if the interrupt is
raised after DRVER_OK.

For PCI, we use MMIO of writel() for set_status(), a wmb() is not
needed in this case according to memory-barriers.txt.

"
Note that, when using writel(), a prior
wmb() is not needed to guarantee that the cache coherent memory writes
have completed before writing to the MMIO region.
"

So CPU 1 will see the broken as false.

>
> virtio_ccw_set_status() uses a channel command to set the status, with
> the interesting stuff done inside ccw_io_helper(). That function
> - takes the subchannel lock, disabling interrupts

Then it is, for x86 the operation to disable interrupt is a full
barrier. I guess this should apply to other architecture like s390. I
see a stnsm is used in this case but a quick google doesn't tell me if
it's a barrier.
If this is true. The vring_interrupt will see broken as false.

> - does the ssch; this instruction will fail if there's already another
>   I/O in progress, or an interrupt is pending for the subchannel; on
>   success, it is guaranteed that we'll get an interrupt eventually

I guess ssch might imply a barrier as well, otherwise we may need a
lot of barriers before this.

Thanks

> - unlock the subchannel, and wait for the interupt handler to eventually
>   process the interrupt, so I guess it should see the vq->broken value?
>
> If the I/O fails, virtio_ccw_set_status() will revert its internal
> status to the old value.
>
>
> >
> > Thanks
> >
> >>
> >> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >> >  }
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
