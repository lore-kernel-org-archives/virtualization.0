Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626C47D442;
	Mon, 21 Sep 2026 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033435; cv=none; b=IxMCibVcfNvUjvNEaXdc8O2UTl4QG58GF9IpWYeMMcsy7E+/Xr1k3BowNXTQckjkIHAWFlAd4llUyOeOluGSY2jxFO1sMuN/papAa+pQ2UDy/dkmsEZaJUBP2S6whV8YDbelVfgPlOowkfXHBPHE/kVy03pWgJg1GBikFbjXS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033435; c=relaxed/simple;
	bh=b7p82YLJXnLVxHzjv3zA2aepK0Y2viauWgsFonjsNew=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rpgk+mrOgsNJxu+n8ix1icuS/lzH6DWG6SUObJpTCYq+kdbKWMBFdXc5NZns/iShaPYjxg41+uIqv6/aFT2ZWnJ7CuFt5NcGZdIgx4S2IigGzt3m+V/G39uMLAy6PQOfDjYsNKqEx5lJ9WWoyzEg1rf0djPvwaJb59/u7Wv+z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D69MFRyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D69MFRyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6CF1F000FF;
	Mon, 21 Sep 2026 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033424;
	bh=ssEn1ac94OxG61fDvH9GJy/OHnTvjSDi25gSmKvZCRQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D69MFRydMY/5uAZ4QGGgBVuTdiKiTrq9z87yi/TxyWjKzEBozdOEWRY3grNm5wOGe
	 yw7SlJx77854Qh0Xj7fEtjRNSiHUDmvKNzcv3ShAdD6VzTozgG13MdlDqZeLu2uG5j
	 EUtxygrul/YVuk8PIfh4jRbxAHXZhIU5MJbWtA4r25WuebopPCtJ7DE+0aE6KVxkhn
	 DU6buRQB5IfFyW3o3/r5akENTeE6ib3y8oeDFVvaca1Rit6qXF8UCAoMat9P5ro5LF
	 JWpqAesBjpdToraWOutqQZOvq9+Q6J/9drETv0f4lQc8XD69hIpmkYka68JbSr0Wim
	 xl9pHu80hbCNw==
Subject: Re: [PATCH] vsock/vmci: harden datagram receive access check (netns
 bypass + cached_peer race)
From: netdev-bot+sashiko@kernel.org
To: bartlomiej.dmitruk@isec.pl
Cc: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com,
 pv-drivers.linux@broadcom.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, sgarzare@redhat.com, mst@redhat.com,
 kuba@kernel.org
Date: Mon, 21 Sep 2026 23:30:23 +0000
Message-ID: <179003342317.2160803.2680774487036888926@kernel.org>
In-Reply-To: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new per-netns gate in vmci_transport_allow_dgram()
  (net/vmw_vsock/vmci_transport.c:536) is placed after the unconditional…
- [High] net/vsock: severe receive fast-path performance regression
- [Medium] Missing `Fixes:` and `Cc: stable@vger.kernel.org` trailers for
  two distinct, user-visible defects.
- [Low] After this patch, include/net/af_vsock.h:42-45 still defines and
  documents `bool cached_peer_allow_dgram; /* Dgram communication…

--

vsock/vmci: harden datagram receive access check (netns bypass + cached_peer race)

This adds a per-netns mode check to vmci_transport_allow_dgram() on the
datagram receive path and removes the cached_peer/cached_peer_allow_dgram
caching so the access decision is recomputed for every datagram.  A few
questions below about the placement of the new check, the commit trailers,
and the now unused struct members.

On the commit message:

> Add the symmetric net-mode check and drop the cache, evaluating the decision
> on every datagram; there is no shared mutable state left to race. The now
> unused cached_peer{,_allow_dgram} members can be removed in a follow-up.
>
> Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>

[Severity: Medium]
Should this carry Fixes: tags, and Cc: stable for the namespace half?

The receive-path netns gap only exists from the commit that introduced
vsock_net_mode_global() — git blame of include/net/af_vsock.h points at
eafb64f40ca4 ("vsock: add netns to vsock core"):

  static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
  {
          return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
  }

The cached_peer check-then-set predates that and goes back to the original
VMCI transport.

A sibling netns fix already in this tree, 2ec28c09b320 ("vsock: ignore empty
child namespace mode writes"), carries Fixes: eafb64f40ca4 plus
Cc: stable@vger.kernel.org.  Without equivalent trailers here, how are
backporters expected to know which trees still have the bypass?

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 1f186e8f83640..37b6f6eca962b 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -529,18 +529,25 @@ static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
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
> +	/* Enforce the per-netns mode on the receive path, symmetrically with
> +	 * the send hook vmci_transport_dgram_allow(): a socket in a non-global
> +	 * (local) netns must not receive datagrams it could never send.
> +	 */
> +	if (!vsock_net_mode_global(vsock))
> +		return false;

[Severity: High]
Is the new check reachable for peer_cid == VMADDR_CID_HYPERVISOR?

The hypervisor early return above it is unconditional, so in
vmci_transport_allow_dgram() the netns mode is never consulted for CID 0.

The send hook the comment names does the opposite ordering:

net/vmw_vsock/vmci_transport.c:vmci_transport_dgram_allow() {
	if (!vsock_net_mode_global(vsk))
		return false;

	if (cid == VMADDR_CID_HYPERVISOR) {
		/* Registrations of PBRPC Servers do not modify VMX/Hypervisor
		 * state and are allowed.
		 */
		return port == VMCI_UNITY_PBRPC_REGISTER;
	}

	return true;
}

So a SOCK_DGRAM socket in a local-mode netns still accepts hypervisor-sourced
datagrams while its own sends to the hypervisor are refused, which looks like
the exact case the comment says must not happen ("a socket in a non-global
(local) netns must not receive datagrams it could never send").

Nothing appears to keep such a socket from registering the receive callback:
vsock_assign_transport() picks transport_dgram for SOCK_DGRAM with no netns
check, and __vsock_bind_dgram() -> vmci_transport_dgram_bind() registers
vmci_transport_recv_dgram_cb() unconditionally.

Then vmci_transport_allow_dgram() is the only gate before the datagram is
queued:

net/vmw_vsock/vmci_transport.c:vmci_transport_recv_dgram_cb() {
	vsk = vsock_sk(sk);
	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
		return VMCI_ERROR_NO_ACCESS;
	...
}

And hypervisor-sourced datagrams do reach ordinary handlers; only the event
resource is special-cased:

drivers/misc/vmw_vmci/vmci_guest.c {
	if (dg->src.context == VMCI_HYPERVISOR_CONTEXT_ID &&
	    dg->dst.resource == VMCI_EVENT_HANDLER) {
		result = vmci_event_dispatch(dg);
	} else {
		result = vmci_datagram_invoke_guest_handler(dg);
	}
}

Would moving the vsock_net_mode_global() test above the hypervisor early
return be the intended shape here?  If a receive-side exception for CID 0 is
deliberate, could the comment say so, and should it mirror the send side's
VMCI_UNITY_PBRPC_REGISTER port restriction?

>  
> -	return vsock->cached_peer_allow_dgram;
> +	/* Evaluate on every datagram instead of caching the decision in
> +	 * vsock->cached_peer{,_allow_dgram}: those fields were an
> +	 * unsynchronized check-then-set shared between the lockless receive
> +	 * tasklet and the lock_sock() send path, which could return a stale
> +	 * 'allow' for a restricted peer.
> +	 */

[Severity: Low]
This isn't a bug, but could the two struct members go away in this same
patch rather than a follow-up?  After this change, a tree-wide grep for
cached_peer matches only the two definitions and this new prose comment:

include/net/af_vsock.h:struct vsock_sock {
	...
	/* Accessed without the socket lock held. This means it can never be
	 * modified outsided of socket create or destruct.
	 */
	bool trusted;
	bool cached_peer_allow_dgram;	/* Dgram communication allowed to
					 * cached peer?
					 */
	u32 cached_peer;  /* Context ID of last dgram destination check. */
	...
}

The block that this patch deletes was the only reader and writer, so the
header now documents per-socket ACL caching state that no code maintains.

> +	if (!vmci_transport_is_trusted(vsock, peer_cid) &&
> +	    (vmci_context_get_priv_flags(peer_cid) &
> +	     VMCI_PRIVILEGE_FLAG_RESTRICTED))
> +		return false;
> +
> +	return true;
>  }

[Severity: High]
Was the per-datagram cost of dropping the cache measured?

vmci_transport_allow_dgram() is called from
vmci_transport_recv_dgram_cb(), i.e. from the VMCI receive tasklet,
once for every incoming datagram.  After this change both remaining
tests can walk the global context list:

  vmci_transport_is_trusted() -> vmci_is_context_owner() -> vmci_ctx_get()
  vmci_context_get_priv_flags() -> vmci_ctx_get()

and vmci_ctx_get() is a linear search:

drivers/misc/vmw_vmci/vmci_context.c:vmci_ctx_get() {
	rcu_read_lock();
	list_for_each_entry_rcu(c, &ctx_list.head, list_item) {
		if (c->cid == context_id) {
	...
}

For an untrusted socket vsock->trusted is false, so the && does not
short-circuit and both lookups run: two traversals proportional to the
number of registered VMCI contexts, per packet, in softirq context,
where the cached_peer path used to be one u32 compare.  On a host with
many contexts that is new fast-path work; in a guest
vmci_host_code_active() is false so vmci_context_get_priv_flags()
returns early, but vmci_is_context_owner() is still on the path.

I am not defending the racy check-then-set — the interleave you
describe is real, and the stale-allow outcome is worse than the cost.
But is removing the cache outright the only way out?  cached_peer and
cached_peer_allow_dgram could be collapsed into a single word (cid plus
an allow bit) accessed with READ_ONCE()/WRITE_ONCE(), which kills the
torn/mismatched-pair problem while keeping the common case O(1) —
though that still returns a stale verdict if the peer's privilege flags
change after the first datagram, so perhaps you concluded that any
caching is unsound here.

Could you say which it is in the changelog, and give some idea of the
impact (datagram rate, context count) of evaluating on every packet?
The cache was presumably added for a reason, and a note that VMCI
datagram receive is slow enough for two context lookups not to matter
would make the trade-off reviewable.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917220225.56200-1-bartlomiej.dmitruk%40isec.pl
