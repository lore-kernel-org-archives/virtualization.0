Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BF37E2EB;
	Mon,  5 Oct 2026 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185772; cv=none; b=XKwHEVh59U8Lt8Jit+tKy3DzrONx/4e9+5ynVppwLOD8fY3FDFwIUjcb+WT5vsvZnbdHTxOluAvvtYkCx9oxdXnEAwpB8/Yt/nlrv83TwfAehAIIE0ytolhRpQedaCCoR4yDSA7yNteOVK2y5z7NGrFzepZ9cIWRAsWFzMIzTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185772; c=relaxed/simple;
	bh=lWFA/lphBDfFlKdg5ZeH8Da13s7WF/Y+TGpl0iNPuM4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuFtAKhQhQUsOryug/9aK5I9xTc9Arin6CCCz4evO7JuDevu+6IvLUCajg6Xy1Nj3MZXdFxVwSBPHc7u/6840fvUzkfdo5fHkBY+iQajInajEXjH23+Gs/1t7ZIUBAGHGHidzYFjxfWcOHwHaWKkJpExB+8QLiiWk3AngceL1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frTp5m5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frTp5m5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F37D1F00893;
	Mon,  5 Oct 2026 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791185770;
	bh=wlE1MxfAOeA6OUdgmn9IID89AexVN0AIyazCIkBDGrY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=frTp5m5FFMiIehoN9KO4h/49gjrqMsWBVS16+FSM4hQstV1Qfe9V9OTxGS6aSTsnL
	 jVDYI7x9YQE+CEdXEd+EomI6cnaTWjxFJCBz6LVI8kWWFC/vPWSmp+8ayq5XxLRz5r
	 jveLNMX9g262A2+fcHTN0en0+dvFIyYEfYJwvsGrE1CdGh6QbB9QNx6hnjGKiIB7TY
	 oc4rl5dfWMHTMM2VZfwtnTzZZ/arMLWSxXsuQS79qkzldjuavox8lUdPwfcvCknLLZ
	 M1lLFoSRFHa6Zbb8+eNpB4BDYVNG3DK3UYsQXh2cEJAsBgqi9oLGmagg53AFj0UiY6
	 Kz18bZCDMnxdg==
Subject:
 Re: [PATCH net v2] vhost/vsock: size receive SKBs from declared payload
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 will@kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Mon, 05 Oct 2026 07:36:09 +0000
Message-ID: <179118576977.434549.3015022133910830215@kernel.org>
In-Reply-To: <20261004073419.4039011-1-4ncienth@gmail.com>
References: <20261004073419.4039011-1-4ncienth@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag names the wrong commit.
- [Low] The commit message presents the new `payload_len > len -
  sizeof(hdr)` check in vhost_vsock_alloc_skb() (drivers/vhost/vsock.c)…

--

vhost/vsock: size receive SKBs from declared payload

This patch changes vhost_vsock_alloc_skb() to copy the virtio_vsock_hdr
into a stack object and validate hdr.len before allocating. The skb is
then sized from the declared payload plus the header, not from the total
guest descriptor length. A guest can then no longer pin descriptor-sized
allocations by sending zero or short payloads.

> Use payload_len > len - sizeof(hdr) for validation.  This avoids addition
> overflow on 32-bit hosts and ensures payload_len fits the subsequent
> int-length copy path.

[Severity: Low]
Should this paragraph say that the old check already overflowed on
32-bit hosts? This patch removes the following check from
vhost_vsock_alloc_skb():

	if (payload_len + sizeof(*hdr) > len) {

That check came from 10a886aaed29 ("vhost/vsock: Avoid allocating
arbitrarily-sized SKBs"), which is Cc: stable. That commit dropped the
earlier payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE short-circuit and
kept only the addition.

VHOST_VSOCK has no 64BIT dependency, so size_t can be 32 bits. If the
guest sets hdr.len anywhere in [0xFFFFFFD4, 0xFFFFFFFF], then
payload_len + 44 wraps to a value in [0, 43]. That is below len, so the
bad length passes the check.

In mainline this seems harmless. virtio_vsock_skb_put() sets skb->len to
about 4 GiB. skb_copy_datagram_from_iter() then gets a negative int
length, copies nothing and returns -EFAULT, and the skb is freed.

Trees that have 10a886aaed29 but not ab9aa2f3afc2 still copy the payload
with:

	copy_from_iter(skb->data, payload_len, &iov_iter)

Wouldn't check_copy_size() hit WARN_ON_ONCE(bytes > INT_MAX) there? On
32-bit hosts that would be a WARN the guest can trigger, and a host
panic with panic_on_warn.

This patch fixes that as a side effect. Would it be worth saying so in
the changelog and adding a Fixes: tag for 10a886aaed29?

> Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")

[Severity: Medium]
Is this the right commit for the Fixes: tag? vhost_vsock_alloc_skb()
sizes the skb from the descriptor length:

	len = iov_length(vq->iov, out);
	...
	/* len contains both payload and hdr */
	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);

This sizing seems to date from 71dc9ec9ac7d ("virtio/vsock: replace
virtio_vsock_pkt with sk_buff"). Before that commit,
vhost_vsock_alloc_pkt() sized the buffer from the header:

	pkt->buf = kvmalloc(pkt->len, GFP_KERNEL);

Here pkt->len came from hdr.len, which is the behaviour this patch
restores.

ab9aa2f3afc2 only switched the call from virtio_vsock_alloc_linear_skb(len)
to virtio_vsock_alloc_skb(len) so that large sizes could be nonlinear. It
did not change how the size is chosen.

ab9aa2f3afc2 isn't tagged for stable. Trees with 71dc9ec9ac7d and
10a886aaed29 but not ab9aa2f3afc2 would still have the problem in its
linear form. That probably includes 6.6.y and 6.12.y.

In those trees, a 64 KiB descriptor with a short payload allocates and
keeps a kmalloc head of about 128 KiB. Payloads above GOOD_COPY_LEN (128
bytes) skip the coalescing path in virtio_transport_recv_enqueue(). The
whole head stays queued, but only the payload bytes count against
buf_alloc. The changelog itself says "Linear skbs retain their full head",
which covers this case.

10a886aaed29 already uses Fixes: 71dc9ec9ac7d for the descriptor-sized
allocation. Should this patch use the same tag, so the stable trees pick
it up?

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004073419.4039011-1-4ncienth%40gmail.com
