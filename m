Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513144CDDCA;
	Wed, 23 Sep 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168182; cv=none; b=SYAFZ/SuTA/dG74u/5RkNE90M16pAgy/mCxhS+IwpYmhbe/2IACegz0cWS+Xga2gyN/9xayY1MrU+r7LVjtWebchCciceEaYxc1ly8barhcFYoAkdsW1iEYqP2UYKLRYtNMBFrasFde7gIoZE1jEUinyGRq0iTCK5qFmnV+xU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168182; c=relaxed/simple;
	bh=treFHUc/YjLYlM9q5FDkKoie64i/yZQeYRwBjM9sFz0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tDe8TAtUiDjp3JP8lluEMlcyhkP2K+eBH6UCM1Za4+tAmU1WEAOV185hLf77cFkaywKWJy/1K6Qcl3WweK+iuFY5xVRh/AscxiBv0UGreET/f3BdiF73ZO1bd/WQq5yEK7zV0EIpxjZjnxwEl2NPvj/5UtnrtPccMhrp2l86fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLw/rutn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLw/rutn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2661F00899;
	Wed, 23 Sep 2026 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790168180;
	bh=QJ6DOuVBg7NHKkWgSpbKSuaNZziP6/c5aWGVHYAvCGM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hLw/rutn6K57hW+SRqMB7mq5r6ECmTWZpKBsd6zbL0XhVkJhDcSTvsw9fyWf+P4jC
	 1QYt4kPuxreWwzi36PqwwZbcbnPAGhpfZQGjVKI/+8Yalv33m7+9/p6dzPNdqit93l
	 1OyoiHBcx9LvJIRjaQ4RZr2N31pJfjda217DqATs4i/pnYdjejmLW5SKmxyYrzVuD+
	 TV5XoMcebai1ZAsLIgM9kwLMTujaxrLQlW6/Sk9W+2ypIRTC//FrlhVP+SrNuv1MMM
	 xmlMOC61C4CG6kTJdXKTuei0mkIUq8GusjNwQt0pCUEPMeaV46FZZ02SqQYFBlpsqu
	 KnPFmzzfEKAew==
Subject:
 Re: [PATCH v2 1/2] vsock/vmci: make the cached_peer dgram decision race-safe
From: netdev-bot+sashiko@kernel.org
To: bartlomiej.dmitruk@isec.pl
Cc: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, sgarzare@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 12:56:19 +0000
Message-ID: <179016817970.2160803.9851803268227445626@kernel.org>
In-Reply-To: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix's entire synchronization mechanism is a plain `u64`
  (`vsock_sock::cached_peer_access`) accessed with…
- [Low] Both lockless call sites of vmci_transport_allow_dgram() still
  carry the comment "NOTE: We access the socket struct without holding…

Pre-existing issues:
- [Medium] The per-socket decision cache is keyed only on the peer CID
  and is never invalidated: grep confirms vsock_sock::cached_peer_access…
- [Low] The patch keeps a VMCI-transport-only cache inside the generic
  struct vsock_sock and, in the core header…

--

vsock/vmci: make the cached_peer dgram decision race-safe

This replaces the two unsynchronized cache fields in struct vsock_sock
(cached_peer and cached_peer_allow_dgram) with a single u64
cached_peer_access that packs the peer CID together with a validity and an
allow bit.  vmci_transport_allow_dgram() now reads and publishes that word
with READ_ONCE()/WRITE_ONCE() so that the lockless receive tasklet and the
lock_sock() send path are said to be unable to observe a stale allow
decision.

The v1 posting is referenced from the changelog:
https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmitruk@isec.pl/

> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 5549298c1ec6..9d59b8fe2853 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -39,10 +39,13 @@ struct vsock_sock {
>  	 * modified outsided of socket create or destruct.
>  	 */
>  	bool trusted;
> -	bool cached_peer_allow_dgram;	/* Dgram communication allowed to
> -					 * cached peer?
> -					 */
> -	u32 cached_peer;  /* Context ID of last dgram destination check. */
> +	/* Cached dgram access decision for the last peer, packed as
> +	 * (cid << 32) | VALID | ALLOW and accessed via READ_ONCE()/
> +	 * WRITE_ONCE() so the lockless receive tasklet and the
> +	 * lock_sock() send path cannot race to a stale decision.
> +	 * See vmci_transport_allow_dgram().
> +	 */
> +	u64 cached_peer_access;

[Severity: Low]
This isn't a bug introduced by this patch (the cached_peer and
cached_peer_allow_dgram fields already lived here), but since the
representation is being rewritten anyway: could the cache move into the
VMCI transport's own state (vsk->trans, struct vmci_transport) instead?

grep shows cached_peer_access is read and written only from
net/vmw_vsock/vmci_transport.c, yet the core header now documents a
VMCI-specific bit packing convention and points at
vmci_transport_allow_dgram(), which the virtio, hyperv and loopback
transports never use.

>  	const struct cred *owner;
>  	/* Rest are SOCK_STREAM only. */
>  	long connect_timeout;
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 1f186e8f8364..31728e26a770 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -524,23 +524,38 @@ static bool vmci_transport_is_trusted(struct vsock_sock *vsock, u32 peer_cid)
>   * only if it is trusted as described in vmci_transport_is_trusted.
>   */
>  
> +/* Packing for vsk->cached_peer_access. */
> +#define VMCI_DGRAM_ACCESS_VALID		BIT_ULL(0)
> +#define VMCI_DGRAM_ACCESS_ALLOW		BIT_ULL(1)
> +#define VMCI_DGRAM_ACCESS_CID_SHIFT	32
> +
>  static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
>  {
> +	u64 access;
> +
>  	if (VMADDR_CID_HYPERVISOR == peer_cid)
>  		return true;
>  
> -	if (vsock->cached_peer != peer_cid) {
> -		vsock->cached_peer = peer_cid;
> -		if (!vmci_transport_is_trusted(vsock, peer_cid) &&
> -		    (vmci_context_get_priv_flags(peer_cid) &
> -		     VMCI_PRIVILEGE_FLAG_RESTRICTED)) {
> -			vsock->cached_peer_allow_dgram = false;
> -		} else {
> -			vsock->cached_peer_allow_dgram = true;
> -		}
> -	}
> -
> -	return vsock->cached_peer_allow_dgram;
> +	/* Cache the trusted/restricted decision for the last peer to avoid the
> +	 * O(N) vmci_ctx_get() lookup on every datagram.  Read/update it through
> +	 * a single word so a race between the lockless receive tasklet and the
> +	 * lock_sock() send path only forces a recompute -- it can never return a
> +	 * stale allow for a restricted peer.
> +	 */
> +	access = READ_ONCE(vsock->cached_peer_access);
> +	if ((access & VMCI_DGRAM_ACCESS_VALID) &&
> +	    (u32)(access >> VMCI_DGRAM_ACCESS_CID_SHIFT) == peer_cid)
> +		return !!(access & VMCI_DGRAM_ACCESS_ALLOW);

[Severity: High]
Does the "single word" property actually hold on 32-bit builds?  The CID
lives in bits 32-63 and VALID/ALLOW in bits 0-1, so the tag and the
decision are in two different 32-bit access units, and a plain u64
READ_ONCE()/WRITE_ONCE() is not single-copy atomic there.
include/asm-generic/rwonce.h is explicit about it:

/*
 * Yes, this permits 64-bit accesses on 32-bit architectures. These will
 * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
 * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
 * (e.g. a virtual address) and a strong prevailing wind.
 */

CONFIG_VMWARE_VMCI builds on 32-bit x86 as well:

drivers/misc/vmw_vmci/Kconfig:
	depends on (X86 || ARM64) && !CPU_BIG_ENDIAN && PCI

So with the cache holding (A << 32) | VALID | ALLOW, and
vmci_transport_dgram_enqueue() -> vmci_transport_allow_dgram() publishing
(B << 32) | VALID for a restricted peer B:

CPU0 (sendmsg, lock_sock held, i386: two 32-bit stores)
	store high word: CID = B
	<-- softirq / other CPU runs here
	store low word:  VALID (ALLOW cleared)

CPU1 (vmci_transport_recv_dgram_cb(), receive tasklet, no socket lock)
	access = READ_ONCE(vsock->cached_peer_access);
	  sees high word B, low word still VALID | ALLOW
	returns true for the restricted peer B

The reader side can tear the same way, since gcc on i386 loads the low word
first.  Since lock_sock() does not exclude softirqs, this also happens on a
single CPU.

Would an atomic64_t / cmpxchg64 based field, a seqcount, or an encoding
that fits in one native word (for example a separate validity/allow flag
plus a CID compared after the flags load, or a 30-bit CID plus two flag
bits in an unsigned long) close this for CONFIG_X86_32?

As written, the unconditional claims in the changelog ("pack the peer CID
and the decision into a single word accessed with READ_ONCE()/WRITE_ONCE().
A race then only forces a recompute and can never return a stale allow"),
in the new function comment, and in the new struct vsock_sock comment hold
only on 64-bit.  Could those be either fixed or scoped?

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, since the
old "if (vsock->cached_peer != peer_cid)" logic had the same lifetime
semantics, but the cache-hit path above is keyed on the peer CID alone and
is never invalidated.  Can it outlive the context it describes?

vmci_ctx_create() only avoids CIDs of contexts that are currently live:

drivers/misc/vmw_vmci/vmci_context.c:vmci_ctx_create() {
	while (vmci_ctx_exists(cid)) {
		/* We reserve the lowest 16 ids for fixed contexts. */
		cid = max(cid, VMCI_RESERVED_CID_LIMIT - 1) + 1;
	...
}

and IOCTL_VMCI_INIT_CONTEXT lets the caller pick both the CID and the
privilege flags:

drivers/misc/vmw_vmci/vmci_host.c:vmci_host_do_init_context() {
	vmci_host_dev->context = vmci_ctx_create(init_block.cid,
						 init_block.flags, 0,
	...
}

So an ALLOW cached for CID X can survive destruction of that context, and a
later context reusing CID X with VMCI_PRIVILEGE_FLAG_RESTRICTED (or a
different owning uid) keeps being allowed without vmci_context_get_priv_flags()
being consulted again.  The inverse direction exists too:
vmci_context_get_priv_flags() returns VMCI_NO_PRIVILEGE_FLAGS while
!vmci_host_code_active(), so an ALLOW cached in that window survives host
personality activation.

Would a generation counter bumped on VMCI context create/destroy, folded
into the cached word, address this?

> +
> +	access = VMCI_DGRAM_ACCESS_VALID |
> +		 ((u64)peer_cid << VMCI_DGRAM_ACCESS_CID_SHIFT);
> +	if (vmci_transport_is_trusted(vsock, peer_cid) ||
> +	    !(vmci_context_get_priv_flags(peer_cid) &
> +	      VMCI_PRIVILEGE_FLAG_RESTRICTED))
> +		access |= VMCI_DGRAM_ACCESS_ALLOW;
> +
> +	WRITE_ONCE(vsock->cached_peer_access, access);

[Severity: Low]
Should the two call-site comments be updated in the same patch?  Both
lockless callers still say the opposite of the new struct vsock_sock
comment:

net/vmw_vsock/vmci_transport.c:vmci_transport_recv_dgram_cb() {
	...
	 * NOTE: We access the socket struct without holding the lock here.
	 * This is ok because the field we are interested is never modified
	 * outside of the create and destruct socket functions.
	 */
	vsk = vsock_sk(sk);
	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
	...
}

The same text sits above the call in vmci_transport_recv_stream_cb(), and
both copies are still there at the end of the series (45f790ccc007).  The
helper now does WRITE_ONCE(vsock->cached_peer_access, access) from exactly
that tasklet context, and the changelog already calls the comment out ("The
in-code comment claiming the fields are never modified outside
create/destruct is contradicted by the send path") without touching it.

> +	return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
>  }
>  
>  static int

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919123208.29032-1-bartlomiej.dmitruk%40isec.pl
