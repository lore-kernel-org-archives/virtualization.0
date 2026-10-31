Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793447290;
	b=kK7IcMCozst10NTxyuC3nZrsyr09xPgNCEIlAxUCFICyCxX16izkh5BShHzaczTbwETm
	 /0KNrKPn+FbmM6PZGh3ygi76KY0EoBTeRAtPKup3fzUOJpfoXLzR3w2cRCnuqrcGaVD5U
	 HMZBkEq/HQJ5H4sqfdnVqnfIoL81ezRaYHAGc+twxJlsqw7phGOx9ZStrTnITv2Xq+3Qu
	 uE/yaLmgkLcKhuACh5q3bMHvE+Qbl03vAGyZhiZ+xShHVvA7AUlYSCb4JcPAyao615RGd
	 sQ/H/wyiTTTCMqLGE/0KHof4s5mSy0V9XVAYIGSkCSZvb9x/zUfNS+vejmOtOnne7cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793447290;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ldqEr8TtLI/GExHL7cGaoYjrri+XYnnzYmCRIWXQu4w=;
	b=V855Xh+wspyN9nmNQklOYTyCCpUTkJTHiTIr/gg8UL+89EUNGctqo+QnYFfz3ZGU3Rqg
	 0M294HLQ3Zv3wcI9my37mcVhfVxSnwJE1ojPOYJEccSO/WG56vLwJWl0HIP3I0qPnKvmq
	 fpQDC2oGWmlWwArXCEwgpvWRWPa+Q8NxumubURJL/0VHFKCF9jbe1v3vXAcyf3GPpc3Oe
	 CpABBy+20RWjXZ2Wg4np6qyWm08naRkMScwcw0ss4PJsBz+CcMay1M5d3T/2lV2Bt5VW2
	 TWu/8ggAdDcJ8BA3sWkulaqCw8xK/HxREy0zXsicmXqZBOXHsBgfwxG/bv+SFcp1X2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQThr56S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BB606A31C;
	Sat, 31 Oct 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQThr56S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630E11F00919;
	Sat, 31 Oct 2026 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793447289;
	bh=ldqEr8TtLI/GExHL7cGaoYjrri+XYnnzYmCRIWXQu4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQThr56SrhzlPItb7AbmY0y5rN1hFdsfqedzQgZo5VRaMD7mWtcWnKXN/e6KuNgn/
	 9Q26g0pQDLkCvkUBprVh3Et1gzIE87yQqZnWht27mVPoyv2ydAkVetOwFfinoLwO71
	 tIBdEAM6328AVMnUqMYMQukxK8P3pWiPUyLGmJ+6gEFTEhgapX3dCJ2FO2ru8SfWYv
	 rwdinauf3inzsbsB5cr3a1NOK+kd0A9x1V5IBL7Ht8BaJSnapzSYdQH1+6++VQJlb/
	 y0b56fKLq+nNJzp50RtMXxtxk83nGoERBfa889Vcq3YVuSpNyp99fiGb+iNlZtKXxT
	 pEWxkO21gnUzQ==
Message-ID: <sashiko-outbox-191926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] net: validate xmit skbs in generic_xdp_tx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: bpf@vger.kernel.org, virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030114753.185281-2-vladimir.oltean@nxp.com>
References: <20261030114753.185281-1-vladimir.oltean@nxp.com>
 <20261030114753.185281-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 11:48:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: out-of-bounds read in qdisc_pkt_len_segs_init() via generic_x=
dp_tx()
- [High] net: shared skb->head corruption on cloned broadcast skbs in gener=
ic_xdp_tx()
- [Medium] net: WARN_ONCE in skb_checksum_help() from generic_xdp_tx() afte=
r XDP resize
--

commit 47b74c796cb5f05688236335aeb274a972cf3b13
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

net: validate xmit skbs in generic_xdp_tx()

This commit validates skbs in generic_xdp_tx() using
qdisc_pkt_len_segs_init() and validate_xmit_skb_list() before passing them =
to
netdev_start_xmit(). This ensures SKB_GSO_DODGY packets have gso_segs
recomputed and unsupported offloads handled in software.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 88860185f5832..e98d85a539916 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5855,23 +5855,44 @@ void generic_xdp_tx(struct sk_buff *skb, const st=
ruct bpf_prog *xdp_prog,
>  		    u32 act)
>  {
>  	struct net_device *dev =3D skb->dev;
> +	enum skb_drop_reason reason;
>  	struct netdev_queue *txq;
> -	bool free_skb =3D true;
> +	bool again =3D false;
>  	int cpu, rc;
> =20
> +	reason =3D qdisc_pkt_len_segs_init(skb);
> +	if (unlikely(reason)) {
> +		trace_xdp_exception(dev, xdp_prog, act);
> +		dev_core_stats_tx_dropped_inc(dev);
> +		kfree_skb_reason(skb, reason);
> +		return;
> +	}

[Severity: High]
Can calling qdisc_pkt_len_segs_init() here cause an out-of-bounds read when=
 a
generic XDP program adjusts the packet head on a GSO packet?

In bpf_prog_run_generic_xdp(), when bpf_xdp_adjust_head() shifts xdp->data =
by
a non-zero offset, skb->data, skb->mac_header, and skb->network_header are
updated, but skb->transport_header (and skb->inner_transport_header) is left
at its pre-adjustment offset:

net/core/dev.c:bpf_prog_run_generic_xdp() {
	...
	off =3D xdp->data - orig_data;
	if (off) {
		if (off > 0)
			__skb_pull(skb, off);
		else if (off < 0)
			__skb_push(skb, -off);

		skb->mac_header +=3D off;
		skb_reset_network_header(skb);
	}
	...
}

When the XDP program returns XDP_TX or XDP_REDIRECT, generic_xdp_tx() calls
qdisc_pkt_len_segs_init(skb), which assigns the signed int return value of
skb_transport_offset(skb) (or skb_inner_transport_offset(skb)) to unsigned
int hdr_len:

net/core/dev.c:qdisc_pkt_len_segs_init() {
	...
	if (!skb->encapsulation) {
		if (unlikely(!skb_transport_header_was_set(skb)))
			return SKB_NOT_DROPPED_YET;
		hdr_len =3D skb_transport_offset(skb);
	} else {
		hdr_len =3D skb_inner_transport_offset(skb);
	}
	/* + transport layer */
	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
		const struct tcphdr *th;

		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
			return SKB_DROP_REASON_SKB_BAD_GSO;

		th =3D (const struct tcphdr *)(skb->data + hdr_len);
		tlen =3D __tcp_hdrlen(th);
	...
}

If bpf_xdp_adjust_head() pulled skb->data 1 to 20 bytes past the original
skb_transport_header(skb) on a TCP GSO packet (or 1 to 8 bytes on a
SKB_GSO_UDP_L4 packet), skb_transport_offset(skb) is in [-20, -1] and hdr_l=
en
becomes 0xffffffecU..0xffffffffU. In pskb_may_pull(skb, hdr_len +
sizeof(struct tcphdr)), the 32-bit unsigned addition wraps to 0..19 and
succeeds if skb_headlen(skb) is at least that small wrapped length. Then
skb->data + hdr_len zero-extends hdr_len to 64 bits on 64-bit platforms and
__tcp_hdrlen(th) reads approximately 4 GiB past skb->data.

Even when skb_transport_offset(skb) remains non-negative after
bpf_xdp_adjust_head(), qdisc_pkt_len_segs_init() computes hdr_len and
shinfo->gso_segs from the stale transport_header offset, whereas
validate_xmit_skb_list() -> __skb_gso_segment() -> inet_gso_segment() /
ipv6_gso_segment() later resets skb->transport_header and tcp_gso_segment()
recomputes skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->len, mss) without
re-checking dev->gso_max_segs.

> +
>  	txq =3D netdev_core_pick_tx(dev, skb, NULL);
> +	skb =3D validate_xmit_skb_list(skb, dev, &again);
> +	if (!skb) {
> +		trace_xdp_exception(dev, xdp_prog, act);
> +		return;
> +	}

[Severity: High]
Could passing skb to validate_xmit_skb_list() corrupt shared skb->head memo=
ry
when a generic XDP program redirects with BPF_F_BROADCAST through a DEVMAP =
or
DEVMAP_HASH?

During broadcast redirects, dev_map_redirect_multi() calls
dev_map_redirect_clone() for each destination except the last, which clones
the packet with skb_clone(skb, GFP_ATOMIC). In dev_map_generic_redirect(),
skb_copy() is only called when dst->xdp_prog is attached:

kernel/bpf/devmap.c:dev_map_generic_redirect() {
	...
	if (dst->xdp_prog && skb_cloned(skb)) {
		struct sk_buff *nskb;

		nskb =3D skb_copy(skb, GFP_ATOMIC);
	...
}

When dst->xdp_prog is NULL, the cloned skb reaches generic_xdp_tx() ->
validate_xmit_skb_list() -> validate_xmit_skb() -> __skb_gso_segment(). In
__skb_gso_segment(), skb_cow_head(skb, 0) is only called when
skb_needs_check(skb, true) is true, so it is skipped whenever ip_summed is
CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY:

net/core/gso.c:__skb_gso_segment() {
	...
	if (unlikely(skb_needs_check(skb, tx_path))) {
		int err;

		/* We're going to init ->check field in TCP or UDP header */
		err =3D skb_cow_head(skb, 0);
		if (err < 0)
			return ERR_PTR(err);
	}
	...
}

If the packet is an IPv6 UFO skb with ip_summed =3D=3D CHECKSUM_PARTIAL,
udp6_ufo_fragment() skips gso_pskb_expand_head() because generic XDP ensures
at least XDP_PACKET_HEADROOM (256 bytes) of headroom, which is larger than
tnl_hlen + sizeof(struct frag_hdr). It then modifies uh->check and *prevhdr
and shifts the MAC and IPv6 headers 8 bytes left in place via memmove() ins=
ide
the shared skb->head buffer:

net/ipv6/udp_offload.c:udp6_ufo_fragment() {
		if (skb->mac_header < (tnl_hlen + frag_hdr_sz)) {
			if (gso_pskb_expand_head(skb, tnl_hlen + frag_hdr_sz))
				goto out;
		}
		...
		packet_start =3D (u8 *) skb->head + SKB_GSO_CB(skb)->mac_offset;
		memmove(packet_start-frag_hdr_sz, packet_start, unfrag_len);
}

Similarly, udp4_ufo_fragment(), tcp4_gso_segment(), and tcp6_gso_segment()
overwrite the L4 checksum field in place when ip_summed =3D=3D
CHECKSUM_UNNECESSARY. When dev_map_redirect_multi() continues to the remain=
ing
broadcast destinations using the original skb, its mac_header and
network_header still reference the pre-shift offsets in the mutated skb->he=
ad
buffer.

[Severity: Medium]
Can calling validate_xmit_skb_list() here also trigger WARN_ONCE() in
skb_checksum_help() when a generic XDP program shrinks or pulls a
CHECKSUM_PARTIAL packet?

In bpf_prog_run_generic_xdp(), adjusting the packet via bpf_xdp_adjust_head=
()
or bpf_xdp_adjust_tail() updates skb->data, skb->tail, and skb->len without
updating or resetting skb->ip_summed, csum_start, or csum_offset. If a
non-GSO packet with ip_summed =3D=3D CHECKSUM_PARTIAL has its head pulled p=
ast
csum_start or its tail shrunk below csum_start + csum_offset +
sizeof(__sum16), and generic_xdp_tx() transmits it on a device without
checksum offload (such as XDP_TX on a tun device without TUN_F_CSUM),
validate_xmit_skb() -> skb_csum_hwoffload_help() -> skb_checksum_help() hit=
s:

net/core/dev.c:skb_checksum_help() {
	...
	offset =3D skb_checksum_start_offset(skb);
	ret =3D -EINVAL;
	if (unlikely(offset >=3D skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset (%d) >=3D skb_headlen() (%u)\n",
			  offset, skb_headlen(skb));
		goto out;
	}
	csum =3D skb_checksum(skb, offset, skb->len - offset, 0);

	offset +=3D skb->csum_offset;
	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",
			  offset + sizeof(__sum16), skb_headlen(skb));
		goto out;
	}
	...
}

Since offset is unsigned int, a negative skb_checksum_start_offset(skb) wra=
ps
to a large unsigned value, and either out-of-bounds offset triggers skb_dum=
p()
and WARN_ONCE().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030114753.1852=
81-1-vladimir.oltean@nxp.com?part=3D2
