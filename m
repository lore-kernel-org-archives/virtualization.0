Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2023AB8D
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276843; cv=none; b=ZOQy1dEeKmxkLrAwwZBuTJwdy7MPf+mcnjl4vvTbDLYCMeHH7LZYbd9pfab7Z/5uOXhHozKmpNDWJtXmnrVpEKDQrVBoFt04EHv95HqD57cCe645OO8nHFG01mINMnpAheunkguAIAUx5oF3Mfo4j1ZYtxXhebHSTBpTlu7Pe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276843; c=relaxed/simple;
	bh=u2PQA0S/gy/0ITz+24bqC/IeF/VMz3qlCfRMUN/YZwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=T2lERD/yLYwQ5SkvjHreArzfO50V6j8UA3Zr+37QDc+kAFmLKO4T0Atpke4jtBMrp0vL9uDghFjhd94m0XxfkX3VCva59Ul5Q0OVPSLp72dNSiBw/OByOM4qy6iGkSFr1MiKkZq8p2lDdfQIN2+mfr0G7818JU1meMHVNkY1CKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfXGDTFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfXGDTFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751276840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cYM+l9u3eA7xXNWMmpxmynV8BtHDfFyAj+GAIS/oRBQ=;
	b=JfXGDTFQa6yza4qj+KUlJIe0PtWk4QsT2pHehgzo7m3OqzityhY0wLaMvIu8EewDuqUfzK
	S0KlkfeL9nqd26TFyEpyEHq6qYMPCZsQHzQHduugJ2MHOTXcfBUSo6ugay7O+ac5NVDFQt
	3Dsc01IRBpenSnUefb1KLpgyO98ehTY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-MpTqhLAQNcqgGSp66D8N4w-1; Mon, 30 Jun 2025 05:47:16 -0400
X-MC-Unique: MpTqhLAQNcqgGSp66D8N4w-1
X-Mimecast-MFC-AGG-ID: MpTqhLAQNcqgGSp66D8N4w_1751276836
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4535ee06160so14627185e9.3
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 02:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276835; x=1751881635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYM+l9u3eA7xXNWMmpxmynV8BtHDfFyAj+GAIS/oRBQ=;
        b=cyWga6EqsIA1TIcGJwKFaiuAmRNUf8DHAdRfHYjVV5kEJmuPAMzTqpAnJNH0MIO11/
         lHJCgoNxq3YTuYuCXg2M86DXpL3R1C3TbtLFcleVZoIlv6hJC9sYlQanwiHfKApnPCeN
         CEdNkWpff2/uZCO7Wk4wDCCWmFDIN2gO8jXEKmMp/etOLfQXFvFB70IKd0Rr3c1lH4GH
         JLoeynaJ3cGRK4Du8ezgArDiwTWgJ0mKMcf106zSyfWexYz5snBtseqP+pp4OCpaJb9t
         ve3QIXQcl8G297gmF32yw/qPPe/hHfjc+Lb4iLE2B/THHkdgZJHLtyO6gf5xnOQlBNuv
         iFLA==
X-Forwarded-Encrypted: i=1; AJvYcCXga/TZf3y+WsoL3tYOCC08EjBH1+hCpVHinb7ZH/u2+F5zd+aKPjoGklAUMLF7MOxRscFNl4zOFTPXvU+70g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVOJH0EyKiPenjV4A0ZVEc3zhQsh1fjHqMJDg5+Ln4+qN/hfFn
	JVvX+63MVU1wygw5dhr4Ckmmwcs+dTiRqJPBhFSvaYpnvV4TV509ZcJHZ4nZaI7xBS3AUj7f12g
	47bTannQM24PpwlrWCqsIJ/n2SK+BXSNps6IKeE3HQYD0U9mGt8LVlkwQMoo2rbALJQWr
X-Gm-Gg: ASbGncuGVTMPViLOn9BfrR9FWsJns9KIdFJOUaXUh9iu7QFlUR3nRSsbr4sRJf0dJBu
	0kO6LxFIrv3k+NgwztQk4Qwyn0qy2S2Po/E9QzNjJQ/0JWKKsQhyFnFmTLBzSNYhmTpH7kG3u/J
	A/ILfViNkFLbdHwEtmsktS7r6d9E49nbos+Y2tWpcV7mBnQAwPgaJBq5xXBtxvbfS5/13SOHyps
	gkx6yKKBr/5z9qABS8uTNwciah02yHaqSzQklF61QP24MVdOxx/QZOvPMkwJRpA/lWKPwBG0AI0
	p6IyuC/aG6sDDGb05dZXB3uoJKV4
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr129104915e9.4.1751276835603;
        Mon, 30 Jun 2025 02:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCsgQCAMCNSYIs4yUUiqL9XaX4IgpvXxCsiWAizlF8onAmxWpgouuXgVa8Tozt+Jbmj2XBUw==
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr129104465e9.4.1751276835016;
        Mon, 30 Jun 2025 02:47:15 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.177.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a87e947431sm9969199f8f.0.2025.06.30.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 02:47:14 -0700 (PDT)
Date: Mon, 30 Jun 2025 11:47:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net v2 2/3] vsock: Fix transport_* TOCTOU
Message-ID: <o2erk5qbypfrla2afvlswzp7al43xulrucdo7b7wvnhsytjchm@jh6spvmgfo2c>
References: <20250620-vsock-transports-toctou-v2-0-02ebd20b1d03@rbox.co>
 <20250620-vsock-transports-toctou-v2-2-02ebd20b1d03@rbox.co>
 <l6yqfwqjzygrs74shfsiptexwqydw3ts2eiuet2te3b7sseelo@ygussce5st4h>
 <b0b49299-6373-4fea-914b-271f6451e27b@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b0b49299-6373-4fea-914b-271f6451e27b@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: luyJDQuY3bBvkVec8eX6GA35gk7Z4S8P5EqnwU-ntws_1751276836
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jun 29, 2025 at 11:26:25PM +0200, Michal Luczaj wrote:
>On 6/27/25 10:08, Stefano Garzarella wrote:
>> On Fri, Jun 20, 2025 at 09:52:44PM +0200, Michal Luczaj wrote:
>>> Transport assignment may race with module unload. Protect new_transport
>>>from becoming a stale pointer.
>>>
>>> This also takes care of an insecure call in vsock_use_local_transport();
>>> add a lockdep assert.
>>>
>>> BUG: unable to handle page fault for address: fffffbfff8056000
>>> Oops: Oops: 0000 [#1] SMP KASAN
>>> RIP: 0010:vsock_assign_transport+0x366/0x600
>>> Call Trace:
>>> vsock_connect+0x59c/0xc40
>>> __sys_connect+0xe8/0x100
>>> __x64_sys_connect+0x6e/0xc0
>>> do_syscall_64+0x92/0x1c0
>>> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> net/vmw_vsock/af_vsock.c | 28 +++++++++++++++++++++++-----
>>> 1 file changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 63a920af5bfe6960306a3e5eeae0cbf30648985e..a1b1073a2c89f865fcdb58b38d8e7feffcf1544f 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -407,6 +407,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
>>>
>>> static bool vsock_use_local_transport(unsigned int remote_cid)
>>> {
>>> +	lockdep_assert_held(&vsock_register_mutex);
>>> +
>>> 	if (!transport_local)
>>> 		return false;
>>>
>>> @@ -464,6 +466,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>>
>>> 	remote_flags = vsk->remote_addr.svm_flags;
>>>
>>> +	mutex_lock(&vsock_register_mutex);
>>> +
>>> 	switch (sk->sk_type) {
>>> 	case SOCK_DGRAM:
>>> 		new_transport = transport_dgram;
>>> @@ -479,12 +483,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>> 			new_transport = transport_h2g;
>>> 		break;
>>> 	default:
>>> -		return -ESOCKTNOSUPPORT;
>>> +		ret = -ESOCKTNOSUPPORT;
>>> +		goto err;
>>> 	}
>>>
>>> 	if (vsk->transport) {
>>> -		if (vsk->transport == new_transport)
>>> -			return 0;
>>> +		if (vsk->transport == new_transport) {
>>> +			ret = 0;
>>> +			goto err;
>>> +		}
>>
>> 		/* transport->release() must be called with sock lock acquired.
>> 		 * This path can only be taken during vsock_connect(), where we
>> 		 * have already held the sock lock. In the other cases, this
>> 		 * function is called on a new socket which is not assigned to
>> 		 * any transport.
>> 		 */
>> 		vsk->transport->release(vsk);
>> 		vsock_deassign_transport(vsk);
>>
>> Thinking back to this patch, could there be a deadlock between call
>> vsock_deassign_transport(), which call module_put(), now with the
>> `vsock_register_mutex` held, and the call to vsock_core_unregister()
>> usually made by modules in the exit function?
>
>I think we're good. module_put() does not call the module cleanup function
>(kernel/module/main.c:delete_module() syscall does that), so
>vsock_core_unregister() won't happen in this path here. Have I missed
>anything else?
>

Nope, I reached the same conclusion!

Thanks,
Stefano

