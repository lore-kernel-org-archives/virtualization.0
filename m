Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86908563FDD
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083119; cv=none; b=K5oLUDfJ84bVZApsJEh5C/OsJyAoRGo0YfOsT2AFsvlnHQV+H3kMROTEFZT/7CFo1iYxk8GYK2Wl5KyRbR9aAtd55BKmf1nWLMaUd5uoPzClEZvAkI3We3QcHoO9hDYGV4zx//788YrU6R8lBhP/PV36wS09T60jM6ZQwv1WzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083119; c=relaxed/simple;
	bh=EyoxSkU/YQvO31zKcI0bNAZCdUkSd/GX8KsrWOX1ftA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l9Nl1mbj297AAyF48V+wzjH8T6LHVytMD2ardVdZVI81hXDG02FerOrYJozUk0X+lfMHVOgcPyM/bGyu2woIFy28CSePCC08F7EGOFWVatOWA5I6ksZehBpHdSAdt5gorcrjUjm0rrLeW8xK9sazZPANjbSSNZnvuc4hPjdVQto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=HdK9G6gm; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="HdK9G6gm"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1x90OD-0038hg-JX; Tue, 22 Sep 2026 15:18:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=12HbY+njqSS4MP2GVtwfHtjvmwges/+vvpXHa7B4KVw=; b=HdK9G6gmBRRwW0yHqE2Hf6amXn
	pvzQVSWfK52WdMovPLTBe4+pL+tOqVH5afZdzQQgzghBRh+u7I8tA8FK79kAIxXXIOwkQXGh2pR3/
	UoOOedNbTr3/Yv29dbVtSwr/z7zZT6PmvIb4miHwzuA/8AX9AgpCGi9S4zDFCNsidHy3jPV6wTA1A
	P/Tmj9Fom5/5nTeU6P0GiUL1O0U/8lTddbiL2OUcQCGbT3Tu9vSZpvj60zWQ9/5whYyajkUJHD2GO
	pPC5v57tEkUyVKxUCqQXc6pt8+f9xnSiAlXE07l9QLC2rjCzerZWgeOVBxLFvjBCnTQO4QezHNoc/
	jw/78Pdg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1x90O8-000546-AV; Tue, 22 Sep 2026 15:18:24 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1x90Nq-00HI7a-4S;
	Tue, 22 Sep 2026 15:18:06 +0200
Message-ID: <036cb16f-c3b6-4e94-9c3d-42e40d160833@rbox.co>
Date: Tue, 22 Sep 2026 15:18:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v2 5/5] vsock: Handle sudden TCP_CLOSE during connect
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Asias He <asias@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-5-a1d9abb472f7@rbox.co>
 <aqqIuUadZ_E1skmR@sgarzare-redhat>
Content-Language: pl-PL, en-GB
In-Reply-To: <aqqIuUadZ_E1skmR@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/16/26 14:31, Stefano Garzarella wrote:
> On Tue, Sep 15, 2026 at 03:15:16PM +0200, Michal Luczaj wrote:
>> Virtio/PM events are serviced by virtio_vsock_reset_sock(), which resets
> 
> What "PM" means here?

Power Management, namely virtio_vsock_driver.freeze which is defined under
CONFIG_PM_SLEEP. I'll generalize this comment, as suggested below.

>> each connected socket. The reset is done under vsock_table_lock but without
>> taking lock_sock(), so from the point of view of vsock_connect() -
>> locklessly. The same pattern exists in VMCI's
>> vmci_transport_handle_detach() and vhost's vhost_vsock_reset_orphans().
>>
>> The complexity of connect() comes from the fact that:
>> 1. the virtio transport can be reassigned, so the old transport must be
>>   safely released;
>> 2. a failed connect can be followed by a retry, so the socket must be
>>   reverted to a sensible state.
>> Both cases apply only as long as the socket has not yet established a
>> connection.
>>
>> While connect() waits for TCP_SYN_SENT -> TCP_ESTABLISHED, other
>> transitions can also occur:
>>
>>  TCP_SYN_SENT -> TCP_CLOSE on connection failure, timeout or signal
>>  TCP_SYN_SENT -> TCP_ESTABLISHED -> TCP_CLOSING on VIRTIO_VSOCK_OP_RST
>>  TCP_SYN_SENT -> TCP_ESTABLISHED -> [TCP_CLOSING ->] TCP_CLOSE on event
>>
>> This further complicates connect(). Rather than making every event handler
>> drop the socket from connected_table or adapting connect() to handle more
>> transitions (while missing proper locking), use vsk->peer_shutdown as a
>> poison flag. Whatever state an event leaves the socket in, the flag bricks
>> it and prevents suspicious transport reassignments or TCP_SYN_SENT
>> retransmissions.
>>
>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> net/vmw_vsock/af_vsock.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index adf3f018347e..972952d04a81 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1743,6 +1743,12 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>> 			goto out;
>> 		}
>>
>> +		/* Virtio/PM events are serviced locklessly. */
> 
> IMO we should be generic here (i.e. don't mention virtio or mention it 
> like one of the transport, but IIUC also VMCI does something similar) 
> and also we should explain better why we are doing this, like you did in 
> the commit description.

Sure, will do.

> Maybe we should document this behaviour also on top of this file.

OK, do you mind if I do that as a follow up? I worry top of the file needs
few more updates.

>> +		if (READ_ONCE(vsk->peer_shutdown)) {
>> +			err = -ECONNRESET;
> 
> Is ECONNRESET a valid connect() error to return?
> 
>> +			goto out;
>> +		}
>> +
> 
>  From LLM reviewing, can you check if it's valid? :
>    - M (net/vmw_vsock/af_vsock.c:1747): VMCI regression.  vmci_transport_handle_detach() sets
>      peer_shutdown = SHUTDOWN_MASK unconditionally and then special-cases TCP_SYN_SENT with the
>      comment "we treat the detach event like a reset" — i.e. a connect() retry is the expected
>      recovery. It is reachable for a non-connected socket via vmci_transport_peer_detach_cb() (which
>      uses trans->sk, not the connected table). Since vsock_assign_transport() only clears
>      peer_shutdown when the transport actually changes (af_vsock.c:671-689), the retry now hits the
>      new check and returns -ECONNRESET forever: the fd is permanently bricked where it previously
>      reconnected.

I'm not sure I follow the logic. SHUTDOWN_MASK gets set no matter what's
the state at vmci_transport_handle_detach(). That means even if vmci's
reconnect succeeds, all the recvmsg()/sendmsg() at af_vsock layer would
fail anyway. Am I missing something?

thanks,
Michal

