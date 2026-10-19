Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C448592C;
	Mon, 19 Oct 2026 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392242; cv=none; b=JvTS9RamZsZDKW+wJzLzDdIdcOdEOYKxmbXhy8l6X/2WHJYLGWpUQymiaZIDvxfsz0oOpOG0/99ZvwSU331WMBoAjILt8fOt/TOFGtsRlA4OM7mehHHx8xAeIuM8AGlUa4l1o/6YhiT5gj2o9Q19Oo3rGAIxNR6FKEl1JTubjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392242; c=relaxed/simple;
	bh=AG8uLDY1S6wAwAA61tjppNxLsAgbrZPU3u1MoI0wUnk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=go34865mpGN3BtdikYTOWxfRNQEkkoReCjQx8KL286AjRfAnS1B++sABpzg5580btgKdFbUz+9XiTBpl8DqKNaG23fHGb5CbpXfJpfVYVwq6G/KXxNpxtQMEaRJPEWqKgNWV3oHCc9wuG0b5BJk3ot5dCT9qkwsCXuOZ3PH9laE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7muDs8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7muDs8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57361F000C4;
	Mon, 19 Oct 2026 06:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392240;
	bh=3LzAVenLs17+neRI0Kjg60FfMYZTYlgEe17qszI4504=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X7muDs8qevBAaUUal+neKz8U1C+bfqsr/ySqQClmzwvvq/G6jw+BNCR6EWia3HujI
	 CSX1N/VyCHAMxt0xpsle2iBCN4r8AYcN54fFuAayBL/KxdtJWA50hW4TeTdbU+Bvcu
	 Xo4H/FhAI/XVxuOZML7Y+eqZxPkOXzWFEQpUssHmeJHQsSK5+7+6e31iIy8uEXbAoU
	 UUMr/cyLR5OtEXqBc6u1JV+hlpvbRkqu79USScve5o0MVH6qNnpSKbzKtsnlpq6dFM
	 rblyboOVD8xvOxKIm6LO9Ow2sGsAyTGXpSF2CWRu6fJBkljEZIXVfnpEuqD4R+9A06
	 05EonGe9NMGWg==
Subject: Re: [PATCH net-next v2 1/2] vsock: support SO_INQ on stream sockets
From: netdev-bot+sashiko@kernel.org
To: devnexen@gmail.com
Cc: netdev@vger.kernel.org, sgarzare@redhat.com, bobbyeshleman@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 06:43:59 +0000
Message-ID: <179239223925.3135.8476932493136974317@kernel.org>
In-Reply-To: <20261015154334.3217358-2-devnexen@gmail.com>
References: <20261015154334.3217358-2-devnexen@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch puts a different meaning into the generic
  SOL_SOCKET/SCM_INQ cmsg than the one already in the tree.

--

vsock: support SO_INQ on stream sockets

This adds SO_INQ support to AF_VSOCK SOCK_STREAM sockets. recvmsg() then
returns an SCM_INQ cmsg filled from vsock_stream_inq_hint(). Accepted
sockets inherit the setting from the listener, and SOCK_SEQPACKET rejects
the option with ENOPROTOOPT.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1c2d1cea67f4c..186ed57fd7978 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -2637,13 +2679,26 @@ __vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>  
>  out:
> -	/* Seqpacket has_data counts messages, while io_uring treats msg_inq as
> -	 * a byte length when sizing retries, so only streams report a hint.
> +	/* Seqpacket has_data counts messages, while SCM_INQ reports bytes and
> +	 * io_uring treats msg_inq as a byte length when sizing retries, so
> +	 * only streams report it.
>  	 */
> -	if (msg->msg_get_inq && err >= 0 && sk->sk_type == SOCK_STREAM)
> +	if ((vsk->recvmsg_inq || msg->msg_get_inq) && err >= 0 &&
> +	    sk->sk_type == SOCK_STREAM) {
>  		msg->msg_inq = vsock_stream_inq_hint(sk);
>  
> +		/* A negative hint means the transport could not tell. SCM_INQ
> +		 * has no encoding for that, so report nothing.
> +		 */
> +		do_cmsg = vsk->recvmsg_inq && msg->msg_inq >= 0;
> +	}
> +
>  	release_sock(sk);
> +
> +	if (do_cmsg)
> +		put_cmsg(msg, SOL_SOCKET, SCM_INQ, sizeof(msg->msg_inq),
> +			 &msg->msg_inq);

[Severity: Medium]

Does this give SOL_SOCKET/SCM_INQ a different meaning on vsock than it has
on AF_UNIX?

SO_INQ/SCM_INQ was added in commit df30285b3670 ("af_unix: Introduce
SO_INQ.") as the generic version of TCP_INQ. That commit says the cmsg
holds the exact value of ioctl(SIOCINQ). AF_UNIX follows this:

net/unix/af_unix.c:unix_stream_read_generic() {
    ...
			msg->msg_inq = READ_ONCE(u->inq_len);
			if (do_cmsg)
				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
					 sizeof(msg->msg_inq), &msg->msg_inq);
    ...
}

tools/testing/selftests/net/af_unix/scm_inq.c also checks that the cmsg
payload equals the SIOCINQ result.

Here the value comes from vsock_stream_inq_hint(). In several states it
returns 1 instead of a byte count:

net/vmw_vsock/af_vsock.c:vsock_stream_inq_hint() {
	if ((sk->sk_shutdown & RCV_SHUTDOWN) || !vsk->transport ||
	    (sock_flag(sk, SOCK_DONE) && sk->sk_state != TCP_ESTABLISHED))
		return 1;
    ...
	if (sock_flag(sk, SOCK_DONE) ||
	    (READ_ONCE(vsk->peer_shutdown) & SEND_SHUTDOWN))
		return 1;
    ...
}

The first branch returns 1 even when bytes are still queued. SIOCINQ in
vsock_do_ioctl() still returns the raw vsock_stream_has_data() value,
which is 0 at EOF:

net/vmw_vsock/af_vsock.c:vsock_do_ioctl() {
    ...
		n_bytes = vsock_stream_has_data(vsk);
		if (n_bytes < 0) {
			ret = n_bytes;
			break;
		}
		ret = put_user(n_bytes, arg);
    ...
}

After the peer closes or shuts down, SCM_INQ reports 1 while SIOCINQ
reports 0. After SHUT_RD, SCM_INQ reports 1 no matter how many bytes are
queued.

The commit message says "As with TCP_INQ, 1 is reported once the stream
is finished". TCP_CM_INQ is a separate SOL_TCP cmsg, though. Suppose a
portable program treats SCM_INQ as an exact byte count. Would it see a
byte on vsock that isn't there?

The vsock selftest in the same series ("vsock/test: cover SO_INQ")
expects 1 at EOF. Once this is merged, that per-family meaning becomes
part of the uAPI.

The updated comment above gives "SCM_INQ reports bytes" as the reason to
refuse SEQPACKET, but the stream path does not report bytes at EOF.
Should the comment or the reported value change so they match?

>  	return err;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015154334.3217358-1-devnexen%40gmail.com
