Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5DC420463;
	Wed, 14 Oct 2026 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959590; cv=none; b=dGTPtujZebDU1kZWPxQYqMod8MBITeLrNmBsYD9aQCGSu5c6h4REh5lh1qLknR6bB3rpsxyo6ZYsER+cxtyPsuYst7qZ50zzJ3XQ8WYzIweBRry565nkvrfsjDlVkX3h+eQsAMy7tQhB2PuddNjs4zsSWHVVAu0XEEJ7b8rj5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959590; c=relaxed/simple;
	bh=4saAHDhCjK3LZFJab5U2Zqo6QmmhLScGPlZ1jXyG+hI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMIlggFQEHQN044gKsOjUb+GDBGX+EfbfW5UPd+kJy7/nWhB7c/bKZC7buNgPbcrB5ME3Jc3Y9DY+4qwLnVtEunpLjevKRHDDjRpTZrtlK8mZQz1sUyjUDe72VmUvfWwWDmf/zCJRVbk4No9M92EyI/dc/rSKupWci9l6xSL01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDXnw0Gk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDXnw0Gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C231F00898;
	Wed, 14 Oct 2026 06:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791959584;
	bh=EWCNmbwJHhBwSsV/lfgErUclzHkc351RPDMX6BjvH5k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RDXnw0Gkrer1O+yr2wqsyOpNiO/ZW3JKL+RJ4n71Sx0LRcMVkkvDuiXCivG1bmgxJ
	 Sr1S85c574IyIXAObjnFY365TZuuREoso5KT77FGevRhDH+jTWQ/eF3nLwNlfVU4mP
	 wG8/q5iPGNNDcuzAYbJmpKTzEAz07F4y8hJejU359NfeCi0BnCpgh/99RF19JC9ZM6
	 0eI5zfLyo5osi2dY/Fo+zwNCZloAt3PIYWKd9H5ynadiCCp7X8UoKohCdcwbSKkSkx
	 erbPEkbNlHvuEwvXc6VlUIh/6zVfC69dAZN8r499vuVp1W2OQz1tANHys9fIfaXjtC
	 62dG7jFXvPLhA==
Subject: Re: [PATCH net-next v3 4/4] vsock/virtio: defer RX readable
 notifications until batch unlock
From: netdev-bot+sashiko@kernel.org
To: physicalmtea@gmail.com
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, virtualization@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 06:33:03 +0000
Message-ID: <179195958316.434549.14684073562290997454@kernel.org>
In-Reply-To: <20261013063112.168321-5-physicalmtea@gmail.com>
References: <20261013063112.168321-5-physicalmtea@gmail.com>
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

- [Medium] The patch defers sock_def_readable() until after
  release_sock() so that a reader is not woken while the RX worker still…

--

vsock/virtio: defer RX readable notifications until batch unlock

This commit records when an RX batch makes a socket readable. It then
calls the saved sock_def_readable() callback once, after the batch
releases the socket lock, instead of calling it per packet. The
original sk_data_ready callback is saved in __vsock_create(), and
batching now also requires sk_data_ready to still match it.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index d6ebfde880db6..84822d6bfb958 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1975,6 +1987,10 @@ void virtio_transport_rx_batch_finish(struct virtio_transport_rx_batch *batch)
>  		vsock_sk(sk)->default_write_space(sk);
>  
>  	release_sock(sk);
> +
> +	if (data_ready_pending)
> +		vsock_sk(sk)->default_data_ready(sk);
> +

[Severity: Medium]
Do blocking recv() readers still get woken while the worker holds the
socket lock?

virtio_transport_rx_batch_finish() still calls default_write_space()
(sock_def_write_space()) before release_sock(). That function wakes
the same wait queue that sk_sleep(sk) returns:

net/core/sock.c:sock_def_write_space() {
    ...
		if (skwq_has_sleeper(wq))
			wake_up_interruptible_sync_poll(&wq->wait, EPOLLOUT |
						EPOLLWRNORM | EPOLLWRBAND);
    ...
}

A blocking stream reader uses DEFINE_WAIT(wait) in
__vsock_stream_recvmsg(). It sleeps on that queue through
vsock_connectible_wait_data():

		prepare_to_wait(sk_sleep(sk), wait, TASK_INTERRUPTIBLE);

DEFINE_WAIT() uses autoremove_wake_function(), which ignores the
EPOLLOUT key. So the EPOLLOUT wakeup also wakes the reader and removes
it from the queue.

On a socket that mostly receives, tx_cnt - peer_fwd_cnt is about zero.
That means virtio_transport_space_update() reports free credit for
nearly every batch, and virtio_transport_recv_pkt_locked() sets
batch->write_space_pending:

	if (space_available) {
		if (batch)
			batch->write_space_pending = true;
		else
			sk->sk_write_space(sk);
	}

In that case the reader wakes under the lock, calls lock_sock(), and
waits on sk_lock.wq until release_sock(). When the deferred
default_data_ready() runs, no sleeper is left. This looks like the
situation the commit message says the patch avoids:

  "Waking a reader at that point can make it immediately wait
  for the same lock."

It seems only poll/epoll waiters that filter on EPOLLIN alone would
benefit from the deferral.

The previous patch in the series ("vsock/virtio: coalesce RX
write-space notifications in lock batches") argues that a writer
cannot use new credit until the lock is released. Could the
default_write_space() call move after release_sock() as well? If not,
could the commit message say why write-space stays under the lock and
that blocking readers are not covered?

>  	sock_put(sk);
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_rx_batch_finish);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013063112.168321-1-physicalmtea%40gmail.com
