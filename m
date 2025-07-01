Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3525A33A
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366082; cv=none; b=t+Jw+s4GHuHquukgGgY8IVFEkFdMftYg/It76LsQYZQwu/UgmME1lhBQNGSw0VKp1pRIQINUdRsfD2DvXT1HCZLF0cvKVG660ZEPF8n7vDBAuNRLazb2ET8pOr7ZRq7i4an/PDZOVjNd9ZrBjUWUXOZePzeGxwPyJK+ARvcC+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366082; c=relaxed/simple;
	bh=Mb60PZKCxPrLuQXD+nGMXcS0bI1nvcxKixTXpIJ6UOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D5aK6ZqLsJGp7X/7G2hxnpFY5TEscHCb4L1yL3UjuFKzT5luGZYaQxvwPwC5euICsAUbiazlUGbbWBtis5LONTtHKT4goCjES7l/fwf0qQmNPMKeuIxNXYUR1fjgJGYpyPzcmGebZryOXItPxkIBqilCWMI7XlsOnA6Ims2fY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hbzf7Hh/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hbzf7Hh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751366079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UpDQ5tS+XCWfCgRZS/6IKZjsLJANA+xHzrICS0TndYM=;
	b=Hbzf7Hh/t++fOQQ1P+QTIyNSBusoq8vwWSGR3BCwL+n70V2LZLT+mCiY9Awv7aegVlt/MP
	cHZyArezIGGFb2SipYsC1J081ZHAFO7g3vvT3Ew4D8HE+ikmtWsX/DnAZNdcF2dpy9bg6x
	wgKP6NyouKAViI9ddCFd4gz460RABSU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-5ORzQo8qPiS4NJdwuLruMQ-1; Tue, 01 Jul 2025 06:34:36 -0400
X-MC-Unique: 5ORzQo8qPiS4NJdwuLruMQ-1
X-Mimecast-MFC-AGG-ID: 5ORzQo8qPiS4NJdwuLruMQ_1751366076
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-611956658aaso4291673eaf.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 03:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366076; x=1751970876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpDQ5tS+XCWfCgRZS/6IKZjsLJANA+xHzrICS0TndYM=;
        b=dA5mmUNG89wBjJGwfT4ULm+thgekMbuAkpKE3u3t+kvg8XTeclfzgHZZz+/ccRBrdS
         gt/0uUZJfQOl185cLwk6PSpUm6M16kCwFaUjxpzlG/dfwZchIvwv9+V59H7mnR9JdSe4
         2E3DaSb+uY1ecYXMxmCg73Ys8DLLYRLkitXbZXw9RmFVjapeBMHOkuRZRI7FIHEjd4KL
         Sldhwq3cM1mPc5xCsBFeprhztfIOTDdslFn8JxXwZ0Y2P7UhCeWvyKkyJRr8OlMkaPQO
         kRrxJ672NMMkfG7cR+ZKnVTjpMwY4av4aJPLnEHONN0J7z6B/DGtWjsAY2l9Pkkn8Avk
         JR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw9ZmJzH5dCOlZ7iq+L7a77ExPVH6VDBx/tCy6tshdK8VbMec2Jwpm6O0evARUTjZ8ae/8wQI6jVtAR9j52g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwngGKJ9XqTx2iQ9g6AWdjvMFcwfa8j4JQqbqVQLNpRMZ/4H6F8
	qvun1zfYWd5flwlDcczTBhNxCDMsTst16CaVYasLOiqtSkSwbifyXJf7z7csE9zufNm+rftW/7Y
	9E8LBIwKhDH9f54VP2tg+E3sk7qSmKNWYfR7lQO6s/7KdZ4Z7BUHgtHdRavhbTF7Ge08k
X-Gm-Gg: ASbGncv3smO//UbSV2B/KPapZFDnnM+HxRTY87cqQO7OfW6kB5dgffstYA8bRwnzcM/
	KChkPfQng+PzBne96gr7WJN7dyXZUTAO+nsTqdlDTCvw0+tUpoMsU6S+1JNyGKUA24q05FhnIEF
	QFSEt9YXDh7gzJGpEX8wssw3Vy9PXFAKwljx9GY0TLdb9s+T5UgZcz1tQG4UX1MOjQiYzrL+Ab6
	vAd5v3soYIKX8tCqmvabNeg/8CvFaQeott5DsP3zG8E+X8K/RzQo04IzQChhrjicQId601Jg30l
	LdQEG+JfWZuuA/qbv6sDsI7BP/3g
X-Received: by 2002:a05:6820:994:b0:611:aabf:2b7d with SMTP id 006d021491bc7-611b91b8ba5mr12929320eaf.7.1751366075932;
        Tue, 01 Jul 2025 03:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvOyh3XEeOqocDMGLPkqu+zdtIY+/LP4pPv1rkoavjsw1qeTINbjxyfJNBqMBK5Rn7C+6dEQ==
X-Received: by 2002:a05:6820:994:b0:611:aabf:2b7d with SMTP id 006d021491bc7-611b91b8ba5mr12929286eaf.7.1751366075453;
        Tue, 01 Jul 2025 03:34:35 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.144.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8474da2sm1366811eaf.6.2025.07.01.03.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 03:34:35 -0700 (PDT)
Date: Tue, 1 Jul 2025 12:34:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <fruzxj3ju4nmm3uipuqq3gcn3jh5et4qpnldzsdahfdcachtyl@o3k7lo2gxzyb>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
 <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
 <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
 <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
 <e97b5cae-f6ef-4221-98e1-6efd7fdc6676@rbox.co>
 <4vsrtxs3uttx6w2zyk6rxescpwvrikypiw6tvjheplht6yzonc@ch6k3xlftikw>
 <c39f22fd-9ede-4cdd-956b-29856e9db20a@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c39f22fd-9ede-4cdd-956b-29856e9db20a@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w0L-S-byzyqXI3VAc-AEs_Bu0VwVxKPovR2AgApZVTM_1751366076
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jun 30, 2025 at 01:02:26PM +0200, Michal Luczaj wrote:
>On 6/30/25 11:05, Stefano Garzarella wrote:
>> On Sun, Jun 29, 2025 at 11:26:12PM +0200, Michal Luczaj wrote:
>>> On 6/27/25 10:02, Stefano Garzarella wrote:
>>>> On Wed, Jun 25, 2025 at 11:23:30PM +0200, Michal Luczaj wrote:
>>>>> On 6/25/25 10:43, Stefano Garzarella wrote:
>>>>>> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>>>>>>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>>>>>>> transport_{g2h,h2g} may become NULL after the NULL check.
>>>>>>>
>>>>>>> Introduce vsock_transport_local_cid() to protect from a potential
>>>>>>> null-ptr-deref.
>>>>>>>
>>>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>>>> RIP: 0010:vsock_find_cid+0x47/0x90
>>>>>>> Call Trace:
>>>>>>> __vsock_bind+0x4b2/0x720
>>>>>>> vsock_bind+0x90/0xe0
>>>>>>> __sys_bind+0x14d/0x1e0
>>>>>>> __x64_sys_bind+0x6e/0xc0
>>>>>>> do_syscall_64+0x92/0x1c0
>>>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>>>
>>>>>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>>>>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>>>>>> Call Trace:
>>>>>>> __x64_sys_ioctl+0x12d/0x190
>>>>>>> do_syscall_64+0x92/0x1c0
>>>>>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>>>
>>>>>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>...
>>> Oh, and come to think of it, we don't really need that (easily contended?)
>>> mutex here. Same can be done with RCU. Which should speed up vsock_bind()
>>> -> __vsock_bind() -> vsock_find_cid(), right? This is what I mean, roughly:
>>>
>>> +static u32 vsock_registered_transport_cid(const struct vsock_transport
>>> __rcu **trans_ptr)
>>> +{
>>> +	const struct vsock_transport *transport;
>>> +	u32 cid = VMADDR_CID_ANY;
>>> +
>>> +	rcu_read_lock();
>>> +	transport = rcu_dereference(*trans_ptr);
>>> +	if (transport)
>>> +		cid = transport->get_local_cid();
>>> +	rcu_read_unlock();
>>> +
>>> +	return cid;
>>> +}
>>> ...
>>> @@ -2713,6 +2726,7 @@ void vsock_core_unregister(const struct
>>> vsock_transport *t)
>>> 		transport_local = NULL;
>>>
>>> 	mutex_unlock(&vsock_register_mutex);
>>> +	synchronize_rcu();
>>> }
>>>
>>> I've realized I'm throwing multiple unrelated ideas/questions, so let me
>>> summarise:
>>> 1. Hackish macro can be used to guard against calling
>>> vsock_registered_transport_cid() on a non-static variable.
>>> 2. We can comment the function to add some context and avoid confusion.
>>
>> I'd go with 2.
>
>All right, will do.
>
>>> 3. Instead of taking mutex in vsock_registered_transport_cid() we can use RCU.
>>
>> Since the vsock_bind() is not in the hot path, maybe a mutex is fine.
>> WDYT?
>
>I wrote a benchmark that attempts (and fails due to a non-existing CID) to
>bind() 100s of vsocks in multiple threads. `perf lock con` shows that this
>mutex is contended, and things are slowed down by 100+% compared with RCU
>approach. Which makes sense: every explicit vsock bind() across the whole
>system would need to acquire the mutex. And now we're also taking the same
>mutex in vsock_assign_transport(), i.e. during connect(). But maybe such
>stress testing is just unrealistic, I really don't know.
>

I still don't think it's a hot path to optimize, but I'm not totally 
against it. If you want to do it though, I would say do it in a separate 
patch.

Thanks,
Stefano

