Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13844C4E2;
	Wed, 23 Sep 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168183; cv=none; b=CXEfz09W/fLpP/Yqm8r+fK6bxPyQRLbg2pGvTaK+BH/0ICQsY6KlzuQjn79iwTKKvtpohZQCuYDx1MJZmarFw9/cd/obS9xtbvIuSdK+ong3o10cYdwUQUof0BZljT1+GrZhiFFVl8uNjGDMzFeoLyxiCiJXEHHFXCh3m1AShng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168183; c=relaxed/simple;
	bh=LzJEruODDUPU73rqcnJtFWsHFPjSXRP/LTH0UAEBWnI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKYmdymHrjiBcb00KaV8dOEJcnL4zotClVTTCyCLV/GNUuLpx6ehcXmP0ylP9Dk4gXlt4ZW6PzfJdiFsHZ+YMe2vJ0rBrbzBXfVWKDG1Bs7jeJUfQzNrvrCcERnPMjvdC/Tnh2nNiZmH3mVwJklTK2wU1ZSWWBQhEqRNS1UhaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvQiQUsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvQiQUsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870B21F000FF;
	Wed, 23 Sep 2026 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790168182;
	bh=3uUhtAR2k0hPaE4q7IxQRMBAokmtgKcz0lOtbcN/3eA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SvQiQUsfVQZRXUO5/FwsLtxY+h0jo4b/6HpYlE6vmJ2SvkTIpI8X949Jn1bEH/yYV
	 orCrR2RIXPB6OqNfTWt7nC58HzbuL4jNGxb3+Gm+zS0fw9ULufsMP2z0t8UQhm+KWJ
	 vxbLhHKTuol4SaYIsB0C9B9P4UQ+zG085/0k+aJ9jeMU2CrcFjWG5ZOFn0PaV1+5Js
	 aJOMIgr83zIt1CEtPDdiJRFhsZXYwO0OzZaWFYny5avLUmutE4MbpH7W6g/I5tK2V3
	 UClqdPdIcbSpo5BzEgjsTdygqYqOvGSTjX+3AusKObMSEXhFQi/fTdgmKwCdtFPwch
	 QSjlEvxEDEriw==
Subject: Re: [PATCH v2 2/2] vsock/vmci: enforce per-netns mode on the datagram
 receive path
From: netdev-bot+sashiko@kernel.org
To: bartlomiej.dmitruk@isec.pl
Cc: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, sgarzare@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mst@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 12:56:21 +0000
Message-ID: <179016818112.2160803.16758605437197754903@kernel.org>
In-Reply-To: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
References: <20260919123208.29032-2-bartlomiej.dmitruk@isec.pl>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Torn 64-bit lockless access to `vsock->cached_peer_access` on
  32-bit builds defeats the access-control invariant the series claims…

Pre-existing issues:
- [Low] Stale justification comments in both lockless callers of
  `vmci_transport_allow_dgram()`.

--

vsock/vmci: enforce per-netns mode on the datagram receive path

This adds a vsock_net_mode_global() check at the top of
vmci_transport_allow_dgram() so the receive path refuses datagrams when the
socket's netns is not in global mode, matching the send hook
vmci_transport_dgram_allow().  The check is placed before the
VMADDR_CID_HYPERVISOR short-circuit so hypervisor datagrams are gated too.

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 31728e26a770..d6791459e2fd 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -533,6 +533,14 @@ static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
>  {
>  	u64 access;
>  
> +	/* Enforce the per-netns mode first, symmetrically with the send hook
> +	 * vmci_transport_dgram_allow(): a socket in a non-global (local) netns
> +	 * must not receive datagrams it could never send (this also covers the
> +	 * hypervisor CID).
> +	 */
> +	if (!vsock_net_mode_global(vsock))
> +		return false;
> +
>  	if (VMADDR_CID_HYPERVISOR == peer_cid)
>  		return true;
>  

[Severity: High]
While looking at the rest of vmci_transport_allow_dgram(), can the packed
cached_peer_access word tear on 32-bit builds?

The helper reads and writes the decision as one u64:

net/vmw_vsock/vmci_transport.c:vmci_transport_allow_dgram() {
	access = READ_ONCE(vsock->cached_peer_access);
	if ((access & VMCI_DGRAM_ACCESS_VALID) &&
	    (u32)(access >> VMCI_DGRAM_ACCESS_CID_SHIFT) == peer_cid)
		return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
	...
	WRITE_ONCE(vsock->cached_peer_access, access);
	return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
}

and the comment above it, plus the field comment in include/net/af_vsock.h,
state that using a single word means the race between the receive tasklet
and the send path "can never return a stale allow for a restricted peer".

include/asm-generic/rwonce.h says the opposite for a 64-bit access on a
32-bit architecture:

 * Yes, this permits 64-bit accesses on 32-bit architectures. These will
 * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
 * rely on the access being split into 2x32-bit accesses ... and a strong
 * prevailing wind.

drivers/misc/vmw_vmci/Kconfig allows this on 32-bit x86:

	depends on (X86 || ARM64) && !CPU_BIG_ENDIAN && PCI

The reader runs with no socket lock held, from
vmci_transport_recv_dgram_cb() and vmci_transport_recv_stream_cb(), while
the writer can run concurrently from vmci_transport_dgram_enqueue() under
lock_sock(), which does not exclude bottom halves.

So on i386, with the cache holding {cid=B, VALID, ALLOW clear} for a
RESTRICTED peer B, can this happen?

CPU0 (sendmsg, trusted peer A) in vmci_transport_allow_dgram()
	WRITE_ONCE(vsock->cached_peer_access, access);
	  -> low word stored first: VALID|ALLOW
	  -> high word still holds B

CPU1 (receive tasklet, datagram from restricted peer B)
	access = READ_ONCE(vsock->cached_peer_access);
	  -> low = VALID|ALLOW, high = B
	(u32)(access >> VMCI_DGRAM_ACCESS_CID_SHIFT) == peer_cid  /* matches */
	return !!(access & VMCI_DGRAM_ACCESS_ALLOW);              /* true */

That would accept a datagram from a VMCI_PRIVILEGE_FLAG_RESTRICTED context
on a non-trusted socket, and the mirrored tear (new high word, old low word)
would drop legitimate datagrams.

Would an atomic64_t accessed with atomic64_read()/atomic64_set(), a
seqcount, or plain serialization be needed here instead of u64
READ_ONCE()/WRITE_ONCE()?

[Severity: Low]
This isn't an issue introduced by this patch, but since
vmci_transport_allow_dgram() is being touched: both lockless callers still
carry a justification that no longer matches the helper.

vmci_transport_recv_dgram_cb() and vmci_transport_recv_stream_cb() both say:

	 * NOTE: We access the socket struct without holding the lock here.
	 * This is ok because the field we are interested is never modified
	 * outside of the create and destruct socket functions.
	 */
	vsk = vsock_sk(sk);
	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
		return VMCI_ERROR_NO_ACCESS;

but the helper writes socket state on the ordinary receive and send paths:

	WRITE_ONCE(vsock->cached_peer_access, access);

and the field comment in include/net/af_vsock.h documents that both the
receive tasklet and the lock_sock() send path update it.

Could the NOTE be reworded to name the fields that really are immutable
(trusted, owner) and mention that cached_peer_access has its own
READ_ONCE()/WRITE_ONCE() protocol?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919123208.29032-1-bartlomiej.dmitruk%40isec.pl
