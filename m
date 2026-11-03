Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708661;
	b=gbbSWk60ALSsNGbVed7ws6xEhnVhVra4WxVQjySC24fTroK79DwhEoqlH4/ogSbZJycB
	 wLj9QaQIr6dZ/7+rbnbeA/ggvNBN/HJK1w+VsabxXMU5booWeNCidiJQvXCXZJ/zoZy3a
	 hgbgpDcLWT5YvBx73WD5D6YJ2f5jblUrY7pCLzayizOl6YWLmCBQpKsG4xD8UgY5FxCaL
	 6qW6FJMG4LKfJTN4KE8dnVpsSvX0X+HzoiMIT0goUm07rBCqi/UAPQer8DS/ML1f5fvFJ
	 KSarEEgRplCw5lKVafNqkVXEI/MfLDCk4UtNIjmvbDKiugT+swg5lbHxpUSoFjtbsDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708661;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SWqdznL5RmpfEQau4NXHZxFj/6fjTDuANXgwfTFdtJ8=;
	b=IKyc2pFR6hMgnOTcH6I70ZFe1AcpFbF2+JgsDnbjXRPGz8xLuG7d7uxnebmZ91FULS5+
	 YUThG0cquVwk57et+4loB+yPObwiEUwXT3L59Ychsh5jwQVz9U295Kne3wv+70251s/qu
	 HwhiGSrCgpMy9I3mBuTc4h7kwRgtpV/bC9+gRXOl7yrwALL5lOrGy4suTPqH1OlJZz4jk
	 VRKE4eeWUt0IKLz3gsT73zIr+rcIPWk06UVIoPwOq2NcJxMSyQhz1+PjZM62bL1O8pYcY
	 IT/y63UnXQs+8O8fZusVMoq5/FdFUF9P5v0TKCnP6r7NLZuVkOVT5gSTL1XgzLQGEeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehIRfbLj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D23606A324;
	Tue,  3 Nov 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehIRfbLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2617E1F000C1;
	Tue,  3 Nov 2026 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793708661;
	bh=SWqdznL5RmpfEQau4NXHZxFj/6fjTDuANXgwfTFdtJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ehIRfbLj1Nql300Q1tCL16+1/HXm8mZQuWOPaTmfViNg6apYlZFhLbASpobozH10R
	 A6GcVgD5T/FW5/mAokdCyYMXWiHS+TIRR/hoMgnWYn7DC5+t5UDLc8cLjh9K7wM7xd
	 ZbPKwQ2I/ClhVvgZprysj0+/R6kTpLqeg4ofXa5zB7CbCqKbQzdjeiefF/ItEUFefP
	 9L42k8K9BQYVjRimBVgTfMsImCS96xQKN7KXCLrlnGk8DTJk8rfKA8/AynCI3PzhCO
	 EayU71QXJhlXc5SGKBCHR8PAErAXAQvjzb8mpc5in1y3YDi+vXJJypVl6j2Iv1lq7c
	 z1b8XOgPEJmHg==
Subject: Re: [PATCH net 2/2] net: validate xmit skbs in generic_xdp_tx()
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuniyu@google.com, wang.zhan@smartx.com,
 mkarsten@uwaterloo.ca, makita.toshiaki@lab.ntt.co.jp,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, willemdebruijn.kernel@gmail.com
Date: Tue, 03 Nov 2026 12:24:18 +0000
Message-ID: <179370865864.488856.15971001209426521133@kernel.org>
In-Reply-To: <20261030114753.185281-2-vladimir.oltean@nxp.com>
References: <20261030114753.185281-2-vladimir.oltean@nxp.com>
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

Critical: 0 · High: 1 · Medium: 0 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds a call to qdisc_pkt_len_segs_init() at the top
  of generic_xdp_tx() (net/core/dev.c:5863).

Pre-existing issues:
- [Medium] The commit message says qdisc_pkt_len_segs_init() must run
  before validate_xmit_skb().
- [Medium] The patch now runs generic XDP TX/REDIRECT skbs through
  validate_xmit_skb().

--

net: validate xmit skbs in generic_xdp_tx()

This commit makes generic_xdp_tx() call qdisc_pkt_len_segs_init() and
validate_xmit_skb_list() before handing the skb to the driver. As a result,
SKB_GSO_DODGY skbs get their gso_segs recomputed, and offloads the egress
device lacks are done in software. The resulting list is transmitted one
skb at a time under the TX lock, and any leftovers are freed with
kfree_skb_list().

> Generic XDP skips all of this. Instead of calling dev_queue_xmit() or
> dev_direct_xmit(), the XDP_TX and XDP_REDIRECT actions end up in
> generic_xdp_tx(), which calls netdev_start_xmit() directly.

[ ... ]

> - Call qdisc_pkt_len_segs_init() first. It recomputes gso_segs for
>   SKB_GSO_DODGY skbs and drops malformed ones. Without it,
>   validate_xmit_skb() would compare the untrusted gso_segs = 0 against
>   dev->gso_max_segs in gso_within_dev_limits(), and the check would
>   always pass.

[Severity: Medium]
This isn't a bug introduced by this patch, but does dev_direct_xmit() have
the same gso_max_segs problem described here?

__dev_direct_xmit() calls validate_xmit_skb_list() without calling
qdisc_pkt_len_segs_init() first:

net/core/dev.c:__dev_direct_xmit() {
    ...
	skb = validate_xmit_skb_list(skb, dev, &again);
	if (skb != orig_skb)
		goto drop;
    ...
}

AF_PACKET with PACKET_VNET_HDR builds SKB_GSO_DODGY skbs with gso_segs = 0
in packet_snd() and tpacket_snd(). setsockopt() doesn't prevent combining
PACKET_VNET_HDR with PACKET_QDISC_BYPASS, and with that option set,
packet_xmit() sends these skbs to dev_direct_xmit():

packet_snd()
  virtio_net_hdr_to_skb()        /* DODGY, gso_segs = 0 */
  packet_xmit()
    dev_direct_xmit()
      __dev_direct_xmit()
        validate_xmit_skb()
          gso_within_dev_limits()  /* 0 > gso_max_segs, passes */
          __skb_gso_segment()
            tcp_gso_segment()      /* sets gso_segs, returns NULL */
        netdev_start_xmit()

The skb isn't segmented, so the skb != orig_skb check does not drop it. It
reaches the driver with gso_segs above the limit the driver set with
netif_set_tso_max_segs(). Triggering this needs CAP_NET_RAW.

The commit message lists dev_direct_xmit() alongside dev_queue_xmit() as a
path that generic XDP skips, which suggests it is already validated. Is
that accurate? Should the commit message be reworded, or should
__dev_direct_xmit() get the same treatment?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 88860185f5832..e98d85a539916 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5855,23 +5855,44 @@ void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog,
>  		    u32 act)
>  {
>  	struct net_device *dev = skb->dev;
> +	enum skb_drop_reason reason;
>  	struct netdev_queue *txq;
> -	bool free_skb = true;
> +	bool again = false;
>  	int cpu, rc;
>  
> +	reason = qdisc_pkt_len_segs_init(skb);

[Severity: High]
Can this read far outside the skb if the XDP program pulled the head past
the transport header?

bpf_prog_run_generic_xdp() handles bpf_xdp_adjust_head() by moving the MAC
and network headers. It does not touch transport_header:

net/core/dev.c:bpf_prog_run_generic_xdp() {
    ...
	off = xdp->data - orig_data;
	if (off) {
		if (off > 0)
			__skb_pull(skb, off);
		else if (off < 0)
			__skb_push(skb, -off);

		skb->mac_header += off;
		skb_reset_network_header(skb);
	}
    ...
}

For a tun IFF_VNET_HDR GSO packet with VIRTIO_NET_HDR_F_NEEDS_CSUM,
__virtio_net_hdr_to_skb() sets transport_header from the user-supplied
csum_start through skb_partial_csum_set(). The only lower bound is
nh_min_len (20 bytes past the MAC header), and for TCPV4 the IP protocol
isn't checked.

Take csum_start = 34 (the outer UDP header of a VXLAN frame). A decap
program then strips 50 bytes and returns XDP_TX or XDP_REDIRECT. A devmap
egress program could do the same. In that case skb_transport_offset() is
-16 when this runs:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
		hdr_len = skb_transport_offset(skb);
    ...
		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
			return SKB_DROP_REASON_SKB_BAD_GSO;

		th = (const struct tcphdr *)(skb->data + hdr_len);
		tlen = __tcp_hdrlen(th);
    ...
}

hdr_len is an unsigned int, so it becomes 0xFFFFFFF0.
skb_transport_header_was_set() is true, so there is no early return.

The size_t sum 0x100000004 is truncated to 4 by the unsigned int len
parameter of pskb_may_pull(), so the check passes. On 64-bit, th then
points about 4 GiB past skb->data, and __tcp_hdrlen() reads th->doff
through it.

Before this patch, generic_xdp_tx() never read transport_header. The rest
of validation would be fine here, because inet_gso_segment() resets the
transport header.

The same helper is already reachable through XDP_PASS plus tc ingress in
sch_handle_ingress(). This patch puts it on the XDP_TX/XDP_REDIRECT path,
which needs no tc setup. As the commit message notes, an unprivileged
process can write the packet to a persistent TAP whose owner was set with
TUNSETOWNER.

Should generic_xdp_tx() reject or reset a negative skb_transport_offset()
before calling qdisc_pkt_len_segs_init()? Alternatively, should
qdisc_pkt_len_segs_init() handle that case itself?

[ ... ]

>  	txq = netdev_core_pick_tx(dev, skb, NULL);
> +	skb = validate_xmit_skb_list(skb, dev, &again);

[Severity: Medium]
This is a pre-existing issue, but can this call now hit the WARN_ONCE() in
skb_checksum_help() for CHECKSUM_PARTIAL skbs that the XDP program resized?

For tun skbs, csum_start and csum_offset come from user space through
virtio_net_hdr_to_skb()->skb_partial_csum_set(). They are only checked
against the layout before the XDP program runs.
bpf_prog_run_generic_xdp() changes skb->data and skb->len for
bpf_xdp_adjust_head() and bpf_xdp_adjust_tail(), but never rechecks the
CHECKSUM_PARTIAL state.

Take a non-GSO skb sent to a device without the matching checksum feature.
Examples are XDP_TX on a tun device where user space never enabled
TUN_F_CSUM with TUNSETOFFLOAD, or XDP_REDIRECT to a NIC without the
matching csum offload. The call chain is:

generic_xdp_tx()
  validate_xmit_skb_list()
    validate_xmit_skb()
      skb_csum_hwoffload_help()
        skb_checksum_help()

net/core/dev.c:skb_checksum_help() {
    ...
	offset = skb_checksum_start_offset(skb);
	ret = -EINVAL;
	if (unlikely(offset >= skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset (%d) >= skb_headlen() (%u)\n",
			  offset, skb_headlen(skb));
		goto out;
	}
    ...
	offset += skb->csum_offset;
	if (unlikely(offset + sizeof(__sum16) > skb_headlen(skb))) {
		DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
		WARN_ONCE(true, "offset+2 (%zu) > skb_headlen() (%u)\n",
    ...
}

If the program pulled the head past csum_start, offset is negative. It
compares as a large unsigned value against skb_headlen(), so the first
WARN_ONCE() fires. If the tail was shrunk below csum_start + csum_offset
+ 2, the second one fires.

The packet is dropped, and with panic_on_warn the kernel panics. The commit
message says validation fixes checksum offload by checksumming in software.
For packets the program modified this way, though, the WARN fires instead.

The stale checksum metadata comes from bpf_prog_run_generic_xdp() and
predates this patch. The same WARN can already be reached after XDP_PASS
when the skb is bridged or forwarded through dev_queue_xmit() to such a
device. This patch adds another way to reach it.

> +	if (!skb) {
> +		trace_xdp_exception(dev, xdp_prog, act);
> +		return;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030114753.185281-1-vladimir.oltean%40nxp.com
