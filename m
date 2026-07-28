Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293F30DD22
	for <virtualization@lists.linux.dev>; Tue, 28 Jul 2026 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208485; cv=none; b=snmqSgbXGfrk/0npk5ec/w5Y9vf3jasxM3jxz3zM7cHZr16HXzFJ7kFStoZKovh2F88CgQ5wsRx7EzcI1VAAmQGLPlPLOG5vJYNEWwHMXHFqCvfmhoU1OcysNuPPT1A6Iw9MbnBXIWmibc1MlZuClzfae1gwL2B+TNslM1fnTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208485; c=relaxed/simple;
	bh=Hr9MdE3yPeYMfEsJoOVBj8Zf+bkMu+OEQj/3CA31Fy0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YtzQTTa/JCR7719cUKnNZsaVXmPv3dCDXbY8ksAlogQ1Arp7kS6USX8cDkaWaTEvO3InSW6hIxV/J6mtf0iiCGFNQmNPgmSOkaiMfmxFMSJ4Q7O0Hj4J03Gf8h/3gjm3uWHX90th5NbsHsVSvGQlJTG3iN+3BpmjGPO1VV++GRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=s1y6RsRx; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="s1y6RsRx"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NKqJqnEUks+bFCAzYrBBqP37Ak/ti4svSTzmdrcM4J4=;
	b=s1y6RsRxnhOSVGY/CQNfofAGAywFvuYyvIyyy8eK3+qQZjQv0YRQ+duMYoZJ132bWbjmgfYja
	kcc1X2OZF9n/+pwOoCcqsBnQ3mgBEKW1z2WZXrDR0B3AW82xVgJmMQDMpl+3FjhxfvX80m9mYbG
	Sbz2YvBvvoZjNFWNxgnSBQM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h8L1J1nZSz1cySc;
	Tue, 28 Jul 2026 11:05:08 +0800 (CST)
Received: from kwepemj100016.china.huawei.com (unknown [7.202.194.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AC134057C;
	Tue, 28 Jul 2026 11:14:33 +0800 (CST)
Received: from [10.174.177.15] (10.174.177.15) by
 kwepemj100016.china.huawei.com (7.202.194.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 28 Jul 2026 11:14:31 +0800
Message-ID: <33c73960-a44c-44e4-bfba-c4ebe85b336c@huawei.com>
Date: Tue, 28 Jul 2026 11:14:31 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <mawupeng1@huawei.com>,
	<syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com>,
	<virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] vsock: use sock_error() to consume sk_err after a
To: <phind.uet@gmail.com>, <sgarzare@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <acking@vmware.com>, <dtor@vmware.com>,
	<georgezhang@vmware.com>
References: <20260727071305.45826-1-phind.uet@gmail.com>
From: mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20260727071305.45826-1-phind.uet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100016.china.huawei.com (7.202.194.10)



On 周一 2026-7-27 15:13, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Syzbot report an issue which can be reproduced with these steps:
>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>    bind(r0, {VMADDR_CID_ANY, PORT})
>    connect(r0, {VMADDR_CID_LOCAL, PORT})
>    listen(r0, backlog)
> 
>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>    connect(r1, {VMADDR_CID_LOCAL, PORT})
>    connect(r0 -> self) -> -1, EPROTO
>   
>    listen(r0)          -> 0
>    connect(r1 -> r0)   -> 0
>    accept(r0)          -> -1, EPROTO
> 
> Basically, it creates a socket (r0) and triggers a self-connect after
> binding it. This self-connect fails with EPROTO because it loops back to
> r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
> incorrectly dispatched to the connecting-client path. The unexpected
> packet type encountered there sets sk_err to EPROTO.
> 
> After that, it invokes a listen() call on the same socket. This listen()
> call succeeds because the kernel's listening path never inspects or
> clears sk_err. Then, a new socket (r1) is created as a normal client and
> connects to r0. However, vsock_accept() rejects this incoming connection
> because the listener's sk_err still holds the EPROTO error from the
> earlier failed self-connect.
> 
> This rejection causes the child socket created for r1's connection to
> never be freed on virtio or hyperv transports; only the VMCI transport
> implements pending_work to revisit and clean up a rejected socket
> 
> Fix the issue by using sock_error() to read the sk_err to prevent the
> rejection branch from occurring  in this scenario.
> 
> sock_error() atomically reads and clears sk_err, ensuring the error is
> consumed when vsock_connect() returns and cannot affect subsequent
> operations on the same socket. This matches the established pattern
> used by other protocol connect() implementations in the network
> stack like __inet_stream_connect(), tipc_wait_for_connect()...
> 
> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>

Thanks for your patch.

Test-by: Wupeng Ma <mawupeng1@huawei.com>

> ---
> V2: Add reproducer steps to commit message.
> 
>  net/vmw_vsock/af_vsock.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 622dbd046799..43eddc33ed12 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1847,14 +1847,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>  	}
>  
> -	if (sk->sk_err) {
> -		err = -sk->sk_err;
> +	err = sock_error(sk);
> +	if (err) {
>  		sk->sk_state = TCP_CLOSE;
>  		sock->state = SS_UNCONNECTED;
> -	} else {
> -		err = 0;
>  	}
> -
>  out_wait:
>  	finish_wait(sk_sleep(sk), &wait);
>  out:

