Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BE9430CC1
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836274; cv=none; b=CHannR/Ta9ZFQHEdUD/6JwVbKecDJVYRCOaz6Yg1QitfkoedY8P4tcdTPzAfPB9sz0EWiEyXkqU+uKBVwsI5e9UHT888Qqqh8/8xKLXqWsbRlPtkxvfAYkueRYne+i4itAdM09tWmeFYFO3PQKx26WfTjx0K7pBGxYkIzsu8KGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836274; c=relaxed/simple;
	bh=YHCzNxOR8vzG0iWXONmBMTdnogbrhp36qxhg1+Egca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JUc82xvtt/Mtn+qTJCe7JcEjjK/odwZ6o040FatztcKqlRvyiw6aSyKKPBI/zku/s+1+MePck0VO38niIS39QARxzfKorUXJ+f4oscZJBIuSlPcn5njQvNJ3t2MVU/Yx9T/y3yLSY8Sv/om67UakjJ1b3vycIgYXcUcDNSDEISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dnC7WCdL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnC7WCdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785836269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EM7xpqXAUJNazCozbweIvpU+TjAspQcIOmydlbjLiPo=;
	b=dnC7WCdL6EEIS6Bnp5Ns6N94jQVqLoOnQoio+6kqe1YYE/ZQ/fLqYM7tYjLhb60uyk0VwB
	qi9zoJ7VrkPdsPMdSrrnLhcRhD0d6mkNOsoQ58oMPUaEq18jFYIBbWCND0vLBn6ac22ijQ
	5epmCe0vp64jLGL8Q5DBkqgLybTd+Qs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-McEXS8SuNF6gyd6TYseCzA-1; Tue, 04 Aug 2026 05:37:48 -0400
X-MC-Unique: McEXS8SuNF6gyd6TYseCzA-1
X-Mimecast-MFC-AGG-ID: McEXS8SuNF6gyd6TYseCzA_1785836267
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493a7fa8481so4170165e9.1
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 02:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785836267; x=1786441067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EM7xpqXAUJNazCozbweIvpU+TjAspQcIOmydlbjLiPo=;
        b=kkMCuDzgJEf6hPzOSRhqMpPHQlNZMBVVo1NxwaOjBo11z4/oGC2kuTBKhm+xXa5GGF
         FFOTxg9F1ZOU4ErlttEO2n6P+Z42mNoHVsFbkXt/cfVdXTs4fUlkh+hbntsV5oRRfUtW
         J5GJBq2bv5VbU84gYikWBCr4bTL3V8pLSIQk3cwJwPJRziunFPUarJzaODFwdz2mglrP
         iEcr8I2DU6DF37TLNPbZbBSpAklU0b8Ssv2Q57NC1wPNXHcV+A4JeQ7rjKNfjVt+li8X
         4uFQH8pAgRPuYiStl+kww+lCm1WFlDWfQaqwndSzaWAimvuXE9CMryrzylOr7z59Ngbe
         4Uag==
X-Forwarded-Encrypted: i=1; AHgh+RqXvgiLPjFpKsFt+6xWvMGmAlr9Vmf75+igufGQClEPIkFodfJ0Y9H/nNPuM+hB9eJNOFWQtkw0eiSdfZh+Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0nNQqhllB9/YWrP/4CyySSJ6FlPX05r1rJ+JsY7bamNfZ8Y2d
	RiqlFX32DwowDEXl1VNZ0/0khmePqNRxhzkEA7J91fdwPdVfFsvVK3xsoE5elFn3fMiX854pr7Y
	7YpIfqxIGgFiMGGY10tgSlpK+QHsY7eI36HBkrmiDC75a0E4jnmSA1n27puRZgvw6/qGH
X-Gm-Gg: AR+sD13g1RQ1lHwJ+ihkaJUzxlTvyIVhxW6cBvRSvHTNHFv7xC6+/b4MyQ+afc9XZ04
	1nteP6fbNgV/2WTNENykeai98BVqoCyP4AI6osRqueAyXmlbvG38/XM3MlSIjpVFXPD5R4O8Nr7
	VCyhuHnJVxSIDhDZmHZEzCSljNoS8LiH0tz5Wo3nwMzUy4AG1ZmqCTtejskbcCtYscG6utx51HK
	YWv/h1zVOhInoP+VokgYShcUB3W8a626xl0pDBgRgB4u06rvyDVsY17WC+nEC2uSCaTs2tVVXu1
	gCPT+c07Wcz+MBiBODYb4cooLUQ/6OP0OgsB4deLO5ySaV+1RQ6DVN3e4cM06nmNi+4FI3Gas2o
	ZVk8=
X-Received: by 2002:a7b:ce08:0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49949f89850mr56639005e9.0.1785836267199;
        Tue, 04 Aug 2026 02:37:47 -0700 (PDT)
X-Received: by 2002:a7b:ce08:0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49949f89850mr56638165e9.0.1785836266578;
        Tue, 04 Aug 2026 02:37:46 -0700 (PDT)
Received: from sgarzare-redhat ([5.11.104.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec606sm86248365e9.14.2026.08.04.02.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 02:37:45 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:37:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: phind.uet@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, Wupeng Ma <mawupeng1@huawei.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vsock: use sock_error() to consume sk_err after a
 failed connect
Message-ID: <anGyP3hBQfO0I1Pe@sgarzare-redhat>
References: <20260730081843.287563-1-phind.uet@gmail.com>
 <6a2958d9-5d16-404a-ac02-21940e90162d@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6a2958d9-5d16-404a-ac02-21940e90162d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7bGT1n8ihAT90LaDxHbz9O_9f4hTb-orYfXSLheAa1Q_1785836267
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Aug 04, 2026 at 11:26:57AM +0200, Paolo Abeni wrote:
>
>
>On 7/30/26 10:18 AM, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> Syzbot report an issue which can be reproduced with these steps:
>>
>>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    bind(r0, {VMADDR_CID_ANY, PORT})
>>    connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>>    listen(r0, backlog)                     -> 0
>>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>>    accept(r0)                              -> -1, EPROTO  (stale sk_err)
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
>> implements pending_work to revisit and clean up a rejected socket
>>
>> Fix the issue by using sock_error() to read the sk_err to prevent the
>> rejection branch from occurring  in this scenario.
>>
>> sock_error() atomically reads and clears sk_err, ensuring the error is
>> consumed when vsock_connect() returns and cannot affect subsequent
>> operations on the same socket. This matches the established pattern
>> used by other protocol connect() implementations in the network
>> stack like __inet_stream_connect(), tipc_wait_for_connect()...
>>
>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>> Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>Sashiko nipa points out that the race still exits:
>
>https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730081843.287563-1-phind.uet%40gmail.com

Yeah, it seems the same conclusion we reached with Michal on v1 and Phi 
agreed on: https://lore.kernel.org/netdev/148e56ec-dc26-4be2-a7af-eb547b517a68@gmail.com/

Not sure why sk_err check was not removed in vsock_accept.

Phi can you check?

Thanks,
Stefano

