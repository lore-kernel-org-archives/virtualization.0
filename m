Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58B1172E;
	Wed,  7 Oct 2026 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791332830; cv=none; b=gZHhhWprgw1Y9pUqFvQHhUdkhNspJShVRIfRGDvgJz0GXcRXvhbugwuL95LIzRbZgAtSngw5EJGsEdyEGk4/dTh5b96lCdSPO7UG/z244z/Xtr+7FwDDaU1FW2DEAQfJuIRb44gOStVtoEpeIH6G9vL8GC4yW2f4AZyiREgfe58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791332830; c=relaxed/simple;
	bh=ECTr0XDqga2DzUnecZ397dCIs1QxzehdAzF2EAdoF5g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKKxBjlA24Zzux48kqAjMTZczGE/jTm07waynHpu51wyPyiaq7TUoX83u4IglQqHiTqmt7PBG9UQ4OFtRV01uKW7eirGd6WF84bpIef5Z2jG4wubsoYBuQE16yDe8+1U/0Bjqi33HsF5DyTCTI48P2UQjGOaCrp1PXM0pS19aLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFUkcDaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFUkcDaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7677B1F0089B;
	Wed,  7 Oct 2026 00:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791332828;
	bh=xBG1xIB4aImdC9KdBbznWT/m81u7ln1y5PFAcdJZe5A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kFUkcDaVMDYXhLQF7gKvS7BuLxa3KOscXPaRSeXggxcJmRisHaz97QxcctAkjfBc/
	 IHAsFzG3NePsY7h3/nj5I+XPPmwNkjrQqr5CgfzLJ/cTJ5kEbMvfDniOiEn/UI3L9F
	 cbuQDKXwLG8Y/DTkkg+lJ7hf4M0eX5kwtF5Dp5i/joWmE/p3pk9jaW3+7i5GY8n3eR
	 mfN2sfby8U+bB3l7bWzyOKYMgrsbfVJx9X33mnp2NHV2kKVzXRWGdCmg5yVlDeLLMC
	 WGTcAxkhcUezzGeKDHfSAJQb3cB9Vsb1PCB1bBgsUuEpcOa1EV6bMJG/kWUhfhe0IE
	 5n+PEk+qw63cQ==
Subject: Re: [PATCH net v4] vsock: treat TCP_CLOSING as once-established
From: netdev-bot+sashiko@kernel.org
To: mhal@rbox.co
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, edumazet@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
Date: Wed, 07 Oct 2026 00:27:06 +0000
Message-ID: <179133282699.434549.6239722975007408103@kernel.org>
In-Reply-To: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
References: <20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed@rbox.co>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.

--

vsock: treat TCP_CLOSING as once-established

This patch makes vsock_connect() return 0 right away when the socket is
found in TCP_ESTABLISHED or TCP_CLOSING after waking from
schedule_timeout(). Before, only TCP_ESTABLISHED was checked. The aim is
to stop connect() from resetting a socket that is still in
vsock_connected_table, which can lead to a double insertion and list
corruption.

Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 9b71479a2b295..14fe24b05f9ce 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1834,23 +1834,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  		timeout = schedule_timeout(timeout);
>  		lock_sock(sk);
>  
> -		/* Connection established. Whatever happens to socket once we
> -		 * release it, that's not connect()'s concern. No need to go
> +		/* Connection was established. Whatever happens to socket once
> +		 * we release it, that's not connect()'s concern. No need to go
>  		 * into signal and timeout handling. Call it a day.
>  		 *
>  		 * Note that allowing to "reset" an already established socket
>  		 * here is racy and insecure.
>  		 */
> -		if (sk->sk_state == TCP_ESTABLISHED)
> -			break;
> +		if (sk->sk_state == TCP_ESTABLISHED ||
> +		    sk->sk_state == TCP_CLOSING) {
> +			err = 0;
> +			goto out_wait;
> +		}

[Severity: High]
Can vsock_connect() still reset a socket that is already linked in
vsock_connected_table? This check only covers TCP_ESTABLISHED and
TCP_CLOSING. At least two transports move an established socket that is
already in the table straight to TCP_CLOSE, and neither one unlinks it.

net/vmw_vsock/virtio_transport.c:virtio_vsock_reset_sock() {
	sk->sk_state = TCP_CLOSE;
	sk->sk_err = ECONNRESET;
	sk_error_report(sk);
}

virtio_vsock_event_handle() calls this for every connected socket on
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET. It does not take lock_sock().

net/vmw_vsock/vmci_transport.c:vmci_transport_handle_detach() {
	...
			sk->sk_state = TCP_CLOSE;
		}
		sk->sk_state_change(sk);
	...
}

This runs from vmci_transport_peer_detach_cb() with only bh_lock_sock()
held and no sock_owned_by_user() check. For a socket that is not in
TCP_SYN_SENT, it leaves sk_err at 0.

Suppose either of these runs after the RESPONSE/ATTACH handler has set
TCP_ESTABLISHED and SS_CONNECTED and called vsock_insert_connected(), but
before the sleeping connect() thread takes the lock again:

  connect() thread               RX / event path
  schedule_timeout()
                                 sk_state = TCP_ESTABLISHED
                                 vsock_insert_connected(vsk)
                                 virtio_vsock_reset_sock() or
                                 vmci_transport_handle_detach()
                                   sk_state = TCP_CLOSE
  lock_sock()
  sk_state == TCP_CLOSE, new check does not match

For virtio, sk_err != 0 ends the loop, and then the reset after the loop
runs:

	err = sock_error(sk);
	if (err) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}

For VMCI, sk_err stays 0. The loop keeps waiting until a signal arrives or
the timeout expires, and then the signal/timeout branch sets TCP_CLOSE and
SS_UNCONNECTED.

In both cases connect() returns an error for a connection that was
established. The socket is also left SS_UNCONNECTED while it is still
linked in vsock_connected_table and still holds the table's reference.

If user space then retries connect(), vsock_assign_transport() returns
early because the transport is the same:

	if (vsk->transport && vsk->transport == new_transport) {
		ret = 0;
		goto err;
	}

so vsock_remove_sock() never runs and the stale table entry survives.

For virtio, the next OP_RESPONSE goes through
virtio_transport_recv_connecting(), which calls vsock_insert_connected()
again. For VMCI, an ATTACH that carries the kept qp_handle does the same
thing in vmci_transport_recv_connecting_client(). In the VMCI case the
detach and the later ATTACH both come from the peer.

__vsock_insert_connected() calls sock_hold() and list_add() without
checking whether the socket is already in the list. Wouldn't this hit the
same "list_add double add" BUG quoted in the commit message, and also leak
a socket reference?

sk_state does not seem to track table membership reliably. Would it be
more robust to check sock->state == SS_CONNECTED instead (the transports
set it together with vsock_insert_connected()), or to check membership in
connected_table directly? That check would have to guard both the
signal/timeout reset inside the loop and the sock_error() reset after the
loop.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-vsock-connect-reset-closing-v4-1-15d41cfda3ed%40rbox.co
