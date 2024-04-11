Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032813CAA0
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815192; cv=none; b=HyJkvr7OSc0lj/SbWI4EmNfARAdxAIHJBCRDc8aakOXrbcpzvM8ibgpSU2BbiVzxO3PClNbLgSJE6/laKTluXOqFq25th8HY7S0t0V8cOvRuozZcgNbUacUnspbVjCmagRZyRh3raaWnGoaWKI0rYlqOEbB+6K+ose9nJDhAP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815192; c=relaxed/simple;
	bh=56ijaC9NWy+pxjPGaLJoxJTcH8+Bvl0OAI4T1hVT8ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgD3L3MUoixy9LgBLu+o17MEW1nNn9C7R2jOT2jgpbEw9Gh5/dVLADcfVp8sCUngq+ODO3FcC2HZBBylis30BxfAjg6+b3/6dzKwGCTnXHTGQv8OhZh8UDgTUPI4VMNG9KYeTV4QGU2xpHoV7jzvPkXd5s/leJjGEN00q7VWS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bph5vfsq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bph5vfsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712815189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWCYn1ILaQSYW83xuRqKVLjSuCeoR+t+APClPv8AcFo=;
	b=bph5vfsqdubRZYqSom3M82Je8HZmVRBIJdXZ0cG3r/1ZcFgwxSrUP3dmI5Ccmb6NqUA428
	qCrEfaPIFK6bo6dEX7AHrBWMlDOyT/ovHfSwAHiJbRsa8fx7yPKnf3QSNZeazaZfCh1IYS
	sooyvWwQuyCHfaTj8N0bHdBDYvnnTRg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-77tnnp4xNFqpX9lqz18lHA-1; Thu, 11 Apr 2024 01:59:45 -0400
X-MC-Unique: 77tnnp4xNFqpX9lqz18lHA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e2a5cb5455so78653705ad.2
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 22:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712815184; x=1713419984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWCYn1ILaQSYW83xuRqKVLjSuCeoR+t+APClPv8AcFo=;
        b=u+z/gNbmuJSG5oggXeQVwGF6NrC8yC4Nw+Gx1zcQxxwcH+VJxy/OQwXFbHErl3+U/+
         kl/0unneVWuQE3ZrdX/FsHJQ0qhf6R0vPcSQhXgf+20C8K9h+sKWQOSp9Wa0yeJa69Kd
         SLlHWIgqpqOmdpuw+VK3U72SnkoxVP73mjxTPs6YHAtkir1i2I3G7G9qGpYFb1WZh7Y0
         cLjwW+D+qTNJH0E3w8St3io9ejCcExr2fL2EZCY//aC7iH/ZBwULh63TVILp284rcXfm
         K1nPXtGsKSetqdwWFOHFnbDEMnfS1vk6DO5vE9m99dlEKx2vupJTOsFBnUsB85qmNBSI
         goOA==
X-Gm-Message-State: AOJu0YxZ2wv/06HeEdCP9GOjgaUwYb6rUjudC+EEh7ua9fq/VbqQvgwF
	PblV9UUAZOoRkca+RK+5Qz18oP3uxFtemg3ITeHDBq+/c0ZCmfQJY5DrWZ2N1/4KgW1obTdbX5s
	VMBBCm3RuGwPsRWzLYDjv1dvDqMRCM7F7C2xO8Q43+WOARXHLqDMNS39kheDaNbItuKP+0BxkAX
	MMb3f2pXaA2v7O52CPVV1jjLURfTPW3NTojFiEM/U=
X-Received: by 2002:a17:902:e84a:b0:1e3:e0ca:d8a3 with SMTP id t10-20020a170902e84a00b001e3e0cad8a3mr5193016plg.6.1712815184640;
        Wed, 10 Apr 2024 22:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyvxszWUaINeg0zfWxZvrV/6Ye7877/zPyBYzFcj2sUpA/d5DhetS9Q6CeFtXsMhSUGlCAbSpcjIVeV/tBn9c=
X-Received: by 2002:a17:902:e84a:b0:1e3:e0ca:d8a3 with SMTP id
 t10-20020a170902e84a00b001e3e0cad8a3mr5193006plg.6.1712815184374; Wed, 10 Apr
 2024 22:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327112136.2897479-1-schalla@marvell.com> <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com> <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Apr 2024 13:59:33 +0800
Message-ID: <CACGkMEv9rB6HbuyGhxr+De8y+ndXJ4LnJWO0rXywqM_Ujj++Bw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
To: Srujana Challa <schalla@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 6:16=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> > > > > +
> > > > > +       domain =3D iommu_get_domain_for_dev(dev);
> > > > > +       if (!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENTITY)=
 {
> > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > +               octep_vdpa_ops.set_map =3D octep_vdpa_set_map;
> > > >
> > > > Is this a shortcut to have get better performance? DMA API should h=
ave
> > > > those greacefully I think.
> > > When IOMMU is disabled on host and set_map/dma_map is not set,
> > > vhost-vdpa is reporting an error "Failed to allocate domain, device i=
s not
> > IOMMU cache coherent capable\n".
> > > Hence we are doing this way to get better performance.
> >
> > The problem is, assuming the device does not have any internal IOMMU.
> >
> > 1) If we allow it running without IOMMU, it opens a window for guest
> > to attack the host.
> > 2) If you see perforamnce issue with IOMMU_DOMAIN_IDENTITY, let's
> > report it to DMA/IOMMU maintiner to fix that
> It will be helpful for host networking case when iommu is disabled.
> Can we take the vfio pci driver approach as a reference where user explic=
itly set
> "enable_unsafe_noiommu_mode" using module param?

I prefer not, the "unsafe" is a hint that it should not be used in
production environment due to security implications.

How much degradation have you seen for IOMMU_DOMAIN_IDENTITY or IOMMU
is disabled? Is that because of the DMA API?

Thanks

>
> >
> > Thanks
>
> Thanks.
>

