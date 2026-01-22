Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EF883F
	for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110989; cv=none; b=CMEceYu0nRxDe0kQM1ZwP71fqryYxW+XerANgBsZ4H207fpFOGIQMaouGWxeIg05Ic019sVvYrey9zqcs/bAbQqn64gC4Rtu0FUcBB4p2oCzJdjLDPww3ncIfk5PXSNIZiK857l7hfYPv/FrblCYFfrfvChtqYqc3lIfSu2VioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110989; c=relaxed/simple;
	bh=McfjPJzKwS57vSW0MyNDedyv+QITcO0lgUUipuZFNug=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sT3NEoAC2yWQh4fDow1V83lYMxCZTvEsehDH0A3Gb8RHI2wzrXjKT6mA2qDfp4lO6kohCy1dxbLM0H7S7/4rRXmOJnJAHqhLN2SbU6FWbI14VkESF6teX9OJWup5UK82xozoK6xq4R3SKaQVj5KXdMMuuZ4kuzuBvgzQFhKD16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBhIhvVu; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBhIhvVu"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7942b9663f8so12772307b3.2
        for <virtualization@lists.linux.dev>; Thu, 22 Jan 2026 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110979; x=1769715779; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McfjPJzKwS57vSW0MyNDedyv+QITcO0lgUUipuZFNug=;
        b=MBhIhvVuFhA5QYmNcVSYwY6Ta9+Tt02J5HEVzR4qspP5YWL4wb/r2Qv7sTFkZkV/aV
         Xf7q9wa/YD7OaFxwsOC5M8qSYNjq5mrjm3KKibYCN+hsRUaG83GH9KPgjSNAw38/cFiv
         sKfM38PDKfKn1F3X3Hj0R4TzTvtqS6ZtpBv7FO8NYiY9JT4LrNcNH1feb3b+zxXyFyBf
         SSVnYst3vxe43NlL6RxNIb7ad3weMXp/z0FHRVr5qX494Wu8y3ilp5iO3gxJPE5zUkDh
         kasi51npudDWIS8jrl7BhggQfHWKIcXL/o7uY3+IaSrjzzSEpvYCj1CUWLo1j1/ka1Sp
         JsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110979; x=1769715779;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McfjPJzKwS57vSW0MyNDedyv+QITcO0lgUUipuZFNug=;
        b=bfd7GBOmk+Rbz5y8mdoMGwRvHsaKUco3E2txOhI0wyKCvxweYduqhlwoBvdMnY0tmx
         gy5ZxflAe0zOAgu56aOS39j7CX4WIZgAnMX2YwB3WQWEFpDXCsebz0V0Ivp3/uA0cwlW
         UxCv2YaMQ0JKdnekeJgJwzivXQOPFCTxwsy33q7kTcp5Lt4gqBymPLJdv48p5bGstMMY
         59mS55GsWZAyHnW6uPU1bC3wKEUfQElKCGJoOICcGjmxFGMXigASF75l+ZeyE4kGly1J
         Uj3TpqG4cSBaN1aO4GoLSILChkfmNbnZZqEt5AGRlz7vxG3S7/21v5D+/WqAHbiAfNCl
         7SRA==
X-Forwarded-Encrypted: i=1; AJvYcCXtnbzqhdSKgzaM/SgJCx2o0mbj9DG2PvI6WwHB8uHnjW3WIzqNpDPQaHr3Wft/RVe6EbuFVNX3YncM2JVyHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz32dh2GH4v6jVRV2R6S5B6MCE4dFLrg9gDEVKtpE7bo73oObML
	tx9wc8HmPxYc2Xr4GCQM4eWQwdriGCjGgeVtBPvGxrPK6tBr0xGKhuSe
X-Gm-Gg: AZuq6aLIrimmc1CA/JlJ3pUad49t5tnlWfuzAG9FyUxa76cPa4N1OxOkP+GWZ719jp+
	RaP2d6zbabAhsmRWue/EszTAEWeHTMx3UaW345QmrNUJHXk6wtxl0+pDccoMiJOVzx6rkInLDF/
	imsTQIeQiNawjoXMq6W+YuN7ueKvOXdYg5mydLCFTIyUiU2FJ/PxJHE5HuDQ/5zbj/ePiuMuj43
	CA6yw7iaS4dPdDKd3UypC686aVbCIQCwPj6LKk8KC0Gaz7wevqK83r2LboO1aoDabTxyPZg7Au9
	ndOaWb7QKqo7hNQN60ncDs0tDqNPU9XrXpY6wOtTNLICulyeytobPkgRsfwHEOlBYYrPYdvDMBJ
	WGOfJCYtC2lymgC8a9K49tCAlWYrdbzy+025vh5pJTrcjaWUYTYBX+uJE6LXJtnp2e2wdXSbKX/
	psvOyzHqotC4Oftvh8fLXPuYTBSkPZNGyJU7X6feWOPE3hxSegsWQPEDkloFk=
X-Received: by 2002:a05:690c:c509:b0:794:2c3d:7947 with SMTP id 00721157ae682-794399c7302mr7365507b3.38.1769110978900;
        Thu, 22 Jan 2026 11:42:58 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943af1443dsm678977b3.2.2026.01.22.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:42:58 -0800 (PST)
Date: Thu, 22 Jan 2026 14:42:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 ndabilpuram@marvell.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.359531d88f721@gmail.com>
In-Reply-To: <willemdebruijn.kernel.113a625cf37a9@gmail.com>
References: <20260122091527.339180-1-schalla@marvell.com>
 <20260122075206.504ec591@kernel.org>
 <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
 <willemdebruijn.kernel.113a625cf37a9@gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn wrote:
> Eric Dumazet wrote:
> > On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> > >
> > > On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > > > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align=
 with
> > > > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LE=
N.
> > >
> > > I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> > > Most modern drivers can't use netdev_rss_key_fill() either because
> > > core generates a tiny key. And the devices support hashing over two=

> > > layers of IPv6 for tunnels.
> > =

> > Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all kn=
own NIC.
> =

> What is the purpose of extending?
> =

> The current length is sufficient for standard Toeplitz 4-tuple hashing.=


Never mind, I should read better:

> And the devices support hashing over two layers of IPv6 for tunnels.

I'm hard pressed to see over 128 B of entropy. But if extending, might
as well go to 256 B right away.


