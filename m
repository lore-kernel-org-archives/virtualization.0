Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7414C583
	for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835646; cv=none; b=GZVfcC8V84dO5f1i96rY7BoeKdxwyhyEe+zCRG3BLDnjKyGRxAVaBdT9Qfa8nDvxWWEgugTbWbyD0oJr3njkN1O+3Hti5yZvS478OGX+8yG0NVCRW2c9Cxh03fwca6fgNisJB378PL2/GwSJDsqaUz4K7OsDpRS2MKArZ9Mev5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835646; c=relaxed/simple;
	bh=EdgBUoaGZipHWYfvkvK5093fnrzFSUyZQUkIgM2yDJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJLVKXenN+bvZYLAT/rKtJkBQLnQww9/Nc7En11g5YsqBuiXlgXIDKR4H+d7gxGBSjh6tWpFUWQNbfnKM5Itj0OtZbse06YyHDf4NMKm8z9VIh3nGfvS1A6c+FbE8GZ5aeLoFxfwFMjl075SCby+SqxQA3TKEa9lPrJPhnqlxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShZl2YlG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShZl2YlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724835642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqJX5Of7GMsCkp8gdgyQDXYdcAwtYT7fpZUnmkWnXRQ=;
	b=ShZl2YlGyghB9G6XRall7eE4dG8j/tuE3y9UI2g9ZfMPCJA5LpJ0szQCDTAcJwgBVfYJNI
	ux9F/4P6tLBbjBixQBdzZAop54/rlamD1mv+9C+SpgVyxP1kAUO1vQMq2MAk9Vf9iMQBwX
	reUP0YLGvkrF49s0EuNsEf/4HCoAMro=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-wShUttiAMVKhsmxTCw5Wwg-1; Wed, 28 Aug 2024 05:00:41 -0400
X-MC-Unique: wShUttiAMVKhsmxTCw5Wwg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a867d92ec4bso278086466b.1
        for <virtualization@lists.linux.dev>; Wed, 28 Aug 2024 02:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724835640; x=1725440440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqJX5Of7GMsCkp8gdgyQDXYdcAwtYT7fpZUnmkWnXRQ=;
        b=eWSGV6XcDSzx9X7PuTUBCeIZia5aLkknGWg5kEduVI/KvOpUx6qylAnQnfYHPakhRB
         BtsE0XI/lJ7Gm2aIOVBek1wgE0Dihw5hje+w0LlUs+fXniVka4X31ePPrySfOo654QCV
         lnif3ugioiD0d4KzYKE/thLKY4Wm7cUNGq3MrUpbVNBiTu3eGtVEbGByg5qzmgpt/ElK
         3HriOV7yMsHouaUHw5liIVV3yiRKAs7P4kxrh0alOMOGiTTRhMCmwDCIyuNsp3gLbtFb
         PJ4dPz1YDxSIARnJlK2GLlcA+x3DVp/mx5UOsfNmcjS2z1DKAimQTUKmQuA5EaIK0d56
         pIxg==
X-Forwarded-Encrypted: i=1; AJvYcCUxNWnw7AQsgdByokQFIpIaIyZsMQ+WEhfGdPGTuj4UcHz0qqwYyepHwOgj6setDmX05+abYji2wbZbFSSGPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/iIE1YWFu3puqGuwoTsAC2NHrK2NnPpzmLGL9IY6+9Ua1XeZC
	Cskw8V56TncVJZoa/o9KVcmofrw61m52D9goQExdo03Pl8YS2O+g78U1g5RYEUpMbWtgiTOWn+8
	8tLWnrtSP6/UsabMbNlvqC5/xA1MintHxfLWpE+cX8E70OUxkRMfPSgkH7hjjRbbP+RB51A191s
	HQfx0LmXSVGltYpQI/gcAmZzQuPtpdFHf0+CU2A1A=
X-Received: by 2002:a05:6402:2549:b0:5be:9bc5:f6b4 with SMTP id 4fb4d7f45d1cf-5c08915b718mr13141124a12.8.1724835639799;
        Wed, 28 Aug 2024 02:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmytXQdT7iRj1p5zIwkpTj8uWa2KU8YRy/19fhGY0/5govv3/YWqQfafQc0XnYLqOPYrG90KFWou4s0lULvlk=
X-Received: by 2002:a05:6402:2549:b0:5be:9bc5:f6b4 with SMTP id
 4fb4d7f45d1cf-5c08915b718mr13141084a12.8.1724835639150; Wed, 28 Aug 2024
 02:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240827160256.2446626-2-dtatulea@nvidia.com> <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
In-Reply-To: <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 28 Aug 2024 17:00:01 +0800
Message-ID: <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC set
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Aug 28, 2024 at 12:03=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> >
> > When the vdpa device is configured without a specific MAC
> > address, the vport MAC address is used. However, this
> > address can be 0 which prevents the driver from properly
> > configuring the MPFS and breaks steering.
> >
> > The solution is to simply generate a random MAC address
> > when no MAC is set on the nic vport.
> >
> > Now it's possible to create a vdpa device without a
> > MAC address and run qemu with this device without needing
> > to configure an explicit MAC address.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> (Adding Cindy for double checking if it has any side effect on Qemu side)
>
> Thanks
>
But Now there is a bug in QEMU: if the hardware MAC address does not
match the one in the QEMU command line, it will cause traffic loss.

So, Just an FYI here: if your patch merged, it may cause traffic loss.
and now I'm working in the fix it in qemu, the link is
https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
The idea of this fix is
There are will only two acceptable situations for qemu:
1. The hardware MAC address is the same as the MAC address specified
in the QEMU command line, and both MAC addresses are not 0.
2. The hardware MAC address is not 0, and the MAC address in the QEMU
command line is 0. In this situation, the hardware MAC address will
overwrite the QEMU command line address.

Thanks
Cindy


> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index fa78e8288ebb..1c26139d02fe 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3824,6 +3824,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev=
 *v_mdev, const char *name,
> >                 err =3D mlx5_query_nic_vport_mac_address(mdev, 0, 0, co=
nfig->mac);
> >                 if (err)
> >                         goto err_alloc;
> > +
> > +               if (is_zero_ether_addr(config->mac))
> > +                       eth_random_addr(config->mac);
> >         }
> >
> >         if (!is_zero_ether_addr(config->mac)) {
> > --
> > 2.45.1
> >
>

