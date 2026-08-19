Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2343364EAB
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129689; cv=none; b=F7fqUHb2tcnll7LAHP1GZiGRDfTFTUiisyjqCCRSBNoq0azqUt/yH15GN6wJf50HgAYWoJ3Am9sOy67M1ImpfkVhdOx5VH6MPjek4eRp9EXUBqn5DcugbF36VcwTPPAULbGVx5E9vo8fuRcnD6vZqG/rabdNxhcWQ0AlFc6BEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129689; c=relaxed/simple;
	bh=T9eBhUtD7DJAjCOIN5rHp+QhsMo7TcL7Rwzb0+0BgO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bRWwlf3MIe+SUlCYvjFOs4lehjYuNIhWQGH4CF0zHnc/lueUyz2UC8jNXCF/uESIycAZMzaRx3p8Zdz7/28tK65VS5FPPjpSxNOzACicFoj1FTe5M2HKFlMlfY6oiSqXlsky61oiQ2f61iSXCNAB/mYZPbvzPsutolNqeKEuQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWvRj7uf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWvRj7uf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787129686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=77481jAD0+x71yyQI0+UVKtdPo0kVhQyKn2fVAxrMBY=;
	b=hWvRj7ufjhUqanV7uzK4PJlAxCpMaS8pZzxMSwxAMiqxs2WUXhKDZp1Li4PCDyy8SDAdpH
	ZixYfeqKokIGzHstUzJfnekxRsEOJbf7+sShCUnV0KJkdq+4FBf6sCgth31VmKAgdORaI1
	1qP1xeK4zwbEMbBvUSjcDTBg+uSgISU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-nPnB9Ak-Mxm3Mcj8p6_ZtQ-1; Wed, 19 Aug 2026 04:54:45 -0400
X-MC-Unique: nPnB9Ak-Mxm3Mcj8p6_ZtQ-1
X-Mimecast-MFC-AGG-ID: nPnB9Ak-Mxm3Mcj8p6_ZtQ_1787129684
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-499900c9d99so6394055e9.0
        for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 01:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129684; x=1787734484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=77481jAD0+x71yyQI0+UVKtdPo0kVhQyKn2fVAxrMBY=;
        b=rSZ8k1xzTNQCW2sTjlpf/MgR1rGu+HyqS6vNLWHcGXvUinjE3fdN2trtYNdA2ge48U
         vEwvvcOZt9juXsLGIWRCeeJPFt/St+c4VaQckXlb32hwBTbnoSGdqQfKR2F7mdSQNbQF
         iUp7fKeSBKQeY8QqRL1ZIz7E73IWHGXE9SBGvtNkA5YRYE8BHqTMq5pcniBZaGwvn08c
         YjRCSalMyU6xueK8C6YrlfYNW9wge9a7kmdDqrAEykMRhZ8sJyIAzKe4msTJ7khS9KOz
         /qeow87DgSpy9vZLGy3UF6mW73hCp+jaYbs5BzM8fDcD5aNVxzGNkmno1RG6T9ixnTJ4
         sxCA==
X-Forwarded-Encrypted: i=1; AHgh+Rq184Wc6xCMnfr8/XG2MCqhIn43xsMJmTGTSsKjwxuXKEBzNeRgzDlZcE3ctgkTUaoRmJtqjUTjIT+nE5R6SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr401MI0sB7+wqyyFQB+HUg0BvWq82hVgwBuBtUW2lkPAAef6w
	8sMQop7JD84QwHqYwQNVyijR8bzrCem8ExqVvb3qui8nDB+ZOSoZgJ47KVHdDjK0mB17dOCnLQK
	NgS9JqBGjglfDrTwSb7ohRD7iNjpz9sY7LXL0Uew0vWKog2T4O9asN5T9ZNkTtj72lgC+
X-Gm-Gg: AR+sD10OgC9DqaJwpDnf9JImHKMwVRDpm2m2uPEDqX8QQ4gOO3XpQKldLMEcKPRXQef
	CtL33blqz1UgEW/65BvsHq5TVBbB6So/Ti338inZ7HCKj61KWyk/L2ubW9XcJWnE2Z6Su1w2pGG
	vARaGCRAsR4AfGI1XxVRIHAFlondMGszTHzGDebqmyWkw+bhirxdOXPVc7w76YoqXtQwUO1V0hz
	UCgu5oZFQTeNg7tTu81kJIKltry12QYcdTYotOMArPrfwNmnWwayqxB5r12JSzsluDou1ZcesDR
	4MT2jr1fffVYNm1+yojd9kkNR6zotl3YGFL+L833D5JaOu0CM04PQ+bU8n8tpl/udycYE+yYo0m
	Pn+S7oUj/Nw/keiGGoO8x5690oh6qZNgTv3cxfSM0xtyYJtaUvS+2
X-Received: by 2002:a05:600c:3484:b0:499:7a5e:4c3f with SMTP id 5b1f17b1804b1-499aa14e6abmr65007805e9.1.1787129683961;
        Wed, 19 Aug 2026 01:54:43 -0700 (PDT)
X-Received: by 2002:a05:600c:3484:b0:499:7a5e:4c3f with SMTP id 5b1f17b1804b1-499aa14e6abmr65006955e9.1.1787129683431;
        Wed, 19 Aug 2026 01:54:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fda98sm70253085e9.1.2026.08.19.01.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:54:42 -0700 (PDT)
Date: Wed, 19 Aug 2026 10:54:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	leonardi@redhat.com, bobbyeshleman@meta.com, stefanha@redhat.com, mst@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net] vsock: do not reset a socket in connect() once it
 has connected
Message-ID: <aoVnp0w9jlyFDPj7@sgarzare-redhat>
References: <anzT1fREOSyHT99k@v4bel>
 <218226a4-38e6-4a16-a660-6c1bb92f9f96@rbox.co>
 <an5zJ9Uf94_L9TyB@v4bel>
 <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c11d6fe8-fdf9-4b45-b291-e5d5b0ef5cb4@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IRAKQA0Hzs551YrR3tjvPMx3GjD95TpGF4rPZQT39IQ_1787129684
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Aug 17, 2026 at 12:29:11AM +0200, Michal Luczaj wrote:
>On 8/14/26 03:45, Hyunwoo Kim wrote:
>> On Thu, Aug 13, 2026 at 11:42:17AM +0200, Michal Luczaj wrote:
>>> On 8/12/26 22:13, Hyunwoo Kim wrote:
>>>> commit 002541ef650b ("vsock: Ignore signal/timeout on connect() if
>>>> already established") stopped connect() from resetting an established
>>>> socket. The check only looks at whether sk_state is TCP_ESTABLISHED at
>>>> that moment, and the state can change while connect() sleeps.
>>>
>>> I guess this makes my fix incomplete. "Fixes: 002541ef650b"?
>>
>> It is incomplete, yes. But this has been triggerable since d021c344051a, so
>> I'd keep Fixes: d021c344051a.
>
>OK, I get it.
>
>>>> A peer RST moves the socket to TCP_CLOSING, and it is not removed from
>>>> vsock_connected_table on that path. connect() then wakes up, fails the
>>>> check, and resets a socket that had actually connected to TCP_CLOSE and
>>>> SS_UNCONNECTED.
>>>
>>> Thanks for the details. Do I get it right: connect() misses the fact that
>>> socket might have already transitioned TCP_ESTABLISHED -> TCP_CLOSING
>>> during schedule_timeout()?
>>
>> Yes, that's it.
>>
>>>
>>> How about:
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index 622dbd046799..39c42ef016c3 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -1807,15 +1807,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>>>  		timeout = schedule_timeout(timeout);
>>>  		lock_sock(sk);
>>>
>>> -		/* Connection established. Whatever happens to socket once we
>>> +		/* Connection (has been) established. Whatever happens to socket once we
>>>  		 * release it, that's not connect()'s concern. No need to go
>>>  		 * into signal and timeout handling. Call it a day.
>>>  		 *
>>>  		 * Note that allowing to "reset" an already established socket
>>>  		 * here is racy and insecure.
>>>  		 */
>>> -		if (sk->sk_state == TCP_ESTABLISHED)
>>> -			break;
>>> +		if (sk->sk_state == TCP_ESTABLISHED ||
>>> +		    sk->sk_state == TCP_CLOSING) {
>>> +			err = -sk->sk_err;
>>> +			goto out_wait;
>>> +		}
>>>
>>>  		/* If connection was _not_ established and a signal/timeout came
>>>  		 * to be, we want the socket's state reset. User space may want
>>>
>>> ?
>>
>> Yes, I like it better than mine. I confirmed it fixes the issue.
>
>Great, thanks.
>
>> If you don't mind, would you take the patch from here?
>
>Sure, no problem.
>
>Stefano, does this look good to you?

Yep, thanks for helping here!

My only doubt is if it makes sense to leave the `break` there, and add a 
similar check before resetting the socket, I mean something like this:

	err = sock_error(sk);
	if (err && sk->sk_state != TCP_ESTABLISHED &&
		   sk->sk_state != TCP_CLOSING)) {
		sk->sk_state = TCP_CLOSE;
		sock->state = SS_UNCONNECTED;
	}

Just to be a bit more defensive, but I don't have a strong opinion, your 
version is also fine.

>And should any sk_err be consumed
>here, too? (`err = sock_error(sk)` instead of `err = -sk->sk_err`)

I'd stay with sock_error() to consume the error if it makes sense also 
for you.

Thanks,
Stefano

