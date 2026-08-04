Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC2469823
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851581; cv=none; b=tWFMzSVB8bIjozyV+SfMUV4YAiU3DbA96/sDC5NlTkoOph9JvZi6d6nIDosL9U5cvNnsNyicG/TPx1Xh2DoNDOtVmpLWlWvWbmD4KrQ2NnOWU22BZzikqZkH9XlBsOCiWt1oSf0cLfh4xXGKRpPBbrWim2jPbkrrcjWI4TlLmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851581; c=relaxed/simple;
	bh=sYuesqJRcMBILfBcDLpqyx4D7Li5OZlu3MjsUJUKCGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnHF386V0WBC3FPYZaRHdBSS6iaRmH+lzbnnR9xsGWDvGWZHJb33GBdRAIc4pDaLEjnx6VUeOwxg4LvlRzi5CxVJnPEDI/eqjEMe+FwEJ51Nn2Dx1DFJOOD1oWKLj4QmnCIZpt5gG94LtUNHdmjy+QCztrQ03HGZpFUljjq+p1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXyKc2R1; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXyKc2R1"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso5137574a34.3
        for <virtualization@lists.linux.dev>; Tue, 04 Aug 2026 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851579; x=1786456379; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drpKu4tj29YfpA+sxDZnVnvfwoyDj4O4bftTxpPVl9M=;
        b=jXyKc2R1rnUNx5yF8223ooiFrghl9cUmBh4/+QHPKSGMZT9SwFxpqqK/mP0lRxbtPn
         Qah6TN6YYSVWfLTLTRjeHwl4za/SXqQGigl2WKMZnl8gPtnoGuFT4rqOYXv7PNKRnOwm
         Fpjhzy8mtZfwunDNSgnYmu72Z25uZygKQKgfr4DCZQ1hSNMrOJtatpllhPw4lr6IlZmC
         T821Rphhv64DSLoH+hiPHg8mtp5Ft2rq946hTEID2u2DkCkj8iuneo0VLlcWhFDXgFcI
         oMErdzNspWZRz0ZctgMTtWmL5RrnMpdhj4+XGWlhw8UvjP7a/Mxa6TRqAoZ5PC/Wf6w6
         oamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851579; x=1786456379;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drpKu4tj29YfpA+sxDZnVnvfwoyDj4O4bftTxpPVl9M=;
        b=htvKWo3znUQiYXwiKUd7L3E8EqcS+uMYZyi0aVmkNsFUGERvIx7+9iad2bezcS/t9U
         6A8EED9ZXI9PPM+uKuRd4KOhCUYjF4xgECz55TgulCYczeHt9U9WXxei2n7xRr5b/0ZB
         5lQFbcYIJoSQ2uB6uPHXtC1A4KsjS5hj1+AqxT83or4ufhQ7Ay0ZOh7Gxu3BdjDPRY2T
         C5uEjFLXtwV9C+eZkHdbdYoQWeKPC6Pq+TUTT/ui+lRHKiGbLAIafrEdG7+trSbdBfFH
         oant1fM+M17weM3bNBJTnA4cCYzWBU0824A/OD1d9sEUEaUzAuLomGfkVgq87E4u4/sR
         M3zQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKDhdeFD7nVHUVC1x7S5UDgApBbCrNxrCxdRkfEQyeYFmB597RXtrrwF6FsLDsk6deSb82dF88sYcNxx12fg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yym2Bdapz+0JQViRzjqbsXcSdXLJsBHLxeG9cAYKEe7Cq/SfA82
	KuG6DesrQcgdN6nt0UR/8xG/Uev/BBYo2jhdOpzxgJVU4/bF64xB6MBh
X-Gm-Gg: AR+sD11RVYRSjhyWl9OxRjpasWp/37PdlQ3cbss8dJY5KPgV9SQOxfIXzord2cL6BtC
	TUsELY/3/axy0FS+3pjbq4l8tGXYaySQm2PKS6Fs36qvC1fvk3Isc8Y7hSx4V2mckVu9iCYAbaC
	s74f9IpZIRY8pZXofm3Zkn2qtP740XGnm+a+oqRbDDJWePeOh6LfHt/sJipuKlHRsbgtZ/W4EE/
	zSRoEzCPZXVkkeMUrOp1lYNGdyB43dH2K3GmweALfHEpwODABAmk9M7AsTjBgFRkJvfamMPgk9w
	4wg5UagDw65P+GBSu3CKK6hgCKUDCW6l40b3qq1qY7ESzx24Szh5HxgDmmovoLXD/UBSTYniWfb
	C8tcPYsektEnI7qF+KV2xk9m4RTWvaDxK1K0cks7DmgMEPKa9XtgnoIvO06jUt+lsIRSDbz/iOr
	tJpobuv3olAFvHpTpEMSROq7rOFWvk07NXlYR0YRo1t9gyWoh306STYcwFfFZLJJNk/2awmUdCQ
	FFLXw==
X-Received: by 2002:a05:6830:6018:b0:7dc:c7aa:22bd with SMTP id 46e09a7af769-7f196bedf8cmr23522764a34.6.1785851578711;
        Tue, 04 Aug 2026 06:52:58 -0700 (PDT)
Received: from [10.22.76.20] ([111.223.92.222])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df346a8bsm823526a34.11.2026.08.04.06.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 06:52:58 -0700 (PDT)
Message-ID: <1fbf5f0b-e9ed-4241-b986-76e71a1b0c89@gmail.com>
Date: Tue, 4 Aug 2026 21:52:51 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vsock: use sock_error() to consume sk_err after a
 failed connect
To: Stefano Garzarella <sgarzare@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>,
 George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
 Wupeng Ma <mawupeng1@huawei.com>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730081843.287563-1-phind.uet@gmail.com>
 <6a2958d9-5d16-404a-ac02-21940e90162d@redhat.com>
 <anGyP3hBQfO0I1Pe@sgarzare-redhat>
Content-Language: en-GB
From: "Nguyen Dinh Phi [SG]" <phind.uet@gmail.com>
In-Reply-To: <anGyP3hBQfO0I1Pe@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/26 17:37, Stefano Garzarella wrote:
> On Tue, Aug 04, 2026 at 11:26:57AM +0200, Paolo Abeni wrote:
>>
>>
>> On 7/30/26 10:18 AM, phind.uet@gmail.com wrote:
>>> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>
>>> Syzbot report an issue which can be reproduced with these steps:
>>>
>>>    r0 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>>    bind(r0, {VMADDR_CID_ANY, PORT})
>>>    connect(r0, {VMADDR_CID_LOCAL, PORT})   -> -1, EPROTO  (self-connect)
>>>    listen(r0, backlog)                     -> 0
>>>    r1 = socket(AF_VSOCK, SOCK_STREAM, 0)
>>>    connect(r1, {VMADDR_CID_LOCAL, PORT})   -> 0
>>>    accept(r0)                              -> -1, EPROTO  (stale sk_err)
>>>
>>> Basically, it creates a socket (r0) and triggers a self-connect after
>>> binding it. This self-connect fails with EPROTO because it loops back to
>>> r0 while the socket is still in the TCP_SYN_SENT state, causing it to be
>>> incorrectly dispatched to the connecting-client path. The unexpected
>>> packet type encountered there sets sk_err to EPROTO.
>>>
>>> After that, it invokes a listen() call on the same socket. This listen()
>>> call succeeds because the kernel's listening path never inspects or
>>> clears sk_err. Then, a new socket (r1) is created as a normal client and
>>> connects to r0. However, vsock_accept() rejects this incoming connection
>>> because the listener's sk_err still holds the EPROTO error from the
>>> earlier failed self-connect.
>>>
>>> This rejection causes the child socket created for r1's connection to
>>> never be freed on virtio or hyperv transports; only the VMCI transport
>>> implements pending_work to revisit and clean up a rejected socket
>>>
>>> Fix the issue by using sock_error() to read the sk_err to prevent the
>>> rejection branch from occurring  in this scenario.
>>>
>>> sock_error() atomically reads and clears sk_err, ensuring the error is
>>> consumed when vsock_connect() returns and cannot affect subsequent
>>> operations on the same socket. This matches the established pattern
>>> used by other protocol connect() implementations in the network
>>> stack like __inet_stream_connect(), tipc_wait_for_connect()...
>>>
>>> Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>>> Fixes: d021c344051af ("VSOCK: Introduce VM Sockets")
>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>> Tested-by: Wupeng Ma <mawupeng1@huawei.com>
>> Sashiko nipa points out that the race still exits:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/ 
>> patchset/20260730081843.287563-1-phind.uet%40gmail.com
> 
> Yeah, it seems the same conclusion we reached with Michal on v1 and Phi 
> agreed on: https://lore.kernel.org/netdev/148e56ec-dc26-4be2-a7af- 
> eb547b517a68@gmail.com/
> 
> Not sure why sk_err check was not removed in vsock_accept.
> 
> Phi can you check?
> 
> Thanks,
> Stefano
> 

Sorry, I made a mistake when sending email.
I've just sent a new version.

Thanks,
Phi.
