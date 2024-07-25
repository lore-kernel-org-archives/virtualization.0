Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1219DF81
	for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917676; cv=none; b=Gnvv0Ko4Cxe4Xts1mPsxPJvRA3Agd6IBb8tuQyJjZ6q0i+JSOBIQCSi12J95z6jyDLJjMcTwCjHLSXUQH2zB9E1Zldftoa2WNlkxk2AodwFhw+IFbyowhBHH1jfdexAGFRvEP9y9fSU1FqpKIlcz/OPGc2YU+pcUJI/vuQRQo5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917676; c=relaxed/simple;
	bh=XHO1nFBL0im1uK7xwc2iVzZ8l8PrKgpCKDDqZg7yXV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAKZKkOO5Xz6a9GON/OY1UVIm6l9iANinads9XzyKQhuq9/vn4b3bir/jsQtWRhDnxkd30fb0EjI2Aou/VK5angPtrhGO4lyr7JlqXU0W7P2HtPfbmfrkht7J6vEeNNhWfAYU+9DK7qXzqS/96KSNYQ3wWEfAGlWGKJhp+Z1ZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfe1sRxU; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfe1sRxU"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5cebf0b37fcso608778eaf.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721917673; x=1722522473; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFCck7sxDvRtwwI607C6VaRUtbYIw5wbK945M/Wp52s=;
        b=nfe1sRxUeN5nW13MqUZZAcuFLJDPrMxrU+2/CYuTJqd6yD9P6DI+rHrr/hAvGEX2zA
         UJAcen//lrluesyXk5qNFmgPa6xQqigdl2T5dSQu6jXfRtxj/Sh+4mdtPGdSPYC2aC1+
         95OM5xgPJd6RUsAQraLcaf9UP/MhkXTdPgaVxHWiO5rFm9J64I3HmrZEkUCjOuicJ8t8
         yf+0WuYjJOOAZ1y6fvrF0n3NTJc/07f5ZUJU9Z2O/51O3mqj9gHb61RqIUEHZmpLTE2Z
         n0ijb/DnTPplqpfa8x3YvlN/409nuplNziHctVyeFa3s/N+FMMjO6v9F7aYYYsX7WzJK
         mpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917673; x=1722522473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFCck7sxDvRtwwI607C6VaRUtbYIw5wbK945M/Wp52s=;
        b=H8xmj9BQGAGY+OOZJNKvxDcTAaOuATmbqHoG+rQsSxYNiPsg0i2eo2xKKA/i22i+/U
         eZe8WoHt3myc42C4QMOsNwy0e5c+OAgPjtw+zjOQrTbw7IX9wIV5HuEBVfSAZ2XTfGB4
         4mMaJDUb9zNlamNAoIIdHx4VcYuguJ+VVsE2X+m1adlBJ1BxohKd70xIEAASVMrJ+U3b
         61h5iHvLq9ZOydCsPFsAne025wjnuKeDZC1u2dgp5CgFZQpQolhMR+JOemvJPKuAypsf
         ost54PaYJWJg9FDLkEDIF6gSKAvzPmTemYpqNEvdxX9vgbkPR9sRV2R/0Ot+LFAJUUJn
         fayw==
X-Forwarded-Encrypted: i=1; AJvYcCX8HpRwkVD3GhfOgiZG8lsiHdU+g3SyCazISbZk3he9zY4MirzFsCJeBK05uGEDy5NA4C1ixn41E5No8lNv9w10BwFRPvcl9UYvg3Ucks0=
X-Gm-Message-State: AOJu0YyRdxr/BMb5mWcEzqbi6xyNfFiqkGHouvVJX6IeuH5M+fCnodLr
	dX3mrpyqBt9Br0ffQHsORJAO3LI8MviFJvzVi3RxRN260YEfyO3Qj3doIrszoDwL0w+3QvPX62A
	Da8H8FOPbBhRxWc/qhgDL7HS//TM=
X-Google-Smtp-Source: AGHT+IHPbvYGSnJR0GCBEsQswJKhQFu8SSG99BreHttMoIIqrMlrP75kEoeevLP4byiQ5tutKuOkj52VVk/J1v94Brk=
X-Received: by 2002:a05:6358:41a1:b0:1a6:b070:a58e with SMTP id
 e5c5f4694b2df-1acf8878353mr440623855d.9.1721917673197; Thu, 25 Jul 2024
 07:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240723223109.2196886-1-kuba@kernel.org> <20240725092203.26366-1-arefev@swemel.ru>
In-Reply-To: <20240725092203.26366-1-arefev@swemel.ru>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 Jul 2024 10:27:15 -0400
Message-ID: <CAF=yD-Kz3PRncy4N0LkTSDGm95Zg7yfKDm+BOHBs4NfkEDSJUw@mail.gmail.com>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
To: Denis Arefev <arefev@swemel.ru>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kselftest@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:22=E2=80=AFAM Denis Arefev <arefev@swemel.ru> wro=
te:
>
> I checked the patch on three reproducers and all three DEFINITELY broke t=
he core.
>
> There are two malfunctions.
>
> 1. No flag skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
>  If it is not set then __skb_linearize will not be executed in skb_checks=
um_help.
>  sk_buff remains fragmented (non-linear) and this is the first warning.
>  OR add skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG.
>  OR ask Eric Dumazet (cef401de7be8c). Is checking if (skb_has_shared_frag=
(skb)) so important?
>  in the skb_checksum_help function, is it enough if (skb_is_nonlinear(skb=
)) ?

Thanks for sharing the reproducers. Having a look.

On SKBFL_SHARED_FRAG: as Eric's commit indicates, that flag identifies
packets with contents writable from userspace, such as vmsplice or
later introduced MSG_ZEROCOPY. That is not the case for these packets.

Setting the flag may have the desired effect of triggering
linearization, but it does not match the intent of the flag.

I think we can catch these bad packets with illegal csum_start and
simply drop them. The question is where is the best place to detect
them. I gave one suggestion. Great to have reproducers. Let's see if
that indeed addresses them.
