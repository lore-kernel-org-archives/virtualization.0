Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14486155723
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786881; cv=none; b=prBSLjlh7P8dxs2Nxu4Kt0ekNkTqvvRR68iFcRmvJTLSU5UQFEsii9nXGIDiksPFMbUMfx/cQ5CdrQ0ZV8I/0mdYLD8SCEg+KEAr9raCY1nHoccFOSnwQ2XYnXFkUTl/m7Sm73WWY4L2Rq7fijoYe3pO0XX6sheh394lrj4nTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786881; c=relaxed/simple;
	bh=uEvMKF3uwyKPakD5edexvI8ElbNThkFQyh0n33CBN3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFG0DisNG2njFQeURI9IK5M4hMzLEzBx92qz/+yC7Wq0lebuzFshgLA+WvUHVoyE6P8lZTEix5YTnA1qPttYwQJN6TJRaEmQ5fKQwUmGSkbrYxW0TVR5//i3HxMjb5n2FB07CKc5eZDDq1IJLsu2gis4Mu/dLuvj2X90bD0yHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpfyoik6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpfyoik6"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso32507a12.1
        for <virtualization@lists.linux.dev>; Wed, 15 May 2024 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715786878; x=1716391678; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmH/Ugjxp31Mi4ohhV34lW02fEsBuZ04RNA7UDSOQrM=;
        b=vpfyoik65vTbxGfdrmnbc2DCjIfDKaxUJb28qHrxAkETA26APHhMhxo02TnsHLBuek
         HQkfcap7fudGPA3x209IErUg+QT9ZXYHVg6W0v7xVGOF3j+vx9L3KoUS1PhrvC7LLdrc
         D7vuh09ToiKa6FrV3ntP23OGZh6s4TfTiPJxqrwtT9iVavmRRH3/80fUjlGphkKy2KjW
         7Tv49Yv2PsqyQvgvzHk9n0MW9U1ZwixOapU7Pjie2gVIIovYdC82ddnwY1aou7K8yoli
         1QPA0tH/8J1ON0f8YmfA2TY+L2FyEedeNSL6nwIZPa4Fm2SeC2wRgsIMQ/O/s/JzAdMj
         RMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786878; x=1716391678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmH/Ugjxp31Mi4ohhV34lW02fEsBuZ04RNA7UDSOQrM=;
        b=ERC74UwtZ3RqDGRleu1tqBJFpPdxGlg8MaD4uH5xyIG8zMriVTzV4qMmBLi+ug2s0F
         14gUu97DvFaGNJLy2ABybMxIQ3+B2tQJc35fnK4De1EGGaSZE8NEOQFKzElsQ+I2MU1A
         XE7SiwbU07uFrVgTAKVxBzKcPlkZwDYV3gF2pjuIE/xnLB5KKDtx0fyCgKk0jU3Ytq8U
         shfUv5Qpu/mex49J8SzcA1W0I92GAss7WPR0LEpIhpwjPq6QykYaO9EvRBG4TNqkGG9k
         45WrICFoaglDGpIMYyHezRiG6c4su2RPFnAxhFauh01Qu7jGy8BNFm6VVgcgMHiYXEGd
         bGlg==
X-Forwarded-Encrypted: i=1; AJvYcCUOTAwMjBg8PNbCRzhJ0nJ9YUyE+Kg5nlVaODI3/Bg3teJ87O13c2FCituYJyrab6G78xcpeoAE51SeDgK5yzfb5Un6JfihnzNYIVMOKNw=
X-Gm-Message-State: AOJu0YwrlUxhIDPLjGjV4pMNi4N7gW/d9qMvyH0ubFavt6+xZhdDVhHy
	8yE7IwIhaFulIQaCvbm0zwIUoDN1k2cLJT7OHR9VQWRv2To7pwKbw+7aEcatlo02NL6tqIf106Y
	4Skasyk9eL+omIDqKY3XGw04CrPVmtnNfr/38
X-Google-Smtp-Source: AGHT+IHzpp6BZkotoofyDJ4SdL5oyEIvlY9OgIr2daPi3sRGR0q58ATvx4vc/z6ta2RnisKfIJytMRUBnfCNmphB9+8=
X-Received: by 2002:a05:6402:5248:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-574e7e13675mr480199a12.7.1715786878207; Wed, 15 May 2024
 08:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240515151152.564085-1-danielj@nvidia.com>
In-Reply-To: <20240515151152.564085-1-danielj@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 17:27:44 +0200
Message-ID: <CANn89iJmr9ZtfT0jp5kcLC9BKha_QM2U0CpgeuaztMEo4nX64A@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_net: Fix missed rtnl_unlock
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, 
	Eric Dumazet <edumaset@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 5:12=E2=80=AFPM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
>
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fh=
c8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..e2b7488f375e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_stru=
ct *work)
>         if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>                 return;
>
> -       rtnl_lock();
> -
>         promisc_allmulti =3D kzalloc(sizeof(*promisc_allmulti), GFP_ATOMI=
C);

While we are at this, please change GFP_ATOMIC to GFP_KERNEL here.

>         if (!promisc_allmulti) {
>                 dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n"=
);
>                 return;
>         }
>
> +       rtnl_lock();
> +
>         *promisc_allmulti =3D !!(dev->flags & IFF_PROMISC);
>         sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>
> --
> 2.45.0
>
