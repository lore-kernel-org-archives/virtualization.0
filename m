Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7CAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 02:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2071F400EF;
	Tue, 12 Apr 2022 02:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2kqfHtXfaTq; Tue, 12 Apr 2022 02:22:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9CF7D40122;
	Tue, 12 Apr 2022 02:22:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77942C0082;
	Tue, 12 Apr 2022 02:22:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF5CFC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 806C441553
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iTu0r1xIfhZA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:22:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B597A41550
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 02:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649730128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kgaL+lS7AJKt0L5x7qfD+kQMcLLSooLLA8RJRkvK0AM=;
 b=Oq+qSkOUByxh/msgHZDeSXghT11D7WtLDsRyGtZ41rV9NrkknOu3JPjr+QSryTFdX0egak
 Of0VAN6LtT4KnqWfjL6qQ6SJDw92Jcjuph60uXDp6CwFyKSTwe8WiF9TrCPpgbVbA9MVgM
 M81AvoRgSaJFPrji2Kz5mQBzdXbu0/I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-FNf0ENe5NIGZDYF_R4xZjw-1; Mon, 11 Apr 2022 22:22:07 -0400
X-MC-Unique: FNf0ENe5NIGZDYF_R4xZjw-1
Received: by mail-lj1-f199.google.com with SMTP id
 v13-20020a2e87cd000000b0024b8b16b7a5so97011ljj.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 19:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kgaL+lS7AJKt0L5x7qfD+kQMcLLSooLLA8RJRkvK0AM=;
 b=N1bvcSGHcd9enh/PFpjGUZkHAjQr5pb59TF/3PKERjJm7Jko0ah+7VpixU4UT6hQSd
 sT2EjE/d37Pol5ldzuar/grupLaPoNjQVu5ASEfcS4BPenHL1L7HQwDj+1KKaSwlOEzP
 ph2GQUt1jtghCyiJch4qATkZvjzKfQMn4mvCgwC/mTCuZ/ZbH7ClSizvz42W7pTmzlui
 qSbzM6CHiMGIpyZQpqbydeCgMQttjSajYXndU0BnPcpP3mtChg4ASJYpqfiMnFGid2Gi
 yhE99KyFYBub4Uubtz8yrn2hy3RoJxegcQKusydXVUlFDPMkunD8pfFxe18ZDpDAHiLh
 JKWQ==
X-Gm-Message-State: AOAM531tgT37h5bgJUtzzRJsLX9oEYiLQosOYTHC4Y4ZmKNVsIbOml6p
 0RRH7/YJ3MEdk5GmmHcVc1hSsWGAUJRAs3ZT5yYaX6FnLAUtloOZ0SWBCGZJmMo0eHVlbQQp5F7
 plcLqUrsUqmgaEFQITt5g9impaflGRHCAJzzMDllOF3Fy7MvUYHSxr4upBA==
X-Received: by 2002:a05:6512:3093:b0:46b:814c:3a69 with SMTP id
 z19-20020a056512309300b0046b814c3a69mr13913196lfd.376.1649730125667; 
 Mon, 11 Apr 2022 19:22:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj81bElhbWdbHaCw3liipX3LewYs9Ob5vG1YGcd586nyUHN+apJ6xXyev/cxx4QUdrcqnamFGnFTrKbUAmXBw=
X-Received: by 2002:a05:6512:3093:b0:46b:814c:3a69 with SMTP id
 z19-20020a056512309300b0046b814c3a69mr13913187lfd.376.1649730125467; Mon, 11
 Apr 2022 19:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <20220411045011-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220411045011-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Apr 2022 10:21:54 +0800
Message-ID: <CACGkMEs6vnE8pcDEn2smvTPNnE015kgzk=+qsopg_Zh2GZMOwA@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Mon, Apr 11, 2022 at 4:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Apr 11, 2022 at 04:22:19PM +0800, Jason Wang wrote:
> > On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> > > > On Wed, 06 Apr 2022 15:04:32 +0200
> > > > Cornelia Huck <cohuck@redhat.com> wrote:
> > > >
> > > > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >
> > > > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> > > > > >> This patch implements PCI version of synchronize_vqs().
> > > > > >>
> > > > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > Please add implementations at least for ccw and mmio.
> > > > >
> > > > > I'm not sure what (if anything) can/should be done for ccw...
> > > >
> > > > If nothing needs to be done I would like to have at least a comment in
> > > > the code that explains why. So that somebody who reads the code
> > > > doesn't wonder: why is virtio-ccw not implementing that callback.
> > >
> > > Right.
> > >
> > > I am currently thinking instead of making this optional in the
> > > core we should make it mandatory, and have transports which do not
> > > need to sync have an empty stub with documentation explaining why.
> > >
> > > Also, do we want to document this sync is explicitly for irq enable/disable?
> > > synchronize_irq_enable_disable?
> >
> > I would not since the transport is not guaranteed to use an interrupt
> > for callbacks.
>
> OK but let's then document this in more detail.
> More readers will wonder about what is the callback
> trying to accomplish, and Halil requested that as well.
>
> For example, let's document why is sync required on enable.

Ok.

Thanks

>
> > >
> > >
> > > > >
> > > > > >
> > > > > >> ---
> > > > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > > > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > > > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > > > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > > > > >>  4 files changed, 19 insertions(+)
> > > > > >>
> > > > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > > >> index d724f676608b..b78c8bc93a97 100644
> > > > > >> --- a/drivers/virtio/virtio_pci_common.c
> > > > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > > > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > >>  }
> > > > > >>
> > > > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > > > > >> +{
> > > > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > > >> +        int i;
> > > > > >> +
> > > > > >> +        if (vp_dev->intx_enabled) {
> > > > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> > > > > >> +                return;
> > > > > >> +        }
> > > > > >> +
> > > > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > > >> +}
> > > > > >> +
> > > > >
> > > > > ...given that this seems to synchronize threaded interrupt handlers?
> > > > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > > > > 'irq' for channel devices anyway, and the handler just calls the
> > > > > relevant callbacks directly.)
> > > >
> > > > Sorry I don't understand enough yet. A more verbose documentation on
> > > > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> > > > surely benefit me. It may be more than enough for a back-belt but it
> > > > ain't enough for me to tell what is the callback supposed to accomplish.
> > > >
> > > > I will have to study this discussion and the code more thoroughly.
> > > > Tentatively I side with Jason and Michael in a sense, that I don't
> > > > believe virtio-ccw is safe against rough interrupts.
> >
> > That's my feeling as well.
> >
> > Thanks
> >
> > > >
> > > > Sorry for the late response. I intend to revisit this on Monday. If
> > > > I don't please feel encouraged to ping.
> > > >
> > > > Regards,
> > > > Halil
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
