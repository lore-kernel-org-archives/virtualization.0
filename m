Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936E4E13E2;
	Thu, 24 Sep 2026 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285325; cv=none; b=EV8l9XXupSSrsKpHi+pXw6xs5Rop0FTKTaxMpEWkpcbDTeQXbppJ9liOK7i+nGrbVZl5lmBiemVIdktMqf0ynVpJW5apJFBmk1v7jZxA3THunN0hSzMM+Yu3TZKM3r0kjaA10v+CWdG0pXMvyKKXsB6fNkWMRwefbeL5oWZwj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285325; c=relaxed/simple;
	bh=zjVyWGYiWU5HUgN4grMTJZ0U8bH8rEz7Jb8s2GZuJX0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ff8620XRXzFEBksVbtSIicwz8bEVbXN8RT7gtt+/+3xPonUcLnrlQwqNQrKJQvcYqF7PoG2D6Zr/QEUX0my5UD2wsPqs+iIgxVZk7RbvnTB6cp7VEdutmUoMr6zGX9TyRoFdpp5r3QIy2ZjZ8REHEpQyuxCfAfoYYpU9pY4ne+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=o2dUdeUl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="o2dUdeUl"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x9qza-00A207-MI; Thu, 24 Sep 2026 23:28:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=icYBpqz7ANQkUhLTH1pziF4V6RUqX/lbxbmolynXgnk=; b=o2dUdeUlz7s0Wk4SkpCMBpseP0
	6Qt+9otc95CW9/QguKUCVq9WE8xiXTy4jMH9zgEedyspAjifAA+cxgSzq/C0R6+u3WiqdVapHFyGL
	gMd9cb2mWsjrZvEMe02zdM4OHdscqUocD9n1IcpzFltOpkbklvl+0VG9WBOOGkkpNdA1xR3p4Bmzm
	Bz0O/DEsbLkGmNKKAp9e6B4m5Ciud5Fk7t5AjvouvvSOILxLSx0gMWGsNP5zyvYUkP9TI8OTkiOPU
	gStrBY/A+FJ4hWfshE68P5fgKlBYP1HFlfE0TNCjbEFr60zSjAJc8VOpVTXqbvd6G9nco9txPnD8k
	nHzS+BBA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x9qzV-0002mD-D7; Thu, 24 Sep 2026 23:28:29 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x9qzU-006Jfx-P4;
	Thu, 24 Sep 2026 23:28:28 +0200
Message-ID: <c3f61ed8-7d53-4c66-ae01-4dab9e26751c@rbox.co>
Date: Thu, 24 Sep 2026 23:28:27 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v3 6/8] vsock: handle socket bricking due to transport
 event
To: netdev-bot+sashiko@kernel.org
Cc: stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, davem@davemloft.net,
 xuanzhuo@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imv4bel@gmail.com
References: <20260922-vsock-connect-reset-closing-v3-6-78907b8200d4@rbox.co>
 <179025570732.2160803.4275584152310711154@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <179025570732.2160803.4275584152310711154@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 15:15, netdev-bot+sashiko@kernel.org wrote:
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index ff4140aaf1f32..5a2d7e10ecb88 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1663,6 +1663,19 @@ static void vsock_unconnected_reset(struct sock *sk)
>>  
>>  	sock_owned_by_me(sk);
>>  
>> +	/*
>> +	 * Transport events are serviced by resetting each connected socket to
>> +	 * TCP_CLOSE. The reset is done under vsock_table_lock but without
>> +	 * taking lock_sock(), so it is effectively lockless from the
>> +	 * perspective of connect().
>> +	 *
>> +	 * Preserve socket's bricked status. Also check SS_DISCONNECTING, since
>> +	 * shutdown() may race us.
>> +	 */
>> +	if (sk->sk_socket->state == SS_CONNECTED ||
>> +	    sk->sk_socket->state == SS_DISCONNECTING)
>> +		return;
>> +
> 
> [Severity: High]
> Can the SS_DISCONNECTING part of this test also swallow the reset for a
> socket that never established?
> 
> vsock_shutdown() moves any socket that is not SS_UNCONNECTED to
> SS_DISCONNECTING, including one that is merely SS_CONNECTING /
> TCP_SYN_SENT:
> 
> net/vmw_vsock/af_vsock.c:vsock_shutdown() {
> 	...
> 	if (sock->state == SS_UNCONNECTED) {
> 		err = -ENOTCONN;
> 		if (sock_type_connectible(sk->sk_type))
> 			goto out;
> 	} else {
> 		sock->state = SS_DISCONNECTING;
> 		err = 0;
> 	}
> 	...
> }
> 
> For a blocking connect(), thread A sleeps in schedule_timeout() with the
> socket lock released, thread B calls shutdown(fd, SHUT_RD).  sk_state stays
> TCP_SYN_SENT and sk_err stays 0, so the wait loop keeps sleeping until the
> timeout or a signal, then takes out_wait -> out_reset ->
> vsock_unconnected_reset(), which now returns here because sock->state is
> SS_DISCONNECTING.
> 
> For a non-blocking connect(), the same guard in vsock_connect_timeout()
> does not filter a SHUT_RD-only shutdown:
> 
> net/vmw_vsock/af_vsock.c:vsock_connect_timeout() {
> 	...
> 	if (sk->sk_state == TCP_SYN_SENT &&
> 	    (sk->sk_shutdown != SHUTDOWN_MASK)) {
> 		sk->sk_err = ETIMEDOUT;
> 		sk_error_report(sk);
> 		vsock_unconnected_reset(sk);
> 	}
> 	...
> }
> 
> so the worker calls the helper and the reset is swallowed there too.
> 
> In both cases vsock_transport_cancel_pkt(), vsock_deassign_transport() and
> the WRITE_ONCE(sk->sk_state, TCP_CLOSE) / sk->sk_socket->state =
> SS_UNCONNECTED below are skipped, and no further timeout is armed.  Does
> that leave the socket stuck in TCP_SYN_SENT with the transport still
> assigned and the VIRTIO_VSOCK_OP_REQUEST not cancelled?

Yes.

> A late response then still matches TCP_SYN_SENT:
> 
> net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_connecting() {
> 	...
> 	case VIRTIO_VSOCK_OP_RESPONSE:
> 		sk->sk_state = TCP_ESTABLISHED;
> 		sk->sk_socket->state = SS_CONNECTED;
> 		vsock_insert_connected(vsk);
> 	...
> }
> 
> so the connection can complete and become usable for send()/recv() after
> connect() already returned -ETIMEDOUT or -EINTR.  A retry of connect() now
> hits case SS_DISCONNECTING: err = -EINVAL, whereas before this patch the
> failure path reset the socket to TCP_CLOSE / SS_UNCONNECTED.
> 
> Would an explicit flag, or a vsock_connected_table membership test, express
> the intended "socket was once established" condition better than
> sock->state?

Do we want to support connect() being raced by shutdown()?

> [Severity: High]
> The commit message says "But transport events leave SS_CONNECTED state
> unchanged" and lists vmci_transport_handle_detach() as one of the handlers.
> Does that hold for the VMCI detach path?

Addressed in comments to patch #3.

