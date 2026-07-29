Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69698488DA4
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331289; cv=none; b=Ao7UXbfzgmv4KtyGl9tiHk2RteF5QyGHQv4n9Y2f/aj6bsSBBueX55z5PWNTkl2LoVaD5krK1XbZ8oxyNIFEZ6mR+KNIrQyIYCJ1Yy0NK2xn3LwhucWGgt8y1WxxrZyH4ZNt977McU0WQ1/s9iXwgvScnhnEj5LVxnnyZg1+QOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331289; c=relaxed/simple;
	bh=ka58tVVi6SsAum83Mc6DSFOiJ7ycJ9uJth8uHFgmOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HL/WrVvv/it1966x5PGyMUnTGS0w6ulPPT92M0vfpFEsBINDzydNFocZNbnVIL+uPf4ffw/tKNWncoEpumQegcd0LcdIP/z6FppmBI0g+RfoumIhg4i/3uSBpsxDOIhLQyZF3QweKp/RdcMpvZf5QrrABEg2ae1v8JD3A+6VfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVpUsVhB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVpUsVhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785331285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0xXJHq60WPbuKjp5vgLyMqWjsr1ek6nh2vuXCicWE8=;
	b=ZVpUsVhBzALriJrjtq4yvMQx77yVUwy/Pkkb8VpUPOndBbw02LO4Eb3FNx1DlFqKOEWpdx
	fi7Vs85gqiDZAFhVxnkZ3r4xAlBLD7olWv1OjrIa5UCNm9DcxrcY5TuJ5awV75lUiqwz2n
	faamjeeGcjqhbwWC7X9r9V8xqFMuLC4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-RMMjgh9wOmGtZ3oON5Dj3A-1; Wed, 29 Jul 2026 09:21:23 -0400
X-MC-Unique: RMMjgh9wOmGtZ3oON5Dj3A-1
X-Mimecast-MFC-AGG-ID: RMMjgh9wOmGtZ3oON5Dj3A_1785331283
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496b408a5c0so5436285e9.0
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 06:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785331283; x=1785936083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u0xXJHq60WPbuKjp5vgLyMqWjsr1ek6nh2vuXCicWE8=;
        b=axNitMZ8tiCPnAFZOYEpUZrhyaDx+LJZOOFY9PHe/P4i7JvexrzvUoS4oiwpG80bvJ
         o5ox6xwdRPTzdCjE0i6sQsMTFqq6aPVHTpjTlvyEcmqcHaSKGej03vILnfjO44okR31O
         xfXq/TVVMqwfOi/KElsrYYQ+jqsBa9MSQKV2MpuGNXIOOhYRY2skOEjNPOu1tIU6MDYG
         5if+lxyZeXS5zGNw6hgQLImQrAD4HCzEvYn/+Ocv5s7Gtn2FMInqVvHXIBT9mSXhhFNA
         Fi9mzsfK4ybSPqv1I5XaE8tF+cnkcdwuVZGOGrYoreMEfiHJIKS+vVKk2jwH66qWnyhQ
         n9Qg==
X-Forwarded-Encrypted: i=1; AHgh+RpOBHCH8ZIek0UY1jEHnA3SEwA0PFZvAQHkK/ArjaodQhjv0lOcHrB45aU79hRxl3z3Egw0X0F+Jp/Ug9sCEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZMsHfSzpevP9K1757X1ev98yaXSSJ6HEHh6UuY6lbtvQiwxhR
	ph7UV+TQ7Tc1HkZmpV5BBDEKjx9IWQ6LgAYDr+lmHION/jpCzojj8Bzkkm0WM6GZCzUIbSdgQqu
	AO7RzTfVGYxWp2o3vaGdnUIVQplY7WZ4d+Ab0TW4GciDvMOgJsVq76Ko+YzSudonnvDjX
X-Gm-Gg: AR+sD11WB23z0YWiFv0OE+ZwiCg+GHApaiFjoV42vtuDPfhqCskLRc+UPVtgcOSV51r
	QhyaPT+pHRzVwyBRuexcipLhSQ64eKq1KIdXyFlkKe3YL8xNYN+OgwYmTDOXrcJ6j99FAdJmva1
	QLTkKzCEGVYyurDJBfJz3rPiR3Dnq8dkD6VwM4wuUd199ztFEWdGbYNym4oMTFeHeDoy0rt8ilx
	zW+dNXzmPzo9cKdD+/8t1jBxmGA2i0yXEn0WJU5VKxb2jhbYNJhqlwegDop7hpf7vR/EMJmFtGK
	rrGEqS47dP42xJomFr1zWrwCXY9huQGrhD3IfmK7PsmTN9AEohWLhzVurAar+rZ70fYIEWNPNT+
	v7AJUYw+LVwu6vVqWrvOlHQjHww+EjC72N84By7XwKYQ=
X-Received: by 2002:a05:600c:3b86:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-496c658eed1mr81575965e9.25.1785331282479;
        Wed, 29 Jul 2026 06:21:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3b86:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-496c658eed1mr81575535e9.25.1785331281888;
        Wed, 29 Jul 2026 06:21:21 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b18a9fsm7167683f8f.32.2026.07.29.06.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:21:21 -0700 (PDT)
Date: Wed, 29 Jul 2026 15:21:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: mawupeng <mawupeng1@huawei.com>
Cc: phind.uet@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, acking@vmware.com, 
	dtor@vmware.com, georgezhang@vmware.com, 
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vsock: use sock_error() to consume sk_err after a
Message-ID: <amn9-HWi5L8DlXy5@sgarzare-redhat>
References: <20260727071305.45826-1-phind.uet@gmail.com>
 <33c73960-a44c-44e4-bfba-c4ebe85b336c@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <33c73960-a44c-44e4-bfba-c4ebe85b336c@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rw9q_5aHLGd_xZYy-u3gcjRG51S0xLVG0V_taOu1_Ys_1785331283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026 at 11:14:31AM +0800, mawupeng wrote:
>
>
>On 周一 2026-7-27 15:13, phind.uet@gmail.com wrote:
>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>
>> Syzbot report an issue which can be reproduced with these steps:
>>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    bind(r0, {VMADDR_CID_ANY, PORT})
>>    connect(r0, {VMADDR_CID_LOCAL, PORT})
>>    listen(r0, backlog)
>>
>>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>    connect(r1, {VMADDR_CID_LOCAL, PORT})
>>    connect(r0 -> self) -> -1, EPROTO
>>
>>    listen(r0)          -> 0
>>    connect(r1 -> r0)   -> 0
>>    accept(r0)          -> -1, EPROTO
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
>
>Thanks for your patch.
>
>Test-by: Wupeng Ma <mawupeng1@huawei.com>

Thanks for testing, just a note, the right tag should be Tested-by:

Anyway, @Phi can you bring this with the right tag to the v3 if the code 
will not change?

Thanks,
Stefano

