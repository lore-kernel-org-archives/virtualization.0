Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906269;
	b=yEYPacrK8u/XOcFePRqEs5Gy3j92lEpwz6kmf3oWEDMp5R299rOdmZn39PX1uoz/ZYNu
	 Oool04WEy6D3Sbhro4nEsRAM/ogUsieplMKav43f7ukZiYfALl53QAjqVP3TTwLg4CvOV
	 LMhu/dNwT/JDi8XTLzdDDK/eDzqy9OspW+HWR7YSBfQ1tWA19b2vx5eDCI4JhFZE+j0tL
	 uuaJnLFKYnrm4qHY+VU3Uch05jypkL9K+NIUY7k1UYXm62oHCxYMaHuKWzAt3moeELZuF
	 RkYoeucSGOjCvJNf6dlgsem3MiTpajycqwd20qxc3e8eGxhgTQIRYzqgkDudD/qUutw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906269;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YTAKiPjHb/nBDo+pPfj3THkCS5OujSZt/0Kav2/2Tn4=;
	b=y+8H8CZaMvIeI+Ci9jzTNJc0iPcRjXO2rl+4OFC4SW+zIWoY9PkTH+9LBAFOt74cNTBT
	 eKEEyFVEmgDJT4Haa0PmySNt0srlMxuXcLXSNDo7c0+eu/Oad18m0jpYD36TFTVxpQn3f
	 n8+Kl0J6TtlHsCn2PCrVp2XfYl2YwsatjHLxMDGT5JgTykloz5IIPCghZQqZfd+J7yNPS
	 iVRrcwGZ42h3OFwQkZT8ri3aTwc3RYbzdLG+9kJK7fICldYRVf07nFf1BC27Kg6sAU5/P
	 OyrboCj+lRW1lK4tgYqvKjq4SQNYQGotISLwcTwnUeMsk4Kt225W0O4mCzGxiq9K1Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VD1fJgiD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45943606A32C;
	Sun, 25 Oct 2026 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VD1fJgiD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22361F01829;
	Sun, 25 Oct 2026 05:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906268;
	bh=YTAKiPjHb/nBDo+pPfj3THkCS5OujSZt/0Kav2/2Tn4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VD1fJgiDa+wxB9P6d0pDvkl5xzVjZZ7lAhik3mAx4sYyjBP/iLTdr6UgW+/5mMDwK
	 +lyTbP6kq3lQrWLqjqCj1xMIDJ9qMHNQMoigiFS96gRIWQPVx3LsVZVPkliabGROIK
	 rm/ij3fsM616CGx8eIz5MBjbr2J8GXMacXPW2/6Jz6dswlminkcGOcWT3u1oci5mfG
	 1j3fezEIxpDQ9A8U2ejKVNWfAq+yrEapcZH6hiT2HhHbfpSnFtwuthtUNLDIRty+3u
	 cjcpdDASuffShCiO+Zz7GkMIlSvjbL0OaJ0sFiLp50Pv8mqhIREcGXqowwvv0kHQg7
	 SNHVUjTXqFZcw==
Subject: Re: [PATCH net v5 7/7] virtio_net: cleanup protocol calculation
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 carges@cloudflare.com, bjorn@kernel.org, phil@nwl.cc, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, maxk@qualcomm.com,
 rusty@rustcorp.com.au
Date: Sun, 25 Oct 2026 05:31:07 +0000
Message-ID: <179290626754.3134.7007257150281295117@kernel.org>
In-Reply-To:
 <f8621d16cf0c67335641d07c1555ec1e43f17628.1792668082.git.mst@redhat.com>
References:
 <f8621d16cf0c67335641d07c1555ec1e43f17628.1792668082.git.mst@redhat.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: use-after-free read of iph->ihl after pskb_may_pull() in
  ip4_parse()

--

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -638,7 +638,6 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
>  	 * set CHECKSUM_PARTIAL.
>  	 */
> -	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
>  	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
>  						 inner_proto))
>  		return 0;

[Severity: High]
This isn't introduced by this patch, but since inner_proto is what
steers virtio_net_csum_partial_ok_at_offset() into the IPv4 parser,
it's worth raising here.

virtio_net_csum_partial_ok_at_offset() calls virtio_net_l4_start(),
which for ETH_P_IP calls ip4_parse(). In ip4_parse() the fixed header
is pulled, iph is set to skb->data + nhoff, and then a second
pskb_may_pull(skb, nhoff + iph->ihl * sizeof(u32)) pulls in the
options. That second pull can go through __pskb_pull_tail() and
pskb_expand_head() when the options sit in paged frags, the skb is
cloned, or CONFIG_FAIL_SKB_REALLOC fires, and that frees the old
skb->head. The next line then computes *thoff from iph->ihl through
the stale pointer, before the header is reloaded from skb->data.

That is a use-after-free read that a guest, or a tun/tap/af_packet
user, can trigger with an IPv4 header whose options straddle the
linear area. If the freed buffer has been reused, we can also end up
with a bogus *thoff that is then checked against csum_start. Since
ip4_parse() is shared with ip_rcv_core(), br_validate_ipv4() and
nf_reject_iphdr_validate(), plain IPv4 ingress hits it too.

Reading ihl into a local before the second pskb_may_pull(), or
reloading iph from skb->data right after it, should be enough.
Do you want to fold a fix for ip4_parse() into this series, or send
it separately to net with a Fixes: tag for the commit that added
ip4_parse()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.v5.git.mst%40redhat.com
