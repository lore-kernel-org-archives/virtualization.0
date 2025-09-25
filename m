Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70761917FB
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835064; cv=none; b=cf13BvIi2UGmOqX2aAfeaRcoF529+ToF8pjVx0OYGBrVb3kEXBht1syroZY0ijdpFIKpg3d/6QaJHhC/nmqdg4VZgcewy6lho0/j1Y4BTnR8N+0eqoa26x/raKCN8JSNRjjdw1nLh69JIBh8g7ApKEWpdtwZ3M6Sg9CAELHKcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835064; c=relaxed/simple;
	bh=uMYvDDi76m0SjYLL/+X5HrviapVaV9pGIvPYvBnmmfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=neMZ8st1fcNfL+wcpFKeAzuiaH+2bCXb90PLX1cVDhQfbY4c4VDU0EbGgGqP83iDRcizQiNz1w1FPnjxPo0B3VFyKAYRrqbEJPdPGItzLjRiQHYwrYtDegZdvm5LuR/pNwdpnKqvuxHSVm0jI9DX9XcEfq+XaaA+eqe07v1ujGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9jLwl9K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9jLwl9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758835061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=InMs270U7tNzmYsR7wyJORKxbY23YzNflcIxA8PlZo4=;
	b=M9jLwl9KN8CX4FZbA7tPJ0iMrdIpzh6jfRAcbPVNR/UAPdv4VCAGwcNWchENKA064RAQy6
	MLFZ0SwEzY4msC5kb+J+/K7OFqJM0SVEjH0eBil+7VyQpY98t2sDinmBGE5qcsD1S5MjV5
	a3nlVSksYg75uIStX/I6s/kZAXpNGtk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-2VFVJ5PkOoivHeVOaaIiuA-1; Thu, 25 Sep 2025 17:17:40 -0400
X-MC-Unique: 2VFVJ5PkOoivHeVOaaIiuA-1
X-Mimecast-MFC-AGG-ID: 2VFVJ5PkOoivHeVOaaIiuA_1758835059
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f3787688b0so676737f8f.0
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 14:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835059; x=1759439859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InMs270U7tNzmYsR7wyJORKxbY23YzNflcIxA8PlZo4=;
        b=n5oliuIbbSGJkQHqmw0r7vGnKdYk3PK+HAHP0056iaqEgBts3T4YOY03F8tmboKX6Z
         frf1IZdQgO48Bniu6TD7GBKEKDNiBJeobmR4+ed3IHmR3LZygkg5ZONZHtm1DkHHB2/6
         w7juorATt61eAZ757mv1wzcQvi5LeJCOW4MnEmTf+c2AvwgAgSSTkG8a7/yQdTSEWeq+
         FfmTBJDk1wCL9INhUKeZs2TumnAPRacaU8om7PeVT2zcwX7R0lCdsS/VAk5TIWWTQQbn
         vR5+ThWbe1mSjb7BBFhMkuMGKBPQpYaqeJGknt9JPzrYEih2wduJD2lD8LgHBoxhbqAZ
         enLw==
X-Forwarded-Encrypted: i=1; AJvYcCVkkV22NdHOgOPrAPi+JfxRuTSvgUT1FZiF5yl4yLjKs4PncsKx1cCONjvJRZ3+z1ib7d7j4TDFsDPHBU4WGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDCN0Vx8M0nwUdi3wCuFQxb9fIXWBtuohmCgm9Snm2MPGzAE4Z
	6OoJu4lpP8Yu49vCwaHMwr02uXhTn7TXxPtqqeqL9TQFXqu1SffmHIp2iEbHPVDjfWA4o26fjz0
	7txK3Yo2gVx06qEoxYLT0TvcjdvGpOmUcTevsRYfHTlQqBg/423pmMj86UCYnJcF+en/n
X-Gm-Gg: ASbGncuFNGbvjamXV0uV0Ms7rZbm/DeCMr+Y6fFeJxk2CHNY4sadKqmNQQGbjzcvqoV
	7fOoL8g8AitUmpcT2X81Hc6kUmARQuw7nLhROxpCc2ieNB0HJnaHxMLABMFPSYgz6VReaQo5RTl
	jh1WGCSL/wTrmGSgOs6iUdsJdYG08s+7lracfcyJSLeots+/hhFre/FmHjtqM0UC4xPFr4/qwXs
	M7aw0JmBObvmxwrjtzmSF9Tapsb2OkLvlQTv5e3JuQ3Z42EK2xxtO4N2dGeggyW/gMQbg6xXdUO
	4m64jgmb2Lq3kPVbOhZg0zmOtoh78/V5Ug==
X-Received: by 2002:a05:6000:2901:b0:3eb:60a6:3167 with SMTP id ffacd0b85a97d-40e4bb2f6c4mr4971941f8f.32.1758835059162;
        Thu, 25 Sep 2025 14:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyfQdBXXom1LNY4hzsZo9rtJMz+NF0dmBeIX72tlfFZXC2O/zmQ4r9tU2in2I61YuZlQYweQ==
X-Received: by 2002:a05:6000:2901:b0:3eb:60a6:3167 with SMTP id ffacd0b85a97d-40e4bb2f6c4mr4971932f8f.32.1758835058759;
        Thu, 25 Sep 2025 14:17:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fbb27sm4235081f8f.4.2025.09.25.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:17:38 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:17:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
Message-ID: <20250925171724-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-4-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-4-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YUuIrDfchQzq3-JtSV9oADrahhW6YfObYYBreKiHvvA_1758835059
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:12AM -0500, Daniel Jurgens wrote:
> The flow filter implementaion 

implementation

>requires minimal changes to the
> existing virtio_net implementation. It's cleaner to separate it into
> another file. In order to do so, move virtio_net.c into the new
> virtio_net directory, and create a makefile for it. Note the name is
> changed to virtio_net_main.c, so the module can retain the name
> virtio_net.
> 
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> ---
>  MAINTAINERS                                               | 2 +-
>  drivers/net/Makefile                                      | 2 +-
>  drivers/net/virtio_net/Makefile                           | 8 ++++++++
>  .../net/{virtio_net.c => virtio_net/virtio_net_main.c}    | 0
>  4 files changed, 10 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/virtio_net/Makefile
>  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8a770714101..09d26c4225a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
>  F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
> -F:	drivers/net/virtio_net.c
> +F:	drivers/net/virtio_net/
>  F:	drivers/vdpa/
>  F:	drivers/virtio/
>  F:	include/linux/vdpa.h
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 73bc63ecd65f..cf28992658a6 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) += team/
>  obj-$(CONFIG_TUN) += tun.o
>  obj-$(CONFIG_TAP) += tap.o
>  obj-$(CONFIG_VETH) += veth.o
> -obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> +obj-$(CONFIG_VIRTIO_NET) += virtio_net/
>  obj-$(CONFIG_VXLAN) += vxlan/
>  obj-$(CONFIG_GENEVE) += geneve.o
>  obj-$(CONFIG_BAREUDP) += bareudp.o
> diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
> new file mode 100644
> index 000000000000..c0a4725ddd69
> --- /dev/null
> +++ b/drivers/net/virtio_net/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the VirtIO Net driver
> +#
> +
> +obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> +
> +virtio_net-objs := virtio_net_main.o
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net_main.c
> similarity index 100%
> rename from drivers/net/virtio_net.c
> rename to drivers/net/virtio_net/virtio_net_main.c
> -- 
> 2.45.0

