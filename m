Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457ED485CD9;
	Thu, 24 Sep 2026 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255712; cv=none; b=iAmLo72yKROJ4vrChZUvXU36GIIxsIeqaoPelonzEDpIzdckecDizmnS2qVYwRWv9aVNIwFF552BfH/JtgYBxF1xQ+USO6r4dCkrXIqBd7pX5+pPu9KgXhf5+OoARpVwVRTvrQjXzDUF7vaA+1x2WNNVe/CkrSoSkfhAuQ6oJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255712; c=relaxed/simple;
	bh=D457ys11xA+Le0Bhlr+wB2HNGwzEv3sC1dSac0Zdjt4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Voos2aBKfoXv90MHj/FnH9dGh/E+kSXbdn4xfCYJcWqKAgmB9UVfCLyVFtkqzFZlrXfbNPwFhioU0ZjRHwRO1AYkTQ5YCSgA9J9oAXROHi7V1sc0gSouC3zR/oqWyXfBhRjQA1DseX21p61kGC/KrKdoUREsP0RxPO+ehmXDG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MknJNTL+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MknJNTL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5D01F00898;
	Thu, 24 Sep 2026 13:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790255710;
	bh=g9sRmXVB5ciON2DlzFeWlXKs+NJaQal3k3zArRH8QwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MknJNTL+2cYW1awLN5iHOZzIwVl3HMofmCuvvXv42pCL6KN40bt6VJlpa2ah/CrPo
	 awPieqoav0DBseHr72acR8qdZvgMWE9Vmq8YEslLPWxmkkvh3H/a7FJ/M0YsS6KKRo
	 tG8VBIJP9Vka/QGOxBw6+ht+j8raJwksoA7BMI232x2yiswncjnq17hQ0Mh62+/A4b
	 dIMnsYL0aKoDXrIsPYZ+cYtncVMGOuw3WOmbY5E7XnLoNnJL5vpu+nEnAeM8s1NBoq
	 +pZaJ9+3DthAfQzHatu08aVPgNrR+FLmu5revb5NU7D9uBmAcNgl5kvewqn2BJGLSL
	 aBck0OuPPr+jg==
Subject: Re: [PATCH net v3 7/8] vsock: handle listen() racing connect()
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
Date: Thu, 24 Sep 2026 13:15:08 +0000
Message-ID: <179025570873.2160803.3404632155755678732@kernel.org>
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-7-78907b8200d4@rbox.co>
References: <20260922-vsock-connect-reset-closing-v3-7-78907b8200d4@rbox.co>
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

- [Medium] The commit message states the goal is to 'let connect() time
  out, but don't reset the socket', implying the pre-patch code resets a…
- [Low] The patch fixes a user-visible, unprivileged-reachable defect
  that exists in released kernels but carries no `Fixes:` tag and no…

--

vsock: handle listen() racing connect()

This adds an early return to vsock_unconnected_reset() so that a socket
which a racing listen() has moved to TCP_LISTEN is left alone. A blocking
connect() that was sleeping in schedule_timeout() then returns its error
without demoting the listener.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 5a2d7e10ecb88..56c5959424564 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1663,6 +1663,13 @@ static void vsock_unconnected_reset(struct sock *sk)
>  
>  	sock_owned_by_me(sk);
>  
> +	/*
> +	 * listen() can race connect() on schedule_timeout().
> +	 * Don't reset TCP_LISTEN.
> +	 */
> +	if (sk->sk_state == TCP_LISTEN)
> +		return;
> +

[Severity: Medium]
The changelog says the intent is to "let connect() time out, but don't
reset the socket", which reads as though the code just before this patch
resets a TCP_LISTEN socket.

Is that still true with the immediate parent ("vsock: handle socket
bricking due to transport event") applied?  In that tree the race
described in the changelog reaches the checks already present in
vsock_unconnected_reset():

net/vmw_vsock/af_vsock.c:vsock_unconnected_reset() {
	...
	if (WARN_ON_ONCE(vsk->peer_shutdown) ||
	    WARN_ON_ONCE(sock_flag(sk, SOCK_DONE)) ||
	    WARN_ON_ONCE(sk->sk_state != TCP_SYN_SENT &&
			 sk->sk_state != TCP_CLOSE))
		return;
	...
}

With sk_state == TCP_LISTEN and sk->sk_socket->state == SS_UNCONNECTED,
the SS_CONNECTED/SS_DISCONNECTING guard does not fire, peer_shutdown is
zero and SOCK_DONE is unset, so control reaches the third WARN_ON_ONCE
and returns without resetting anything.

That makes the pre-patch symptom at this point of the series a
userspace-triggerable splat from vsock_connect()'s out_reset: path rather
than a lost listener, and a splat is fatal with panic_on_warn.  The
window covers the commits from "vsock: do not preserve transport
assignment" through "vsock: handle socket bricking due to transport
event", so a bisect or a partial backport can land on it.

Would it make sense to squash this TCP_LISTEN check into the commit that
introduced that WARN_ON_ONCE, or otherwise mention the warning in the
changelog?

[Severity: Low]
Should this patch carry a Fixes: tag?  The sibling fixes in the same
series carry Fixes: d021c344051a ("VSOCK: Introduce VM Sockets"), while
this one has only a Signed-off-by.

Released kernels appear to hit the same race without this guard.  At the
pre-series baseline, vsock_connect() writes the state back unconditionally
with no sk_state test:

net/vmw_vsock/af_vsock.c:vsock_connect() {
	...
	err = sock_error(sk);
	if (err) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}
	...
}

and vsock_listen() only requires SS_UNCONNECTED plus a bound address
before flipping the state:

net/vmw_vsock/af_vsock.c:vsock_listen() {
	...
	if (sock->state != SS_UNCONNECTED) {
		err = -EINVAL;
		goto out;
	}
	...
	if (!vsock_addr_bound(&vsk->local_addr)) {
		err = -EINVAL;
		goto out;
	}

	sk->sk_max_ack_backlog = backlog;
	sk->sk_state = TCP_LISTEN;
	...
}

So on a stable tree, two threads sharing one fd (non-blocking connect()
arming vsock_connect_timeout(), blocking connect() sleeping in
schedule_timeout(), then listen()) can end up with the listener demoted
to TCP_CLOSE/SS_UNCONNECTED and accept() returning -EINVAL.  Without a
Fixes: or Cc: stable trailer, is there anything to signal that to
backporters?

>  	/*
>  	 * Transport events are serviced by resetting each connected socket to
>  	 * TCP_CLOSE. The reset is done under vsock_table_lock but without

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-vsock-connect-reset-closing-v3-0-78907b8200d4%40rbox.co
