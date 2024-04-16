Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6423771E
	for <virtualization@lists.linux.dev>; Tue, 16 Apr 2024 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713237487; cv=none; b=J2+QJgxNdu7iB8IoFS19fiqGM4JOXQyos6Lw3BQaGeOIYbaU6gMjWqghlTJE1sDem5JvO9IJ3RUdXQ7YcYbGlKGoKsh8uG1bJIFwiR6n2F15b+HFUARN2pRzGrtKDAzXE1O2ZedHaUW/IPmrVEsuIZae7GL4rCJEXRjpK/zO8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713237487; c=relaxed/simple;
	bh=o2U5u+XWP753D92tZ34TPHsPkRo8qrpjr2ko1JhCmes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rG4/oMimhytC977mcajmjBe+TXoAF9B0oi99gPu4d32yBgG3Hdypgr6U3IFTEha1DuCYBvjzdoWCEW7cjYtO2leNxSuxEpjGqASv1MtkvWdQICKDh71zvqeqNQESNzNOydYja3w/ysm4gwXvBhraTwzJ5YYzw5dlqOPUOmxOMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GV4Tm+Xg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GV4Tm+Xg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713237484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HanHGIwy160qTJhJLx1YqIJsuf6cM52V3/skkv+xCCA=;
	b=GV4Tm+XgqEU9Yw4BqM+2osSDjofQjsi/Q8GYbS2j676mj4uSGkrn+NNqu30gi/mLDH6ss+
	JDsBlzW7lToeKD+2IvaORGZ+QaVNAiMemnJ+SoIDflqD/7g7Tjzk//I3GDQbqXOSzhYz39
	cC0n3KRHW+6IZEDD3DfQOtnc2mRfa44=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-6e0y__6UMf6Szm5bc6cnLQ-1; Mon, 15 Apr 2024 23:18:01 -0400
X-MC-Unique: 6e0y__6UMf6Szm5bc6cnLQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a4fc4cf54dso4066955a91.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 20:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713237480; x=1713842280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HanHGIwy160qTJhJLx1YqIJsuf6cM52V3/skkv+xCCA=;
        b=GE/AIsSqxsBC99ELRkS9SlNJ1A7tmuYdvxHQFtWcSB1GJBgIhXsydcUmNaV6CbwDV0
         yo0scHy6OtslXejzDXLZM6GB7BzcilEaUAOumqNTy4+UfucqmXOOQII0vAU4vgx0zcRb
         gFsmd8VS6w3s++oB51ejuqgMIzFuXDZgm1dKwdWmkGZC0EQpFH9AV7NJvSlhIG8r0y2E
         +nwSWnraRTEY5xrcfR/01cJvnxBy/WL/icvylLAWu8AejcSJFImPQXtTVgq6NAtXL3y0
         rP/O4t2G4fmP8yJT5JD22ZmW9VfFaMHNL7IGLV8/M/oKjXAzGo9xiNFshkw0wZBtwOjQ
         CjEA==
X-Gm-Message-State: AOJu0Yyum44+1REWosXa4sJsPA6xwanuBztf5APxrDVcHnTwQ+42oHCY
	+390nQGZbwtCI2wv7HajaT4OkijRCxw/7TTfne7eRZVX3bGiXuTJiCN2iuI5D+dDc9iisWWeXQj
	lkKApSuESPAUiB6kyTROjqMBgzU14HJCHxxoYwnua1zeMQMyOeEsYczwYIxywfYmwAzpPGm2VPY
	rIhD+25WZvgCHurpSmky6Fah1elSp0BDAeHysWy3s=
X-Received: by 2002:a17:90b:1b4b:b0:2a2:73e9:c3bf with SMTP id nv11-20020a17090b1b4b00b002a273e9c3bfmr11030513pjb.20.1713237480409;
        Mon, 15 Apr 2024 20:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8qoJhQbPW9pRVskW959ZliuL1EIsKjXK9+B/o0bagawEXOafJ/4cr8Bn0K9ttDEek8Hpj8WX4CllPdhQQ5Ys=
X-Received: by 2002:a17:90b:1b4b:b0:2a2:73e9:c3bf with SMTP id
 nv11-20020a17090b1b4b00b002a273e9c3bfmr11030503pjb.20.1713237480125; Mon, 15
 Apr 2024 20:18:00 -0700 (PDT)
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
 <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com>
 <DS0PR18MB53685690485AACEEFB8D766CA0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEvg1ng88-v+ih+LnKgfiSNjJQZTLBkbdM4Z+t9oOosxbw@mail.gmail.com>
 <DS0PR18MB53684432E58CC810569D62D8A0042@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CACGkMEtR-eEc3-MEMMvixZ4w93wNoJjeuqhgNsP=62oZfZHd5A@mail.gmail.com> <PH7PR18MB535426965C489176FA9D8281A0092@PH7PR18MB5354.namprd18.prod.outlook.com>
In-Reply-To: <PH7PR18MB535426965C489176FA9D8281A0092@PH7PR18MB5354.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Apr 2024 11:17:48 +0800
Message-ID: <CACGkMEtMvb6HOebVxjn8070+PvtPp=9FAvuNA6uKd4NK+L996Q@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
To: Srujana Challa <schalla@marvell.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>, eperezma <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 8:42=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marve=
ll
> > OCTEON DPU devices
> >
> > On Fri, Apr 12, 2024 at 5:49=E2=80=AFPM Srujana Challa <schalla@marvell=
.com> wrote:
> > >
> > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for
> > > > Marvell OCTEON DPU devices
> > > >
> > > > On Fri, Apr 12, 2024 at 1:13=E2=80=AFPM Srujana Challa <schalla@mar=
vell.com>
> > wrote:
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Thursday, April 11, 2024 11:32 AM
> > > > > > To: Srujana Challa <schalla@marvell.com>
> > > > > > Cc: Michael S. Tsirkin <mst@redhat.com>;
> > > > > > virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com;
> > > > > > Vamsi Krishna Attunuru <vattunuru@marvell.com>; Shijith Thotton
> > > > > > <sthotton@marvell.com>; Nithin Kumar Dabilpuram
> > > > > > <ndabilpuram@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> > > > > > eperezma <eperezma@redhat.com>
> > > > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver
> > > > > > for Marvell OCTEON DPU devices
> > > > > >
> > > > > > On Wed, Apr 10, 2024 at 8:35=E2=80=AFPM Srujana Challa
> > > > > > <schalla@marvell.com>
> > > > > > wrote:
> > > > > > >
> > > > > > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA
> > > > > > > > driver for Marvell OCTEON DPU devices
> > > > > > > >
> > > > > > > > On Wed, Apr 10, 2024 at 10:15:37AM +0000, Srujana Challa wr=
ote:
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       domain =3D iommu_get_domain_for_dev(dev);
> > > > > > > > > > > > > +       if (!domain || domain->type =3D=3D
> > > > > > > > > > > > > + IOMMU_DOMAIN_IDENTITY)
> > > > > > {
> > > > > > > > > > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > > > > > > > > > +               octep_vdpa_ops.set_map =3D
> > > > > > > > > > > > > + octep_vdpa_set_map;
> > > > > > > > > > > >
> > > > > > > > > > > > Is this a shortcut to have get better performance?
> > > > > > > > > > > > DMA API should have those greacefully I think.
> > > > > > > > > > > When IOMMU is disabled on host and set_map/dma_map is
> > > > > > > > > > > not set, vhost-vdpa is reporting an error "Failed to
> > > > > > > > > > > allocate domain, device is not
> > > > > > > > > > IOMMU cache coherent capable\n".
> > > > > > > > > > > Hence we are doing this way to get better performance=
.
> > > > > > > > > >
> > > > > > > > > > The problem is, assuming the device does not have any
> > > > > > > > > > internal
> > > > > > IOMMU.
> > > > > > > > > >
> > > > > > > > > > 1) If we allow it running without IOMMU, it opens a
> > > > > > > > > > window for guest to attack the host.
> > > > > > > > > > 2) If you see perforamnce issue with
> > > > > > > > > > IOMMU_DOMAIN_IDENTITY, let's report it to DMA/IOMMU
> > > > > > > > > > maintiner to fix that
> > > > > > > > > It will be helpful for host networking case when iommu is=
 disabled.
> > > > > > > > > Can we take the vfio pci driver approach as a reference
> > > > > > > > > where user explicitly set "enable_unsafe_noiommu_mode"
> > > > > > > > > using module
> > > > param?
> > > > > > > >
> > > > > > > > vfio is a userspace driver so it's userspace's responsibili=
ty.
> > > > > > > > what exactly ensures correctness here? does the device have
> > > > > > > > an on-chip iommu?
> > > > > > > >
> > > > > > > Our device features an on-chip IOMMU, although it is not
> > > > > > > utilized for host-side targeted DMA operations. We included
> > > > > > > no-iommu mode in our driver to ensure that host applications,
> > > > > > > such as DPDK Virtio user PMD, continue to function even when
> > > > > > > operating in a no-
> > > > IOMMU mode.
> > > > > >
> > > > > > I may miss something but set_map() is empty in this driver. How
> > > > > > could such isolation be done?
> > > > >
> > > > > In no-iommu case, there would be no domain right, and the user of
> > > > > vhost-vdpa(DPDK virtio user pmd), would create the mapping and
> > > > > pass the PA (=3D IOVA) to the device directly. So that, device ca=
n
> > > > > directly DMA to the
> > > > PA.
> > > >
> > > > Yes, but this doesn't differ too much from the case where DMA API i=
s
> > > > used with IOMMU disabled.
> > > >
> > > > Are you saying DMA API introduces overheads in this case?
> > > No actually, current vhost-vdpa code is not allowing IOMMU disabled
> > > mode, If set_map/dma_map op is not set. Hence, we are setting set_map
> > > with dummy api to allow IOMMU disabled mode.
> > >
> > > Following is the code snippet from drivers/vhost/vdpa.c
> > >
> > >       /* Device want to do DMA by itself */
> > >         if (ops->set_map || ops->dma_map)
> > >                 return 0;
> > >
> > >         bus =3D dma_dev->bus;
> > >         if (!bus)
> > >                 return -EFAULT;
> > >
> > >        if (!device_iommu_capable(dma_dev,
> > IOMMU_CAP_CACHE_COHERENCY))
> > >                 return -ENOTSUPP;
> >
> > Right, so here's the question.
> >
> > When IOMMU is disabled, if there's no isolation from the device on-chip
> > IOMMU. It might have security implications. For example if we're using =
PA,
> > userspace could attack the kernel.
> >
> > So there should be some logic in the set_map() to program the on-chip
> > IOMMU to isolate DMA in that case but I don't see such implementation d=
one
> > in set_map().
>
> Our chip lacks support for on-chip IOMMU for host-side targeted DMA opera=
tions.
> When using the DPDK virtio user PMD, we=E2=80=99ve noticed a significant =
80% performance
> improvement when IOMMU is disabled on specific x86 machines. This perform=
ance
> improvement can be leveraged by embedded platforms where applications run=
 in
> controlled environment.
> May be it's a trade-off between security and performance.
>
> We can disable the no-iommu support by default and enable it through some=
 module
> parameter and taint the kernel similar to VFIO driver(enable_unsafe_noiom=
mu_mode) right?

Could be one way.

Michael, any thoughts on this?

Thanks

> >
> > >
> > > Performance degradation when iommu enabled is not with DMA API but th=
e
> > > x86 HW IOMMU translation performance on certain low end x86 machines.
> >
> > This might be true but it's not specific to vDPA I think?
> >
> > Thanks
> >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > >
> > > > > > > We observed performance impacts on certain low-end x86
> > > > > > > machines when IOMMU mode was enabled.
> > > > > > > I think, correctness is Host userspace application's
> > > > > > > responsibility, in this case when vhost-vdpa is used with Hos=
t
> > > > > > > application such as DPDK
> > > > > > Virtio user PMD.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > >
> > > > >
> > >
>

