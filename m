Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB163955C8
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703080; cv=none; b=RmyyHmgUcCeacIFJ5SfN6Iz8Jut0jvH3zoCoEUPaLUr7RsJotnbz39+hULa4+6tJpIN8GybpFR5dlFIzISy5dYxkAszz+aAmHJR30hMytxM4Qc3LKGqgTh8YzUM2325yujcYVEJgeoGVfNnlG3a9HEv4+rll/Kt63gEATl/TKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703080; c=relaxed/simple;
	bh=uK/vt7eLnOx5l8lJnbIVpEjTM2YvSAf8nXV0EaVRzsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UO8GZgfPiW0VPlSUaqGAy2lxJuQ+gcRUyxAz5+K5MZw97e7JWr3jr5PRcygQjsmYCmO72MHp9Mnh2dm+2YtSRhB3R+U0OAN1HiGqB1EGg+T6tn1DCpRxhcD6cJ9H5+QLmIBupLGZQyXNZYs2zsJugANK/PP/t36hZV5NMUaY3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Az1LV/CU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Az1LV/CU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779703077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
	b=Az1LV/CU70xT/auOthh/c4+7ns967wk7FFRsQU9kEoVuw1z3JMABeJzPqohSwEbUh8phQs
	Y6wQ0ArccV8aCVS6kAu74the80x7QkCW3tEtn2A27hCS4qQMkCUU5zwYEL8sHDfSiAJmfM
	QqQCC03HOzHaoOg7CepENeDesNxvRU8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-d0_py-YqNmu0VkNXsPs36w-1; Mon, 25 May 2026 05:57:56 -0400
X-MC-Unique: d0_py-YqNmu0VkNXsPs36w-1
X-Mimecast-MFC-AGG-ID: d0_py-YqNmu0VkNXsPs36w_1779703075
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49051422d55so17006665e9.2
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 02:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779703075; x=1780307875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
        b=KKLnU9x5wIMD4VRFtKakE8N2KQgP/32INpLaTomEnNfR0KOTdCy694bvn1bVLDQ+7y
         PTrR/bnso5PJNoL7XwuZjJpMHOfmwQKvGZk8ZEydVBof5SYPyRSzaMICXieOIzSON0dm
         9jlkvbXDHCRwv9nmkqOJ4Q8dym291crbyrn/f0E4SsYzk5GRkkxwvkk2scqAtrLH6lE0
         xlP0kg0mD23U0yoZQGtEOC8AKgMe9uPfaqBQcZO+I9aXDmS1O1ILRL6Jt0OGgYREZrIR
         7Bn/A5TGORFNVohTz0uwVERn56SKWWV2zBAuO9YJX35Ge4DXGYIe4Qyx6Sqkq+OKuI0b
         P/0w==
X-Forwarded-Encrypted: i=1; AFNElJ+zaqV9mU7nveQsO5R8u5xIJha8IhIeSd+GQb2krRvIamFpZAxurEr3fP1ims452diX/nSJ4+QzcfigOmu/dA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ7AaFCHnuwN5XpsWc5WAL7qR/IoqEjJx1u7mvHm1h2kGtJ0Gp
	+RYOUQAHuysjbDFHVNA7OFQjYyhDDe4UWik4gEzJMH5hrWgILRcuOZUzg6PePb/GbTcKYxAnnVl
	A8BtSiMPuQdNG2+FJaM5z9ph9NJSgrtl0EzReH1XYteNchsmx8vsmANX4b7LAglSLXVWl
X-Gm-Gg: Acq92OGTFx9lnnIRAbZ/k4tlRjf8FtGgaHd/6GLB82GA1011whPGBeFRlTw9uzcjxsI
	jW0u6Rk2Nz3rzcS1HHSBP9K1rv4qZ3Gl68z+hZFge42IKU5yvTnIkQ8AyfPw8WvM0KgUXzu31h8
	AVxzMYlN4YOTYOTzb/gB1ULtosHMC8PsWtdmTc8RrZd4AIUj+WpFJgajVOxV641VqYw6zPVReD3
	oRabimi36tXJQwTB6TGzXPDhWStVUYWqnPuedWa51xX0Spba0MFKivrkQcfO6pEqStaY7L4USi+
	6cxY1R1z9n7/Y7U4OF3AfAGcn7k7wTA9quTsy4qoLOAUmGQYPC1uggxWOA4UEKo+3PQmbTFfY9S
	mkaJyBkdgym3iaI5BtHwHpdFKA3O4rD4VE735P3zJMddP3R76o9fcaKPxV5X22Y1E+zTQiKM5f6
	OWEAfM7g==
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id 5b1f17b1804b1-490482c44ddmr216835785e9.24.1779703075151;
        Mon, 25 May 2026 02:57:55 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id 5b1f17b1804b1-490482c44ddmr216835185e9.24.1779703074518;
        Mon, 25 May 2026 02:57:54 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490417b0680sm83957175e9.8.2026.05.25.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:57:53 -0700 (PDT)
Date: Mon, 25 May 2026 11:57:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, horms@kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, 
	pabeni@redhat.com, mst@redhat.com, davem@davemloft.net, jasowang@redhat.com, 
	stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260523173557.5cc4f4f6@pumpkin>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tWjN6JmR6wj3lMaLbPZ0fYq3EozFgoJzIdyHV_FzMj4_1779703075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>On Sat, 23 May 2026 02:20:29 +0000
>patchwork-bot+netdevbpf@kernel.org wrote:
>
>> Hello:
>>
>> This patch was applied to netdev/net.git (main)
>> by Jakub Kicinski <kuba@kernel.org>:
>
>Did anyone else notice that is isn't a bug?
>
>There is no way that a 'count of bytes of kernel memory' can overflow
>the size of 'long'.

It's more of an estimate than an actual calculation of memory usage if 
we queue the incoming packet. In theory, an overflow could occur if the 
user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
the memory should run out before we get to that check.

Thanks,
Stefano

>
>-- David
>
>>
>> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
>> > From: Stefano Garzarella <sgarzare@redhat.com>
>> >
>> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
>> > to 32-bit values. The multiplication can overflow before being assigned to
>> > the u64 skb_overhead variable, making the skb overhead check ineffective.
>> >
>> > Cast skb_queue_len() to u64 so the multiplication is always performed in
>> > 64-bit arithmetic.
>> >
>> > [...]
>>
>> Here is the summary with links:
>>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>>     https://git.kernel.org/netdev/net/c/4157501b9a8f
>>
>> You are awesome, thank you!
>

