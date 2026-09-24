Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA9457E63
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245047; cv=none; b=Qxf7ueL7GCZ5HJdDpFGTgJK+sLLcXCdH477nH+Y636Mcd11zcWXQqMHtEK8C7GlPCr086+mNcK2oegPm2xaaTaORpMYm8aFoaf5xYAFt5rkMiDjzyBM1r6VbZzCfo8lY0e3HXEt0csobkQmR3spbEDPBvZPKc3Bnfdz6tXBQTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245047; c=relaxed/simple;
	bh=OLQtN8/9/Nf4flz3Kt2BUy4OlOf9PndZym7N2lg6lbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LCOe7xikQ26JsbtD/4BWrmyGDwbMQ06SOulvyBgWt7cKhdPvJXVI1PDKVqTRieoxychhjyd2QfZ17lAg57PvLrkSsXTL1pexIGxMiZnOIBXeWRTdLVGlUTKQkw+VHvS37FNnRh5j0bPh3vX3Kp+5H5BRxiiFfQLlVy66azBGki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a62eB1VJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a62eB1VJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790245034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
	b=a62eB1VJw75EktJS75+2xdXvr1XdUTzZGANOZ6VNC2K0i37XkEM8udyTyctf9fc+AKAPln
	XW0baWTvX4xpvYoXgo98WNM1uDEe0X2xP1nFeFFKflB0F6mEu+k2nNaPuqaICwupl8noAZ
	Y1Tvd58bMrb1sEWfEUbSeZJfgEJEcD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-qoEADte2P1K244txsGbEQg-1; Thu, 24 Sep 2026 06:17:12 -0400
X-MC-Unique: qoEADte2P1K244txsGbEQg-1
X-Mimecast-MFC-AGG-ID: qoEADte2P1K244txsGbEQg_1790245032
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f768517dso1453347f8f.1
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 03:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245031; x=1790849831;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H6EUUW1m1zoaB7DVxqcfClkBe+yQHGLp6gBbcFMHwFk=;
        b=esavTt31EwkOUq7NCeSmlZkFL2AjWQVTr3sBX4/VVTB+zDVKZMk4Md42eBeCW9x3Wo
         Egotsz9ZwJ/puMIudeGq1pZrBFh5yXHZiDZlgRbVNwQjs8V2UgudyAZfHOhsRJ9bJxmD
         Sg4FCzYwa8P5vfZT3KUpdlsBNIcJMZDEAKhOCvvouVRtgWUkZCcDKYQs2j/dxrnPCyTN
         5Tw8T0ycU/Jz29RkwzIjW9ml1wgNAeBxoWoYJyq8vJ69GIr/34QzPfPdch0OoBp2FFB2
         CNzRpPk1MmKScxMxOwv/JUGIrBoFQsxEDGlfsQ02em8lexNPYrX+8SV4Ilu35Zwh6wA6
         bqAA==
X-Forwarded-Encrypted: i=1; AKwUvBymFWKWBo3cTE6YDVbcLo2AupN6yBNowjpY4Yj2l2C1/oatRr3LqwGTD7FqQ+KE/9CvNvCbWx3AFIL0ZSK5Mw==@lists.linux.dev
X-Gm-Message-State: AFuF++mtoqxEFj8f0mduL1Tqy0/w5GccxD1GnlorZ3lWEw0Gj0uZ3Fd7
	AcvDNcnCkAhd6y0iKCteaYTaCvRezJOYF4rjRgYC9dHsf07zsj/UCqWQrPskiQrVpv3PZHpuqyV
	/oNDYijTlLMKBHSpAd8HWVLBEzTBA5exof4arLOTDl9aAnhdFI6KXxOlVEadMEiZ/RMl3
X-Gm-Gg: AYBFou0SXCICMfdZXoqCJ2q/VXsigLNFgyTq7178HNij5RJCWAijZf3lEjdAEnximzk
	bNkRn2jGxNiGf2rA6CnJogCRKURU0Ym18RcooJcy0LnofbDlO34c6aXUjTpSKEGfaloAid7+AOK
	k+w7qsGTqWKOaXTzyEvFgRZjbXmYgAbJAS5Vs8VfxQ7LBvehctJeeusrG4Eo2BkLq5G9OljpaMU
	G966ubB+bFRhcjC0U+Yteat4//eUP/tqmH3kAsO+2VFEG/nZYGR24RCG4INx+IpvYX0myc5B/B1
	esMpkL7O0osRT9PVbdNT0YHASMsk/zENe534TB11yVXXiTIVMUku1rkgqFb/rjeSNPXw8gyzrwI
	nDPwu58XzpPaHRlQwWNS3YwVgCoziMldqvfEgKFSeDNOrzmsKVgQ=
X-Received: by 2002:a5d:5e93:0:b0:487:27f9:82a with SMTP id ffacd0b85a97d-488716f74b7mr3255268f8f.31.1790245031504;
        Thu, 24 Sep 2026 03:17:11 -0700 (PDT)
X-Received: by 2002:a5d:5e93:0:b0:487:27f9:82a with SMTP id ffacd0b85a97d-488716f74b7mr3255203f8f.31.1790245030920;
        Thu, 24 Sep 2026 03:17:10 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684863d9sm13714443f8f.12.2026.09.24.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:17:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:17:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/5] vsock: Enforce no-transport invariant for
 TCP_LISTEN sockets
Message-ID: <arT3jXoS7OaU6Tsc@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-3-a1d9abb472f7@rbox.co>
 <aqp7CV9DnfsG1GJc@sgarzare-redhat>
 <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0bc40e5c-8790-4a36-84bc-80e0bfe6b504@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rsOc4BTr9wHNQFdu0B9t23XBo_v9eaA1pGEwUy2120E_1790245032
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 22, 2026 at 03:18:13PM +0200, Michal Luczaj wrote:
>On 9/16/26 14:30, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 03:15:14PM +0200, Michal Luczaj wrote:
>>> A non-blocking connect() running in parallel with a blocking connect(),
>>> combined with a racy listen() that hits right after a connect timeout:
>>> TCP_SYN_SENT -> TCP_CLOSE -> TCP_LISTEN, while the connect() loop is still
>>> in progress.
>>>
>>> Enforce the invariant. Prevent a socket from becoming a listener after
>>> acquiring a transport.
>>
>> We should improve this comment; it's not entirely clear to me, TBH.
>
>The race I was thinking about:
>
>sk is CLOSE UNCONNECTED
>non-blocking connect():
>  sk := SYN_SENT CONNECTING
>  enqueue vsock_connect_timeout()
>                                   blocking connect():
>                                     release_sock()
>                                     schedule_timeout()
>vsock_connect_timeout():
>  sk := CLOSE UNCONNECTED
>listen():
>  sk := LISTEN UNCONNECTED
>                                     lock_sock()
>                                     sk is TCP_LISTEN UNCONNECTED
>
>It's not really critical (blocking connect() just timeouts), but I thought
>the invariant should be enforced once and for all.

I see, would it better to do this change in net-next?

>
>>> @@ -1973,13 +1973,13 @@ static int vsock_listen(struct socket *sock, int backlog)
>>> 		goto out;
>>> 	}
>>>
>>> -	if (sock->state != SS_UNCONNECTED) {
>>> +	vsk = vsock_sk(sk);
>>> +
>>> +	if (sock->state != SS_UNCONNECTED || vsk->transport) {
>>
>> Are we changing the behavior when an error occurs?
>>
>> If we call `connect()` on a socket (with no others running in parallel),
>> it fails, and then when we call `listen()`, it now fails, whereas before
>> it didn't. Can this happen? Is that what we want?
>
>Ah, true, I didn't consider that. So yeah, we'd changing the behaviour.
>
>> If so, we should mention it at least in the commit description; if not,
>> perhaps we should unassign the transport in the `connect` call.
>
>Do you mean immediately un-assign on every transition from SYN_SENT to
>CLOSE (failure, timeout, signal)? Then we could also drop the re-assign
>logic. I think that's a nice idea.

yeah, that!

>
>---
>
>I've addressed all your other comments for v2 and went through Ashiko's
>reports (side effects of lockless peer_shutdown write, imperfect
>no-transport TCP_LISTENER enforcement). I've decided to try the
>eager-unassign approach. I think/hope this way we sidestep the lockless
>writes and enforce the invariant without breaking the API, while fixing the
>bugs.
>
>This should probably be RFC, but I'm posting as v3[1] so netdev's LLM can
>have a go (too). Hope I'm not breaking any workflow. Let me know what you
>think.

I think you can add RFC also on a v3 patch, just to make it clear you 
are not sure it's ready to be merged.

That said, thanks for that :-) I'll take a look today or next week 
because I'm off tomorrow.

I'm just worried it's becoming too big for net. Anyway, I'll comment 
there.

Thanks,
Stefano

