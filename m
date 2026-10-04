Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7891E47CC;
	Sun,  4 Oct 2026 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791089866; cv=none; b=BCXp5EBAPPJ/y90gE1PAiC94zl1NM05hkOaVJzycSdhdHXF6TwgrO9JxsGpC/uWwAAXkJLq81CnYwNaDPxeFixOT24YwIK/Pa+oSPiFqPc6GgX7uubuOha8h93sSqsamzBpD0x1Bh3OgTPCuPqGliDOtrRvXYJir8HJ3PnQrfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791089866; c=relaxed/simple;
	bh=Q+Uo68P+lhj5UfkFd8WODPbN3xmadHKb2kEfoFD3NLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zomg+kWIkrtYhkiSNR/AGFQGOHtlXVdKWbY3l2vm2eoJbcS2FlG7OJ9wxVKxELXJ/eZA5J5lV1VTvVCpQeVkAT1nRoixG8dhs3o65oDxae114ILc/uG17r7hbNZlKM+24lh7QpgAcqn6p0h8d7fwfVnNBjEPn4ht6htAl/TUYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxXuqca2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxXuqca2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197091F000FF;
	Sun,  4 Oct 2026 04:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791089864;
	bh=jqPp+qIXD1dd5/GTvZtypfi8cpUovFkg6nolTGVJjHQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dxXuqca2Noggs731vdDCyUmzRxEohjC+Oy8JVf8YmaryyxmA81lv1AsQtXEW5iJnX
	 kthZdzFi4H0Zy2CvrusLuaMNnLc1jYYzMRKeawl+FWT/4FdecaQVvll74EiTAkRqTx
	 X//ajnRnM+45SzgwxWxcqZPxidF5hsf8CRwiArLUN+PdJ6VaT0apgORUVU6y2s6p+d
	 iiGR5G+1YCq5zlKJINkqFr0nfolXLLoUBTIEhctmyIs7al8SgM395v9EKoNmTObiUG
	 OSw1miiuHI0rWG1W/lV/GuNacj/DuRPihEhQdyEUd+2fma512Rvn2SbrNfpCQG3sVn
	 ngLGpnRbPERGQ==
Subject:
 Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload length
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sun, 04 Oct 2026 04:57:43 +0000
Message-ID: <179108986364.434549.5339286904514687491@kernel.org>
In-Reply-To: <20260930044147.3818241-1-4ncienth@gmail.com>
References: <20260930044147.3818241-1-4ncienth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] On 32-bit hosts, the check `payload_len + sizeof(*hdr) > len`
  in vhost_vsock_alloc_skb() (drivers/vhost/vsock.c:404) can wrap, and…

--

vhost/vsock: trim nonlinear SKBs to declared payload length

This commit changes virtio_vsock_skb_put() so that a nonlinear skb is
trimmed with pskb_trim() to the payload length declared in hdr->len.
Previously only skb->len was adjusted. The zero-payload early return in
vhost_vsock_alloc_skb() now comes after the helper call, so zero-length
packets are trimmed as well.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index abed1fbcf66cc..fa59456abda97 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -400,10 +400,6 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>  
>  	payload_len = le32_to_cpu(hdr->len);
>  
> -	/* No payload */
> -	if (!payload_len)
> -		return skb;
> -
>  	/* The pkt is too big or the length in the header is invalid */
>  	if (payload_len + sizeof(*hdr) > len) {

[Severity: Medium]
Can this check wrap on 32-bit hosts? payload_len is a size_t that comes
from the guest-controlled hdr->len. A value from 0xFFFFFFD4 to 0xFFFFFFFF
makes payload_len + sizeof(*hdr) wrap to 0..43. Since len is at least
VIRTIO_VSOCK_SKB_HEADROOM, the check always passes.

Before this patch, the nonlinear branch set skb->len to that huge value.
skb_copy_datagram_from_iter() then skipped every fragment and returned
-EFAULT without a warning.

With the new virtio_vsock_skb_put(), skb->len is set to skb->data_len.
pskb_trim(skb, huge) then does nothing, because len < skb->len is false.
The skb reaches this call with headlen 0 and a negative int length (for
example -32):

vhost_vsock_alloc_skb()
    skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)

In the frag loop of skb_copy_datagram_from_iter(), this evaluates
0 > -32 and fires:

    WARN_ON(start > offset + len);

copy_page_from_iter() is then called with bytes = (size_t)-32, which
trips the check in page_copy_sane():

    if (WARN_ON(n > v || v > page_size(head)))

Neither warning is a once-only warning. A guest that posts TX descriptors
larger than about 32.5 KiB with such hdr->len values would get two host
WARN splats per packet. With panic_on_warn set, it would panic the host.

The guest-side virtio_transport_rx_work() already uses an overflow-safe
form of this check. Would it make sense to use it here as well?

    if (unlikely(payload_len > len - sizeof(*hdr))) {

[ ... ]

> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index f91704731057e..31358683e23e3 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -51,10 +51,13 @@ static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
>  {
>  	DEBUG_NET_WARN_ON_ONCE(skb->len);
>  
> -	if (skb_is_nonlinear(skb))
> -		skb->len = len;
> -	else
> +	if (skb_is_nonlinear(skb)) {
> +		skb->len = skb->data_len;
> +		if (WARN_ON_ONCE(pskb_trim(skb, len)))
> +			return;
> +	} else {
>  		skb_put(skb, len);
> +	}
>  }

[Severity: High]
Does this fully fix the retention described in the commit message?
vhost_vsock_alloc_skb() still sizes the skb from iov_length(), not from
hdr->len:

    skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);

The trim here only frees memory when the whole payload fits in the head
tailroom. Two cases seem to remain open.

The first case is the linear path. virtio_vsock_alloc_skb() gives any
descriptor up to about 32448 bytes a linear head of the full descriptor
size:

    if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
            return virtio_vsock_alloc_linear_skb(size, mask);

The else branch above still just calls skb_put(skb, len). A zero or small
payload therefore keeps the whole ~32 KiB head.

The second case is the nonlinear path with a payload larger than the head
tailroom. That is a few hundred bytes; the 960-byte truesize in the commit
message suggests about 340. ___pskb_trim() shortens frag[0] and unrefs
only the frags after it:

    skb_frag_size_set(&skb_shinfo(skb)->frags[i++], len - offset);

    drop_pages:
    skb_shinfo(skb)->nr_frags = i;

    for (; i < nfrags; i++)
            skb_frag_unref(skb, i);

The order-3 page behind frag[0] stays pinned. skb_condense() then returns
early, so truesize is not recomputed:

    if (skb->data_len > skb->end - skb->tail ||
        skb_cloned(skb) || !skb_frags_readable(skb))
            return;

virtio_transport_inc_rx_pkt() charges only hdr->len plus this per-skb
overhead:

    u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);

For a 256 KiB buf_alloc, that admits about 455 skbs.

The merge and collapse paths don't seem to reclaim these skbs either:

- virtio_transport_can_collapse() refuses any skb with
  VIRTIO_VSOCK_SEQ_EOM set, and the guest controls hdr->flags.
- The GOOD_COPY_LEN merge in virtio_transport_recv_enqueue() skips
  nonlinear skbs, payloads over 128 bytes, and any skb after an EOM skb.
- Collapse only runs once queue_len reaches queue_max.

So one socket could still pin roughly 455 x ~33 KiB, about 15 MB.
Meanwhile buf_used stays at zero (linear, zero payload, EOM) or about
155 KB (nonlinear, 341-byte payloads). A guest can repeat this across
connections.

The commit message says:

  "Set skb->len to the fragment length before calling pskb_trim(), then
  trim to the declared payload length.  This releases unused fragments
  and lets skb_condense() reduce truesize."

Is that accurate for nonlinear skbs whose payload is larger than the head
tailroom?

Would it work better to read and validate hdr->len first and then allocate
payload_len + VIRTIO_VSOCK_SKB_HEADROOM? Copying into a right-sized skb,
or charging the memory actually retained, are other options.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930044147.3818241-1-4ncienth%40gmail.com
