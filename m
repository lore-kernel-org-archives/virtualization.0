Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906262;
	b=cI31XP9sxKnuGiQfBJLQ/tMLHRbB6X5H0izF2LLp2KbMvg1PNOgv5D/BYM4eFOApFvPZ
	 uS8ZlLdm7zF+n/WgroRhnr/dnCNEoKXmr5gMrYJqJ6USVZlXXUlsuGb1Rn6iwl9tTETFX
	 GWTNl6Xry+I3PK9ca/5V4lCLL1ho2JWrjLJ3TMzgFUJ0hvckqqeMNXkVc5+rG0S23Vl2p
	 3dcCb3VDPF0T7PdPxyyfpN/nfT3S+EQdil89hu2qBaYAgdbQUb3NJ65iIKC5fuKGT0xur
	 OEbvZNNL5fR3zHp4Tbz/Y7Y1zQjKmngSokazZLWn4q+jF+CUQOsOvrdWu+ILlCQE5rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906262;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZzKajPNZhJBaeiX7KrF0L4LRhebWXvs6tMtkK6E+pA4=;
	b=zCV8CX4B+mV3BeHNwdhYfMdMueUTh5EV92hBL4xSWjaH6WOfE3yisoSLI5ykNku42tkk
	 83sRmWD/7Mf0umpUM3ek4zl5vUm8w1nmaAIJhic9deimTlZKqk25boZYOGWKFA5LTrObr
	 wp6hyASZICxkUJgTcSUx6RK+raWJ5frM7gUfVy2Hy2KvRbf7rHb9/c7eVUBARMICG9Y0t
	 HbFIlw7xfssUktI5MOznDQbXIu2flNxoLjsE+ACZfaaKz3h+eXHR2mdND3Wj1+cJJKpS8
	 hLXGOLZYYOUg+t2sAzINBnlRtFbzEQR6a8U+3yvYcze2dRpR7LJ+kR5lyiVbupALwbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIQDBQGY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EA606A31A;
	Sun, 25 Oct 2026 05:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIQDBQGY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584C41F01825;
	Sun, 25 Oct 2026 05:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906261;
	bh=ZzKajPNZhJBaeiX7KrF0L4LRhebWXvs6tMtkK6E+pA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XIQDBQGYo0HizMSKxpCpMD164TC/u5LTwuqveTngIR6NYP8e2MI8LnG/XMqXFTSeI
	 waYdtcOz2Qy2KpLbYJZG2dQl/3HRqD4+xe03eeV1Jdv8VU5nw38rmkmzdCQlGuo1+g
	 tI4ZUNYIEtF2QUyqgP+VP9x08/Kt6HgFEeG3klxNDSvYt0GMqMHMmpdKzQw4LL96+B
	 Bl1FRSsrqLVA585hNWKi1q6TCg+gHKvMnjxJfpdCCerx3K2pZJwAKqrLvn686uWXEF
	 vmZSOz2Bky5GVtozBZiitNz9ZbmLX8rn5gWfFfEe6K9UC9bUFpsX1E0WCbhUcJpxOT
	 Mi1XAXXXCUa/g==
Subject:
 Re: [PATCH net v5 1/7] net: account for ingress-resolved virtio net hdr state
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 carges@cloudflare.com, bjorn@kernel.org, phil@nwl.cc, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, maxk@qualcomm.com,
 rusty@rustcorp.com.au
Date: Sun, 25 Oct 2026 05:30:59 +0000
Message-ID: <179290625983.3134.1093878831391467849@kernel.org>
In-Reply-To:
 <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
References:
 <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The concern: the newly checked virtio_net_hdr_to_skb() call in
  raw_verify_header() (arch/um/drivers/vector_transports.c:213) runs on…
- [Low] This patch quietly includes a real behaviour fix for the UML
  vector raw transport.
- [Low] The concern: at this commit, virtio_net_hdr_to_skb(),
  __virtio_net_hdr_to_skb() and virtio_net_hdr_tnl_to_skb() in…

--

net: account for ingress-resolved virtio net hdr state

This commit changes callers of virtio_net_hdr_to_skb() and
virtio_net_hdr_tnl_to_skb() to treat only negative return values as errors.
It prepares for a later patch that returns a positive value when the
checksum is completed in software. It also makes the UML vector raw
transport check the return value, and adds a tun ethtool -S counter,
rx_csum_sw, for the positive case.

> diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vector_transports.c
> index e1fb2a76fdff5..8b75484586635 100644
> --- a/arch/um/drivers/vector_transports.c
> +++ b/arch/um/drivers/vector_transports.c
> @@ -210,7 +210,9 @@ static int raw_verify_header(
>  		return 1;
>  
>  	skb_set_network_header(skb, ETH_HLEN);
> -	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
> +	if (virtio_net_hdr_to_skb(skb, vheader,
> +			virtio_legacy_is_little_endian()) < 0)
> +		return -1;
>  	return 0;
>  }

[Severity: Medium]
Can this drop valid frames at this point in the series? The skb passed in
here has not been trimmed to the received length yet. prep_skb() sizes it
to the whole receive buffer:

arch/um/drivers/vector_kern.c:prep_skb() {
    ...
	skb_put(result, vp->max_packet);
	result->data_len = len - vp->max_packet;
	result->len += len - vp->max_packet;
    ...
}

Both vector_legacy_rx() and vector_mmsg_rx() call verify_header() before
pskb_trim():

arch/um/drivers/vector_kern.c:vector_legacy_rx() {
    ...
				header_check = vp->verify_header(
					vp->header_rxbuffer, skb, vp);
				if (header_check < 0) {
    ...
			pskb_trim(skb, pkt_len - vp->rx_header_size);
    ...
}

That means the length checks in __virtio_net_hdr_to_skb() compare against
the buffer size (65536 with GSO), not the packet length. Take the USO check:

	if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
		return -EINVAL;

With a 64K buffer, this rejects a valid USO frame whose gso_size is below
about 511. Before this patch the error was ignored. Now raw_verify_header()
returns -1, and the caller frees the skb and increments rx_encaps_errors.

The same ordering also lets csum_start/csum_offset values that point past
the real packet, but still inside the buffer, pass validation.

The next patch in the series, "um: vector: trim skbs before verifying the
header", moves pskb_trim() ahead of verify_header() in both RX paths. That
fixes this, so only intermediate bisect points are affected. Could the trim
come before this change, or be folded into it?

[Severity: Low]
This hunk looks like a real behaviour fix for the UML raw transport, not
accounting preparation. The commit message says:

    The um vector raw transport even ignored the return value
    altogether: rejected packets went on into the stack with their
    metadata unvalidated, so check it there as well.

The return value has been ignored since commit 49da7e64f33e ("High
Performance UML Vector Network Driver").

For example, __virtio_net_hdr_to_skb() can call skb_partial_csum_set(),
which sets CHECKSUM_PARTIAL along with csum_start/csum_offset, and then
return -EINVAL from a later check. The old code still delivered that skb.

Should this be a separate UML patch, ordered together with the trim fix
from "um: vector: trim skbs before verifying the header", and carrying:

Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")

Right now the fix sits in a patch whose subject reads as accounting-only
and which also adds a new tun ethtool string. That makes it hard to pick
up cleanly for stable.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 7cca1a6f72ff4..133923317eae8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -1939,10 +1940,14 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		break;
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> +	if (err < 0) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
> +	} else if (err > 0) {
> +		atomic64_inc(&tun->rx_csum_sw);
> +		err = 0;
>  	}

[Severity: Low]
Can err be positive here at this commit? At this revision,
virtio_net_hdr_to_skb(), __virtio_net_hdr_to_skb() and
virtio_net_hdr_tnl_to_skb() in include/linux/virtio_net.h appear to return
only 0 or -EINVAL.

If so, this branch and the matching ret > 0 branch in tun_xdp_one() can't
be reached. The new rx_csum_sw value reported by tun_get_ethtool_stats()
would always read 0.

The later patch "net: resolve uncommon partial checksums at ingress"
documents the tri-state return and adds
__virtio_net_resolve_csum_partial_mismatch(), which returns
skb_checksum_help(skb) ?: 1. That makes these branches live at the end of
the series, so this only affects intermediate bisect points.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.v5.git.mst%40redhat.com
