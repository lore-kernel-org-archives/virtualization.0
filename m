Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995C22F14D
	for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751011394; cv=none; b=ZcVo2+rvACPm6SNlYZr0xEEnMDGWJcW07EtufRoROXSJj/D8QlodRxPkI/IY4XQyHgOv672z10GwfJwdQWi+u+L3bCpyFVMjFzb0cgu9y5ZxadigsUermy5ONrd5tT2m+Iyi9etIplPaD5yoYai/i1UyhMn2aC2ZHQb+8q2Vyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751011394; c=relaxed/simple;
	bh=TlipyTpq+zkxi6ZA8xLnUlroRbf/E4O5IFbXL9YlqHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NocpTr5hi2FuZRAjYa5FeBtNNrDshBIrCecy/ayzPraOxQ3oJVIDk3RfV97w0DdkmGTfUdOWbtEPGbXtkQTy1g4Psc3PgHZbgqc4TUVlS7QVlPPmrz0L6u5AHHWt/uPPcSrlUqdtvtr50RoHMMVWHxKeAgucJdsejJMvZsw6kxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjR4XV6I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjR4XV6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751011391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBGuOpjeJcrv22tZz5j3GQyTZme+pLri3Tcax7Iti6c=;
	b=CjR4XV6I8ac1MWkliFwP4LVbJw/QykKCwq3hqJJpvqL6zbK6tyZXk/il4erqqvUz3abG64
	X0eDTUrdfG5Y84gH4U/AVJjiE5bi9bKJf9DYDC/BfhIPAVegSXnG202is1Ed+IBwVS1iqr
	ar1YdLRJ4PCzGPILaXNLSNh0GPTM5dM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-rSIaQ4aQOISI_HCPIrQaFQ-1; Fri, 27 Jun 2025 04:03:09 -0400
X-MC-Unique: rSIaQ4aQOISI_HCPIrQaFQ-1
X-Mimecast-MFC-AGG-ID: rSIaQ4aQOISI_HCPIrQaFQ_1751011388
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31ca4b6a8eso1127484a12.1
        for <virtualization@lists.linux.dev>; Fri, 27 Jun 2025 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751011388; x=1751616188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBGuOpjeJcrv22tZz5j3GQyTZme+pLri3Tcax7Iti6c=;
        b=PcUcTQJS34KByQ9oSb88N5rkMlUKqwrTOK1c7jbwGrK6j+KvmErK+O7/ybTzGn60CW
         hvRdGjeCC20CfFHTNhb2TVEDFw+Vf3kj8bVHt46yl/kyjS1yU7ti4hU5I9oktQRaQcJD
         0kG2W6W6jP0Yg9d5lqwtvo4SuR3kO9kJbuP5GJ21Vt09ruHAaAmaFgTG1kotEI3of0gI
         JukTLJt6amd6JMPUSFix1TFkQM5oUFRs0L/sauvwQTojMiby7RdRjkYdtB/1Qwo/k0Mq
         IsM1G/OKjYor+SSVtOodDkTwkAh+wFacxTbtY/pLJQUP3a9EZe6UfNPJRTmjl+UXVty1
         etCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6fja1xh6bU/+l+RvvA7AU1bul3R7qCQiTBZAYMEr07f8u3gTwlcIbWTiZXj+oiNibdAqCS+uR8GENGeIRw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqx17F5ioKvfmu8pxQfBlzVDFPrWX60r6z/tvM/jy9BXC5Pr5T
	7PgbInINT/2FKrZeV2LRvs+xi0uO3ASNIyaVxiGS5LoXZUiuk3j6Zzq4nhgZVXpr3qysw03iPkY
	1ScRhKOPoZgowkhLq9NtXTLfyakJ+amIWTtLShAbcGwpdh9LSGJf7Kds7GaDnh+wi33dA
X-Gm-Gg: ASbGnctu9BsOVK/W0t/54bXcMVD0uhNtK58uIURFbXDDK3cbgrnC2yDpQhLnYIfZR9/
	sFJm3TexkgMSI6LFDmzi9ipISbIHr2BMIw9xbcrZzTH1F/XOYhSZd+sTf+j7kKMWikSSu0xSxBX
	H9AB8GOl2yVdxnIF5vcAFuw1I/M1cg1qlWkRoDfjhR9g15wc9vdwEiviaI5p0twob6/8d0HgLYQ
	P9kkIQ72ohqnvh5TK3OsGoq5AhnYzCaWGV2WmdxfNrFGQaVXqlpe0+q2gyCByKB3UdRSsvG6Wx0
	NSthy3ZylCehFISLBjhDdVBS5xI=
X-Received: by 2002:a05:6a21:6d8e:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-220a12a6756mr3045469637.3.1751011387778;
        Fri, 27 Jun 2025 01:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENKutaEVvhU5X/3wOtUe3CypyD8G+Z3R9VqfGa0fMc8Jzyjr0jAT/okl2FRUtRTn0F5dIhXA==
X-Received: by 2002:a05:6a21:6d8e:b0:1f5:7eb5:72dc with SMTP id adf61e73a8af0-220a12a6756mr3045415637.3.1751011387141;
        Fri, 27 Jun 2025 01:03:07 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.150.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af541e548sm1766830b3a.66.2025.06.27.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:03:06 -0700 (PDT)
Date: Fri, 27 Jun 2025 10:02:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 1/3] vsock: Fix transport_{g2h,h2g} TOCTOU
Message-ID: <owafhdinyjdnol4zwpcdqsz26nfndawl53wnosdhhgmfz6t25n@2dualdqgpq3q>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-1-02ebd20b1d03@rbox.co>
 <zdiqu6pszqwb4y5o7oqzdovfvzkbrvc6ijuxoef2iloklahyoy@njsnvn7hfwye>
 <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d8d4edb2-bf14-42b2-8592-79d7b014e1a7@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y-5O3SgEYNghgMP04SNgtDS1tPrcHfnVmNRe7qwGR-8_1751011388
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jun 25, 2025 at 11:23:30PM +0200, Michal Luczaj wrote:
>On 6/25/25 10:43, Stefano Garzarella wrote:
>> On Fri, Jun 20, 2025 at 09:52:43PM +0200, Michal Luczaj wrote:
>>> vsock_find_cid() and vsock_dev_do_ioctl() may race with module unload.
>>> transport_{g2h,h2g} may become NULL after the NULL check.
>>>
>>> Introduce vsock_transport_local_cid() to protect from a potential
>>> null-ptr-deref.
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>> RIP: 0010:vsock_find_cid+0x47/0x90
>>> Call Trace:
>>> __vsock_bind+0x4b2/0x720
>>> vsock_bind+0x90/0xe0
>>> __sys_bind+0x14d/0x1e0
>>> __x64_sys_bind+0x6e/0xc0
>>> do_syscall_64+0x92/0x1c0
>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> KASAN: null-ptr-deref in range [0x0000000000000118-0x000000000000011f]
>>> RIP: 0010:vsock_dev_do_ioctl.isra.0+0x58/0xf0
>>> Call Trace:
>>> __x64_sys_ioctl+0x12d/0x190
>>> do_syscall_64+0x92/0x1c0
>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 23 +++++++++++++++++------
>>> 1 file changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 2e7a3034e965db30b6ee295370d866e6d8b1c341..63a920af5bfe6960306a3e5eeae0cbf30648985e 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -531,9 +531,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>> }
>>> EXPORT_SYMBOL_GPL(vsock_assign_transport);
>>>
>>> +static u32 vsock_transport_local_cid(const struct vsock_transport **transport)
>>
>> Why we need double pointer?
>
>Because of a possible race. If @transport is `struct vsock_transport*` and
>we pass `transport_g2h`, the passed non-NULL pointer value may immediately
>become stale (due to module unload). But if it's `vsock_transport**` and we
>pass `&transport_g2h`, then we can take the mutex, check `*transport` for
>NULL and safely go ahead.
>
>Or are you saying this could be simplified?

Nope, you're right! I was still thinking about my old version where we 
had the switch inside...

BTW I'd like to change the name, `vsock_transport_local` prefix is 
confusing IMO, since it seems related only to the `transport_local`.

Another thing I'm worried about is that we'll then start using it on 
`vsk->transport` when this is only to be used on registered transports 
(i.e. `static ...`), though, I don't think there's a way to force type 
checking from the compiler (unless you wrap it in a struct). It's not a 
big issue, but taking the mutex is useless in that cases.

So, if we can't do much, I'd add a comment and make the function name 
more clear. e.g. vsock_registered_transport_cid() ? or something 
similar.

>
>>> +{
>>> +	u32 cid = VMADDR_CID_ANY;
>>> +
>>> +	mutex_lock(&vsock_register_mutex);
>>> +	if (*transport)
>>> +		cid = (*transport)->get_local_cid();
>>> +	mutex_unlock(&vsock_register_mutex);
>>> +
>>> +	return cid;
>>> +}
>>> +
>>> bool vsock_find_cid(unsigned int cid)
>>> {
>>> -	if (transport_g2h && cid == transport_g2h->get_local_cid())
>>> +	if (cid == vsock_transport_local_cid(&transport_g2h))
>>> 		return true;
>>>
>>> 	if (transport_h2g && cid == VMADDR_CID_HOST)
>>> @@ -2536,18 +2548,17 @@ static long vsock_dev_do_ioctl(struct file *filp,
>>> 			       unsigned int cmd, void __user *ptr)
>>> {
>>> 	u32 __user *p = ptr;
>>> -	u32 cid = VMADDR_CID_ANY;
>>> 	int retval = 0;
>>> +	u32 cid;
>>>
>>> 	switch (cmd) {
>>> 	case IOCTL_VM_SOCKETS_GET_LOCAL_CID:
>>> 		/* To be compatible with the VMCI behavior, we prioritize the
>>> 		 * guest CID instead of well-know host CID (VMADDR_CID_HOST).
>>> 		 */
>>> -		if (transport_g2h)
>>> -			cid = transport_g2h->get_local_cid();
>>> -		else if (transport_h2g)
>>> -			cid = transport_h2g->get_local_cid();
>>> +		cid = vsock_transport_local_cid(&transport_g2h);
>>> +		if (cid == VMADDR_CID_ANY)
>>> +			cid = vsock_transport_local_cid(&transport_h2g);
>>
>> I still prefer the old `if ... else if ...`, what is the reason of this
>> change? I may miss the point.
>
>Ah, ok, I've just thought such cascade would be cleaner.
>
>So is this what you prefer?

I usually prefer less changes as possibile, but in this case I see your 
point, so up to you ;-)

In your way we save `cid` initialization and an if, so it's fine.

Thanks,
Stefano

>
>if (transport_g2h)
>	cid = vsock_transport_local_cid(&transport_g2h);
>else if (transport_h2g)
>	cid = vsock_transport_local_cid(&transport_h2g);
>
>Thanks,
>Michal
>

