Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD03BC433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Apr 2022 08:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5669383F7B;
	Mon, 11 Apr 2022 08:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGA5oPaGT66r; Mon, 11 Apr 2022 08:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B89FF83F77;
	Mon, 11 Apr 2022 08:22:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88882C002F;
	Mon, 11 Apr 2022 08:22:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66B5CC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 520C160E33
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8GuCOdCezFT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:22:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 565D5607F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649665353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPyaIl319ztvqKoCtkHuGci2rqOpStJtnRV8yytfiK0=;
 b=X3z0ARNfoCmeYlswDEKLQ/i/UOqFvG4Cwvd9DORS+CibwbS6fbJMGFVKIQX1ZfHD5D9WXr
 1mem3+NljZAw2Wm/9/+tSMmoUkKjRLMzKY1pw1IXvJbL+GMWtQvTo0pzWlwhycwbLG+ZtV
 EgH0Yk7u+L+RJ77+3UudHGPyyWOqeuE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-yzBnE5GePcSY8crifYGOSQ-1; Mon, 11 Apr 2022 04:22:32 -0400
X-MC-Unique: yzBnE5GePcSY8crifYGOSQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 n2-20020a2e86c2000000b0024b5c8d3a7dso1640826ljj.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 01:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cPyaIl319ztvqKoCtkHuGci2rqOpStJtnRV8yytfiK0=;
 b=DbdVGPkqbvDVtsLo7FfQqdvAF/2Zuvgaj/VHFmPR/2myd90HjHnzckgUas3PZKlbNp
 gTg2soEvFsCniqY/khMVl26xLC9ZjG2YTFAWdixScLcrpZXewwYd+YgKjOz/P7Jll/GB
 OgaXLq6c4DbEpJaCyrSupHp4X4x2R7stUb3hGkP3/5mn2vx5i8Rhq2OzInm+TgHu6P3l
 anOurdb9oUTOSntVcc6dyHRTxtkY02n78RZ9zQNuk2z9HoX6ktloG6Cc7QBKfLCEZqZc
 IXKnHziRplm00IQdDTod6Hy+0Z6YuA5iznfB4eWBrRF2aa9hadDzISOvQ951/7dzOmCM
 KtJw==
X-Gm-Message-State: AOAM532wi5ixdzAIo6rNbl5Y4jiDptoTayWeLsbmE22JUu9LUqgNm8gs
 SZ/4OsFYiow1rvTlrItKnkgZw6ZwvHtgZZGJKWDnRJUGAB9AnnxNa53WzKKZl0fPJYa2hxQh3ij
 VB0IAlFGhEsNbTM5JexpbR8+oOvE6gofoXnpLT+sWrjFdScJwCuVqwBDWog==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr20774689lfv.257.1649665350801; 
 Mon, 11 Apr 2022 01:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy36T1IkIh/LBxNUKNUU+NDYgK6XmC1TUtECkJuaLTLruMjPfiHtpO/zql/yb2VBluB9HiXpVgbuKV8j2NoQ7w=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr20774672lfv.257.1649665350470; Mon, 11
 Apr 2022 01:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org> <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220410034556-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Apr 2022 16:22:19 +0800
Message-ID: <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
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

On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> > On Wed, 06 Apr 2022 15:04:32 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >
> > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> > > >> This patch implements PCI version of synchronize_vqs().
> > > >>
> > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > >
> > > > Please add implementations at least for ccw and mmio.
> > >
> > > I'm not sure what (if anything) can/should be done for ccw...
> >
> > If nothing needs to be done I would like to have at least a comment in
> > the code that explains why. So that somebody who reads the code
> > doesn't wonder: why is virtio-ccw not implementing that callback.
>
> Right.
>
> I am currently thinking instead of making this optional in the
> core we should make it mandatory, and have transports which do not
> need to sync have an empty stub with documentation explaining why.
>
> Also, do we want to document this sync is explicitly for irq enable/disable?
> synchronize_irq_enable_disable?

I would not since the transport is not guaranteed to use an interrupt
for callbacks.

>
>
> > >
> > > >
> > > >> ---
> > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > > >>  4 files changed, 19 insertions(+)
> > > >>
> > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > >> index d724f676608b..b78c8bc93a97 100644
> > > >> --- a/drivers/virtio/virtio_pci_common.c
> > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > >>  }
> > > >>
> > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > > >> +{
> > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > >> +        int i;
> > > >> +
> > > >> +        if (vp_dev->intx_enabled) {
> > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> > > >> +                return;
> > > >> +        }
> > > >> +
> > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > >> +}
> > > >> +
> > >
> > > ...given that this seems to synchronize threaded interrupt handlers?
> > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > > 'irq' for channel devices anyway, and the handler just calls the
> > > relevant callbacks directly.)
> >
> > Sorry I don't understand enough yet. A more verbose documentation on
> > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> > surely benefit me. It may be more than enough for a back-belt but it
> > ain't enough for me to tell what is the callback supposed to accomplish.
> >
> > I will have to study this discussion and the code more thoroughly.
> > Tentatively I side with Jason and Michael in a sense, that I don't
> > believe virtio-ccw is safe against rough interrupts.

That's my feeling as well.

Thanks

> >
> > Sorry for the late response. I intend to revisit this on Monday. If
> > I don't please feel encouraged to ping.
> >
> > Regards,
> > Halil
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
