Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00EA1C173F
	for <virtualization@lists.linux.dev>; Wed, 11 Dec 2024 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896214; cv=none; b=tT2X5mwxORUpTsX0IBFMA2FuHetw59nIFN/7MYTUpgd6nmFg6lHIGXUpOyTloVmBCUnvkpP4CWTs5Cf9DiCBzOTaucyK9vXtWzpDKjxkUt93Kx6vlaQ5sbzjBNQre38VqXtxfoXY4jWI0Q3CHM+sx3d6vOYKuORnrx6Gdns1vy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896214; c=relaxed/simple;
	bh=pTw6+HXewQVV4V8HC5eH2eUX2bdmmcmJFKzFd4Ir55k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WF9p0ItZpjZttUw2luHhsRHzCm//DSIF0LycHvnjkkawFT9fIKhE3u8ufpgBg/UgB1JvgdMqxtbFAlWM9QYKCKhqUyqRIwvBw+IEBRmCkjkGmW96wxx17TMMDDv6SjtqMuBQ6p02lPC89Fxalivy5qk4XgkYoTx2Xy8MGmXEFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btHkwCKq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btHkwCKq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733896211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZKzAJOTVUI2+3jv44AVXBEr1V6z3Mv6Ud2xQd2hF/E=;
	b=btHkwCKqAjDdB57msnW3IT8c3CPi9NW27u4laU4pg3dOMpzAcJTnozqDUkHOPtJv5ESanc
	L7/LSKym9Jz29WWzJYpy+W6msLedA7HwpRcKtMIJ0bizUQnkJrnwMDj6/mnsZFJDrhX/Mg
	1SkaLeh/HckXEqzwreenOeSTmBesmf0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-9edtg78_MFGHBVeBmAYtdg-1; Wed, 11 Dec 2024 00:50:07 -0500
X-MC-Unique: 9edtg78_MFGHBVeBmAYtdg-1
X-Mimecast-MFC-AGG-ID: 9edtg78_MFGHBVeBmAYtdg
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa6732a1af5so13835866b.3
        for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 21:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733896206; x=1734501006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZKzAJOTVUI2+3jv44AVXBEr1V6z3Mv6Ud2xQd2hF/E=;
        b=af2y0mFwkD6wTY/Gc1h/0o0T6tHSbcthGvSF6dEnZ2iBgXa1a07SF/zT6zsz/XrM7+
         PjH3pNU4wYarbaBdRMZNumW52Gh3IzdlbE7VMlocKXxjmfP9qN3halvv2Ql1xmsCrUOg
         aceU8HjO6Z1qL2iY5rT4f7dHzl0fnIPuVzxvVZbe0PpbB9XfaZt8C/15vvl9n37UPxzr
         mfF/6jLxaFcyytGBZLK1LGNYO6Usl/pD3FfZrR26CSs5neygcdAKMD/lb+Yxr69MKCUI
         T+no7v3rfuyfSzbJsOnQ6NjIiQ5zgBhYjWK32/Rf9s7KAHDs+Gl7MJlUEh9POAzVvO1g
         Jhow==
X-Gm-Message-State: AOJu0YwTAp/ONvNxiiO947JYDytrfgLv5pm5Fq5MiFfpzY7KoOJd0U71
	UWsEiHHESMaClfzHoAQXwQHvIxkqjT426SBQsUNaVSLAe6xWuaGBpXK3f7e2saVv8DKjJNyICnp
	Ct0iHkw+vUv8HQ+WhgzwLE2sbHYZ+6jiX0q/0bz5hsZVs3Yy+QeWhBdMSjn/c0J5MONK1RuYj1z
	Q3oV62F1SOkriDt6TD+z7XDlIoRJWUK+KRgaEE49s=
X-Gm-Gg: ASbGncsKnC6L1KSa4Vd3EWQDc44NPXcc0GYKAj1A9HMKk81mbDFojERvJVhkNwJwNqm
	9GsdE61mE4xDHt+vcpG3/AJxKVmMkcdZQSRmA
X-Received: by 2002:a17:907:7702:b0:aa6:acd6:b30d with SMTP id a640c23a62f3a-aa6b1396eabmr113659266b.48.1733896206573;
        Tue, 10 Dec 2024 21:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpDct7ZNNOFQqgGk4S0pzIyNtjEkcahpRAQ25cSBOXT+i/S1uQlOHn7d+0GcNwBJsWFR2bkTyTMTH2AqxqVS8=
X-Received: by 2002:a17:907:7702:b0:aa6:acd6:b30d with SMTP id
 a640c23a62f3a-aa6b1396eabmr113657466b.48.1733896206265; Tue, 10 Dec 2024
 21:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241206011047.923923-1-koichiro.den@canonical.com> <173382722925.756341.2427257382387957687.git-patchwork-notify@kernel.org>
In-Reply-To: <173382722925.756341.2427257382387957687.git-patchwork-notify@kernel.org>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 11 Dec 2024 13:49:29 +0800
Message-ID: <CAPpAL=xJ9_-TU=9rhtdR78g-SVSn9vOMBr0vaA8VbP+eLykvFQ@mail.gmail.com>
Subject: Re: [PATCH net v4 0/6] virtio_net: correct netdev_tx_reset_queue()
 invocation points
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patchwork-bot+netdevbpf@kernel.org, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dxor7FEz30PHsdLSmxp08kOquK6p5sy-lIixALaUabk_1733896207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series v4 patches with virtio-net regression tests, all
cases test pass. But I hit a bug
https://bugzilla.kernel.org/show_bug.cgi?id=3D219588, only judging from
call trace info it should be a CPU issue, and not related to the
current patch.

Tested-by: Lei Yang <leiyang@redhat.com>

On Tue, Dec 10, 2024 at 6:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Fri,  6 Dec 2024 10:10:41 +0900 you wrote:
> > When virtnet_close is followed by virtnet_open, some TX completions can
> > possibly remain unconsumed, until they are finally processed during the
> > first NAPI poll after the netdev_tx_reset_queue(), resulting in a crash
> > [1]. Commit b96ed2c97c79 ("virtio_net: move netdev_tx_reset_queue() cal=
l
> > before RX napi enable") was not sufficient to eliminate all BQL crash
> > scenarios for virtio-net.
> >
> > [...]
>
> Here is the summary with links:
>   - [net,v4,1/6] virtio_net: correct netdev_tx_reset_queue() invocation p=
oint
>     https://git.kernel.org/netdev/net/c/3ddccbefebdb
>   - [net,v4,2/6] virtio_net: replace vq2rxq with vq2txq where appropriate
>     https://git.kernel.org/netdev/net/c/4571dc7272b2
>   - [net,v4,3/6] virtio_ring: add a func argument 'recycle_done' to virtq=
ueue_resize()
>     https://git.kernel.org/netdev/net/c/8d6712c89201
>   - [net,v4,4/6] virtio_net: ensure netdev_tx_reset_queue is called on tx=
 ring resize
>     https://git.kernel.org/netdev/net/c/1480f0f61b67
>   - [net,v4,5/6] virtio_ring: add a func argument 'recycle_done' to virtq=
ueue_reset()
>     https://git.kernel.org/netdev/net/c/8d2da07c813a
>   - [net,v4,6/6] virtio_net: ensure netdev_tx_reset_queue is called on bi=
nd xsk for tx
>     https://git.kernel.org/netdev/net/c/76a771ec4c9a
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
>

