Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82613C806
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815321; cv=none; b=cloCk25uSx+2nu/AqgGDbvO6MM/bZEcfcrI9e8j3MriLcn9d9VBV9RQnCiY1R48itNgM0lT0SKpPdm29JRine0IZtxPeIQaUmkTNJTeY7jQKdJW27N2wehGN/xpNRuheRVDOA+VfmZcYYxQgHbV+xfQDcILD4z4Fvf6oPOdbgns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815321; c=relaxed/simple;
	bh=xCWEUDMBy7s4GDJTqnk2hO3jPgMJesRXA4TL5DoZ1uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxmLu1yTecoLqHlF1DQpnXhempkdmwScn6+L5CIguQwRZozE6eTOtB9F66LM5ZKaljxtbTEFCaVk8B42JBN0E/klA8y/ZfXzRX2JVWKsI/9FdRrrvWhGkz9rZdo1faSXsUAunW3SF9Uwl1Dlk+0ncDQLu5YNWA6fSs37oSXd2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hV0DMNQG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hV0DMNQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712815318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wIcv/g56qk9S7PzS3tNYBLkf5XdE7gzJNR0A0H8jMKI=;
	b=hV0DMNQGEWXJ8Mx7Jrg0BpwD7oq3qp5bDZVtRGF002qECpoN7Z57oI/AnK+AepjuQKNj5B
	mMPgjpw4IfQBNj+K+JXeE+XJauTkUnNoyr9HoiPSDaByJ0+Ccywt9O/uGP05HcwSHwtomJ
	WqWNZ9kUdpFkiJDrjxuldDBdtnP1E0A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-0-_dCk8PNx20iJy1q1yVPQ-1; Thu, 11 Apr 2024 02:01:56 -0400
X-MC-Unique: 0-_dCk8PNx20iJy1q1yVPQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a4a2cace80so4360732a91.3
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 23:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712815315; x=1713420115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIcv/g56qk9S7PzS3tNYBLkf5XdE7gzJNR0A0H8jMKI=;
        b=fdvkZlz/IBMcWBg1fK6ro4aViZUTYus13dnqqpb60Bq+upQWP4T4BdWZJ4XiwE/1e2
         sNJZdclUdwDfCMjKAKbUs5h5GWBrOdnGMTrgfmTf+qNSnpU3WNbovvEVdEAQo++TayHD
         llRNyD1ROLvRXl/a5B4XbRzL6o07J36uWeYAAd9wcoTyjLrSQ10XDVeJrP8kTWcevy89
         1r+qkPWqa5mOuQ+qmQb+yD7TaXFMgEBMUbrF27JOYKdQWsVAO+rhbrEtpiWztTFlr/96
         H1CbqT+2r4gBnFWG5mzEM/es4bGilMKK/NP21GWH6EwQaiJCRMnOLoTZ9/Q7ZPGmKDOi
         PPtw==
X-Forwarded-Encrypted: i=1; AJvYcCVODwWOsHU6dv9oTbXk6whi0eld/0z24BfuqPxGxmNjSv6E4oQKVWoXjOGviBTfhR98XIv4E4LqinPrrEPLSlN4Sv7K7gIhCHLu28lulDE=
X-Gm-Message-State: AOJu0YxbkGvN7UB37IELddnxylx0HvqA1FmaiDJrFJnA7zl/XniT2/lf
	WwYeiT7E+EtFomDd4pCtpOtCZZMNht5PnKFslwEEK6H09ZbkK7LGqOo1ja80qr/fV1PaLnySHtT
	5cgRiZBSExNFHSody+oyPGj54IN0/y1TVmfwQHX+oxNx+sMChKXDJThUrBpAH3z92dJ+UxIS4GG
	sJYA5QzbYSt0Gppmej8E2J/3ppcgEXyjpABUtCstg=
X-Received: by 2002:a17:90b:8d7:b0:2a0:3dc3:8a8b with SMTP id ds23-20020a17090b08d700b002a03dc38a8bmr4017666pjb.47.1712815315302;
        Wed, 10 Apr 2024 23:01:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWR4GAxDrrKoSWn6Ukas6dUEc0M2k2hzTgljOe70SunYt514W+R5oa8szWv9NdkeqdQjZeqT9/2vD3Cts/HQE=
X-Received: by 2002:a17:90b:8d7:b0:2a0:3dc3:8a8b with SMTP id
 ds23-20020a17090b08d700b002a03dc38a8bmr4017648pjb.47.1712815315022; Wed, 10
 Apr 2024 23:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327112136.2897479-1-schalla@marvell.com> <CACGkMEuKhKOtqYUk4Sbv1QmVSuo3AJ1-tX13ZZxdbPmSSNYk9Q@mail.gmail.com>
 <DS0PR18MB53686F5F53AF5D26B7CE37B6A03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEuAEsApX0ZT=FWVgtvYwpAVhzQGh_1yrUaN5f8A8K7iCw@mail.gmail.com>
 <DS0PR18MB5368C214A318C026C6A64E45A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
 <20240410071350-mutt-send-email-mst@kernel.org> <DS0PR18MB5368C21CDDE827AA2A496510A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB5368C21CDDE827AA2A496510A0062@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Apr 2024 14:01:42 +0800
Message-ID: <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
To: Srujana Challa <schalla@marvell.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:35=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marve=
ll
> > OCTEON DPU devices
> >
> > On Wed, Apr 10, 2024 at 10:15:37AM +0000, Srujana Challa wrote:
> > > > > > > +
> > > > > > > +       domain =3D iommu_get_domain_for_dev(dev);
> > > > > > > +       if (!domain || domain->type =3D=3D IOMMU_DOMAIN_IDENT=
ITY) {
> > > > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > > > +               octep_vdpa_ops.set_map =3D octep_vdpa_set_map=
;
> > > > > >
> > > > > > Is this a shortcut to have get better performance? DMA API
> > > > > > should have those greacefully I think.
> > > > > When IOMMU is disabled on host and set_map/dma_map is not set,
> > > > > vhost-vdpa is reporting an error "Failed to allocate domain,
> > > > > device is not
> > > > IOMMU cache coherent capable\n".
> > > > > Hence we are doing this way to get better performance.
> > > >
> > > > The problem is, assuming the device does not have any internal IOMM=
U.
> > > >
> > > > 1) If we allow it running without IOMMU, it opens a window for gues=
t
> > > > to attack the host.
> > > > 2) If you see perforamnce issue with IOMMU_DOMAIN_IDENTITY, let's
> > > > report it to DMA/IOMMU maintiner to fix that
> > > It will be helpful for host networking case when iommu is disabled.
> > > Can we take the vfio pci driver approach as a reference where user
> > > explicitly set "enable_unsafe_noiommu_mode" using module param?
> >
> > vfio is a userspace driver so it's userspace's responsibility.
> > what exactly ensures correctness here? does the device have an on-chip
> > iommu?
> >
> Our device features an on-chip IOMMU, although it is not utilized for hos=
t-side
> targeted DMA operations. We included no-iommu mode in our driver to ensur=
e
> that host applications, such as DPDK Virtio user PMD, continue to functio=
n even
> when operating in a no-IOMMU mode.

I may miss something but set_map() is empty in this driver. How could
such isolation be done?

> We observed performance impacts on
> certain low-end x86 machines when IOMMU mode was enabled.
> I think, correctness is Host userspace application's responsibility, in t=
his case
> when vhost-vdpa is used with Host application such as DPDK Virtio user PM=
D.

Thanks

>
> > > >
> > > > Thanks
> > >
> > > Thanks.
> > >
>

