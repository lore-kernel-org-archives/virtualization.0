Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93B1C2459
	for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147886; cv=none; b=A05myG/M6WmPeFKSY5VvvBrnqjRVs4PKABOHkiwgXUB5TB3uE8KSu2aM9Ae8Lp1XW+lW4EtIFcdcbswavRLU1kiOdF9Xv0VUbOKAIlLHxgpDZoTNSjxpe2DtWkaHbmrylXw6NP/Q+E95qkV2eJJGPgzT2WgDOLApNXFWMGT1hw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147886; c=relaxed/simple;
	bh=xvSTe7MkagrupWBAefdjJyXtMIcCbckwXBrGdN7d9l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NDYAzbaafPFHxDGcdSr2eLbAUq1Zjcim4AIXlKt6IFJwUhPB2QSfdFsA49shvYVqTnYzLHf1WiAPYGItK0GIYWKqG2hxdUF71p5bKgAlKgKfOasndJaIzKHYCzr9KnOYvRMzjiOz6hDO3iHdyKjzHhObVMbccXGrCr84YNPRJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fT9JIFO8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT9JIFO8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729147883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xay7m0WxFpn21Bz1X2gL8BD4WBjxqjm+qohOUPEun3M=;
	b=fT9JIFO8umBmO7uKEnGEjRRZ8RqkTj/mQmEEWDLNgRWkoFLF2LOs4Swit2W8JwCT/Ihi8Q
	x0uFweKadWGO/JSbDgYSXrr985Lb1IqMEx+WvXgpNCMP20IIMSjWSEK0tyzTAaIL7vhUhT
	nUF/ea9UpNNEF5Wj7bwNOpYes1H7ES4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-mOZpiVo4MGWMfniBRtDufQ-1; Thu, 17 Oct 2024 02:51:20 -0400
X-MC-Unique: mOZpiVo4MGWMfniBRtDufQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e578061ffso660790b3a.1
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 23:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729147879; x=1729752679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xay7m0WxFpn21Bz1X2gL8BD4WBjxqjm+qohOUPEun3M=;
        b=Dlkgxtc810peW6L6wU7+hbDy8er0wk7USMK1pgplLKQtNth+2e5YRUASsSIvYA0oXr
         mnzbsOrsSM4kaVlaMBq8aMIsa47AFcATaYpXri8B+vs5M/aNa4xYMy2i2U/YsGIlQfZG
         nmyzt3M9m/uof+WD6q+L9MkpeUfrkztedwkCkqtPBc1VMsR606x/om8gKShV94jIx7WC
         vnMtDrQBSiuNrN77TwwsVvhd1DhP17h9mPikWg7nsQNSbZmwN3rqEDs0iIXZo0wSr6/I
         a2EaEm/X0eR5gL//gIRqxfcrCjYB36iuECDG6Ds+HEze8JU9fn04diy2V4Siy+RXon5E
         3AMw==
X-Forwarded-Encrypted: i=1; AJvYcCUWAh3NS4e/E+1321ljI9+oKajEDHPaGAnQddsNQBCoxYi4UC0beHScF+JA14KUxynawPh+fayI+t2Ww2uXNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzL3PW0Om1zG31gABiL6XC3RK+ozPXQERVsk9wD1oLGiKq5CrWf
	LhTPnHAmpyU8ojKSGyt4qtUmkOj89ShDpO5LSc7RSpZOf/80G131mHlKmCbCpoDSGOLD+qqpEkr
	wZyUqZmxYuVoNjpUCmnBDYs6IrHwBmmQ2ONYjW+BfcfNtneVJx+fXBXfDMwd8MJ4Ygxa7diLQTl
	d811upS05yEW5sBTsANe6LVTcCsBXJp+yifXPnk1Q=
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-71e6489127amr18954651b3a.0.1729147878717;
        Wed, 16 Oct 2024 23:51:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGSON7GqEf790y/2ntpuXKji/SEhnmlTHIdPHQBAwq6YDA8De1J3fJmL4zC3Yp6zQMaH7+G3U/d3cye43jIOs=
X-Received: by 2002:a05:6a00:3e25:b0:71e:6489:d06 with SMTP id
 d2e1a72fcca58-71e6489127amr18954637b3a.0.1729147878273; Wed, 16 Oct 2024
 23:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
In-Reply-To: <53e2bd6728136d5916e384a7840e5dc7eebff832.1729099611.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Oct 2024 14:51:06 +0800
Message-ID: <CACGkMEsovgv9=jj76dfATHWHY7c6NAmiqKDaARDGYju-A6zaKg@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: fix integer overflow in stats
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	"Colin King (gmail)" <colin.i.king@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Static analysis on linux-next has detected the following issue
> in function virtnet_stats_ctx_init, in drivers/net/virtio_net.c :
>
>         if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_CVQ) {
>                 queue_type =3D VIRTNET_Q_TYPE_CQ;
>                 ctx->bitmap[queue_type]   |=3D VIRTIO_NET_STATS_TYPE_CVQ;
>                 ctx->desc_num[queue_type] +=3D ARRAY_SIZE(virtnet_stats_c=
vq_desc);
>                 ctx->size[queue_type]     +=3D sizeof(struct virtio_net_s=
tats_cvq);
>         }
>
> ctx->bitmap is declared as a u32 however it is being bit-wise or'd with
> VIRTIO_NET_STATS_TYPE_CVQ and this is defined as 1 << 32:
>
> include/uapi/linux/virtio_net.h:#define VIRTIO_NET_STATS_TYPE_CVQ (1ULL <=
< 32)
>
> ..and hence the bit-wise or operation won't set any bits in ctx->bitmap
> because 1ULL < 32 is too wide for a u32.
>
> In fact, the field is read into a u64:
>
>        u64 offset, bitmap;
> ....
>        bitmap =3D ctx->bitmap[queue_type];
>
> so to fix, it is enough to make bitmap an array of u64.
>
> Fixes: 941168f8b40e5 ("virtio_net: support device stats")
> Reported-by: "Colin King (gmail)" <colin.i.king@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

