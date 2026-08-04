Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54843380FF4
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844047; cv=pass; b=dCzeVoKsejy20+lP6+Y7AIQC0ZshlcWshMhP6z7m47NUj5Uyv9x+imAb2asQiya3hqqcxY+REZCHmXjxE6/oa5c2Cx5Dswz/v/jnLqMEukVBtdroLABms7P629vC8Cmrt+UsZG/TOk/bve8BaX8sO9e2EZNQc1k6ap1J6ilnMRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844047; c=relaxed/simple;
	bh=F1aKEf0+UY8QdGbI80WfjYGHcxUeD+r2aROycezgenk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrFn7iZWMp5o9qWsL81BaKQiHmf92UxSNs2TTYwpQ0phercVG5US6ytME+dLKmKZq1/NDfhp0JIn89NTldkv7fOCYpTtSAlqg3Jf0MmaLwyWf8fyoZAShWegfU2GdoHXLig+ivwIGMwzVl+5NIW/BgcUBtnzomIB3tw5HkBOP0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yst+xMl+; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yst+xMl+"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b015b2d792so4332608e87.3
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 04:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785844043; cv=none;
        d=google.com; s=arc-20260327;
        b=ArXoTYeK9x7v2y5L1qWWi+gtvOn2EeJAOKHGt5ctmB0BSoePzBTJkJbvcHigAJCGFs
         YyTemEbZ/LsfeN3dkV6X5dp5DfYbL9u/EZeGpNZ/WDhTqrRV4X8ISbQJfQjitwQI7oJr
         NG8qN6cXTVdFj37XP4Q8dAzUYbOs/aDO6BWvcQUYk+4fr3C6U81VDDjdRzo4TTe4pl4A
         cwUuTLhwRCrOSo+BcKAC/3q7pao3W/lrnASWDVBuTnOCgXzh3SAJUnzhENOa9hrw7U7g
         J44WpJatCu9EiCKkIjHcMG9qOi5HVzwRyihtb34ez8jxDQADwbp9meWmwtJVJ36JFfos
         DHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wbykn1jlWzXgukkhvoAIgn0Mbp7udhOlX2EPLRb99Bg=;
        fh=SmQFzT/WjTLGijq+Uw5EGK78pEzimYClXHaAK+iu364=;
        b=eRsdYpDpZykDQLclE1uE1nv65YpaFaKp6vWYulV3svOdCDN9zkoy7GRooUCOE2x+Ds
         qduH19PGf3rYTO60lXC51qrZLHSA9RQsTeSb4o4YPiRwzDsDtTGy5hc4obD3K1RKxKi2
         b0yOzse296HeYXXxT2zSkQM+A8PWXugqdxJzGTc5y8J3RKs2OfBb9oZx8ts4YJyDB8B7
         23R2MBDWmZqzB9PXe41DxDVpY/1C9KDeVRzLmP4xkqGUQ8YZUmW5I6g8ge8o4sLcpZ4S
         NpgduWE3/yiaJy0qwt8oyk2sHimYFNdj+ctReqy4hNueewrOVCUdr28YHnYBRE5TwMaE
         07Tg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785844043; x=1786448843; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wbykn1jlWzXgukkhvoAIgn0Mbp7udhOlX2EPLRb99Bg=;
        b=Yst+xMl+UsNqalUnMWcr4JH5v4c0aOJZ/UPx7MEyMX1eSc19iAAkaxBKo96hOBUhAS
         KB0f1SbjeLkfdcYRObl9sYY1WGEHon3h/jKhelZViK6Bl1Pbx5zxT5kHCFBSACaG5nrF
         YC65YXyKbRXK7yxu0NHsQFFhRPRGguavccC4PJ38PaC/yaOBVykXLB80bZRVRPdPCE7B
         njPmjal9Lk8y2qjZlDM6j6wSfC0Eacvcs6lkwVC9x1YUMGNGtCELFGrb6vRCxOnf+v6c
         MYNLbREVWaz3dI8RTfKo9ZhMezzMW6e79+LAq/syeC5YIRSeX3uvIJ+cwtSCVKVnRa0Y
         TeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844043; x=1786448843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wbykn1jlWzXgukkhvoAIgn0Mbp7udhOlX2EPLRb99Bg=;
        b=WaRN3cK4VlyNZbF0nkRfnnPPiDcHT9+iFUuhUf+x7PUXB7Dq/p7OdHgo/2nGl54/LR
         ZTC9QDmK3A+VusPssJgD0nS4LYV/ZAKrY54G1lZ5UnRW2zUjaIFgqzqtqf35Ql706dGe
         kKBjyFP+edNhFuS/XugOBd9O446XmSfmkk7hb5KGJlI6EUq+Db7YnVqMzbriGN587f5K
         69EOB6bgWSafuw0o3vVwbwLhWdWeivD03DU/glRI3Csqy4mCHlPIh8uNx78A42OuACsh
         r/wKzQaQbwr31QpD1tqib6sGGN/d6Dk9UbfocSYdg93a/1aUTfeL04H/OSo4ZPhOTLhq
         tQyg==
X-Forwarded-Encrypted: i=1; AHgh+RpveZCLkxY903u8gxpXreJHO4p68H3XmC7bhnfO+LbH2AY9KUKL5I0p8zGcDgiF8c8C+NaJZNdCkS0zUkAyAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFutHCBT5a7MYdI0fKxz39a/sxfvcewi59BTT4oX5NN0ZExUqx
	oTp5BsmlWEuKg9KUO57s9Vc5lSgnZYI/UKBm4Nas6Rl/vee4sZxpaA8AkfxY7+oA6PScvvZO9vb
	M3YzHcL/AOJmfK0ZnAgL4orv+hHnklww=
X-Gm-Gg: AR+sD11ij/8O3OSm9Hx3H6yCt9reytE4RqmaKDoE3qRAUKaNgCcY6yIcib6bkjwzYGG
	re3EoyTBVOGCuxvG/Rnz4BAKou1CNrjQaFDjB1NGBpVXT3I7YGxm4n2Xl7VCPmTincARzRbQXAz
	p4cbCPH0sdcxA/957MV6sPWsjNjpkHij5M/BkKWKBYmJ700o/2bWvm5hoBvB8DYJkd+Nd583FGe
	J0ppYbU/y7AGXIv0AOgLzOVLycHLniQpH4EblTpDLrRl8k6Y7144WcH+JfaYTDyNYn4iYeU1Bmc
	vmvhduZUAr6INmNelYaNUjlqIYmpDpP59CTej21FPcj+f9/oEDmSR3Zg09fqE4ySMX5QNu+5PNd
	J7Gbrie9cJJ+lFP+nIn23jcIj7dL74PavmWfiv1iS3GvVo+WMv9E87Fp88Djx9fu0OlI3k0gQIe
	9QxluS+A==
X-Received: by 2002:ac2:4946:0:b0:5b0:1572:5b0e with SMTP id
 2adb3069b0e04-5b2e4f73457mr1827838e87.39.1785844043067; Tue, 04 Aug 2026
 04:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
In-Reply-To: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Aug 2026 19:46:45 +0800
X-Gm-Features: AUfX_mypfQk8w7EqOyDcZbbrJ_FGx0Fqf5tiqd7XFD1IFRW0P8HWAI7KhRJaBWE
Message-ID: <CAL+tcoC8ORo3PWxm1Eecbxhy0g+RRHLMJX4gaWxCp81U9ouArg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio_net: check AF_XDP queue index before use
To: Xiong Weimin <xiongweimin@kylinos.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:11=E2=80=AFPM Xiong Weimin <xiongweimin@kylinos.cn=
> wrote:
>
> Validate the AF_XDP queue index before dereferencing the receive or
> send queue arrays in virtnet_xsk_pool_enable().  This keeps an out of
> range queue id from reaching vi->rq[qid] while checking page_pool.
>
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>

Fixes: 24fbd3967f3f ("virtio_net: add page_pool support for buffer allocati=
on")

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c..6160aa8ba 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5896,15 +5896,15 @@ static int virtnet_xsk_pool_enable(struct net_dev=
ice *dev,
>         if (vi->hdr_len > xsk_pool_get_headroom(pool))
>                 return -EINVAL;
>
> +       if (qid >=3D vi->curr_queue_pairs)
> +               return -EINVAL;
> +
>         /* In big_packets mode, xdp cannot work, so there is no need to
>          * initialize xsk of rq.
>          */
>         if (!vi->rq[qid].page_pool)
>                 return -ENOENT;
>
> -       if (qid >=3D vi->curr_queue_pairs)
> -               return -EINVAL;
> -
>         sq =3D &vi->sq[qid];
>         rq =3D &vi->rq[qid];
>
> --
> 2.43.0
>
>
