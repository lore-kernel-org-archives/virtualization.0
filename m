Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE412C6B8
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609610; cv=none; b=W4w1INNjbsv+DvrYDgqleZ5Ib+OsAmnL3ymd5MctQigedBt62WRMkTFIEq9iDhbUT1rE42aubhc3AoFo1Mo2Q/vRh9Oo2YsnsILXH9EBWqCvkNsiul0YmztS7IbiyrTh+ifHsNKS2kJKyNk8vNl3SrlvaNhh4s0hy7Ey3BWnn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609610; c=relaxed/simple;
	bh=rWUEtU0RNdJV8JflDmOnHRHkp+n8OyVdKJqpGZl5iwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXMQve4Z245rUvv2KJIaFK1RkWb66AnLpjy95pUdjFDcSdi2kd/izHX5XRlUR9mEVVWxUPv62Hb+tSloAo/JwPWYJ/r5zer3ByOcUb0J+U571SucbYYJl9uXRZtH7FFQzRfWiG4V9GMTZu3uwCNpEUpjLyOvZpFTqzzzHX0zhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJDniCui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJDniCui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711609607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bnDouKQUa1KFdv6sPVLtYBCuBumGNcRSCwaUxiEVNw=;
	b=CJDniCuiamXtKPJQ/tlj5opR5EwAaW0+yd/Y6ozinbrnruaErT9XExN83d9T6UlWvp1D/9
	kT/E+Nxg1F1QYrRqsx5mV/a65ZCrkM4ObqTAqXZEntBPowvpgytH7KTXmEdsrXW40nGn/Z
	9+vXlLfsPOVTARmhGHEAZHmZB332Uq0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-60qpqe9XM-iQsTpzE1E6BA-1; Thu, 28 Mar 2024 03:06:45 -0400
X-MC-Unique: 60qpqe9XM-iQsTpzE1E6BA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ea9ba4d1cbso620494b3a.3
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 00:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711609604; x=1712214404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bnDouKQUa1KFdv6sPVLtYBCuBumGNcRSCwaUxiEVNw=;
        b=WzcJr1CQ5VtYs5wBX5+ronzXb4TNgWLgA4xtmnvkptS9PZUebLpnT50yVSKCF/zITk
         n5H05rGhACU5z/XfB8ejr7L+7KCjN+ZFsfvqvL/IeIu6iSQcjD2puU9bzbeRtUu+Xbp7
         98L4PdZvVXx53+dtG0yaVU6Tr6YRvVwztdD+BtJLhGgVQnrMvqkeCY3NNY4AVwEiMM4K
         EnaW1D0gLPtDr0IHTiOgRrP0up1NWFzLx44eOouKscOpsUts99/4pQImaBfzNUd7CmWb
         ebnMaDK4YFASV55qjDKiH2Dn3YEETYQCqy6WXpofTfTnUheNbzlTF/H0vEqvIjB2NJXF
         uTOQ==
X-Gm-Message-State: AOJu0YxWRxIUxzZ64FTGHTZHqlll72wf+rtdWRYrhUqKaEYTResAolDn
	0M4SZJVdFuCkJXid1LD9M5F8liJ9VY+SNPvLnMWjPhLFzYiDJ/bx8YcQa08RFOJkhDr3ac6Xbf+
	/OZpW3AZjUJZKgiREsZoH4t0qBC9PuKkcnJTsamsZWd86fsZmBpVzb0IB0HCHUwXjaA9HWIKbyF
	EofCH1ntGhZrDSRpmkArYxGQmPy01ggcEAlUnJo3U=
X-Received: by 2002:a05:6a20:8427:b0:1a3:81d2:29f with SMTP id c39-20020a056a20842700b001a381d2029fmr2801597pzd.17.1711609604521;
        Thu, 28 Mar 2024 00:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1CQGXYHWT4HkvLD4Yunmea/2pSjRrMA+FI4rzfQdiIMS1QMvFkNcdQpc5EwZEahWf0bT8RKZgwK/RMww7m8A=
X-Received: by 2002:a05:6a20:8427:b0:1a3:81d2:29f with SMTP id
 c39-20020a056a20842700b001a381d2029fmr2801581pzd.17.1711609604186; Thu, 28
 Mar 2024 00:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 15:06:33 +0800
Message-ID: <CACGkMEsmnzEUmaffn3ueY1JtbJ4UzLpr9o0s4j1jwoVuO-yy8Q@mail.gmail.com>
Subject: Re: [PATCH vhost v6 06/10] virtio_ring: no store dma info when unmap
 is not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As discussed:
> http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_yC21=
bgGkKZh845w@mail.gmail.com
>
> When the vq is premapped mode, the driver manages the dma
> info is a good way.
>
> So this commit make the virtio core not to store the dma
> info and release the memory which is used to store the dma
> info.
>
> If the use_dma_api is false, the memory is also not allocated.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 120 ++++++++++++++++++++++++++++-------
>  1 file changed, 97 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1f7c96543d58..08e4f6e1d722 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -69,23 +69,26 @@
>
>  struct vring_desc_state_split {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc_extra *indir_desc;    /* Indirect descriptor, i=
f any. */
> +       struct vring_desc_dma *indir_desc;      /* Indirect descriptor, i=
f any. */
>  };
>
>  struct vring_desc_state_packed {
>         void *data;                     /* Data for callback. */
> -       struct vring_desc_extra *indir_desc; /* Indirect descriptor, if a=
ny. */
> +       struct vring_desc_dma *indir_desc; /* Indirect descriptor, if any=
. */
>         u16 num;                        /* Descriptor list length. */
>         u16 last;                       /* The last desc state in a list.=
 */
>  };
>
>  struct vring_desc_extra {
> -       dma_addr_t addr;                /* Descriptor DMA addr. */
> -       u32 len;                        /* Descriptor length. */
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
>  };
>
> +struct vring_desc_dma {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */

This seems to be odd, flag should be part of dma info.

To reduce the changeset, I would split out next.

Thank

