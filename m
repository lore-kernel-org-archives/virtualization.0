Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B02E5429
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021085; cv=none; b=LqF/MAXUtRhKlTN9+HoTOQacSxwuucnjOSkWtQZCB/FnrMOpokvrqvkYidBwY7yqoZ0wBEnGd3H5lyb/wgkwR262ucn31MIlJPX11bm61xOrYDivZC8HLVV9p+pG69Xlk8lbk6qjxgNciGghMa2tpeVR3WaY+YRSKWk9GkhJr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021085; c=relaxed/simple;
	bh=3al0HDOqY9ebkA4EOMVEdKxXeaHy538zLs06SWOiaj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YG+SpYpNN7Z6UJ+o53M50awIcwz+b50sCk2RFXsNaYOCmJbMALn2bKERwTfrgQkip7xk+N6SJIkXZL+oDDdjKDmWLxWnWoD8TAp3oa1TvjA+VodjO7hEhQ4iQbM2EdX1uquRpmXDejEOkFrbcn5gBwwBK/B4XXx7ESGDHapoeYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D147exLe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D147exLe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786021082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kbOMQBVAhPddh1fc9S9hVBoJE1QXhrm/1cN6yecgL4=;
	b=D147exLeR98CAyti34wU4xjvE/Gpt6yzy3tzQ2RYbjMwiV6g1u691j5jGCSE/d1gTSGNqu
	7oFa3CkX6uT+Grt5lXCciEAXsHYn5BYA+5R1URE3Xm2LDG7eAFlvIUo00fOxacVUVy9nHk
	xWMDUTIzWzcWXkx9bDagnbtF9e9t3sE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-QKfzw0gtOxye3A4hqfNLwA-1; Thu, 06 Aug 2026 08:57:59 -0400
X-MC-Unique: QKfzw0gtOxye3A4hqfNLwA-1
X-Mimecast-MFC-AGG-ID: QKfzw0gtOxye3A4hqfNLwA_1786021078
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f8398ed9fso1690096f8f.0
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 05:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021078; x=1786625878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6kbOMQBVAhPddh1fc9S9hVBoJE1QXhrm/1cN6yecgL4=;
        b=S3HfkcxkUn4ni0kR4OHfGpLLSAmam4/x4QMjmhK/OswbON7FQrcbCOZHlFeXJ9mwjm
         NU1F3AngMf/C0orEUzXHWVarBeeDOaCp1k2k4aF3mbwIQTD/ZnmgJ/b49YthEeIAIdqv
         Lo/ocqwLHXdSvPLMhP8QaC+C9mDaFUMtD3bknoV3B6AgMA8WSL24OGDyY/SxxvK7lvlN
         V3vc/GfJkBtlPzuXaUJZAVsMZb/iwaV4t4wZTnbV0TXPPqZTk0CWP4M188HK5+Cu1PEl
         eavjItoP2MaKANCRjCkTuJGn8kNMvER6AVcKd7L8if8nCk/GyOSebDRj5fIPTFNcwWs7
         GK7g==
X-Forwarded-Encrypted: i=1; AHgh+RqhDW73iKlCcuS5Ygm38LNskmsVgDNxQTzJQjBEXUFil8B9kVArlVd2NNQGw63VFBkdj4QTd/hEHuQ5PTsaIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrRC0H6k9rtyRKXNMGSixyXowPCOE1d9g21lesttyCv7cpbzi1
	9MCEPbWBt4SE/TG35Q39Vy+DKGXzub2JDwZfJvw/ATPMQL4EX55oJnb5/bZMCcxhTiPEV7YkiY8
	gc6RzmAelgrhELFsEON1BgUL1nEc7hgR4sGzHBdyLQM4HroHrmoraeSZurZ1gIWglE5sC
X-Gm-Gg: AR+sD10L5YBMmdrxTLf6n4cuA4eu8BW87NzViCCgY5ELEHjBEsNYj1Or8/GjuTz2Ok3
	3nFdXLLlpUg8kFiXekhZVkKjmbmdv1D+jem6gU3eT1BBCAxxlr7v8if21GQUlS4unieSHLTYxdY
	2kP0l8RtwwNXPqKVQk6UibXPMOpm2MaeiBPh6sOGCvl28+bvkTQGcc33ph8TAg8tBxlnPHk1q93
	ab8C64vAPJ9qDmnb7RErz9NBdgaaKLPWbN9fNkzm1lZpLziAaf0xsJgaX7xaWr43b1nzAypavAG
	Cbq3w7PSuStXNjI9Omdcx7ikmsLyWAZhRIsrFLE3Z1IJQ7jfN4OuMpHMCQ8hC8D8vvpi11TM2DU
	DBTA=
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr185171345e9.6.1786021078281;
        Thu, 06 Aug 2026 05:57:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr185170495e9.6.1786021077713;
        Thu, 06 Aug 2026 05:57:57 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954206d9dsm70070355e9.2.2026.08.06.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:57:56 -0700 (PDT)
Date: Thu, 6 Aug 2026 14:57:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Michal Luczaj <mhal@rbox.co>, Wupeng Ma <mawupeng1@huawei.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <anSEfl9bG6HjlMpz@sgarzare-redhat>
References: <20260804135238.386417-1-phind.uet@gmail.com>
 <anLuRE4ix5-BZ7-t@sgarzare-redhat>
 <b64dde64-8ae0-4b97-bd65-14da8d9cb5eb@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b64dde64-8ae0-4b97-bd65-14da8d9cb5eb@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LY65q1XU_uBlQO7HhZEV0G0GuYbJNI8eBqYMV-Bl9js_1786021078
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Aug 05, 2026 at 06:29:36PM +0800, Nguyen Dinh Phi [SG] wrote:
>On 5/8/26 16:34, Stefano Garzarella wrote:
>>On Tue, Aug 04, 2026 at 09:52:36PM +0800, phind.uet@gmail.com wrote:
>>>From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>
>>>Syzbot reported an issue which can be reproduced with these steps:
>>>
>>>  r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>>  bind(r0, {VMADDR_CID_ANY, PORT})
>>>  connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>>>  listen(r0, backlog)                     -> 0
>>>  r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>>  connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>>>  accept(r0)                              -> -1, EPROTO  (stale sk_err)
>>>
>>>Basically, it creates a socket (r0) and triggers a self-connect after
>>>binding it. This self-connect fails with EPROTO because it loops back to
>>>r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>>>incorrectly dispatched to the connecting-client path. The unexpected
>>>packet type encountered there sets sk_err to EPROTO.
>>>
>>>After that, it invokes a listen() call on the same socket. This listen()
>>>call succeeds because the kernel's listening path never inspects or
>>>clears sk_err. Then, a new socket (r1) is created as a normal client and
>>>connects to r0. However, vsock_accept() rejects this incoming connection
>>>because the listener's sk_err still holds the EPROTO error from the
>>>earlier failed self-connect.
>>>
>>>This rejection causes the child socket created for r1's connection to
>>>never be freed on virtio or hyperv transports; only the VMCI transport
>>>implements pending_work to revisit and clean up a rejected socket.
>>>
>>>Fix the issue in blocking connect() by using sock_error() to read the
>>>sk_err to prevent the rejection branch from occurring in this scenario.
>>>
>>>sock_error() atomically reads and clears sk_err, ensuring the error is
>>>consumed when vsock_connect() returns and cannot affect subsequent
>>>operations on the same socket. This matches the established pattern
>>>used by other protocol connect() implementations in the network
>>>stack like __inet_stream_connect(), tipc_wait_for_connect()...
>>>
>>>For non-blocking connection, vsock_connect_timeout() may set
>>>sk->sk_err after vsock_connect() has returned. To handle it, we also
>>>remove the sk_err checks from vsock_accept(). Nothing in vsock sets
>>>sk_err on a listening socket, so accept() has no reason to inspect it
>>>at all.
>>>
>>>Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>>>Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>>>Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>>>Suggested-by: Michal Luczaj <mhal@rbox.co>
>>>Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>>>---
>>>V2: Add reproducer steps to commit message.
>>>V3: Fix truncated title and add annotations to reproducer steps.
>>>V4: Remove sk_err checks from vsock_accept()
>>>
>>>net/vmw_vsock/af_vsock.c | 13 ++++---------
>>>1 file changed, 4 insertions(+), 9 deletions(-)
>>>
>>>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>index 622dbd046799..594fe27d2ebe 100644
>>>--- a/net/vmw_vsock/af_vsock.c
>>>+++ b/net/vmw_vsock/af_vsock.c
>>>@@ -1847,12 +1847,10 @@ static int vsock_connect(struct socket *sock, 
>>>struct sockaddr_unsized *addr,
>>>        prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>>>    }
>>>
>>>-    if (sk->sk_err) {
>>>-        err = -sk->sk_err;
>>>+    err = sock_error(sk);
>>>+    if (err) {
>>>        sk->sk_state = TCP_CLOSE;
>>>        sock->state = SS_UNCONNECTED;
>>>-    } else {
>>>-        err = 0;
>>>    }
>>>
>>>out_wait:
>>>@@ -1893,7 +1891,7 @@ static int vsock_accept(struct socket *sock, 
>>>struct socket *newsock,
>>>    timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
>>>
>>>    while ((connected = vsock_dequeue_accept(listener)) == NULL &&
>>>-           listener->sk_err == 0 && timeout != 0) {
>>>+           timeout != 0) {
>>>        prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
>>>        release_sock(listener);
>>>        timeout = schedule_timeout(timeout);
>>>@@ -1906,11 +1904,8 @@ static int vsock_accept(struct socket 
>>>*sock, struct socket *newsock,
>>>        }
>>>    }
>>>
>>>-    if (listener->sk_err) {
>>>-        err = -listener->sk_err;
>>>-    } else if (!connected) {
>>>+    if (!connected)
>>>        err = -EAGAIN;
>>>-    }
>>>
>>>    if (connected) {
>>
>>Can this become an `} else {` ?
>>
>>Or just add a `goto out` when setting `err = -EAGAIN`.
>>
>
>I will update it.
>
>>>        sk_acceptq_removed(listener);
>>
>>         lock_sock_nested(connected, SINGLE_DEPTH_NESTING);
>>         vconnected = vsock_sk(connected);
>>
>>         /* If the listener socket has received an error, then we should
>>          * reject this socket and return.  Note that we simply mark the
>>          * socket rejected, drop our reference, and let the cleanup
>>          * function handle the cleanup; the fact that we found it in
>>          * the listener's accept queue guarantees that the cleanup
>>          * function hasn't run yet.
>>          */
>>         if (err) {
>>             vconnected->rejected = true;
>>         } else {
>>
>>
>>Should we update this comment too and maybe remove the `if (err)` at
>>all. With that change I guess `rejected` is never set at the end and
>>maybe we can remove it at all from `struct vsock_sock`.
>>
>>Looking at commit d021c344051a ("VSOCK: Introduce VM Sockets") where
>>`rejected` was introduced, I can't see any path where sk_err is set on
>>a listener socket, so I guess that path was dead since the beginning.
>>
>
>That seems true, let me verify it.
>
>>So now I'm thinking if it's better to split in 2 patches (both with the
>>same Fixes tag):
>>- Patch 1: "vsock: remove stale sk_err checks from vsock_accept()"
>>   Where we can also remove `rejected` since it's never set to true since
>>   the beginning
>>- Patch 2: "vsock: use sock_error() to consume sk_err after a failed
>>   connect"
>>
>>WDYT?
>>
>
>Yes, I felt the same when I was writing the commit message, but honestly I
>didn't know that I could split it into a series when sending the new 
>version.
>
>So, it may contain 3 patches, if the rejected flag can be removed from 
>vsock_sock.

Yeah, or including the rejected flag removal in the patch 1 I suggested.

Up to you.

Thanks,
Stefano

