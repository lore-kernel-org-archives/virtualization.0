Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5341D12E
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925788; cv=none; b=birAk8dZJzHZ/UeNK9/HCZDq0yvnq4xugWZ1fiMC7gwl9oJ2JPIyOKZAhTnINdhi5c4A+EmCb8LDdK0rKplBs9RtZ/NEWRtrCAzup+tWj5ZEAcegF+t40CjX0gAyBO/zIo7Tw63CXCH1nex6P3VTF8pDRSiTXIhd9zy1lc6ztxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925788; c=relaxed/simple;
	bh=uZIfQ2ep+zKP+NQDe+F559/YOsSB/WrZVinoZfDAncw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCWXuphusSTTsBQbik004z6/XOl2hTVj3Sp6yonGsbSPZzuMzU/TPCyBnZhpBCE7AUtdsaLuWXsl8HPfrZnuRyPqu75uhTsi7BG/lHlAuToim+6pBRWIJoE+oCFb/13RJ8CurJonWEyo6L5K6q+Uan6ojLuMkq2sd/BoEuTFheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQmAnfMy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQmAnfMy"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso955016a91.1
        for <virtualization@lists.linux.dev>; Wed, 05 Aug 2026 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785925782; x=1786530582; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3CobWGezPJ1jiz14fyzEAXpAWQpNHtzLmWbtrjHOhKU=;
        b=GQmAnfMyAbxEKzr+3dXndFWtLXzOU2RqESeQPhXlVVuJRP2zFEbvZLvdt0e13xZTzu
         SEGOoJ7l/ZULNVpxUGL/XDneJ/yyzuNv5aINolz24LFqFXzGsqNnmuK4HRFe9xNxHiJt
         P+3RpoMzZBR6AirSHyL+f11oY9vEaoTPkCDy5GwD9gV15ma+ATFWcAFF99zmR2W0uojq
         ub0Q1CmevR1Sk76moE9W3yMUiS++VvLrXGtCEhO0LYgvcHSnWa6UzBuVPX1e9O/A53Ke
         /PKa3bxugVZsxJaz6nhSnJx2946JF2Ep8Jeyxe7EwXOITpppMMpx5DYweHiAvnmd2t50
         9zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785925782; x=1786530582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3CobWGezPJ1jiz14fyzEAXpAWQpNHtzLmWbtrjHOhKU=;
        b=ie9zMWEhSMf6Kd5wATfD/GwQuB4XCJ7eIEB+dQp35k2l+3LgmdxdSZZh8T5QchneLu
         CnTrWkTDRat7eEQGQ3Jb1vIg3m0amAHigl5ADIbpnbWYer6e1cig0iZUG/RdaAvxzJjm
         8z9GY4BsjxChh2bm10pu3SdjJpl7AbFYgtjWMlENlMIQ5JnyY71jAJ6AXST8yh6Ku2Hi
         d0Xmt+FagRoK2p6hmxyHdjJIwOjPD2hjiRVwexaFFOf/ZdgC1TPDeNOU6Ab1NvheZLLg
         ugvbTfc/+wjGaqLhu4jATsP6o43rjlZRZDGCrTJATTFyIcq0tMz8vrcFgKPMe+5DUDL7
         j8Hg==
X-Forwarded-Encrypted: i=1; AHgh+RrKITiRp0+WXMcZVyhrL+Cz6Sbiraz8CJdT/l3o68vMvFQbhWHf/QRxmFwdp2xAFi6pmNYQBHwp88BiGLn0xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydJK8L9/B1scj1ZOl/KGJd+WgQntuf8uUm5FfyhoJZxaqN+w+r
	29mcvwMP25xw41z8FCAFPryHpCjypkhm7QkYafrBxgR584Jxl26BrbjZ
X-Gm-Gg: AR+sD11f8ukA3S5EDkxIZIE3teDDv+UIO0JaJVdXotnwk6rVjkwEnr8+1ZLoRmUPYK/
	UNtv3VUPsspVSeaR+N0ch9pEmbOmeXdCbHilzXlj0hQz4ufbWnH5VAMR84di7W67K0EeIzle9Iz
	XDVe2kM/ymbuBEiIk/73lOvU7g7uVVS6Rr/RWFq4mxBmq6qcVR6n09EVr5cJv/fqCyWhWqSMb8t
	iO/VcTQrVUMKqopn9VeDSCinx1TlbiTmDmnjJ4+5BiON1M/mW4U+puukw57QL70l2HrnbhOrPVY
	Pc2EWvvvDXCF9ISBOEvf5zO/hIihPOt76g6wZ1FncuLrOqcCiFXENhpwyhZaTrPNI03vU4Y+wYy
	v3UoTzmlkd6+R0sL9NC7XwtnAtEqud6umMO/UkogvQWjMRIIFGQMJ297VnlSJpIZ+I+kw6vjJCt
	ergQTQxUO6YdGNon8VqdxBywVNc7nXIQkfN7nGw6RPXX5hSNOd1BUJ35zLJHz55971ru4vk9GqS
	E2ecpEOwFcpE5vaLg==
X-Received: by 2002:a17:90b:57cf:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-3903c5b34edmr6522051a91.15.1785925782493;
        Wed, 05 Aug 2026 03:29:42 -0700 (PDT)
Received: from [10.22.76.20] ([118.201.124.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392aee23sm2798253a91.15.2026.08.05.03.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 03:29:42 -0700 (PDT)
Message-ID: <b64dde64-8ae0-4b97-bd65-14da8d9cb5eb@gmail.com>
Date: Wed, 5 Aug 2026 18:29:36 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] vsock: use sock_error() to consume sk_err after a
 failed connect
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andy King <acking@vmware.com>, George Zhang <georgezhang@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 Michal Luczaj <mhal@rbox.co>, Wupeng Ma <mawupeng1@huawei.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260804135238.386417-1-phind.uet@gmail.com>
 <anLuRE4ix5-BZ7-t@sgarzare-redhat>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <anLuRE4ix5-BZ7-t@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/8/26 16:34, Stefano Garzarella wrote:
> On Tue, Aug 04, 2026 at 09:52:36PM +0800, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> Syzbot reported an issue which can be reproduced with these steps:
>>
>>   r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>   bind(r0, {VMADDR_CID_ANY, PORT})
>>   connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>>   listen(r0, backlog)                     -> 0
>>   r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>   connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>>   accept(r0)                              -> -1, EPROTO  (stale sk_err)
>>
>> Basically, it creates a socket (r0) and triggers a self-connect after
>> binding it. This self-connect fails with EPROTO because it loops back to
>> r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>> incorrectly dispatched to the connecting-client path. The unexpected
>> packet type encountered there sets sk_err to EPROTO.
>>
>> After that, it invokes a listen() call on the same socket. This listen()
>> call succeeds because the kernel's listening path never inspects or
>> clears sk_err. Then, a new socket (r1) is created as a normal client and
>> connects to r0. However, vsock_accept() rejects this incoming connection
>> because the listener's sk_err still holds the EPROTO error from the
>> earlier failed self-connect.
>>
>> This rejection causes the child socket created for r1's connection to
>> never be freed on virtio or hyperv transports; only the VMCI transport
>> implements pending_work to revisit and clean up a rejected socket.
>>
>> Fix the issue in blocking connect() by using sock_error() to read the
>> sk_err to prevent the rejection branch from occurring in this scenario.
>>
>> sock_error() atomically reads and clears sk_err, ensuring the error is
>> consumed when vsock_connect() returns and cannot affect subsequent
>> operations on the same socket. This matches the established pattern
>> used by other protocol connect() implementations in the network
>> stack like __inet_stream_connect(), tipc_wait_for_connect()...
>>
>> For non-blocking connection, vsock_connect_timeout() may set
>> sk->sk_err after vsock_connect() has returned. To handle it, we also
>> remove the sk_err checks from vsock_accept(). Nothing in vsock sets
>> sk_err on a listening socket, so accept() has no reason to inspect it
>> at all.
>>
>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>> Suggested-by: Michal Luczaj <mhal@rbox.co>
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>> ---
>> V2: Add reproducer steps to commit message.
>> V3: Fix truncated title and add annotations to reproducer steps.
>> V4: Remove sk_err checks from vsock_accept()
>>
>> net/vmw_vsock/af_vsock.c | 13 ++++---------
>> 1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 622dbd046799..594fe27d2ebe 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1847,12 +1847,10 @@ static int vsock_connect(struct socket *sock, 
>> struct sockaddr_unsized *addr,
>>         prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>>     }
>>
>> -    if (sk->sk_err) {
>> -        err = -sk->sk_err;
>> +    err = sock_error(sk);
>> +    if (err) {
>>         sk->sk_state = TCP_CLOSE;
>>         sock->state = SS_UNCONNECTED;
>> -    } else {
>> -        err = 0;
>>     }
>>
>> out_wait:
>> @@ -1893,7 +1891,7 @@ static int vsock_accept(struct socket *sock, 
>> struct socket *newsock,
>>     timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>>
>>     while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>> -           listener->sk_err == 0 && timeout != 0) {
>> +           timeout != 0) {
>>         prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>>         release_sock(listener);
>>         timeout = schedule_timeout(timeout);
>> @@ -1906,11 +1904,8 @@ static int vsock_accept(struct socket *sock, 
>> struct socket *newsock,
>>         }
>>     }
>>
>> -    if (listener->sk_err) {
>> -        err = -listener->sk_err;
>> -    } else if (!connected) {
>> +    if (!connected)
>>         err = -EAGAIN;
>> -    }
>>
>>     if (connected) {
> 
> Can this become an `} else {` ?
> 
> Or just add a `goto out` when setting `err = -EAGAIN`.
> 

I will update it.

>>         sk_acceptq_removed(listener);
> 
>          lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
>          vconnected = vsock_sk(connected);
> 
>          /* If the listener socket has received an error, then we should
>           * reject this socket and return.  Note that we simply mark the
>           * socket rejected, drop our reference, and let the cleanup
>           * function handle the cleanup; the fact that we found it in
>           * the listener's accept queue guarantees that the cleanup
>           * function hasn't run yet.
>           */
>          if (err) {
>              vconnected->rejected = true;
>          } else {
> 
> 
> Should we update this comment too and maybe remove the `if (err)` at
> all. With that change I guess `rejected` is never set at the end and
> maybe we can remove it at all from `struct vsock_sock`.
> 
> Looking at commit d021c344051a ("VSOCK: Introduce VM Sockets") where
> `rejected` was introduced, I can't see any path where sk_err is set on
> a listener socket, so I guess that path was dead since the beginning.
> 

That seems true, let me verify it.

> So now I'm thinking if it's better to split in 2 patches (both with the
> same Fixes tag):
> - Patch 1: "vsock: remove stale sk_err checks from vsock_accept()"
>    Where we can also remove `rejected` since it's never set to true since
>    the beginning
> - Patch 2: "vsock: use sock_error() to consume sk_err after a failed
>    connect"
> 
> WDYT?
> 

Yes, I felt the same when I was writing the commit message, but honestly I
didn't know that I could split it into a series when sending the new 
version.

So, it may contain 3 patches, if the rejected flag can be removed from 
vsock_sock.

Thanks,
Phi

