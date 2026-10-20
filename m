Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497843;
	b=up1D4xkfHmOzio6woukDIRic+eHMMm1QsumpmeY7BU9pdhZ/VEklgyNbxSEdV3N786/b
	 tzcPtz8Fqmn19IYk7ZBE7Swk80eugcO4H+otO693cAq2aBzE/QY9o7YbKTNNBarUxgedS
	 pWOmlUpVKHL/f+UwUQCwyMpUUcVa3eRSEaWei3PM1nwJU0oMxDxuov17dtfMtB9Wp0eZN
	 UeXxa9kG5DFBbdihhNlAKIfhndERMi677bNI8FD0MWP9pFwFFue4qco4Ao6vVCmyZ2niR
	 ej2sRiye21Zx8Dsroeg6ILxvjqIB75vk1uTzfzp3IwrGqIyDTpr7cPt9srsCqYpTuuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497843;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tVqQ+3VmFAPWCbkD0PpPPonKTGx9Npjk+l/oZ24qEYk=;
	b=tWhH9017q37gJWXoD1NI8z7wZst3Y909kZbxOCAnWhMpQ3Qujxomv9teQ6WtKZBM9klz
	 2riLzj/yun7RY46BzuGVYlgpHk+oyBxMKpL3hJ4ESw3yEwxMl6aaqz+y5NNzcbTVBFd3O
	 dj5w2T4SJk0S+iHFXWdLI6P6YKiSddjhjWlGjoJREdSjsTJc9oJt5O54r/Kw5bEd7uv0e
	 LOetTJONwbk0LwvCGjfcnKAuslwXBihycYaXWR/zHLSl1yRlHvlKcaRjfBmyVhyB6R7j7
	 3cywBhjUYvJK55pdo5WS6kmJoYRmyK68v58ByU6yoBP9msWDcWAOlOsgz6+g6XfRlfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTmH5Sw8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F09606A31D
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTmH5Sw8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F291F000C6;
	Tue, 20 Oct 2026 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497843;
	bh=tVqQ+3VmFAPWCbkD0PpPPonKTGx9Npjk+l/oZ24qEYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTmH5Sw8VDEsb+FU1D4j6V7aMtzvSi5LX/dzxvpzLDnaP5rSnQzRF1M03HJI7eRHq
	 MOJOH/bNZhuzHrjsYQgFdaw84qFXP3gHU8uRPFCUOK2GWvix8qRC6WQbOmxOXIO2y2
	 DCUrvs8aovALm8JLnyihnszhCcrOBcmSBrZBkvFZn0MArDu1LZkft0dhSlbLH3gDER
	 YSUT73HisXtIpbgaa7k1Ut9HTiD4gW7HxGi3C/Y7RdbJGZv0nH25MbkEFs4HJDbplc
	 wzsuRJC1Ua1WY8mRIVcLOHbV/0ekHGFiiCgmOBF4NmJ9i3CCSpuONrSAsDzzGWTftr
	 wNgbhNa7HkDug==
Message-ID: <sashiko-outbox-178922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:04:02 +0000
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
- [Medium] net: virtio_net_csum_partial_ok() fails to bypass virtio_net_l3_=
start()
--

commit 559fb10ce506a1c7276bf12adfdeed16a12a4f0c
Author: Michael S. Tsirkin <mst@redhat.com>

net: add a sysctl to opt out of virtio net hdr checksum validation

This commit adds a per-netns sysctl net.core.virtio_net_hdr_csum_check
guarded by a static key to allow opting out of ingress virtio_net_hdr
checksum metadata validation.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 97b554ef7123f..25aa95c11e31a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -179,6 +193,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff =
*skb, u8 hdr_gso_type,
>  	unsigned int thoff;
>  	int ip_proto;
> =20
> +	/* Failsafe: a namespace opted out of the validation,
> +	 * trust the checksum metadata as before.
> +	 */
> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;
> +
>  	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
>  		return false;
> =20
> @@ -516,6 +536,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool o=
uter_isv6,
>  	unsigned int thoff;
>  	int ip_proto;
> =20
> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;
> +
>  	if (!virtio_net_l3_start(skb, &nhoff, &proto))
>  		return false;
>  	if (outer_isv6 !=3D (proto =3D=3D htons(ETH_P_IPV6)))

[Severity: Medium]
In virtio_net_tnl_offsets_ok(), virtio_net_hdr_csum_check_disabled(skb) is
checked before calling virtio_net_l3_start(). However, in the non-tunnel
path, virtio_net_hdr_to_skb() calls virtio_net_csum_partial_ok(), which
calls virtio_net_l3_start() before reaching the check in
virtio_net_csum_partial_ok_at_offset():

include/linux/virtio_net.h:virtio_net_csum_partial_ok() {
	int nhoff;
	__be16 proto;

	if (!virtio_net_l3_start(skb, &nhoff, &proto))
		return false;

	return virtio_net_csum_partial_ok_at_offset(skb, hdr_gso_type, nhoff,
						   proto);
}

When net.core.virtio_net_hdr_csum_check is set to 0 and a packet with
VIRTIO_NET_HDR_F_NEEDS_CSUM enters virtio_net_hdr_to_skb(),
virtio_net_l3_start() still runs pskb_may_pull() and __vlan_get_protocol()
to compute nhoff and proto, which virtio_net_csum_partial_ok_at_offset()
then immediately discards.

Furthermore, if virtio_net_l3_start() returns false (for example, when
__vlan_get_protocol() returns 0 on VLAN tags exceeding VLAN_MAX_DEPTH, or
on a non-ARPHRD_ETHER device where skb_network_offset(skb) is unset or out
of bounds), virtio_net_csum_partial_ok() returns false without consulting
virtio_net_hdr_csum_check_disabled(skb). virtio_net_hdr_to_skb() then falls
through to virtio_net_resolve_csum_partial_mismatch(), dropping GSO packets
or completing non-GSO checksums in software despite the sysctl opt-out.

Should virtio_net_csum_partial_ok() check
virtio_net_hdr_csum_check_disabled(skb) before calling
virtio_net_l3_start()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D6
