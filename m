Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9531DDA1E
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343832; cv=none; b=XY5CS4YFztGtI4F7vfbA3yajqFlKZkA9OIT3ERD1dJI9L3gO9sE0bmgXC//XzQAHXDWVmUzoK7lWhbeag9wuWhxTVojUUh8MyLlYBEUnIbUHeAbrmHYSu3sIm6Mkfd6uxTndQX9xz1IEeZFk2nsakc7RrBlc6IQ0e+7M+7c4gG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343832; c=relaxed/simple;
	bh=zcVb6Cfxy75Ob1kNh4bYs664zPYBcfFrxG08qGEETk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saTHYuNOb9fvANLO2c2g7pRJcHaD4nHfuUfS5B5SFOD6ZWKWVr3YUB1WOYnTCGmRhqb+QaZX7F3VV2Z23irIHPjy6djtkR2/afLPV+AbkwOi+JNHe5OQloVV/qLNkKrEESuNOoknTHeb4IxWVXZjR+r7w4k70xvkoZ0PQsJIP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuwS22VI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuwS22VI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2263428c8baso12885ad.1
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745343829; x=1745948629; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nQBVslpgDVVhWwmvHoRlwAkP6zwHezc78dd9O+zlzs=;
        b=nuwS22VI6Nv4C200EFDd0c2jMpSWBTEOyFWyBu8Fvu+7v38HA+267arh6ylaNxAy5K
         aeif6/MiKd0pv8VQjYHv++x/PX8Nb44sQIXRBezxH3JhXM6A9VinnWEo0JN40Y4Iwdyi
         kLnIDSV5Smrus5xbz73kH0PTVp/MbCTlLGadSvsU2mcIeUqzLvUaOC0mUYZOvUcVZPju
         GHr5KjGKkt2cruUHN6suxGitZV4YJ0LncIttEG/fRE/27blIuuSVAueY1wQboyBfx8Nm
         13kBHj/aYGHzhYPhGGOpMkOgwXJxk37fxzoka7H3Fo8/PjPLWKI2AkBs7ev6KXLPL0cs
         cjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343829; x=1745948629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nQBVslpgDVVhWwmvHoRlwAkP6zwHezc78dd9O+zlzs=;
        b=GtHfnOC8ReJDe4LyPI0QDkM45vSIixdniHFQzOvrWE5qZiCW3kDnbgx3qAaPuBmJvI
         0cXJqCVCvrA9Cjc8Ig2vaSOZwrFgzsCfCyp97qv0D79v2kCINJaXDz4kJq8SI9cQDlBa
         WmP2l+42L+f6iy0mYhgDo/xrNzqaUvh3hxV0dVJXzMEut2h6asGW8BD42TQJxqKSP8kg
         cAnMDtVBj0Uko+dRUjx5nyKSgzk3NQtyWpxchOXrjiQk1r2+qQNEgXoojphtEoUXZsSN
         FRI8B3Tox38S05/OI1//5E/soSSUPY9mrsHfr1LHinx2csUigJdHkPdqcpkYAZIqse+F
         MrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu8qdPwEKJtGHkLFJhRFZ/9BlGBGbbBu6ZssrKRUnPGqjiL44bm5JHZjJgJuMByIz5I95tAj1v2PddR0uQOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuvgKaNtTc32+Eqlte/CoQATf+Ykn4CHNZjif1eAnUJr6Sjzsn
	BapjNF71hsUJJKnSBgDUI45GM3AVNP0QmOLZu3r/0E2EoL3ZfQwqNm8F8JlQ2AX0MWYkMr81lYl
	8pWZy2ATgNW6zV5nwfldQwjcIpHc+cbWsAP3W
X-Gm-Gg: ASbGncsq/mvf5nf7Lp/ydUekF6RlLudc2TeysOfg5X64wBqePEKd5yLxZSr5a4+Lgkr
	x2OJmACiO5zFVmw2WUgSIb/ZiKGBooQcW2QF0Xlww0eAxU7+Cbm3A1Lwj2xsF4RRXnh5qTSc7cK
	TLIkOuFQN2vQAQymCW7fcpSJECrHVXeHSGqEBEBtiYqusKyxJkU4o7
X-Google-Smtp-Source: AGHT+IGSKGIgLM9bohGpvqQzDuyOGN9Dox9hCzuEhi9yioRJmO0B7Hjp5oQ00AwnuEeP5W6trjfsTXRGJyVju6gMOtY=
X-Received: by 2002:a17:903:1a4d:b0:215:42a3:e844 with SMTP id
 d9443c01a7336-22c54562829mr9132085ad.17.1745343829160; Tue, 22 Apr 2025
 10:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com> <20250417231540.2780723-8-almasrymina@google.com>
In-Reply-To: <20250417231540.2780723-8-almasrymina@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 22 Apr 2025 10:43:38 -0700
X-Gm-Features: ATxdqUEoZbftW3pP1LK4aYTjtkb7qLFfr67voRhIGom_RJK1JmrrX3YpsAjUeYk
Message-ID: <CAEAWyHckGSYEMDqVDT0u7pFCpO9fmXpEDb7-YV87pu+R+ytxOw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 7/9] gve: add netmem TX support to GVE DQO-RDA mode
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 4:15=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
> enable netmem TX support in that mode.
>
> Declare support for netmem TX in GVE DQO-RDA mode.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> v4:
> - New patch
> ---
>  drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 8aaac9101377..430314225d4d 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2665,6 +2665,10 @@ static int gve_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
>
>         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
>         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_fo=
rmat);
> +
> +       if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> +               dev->netmem_tx =3D true;
> +

a nit: but it would fit in better and be more uniform if this is set
earlier in the function where other features are set for the
net_device.

>         gve_clear_probe_in_progress(priv);
>         queue_work(priv->gve_wq, &priv->service_task);
>         return 0;
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> index 2eba868d8037..a27f1574a733 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -660,7 +660,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_r=
ing *tx,
>                         goto err;
>
>                 dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
> -               dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
> +               netmem_dma_unmap_addr_set(skb_frag_netmem(frag), pkt,
> +                                         dma[pkt->num_bufs], addr);
>                 ++pkt->num_bufs;
>
>                 gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
> @@ -1038,8 +1039,9 @@ static void gve_unmap_packet(struct device *dev,
>         dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
>                          dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
>         for (i =3D 1; i < pkt->num_bufs; i++) {
> -               dma_unmap_page(dev, dma_unmap_addr(pkt, dma[i]),
> -                              dma_unmap_len(pkt, len[i]), DMA_TO_DEVICE)=
;
> +               netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[=
i]),
> +                                           dma_unmap_len(pkt, len[i]),
> +                                           DMA_TO_DEVICE, 0);
>         }
>         pkt->num_bufs =3D 0;
>  }
> --
> 2.49.0.805.g082f7c87e0-goog
>
