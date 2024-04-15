Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A120DC8
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163759; cv=none; b=kgxjFtHMQUYRGyWYy3HfboO1Pqe5pBz9klFB8zROzppaAENaNdhTAJZtjJ+GwWmnR8PPL+ZWPeW/1GUad/nY8LUMGQFkzHET8+x+cSt1zonaY5Y6yCc55Gevn9JzAJxyezh92c1rHCVeCoBBhXK/iGSbaVyXt3FuAfARqFXdA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163759; c=relaxed/simple;
	bh=SDBGUvSWm8QEDhgQVXK9WfbSigTTIP+FpPfR4nSAWuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZFirenRcPl1lw/sC177yWFgofZlM1Pciq/32h16SpwCoAk8m6loNeaGAKSeAMcXQ5DfDlVAdOKQl0oPdSIfMjG/Z2ZQUgn9yCy7Xzkf9sl8UKCjupyENi+cKWI/BAMn8beE87EyWt0mGUSmIhw6LfxqVW6SzpkSYFuW9lt06hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H17Uocso; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H17Uocso"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713163757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8VjdQQ8EPfR431S1WFAg4xyVlpzqsdaNlPsYq+Vc/F4=;
	b=H17UocsoPKHFMV0QM5gytjraVHL9S8QSVn0Uvpv8sgLlcPThXlMTLgQroWQNk0YHTxvYKD
	hcXgOH1Nat17aU9u9yxcQAhN08yBzV2D7DEk10rWVCnmuv98LrE18TnRv7Di1qlbpXVxtD
	/bIpzMzxmj4r3zGEHhWhz18FICk/Zx0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-g84qHwGIOiePnBcwqGSLLA-1; Mon, 15 Apr 2024 02:49:15 -0400
X-MC-Unique: g84qHwGIOiePnBcwqGSLLA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a53909676fso2732855a91.3
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 23:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163754; x=1713768554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VjdQQ8EPfR431S1WFAg4xyVlpzqsdaNlPsYq+Vc/F4=;
        b=P2hcVb/Uvb+g0allgPcSkKJV2M8g8FZ8ng54bPMNDGJ9no6UcnU4rV2+f1/EAJQV1w
         8J2LWLBFIrpUuG6kvXSriQ+m06Ov4t/O+MmSUt87mw8qGPX/o8rFVPXmbn3Xk+OV51RW
         /jCmUeTEIlK7SMwLuVUp1xdENWhMKpe0GxijrdyJQp0HAb1P0aWwfFqU1BUiUbjXMqqc
         LxWfqeVxlhIVxIbqekNG5kwNvbMItWaEsx0MAN5/2GAXdXNqKAL9XCEHeB/27n+lAxV6
         C5kEp2+cmhgtMujZctrp3K4gX8WHvNrk5rUcGoSGjdYcmxjFohrDBBb8GJv7W6N8SrJA
         ClzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBHO3goVUgY4H8LOYCuQpy6B3MYL4TsArj3UZgfGCj14Y7+DiQf0cw8usazLBLeswZskGx/uSM5C1op2FcIEkmsY/QsyKjMsE3ZJTlTi8=
X-Gm-Message-State: AOJu0YwmZ9lY3LHZlJYknFti21ncs03OXWfU7ncF8nuOF13qzId/jfzk
	2eRXLa+eD9PnJjIM9V/fnT3m9FMICd8soVi31htcjY26H9gcbCKe9ThEeDfJLqV0/MmAfrnIEUI
	OdFDhz3Gx+9dZkhL/Dj2bmpuqT4YO1M8i0XWxP9IWNlM0y8UyyvlWicuPTxJucb4uwExSfxFljP
	Ay/l0P0WPlqdDRVJF3DrrvQmyDt5BFHy0PPhw1mC8=
X-Received: by 2002:a17:90a:ca84:b0:2a6:4966:b50f with SMTP id y4-20020a17090aca8400b002a64966b50fmr6596470pjt.40.1713163754385;
        Sun, 14 Apr 2024 23:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb0jJLj0/DGojHwxiIhP4HOf1t/sptnTF7hKdkrhdN6RME5HREbelcHdpFaGogkZ0XEgF2ZjdPGgbaFLGUhYw=
X-Received: by 2002:a17:90a:ca84:b0:2a6:4966:b50f with SMTP id
 y4-20020a17090aca8400b002a64966b50fmr6596458pjt.40.1713163754019; Sun, 14 Apr
 2024 23:49:14 -0700 (PDT)
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
 <CACGkMEvg1ng88-v+ih+LnKgfiSNjJQZTLBkbdM4Z+t9oOosxbw@mail.gmail.com> <DS0PR18MB53684432E58CC810569D62D8A0042@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB53684432E58CC810569D62D8A0042@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 14:49:02 +0800
Message-ID: <CACGkMEtR-eEc3-MEMMvixZ4w93wNoJjeuqhgNsP=62oZfZHd5A@mail.gmail.com>
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

On Fri, Apr 12, 2024 at 5:49=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
> > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marve=
ll
> > OCTEON DPU devices
> >
> > On Fri, Apr 12, 2024 at 1:13=E2=80=AFPM Srujana Challa <schalla@marvell=
.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Thursday, April 11, 2024 11:32 AM
> > > > To: Srujana Challa <schalla@marvell.com>
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>;
> > > > virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com; Vamsi
> > > > Krishna Attunuru <vattunuru@marvell.com>; Shijith Thotton
> > > > <sthotton@marvell.com>; Nithin Kumar Dabilpuram
> > > > <ndabilpuram@marvell.com>; Jerin Jacob <jerinj@marvell.com>;
> > > > eperezma <eperezma@redhat.com>
> > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for
> > > > Marvell OCTEON DPU devices
> > > >
> > > > On Wed, Apr 10, 2024 at 8:35=E2=80=AFPM Srujana Challa <schalla@mar=
vell.com>
> > > > wrote:
> > > > >
> > > > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver
> > > > > > for Marvell OCTEON DPU devices
> > > > > >
> > > > > > On Wed, Apr 10, 2024 at 10:15:37AM +0000, Srujana Challa wrote:
> > > > > > > > > > > +
> > > > > > > > > > > +       domain =3D iommu_get_domain_for_dev(dev);
> > > > > > > > > > > +       if (!domain || domain->type =3D=3D
> > > > > > > > > > > + IOMMU_DOMAIN_IDENTITY)
> > > > {
> > > > > > > > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > > > > > > > +               octep_vdpa_ops.set_map =3D
> > > > > > > > > > > + octep_vdpa_set_map;
> > > > > > > > > >
> > > > > > > > > > Is this a shortcut to have get better performance? DMA
> > > > > > > > > > API should have those greacefully I think.
> > > > > > > > > When IOMMU is disabled on host and set_map/dma_map is not
> > > > > > > > > set, vhost-vdpa is reporting an error "Failed to allocate
> > > > > > > > > domain, device is not
> > > > > > > > IOMMU cache coherent capable\n".
> > > > > > > > > Hence we are doing this way to get better performance.
> > > > > > > >
> > > > > > > > The problem is, assuming the device does not have any
> > > > > > > > internal
> > > > IOMMU.
> > > > > > > >
> > > > > > > > 1) If we allow it running without IOMMU, it opens a window
> > > > > > > > for guest to attack the host.
> > > > > > > > 2) If you see perforamnce issue with IOMMU_DOMAIN_IDENTITY,
> > > > > > > > let's report it to DMA/IOMMU maintiner to fix that
> > > > > > > It will be helpful for host networking case when iommu is dis=
abled.
> > > > > > > Can we take the vfio pci driver approach as a reference where
> > > > > > > user explicitly set "enable_unsafe_noiommu_mode" using module
> > param?
> > > > > >
> > > > > > vfio is a userspace driver so it's userspace's responsibility.
> > > > > > what exactly ensures correctness here? does the device have an
> > > > > > on-chip iommu?
> > > > > >
> > > > > Our device features an on-chip IOMMU, although it is not utilized
> > > > > for host-side targeted DMA operations. We included no-iommu mode
> > > > > in our driver to ensure that host applications, such as DPDK
> > > > > Virtio user PMD, continue to function even when operating in a no=
-
> > IOMMU mode.
> > > >
> > > > I may miss something but set_map() is empty in this driver. How
> > > > could such isolation be done?
> > >
> > > In no-iommu case, there would be no domain right, and the user of
> > > vhost-vdpa(DPDK virtio user pmd), would create the mapping and pass
> > > the PA (=3D IOVA) to the device directly. So that, device can directl=
y DMA to the
> > PA.
> >
> > Yes, but this doesn't differ too much from the case where DMA API is us=
ed
> > with IOMMU disabled.
> >
> > Are you saying DMA API introduces overheads in this case?
> No actually, current vhost-vdpa code is not allowing IOMMU disabled mode,
> If set_map/dma_map op is not set. Hence, we are setting set_map with dumm=
y
> api to allow IOMMU disabled mode.
>
> Following is the code snippet from drivers/vhost/vdpa.c
>
>       /* Device want to do DMA by itself */
>         if (ops->set_map || ops->dma_map)
>                 return 0;
>
>         bus =3D dma_dev->bus;
>         if (!bus)
>                 return -EFAULT;
>
>        if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY))
>                 return -ENOTSUPP;

Right, so here's the question.

When IOMMU is disabled, if there's no isolation from the device
on-chip IOMMU. It might have security implications. For example if
we're using PA, userspace could attack the kernel.

So there should be some logic in the set_map() to program the on-chip
IOMMU to isolate DMA in that case but I don't see such implementation
done in set_map().

>
> Performance degradation when iommu enabled is not with DMA API but the x8=
6 HW IOMMU
> translation performance on certain low end x86 machines.

This might be true but it's not specific to vDPA I think?

Thanks

>
> >
> > Thanks
> >
> > >
> > > >
> > > > > We observed performance impacts on certain low-end x86 machines
> > > > > when IOMMU mode was enabled.
> > > > > I think, correctness is Host userspace application's
> > > > > responsibility, in this case when vhost-vdpa is used with Host
> > > > > application such as DPDK
> > > > Virtio user PMD.
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > >
> > >
>

