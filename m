Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4843FD2B
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835632; cv=none; b=iUCQu44ufyvc3ZkhB5NMvUtWqogUJ0A36W5hYA+t1OwQeXWnWW55ieBb+ogI3pDFzhjqt1msoHi4mL+xrXlsboEj5GlU+gG7ITwtCP7QHIQzsGG9SbXd+sJtgJlviGP2LCrNIzWEqTZSrC8nkKJn1g5amuc6/FyvMoD4xVwibfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835632; c=relaxed/simple;
	bh=skB/VTMTVWUWweeYibtmz/vwh56rk9b9WsCTp4BOFYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDIBJrkX6Aac3HhThHTLrLVu8SmQEYBN1EgfyQHRPjz2855pZ/pzIXdx6K2zInRO0LMU0PLDC6tbC4GcxN6VsDCbIG90sB+wNxySyUPbDdsSxjvb0v6zGolYdSh27i1i8TZrLvbsr2ob2xRRD2EKfhXw5en+C9C7YInyxs7Nevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOqcz1Je; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOqcz1Je"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785835623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNJ/sXRmHkTmqxpE76MJtCuijUeyDT/yfL/oohXB45Y=;
	b=gOqcz1JeOgoZlmkOeooND2a+O4nCNogvJyfRjlk1yyngh6oEamDvLHech2Shu/oqWCvCE1
	ClDuJd3Vy/meyBLaJgSKs40Tn7NgdsDW/sYygUKNukYSue1jDN6xlSC3IoBAaAmVl4gavL
	6CtR8kv0ybyrL0EO+K5rrcFfxQRBxq4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-X6WI_almOb6MZPVwEeZmqg-1; Tue, 04 Aug 2026 05:27:01 -0400
X-MC-Unique: X6WI_almOb6MZPVwEeZmqg-1
X-Mimecast-MFC-AGG-ID: X6WI_almOb6MZPVwEeZmqg_1785835621
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f4bff865cso2656125f8f.0
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 02:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785835621; x=1786440421;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PNJ/sXRmHkTmqxpE76MJtCuijUeyDT/yfL/oohXB45Y=;
        b=K05qScUVCpSHwnsCzwlxKHBTR4ZCbAt7ykHeclEH0glq7Y41bS9CqmouuX/z9L4xJn
         +TmbW2L1UeJ0sIg/QJ7chnrhhaLfIHUBfm6vdLAkr3nbi1sVybuARnx9bLdE84WQo1JO
         sMa8st8djDMLt+Z+Wc0ZV2udEw+ijRAGg6rAEj0wreyueblJOuhs2J9vG8vU6c08iiQM
         nzlF9WLmhy69QKwoHuBExAhoefNW/2en62h4cGaFGMh+QaOci9mLjRVcVBw+PRSjbdR/
         zNCcZIfWP9twNXRnTfb/0xxi0VFx/7kcyxaPnJdarNEjFG1vkVg9BVLuxkWml+0dn++n
         StVA==
X-Forwarded-Encrypted: i=1; AHgh+RpS2Wq69BPBPQgTdcZA1Cm3Piy6yJQHhQWAUkKD2jnRa05tANe/ZB/92zcbxJuIo5kPFQ7Xn/zaHRvuEFGszg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8HoylELqONAWaBxLy7IQn+AkiDCpLalkNKAnADyKxZMEf8V/v
	lvgEufyNq/GuQYUjxxuP2F3TLiim4Pp9d3oG/vkCDABfncdVBJGB13HN051Go3yT7LK95eyqP3g
	+/GUFueVDQQMDyPKTGVJych6EHCIZBs4baCjWbGQtJ4iX/gF+kJNBIKVC9daXJlDUko+O
X-Gm-Gg: AR+sD11g4hBStKWEvEdyE+LHJ6E4AVYZavbYiqkMXQF/xmJMl6/tbYyf+f4IRyFt9yJ
	fiyll+MNZgKH5Eos4+PKRI73wuUsjbnlDkcuoCv8MDvjpsg8jLQY8PgW5zI/QuxORQMU2sVTz9K
	t9Sr8L4otrXbYXi5BqmotpNyYtxizF1aiP8WZf8y78Re25hgyVIkC+vGfZjHHwaJiTVv59cqqFU
	CCTot6CT2lXCBv9WvMQ3tJyFKLn097G1n5yVK3g8P/cYv7SX6/TrD9Uad94u9BqD3dfjxz6rD2y
	YV2fTXf/VwaYU0qGgUgEQmhRB2sQBDzXaeKzWW96gGhaus3P9HV4w56kKXJ2baNxLEggVjnJ2zP
	MzdIYdNKOVywY/EmStkoMKPLT87WUYda3pZ9Yhv7U4pISBlc78UoH55UfYTucziR8Z4L1BfJ3Qs
	E=
X-Received: by 2002:a05:600c:811b:b0:495:6934:414c with SMTP id 5b1f17b1804b1-4980c696c7emr309462345e9.19.1785835620744;
        Tue, 04 Aug 2026 02:27:00 -0700 (PDT)
X-Received: by 2002:a05:600c:811b:b0:495:6934:414c with SMTP id 5b1f17b1804b1-4980c696c7emr309461645e9.19.1785835620292;
        Tue, 04 Aug 2026 02:27:00 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm69568615e9.11.2026.08.04.02.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 02:26:59 -0700 (PDT)
Message-ID: <6a2958d9-5d16-404a-ac02-21940e90162d@redhat.com>
Date: Tue, 4 Aug 2026 11:26:57 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vsock: use sock_error() to consume sk_err after a
 failed connect
To: phind.uet@gmail.com, Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andy King <acking@vmware.com>, George Zhang <georgezhang@vmware.com>,
 Dmitry Torokhov <dtor@vmware.com>
Cc: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 Wupeng Ma <mawupeng1@huawei.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730081843.287563-1-phind.uet@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260730081843.287563-1-phind.uet@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CyTk_sDzxPKdtnNmZomq1VkF4emomzk1KGK2WpoIGJk_1785835621
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 10:18 AM, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Syzbot report an issue which can be reproduced with these steps:
> 
>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>    bind(r0, {VMADDR_CID_ANY, PORT})
>    connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>    listen(r0, backlog)                     -> 0
>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>    connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>    accept(r0)                              -> -1, EPROTO  (stale sk_err)
> 
> Basically, it creates a socket (r0) and triggers a self-connect after
> binding it. This self-connect fails with EPROTO because it loops back to
> r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
> incorrectly dispatched to the connecting-client path. The unexpected
> packet type encountered there sets sk_err to EPROTO.
> 
> After that, it invokes a listen() call on the same socket. This listen()
> call succeeds because the kernel's listening path never inspects or
> clears sk_err. Then, a new socket (r1) is created as a normal client and
> connects to r0. However, vsock_accept() rejects this incoming connection
> because the listener's sk_err still holds the EPROTO error from the
> earlier failed self-connect.
> 
> This rejection causes the child socket created for r1's connection to
> never be freed on virtio or hyperv transports; only the VMCI transport
> implements pending_work to revisit and clean up a rejected socket
> 
> Fix the issue by using sock_error() to read the sk_err to prevent the
> rejection branch from occurring  in this scenario.
> 
> sock_error() atomically reads and clears sk_err, ensuring the error is
> consumed when vsock_connect() returns and cannot affect subsequent
> operations on the same socket. This matches the established pattern
> used by other protocol connect() implementations in the network
> stack like __inet_stream_connect(), tipc_wait_for_connect()...
> 
> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Tested-by: Wupeng Ma <mawupeng1@huawei.com>
Sashiko nipa points out that the race still exits:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730081843.287563-1-phind.uet%40gmail.com

/P

