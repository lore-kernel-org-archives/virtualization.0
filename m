Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858943911DC;
	Thu, 10 Sep 2026 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073505; cv=none; b=qsqXog5j0+OVgrTflQ6s37XFjlW7MOakb7oeQZZElqw3Nm6GUzDgpbxDU7Rr+NXfXhjNPa9emsVvC0CwEv1k/Z9F3qoxxK0bPGwi73W4BZmG8zGZYNC/TSoUFEvQHzS44gxCvLlAlm9KEkVKaBufP2OmcLQHLDRNVgoMs4o+4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073505; c=relaxed/simple;
	bh=UCcOfUVMCJebxAkWuL8LP+6Dv3V0y9amcOj5t24E4bk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nZDBRMmhi9iyQ6QukGfyVh33XGFu+oY3fnDP5l2DMj6AOUdCIvnAU5sT6A2w1FSZfx9/Hq5vCel0TLvGLi7qFB9xE7WgsxPrTW3vij9/0+fsfZF4lxEVArgqPjr8mTDMTmt3pTj1p7ndOoTDvkgKJMAF1F2/pbImd+U9PCqRYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KgIgCt/h; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KgIgCt/h"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x4lk1-0050Q4-FD; Thu, 10 Sep 2026 22:51:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=anPNjmrD8AW3WMHHHWQknz5mBFm1utmEizQxwcLWIcE=; b=KgIgCt/hpDIDVaafe51u9nK8Qn
	5znMARaKErqdXWomliTQtzckH4QdNqbQ97lOk0XEyua2WARW0VvXiBWWjzF1Kdg8TfT4h5FLoChQc
	ZWukeODXaA91E+SmrxRq0ZThpAgzSSAtQviiUZQFYenHju6w88NPLkKRWOq5r9ZjzSmi7lY9X7Osr
	M+2ZERVw9ZX8O6SXAbvoXg1PxuCNnOFIddryZKsKruVftg2F6mIqvSkhZBskAKwqoodsg8vaM9Azh
	ZaGrIf7/3D0u3rnG6HlWOZogDXGp7wPpGTFQYhRFWJ3AEzeqtyrHMcAWSiItl6RFYLlVXFLYTOXw6
	fEuWQxCw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x4ljq-0000GR-Si; Thu, 10 Sep 2026 22:51:18 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x4ljn-002hpl-EH;
	Thu, 10 Sep 2026 22:51:15 +0200
Message-ID: <3405f482-e8e8-49fa-b465-045b787d5080@rbox.co>
Date: Thu, 10 Sep 2026 22:51:08 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock: Do not reset a TCP_CLOSING socket
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Dmitry Torokhov <dtor@vmware.com>,
 Andy King <acking@vmware.com>, George Zhang <georgezhang@vmware.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
References: <20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co>
 <aqHhUROhqyNhPJDr@devvm29614.prn0.facebook.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <aqHhUROhqyNhPJDr@devvm29614.prn0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 00:44, Bobby Eshleman wrote:
> On Wed, Sep 09, 2026 at 11:58:26PM +0200, Michal Luczaj wrote:
>> Ensure connect() resets the socket only if it has never been established.
>> Handle the previously overlooked TCP_ESTABLISHED -> TCP_CLOSING
>> transition (on VIRTIO_VSOCK_OP_RST), which could race with the connect
>> loop.
>>
>> Resetting a socket that is still present in connected_table can lead to
>> memory corruption. The reporter noted lost transports for in-flight skbs,
>> and I have reproduced crashes caused by re-insertion into connected_table.
>>
>>   list_add double add: new=, prev=, next=.
>>   kernel BUG at lib/list_debug.c:35!
>>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>>   Workqueue: vsock-loopback vsock_loopback_work
>>   RIP: 0010:__list_add_valid_or_report+0x11f/0x130
>>   Call Trace:
>>    vsock_insert_connected.cold+0xe/0x13
>>    virtio_transport_recv_pkt+0x10e9/0x1460
>>    vsock_loopback_work+0x305/0x480
>>    process_one_work+0xe4c/0x1560
>>    worker_thread+0x4f1/0xd60
>>    kthread+0x36e/0x470
>>    ret_from_fork+0x47b/0x6b0
>>    ret_from_fork_asm+0x1a/0x30
>>
>> Drop the inaccurate comment above signal_pending(). This fix is
>> supplementary to commit 002541ef650b ("vsock: Ignore signal/timeout on
>> connect() if already established"). Details at Link.
>>
>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
>> Link: https://lore.kernel.org/netdev/anzT1fREOSyHT99k@v4bel/
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Note that this is not a complete fix. connect()'s schedule_timeout() can
>> still race with two other functions that set sk_state = TCP_CLOSE while
>> keeping the socket in connected_table:
>> 1. vmci_transport_handle_detach(): no way for me to test,
>> 2. virtio_vsock_reset_sock(): tested by unbinding the driver
>>    (/sys/bus/virtio/drivers/virtio_transport/unbind).
>> The latter appears easy to fix by adding __vsock_remove_connected() and
>> switching to a _safe iterator in vsock_for_each_connected_socket().
>> ---
>>  net/vmw_vsock/af_vsock.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index f840498b58af..eec5dd6daebb 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1834,23 +1834,20 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>>  		timeout = schedule_timeout(timeout);
>>  		lock_sock(sk);
>>  
>> -		/* Connection established. Whatever happens to socket once we
>> -		 * release it, that's not connect()'s concern. No need to go
>> +		/* Connection was established. Whatever happens to socket once
>> +		 * we release it, that's not connect()'s concern. No need to go
>>  		 * into signal and timeout handling. Call it a day.
>>  		 *
>>  		 * Note that allowing to "reset" an already established socket
>>  		 * here is racy and insecure.
>>  		 */
>> -		if (sk->sk_state == TCP_ESTABLISHED)
>> +		if (sk->sk_state == TCP_ESTABLISHED ||
>> +		    sk->sk_state == TCP_CLOSING)
>>  			break;
>>  
>>  		/* If connection was _not_ established and a signal/timeout came
>>  		 * to be, we want the socket's state reset. User space may want
>>  		 * to retry.
>> -		 *
>> -		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>> -		 * vsock_connected_table. We keep the binding and the transport
>> -		 * assigned.
>>  		 */
>>  		if (signal_pending(current) || timeout == 0) {
>>  			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>> @@ -1875,7 +1872,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>>  	}
>>  
>>  	err = sock_error(sk);
>> -	if (err) {
>> +	if (err &&
>> +	    sk->sk_state != TCP_ESTABLISHED && sk->sk_state != TCP_CLOSING) {
> 
> If the OP_RESPONSE + a blast of OP_RW that pushes past the buffer limit
> arrives while we were scheduled out, we end up with sk_err = ENOBUFS
> here. Then I guess connect() returns an error, but sk_state/sock->state
> is still TCP_ESTABLISHED and SS_CONNECTED. If the user sees the error
> and tries connect() again, they just get -EISCONN back. Maybe the
> sock_error() needs to be moved within the conditional here, and then let
> subsequent calls return the error to the user (it looks sendmsg() at
> least will report it faithfully, but not sure about recvmsg() or the
> others).

Right, I share the concern about ENOBUFS. I'll move sock_error() in v2.

thanks,
Michal

