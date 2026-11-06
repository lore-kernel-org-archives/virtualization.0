Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954916;
	b=dGasJPR2cKi6r2ndrvedoQTJCnzJT95WU8JbJb583q455170zx/AmyFFNwn/43lUD7+h
	 5/+P7TLyvyfUK4ylSIvpW2fUPA3Dmv0qnw5U7+CLv8K3lwkrFtKReXe9We+JWY9taU1EJ
	 Hu4qClUS8s6Xerlq5Y1YczmwlMsVaAiKvomFCkQkO22KteJ4NPrcdpoJDNW/XZhqXl1Hu
	 FvsSbDIKCVx2+PYxaw1wpSIl5TADTDYSXESOcy9Nv1wjXnCbaTNY+bHXYNkOk5OJfwA2v
	 SWCg7mWdHKhOmeUJP/llNZ1C8IGa6IqE8jibYq2VARx3Te0YtppGAjhrsGlnX8N6jpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954916;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QPSWzvYvVt1otuhEA/nRLFOiH4lZX6RTdmU2sAZbE2A=;
	b=rt8MX802mE9KgztYDh+TcROb06YLLPoN7uyW/TLRkNlqgiwKjFqadlrpAoDm5nppNPhO
	 Mx0humq0GbUoX9IdkVc4Os7OT/h7hXP/U+eoTpeQ7qYtjoyS6OOxWWoa6uF1ikg9WFeZh
	 j/52ak3uziMcR8qjcSE4tcUXaWVQXy2VFWT2+LOjZ2MiPiCxPhUJYRkVTBUkOgDDxXZAc
	 bAdAkLPcMfGMN++0KTPQ+PPoCLeM4wVoRuyla7fO5LsKTINMC9ZrEwon3QO/hB1Ch+8eh
	 VmxJF6bMUAhSpRerphXEV6U1m7dzb+DnOCqrxFQbo7XidNuNFymkJZwkxkkwF71E4Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XmQ1kK/S";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E8606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmQ1kK/S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC81F008BC
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 08:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954915;
	bh=QPSWzvYvVt1otuhEA/nRLFOiH4lZX6RTdmU2sAZbE2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XmQ1kK/S++uQRzPT8eUgxF8quhZhWr+S+11Hf0A1VS0vj+4Np6Jwd3fbMLMkcW8sA
	 DfOKGYeUMJs0hkWvWWP9RbFosgiUfI7NXv33Q/d+nzgVob57itUjKjsYMYA1NXrgob
	 dxUQGn4AYXZHyV2CwBCXbe54s7oMXGhxsgq9N0ZSkkDSxnirRAlx5PoTW0E0j4ZPcB
	 +MIwpE7p7TUo336o+mn67JN6e3SEw2lIVP88uKgROdK99E8g19xWH0QtnMK1UdYitQ
	 iDbXerf5IF+zea39WOY3FFXRQx8mBXifpm9TX8d4wXZnPxnBH6UwZbAsS5dnnL5Tan
	 LZWWdx6LAFnfw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-486f013db83so86321fac.0
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 00:48:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxZTzxM3RyiEU6CErsMuAoUA024fVxqRkUwmTKssU+AhnJBxByq00IkyoZO5ImIFHyXH2dpxrM4Gf7P+mqmow==@lists.linux.dev
X-Gm-Message-State: APuU4Z8a+WLR7QMaBMEFn508Az/S5UwtLjXVat0u67hLpqtocmOks9tF
	cESphXxucYrVluTnlFgKGunsaQQ3mlRGKfkr+YtlU1yzLHSmSeledtIEyjl4CpeJKkzbXdR+iib
	x83hD8+4oU6G+xTwi+MMU59SSjzwDIks=
X-Received: by 2002:a05:6870:8327:b0:48f:e24e:6b6a with SMTP id
 586e51a60fabf-4ad9914e161mr1171313fac.61.1793954914699; Fri, 06 Nov 2026
 00:48:34 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261105115715.1466924-1-edumazet@kernel.org> <20261105115715.1466924-3-edumazet@kernel.org>
 <willemdebruijn.kernel.2494b56c7bdc2@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2494b56c7bdc2@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 09:48:23 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqoa7+=0vxHuG8p497O3yU9hJvXV+F1zpOSOiRMG9-j6w@mail.gmail.com>
X-Gm-Features: AclHuK8VZB_QmyiYw9SabnBbcPNtk4vy7WYuuy3H9l5V4RQHRVJOYmWAQ5YIbSs
Message-ID: <CAL4Wiiqoa7+=0vxHuG8p497O3yU9hJvXV+F1zpOSOiRMG9-j6w@mail.gmail.com>
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Hassan Sultan <hassansultan@google.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 05:18, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> a =C3=A9crit :
>
> Eric Dumazet wrote:
> > virtio_net_l3_start() decides from skb->dev->type whether the frame
> > starts with an Ethernet header. tun decides it from the IFF_TAP and
> > IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
> > to any value, without changing the flags.
> >
> > On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
> > look at the IP header at the network header (ETH_HLEN), and never read
> > the Ethernet header. eth_type_trans() then sets skb->protocol from an
> > unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
> > the skb_under_panic() addressed by the previous patch.
> >
> > On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
> > Ethernet header that tun then treats as the start of the L3 header.
> >
> > Checking in tun that the device type matches the framing is not
> > enough: the type is read again later, and a concurrent TUNSETLINK can
> > change it in between, since tun_get_user() only drops packets of a
> > down device after these checks.
> >
> > Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
> > virtio_net_l3_start(), so the device type is no longer used:
> >
> > - virtio_net always receives Ethernet frames.
> > - tun_get_user() passes whether the device is IFF_TAP.
> > - tun_xdp_one() always calls eth_type_trans() on its frames.
> >
> > Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org=
/
> > Link: https://lore.kernel.org/netdev/179387332014.488856.91119564136101=
07951@kernel.org/
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> Makes sense, and easier to review stand-alone.
>
> But if having to respin, squash into 1/8?
>
> Also, to avoid having to respin too often could (now that they're
> public and archived) leave the self-tests for a later series.

Thanks Willem, v4 does both: this patch is squashed into the first
one, and the selftests are dropped from the series. I will send them
separately, with the fixes Sashiko found in patches 7 and 8.

pw-bot: cr
