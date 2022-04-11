Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A10DC433EF
	for <virtualization@archiver.kernel.org>; Mon, 11 Apr 2022 08:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C11C683FC8;
	Mon, 11 Apr 2022 08:56:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aS4PF_EeEsng; Mon, 11 Apr 2022 08:56:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4591483FC1;
	Mon, 11 Apr 2022 08:56:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A86DC002F;
	Mon, 11 Apr 2022 08:56:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B88DFC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A860408F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R8Uvlhf7Ij1Z
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:56:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7115404B0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649667402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/8SRRAANzvkchv/qA5xGsv21EcrCPMWC+psYPj5Pk4=;
 b=MHIZHy4DtSUEwaTG2bNbxd32Fq4TIqsF33ba0WZxYv3XNLfwtVwXJ7kNhdFNGkPvhlWT5w
 6rnyqiulfnrsIP84KxE35W7VG25TFboSE95eeOL0+gNAW82dGgKeybaYAk40TNciKV3AR1
 ZhAl3JdUpXNdI+34uh1s0WxL0PhXRwQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-GZ-0wWGEOCqhd3IpwwFV9g-1; Mon, 11 Apr 2022 04:56:39 -0400
X-MC-Unique: GZ-0wWGEOCqhd3IpwwFV9g-1
Received: by mail-wr1-f70.google.com with SMTP id
 p18-20020adfc392000000b00207a2102f9bso684106wrf.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 01:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k/8SRRAANzvkchv/qA5xGsv21EcrCPMWC+psYPj5Pk4=;
 b=pnqyGq+s5GUeYfOut3YNVMRmVX1gUBIZKppFIt6IuI+YYlf6q8o2QeoeTuEcx7nDxc
 Dq3YJxm3rKZF76H5DcFoaH4ojb/zcq4AGs3mBxKeL6jjAFq8G1FJmBzQ/bxgpHPyU2ak
 sYj8wv95XEEuWqqHCS95wDxm/CAUf0PA3yLfPbifkLzKkCVeKk8cqbY2I0P3F2OFNSsS
 OmPPJ60bteGQsKfkCIVTPIKb4oS72wz6/ZNNTEGTAArjGbgsGqcxCHYFwvEIS3htQGgn
 rNfLbDohHQoQcc5LsS+x0+y5fSVfFKrV81GBTv9bID/cfbtWlrPtlC4hpBqItxzWVAWM
 KzeQ==
X-Gm-Message-State: AOAM530msMgKcpeL+viYfbbiD9knt1qYdrMBlC5BvZVsgvZ+bXexLyhc
 D8oAgQHoNcWC60m4IqSW1NpmOZYabrdVS+bT6pAvJlNy05kjo/fO209Ed8cAzYlF8Nwl1KjC9zc
 X114+BFoGceCWYYzPfUrNkooW042bpQ4yoAVJ//Elyw==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id
 l10-20020a5d6d8a000000b0020408aa309fmr23696631wrs.38.1649667398030; 
 Mon, 11 Apr 2022 01:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbuWEZKovLlvZ9rE66XCQpJJwVUoRQzhWiB2WoGPCiZ1WI17PylwzUv/x5oI7UDfQLPpTKHQ==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id
 l10-20020a5d6d8a000000b0020408aa309fmr23696617wrs.38.1649667397814; 
 Mon, 11 Apr 2022 01:56:37 -0700 (PDT)
Received: from redhat.com ([2.52.1.156]) by smtp.gmail.com with ESMTPSA id
 u11-20020a056000038b00b00203e5c9aa09sm36522327wrf.27.2022.04.11.01.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 01:56:36 -0700 (PDT)
Date: Mon, 11 Apr 2022 04:56:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220411045011-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, Apr 11, 2022 at 04:22:19PM +0800, Jason Wang wrote:
> On Sun, Apr 10, 2022 at 3:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> > > On Wed, 06 Apr 2022 15:04:32 +0200
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >
> > > > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >
> > > > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
> > > > >> This patch implements PCI version of synchronize_vqs().
> > > > >>
> > > > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > > > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > >> Cc: Marc Zyngier <maz@kernel.org>
> > > > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > Please add implementations at least for ccw and mmio.
> > > >
> > > > I'm not sure what (if anything) can/should be done for ccw...
> > >
> > > If nothing needs to be done I would like to have at least a comment in
> > > the code that explains why. So that somebody who reads the code
> > > doesn't wonder: why is virtio-ccw not implementing that callback.
> >
> > Right.
> >
> > I am currently thinking instead of making this optional in the
> > core we should make it mandatory, and have transports which do not
> > need to sync have an empty stub with documentation explaining why.
> >
> > Also, do we want to document this sync is explicitly for irq enable/disable?
> > synchronize_irq_enable_disable?
> 
> I would not since the transport is not guaranteed to use an interrupt
> for callbacks.

OK but let's then document this in more detail.
More readers will wonder about what is the callback
trying to accomplish, and Halil requested that as well.

For example, let's document why is sync required on enable.

> >
> >
> > > >
> > > > >
> > > > >> ---
> > > > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > > > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > > > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > > > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > > > >>  4 files changed, 19 insertions(+)
> > > > >>
> > > > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > > >> index d724f676608b..b78c8bc93a97 100644
> > > > >> --- a/drivers/virtio/virtio_pci_common.c
> > > > >> +++ b/drivers/virtio/virtio_pci_common.c
> > > > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > > > >>                  synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > >>  }
> > > > >>
> > > > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > > > >> +{
> > > > >> +        struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > >> +        int i;
> > > > >> +
> > > > >> +        if (vp_dev->intx_enabled) {
> > > > >> +                synchronize_irq(vp_dev->pci_dev->irq);
> > > > >> +                return;
> > > > >> +        }
> > > > >> +
> > > > >> +        for (i = 0; i < vp_dev->msix_vectors; ++i)
> > > > >> +                synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > > > >> +}
> > > > >> +
> > > >
> > > > ...given that this seems to synchronize threaded interrupt handlers?
> > > > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > > > 'irq' for channel devices anyway, and the handler just calls the
> > > > relevant callbacks directly.)
> > >
> > > Sorry I don't understand enough yet. A more verbose documentation on
> > > "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> > > surely benefit me. It may be more than enough for a back-belt but it
> > > ain't enough for me to tell what is the callback supposed to accomplish.
> > >
> > > I will have to study this discussion and the code more thoroughly.
> > > Tentatively I side with Jason and Michael in a sense, that I don't
> > > believe virtio-ccw is safe against rough interrupts.
> 
> That's my feeling as well.
> 
> Thanks
> 
> > >
> > > Sorry for the late response. I intend to revisit this on Monday. If
> > > I don't please feel encouraged to ping.
> > >
> > > Regards,
> > > Halil
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
