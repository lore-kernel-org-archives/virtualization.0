Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD57DA62
	for <virtualization@lists.linux.dev>; Fri, 13 Dec 2024 03:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062239; cv=none; b=BqR/4g2PIUlcYF2usAj2Suhf1yNWwlzb0YrDUAm3sVUcmLAeBxRKrJHKm2uHCjeZfUHfvX5uqjSApJ/y3rdpsJbF2wJoR4epcQFCoMa638Oxs3QBvIKMtHYG77v7C0duD6qw7MrJsX3SJz3SZXKeje9aCnHRXHL27ZyE1WZVIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062239; c=relaxed/simple;
	bh=FXb7zfdtlFu9GBIjB0tryV1aOvS/z6JwtcsImBQ1aHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Deb5oV1IkQlaEOAEWgQk7UFyPv0KKcWMmt23NRSxiSbRtMBKC8ARpkzeMvMYdsooZDNT3pHzh4dxhCmh5q817lJqO0N+O4mgFOk3RMOvwA2jqzxxGeWu8ojB9se1AkenNGKSSXwyYFNQx+LDPzrRXSFx/eq9Sz5eLteMImUGyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JT8NgZxu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT8NgZxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734062237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+zQC/AspIICVZze8P03srX8nFk7q1UzX/5YiLdcZN4=;
	b=JT8NgZxuwGRtq68/TvvYQz17FAfEXHOGIA1e/JEzSB9nJIHQtEGjgqCCHt6ybAu3rebWis
	hLpT7YdlZwhRACSxp8MHzNj8ICGpptKH2tnueLy72ZhSf8pZ9cPOdfDiQei4VI4MATnZTR
	Y0vUCEhmjrgCxexs9y/ltX6a/ZFgnUc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-w5-6Ylk_Oj6HlGus6cAVhg-1; Thu, 12 Dec 2024 22:57:15 -0500
X-MC-Unique: w5-6Ylk_Oj6HlGus6cAVhg-1
X-Mimecast-MFC-AGG-ID: w5-6Ylk_Oj6HlGus6cAVhg
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso1299446a91.3
        for <virtualization@lists.linux.dev>; Thu, 12 Dec 2024 19:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062234; x=1734667034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+zQC/AspIICVZze8P03srX8nFk7q1UzX/5YiLdcZN4=;
        b=mgK7WqZtnUvhe1hJqVmW8J5t+LtdULOxQlCMI1a2mQ+vxxmgErg6YuUbhYtmrVV6W/
         yYEGn5ovWzRAhzVqsp0Dwh7M189MnOUEIXUDTGkey1hNDzFR4WbViKmE9EE5P+368uL7
         PuyNIar2dtsh0lQBoNaebjVnbOx/82V6rvnzpXPBx5cUlj5NR1y3r3VOs/EoX4OWhn2H
         0/UK70o8Ox0HW3FKFlwz2TadvJ91KfbbSKwOvmgHA3kEJaqK3tu/S6918p7H+vjWbou1
         tOzc30YcrHGfPmQpbjdAo3wwYpOTkEldsb5XkHnnRV47yX8qLMIJSeD7Ojm1q2M4CEpD
         AN7g==
X-Gm-Message-State: AOJu0YwCp/y/XHaRNKi5HdVphdFQOYOSQGC8Qtk6yYwUlRyUsOETwkKc
	8LOWgH2h5SE01LbapIaX3qvnj4aWhM8Zq8ZWVj7Q22EwmG83Ydx2MyBH+4X1UHqP0Niq+PGLtMd
	K9HNBphzFZF1/DVM8CZv29Sq//uAUp1G3+HH7aLmmjs3CVFkn+unNfXFVo1/ZJsCIgcihQHHVXh
	wzijK4d51+Mm6Npxs3Ux9arK83RF3q2NsQNAijNtU=
X-Gm-Gg: ASbGncst9/hr+dLMlrMUIzCvjYfTOyWQNEN3Snl/thp0LhyCzL64miJG6c5XQGFZrO1
	IiKmUfL95KkVz+XkE027f2ZqztR2eI++pO+ikBZc=
X-Received: by 2002:a17:90b:3c02:b0:2ee:5958:86d with SMTP id 98e67ed59e1d1-2f28fb6764amr1931601a91.9.1734062234619;
        Thu, 12 Dec 2024 19:57:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh3fj/HXPiH/AF6JoMV2Y0Sft32EqIZr/Wg7xCm7BFvcJfN2LWRsNMAdRhZEer22QFkA6gf+Eyi/3v1wqkjoo=
X-Received: by 2002:a17:90b:3c02:b0:2ee:5958:86d with SMTP id
 98e67ed59e1d1-2f28fb6764amr1931573a91.9.1734062234229; Thu, 12 Dec 2024
 19:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241209151427.3720026-1-sthotton@marvell.com> <20241209151427.3720026-4-sthotton@marvell.com>
In-Reply-To: <20241209151427.3720026-4-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Dec 2024 11:57:03 +0800
Message-ID: <CACGkMEvuObS4RCk2BjQ4sm6r4jaC3fN4ui5EXd6SVzYxYZV7iA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] vdpa/octeon_ep: read vendor-specific PCI capability
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AskOGAy6ZVAfnZ05MY9voY5UiOPI6TE607Gw78o2RfE_1734062235
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:16=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added support to read the vendor-specific PCI capability to identify the
> type of device being emulated.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 20 ++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 33 +++++++++++++++++++++++-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
>  3 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep=
/octep_vdpa.h
> index 2cadb878e679..53b020b019f7 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> @@ -8,6 +8,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/vdpa.h>
>  #include <linux/virtio_pci_modern.h>
> +#include <uapi/linux/virtio_crypto.h>
>  #include <uapi/linux/virtio_net.h>
>  #include <uapi/linux/virtio_blk.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -52,6 +53,24 @@ struct octep_vring_info {
>         phys_addr_t notify_pa;
>  };
>
> +enum octep_pci_vndr_cfg_type {
> +       OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
> +       OCTEP_PCI_VNDR_CFG_TYPE_MAX,
> +};
> +
> +struct octep_pci_vndr_data {
> +       struct virtio_pci_vndr_data hdr;
> +       u8 id;
> +       u8 bar;
> +       union {
> +               u64 data;
> +               struct {
> +                       u32 offset;
> +                       u32 length;
> +               };
> +       };
> +};

This seems not to be padded to a multiple of 4 bytes?

Others look good.

Thanks

