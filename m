Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE47AD5A
	for <virtualization@lists.linux.dev>; Mon,  1 Sep 2025 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693573; cv=none; b=MuHoxq1F262LJVgfw9pCSx5PwJfx7pclOHPjUgR55qDgOUV+OdBga0WfPHiSUCHkjsA/EYavhdFAkguU49x2iwLzeTg9+xALfNpSXWYpCcUJiG7fH6AS2BRzFHtquL3y5XUahBZDlshLCB1FuhQgEE4r5lhguqwfi0sbCa970vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693573; c=relaxed/simple;
	bh=6Oshq/yJ1fHBl5xl2XzHzCQOf1h3ROLhFP38peDQ2mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/xJ+9BoaXAZUXFyw+ZOUh4pSNpwqFapZ7Dlx/ZnFs5iPNcA2paGxf16Ym+ZjF4NSIyuedG9OMIGgTT/liYvU9TxSAuzpfKWNI3n2TxD2RjDC50vUQ2KRwQTVE20nSkB+W77J8LbfN1eLdLrSE8WBoa1bBK/zjV6bC2H9STCGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPpQXKqW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPpQXKqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756693568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pEQF/BwSM3dQ3hEjpIbD+T80xvw1+fXTShbhLh8tNo=;
	b=YPpQXKqWJON/V3SmKCXu3Ac03fBBGnWvBkrQvV8+NVBzCZaCAR44xeMcQuhQufwiAt2WVI
	vkqFPn8TouTlT3QvKctIGVEo7i8akN79ydYiYvYqM82pKZ+aq8DnfuZe2/Uw3e+nOklRRW
	ICqKD6pUa4VDMB4PlyjTdxr7glfOVso=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-RmQM33_0MAGDAG2WDmcqLA-1; Sun, 31 Aug 2025 22:26:07 -0400
X-MC-Unique: RmQM33_0MAGDAG2WDmcqLA-1
X-Mimecast-MFC-AGG-ID: RmQM33_0MAGDAG2WDmcqLA_1756693567
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-327b016a1f3so3960992a91.1
        for <virtualization@lists.linux.dev>; Sun, 31 Aug 2025 19:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756693566; x=1757298366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pEQF/BwSM3dQ3hEjpIbD+T80xvw1+fXTShbhLh8tNo=;
        b=jDMDUSwly9AnGU1GT6PDAdkp09gOQeHSbDFO12zBBUcWqAAwtgM3ODi1kDkcIGxpF7
         XVvYEcvtCSDwhzg+SMzQhJxJA4qapUwTs/qUkO82E+6CC8tDc76nh9SHP/DDTks/94FG
         rEUe1B4YQteqtxHlnpQhuuAdIOcfU60bEYuXSrjKlkSUOQ7ZK0kpUuKQOI4O/vXvSj7X
         PlCifuVpPslX3PRackJxYsMG9Fz3i1FonnJ5zYKz4p8g37jH1DLIM5qmNljp7/XSWTrr
         4hE7M8gainu0/yI+JTE6oyFuyNDQXgBzKdGGbkKHJMrt/My7su0CUjvd7BUXrm2EiS9o
         0fiw==
X-Forwarded-Encrypted: i=1; AJvYcCWyEb3CQwcpryoIv8izqRCo76HWS4aDE3XL/koqkbRrGhV5HUK2KNZgbn1cBqWvvh8Ehh392bSUdjykjOJuGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1D7Gh34m9iwolFuo1jijrs+jYaFmUxH+H1EMHx1ELeY54ASHc
	1yBmhlgf1hspyWBcM8Y21ExXE9MsELm8bXzY2WiYS1lZOKr8ETVvmyxQuKAn4LlRzvhYJz+1R/c
	3nwUlcouNhsa2jO8Ez0DNn65F8YHDoLH2HoY4Za7y+9xsZXX9NcJyHmCR7LVMuuuvpNZr41Ss7H
	BMYTzxw+wI95CHkamnxpyq5n2MuqsDmg9SnHDD79eJtHNuo+Qim32c2amV
X-Gm-Gg: ASbGncvWvsASfVLpX7mIxGV23N/c+3RdoFC66vqKAJuxSMAmRwZqVclP1UtXVNjJ+2e
	rmDE13CcXzYswNmLiP0QiNIyo/8oqIu+ftSBIOcDhyF90A07ocvepC3FR49eQvWVq5oKMyoawiJ
	EoI0FwG8KFsEA2Y53uuL6BRg==
X-Received: by 2002:a17:90a:d446:b0:327:d4e9:c4ea with SMTP id 98e67ed59e1d1-3280d2b934amr9612696a91.4.1756693566382;
        Sun, 31 Aug 2025 19:26:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG04L+mSZQxDAgSndTWXpyd5tyWz7U7JM0QivfjSOHhWazWspQAo9CicjuR8nY9/rBKXoNCJFORwKsWHjouZM=
X-Received: by 2002:a17:90a:d446:b0:327:d4e9:c4ea with SMTP id
 98e67ed59e1d1-3280d2b934amr9612666a91.4.1756693565990; Sun, 31 Aug 2025
 19:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-4-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 10:25:54 +0800
X-Gm-Features: Ac12FXzepgUZC6sPZxvYAfiYbM5Kr5AXV_an7YFO7Nm-RiV0EW6x4wQYznXQpbM
Message-ID: <CACGkMEvUQeA8bgvMthjSAa4u0o3u7Sq3PDoRXTADa9e=c8G7uw@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: return internal vq group struct as map token
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0-qpiKoboj3pQ_UsAW5PqBMKvxJFIkifEXX8mdRkSWs_1756693567
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Return the internal struct that represents the vq group as virtqueue map
> token, instead of the device.  This allows the map functions to access
> the information per group.
>
> At this moment all the virtqueues share the same vq group, that only
> can point to ASID 0.  This change prepares the infrastructure for actual
> per-group address space handling
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
> v3:
> * Make the vq groups a dynamic array to support an arbitrary number of
>   them.
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
>  include/linux/virtio.h             |  6 ++--
>  2 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0f4e36dd167e..cdb3dc2b5e3f 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -22,6 +22,7 @@
>  #include <linux/uio.h>
>  #include <linux/vdpa.h>
>  #include <linux/nospec.h>
> +#include <linux/virtio.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/mm.h>
>  #include <uapi/linux/vduse.h>
> @@ -84,6 +85,10 @@ struct vduse_umem {
>         struct mm_struct *mm;
>  };
>
> +struct vduse_vq_group_int {
> +       struct vduse_dev *dev;
> +};

Nit: I don't get the meaning of the "int" suffix.

Thanks

