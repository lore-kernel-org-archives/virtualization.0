Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA0472F63
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154533; cv=none; b=kuA1EAXX5eIUP0eKM8Itix5qMxCu1XTivlOwTKiszJUxt1BnyOe1akqK75z5UhDgxtvv+Jx4ObsczhN5CghuZOna9SrdRwDPkNR/Y9vabdYGOl3Eo+iTCzQSxXi3vwe9Rz986TxvfaSd6FtXrtU6OPjsWSDymwzedZAtA2g0BBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154533; c=relaxed/simple;
	bh=79GO295/gGSPHs6Vz4Xbq2uKT4tA6X7fiK8IJfBQ2Bs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JFqF8Hc1jTb0iH2/UfkEtvznSMf6FHkRH1ubKiUBYEzxCwZTESkEa46Vc5F02htEomcB4zDo9ZjKK1nQqP+tY3csZBjtIGIZfozkwKSE9k12BgEoLowBDYWOvDcScPS+mih1aZ0VhEZQLLTXBg0j2c2cGVvvJga+rlOeRgA5M+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq8PpMA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq8PpMA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECC31F000C6;
	Fri, 16 Oct 2026 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154532;
	bh=3uEvMDyNUhy9HFE4Cjtgh/fRhstAuPkw/mtJadBGgeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eq8PpMA6CygnWpyh4SOYYcHAcLUp2RnmhLAwoByheNtO1q4jZ4OhaWKGQDXyQ2ON+
	 Bh2i9z2WyHizCferAKl0TR1yDD4tXv4mldHHJ+FP+ntgkYQJxXWS0QYja90+fZEhjT
	 +kjFqdFWNoh7AuoRkPb7yoHT9fG6JLMQUKppJwEqNqEvkPFXl0ThQAg894VO87XkyJ
	 Pa9ZMS9Y9MRlv59F+k6s7BZXaMLp7HYuGqEE4WUC5EDDmr1AKIMeMhTcyKrSKZSHHi
	 l3g1sJeReOzxOfS5uNgr5/4Wz0LiOcsiLeYer2q52JlNErfxJp+w5M+jRizWiUXpxz
	 TQt22esjPBzaQ==
Message-ID: <sashiko-outbox-174318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 3/7] um: vector: trim skbs before verifying
 the header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <d9ac3420f95c5953227d80c71ebc3cd7e3c5fd9c.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <d9ac3420f95c5953227d80c71ebc3cd7e3c5fd9c.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:42:11 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: vector: integer underflow in pskb_trim leads to info leak
- [High] um: vector: OOB read and packet corruption in vector_legacy_rx
--

commit 7f2cd5c3a1fb41cfaea6c03500daa85a7433a386
Author: Michael S. Tsirkin <mst@redhat.com>

um: vector: trim skbs before verifying the header

This commit modifies the vector receive path to trim the SKB before verifyi=
ng
the transport header. This is done to prepare for computing the packet
checksum in software, which requires the packet to be trimmed correctly.

> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 8a70b3a625537..1afbef78df725 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -865,6 +865,7 @@ static int vector_legacy_rx(struct vector_private *vp)
> =20
>  	if (skb !=3D NULL) {
>  		if (pkt_len > vp->header_size) {
> +			pskb_trim(skb, pkt_len - vp->rx_header_size);

[Severity: High]
Can this subtraction underflow if pkt_len is smaller than vp->rx_header_siz=
e?

For GRE and L2TPv3 over IPv4, vp->rx_header_size (e.g., 24) is strictly
greater than vp->header_size (e.g., 4). If a packet is received with a
length between these two values (e.g., 20 bytes), the check
pkt_len > vp->header_size passes, but pkt_len - vp->rx_header_size
underflows to a very large unsigned value.

Because the length would exceed the pre-allocated skb->len, pskb_trim() fai=
ls
silently. The SKB retains its maximum allocated size containing uninitializ=
ed
memory.

If vp->verify_header() randomly succeeds on the undersized IOV buffer,
could this leak uninitialized kernel memory up the network stack via
napi_gro_receive()?

[Severity: High]
Does this sequence cause an out-of-bounds read and inner packet corruption?

Earlier in vector_legacy_rx(), iov[0].iov_len is restricted to
vp->header_size:

	if (vp->header_size > 0) {
		iov[0].iov_base =3D vp->header_rxbuffer;
		iov[0].iov_len =3D vp->header_size;
	}

For raw IPv4 GRE/L2TPv3 tunnels where vp->header_size (4) differs from
vp->rx_header_size (24), recvmsg() reads only the first 4 bytes of the IP
header into vp->header_rxbuffer. The remaining IP header, GRE header, and
inner packet spill into iov[1] (skb->data).

When gre_verify_header() runs, it advances its pointer by
sizeof(struct iphdr) and reads uninitialized memory from the 4-byte
header_rxbuffer to verify the header.

Additionally, because the headers spilled into the SKB, does trimming by
the full vp->rx_header_size here incorrectly truncate the payload from
the tail instead of the head, silently destroying the inner packet
before it reaches eth_type_trans()?

[ ... ]

> @@ -981,6 +981,8 @@ static int vector_mmsg_rx(struct vector_private *vp, =
int budget)
>  	for (i =3D 0; i < packet_count; i++) {
>  		skb =3D (*skbuff_vector);
>  		if (mmsg_vector->msg_len > vp->header_size) {
> +			pskb_trim(skb,
> +				mmsg_vector->msg_len - vp->rx_header_size);

[Severity: High]
Like the vector_legacy_rx() path, does this subtraction also underflow if
msg_len is between vp->header_size and vp->rx_header_size?

>  			if (vp->header_size > 0) {
>  				header_check =3D vp->verify_header(
>  					mmsg_vector->msg_hdr.msg_iov->iov_base,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792067836.gi=
t.mst@redhat.com?part=3D3
