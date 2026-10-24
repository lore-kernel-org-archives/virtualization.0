Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792807872;
	b=OcuV/Io43OCaAYHdaoqR05yAjTO7JcxRtCh+45euyKDccsszSZ2cNhhYEAukz/Gq4IWa
	 pmxD32teIA7vPgk05igxROxHDfRNOE17CRSCzeCOp3XpJcItoGks1EbteNSDwuUszTTxg
	 KR+huIEnUkqntCKOGPGPfbn/MPzIUY0kitMCwXAqVKf+VXe1N3OWMKYTh3iU4rCHhokjS
	 B5VnFMIgz4Pr//gODZ0r9YhJIcz8CSq/aemJKc2EdbBQa7JG2q6HFxYqm1xNAKm39vY6h
	 CGFfRMB3jAkYmzlYebOcX4GCKuxHMht6MqeNUnfcPAxniZKkbKFPOPkjyibM8PrgNng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792807872;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=863FoNpy4fj3rnzzl3jnxGRI7PKAwuQa9MouObwaNBU=;
	b=flZjNkSyilcndn+/KZw+A68kXLgTsh2l3Rk3qHMaSn9aTWUYoxkHrOf/IfADrtv9au7V
	 UzTkFYnwl0C3gwEAz5npGBw0A3Yr/QD96B0TkG5UeRvuz6GH+4W7junT+oDRz2F1Nxs7/
	 DrSASfm8NZLEMWgzTwWH9YfLMgiz4P1FHyiNKXqzTZgpa2mVna5ssnbdabZif0IGAM4TW
	 V+IlZ4X7f2U3oOE/8pWVp9TWbwgtm4fhbldT/TyRsyAH24X9syr57QYLFOwVfYNdr2yU0
	 OIOcY0tmqVyjcgL6ZMLMFwKtppEnM9LtsCb6WeupsYCFHt6Lsk9PRdE0SqPustuabzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fLNbGzcO;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA246606A31B
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 02:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA246606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fLNbGzcO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792807865; bh=863FoNpy4fj3rnzzl3jnxGRI7PKAwuQa9MouObwaNBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fLNbGzcOgmMflwz2BVnAkdwzwvFmwyQkbEBnzvnf2+uYWmhbA7R6/XQ1vQnZ95AXm
	 GvvF5BGodXNvZs3gObE8P9Acw8OwpYoZfjjhZDfFaGgnIg8qYDzaHmT+TQuuBnij0M
	 560SWiYo/WJfqP4GS+44h/SQPS285ekaO8aJNW20=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 2C2AE094; Sat, 24 Oct 2026 10:11:02 +0800
X-QQ-mid: xmsmtpt1792807862tc0qulw03
Message-ID: <tencent_E3543FCAC26722EA3D15F87B69C4C769D905@qq.com>
X-QQ-XMAILINFO: N1JCMsqefaecSzIBam8zWC5oCLpflIj/PvoxrkbFRGfCDTMnJrNWJalOpMgpWy
	 lZ5jop7pwKzc/YofDZI/nApfWcEv+wKGMpLXrdhGmNkY7gETnac3N8AJb6m+SgI+7qClPSF7fcOK
	 swsntUlux4TOwC6WJN6pfea8uAm2S49GUcz32v7VS0geJ/KWyXHbrGrpKLWF6ltbzd/soQjzT5qL
	 PgZErt95Z6sonVLirwIznH2y18bJnqpiLQBCvQUEEYeGc+g24b0ki18y75GdktlZNV06iGOPiA6h
	 Z0UOJlXIVk+Cm8bFQGM/sQE+L4Op1aOsv8lxRi1e3NjZetZO1CXs8LzXoRzkXI3wRGE2SwLDsGQQ
	 z8GyF6N34f5/YFvkt1SVyWlGplGJzNjIReE8WdiKSJOkUDq649ggUr/uhogI8z7mqVpoqRWbENWU
	 bUTMKakS9j1Lij6Keyl/idrNzAnBlEODrTcMO8C4ElEnzA5RDB80pHHUWTH4zpB43D4e7cqO2d38
	 uk/7uvv6NMiQ14KOC33yQOc9qpLma00wyVluGQhO16h1CafdUpnTttIY+n3ppWDz5WYB51nXfSbl
	 /3lqGPyjrzRDIW1jYrrEsizm6QwE/MiPtEUlNz1y2sGMA8lSbSZoU+cN1t9+rSgz9KQb4YLZIGPP
	 zLly11CKIEKMUZQQT9sPJlv5ad7rhMmVDueO4wI+NsTDrnohDw+5+h+AOiJ1XDRdsLVO9Bze9oRA
	 F8pF/QHGjBfz2VOuOU0cflr5vz8TEqju7v/4o9fN6Od2MY9FrLK9Rh3kGy/986ucdTeTzOrRIhJJ
	 3yKQ/YKzY9bRQtOrTfLO3GGXuJLhCbbCxU9ygB4mDUUBxbr7CVClKacABWd1rI0kYt9cYokgwvvV
	 uNP/gIyGwAwj2UJ3jLYLmbg3Rriql+qK07mPgfpA+fIGPX1Kz9kwKrvUxtbaOmZ+X7uqq4NsQ5zH
	 0MkIQVVN3eBUOXyGkL+wI1BIAk3nNlWKAkCeYIv4vIXX1Gfxxa8FMBIU/+EjI2i/7Lh3LXEMVyhj
	 xRhjZpvHfyZL4ijdZtdLV8WR1So0yTK/yp11eFlPJN82CwEs0m
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Guikun Yang <yangguikun19@qq.com>
To: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Eugenio Perez <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: initialize the whole negotiated RX vnet header
Date: Sat, 24 Oct 2026 10:11:01 +0800
X-OQ-MSGID: <20261024101101.71420-vhost-yangguikun19@qq.com>
In-Reply-To: <20261023080824-mutt-send-email-mst@kernel.org>
References: <tencent_803981983647D9F9444561A4227F138C600A@qq.com> <20261023080824-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, Oct 23, 2026 at 08:13:22AM -0400, Michael S. Tsirkin wrote:
> Which backend did you use? Sounds like you did not set
> TUN_VNET_TNL_SIZE or did not set TUNSETOFFLOAD?
> That's the issue then.

The backend is a tap device attached via the normal tun path:
TUNSETIFF (IFF_TAP|IFF_NO_PI, no IFF_VNET_HDR), then
VHOST_NET_SET_BACKEND on the RX vq.

I re-ran the repro with TUNSETOFFLOAD declared before attaching the
backend, listing every offload bit the interface understands:

	TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
	TUN_F_USO4 | TUN_F_USO6 |
	TUN_F_UDP_TUNNEL_GSO | TUN_F_UDP_TUNNEL_GSO_CSUM

TUNSETOFFLOAD succeeds (0 is returned, so tun accepted all of them,
including the UDP tunnel GSO bits).  The result is unchanged:

	features[0] = 0x108000000, features[1] = 0xa   (tunnel bits on)
	VHOST_SET_FEATURES_ARRAY ok
	TUNSETOFFLOAD ok
	--- RX buffer first 32 bytes (initially all 0xAA) ---
	hdr: 00 00 00 00 00 00 00 00 00 00 01 00
	     aa aa aa aa aa aa aa aa aa aa aa aa     <-- offsets 12..23
	     33 33 00 00 ...

Offsets 12..23 still contain the stale 0xAA fill.

The reason is that vhost_net_set_features() computes vhost_hlen purely
from the feature bits passed via VHOST_SET_FEATURES(_ARRAY):

	hdr_len = ... sizeof(struct virtio_net_hdr_v1_hash_tunnel) when
	           HOST/GUEST_UDP_TUNNEL_GSO is set ...
	if (test_bit(VHOST_NET_F_VIRTIO_NET_HDR))
		vhost_hlen = hdr_len;

TUNSETOFFLOAD only updates tun->set_features and the tap device's
wanted_features; it does not feed back into the vhost feature bits or
into vhost_hlen.  handle_rx() then writes vhost_hlen bytes of the
virtio-net header into the guest buffer while handle_tx() / the GSO
path never touches those 12 bytes for a header vhost itself built.

I could not find TUN_VNET_TNL_SIZE anywhere in 7.3.0-rc7 or in
linux-next (drivers/net/tun.c, drivers/vhost/net.c, include/uapi/linux/
if_tun.h, include/uapi/linux/vhost.h) — is that an interface from a
tree/series I'm missing?  If it is meant to gate vhost_hlen I'd be
happy to re-test with it.

Meanwhile the stale 12 bytes are observable with a plain tun backend
that has declared full tunnel offload support, so I believe the patch
(Zero-initialize the largest header layout and copy vhost_hlen bytes)
is still needed.  Happy to re-test under whatever backend setup you
had in mind.

Best,
Guikun Yang

