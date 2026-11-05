Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854913;
	b=HvPfjR67AdPV+t9V4KAZSpKbco3/aCSDHJAAKgdao92xFWHjvoT+mW8okxg/icyd7sz8
	 hkBzTFlobA+sZUMJeOUPEiGc4H3op1ZenjEcqeGIzlFdvKZhXKujygvZDXTTVhTEI4Ukb
	 WGL5kvyeJE+OwQ/8IbMSKdKrWMm7sK3eiM5Hd4f7N3yxZW5jgEqCMA12Me4ASahd4bVHG
	 PIAQqqlPVYUDMCGSkY5BWngmRE7swQcudVpfILSI9eOQuwk9HGIM1eA+5MIwnnqVni5c2
	 mQ219aCavBnbFtbFPVQdeQ/SBDIXVjgQsVlXGBZlc3pMU6JfDvVr0MGkVkrp7R1yFbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1Mw6dAv/bozLoZkxzyKx6Wr35ENEDFcKPs0f8P97V+Y=;
	b=gXNE1xzcgczJqXXgPvW9qM6mL8VqlAn6xYo42PwIjYKupqCuqnsbjF7PWUdhMycQn7mB
	 lXxhr7c9eXaCzcX4XVQGw8pzCZLu+zbm4mn4wPsenOG4XB018S3v0Majw8XNc+HQmAVoX
	 RdXAu/O9EAyPlG3Qk9xkklbrfHKIr6prVdZzd3gO6q+XZaw0n2tBOSZbcJskT2jKhUPkw
	 fCxBJ8I1yrTwSsKd9G2fgaxHuZ6wfnCPP29yqCdWdbd75oYpxngeBE9VKgXrUBOp+NxZv
	 6HcjEIWgobgleoa0DsEGly9vBolxMHdkkQmcX6Gsu0aiGwUokmGlrHfKSeeQSlnCVdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAh7mU3s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3E606A329
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAh7mU3s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D01F000C1;
	Thu,  5 Nov 2026 05:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854912;
	bh=1Mw6dAv/bozLoZkxzyKx6Wr35ENEDFcKPs0f8P97V+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAh7mU3sldLHURdTPuzorKMzfZzZ8Npy9Dn0p9b+93OVU/DpdDvDPB94FKoaY90rq
	 cZghpnjSgoZxL5zdT0ddBozMNiib2EWXfkA3tIHeY8RT30bxwd8NDoUfcyB0RbyCfE
	 x85YhvDonSnIfPQsfjXWHd1vFpqPclMxQshq/G6YYEpSNcYUSoZHQo0V8eqUSzY9fd
	 UpfWrL89eK8m/A2/ftl1pYlu428PmqAcHYGNAmF/lm55x3VN7Ee685Ih3KOxAigFlm
	 I25MBO7RKO9MP51s7Qm5sIJMc/n6zNvqPrYnqDSmCQea/EuaNLe3do0bo7Aavd7tkx
	 2BIMR3ucz5Tcg==
Message-ID: <sashiko-outbox-198573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104050131.629967-2-edumazet@kernel.org>
References: <20261104050131.629967-1-edumazet@kernel.org>
 <20261104050131.629967-2-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 05:01:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: virtio: L2 check bypass in virtio_net_l3_start() via TUNSETLI=
NK
--

commit 546d87e0158fb3d32de1c338228f7d9a8f02bb4e
Author: Eric Dumazet <edumazet@kernel.org>

net: virtio: validate outer protocol of UDP tunnel GSO packets

This commit validates the outer L2/L3/L4 headers of UDP tunnel GSO packets =
in
virtio_net_hdr_tnl_to_skb() so that frames carrying mismatched outer protoc=
ols
or offsets are rejected before GSO segmentation.

Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2=
e2.1793276116.git.mst@redhat.com/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..b9c8babb1fd73 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
[ ... ]
> +/* Where does the L3 header start, and what protocol is it?
> + * Handles Ethernet and VLAN headers; other devices use the
> + * network header offset the caller set up.
> + */
> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	/* skb->dev should always be set here already,
> +	 * but let's not crash when it is not.
> +	 */
> +	if (WARN_ON_ONCE(!skb->dev))
> +		return false;
> +
> +	if (skb->dev->type =3D=3D ARPHRD_ETHER ||
> +	    skb->dev->type =3D=3D ARPHRD_LOOPBACK) {
> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto =3D eth_hdr(skb)->h_proto;
> +		/* skb->protocol is a sender claim, and parts of the
> +		 * stack parse the packet per it: when it disagrees with
> +		 * the frame we do not know which view the packet will
> +		 * be parsed as, so do not validate.
> +		 */
> +		if (skb->protocol && skb->protocol !=3D h_proto)
> +			return false;
> +		*nhoff =3D ETH_HLEN;
> +		*proto =3D h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto =3D __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		const struct iphdr *iph;
> +
> +		*nhoff =3D skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >=3D skb->len)
> +			return false;
> +		/* No L2 header to cross-check with: take the protocol
> +		 * from the IP version at the network header.
> +		 */
> +		if (!pskb_may_pull(skb, *nhoff + 1))
> +			return false;
> +		iph =3D (const struct iphdr *)(skb->data + *nhoff);
> +		if (iph->version =3D=3D 4)
> +			*proto =3D htons(ETH_P_IP);
> +		else if (iph->version =3D=3D 6)
> +			*proto =3D htons(ETH_P_IPV6);
> +		else
> +			return false;
> +		if (skb->protocol && skb->protocol !=3D *proto)
> +			return false;
> +	}
> +	return true;
> +}

[Severity: High]
Can a tap writer bypass the Ethernet header check in virtio_net_l3_start() =
by
changing tun->dev->type via the TUNSETLINK ioctl?

In drivers/net/tun.c, __tun_chr_ioctl() allows changing tun->dev->type while
the device is down without changing tun->flags:

drivers/net/tun.c:__tun_chr_ioctl() {
	case TUNSETLINK:
		...
		tun->dev->type =3D (int) arg;
		tun->dev->addr_len =3D tun_get_addr_len(tun->dev->type);
}

Meanwhile, tun_get_user() (and tun_xdp_one()) decides whether the frame sta=
rts
with an Ethernet header based on (tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TA=
P,
setting the network header to ETH_HLEN before calling
tun_vnet_hdr_tnl_to_skb(), and only populating skb->protocol via
eth_type_trans() afterwards:

drivers/net/tun.c:tun_get_user() {
	switch (tun->flags & TUN_TYPE_MASK) {
	...
	case IFF_TAP:
		...
		skb_set_network_header(skb, ETH_HLEN);
		break;
	}

	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
		...
	}

	if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
		skb->protocol =3D eth_type_trans(skb, tun->dev);
}

If an IFF_TAP device has tun->dev->type set to another type such as
ARPHRD_NONE via TUNSETLINK, virtio_net_l3_start() takes the else branch, re=
ads
*nhoff =3D skb_network_offset(skb) (which is ETH_HLEN), derives *proto from=
 the
IP version nibble at offset 14, and skips the skb->protocol check because
skb->protocol is still 0.

The Ethernet header at offset 0 is never inspected by virtio_net_l3_start(),
so eth_type_trans() will subsequently set skb->protocol from the unvalidated
eth_hdr(skb)->h_proto (for example ETH_P_NSH) on a packet with
SKB_GSO_UDP_TUNNEL set, triggering the same skb_under_panic() during GSO
segmentation.

Conversely, on an IFF_TUN device whose tun->dev->type is changed to
ARPHRD_ETHER via TUNSETLINK, virtio_net_l3_start() validates a 14-byte
Ethernet header at offset 0 and an outer IP header at offset 14, but
tun_get_user() does not call eth_type_trans() and resets skb->network_header
to offset 0, leaving the outer network header pointing at the fake Ethernet
header.

Should tun_get_user() and tun_xdp_one() set skb->protocol before calling
tun_vnet_hdr_tnl_to_skb(), or should virtio_net_l3_start() avoid relying on
skb->dev->type matching the caller's L2 framing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104050131.6299=
67-1-edumazet@kernel.org?part=3D1
