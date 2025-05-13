Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B2F18DB20
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132664; cv=none; b=o0CTCgYceYHBdV5fcjtVMxLYmFgNVphAUvvyl4bJ7rhyt3juZ9JrCxvbglhRraTkVgeQKvCca9/t4c170qKo4LPwjT6OgcDR6Pp1efWwqfs2BSNJeENbpElkHg5xTITYIbx3K1uUkYT9giI+wRhcS2GTSuFl/c234wRNmmesdcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132664; c=relaxed/simple;
	bh=0+JAfIVe5TbD+BsWH6Y1qq0GakoctBjfNN1l+27aN4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJiSNmdXCR38HK3OUN4Dp2hEJWxOBx+5ln08aHFzVNygKKFMNCGkEtGcyVIPHdz7BpKi1byQ4UaTFPSlL/YSGHbWny5kafk6ZzSNszz9ug+QBdNU4aBTVX9lEK6J3PtJZlkhHrZN1KXS26SohgrE3BFyrfUbXkZrZ4v+X64HtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZM+ag/Nm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZM+ag/Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747132661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1ycin1YMkPuCF1ATge++M1JYdrKUEG5Nak7RYdhw00=;
	b=ZM+ag/NmtuXmRX+dPL+lGfXOYow2SQaJT8dfMUKmGqfOhVDUH6oKIA9DVSwiUFAf3r5rTc
	njE/N4Z8ZzcTdiOhmQJXhH7AOy5/IihK4ew92K17/WT/HKdIMX8BAWHoY6hSPeZFthePeF
	oLLjkq8FI3has6IKfbD/bHSH5neIWq0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-C997S-qwOdGPDINxTAuJPg-1; Tue, 13 May 2025 06:37:40 -0400
X-MC-Unique: C997S-qwOdGPDINxTAuJPg-1
X-Mimecast-MFC-AGG-ID: C997S-qwOdGPDINxTAuJPg_1747132659
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-44059976a1fso18525355e9.1
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 03:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747132659; x=1747737459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ycin1YMkPuCF1ATge++M1JYdrKUEG5Nak7RYdhw00=;
        b=c/tdhD5UU5WKsQEsFiD7ew1hzQe6Rku+wEgvkjaHEfVxYudMBtG5rmXSDGLpUKoyYv
         CxAJqNFbgLQEbnmdpbH1MmXDpv9MCgqpdvEaIS6lZU7De9h3o8QQtWpBPGG1xV176T57
         Bij2p3HPmlWScGw4P10PNVdODlt2tvLeW4FgP/szvaeUXdjem5LX2YqJ8az1Mt1RTjZH
         LgMRuyVnepN1ZwQE5Ep6bRWRCR+OQ1MDOpV29eR+K99jcMnu82iN11oE+oXXpaSiu7Aj
         cyVx6kw0CgEsitgT2J8Q8I1jjl+Xjbbj47earVrAWcxdT7fAhyJZOFRJlqxKpadvin91
         WcSg==
X-Forwarded-Encrypted: i=1; AJvYcCXdyEJ65U/+vEUbDoSwsLpQCR2+T7+rqId+sy4/40F5/sI2Urpm+CQ+CZ8W6ENNE003V7IFQvxgoBkEum5WOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9YYbfAi8BUfGNupO8VD9UUatn4+MHMZfXO+RnUIFgZWk0xPWs
	EBmpx69TIOSK8d3v/EqgETIuYD9NgdkoqeEtBtZ5McEOUcPz96y5Nf7iQ1VKY+zMypiMIrEkw0s
	YStTogvjmCPh4Eq8q7ToBJ+dXBF40cTXh7rq/LuhwfeaqeLSokAyTQ2Y5QcGt6I2asuWnCUYndt
	c=
X-Gm-Gg: ASbGncs5ijXD1uco1VmsPiMLvb0ANWFfIcKDEnf7kmr17YtkeIbtO5n4mxFG8vMjYGH
	ZnGE9q/vJ2qqr2DQLM43SpzWLmpFTZXpkOACdjei5UXE4jrSdUzssFfeG8UCDMdwgo2Nebewz3r
	SpFRHqM4rA2xEaptLTOctZJxMqiJuDZNgdV77OYbDYl8uZ28uvhIiZdBv5ujKmnvYc7Femf1aU2
	iVZmrqe4XiPnRa8fDAUxdHrRNnA2hSN9vy5yKTNPWC+4NHqT7HrpRl+midmefEXs6XXhKTsUlKd
	fgaFNG8FkYBfSnkdrUU=
X-Received: by 2002:a05:600c:3587:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-442d6dd1bf8mr109922435e9.20.1747132658793;
        Tue, 13 May 2025 03:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpVnwLwL3h3SPRt/DvwKMVIkUz/KDgEEw1efsbBAEpQpKw5oFdKDXUjHqlKxtD7LGNGPpLOw==
X-Received: by 2002:a05:600c:3587:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-442d6dd1bf8mr109922275e9.20.1747132658404;
        Tue, 13 May 2025 03:37:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ea45c209sm37449475e9.17.2025.05.13.03.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:37:38 -0700 (PDT)
Message-ID: <2c5581b9-c0a4-4620-ac82-0a98abfd4d0d@redhat.com>
Date: Tue, 13 May 2025 12:37:36 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] vsock/test: retry send() to avoid occasional
 failure in sigpipe test
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20250508142005.135857-1-sgarzare@redhat.com>
 <20250508142005.135857-2-sgarzare@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250508142005.135857-2-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ELmB0nvlWjexZq_T4zNLamv2xz9QI56wQ8xknyNO0Gg_1747132659
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 4:20 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When the other peer calls shutdown(SHUT_RD), there is a chance that
> the send() call could occur before the message carrying the close
> information arrives over the transport. In such cases, the send()
> might still succeed. To avoid this race, let's retry the send() call
> a few times, ensuring the test is more reliable.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index d0f6d253ac72..7de870dee1cf 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1064,11 +1064,18 @@ static void test_stream_check_sigpipe(int fd)
>  
>  	have_sigpipe = 0;
>  
> -	res = send(fd, "A", 1, 0);
> -	if (res != -1) {
> -		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> +	/* When the other peer calls shutdown(SHUT_RD), there is a chance that
> +	 * the send() call could occur before the message carrying the close
> +	 * information arrives over the transport. In such cases, the send()
> +	 * might still succeed. To avoid this race, let's retry the send() call
> +	 * a few times, ensuring the test is more reliable.
> +	 */
> +	timeout_begin(TIMEOUT);
> +	do {
> +		res = send(fd, "A", 1, 0);
> +		timeout_check("send");
> +	} while (res != -1);

AFAICS the above could spin on send() for up to 10s, I would say
considerably more than 'a few times' ;)

In practice that could cause side effect on the timing of other
concurrent tests (due to one CPU being 100% used for a while).

What if the peer rcvbuf fills-up: will the send fail? That could cause
false-negative.

I *think* it should be better to insert a short sleep in the loop.

/P

