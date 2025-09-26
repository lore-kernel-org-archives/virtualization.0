Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F45A72633
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 04:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862535; cv=none; b=lp9nxPRTBPI9u+RN5MJ+9Q71lKLxuYYNkoQFCjtpGru3p6CYSh0kfm3Rn0awqBdbZz6vTd9WUi1XDDUf+aoixIGuclEcthL4KPtJZvQZsvwWMZMjazUMLYk2CjCyrGKj7Hy2ITWBltnAXMosSLa0KATvBEElkeV94HAbKa5esR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862535; c=relaxed/simple;
	bh=Nej2v9PMt/WcbamJ+FX4ohIqCRqaL0Mql+6Jr/x2r7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrHs1hw7QZKipyH0Emcz+dEAWV2f+5+IWf6E0xImderiVPOcBWN0GdmQcgUS2rcJ3N2avQxpmPUIXzbss20BoBgSqflypFvTHTzvE5da0y04qYIOGDNVj+HejfMfBXyDBCA4Vz7FMip6+X538B9A8vphbZBegqtB0DrA4bOuSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKFnbgek; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKFnbgek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758862533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXIPhhw4tWLJ9v89faJ+PM4VIR9L03wMvBqNbKspOp8=;
	b=IKFnbgek8NZaMktELcdLRfY0sHyBUA64r22MlKAVGceQzdLQeO8UcEHLZhlscbXkFS4GRc
	Yoyszlj65vXYFDkh+GzO9CDhJa15Jq/jiCmfg9FdTJeJhfmyMv5Et0ylr9tQVDQ0slXnG6
	iIQ533pdCBid9Yin8e/ok+hFQDwXbLM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-VHJPbM4oP2i9QOJ-zqJh5Q-1; Fri, 26 Sep 2025 00:55:26 -0400
X-MC-Unique: VHJPbM4oP2i9QOJ-zqJh5Q-1
X-Mimecast-MFC-AGG-ID: VHJPbM4oP2i9QOJ-zqJh5Q_1758862525
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so2439916a91.3
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758862525; x=1759467325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXIPhhw4tWLJ9v89faJ+PM4VIR9L03wMvBqNbKspOp8=;
        b=hvCCvSZYQtFYlq02X8QjTqHSpGS910jovrIHVdDarcrCck0zZh0VzF5DryluFUb4Io
         gOraZVvS+k2w//o4VRaBFMHFxfeKXj1yMvnoCsl80APfovNym45Rr8eOUBsymMGg8Auh
         GsHl+8Lln2rjHrSWl2gOsYj5JiMDeGHuiY7mvrLQiOJc2a8kX0F79TFXEMDokYOz6TuK
         dU9H/o/ouWsMIfpiXW34EIdvbfy74WpA0YokrVVsYfDdGRUj6h081T/FLclgHZ94H7sh
         PlhrT29SgmLeyBWYBWut0napRLS2F7aIgMimMyjzhgVsOzuC/vOQZA61Ntr1joZbANIi
         gJJg==
X-Forwarded-Encrypted: i=1; AJvYcCWFocF5SUEuLbKqlqSTToYmeIx2gN6XdaX9XHKjOaQpK2zZnT3jb0Ml5xvLjrEH3cF3HNsxyHVLzXKGg6ccQA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/FVNRfcdKtmzbXTV3uhUyzqjqgg446svYUYIskoVcHvQC8z55
	VnYRuNox8Vkkf+6LfNBn46ti3WcHUGSqwn9URwrx1MDp5m2sBVGNUXpw2uLotUEm3u0pW0EFE/9
	h03pIsI2xz/Ut9Jjcs+sQ9gNdnB7VTj+mRN7werB74s+5DA0RAmmZVh2ZRWfdH4Fw1CGWcu4F2F
	VCvKBxanekJEHnVb2XPW6kjy12YQrCeoqo7cYpADP4IL4=
X-Gm-Gg: ASbGncv3tu0wn15dJJ36+0jbl0i5My4zRyms0FDKuFhyR3p/qJvdMZZymA1/MasvNHL
	IIrRmQCd4INolyuWDwMcVvCf0/AbtyFQ304Zuso2u0nA27wcPnvmVChVs9HBCIiKQhCmA+xjct8
	gZhMCDkJllFIz8V3euNA==
X-Received: by 2002:a17:90b:3a8b:b0:330:4604:3ab6 with SMTP id 98e67ed59e1d1-3342a2b119emr6309521a91.18.1758862524855;
        Thu, 25 Sep 2025 21:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhepOtBGMOoRmGAMGYvLYEEoIZzIxWPaI1wxI6nM9zltZDzQ31wVU9ghnTwZpyBnsfgfU1312VbBySpCVKrvw=
X-Received: by 2002:a17:90b:3a8b:b0:330:4604:3ab6 with SMTP id
 98e67ed59e1d1-3342a2b119emr6309485a91.18.1758862524392; Thu, 25 Sep 2025
 21:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250923141920.283862-1-danielj@nvidia.com> <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com> <20250924021637-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924021637-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 12:55:11 +0800
X-Gm-Features: AS18NWAP5nE5bSzUngmD74vhSZHIuWlJH1On-rHDVx-a53FiiQzgeN7bupN4ojc
Message-ID: <CACGkMEuWRUANBCkeE5r+7+wob3nr-Mrnce_kLRHbpeF0OT_45Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org, alex.williamson@redhat.com, 
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com, 
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch, 
	edumazet@google.com, Yishai Hadas <yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _q49I3Jb1oyxdAb_cdkc0U1RlkFfKeWlPlaydDGESA8_1758862525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 24, 2025 at 09:16:32AM +0800, Jason Wang wrote:
> > On Tue, Sep 23, 2025 at 10:20=E2=80=AFPM Daniel Jurgens <danielj@nvidia=
.com> wrote:
> > >
> > > Currently querying and setting capabilities is restricted to a single
> > > capability and contained within the virtio PCI driver. However, each
> > > device type has generic and device specific capabilities, that may be
> > > queried and set. In subsequent patches virtio_net will query and set
> > > flow filter capabilities.
> > >
> > > Move the admin related definitions to a new header file. It needs to =
be
> > > abstracted away from the PCI specifics to be used by upper layer
> > > drivers.
> > >
> > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> > > Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> > > ---
> >
> > [...]
> >
> > >
> > >  size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > >
> > > diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admi=
n.h
> > > new file mode 100644
> > > index 000000000000..bbf543d20be4
> > > --- /dev/null
> > > +++ b/include/linux/virtio_admin.h
> > > @@ -0,0 +1,68 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only
> > > + *
> > > + * Header file for virtio admin operations
> > > + */
> > > +#include <uapi/linux/virtio_pci.h>
> > > +
> > > +#ifndef _LINUX_VIRTIO_ADMIN_H
> > > +#define _LINUX_VIRTIO_ADMIN_H
> > > +
> > > +struct virtio_device;
> > > +
> > > +/**
> > > + * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the ca=
pability list
> > > + * @cap_list: Pointer to capability list structure containing suppor=
ted_caps array
> > > + * @cap: Capability ID to check
> > > + *
> > > + * The cap_list contains a supported_caps array of little-endian 64-=
bit integers
> > > + * where each bit represents a capability. Bit 0 of the first elemen=
t represents
> > > + * capability ID 0, bit 1 represents capability ID 1, and so on.
> > > + *
> > > + * Return: 1 if capability is supported, 0 otherwise
> > > + */
> > > +#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
> > > +       (!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> c=
ap % 64)))
> > > +
> > > +/**
> > > + * struct virtio_admin_ops - Operations for virtio admin functionali=
ty
> > > + *
> > > + * This structure contains function pointers for performing administ=
rative
> > > + * operations on virtio devices. All data and caps pointers must be =
allocated
> > > + * on the heap by the caller.
> > > + */
> > > +struct virtio_admin_ops {
> > > +       /**
> > > +        * @cap_id_list_query: Query the list of supported capability=
 IDs
> > > +        * @vdev: The virtio device to query
> > > +        * @data: Pointer to result structure (must be heap allocated=
)
> > > +        * Return: 0 on success, negative error code on failure
> > > +        */
> > > +       int (*cap_id_list_query)(struct virtio_device *vdev,
> > > +                                struct virtio_admin_cmd_query_cap_id=
_result *data);
> > > +       /**
> > > +        * @cap_get: Get capability data for a specific capability ID
> > > +        * @vdev: The virtio device
> > > +        * @id: Capability ID to retrieve
> > > +        * @caps: Pointer to capability data structure (must be heap =
allocated)
> > > +        * @cap_size: Size of the capability data structure
> > > +        * Return: 0 on success, negative error code on failure
> > > +        */
> > > +       int (*cap_get)(struct virtio_device *vdev,
> > > +                      u16 id,
> > > +                      void *caps,
> > > +                      size_t cap_size);
> > > +       /**
> > > +        * @cap_set: Set capability data for a specific capability ID
> > > +        * @vdev: The virtio device
> > > +        * @id: Capability ID to set
> > > +        * @caps: Pointer to capability data structure (must be heap =
allocated)
> > > +        * @cap_size: Size of the capability data structure
> > > +        * Return: 0 on success, negative error code on failure
> > > +        */
> > > +       int (*cap_set)(struct virtio_device *vdev,
> > > +                      u16 id,
> > > +                      const void *caps,
> > > +                      size_t cap_size);
> > > +};
> >
> > Looking at this, it's nothing admin virtqueue specific, I wonder why
> > it is not part of virtio_config_ops.
> >
> > Thanks
>
> cap things are admin commands. But what I do not get is why they
> need to be callbacks.
>
> The only thing about admin commands that is pci specific is finding
> the admin vq.

I think we had a discussion to decide to separate admin commands from
the admin vq.

Thanks

