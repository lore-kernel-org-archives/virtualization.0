Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96D5F1D5
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrWn+dQp"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5EA081441
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 16:40:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5EA081441
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WrWn+dQp
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NwnnXR_H6Tof
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 16:40:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CCAC9813D9
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 16:40:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCAC9813D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702572036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRk2CZG4/Ab0na0DCr/3bwBDdbw32XXRbYjtR9ARqr4=;
	b=WrWn+dQpMS0uTvbJ/cxL9SPvXeK0wq56oGszRI5VzPOxJ7OnsbAPcsVDXtaRvhBoNVnzNG
	TFO/Katw6JQJ9tfMPpqlwJBLbWPRQDCgMYQ5ObxJWBilhlT7ur7P0IaC/ZJQDd91nGiKGx
	H2NgHEo6PE507M5T0Cbscgw0PzUn7hw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-0CBru1J1Oris9InZeTTgzA-1; Thu, 14 Dec 2023 11:40:34 -0500
X-MC-Unique: 0CBru1J1Oris9InZeTTgzA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54cb71a5e16so4345350a12.3
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 08:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572033; x=1703176833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRk2CZG4/Ab0na0DCr/3bwBDdbw32XXRbYjtR9ARqr4=;
        b=iz2Y1pUZ6jjo8rKoyPZZRafVnCL3hbVfvcH8oxCQxMYXDaFQqB5Gg8QkvFaNbuNGND
         ovOsAF0QzgZgptrpe/Jtk+4BQ4p3/82HznjEs4B3oTg0zebGdJbwW8Mv3DX7xt0ixoOd
         8fbZTy0Z/zX5v7iB/C7zA77lDAPmOz5792+JAp3OSIp0i6iRIk2snvb7xApAiXXlJyan
         sOkNMukqAtBqeu2fXi1SA7gKeavOS4Yv96GuUNA8YRw8jf9Hgv3nhMoy966oQ9zoauPe
         PvMhSN0Gk9i8JqD/xCP6h5q2n2a8oGVSyDlvGIRa4TeDStacQmuWWI28l5LMIeQdIzBL
         QjCQ==
X-Gm-Message-State: AOJu0YzloGXrCdcJxspVZsSBeRD+EBCsrafpa9xfYVjtF02+93DhLxOD
	4XoTKcHe2uTrlBNW0//KAcPsNWVe/zz4r6gPbM8OsByb4LhnVPsyM8MXll4OUUv/QaKTrR7Gx/G
	Gr61F6FskLVlRlz4VNC6LuXp0v7Rj99KZmgmIHCwE6w==
X-Received: by 2002:a50:d657:0:b0:54c:f9e6:e40f with SMTP id c23-20020a50d657000000b0054cf9e6e40fmr5439740edj.7.1702572033329;
        Thu, 14 Dec 2023 08:40:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvmFnJLvOAFDRW8ctVUYl/ZQOHmqyiQ5QKA7dMnsf6MbAZiLEGF9Ip05ui1pTG2jJFcq303w==
X-Received: by 2002:a50:d657:0:b0:54c:f9e6:e40f with SMTP id c23-20020a50d657000000b0054cf9e6e40fmr5439730edj.7.1702572032938;
        Thu, 14 Dec 2023 08:40:32 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id n8-20020a50cc48000000b0054c9df4317dsm6901383edi.7.2023.12.14.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:23 -0800 (PST)
Date: Thu, 14 Dec 2023 11:40:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, jasowang@redhat.com,
	jgg@nvidia.com, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, parav@nvidia.com,
	feliu@nvidia.com, jiri@nvidia.com, kevin.tian@intel.com,
	joao.m.martins@oracle.com, si-wei.liu@oracle.com, leonro@nvidia.com,
	maorg@nvidia.com
Subject: Re: [PATCH V7 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231214113649-mutt-send-email-mst@kernel.org>
References: <20231207102820.74820-10-yishaih@nvidia.com>
 <20231214013642-mutt-send-email-mst@kernel.org>
 <ea0cdfc9-35f4-4cc1-b0de-aaef0bebeb51@nvidia.com>
 <20231214041515-mutt-send-email-mst@kernel.org>
 <37bcb2f0-a83d-4806-809c-ec5d004ddb20@nvidia.com>
 <20231214075905.59a4a3ba.alex.williamson@redhat.com>
 <20231214100403-mutt-send-email-mst@kernel.org>
 <5b596e34-aac9-4786-8f13-4d85986803f0@nvidia.com>
 <20231214091501.4f843335.alex.williamson@redhat.com>
 <c838ad5a-e6ba-4b8e-a9a2-5d43da0ba5a4@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c838ad5a-e6ba-4b8e-a9a2-5d43da0ba5a4@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2023 at 06:25:25PM +0200, Yishai Hadas wrote:
> On 14/12/2023 18:15, Alex Williamson wrote:
> > On Thu, 14 Dec 2023 18:03:30 +0200
> > Yishai Hadas <yishaih@nvidia.com> wrote:
> > 
> > > On 14/12/2023 17:05, Michael S. Tsirkin wrote:
> > > > On Thu, Dec 14, 2023 at 07:59:05AM -0700, Alex Williamson wrote:
> > > > > On Thu, 14 Dec 2023 11:37:10 +0200
> > > > > Yishai Hadas <yishaih@nvidia.com> wrote:
> > > > > > > > OK, if so, we can come with the below extra code.
> > > > > > > > Makes sense ?
> > > > > > > > 
> > > > > > > > I'll squash it as part of V8 to the relevant patch.
> > > > > > > > 
> > > > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c
> > > > > > > > b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > index 37a0035f8381..b652e91b9df4 100644
> > > > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > @@ -794,6 +794,9 @@ bool virtio_pci_admin_has_legacy_io(struct pci_dev
> > > > > > > > *pdev)
> > > > > > > >            struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> > > > > > > >            struct virtio_pci_device *vp_dev;
> > > > > > > > 
> > > > > > > > +#ifndef CONFIG_X86
> > > > > > > > +       return false;
> > > > > > > > +#endif
> > > > > > > >            if (!virtio_dev)
> > > > > > > >                    return false;
> > > > > > > > 
> > > > > > > > Yishai
> > > > > > > 
> > > > > > > Isn't there going to be a bunch more dead code that compiler won't be
> > > > > > > able to elide?
> > > > > > 
> > > > > > On my setup the compiler didn't complain about dead-code (I simulated it
> > > > > > by using ifdef CONFIG_X86 return false).
> > > > > > 
> > > > > > However, if we suspect that some compiler might complain, we can come
> > > > > > with the below instead.
> > > > > > 
> > > > > > Do you prefer that ?
> > > > > > 
> > > > > > index 37a0035f8381..53e29824d404 100644
> > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > @@ -782,6 +782,7 @@ static void vp_modern_destroy_avq(struct
> > > > > > virtio_device *vdev)
> > > > > >             BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ) | \
> > > > > >             BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO))
> > > > > > 
> > > > > > +#ifdef CONFIG_X86
> > > > > >     /*
> > > > > >      * virtio_pci_admin_has_legacy_io - Checks whether the legacy IO
> > > > > >      * commands are supported
> > > > > > @@ -807,6 +808,12 @@ bool virtio_pci_admin_has_legacy_io(struct pci_dev
> > > > > > *pdev)
> > > > > >                    return true;
> > > > > >            return false;
> > > > > >     }
> > > > > > +#else
> > > > > > +bool virtio_pci_admin_has_legacy_io(struct pci_dev *pdev)
> > > > > > +{
> > > > > > +       return false;
> > > > > > +}
> > > > > > +#endif
> > > > > >     EXPORT_SYMBOL_GPL(virtio_pci_admin_has_legacy_io);
> > > > > 
> > > > > Doesn't this also raise the question of the purpose of virtio-vfio-pci
> > > > > on non-x86?  Without any other features it offers nothing over vfio-pci
> > > > > and we should likely adjust the Kconfig for x86 or COMPILE_TEST.
> > > > > Thanks,
> > > > > 
> > > > > Alex
> > > > 
> > > > Kconfig dependency is what I had in mind, yes. The X86 specific code in
> > > > virtio_pci_modern.c can be moved to a separate file then use makefile
> > > > tricks to skip it on other platforms.
> > > 
> > > The next feature for that driver will be the live migration support over
> > > virtio, once the specification which is WIP those day will be accepted.
> > > 
> > > The migration functionality is not X86 dependent and doesn't have the
> > > legacy virtio driver limitations that enforced us to run only on X86.
> > > 
> > > So, by that time we may need to enable in VFIO the loading of
> > > virtio-vfio-pci driver and put back the ifdef X86 inside VIRTIO, only on
> > > the legacy IO API, as I did already in V8.
> > > 
> > > So using a KCONFIG solution in VFIO is a short term one, which will be
> > > reverted just later on.
> > 
> > I understand the intent, but I don't think that justifies building a
> > driver that serves no purpose in the interim.  IF and when migration
> > support becomes a reality, it's trivial to update the depends line.
> > 
> 
> OK, so I'll add a KCONFIG dependency on X86 as you suggested as part of V9
> inside VFIO.
> 
> > > In addition, the virtio_pci_admin_has_legacy_io() API can be used in the
> > > future not only by VFIO, this was one of the reasons to put it inside
> > > VIRTIO.
> > 
> > Maybe this should be governed by a new Kconfig option which would be
> > selected by drivers like this.  Thanks,
> > 
> 
> We can still keep the simple ifdef X86 inside VIRTIO for future users/usage
> which is not only VFIO.
> 
> Michael,
> Can that work for you ?
> 
> Yishai
> 
> > Alex
> > 

I am not sure what is proposed exactly. General admin q infrastructure
can be kept as is. The legacy things however can never work outside X86.
Best way to limit it to x86 is to move it to a separate file and
only build that on X86. This way the only ifdef we need is where
we set the flags to enable legacy commands.


-- 
MST

