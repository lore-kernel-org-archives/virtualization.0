Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA422F169
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766323; cv=none; b=F+UwrTtJ/dUXs5eR9UnMwfoaEMdULU4LmUOXr/QeeLOJDmADZUuFbh0nY7fMGQlAHeVrUhJxZnCCPQS6QG5GeM79JiQbbYgqO64TnTMgxMkUZJfVGXt12xFINsbf68rseJwtLhbwZe7bDDxrUyFkyCb59FTW3TNWeH+YyT87/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766323; c=relaxed/simple;
	bh=Y/DjbpXTli+q6qXYniP9mDlDlQz3GWNZg2gJsGHgxs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eniKNMeFRf6kl0P0mBh2GPDfhcYcMaETLh3a7V4CFGuiBaQv+Nwiu2FkR7I6pMhnwwLdcWMnC9moI7y3xeAL+dz/wJg5WziMTmmXo1eqQR57qcwQC4IZLNecemAHdEc/drlUaaPpJfU2HhI135ixARPtYunIOyY8fJdcUZSQ6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9I+IGJt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9I+IGJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736766319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nBhouD3nO1E5V4MavagLJ4BxPXoXO2uHY25LrPgF6oo=;
	b=W9I+IGJtXieT9K+HrRgNaBJi1K2x4cpW9FfJf25mg+mVmTMuG9pRsyNCkVN28lBPYjYWV/
	hnkmTQXZ0M4z6BV+8fE6fA71bknkwEeaHswRjL9rMqXaZdpL1YYMIA0eqoGR9ZHdaK9uCC
	BPRMEsGu9zxkXsyfghNtbjjlNBfzBoU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-b86hO99SMcW71mWYxG9l0A-1; Mon, 13 Jan 2025 06:05:15 -0500
X-MC-Unique: b86hO99SMcW71mWYxG9l0A-1
X-Mimecast-MFC-AGG-ID: b86hO99SMcW71mWYxG9l0A
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6c51069f5so697947885a.3
        for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 03:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736766315; x=1737371115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBhouD3nO1E5V4MavagLJ4BxPXoXO2uHY25LrPgF6oo=;
        b=qYwPJO7fK/FI340fppsJcEVQucRgYXAwZQ0IQ+LIXqeSusG0/8WzorPb4Jqn75EbFU
         8hwypJoeqv1H0GN3k8ExNnIUdk5YtpeN6rLHbNQE26krc0Ft9Md7DZPIy5OetyU1+SSR
         XTdwbX6NKwbkOICtoTpiLvoyH5AhfqA0tEke0LQ7IhNqSvDFk1Q/slR3L01I87WVNBWQ
         JPJRFekYNlpwe5d90K2chvq4ppAJ61t5RzdNADSrygq7LxDDSDFcHxs85QRyHezINCpu
         3ILRwmx/0Er/JvmSQ8kUr7Jl6BsLkEsKdjVpnWT+Yu6ibp/AVNb0aK71YjxR/TZJs4Ry
         SbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjA/NPpBp7+li5B95C6F4uoBeSlIC7JL7U8FypQvC2iX2RQ5cU/TnsIrFZE/PsOYcJvdAEIaZz41pwVD9HZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/y3SH/Xcf8n1pIT735svu3CVRdYtbLnzCMsd0cuVmnKkLvneL
	gaq5A8r6hReEBeHsihbyZDPyG14ScZNToAJHGYkilbUGBJTNkRw/lFBuOlMDvVVnCWbLjZxKXqL
	vcAK4RMlsk+3erXKnDaHNYYRTlP9TIb4VkzDiL0Ef7gUaWk8ObxaXir15BzbDpRmf
X-Gm-Gg: ASbGncvI+RSeMeEO5nuOtUbw/N6/d8sHjkgTfryf/5UIZ0WhDdI6Dr38D3utj4rHbK5
	n6QuLQtrvFyA5hkPUORqNb49ZrTj9zgFPiujB/JfGI0anbCYZJJ+QrFK36pySTytEyOk+DaMj3d
	wCr2Vb+Xs6Ot8p1J89s8ZebviS1j0Okeh9OtWduIRDSGb88J4rbpanJ7Pt6uzmng8dqx3RzGAR2
	7A5Fhh53g2K4i7dR/Ag2iEzRfaPN6uY+PZxQ6C/b8DL52DIjiQksqNy8/XklHiuaRFkIZs76E9U
	1TgnatNel4sND9WHrPBoVKFf+I3kB+NU
X-Received: by 2002:a05:620a:4090:b0:7b6:da21:751c with SMTP id af79cd13be357-7bcd96e6e7fmr3008275785a.11.1736766315356;
        Mon, 13 Jan 2025 03:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEudJmjiFx2X110aIZp/K+dX1C2vUPlCS9Q7jCzrlGeW5dRG0V5tRdS8MDrW/FDVcQi98EIoA==
X-Received: by 2002:a05:620a:4090:b0:7b6:da21:751c with SMTP id af79cd13be357-7bcd96e6e7fmr3008272185a.11.1736766314973;
        Mon, 13 Jan 2025 03:05:14 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516193sm474979185a.117.2025.01.13.03.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:05:14 -0800 (PST)
Date: Mon, 13 Jan 2025 12:05:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Wongi Lee <qwerty@theori.io>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
 <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 76XMAWAVhPQhMW8eUXy8uLLq6O5iJp3js1ZH9hr1Vqg_1736766315
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 13, 2025 at 11:12:52AM +0100, Michal Luczaj wrote:
>On 1/13/25 10:07, Stefano Garzarella wrote:
>> On Mon, 13 Jan 2025 at 09:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>> On Sun, Jan 12, 2025 at 11:42:30PM +0100, Michal Luczaj wrote:
>>
>> [...]
>>
>>>>
>>>> So, if I get this right:
>>>> 1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
>>>> 2. transport->release() calls vsock_remove_bound() without checking if sk
>>>>   was bound and moved to bound list (refcnt=1)
>>>> 3. vsock_bind() assumes sk is in unbound list and before
>>>>   __vsock_insert_bound(vsock_bound_sockets()) calls
>>>>   __vsock_remove_bound() which does:
>>>>      list_del_init(&vsk->bound_table); // nop
>>>>      sock_put(&vsk->sk);               // refcnt=0
>>>>
>>>> The following fixes things for me. I'm just not certain that's the only
>>>> place where transport destruction may lead to an unbound socket being
>>>> removed from the unbound list.
>>>>
>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>> index 7f7de6d88096..0fe807c8c052 100644
>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>> @@ -1303,7 +1303,8 @@ void virtio_transport_release(struct vsock_sock *vsk)
>>>>
>>>>       if (remove_sock) {
>>>>               sock_set_flag(sk, SOCK_DONE);
>>>> -              virtio_transport_remove_sock(vsk);
>>>> +              if (vsock_addr_bound(&vsk->local_addr))
>>>> +                      virtio_transport_remove_sock(vsk);
>>>
>>> I don't get this fix, virtio_transport_remove_sock() calls
>>>    vsock_remove_sock()
>>>      vsock_remove_bound()
>>>        if (__vsock_in_bound_table(vsk))
>>>            __vsock_remove_bound(vsk);
>>>
>>>
>>> So, should already avoid this issue, no?
>>
>> I got it wrong, I see now what are you trying to do, but I don't think
>> we should skip virtio_transport_remove_sock() entirely, it also purge
>> the rx_queue.
>
>Isn't rx_queue empty-by-definition in case of !__vsock_in_bound_table(vsk)?

It could be.

But I see some other issues:
- we need to fix also in the other transports, since they do the same
- we need to check delayed cancel work too that call 
   virtio_transport_remove_sock()

An alternative approach, which would perhaps allow us to avoid all this, 
is to re-insert the socket in the unbound list after calling release() 
when we deassign the transport.

WDYT?

Stefano

>
>>> Can the problem be in vsock_bind() ?
>
>Well, I wouldn't say so.
>
>>> Is this issue pre-existing or introduced by this series?
>>
>> I think this is pre-existing, can you confirm?
>
>Yup, I agree, pre-existing.
>
>> In that case, I'd not stop this series, and fix it in another patch/series.
>
>Yeah, sure thing.
>
>Thanks,
>Michal
>

