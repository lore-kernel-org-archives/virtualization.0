Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C44C433EF
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 03:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 162AB60784;
	Thu, 12 May 2022 03:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03dexpM4nbrO; Thu, 12 May 2022 03:27:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 708F860B5A;
	Thu, 12 May 2022 03:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40FB2C0032;
	Thu, 12 May 2022 03:27:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 652F4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D7CA60B5A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xlEyk30cwqLw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:27:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0AF960784
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 03:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652326065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lVQIk7XWLCbb+j6Gb7OWizoocgmR8cWGvz7hpNAv2/Y=;
 b=Yvnpu5ZDMTX3tPhHTqcv5vMBqhD1JmYluNxdD2tZ59p/2OALdSlhD9WMNz+KURJJgqt4wj
 DDqr+Gap0BvCA6l9DP77teYO7GQ3UWKWcsC5pZBMqgKcAWGsrLrnKAN7SmI/y4hbDTDAU9
 +fzbuiQL4KV2qdPw/POX6u3RBtIHL0w=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-l7Sm4A7NPK6gN8U6S7OTHA-1; Wed, 11 May 2022 23:27:44 -0400
X-MC-Unique: l7Sm4A7NPK6gN8U6S7OTHA-1
Received: by mail-lf1-f72.google.com with SMTP id
 h34-20020a0565123ca200b00473e2754d00so1624168lfv.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 20:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lVQIk7XWLCbb+j6Gb7OWizoocgmR8cWGvz7hpNAv2/Y=;
 b=6iYZLvd8Swm2be2OsL/U+Rh251xERn4T9IAybmDk6X1xUjqWiD4+N73KUjWfm2DePi
 3P7YIX+J+LENuVqbbsqnO+2YROPSUMcoWlMA5GmQZVdDQDuUooMXQPL+Ly7buKzGKnqr
 WO0mqE+r2mIOy5PL1R0Ya1JY6AkRW/LYh4oELEukEw5n7NwAZsh4LZNS7cZewY4kHp4c
 1JmcEPePerj4/1y2/kKRvzNmC+H/XXx9bE3/TeUbUbNh7XsRHfxFamZISmgfPaSa0aLb
 61+3INB194bCyhpQBHMQX+fe3OTca+E7qan7eNa3tBbK32js7aZ4zu+Ofsl+JD+f9fEl
 EPIA==
X-Gm-Message-State: AOAM5319/8/ENi/pq2Zhet3mgrTjLxzaj0mVhYBlEyCxPRVc6AwlRDpp
 z+KpomKwbjrSWXWPh9KujhMoW/rIhUysU980HVt2DUr51f6a7LdcKt/zpGmxc57JS0RInSL7woL
 j148GjA8RNhF3VRLixgITcVVGbfKI239R3R+gB67C+Q1dLO0BxAsrxJSQqA==
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr15637835lfr.257.1652326062920; 
 Wed, 11 May 2022 20:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxStChmH/rVzb4XHKdnq3dQVyoUrB/39XSF0wz703iGtewPdHYj/3MruOM+2TroG/vmJKeEXh+tUmqyP34HsmQ=
X-Received: by 2002:ac2:4e14:0:b0:474:1f4d:9b86 with SMTP id
 e20-20020ac24e14000000b004741f4d9b86mr15637813lfr.257.1652326062677; Wed, 11
 May 2022 20:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com>
 <20220507071954.14455-9-jasowang@redhat.com>
 <20220510072833-mutt-send-email-mst@kernel.org>
 <CACGkMEtBfdhx-9CMKD0F4+536e5ewf6NQJGPTEBX00uby-C8+w@mail.gmail.com>
 <87o804bgrl.fsf@redhat.com>
 <CACGkMEt0WdaVCbzeJ9KJuLw273D6KjSOG85RCk675QW3ZxvEsQ@mail.gmail.com>
 <20220511144915.02efda98.pasic@linux.ibm.com>
In-Reply-To: <20220511144915.02efda98.pasic@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 May 2022 11:27:31 +0800
Message-ID: <CACGkMEuiA1Q9Z4aXKj51y8Ad+caLkrG_NvLcQvwMfnpWQ7kjzA@mail.gmail.com>
Subject: Re: [PATCH V4 8/9] virtio: harden vring IRQ
To: Halil Pasic <pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Cindy Lu <lulu@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, May 11, 2022 at 8:49 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Wed, 11 May 2022 17:27:44 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
> > On Wed, May 11, 2022 at 4:44 PM Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > On Wed, May 11 2022, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > > On Tue, May 10, 2022 at 7:32 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >>
> > > >> On Sat, May 07, 2022 at 03:19:53PM +0800, Jason Wang wrote:
> > > >> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > > >> > index d8a2340f928e..23f1694cdbd5 100644
> > > >> > --- a/include/linux/virtio_config.h
> > > >> > +++ b/include/linux/virtio_config.h
> > > >> > @@ -256,6 +256,18 @@ void virtio_device_ready(struct virtio_device *dev)
> > > >> >       unsigned status = dev->config->get_status(dev);
> > > >> >
> > > >> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > > >> > +
> > > >> > +     /*
> > > >> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > > >> > +      * will see the driver specific setup if it sees vq->broken
> > > >> > +      * as false.
> > > >> > +      */
> > > >> > +     virtio_synchronize_cbs(dev);
> > > >>
> > > >> since you mention vq->broken above, maybe add
> > > >>         "set vq->broken to false"
> > > >
> > > > Ok.
> > > >
> > > >>
> > > >> > +     __virtio_unbreak_device(dev);
> > > >> > +     /*
> > > >> > +      * The transport is expected ensure the visibility of
> > > >>
> > > >> to ensure
> > > >
> > > > Will fix.
> > > >
> > > >>
> > > >> > +      * vq->broken
> > > >>
> > > >> let's add: "visibility by vq callbacks"
> > > >
> > > > Sure.
> > > >
> > > >>
> > > >> > before setting VIRTIO_CONFIG_S_DRIVER_OK.
> > > >> > +      */
> > > >>
> > > >>
> > > >> Can I see some analysis of existing transports showing
> > > >> this is actually the case for them?
> > > >
> > > > Yes.
> > > >
> > > >> And maybe add a comment near set_status to document the
> > > >> requirement.
> > > >
> > > > For PCI and MMIO, we can quote the memory-barriers.txt or explain that
> > > > wmb() is not needed before the MMIO writel().
> > > > For CCW, it looks not obvious, it looks to me the IO was submitted via
> > > > __ssch() which has an inline assembly.  Cornelia and Hali, could you
> > > > help me to understand if and how did virtio_ccw_set_status() can
> > > > ensure the visibility of the previous driver setup and vq->broken
> > > > here?
> > >
> > > I'm not sure I completely understand the question here, but let me try:
> >
> > It's something like the following case:
> >
> > CPU 0: vq->broken = false
> > CPU 0: set_status(DRIVER_OK)
> > CPU 1: vring_interrupt() { if (vq->broken) return IRQ_NONE; }
> >
> > We need to make sure the CPU 1 sees the vq->broken if the interrupt is
> > raised after DRVER_OK.
> >
> > For PCI, we use MMIO of writel() for set_status(), a wmb() is not
> > needed in this case according to memory-barriers.txt.
> >
> > "
> > Note that, when using writel(), a prior
> > wmb() is not needed to guarantee that the cache coherent memory writes
> > have completed before writing to the MMIO region.
> > "
>
>
> IMHO the key facts here are the following:
> * ssch and all other I/O instructions are serializing instructions
> * all interruptions are serializing operations
>
> For reference see
> https://www.ibm.com/resources/publications/OutputPubsDetails?PubID=SA22783213
> page 5-138.

I see thanks for the pointer.

>
>
> Maybe we should add that to the linux documentation somewhere if
> not already mentioned.

Maybe somewhere in memory-barriers.txt.

>
> So IMHO we don't need CPU0 to do a wmb() because of the ssch.
>

Right.

> >
> > So CPU 1 will see the broken as false.
>
> But barriers need to be paired.

Yes, actually the pairing is done by the device where it need something like:

if (get_status(DRIVER_OK)) {
    rmb();
    start_device_logic();
    raise_interrupt();
}

> And in my understanding the ssch
> doesn't really ensure that CPU1 is about to see the change, unless
> there is a suitable barrier that pairs with the barrier implied
> the ssch instruction.
>
> Assumed vring_interrupt() is always done in hard-irq context, AFAIU,
> we should be fine. Is that assumption correct?
>
> Why are we fine:
> * Either the ssch was performed before the interrupt for
>   vring_interrupt() got delivered on CPU1, and then we are guaranteed to
>   see the updated value for vq->broken,

Yes, for a well behaved device, the device will raise the interrupt
after it sees DRIVER_OK and the ssch guarantees that when the device
sees DRIVER_OK vq->broken is false.

> * or the interrupt that triggered vring_interrupt() was delivered before
>   the ssch instruction got executed. But in this case it is fine to
>   ignore the notification, because this is actually the bad case
>   we want to guard against: we got a notification when
>   notifications are not allowed.

Exactly.

>
> We may end up with !vq->broken and !DEVICE_OK as well, but that should
> be fine because, although that notification would be a should not happen
> one, I understand it would not catch us with our pants down.

Right.

>
> Regards,
> Halil
>
>
> >
> > >
> > > virtio_ccw_set_status() uses a channel command to set the status, with
> > > the interesting stuff done inside ccw_io_helper(). That function
> > > - takes the subchannel lock, disabling interrupts
> >
> > Then it is, for x86 the operation to disable interrupt is a full
> > barrier. I guess this should apply to other architecture like s390. I
> > see a stnsm is used in this case but a quick google doesn't tell me if
> > it's a barrier.

Looks like it's not a serialization instruction and this
memory-barriers.rst told me irq-disabling is only a compiler barrier:

"""
Functions that disable interrupts (ACQUIRE equivalent) and enable interrupts
(RELEASE equivalent) will act as compiler barriers only.  So if memory or I/O
barriers are required in such a situation, they must be provided from some
other means.
"""

Thanks

> > If this is true. The vring_interrupt will see broken as false.
> >
> > > - does the ssch; this instruction will fail if there's already another
> > >   I/O in progress, or an interrupt is pending for the subchannel; on
> > >   success, it is guaranteed that we'll get an interrupt eventually
> >
> > I guess ssch might imply a barrier as well, otherwise we may need a
> > lot of barriers before this.
> >
> > Thanks
> >
> > > - unlock the subchannel, and wait for the interupt handler to eventually
> > >   process the interrupt, so I guess it should see the vq->broken value?
> > >
> > > If the I/O fails, virtio_ccw_set_status() will revert its internal
> > > status to the old value.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > >>
> > > >> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> > > >> >  }
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
