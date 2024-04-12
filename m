Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFD4DA09
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712904092; cv=none; b=pWTo2Nt/7/BO8Pv9Zts+7Us8rWZiUxbwhqD2OsRaAKDj9NaS1LqDXmD6jLbC1WxYKfpcW76U/SZFZCx4aUJaSVcDF/jcrVUj/r0ODaQSXIaKnpkwWUYdQ0H/LTdpdZqOZ/i9CTl/JjNRsfRwrjLZMtfDN6cB1uVWQVlOPpmP00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712904092; c=relaxed/simple;
	bh=sLp9hsCiYP+NM4SfzGrD14i/8HilzsQZrHSsoSUYfFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ereHQB881oNjhOcnp3xbAmkupa+e3XARXYzUhtnt3wyKXycjGBdN8+tRITG83peDPY7quJQxCfcg/rgl+IY4IYvMir5U8plQiTQlwlsEQ5LtVQxjp1XzW6Mn2YqOiHbQqNzsueMKy47bXibWY4hENAkFU+MNbNKzTL/Ccj18DXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITk5dP2c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITk5dP2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712904089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiuvxDVGvD48twNYSXKuRkkZdcslA+/22Kogef1EBwk=;
	b=ITk5dP2cxruwtf4apA3e9drMsX8sweJ88MwYOFMlgg4zFStx6FuRaHvHhdDBovtCYBXjAm
	7xUcxJAoxuSA+ds8+eQT42owPlTpp5s3rJU8rwhf0dhZA0LjjjVFLWnuHzhDnfKzK5tfxw
	Wxpajrda5r9BwQ5lfYG7fPjdvgsLoq0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-9dqcc4phOUChK3J6bWmDRQ-1; Fri, 12 Apr 2024 02:41:27 -0400
X-MC-Unique: 9dqcc4phOUChK3J6bWmDRQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a2e6197371so572172a91.3
        for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 23:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712904086; x=1713508886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiuvxDVGvD48twNYSXKuRkkZdcslA+/22Kogef1EBwk=;
        b=iTxSVCJdO02sQR5FMYx5gMjb18U9GFp3N2zPxqaa6S5urdo8J3K5KqKti84d4ZckCo
         1oNBFaTj9fwES6SrOp3ZwcQ2S0SOloOGYGeq3B4sCCYGjunLnrZy8mOPs+UoyP2qR5hG
         G/xcXzEHC1de5ewgPFWlhvSSEt4PsJiTqZUECBr+n3C2DhfZehftHaeiOIWsZr4oRDoi
         hSFPIaw+tjtiPDTQI3e2em7RF8eIJh1rXwSYBKnUHixaWbAr3YE1WCGgpgGxUVq9pK/0
         Jow9Qe0qMLfySjsbO+ha69kJLpLjiipBp1EbRu30v/XbCy9tW21M1pwoQ0nS/CR5kmZR
         3MfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgzMqdjqSxVJfZV/14BwA0ENI5J96il1F70mnvJbjJBioDeTYgY70n2dtMAL4IT1O7pHKDY2spgEAgFxdb9nlWzkoDT2rX2iQLODgB92M=
X-Gm-Message-State: AOJu0YxLMB9LDOZAsVDYyvE4p+9XBGtJ/xcbYmAhMPub2gkU5r2JH23v
	xNyMI0mfzP0/JSav7vCCTCtNWtAUSRfYBFFCiq4tGVuivgQ6tYV2eWdEa+wxQL7bCjzkvK78qpD
	QoY+TfY1qAsSN/dzZVkJj21tB6VCHo7OceEP80/MnGhSKBWoh7DEjuMLNWc7v6bTrnQYrh0SkVO
	vF60pLZdXNKX7un/jOix9ckfOtHKHQ5H+zNeVMaqQ=
X-Received: by 2002:a17:90a:b307:b0:2a3:48a8:cf7b with SMTP id d7-20020a17090ab30700b002a348a8cf7bmr1788130pjr.18.1712904086596;
        Thu, 11 Apr 2024 23:41:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXYGIlI0yiSZbFLRNYjdq2Y4W1v6SXifZ1k3EZhZZK8wO/GV+6qZYbmQ7mBl3zq5iLq4IpdGjVl8RqYI6zmJI=
X-Received: by 2002:a17:90a:b307:b0:2a3:48a8:cf7b with SMTP id
 d7-20020a17090ab30700b002a348a8cf7bmr1788111pjr.18.1712904086276; Thu, 11 Apr
 2024 23:41:26 -0700 (PDT)
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
 <CACGkMEvYXPPp9Jbkx4ucXL7WYBkCMggCJJHVZUg2JuNc7DMJPw@mail.gmail.com> <DS0PR18MB53685690485AACEEFB8D766CA0042@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB53685690485AACEEFB8D766CA0042@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 14:41:15 +0800
Message-ID: <CACGkMEvg1ng88-v+ih+LnKgfiSNjJQZTLBkbdM4Z+t9oOosxbw@mail.gmail.com>
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

On Fri, Apr 12, 2024 at 1:13=E2=80=AFPM Srujana Challa <schalla@marvell.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, April 11, 2024 11:32 AM
> > To: Srujana Challa <schalla@marvell.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; virtualization@lists.linux.dev=
;
> > xuanzhuo@linux.alibaba.com; Vamsi Krishna Attunuru
> > <vattunuru@marvell.com>; Shijith Thotton <sthotton@marvell.com>; Nithin
> > Kumar Dabilpuram <ndabilpuram@marvell.com>; Jerin Jacob
> > <jerinj@marvell.com>; eperezma <eperezma@redhat.com>
> > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marve=
ll
> > OCTEON DPU devices
> >
> > On Wed, Apr 10, 2024 at 8:35=E2=80=AFPM Srujana Challa <schalla@marvell=
.com>
> > wrote:
> > >
> > > > Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for
> > > > Marvell OCTEON DPU devices
> > > >
> > > > On Wed, Apr 10, 2024 at 10:15:37AM +0000, Srujana Challa wrote:
> > > > > > > > > +
> > > > > > > > > +       domain =3D iommu_get_domain_for_dev(dev);
> > > > > > > > > +       if (!domain || domain->type =3D=3D IOMMU_DOMAIN_I=
DENTITY)
> > {
> > > > > > > > > +               dev_info(dev, "NO-IOMMU\n");
> > > > > > > > > +               octep_vdpa_ops.set_map =3D
> > > > > > > > > + octep_vdpa_set_map;
> > > > > > > >
> > > > > > > > Is this a shortcut to have get better performance? DMA API
> > > > > > > > should have those greacefully I think.
> > > > > > > When IOMMU is disabled on host and set_map/dma_map is not set=
,
> > > > > > > vhost-vdpa is reporting an error "Failed to allocate domain,
> > > > > > > device is not
> > > > > > IOMMU cache coherent capable\n".
> > > > > > > Hence we are doing this way to get better performance.
> > > > > >
> > > > > > The problem is, assuming the device does not have any internal
> > IOMMU.
> > > > > >
> > > > > > 1) If we allow it running without IOMMU, it opens a window for
> > > > > > guest to attack the host.
> > > > > > 2) If you see perforamnce issue with IOMMU_DOMAIN_IDENTITY,
> > > > > > let's report it to DMA/IOMMU maintiner to fix that
> > > > > It will be helpful for host networking case when iommu is disable=
d.
> > > > > Can we take the vfio pci driver approach as a reference where use=
r
> > > > > explicitly set "enable_unsafe_noiommu_mode" using module param?
> > > >
> > > > vfio is a userspace driver so it's userspace's responsibility.
> > > > what exactly ensures correctness here? does the device have an
> > > > on-chip iommu?
> > > >
> > > Our device features an on-chip IOMMU, although it is not utilized for
> > > host-side targeted DMA operations. We included no-iommu mode in our
> > > driver to ensure that host applications, such as DPDK Virtio user PMD=
,
> > > continue to function even when operating in a no-IOMMU mode.
> >
> > I may miss something but set_map() is empty in this driver. How could s=
uch
> > isolation be done?
>
> In no-iommu case, there would be no domain right, and the user of vhost-v=
dpa(DPDK virtio user pmd),
> would create the mapping and pass the PA (=3D IOVA) to the device directl=
y. So that, device can directly
> DMA to the PA.

Yes, but this doesn't differ too much from the case where DMA API is
used with IOMMU disabled.

Are you saying DMA API introduces overheads in this case?

Thanks

>
> >
> > > We observed performance impacts on
> > > certain low-end x86 machines when IOMMU mode was enabled.
> > > I think, correctness is Host userspace application's responsibility,
> > > in this case when vhost-vdpa is used with Host application such as DP=
DK
> > Virtio user PMD.
> >
> > Thanks
> >
> > >
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > Thanks.
> > > > >
> > >
>

