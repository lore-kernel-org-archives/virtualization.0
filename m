Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C738C433FE
	for <virtualization@archiver.kernel.org>; Sun, 10 Apr 2022 07:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5DAB84203;
	Sun, 10 Apr 2022 07:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JiQAsnWT6-nv; Sun, 10 Apr 2022 07:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 179EE841FE;
	Sun, 10 Apr 2022 07:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE34DC0033;
	Sun, 10 Apr 2022 07:51:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0D72C002C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 07:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98EA8416FF
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 07:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vccBub_mWLB1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 07:51:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50F164170B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 07:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649577072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEGpPcEbQpA7grhoTpCsc4+FcBngn29MUORJJ4U+NYw=;
 b=eNbxZE16HfP1GC3hyvsw7U7FS+fd8CC79H72BFzFd2Xnp8QQKGgiksJe1KTxiY5oT7a5Zo
 eNJOwvLLuU3E+5YMbhx5grtEDTP3CZ43rLsLWSiCLsxT1Wwu20t4jgB+u9UutYxLg1l6Qp
 5yZSnBb9LvfFfpbn7JaP2GoK9ED7+ZA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-byIXlUAVOhSkSUjapwyYjQ-1; Sun, 10 Apr 2022 03:51:11 -0400
X-MC-Unique: byIXlUAVOhSkSUjapwyYjQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 h65-20020a1c2144000000b0038e9ce3b29cso3654792wmh.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 00:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CEGpPcEbQpA7grhoTpCsc4+FcBngn29MUORJJ4U+NYw=;
 b=6jtv/PeBt3ZtkBA8q55159qHLjosAPvOHPGo0xTnSt5NszHJstxJWi09VCK2l5pH7/
 VurxZIuemXcQsdBFitQzkB6qXgbI3OsSlVaFHxCvz2XbXgR0oM0FtA1CYo5+dakAEuJH
 n4oCxSRpZk/UobQ/yID1WaFMRyrfpztgLmYVkh6ZDQ2+6QY2ax9yW0F93I8ff877bGD0
 6xwF4l+M4J9qsYBSzb8XTp+XCB/rlEPdjm8GFpWyNAf0BaEeB0Y78EsRkJlPh19b2flp
 xDTW2QGTV71wAVrnpIfeRIee/YGxOt47ml9sSClErBeJfxO5va9F1d4lyuSeRHkBrhX9
 +xbA==
X-Gm-Message-State: AOAM531WO4emGAjBSOs6DN0biltxSFt9yY9ycQyajLswdBPFPPJIhv1l
 2dNa9rx7XAZ/j1zFFtCgEw8gq48ndGrWATqfVRvWxOTgBP2BTEsN0f+4smBwPHlHbbYcsi6UUvm
 bH1LQsj4lAcOLq6Imy7G7eHkwdARdh7Q46juLz5t5yQ==
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id
 u14-20020a056000038e00b00204101ab2bfmr21145000wrf.308.1649577069988; 
 Sun, 10 Apr 2022 00:51:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvYZyBQ0r+Gt7hwuX3pBsyKj4i4o0hapZQla4rsV4724KDz9tVyJjJ9jxgUH/qez7K6v9+rw==
X-Received: by 2002:a05:6000:38e:b0:204:101a:b2bf with SMTP id
 u14-20020a056000038e00b00204101ab2bfmr21144987wrf.308.1649577069755; 
 Sun, 10 Apr 2022 00:51:09 -0700 (PDT)
Received: from redhat.com ([2.53.10.84]) by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c19c700b0038cc9aac1a3sm16055019wmq.23.2022.04.10.00.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Apr 2022 00:51:08 -0700 (PDT)
Date: Sun, 10 Apr 2022 03:51:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
Message-ID: <20220410034556-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220408150307.24b6b99f.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220408150307.24b6b99f.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 tglx@linutronix.de
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

On Fri, Apr 08, 2022 at 03:03:07PM +0200, Halil Pasic wrote:
> On Wed, 06 Apr 2022 15:04:32 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:  
> > >> This patch implements PCI version of synchronize_vqs().
> > >> 
> > >> Cc: Thomas Gleixner <tglx@linutronix.de>
> > >> Cc: Peter Zijlstra <peterz@infradead.org>
> > >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > >> Cc: Marc Zyngier <maz@kernel.org>
> > >> Signed-off-by: Jason Wang <jasowang@redhat.com>  
> > >
> > > Please add implementations at least for ccw and mmio.  
> > 
> > I'm not sure what (if anything) can/should be done for ccw...
> 
> If nothing needs to be done I would like to have at least a comment in
> the code that explains why. So that somebody who reads the code
> doesn't wonder: why is virtio-ccw not implementing that callback.

Right.

I am currently thinking instead of making this optional in the
core we should make it mandatory, and have transports which do not
need to sync have an empty stub with documentation explaining why.

Also, do we want to document this sync is explicitly for irq enable/disable?
synchronize_irq_enable_disable?


> > 
> > >  
> > >> ---
> > >>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
> > >>  drivers/virtio/virtio_pci_common.h |  2 ++
> > >>  drivers/virtio/virtio_pci_legacy.c |  1 +
> > >>  drivers/virtio/virtio_pci_modern.c |  2 ++
> > >>  4 files changed, 19 insertions(+)
> > >> 
> > >> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > >> index d724f676608b..b78c8bc93a97 100644
> > >> --- a/drivers/virtio/virtio_pci_common.c
> > >> +++ b/drivers/virtio/virtio_pci_common.c
> > >> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
> > >>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > >>  }
> > >>  
> > >> +void vp_synchronize_vqs(struct virtio_device *vdev)
> > >> +{
> > >> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > >> +	int i;
> > >> +
> > >> +	if (vp_dev->intx_enabled) {
> > >> +		synchronize_irq(vp_dev->pci_dev->irq);
> > >> +		return;
> > >> +	}
> > >> +
> > >> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > >> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
> > >> +}
> > >> +  
> > 
> > ...given that this seems to synchronize threaded interrupt handlers?
> > Halil, do you think ccw needs to do anything? (AFAICS, we only have one
> > 'irq' for channel devices anyway, and the handler just calls the
> > relevant callbacks directly.)
> 
> Sorry I don't understand enough yet. A more verbose documentation on
> "virtio_synchronize_vqs - synchronize with virtqueue callbacks" would
> surely benefit me. It may be more than enough for a back-belt but it
> ain't enough for me to tell what is the callback supposed to accomplish.
> 
> I will have to study this discussion and the code more thoroughly.
> Tentatively I side with Jason and Michael in a sense, that I don't
> believe virtio-ccw is safe against rough interrupts.
> 
> Sorry for the late response. I intend to revisit this on Monday. If
> I don't please feel encouraged to ping.
> 
> Regards,
> Halil

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
