Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906263;
	b=1DCR3eWJHPPiBgKogMj4A+kYJNQnttFIUAk3Nh0QEMcafiUtphQZAfsTjkJcyh/lNVzK
	 w09N6OJZ2FPXNHzpKAqyOQhGupBxsYRDyQb3CN1vyE6+fX/xODHMeQg8rFub06a0Lujsi
	 NPk4sX8D2Inn7pQjnSXbMebQuGchJvQNb8mQHOG2/NRzTPyFYBp75Etid+w91MSBabxEA
	 CEBwXvVWV5wUrQsQCSEMj9glF0ynkken1BskL0f/zT6HPbMOMT4ZhZgUsHjOCP3NyDmJr
	 0IhlpGdcJyXZEP/WQhgYxdjc4jfjMa8saTQaqG1wf9nmoMb9sNwix++MkGbYeu5Baxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906263;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=evp3RhZwPL7WcN3Ln8Vx2PJENKtYSS4z9lIGj4Rbwio=;
	b=Rk3lqNp8pQ5XpwWgTH9Ic2m+3Jn+yld+UHDhIuZVPdP8LsgRuGQRpqPifbSU13RcsLTc
	 AoXr5f5Q0sGtzIz/vHJclpwNNOyrLOHaeo+0Kjs/ugodeRTAoJcwsuRjcPSc5ppaFiwFx
	 sfQZqZfINaXuommF6dR9mBkcc/WdSFrxBEX3Gbz/ioCmwhGCjJo/WoykbRdx5bLHk8yH9
	 7QqlVGVhTOTrcwq9ud4QSYC35U896b/V6mnSeNvm6t1GCNtOGCAwiQUfvDOLldZKp62ph
	 eO6jfM0aC2YshdSJGSdmzhLLKcgB2/JD7rwYtm3cixZcp5XSuMmP+UKJ1EhsIcSTjRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYzRG6Wb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C042606A31F;
	Sun, 25 Oct 2026 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYzRG6Wb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43971F01828;
	Sun, 25 Oct 2026 05:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906262;
	bh=evp3RhZwPL7WcN3Ln8Vx2PJENKtYSS4z9lIGj4Rbwio=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fYzRG6WbDirCMf7U0+YQav+n36FYB3szMBj8LOXoHXviBpuW1nbhbZ8xp5WSjiurM
	 ch2gvspFttyirAgatJf6PWviRt93jZKPpOLAgBuZkAxKNh3NLfTOgj0VqrLLjn7nW1
	 eL230NbJM9CwWJwCncCyb+OzIb5AAuu4v+ZIvHX5ar44ZcGEyMT3jXYGesX0KHsipI
	 hH1mdU8oMvoS+VhjiGM3kXUQtGrpt96oB2WB5zkmRKV1+ZmhfuMk1+mU8MvVVZR0hU
	 LuO+MtgB0qx5op8D18w4BIPkzwGO1ZbRu1tp2UirCLiKKeGfo4Rwxf8eA5BXp4dCKO
	 ul/FMbnG+lXdw==
Subject:
 Re: [PATCH net v5 2/7] um: vector: trim skbs before verifying the header
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 carges@cloudflare.com, bjorn@kernel.org, phil@nwl.cc, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, maxk@qualcomm.com,
 rusty@rustcorp.com.au
Date: Sun, 25 Oct 2026 05:31:01 +0000
Message-ID: <179290626141.3134.1246964108369704124@kernel.org>
In-Reply-To:
 <1b2a0697662501fd4fe896a7dc2bba2d97885101.1792668082.git.mst@redhat.com>
References:
 <1b2a0697662501fd4fe896a7dc2bba2d97885101.1792668082.git.mst@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In vector_mmsg_rx() (arch/um/drivers/vector_kern.c),
  pskb_trim(skb, ...) now runs before verify_header(), and the skb is…
- [Low] The commit message presents the reorder only as groundwork for
  the later commit "net: resolve uncommon partial checksums at ingress".

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  touches these exact lines.
- [Medium] This problem wasn't introduced by this patch, but
  vector_legacy_rx() sets the receive header iovec to vp->header_size…
- [Low] This problem wasn't introduced by this patch, but
  vector_legacy_rx() leaks the skb that prep_skb() allocated when…

--

um: vector: trim skbs before verifying the header

This patch moves the pskb_trim() call in vector_legacy_rx() and
vector_mmsg_rx() so that it runs before verify_header(). It prepares for a
follow-up change, in which virtio_net_hdr_to_skb() will complete the
checksum in software and will need the skb trimmed to the received length.

> Trim first, so the import sees the packet as it was received.

[Severity: Low]
Should the commit message say that this reorder also changes current
validation behaviour, and not only prepare for the follow-up?

raw_verify_header() calls virtio_net_hdr_to_skb(). Today,
__virtio_net_hdr_to_skb() already checks lengths against skb->len and
skb_headlen() in several places:

  skb_partial_csum_set()
  pskb_may_pull(skb, p_off)
  the UDP_L4 bound against gso_size * UDP_MAX_SEGMENTS
  the skb->len - nh_off > gso_size test that decides whether gso_size
  and SKB_GSO_DODGY get set

Before this patch, those checks ran against the untrimmed prep_skb()
buffer (max_packet plus frags). A vnet header whose csum_start/csum_offset
pointed past the received data, but still inside the buffer, used to pass.
The later trim then left a CHECKSUM_PARTIAL skb whose checksum location
was beyond skb->len.

With the reorder, such headers are rejected and counted in
rx_encaps_errors. Could the changelog describe this? There is also no
Fixes: tag.

> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 8a70b3a625537..1afbef78df725 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -865,6 +865,7 @@ static int vector_legacy_rx(struct vector_private *vp)
>  
>  	if (skb != NULL) {

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. Does
vector_legacy_rx() leak the skb from prep_skb() when uml_vector_recvmsg()
fails?

Just above this hunk:

	pkt_len = uml_vector_recvmsg(vp->fds->rx_fd, &hdr, 0);
	if (pkt_len < 0) {
		vp->in_error = true;
		return pkt_len;
	}

uml_vector_recvmsg() returns -errno for any readv() failure other than
EAGAIN. This path then returns without calling dev_kfree_skb_irq(skb).
Nothing else holds a reference, so the skb and its frags are lost.

>  		if (pkt_len > vp->header_size) {
> +			pskb_trim(skb, pkt_len - vp->rx_header_size);
>  			if (vp->header_size > 0) {
>  				header_check = vp->verify_header(
>  					vp->header_rxbuffer, skb, vp);

[Severity: Medium]
This isn't a bug introduced by this patch, but is the header iovec in
vector_legacy_rx() the right size for IPv4 GRE and raw IPv4 L2TPv3?

Earlier in vector_legacy_rx():

	if (vp->header_size > 0) {
		iov[0].iov_base = vp->header_rxbuffer;
		iov[0].iov_len = vp->header_size;
	}

build_gre_transport_data() sets:

	vp->rx_header_size = vp->header_size;
	if (!td->ipv6)
		vp->rx_header_size += sizeof(struct iphdr);

build_l2tpv3_transport_data() does the same when
(!td->ipv6) && (!td->udp).

gre_verify_header() skips sizeof(struct iphdr) into header_rxbuffer
before it compares. With vec=0, readv() only puts header_size bytes (the
start of the IPv4 header) into header_rxbuffer. The verifier then reads
uninitialized kmalloc memory, so nearly all packets get dropped.

For any packet that does pass, the rest of the IP and encapsulation
header stays at the front of the skb. The trim by rx_header_size then
removes 20 bytes of real payload from the tail.

[ ... ]

> @@ -981,6 +981,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
>  	for (i = 0; i < packet_count; i++) {
>  		skb = (*skbuff_vector);
>  		if (mmsg_vector->msg_len > vp->header_size) {
> +			pskb_trim(skb,
> +				mmsg_vector->msg_len - vp->rx_header_size);

[Severity: High]
Can skb be NULL here?

If the GFP_ATOMIC alloc_skb_with_frags() in prep_skb() fails, the
skbuff_vector slot stays NULL, but the header iovec is still active:

	if (vp->header_size > 0)
		iov_index++;
	if (result == NULL) {
		iov[iov_index].iov_base = NULL;
		iov[iov_index].iov_len = 0;
		goto done;
	}
	...
done:
	msg->msg_iovlen = iov_index;

vector_net_open() sizes the rx queue header buffers with
vp->rx_header_size through create_queue(). For IPv4 GRE and non-UDP IPv4
L2TPv3, rx_header_size is header_size + sizeof(struct iphdr). A packet
that fills only the header iovec therefore gives
msg_len == rx_header_size > header_size.

That packet enters this branch and calls pskb_trim(NULL, 0), which
dereferences skb->len.

Before this patch, gre_verify_header() or l2tpv3_verify_header() ran
first. Neither touches the skb. A packet that failed them went to
dev_kfree_skb_irq(NULL), which returns early. Only packets with a valid
header reached the old pskb_trim() on a NULL skb.

Now a packet with the wrong GRE key or the wrong L2TPv3 session/cookie
can also hit the NULL dereference whenever an rx skb allocation has
failed. The GRE and L2TPv3 raw sockets are bound but not connected, so
any remote host can send such packets.

The else branch already checks skb != NULL. Is a similar check needed
before this pskb_trim()?

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
the patch touches these lines. Is this guard strict enough for the trim
length?

The guard checks msg_len > vp->header_size, but the trim subtracts
vp->rx_header_size. Two configurations have rx_header_size larger than
header_size:

  IPv4 GRE: header_size 4 and rx_header_size 24 without a key, or 8 and
  28 with a key
  raw IPv4 L2TPv3

In these cases, a msg_len between header_size and rx_header_size makes
the difference negative. pskb_trim() takes it as a very large unsigned
int:

	return (len < skb->len) ? __pskb_trim(skb, len) : 0;

and returns 0 without trimming. recvmmsg() only wrote into the header
iovec, so the skb keeps its full prep_skb() length of unwritten
alloc_skb_with_frags() memory. That memory goes through eth_type_trans()
and napi_gro_receive() into the guest stack.

gre_verify_header() and l2tpv3_verify_header() also read bytes past
msg_len in the per-slot header buffer. Those bytes can still hold an
earlier packet's header.

For example, a keyed GRE packet with msg_len 24 supplies only the 4 GRE
flag bytes. The key at offsets 24..27 is left over from the last valid
packet, so the key check passes without the sender knowing the key.

When msg_len == rx_header_size, the skb is trimmed to 0 bytes and
eth_type_trans() parses uninitialized head data.

vector_legacy_rx() has the same mismatch:

	if (pkt_len > vp->header_size) {
		pskb_trim(skb, pkt_len - vp->rx_header_size);

Should both paths require the received length to be larger than
rx_header_size (plus ETH_HLEN) before trimming?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.v5.git.mst%40redhat.com
