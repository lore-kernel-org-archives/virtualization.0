Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734432ABE0
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761792170; cv=none; b=UwRT9j6YJPoR95uIrEJvuZ50sXWcJ87zyHAwXWMTyf8l1wGatavbXe4jsJoZN2HsQIU1C+5XaSWKsQqJdkl3CiUhUmTKOFLjVCsksST9QHlOF1b34mi9R5XCh4BBLAfyspKuQzY5vTcml0M5bLeJni/RrpRs8/LGsZmB/OAYNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761792170; c=relaxed/simple;
	bh=eEnpiMSXYQvSVbkRm+5dPeWzUqqgY5BA2tW5hs88yxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifLIsOzOvmqzlPy4UKw1U5JCCUW481C/YMYVCDd5j3o3A5ylj6LqBNPEUQHZH5ywTfEJfSIZ37Be/km+ioSd4U6mNwoJrJJpAw9CaPc7ciNFZhAaJQnqiKhblqovYGrj3kji+X35lv17wI7mgChiyVDg7Np9LEc5Azs7b92Dtns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTkbcLUP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTkbcLUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761792166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/ZCYcZbkclIBTLFnAz2fA6NECmLLYytFhAcPGYaB5Y=;
	b=RTkbcLUPpLUJlw7uCOAA2NYMPkzFTrJLLF7ShE1D3W9AiWq607ZgWL83Xad3kENtyUEVjk
	+xbqaoWhsBY8xRLtMH0kHrKg2tEc00k2TAxPqnZ7LX0RKTbAHBaVZ1EPyxcXsh2D1mTQHX
	I1EgZUP82oZ6k7sC2psafPEizWaA40c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-gOdbBq2OMAeJ243foZN5Hw-1; Wed, 29 Oct 2025 22:42:43 -0400
X-MC-Unique: gOdbBq2OMAeJ243foZN5Hw-1
X-Mimecast-MFC-AGG-ID: gOdbBq2OMAeJ243foZN5Hw_1761792162
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso1197144a91.3
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 19:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761792162; x=1762396962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/ZCYcZbkclIBTLFnAz2fA6NECmLLYytFhAcPGYaB5Y=;
        b=eIC1xuwfL2zL1/R2ZIDh+QvvHbtz8VZ2qKDp4H+HWg8/aTY8Xq2ym5NNEeowwVlamj
         E94pG7SWOrIScduA7/C2DDirGhVHa7RbVb9u15QBNKEdQJbB9aAEwjbeBGBwWR4Supk6
         YhRzZ6gMZvXn+EYeifMOgChlDKxy9eIW/1TuFF/ZOqeSSkayETjssBndjhxcpKln+IhA
         kKyalkWhMRLWqdOVF8/ooMIa6F66A17NA/V5hm6bz1YyT+enSZtbvD0OPuzA9cc3Q7zv
         umUtFIBJQHJoGFKaxZWDFb3xoQdivhDKBud4eFdTPZnXaWpiPosJ2EoL8Utvx5yaoKYJ
         kVTA==
X-Forwarded-Encrypted: i=1; AJvYcCXZp7k07LB3aqv+oe1Pyn/8v7FEAyXAGne5wwf8BuqFZX1H8jkkG+HA3swSvIKiZXYVarn7UbINTPyXNeNICg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnmTWLqjPN6bJiEy8nz1tURrJpVIHcYuU68kFM8jthtvKrzwWs
	WBAFDEKM/m23qG5EYKN+qY/tL3qOr39XTwy2qRwVaj229SFbFjYxofkYNm8vsPZsdjKOEbkW72b
	6Lq315ncfTEwLXvh6wzDUwYs4MlopRVZEaO7VV6nk/M7NHJF2c5CVTY3fv1mkk8oDZwKT27L4pK
	cOyyDTdcSuobL0oAA1TpoHjRWmOH2svc8tl6fkUuVNYbI=
X-Gm-Gg: ASbGncsz8jsMFewTWoIJPfs+RT+8gwYWBHTMOr5y/cC3Ek43VYSMquwKh9QB0DX2i3u
	If2bRQh85wxGipgGQxhALpmLWH65nmtOJ2fhy2ZByLB1JjUVo2luZxy4i5ZPU4H0NvHzySQr0v7
	3UErYqgyyNahdT8Xm/oH2XUKBw+xTbxw2jIzRl7Y6ZdZ8vQ7WJr1QbCIOL
X-Received: by 2002:a17:90b:2802:b0:33f:ebc2:634 with SMTP id 98e67ed59e1d1-3404c3f4a5cmr1771788a91.9.1761792162284;
        Wed, 29 Oct 2025 19:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIVn1Bb5rNjXC5IPex9+DZAuDNurvVlJkJYxl4qjxLsMlWBCjHB2c4xxBH7QS96+rjUVkYNMjDamTWV5i87o4=
X-Received: by 2002:a17:90b:2802:b0:33f:ebc2:634 with SMTP id
 98e67ed59e1d1-3404c3f4a5cmr1771757a91.9.1761792161884; Wed, 29 Oct 2025
 19:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com> <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251029030913.20423-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Oct 2025 10:42:28 +0800
X-Gm-Features: AWmQ_bny5IxrU5zz8cJv4O8XuvV3My3M8eqi2dffdnZElWpOCXh_fsT9qM8wFG4
Message-ID: <CACGkMEszWAc_552TmyqH1grZLDK7ZO_dJ7mr1JD+YK=BphFJZQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/4] virtio-net: Ensure hdr_len is not set unless
 the header is forwarded to the device.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heng Qi <hengqi@linux.alibaba.com>, Willem de Bruijn <willemb@google.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JJJIQV-8JwufjbvUTktEFE4-TOMKaDlovimreeUtlaw_1761792162
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:09=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Although `virtio_net_hdr_from_skb` is used in several places outside of
> `virtio-net.c`, the `hdr_len` field is only utilized by the device
> according to the specification. Therefore, we do not need to set
> `hdr_len` unless the header is actually passed to the device.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I wonder if this will cause any issue consider hdr_len is just a hint.

E.g device needs to survive from hdr_len =3D 0.

> ---
>  include/linux/virtio_net.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4d1780848d0e..710ae0d2d336 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -218,9 +218,14 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
> +               /* In certain code paths (such as the af_packet.c receive=
 path),
> +                * this function may be called without a transport header=
.
> +                * In this case, we do not need to set the hdr_len.
> +                */
> +               if (skb_transport_header_was_set(skb))
> +                       hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> +                                                        skb_headlen(skb)=
);
> +
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> --
> 2.32.0.3.g01195cf9f
>

Thanks

