Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795078997;
	b=UGJ2UAigDyr0xJ4U0Xfm1H3wVPGpPp7p9zqkmcr0Zxm/BgfKfieuLxjtrl9ha6EEMoQB
	 cwbjqx9H438pnuM9sEP711dh5ArDLOF7Sn8FxA5E//nMuw/ksAYBBH942otw4vvQrBkRe
	 JteEvAE6GWa6Ye+s1ShXdBAY6fsQdV1vA9KOs9Oz3luM7YnkagoXVPWv4E0vKdpPn8SeS
	 uT6GWswuezSbxvX5DjySi4jOw7iL3tgNjEqY6+fQHlWCV2moZyU5oCjBaBb3mAWkpsJUy
	 kXhR/Pi1MFE0dkMv+ulEYnrXFERgVhzkr3DLMY0swyl+Avv4tF+m/UkYMygXBZfBZJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795078997;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ev1ALMDJ9rqPsDXSnREH7pDpCBz175oayjjOjbBvQOI=;
	b=fWd5Ni9w8PPU6QYLvBBaC27uPUB4X6ZPKJ5CknANw2jtKcKr6hCChxDvd8q0Zne2YZMy
	 UWzvetZt7Xyo45N+BTfVBPBmP5jUr0ZQwwhubI1XBMlVyh4YLApjFohSjJnZG/ua/WuF7
	 o4KxscVECW94Fx+BMV9A4ixeC9zWv252HPAPnnZ+bVufeLt1+yogUh/bM7Ed5+gVPCoie
	 yvwkWOUg3h0OypmUlp109C3CQJ2XHHo9NuHMR8gDaykRh4ZFHCJkwX3Zc6b564gsavShj
	 WcdXbgGHi1t4Mp+bTla2jeAhs2kB+ZWYRigmW5wv+9BXgDdPe606E+btDAzljLDmL0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzJyUlZd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77008606A33F
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 09:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77008606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzJyUlZd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795078995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev1ALMDJ9rqPsDXSnREH7pDpCBz175oayjjOjbBvQOI=;
	b=XzJyUlZdvOEvO2tepLebN83cQqiQIRozPgN13M9xjpZuJij95PA+RjISxIAMujcc88nDt8
	I9TQor4SFo8rI3L8adDZtBtO+tiVbHo846/ZWh3ikXD8LewNvHdJPd9dL2QBlazCbIHAgg
	HYq3bYbdciaTRZki8sAJ07oBuxUGmaw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-1HnsxAvzNvGqTMSDhG48bg-1; Thu, 19 Nov 2026 04:03:14 -0500
X-MC-Unique: 1HnsxAvzNvGqTMSDhG48bg-1
X-Mimecast-MFC-AGG-ID: 1HnsxAvzNvGqTMSDhG48bg_1795078993
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so6207135e9.1
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795078993; x=1795683793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ev1ALMDJ9rqPsDXSnREH7pDpCBz175oayjjOjbBvQOI=;
        b=L9jOmyZ2BSIhyQdoNpgSwwZm7Ruczea2bM1q1ZA0g8fV0K60mjFejUqdpFvgnio24P
         wWK1HVCAvpFYttklZM3pVZm4l0UtWIxoQveleqh12sE7UVBzFxpqAqpW2nQBA2JTvhA4
         gNQm7+b2AuSd66zL1D7BN7r7Lg/8DXl01wqxV9iOxGJg6GnVBoLPabtoH04xYiMUa48t
         c2FHzDdDYHYbyCfDKNIqk28gGQ3nTgbbkJ9AzlmfO5zl2Z8kjlQfS87KD/kBcQIgXHbO
         DyOwTUcfieFwROjDwTuDOYLeCEAreQc9byiKYbEUtf/wIUjRXdyLXRa7vLZJEoidPnDX
         zbHw==
X-Forwarded-Encrypted: i=1; AL+hErEcfNRMX+8rhLaCmogIAhLmlzwgQlcQVkO9exT8eNgxaIRa+WSdm9s8+O1L8oza+qf6k3eNfYYDIAb/2jZYfw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/02/NbnktBxfcUAF3CJjNYYBCxoLfFHbzU7q/QEpOclLMVW6MU
	jBe0jSyfynhNMmik1/U2dD2qO863cSMvenSpPOb2oJWPPsZuOMH6R+SzGbWc2LlBOoEUyyVlxbO
	Re6x50haDpuFWx5UsTfMJ7icZOhmsMHxCXWnaFC7Qy9NrP4DPa54/OU3X8fS6kTh9SqX1
X-Gm-Gg: AYBFou0jyYUJu92ZP6I4pHofLPiE3BN7rYRr3MsQINoRW3XcjKPyK5TMpr6DAI8Zgpd
	wurvyL9WCNfVaEphiCeHqNzifeaLTg6M/pKWSvRt3huGvA4Ixk+9VMqQMi7PBqLXIMNSEuGEdC2
	x0kXLV6agPGwfmO/28AYWQO4lgskLaPP6YKObQjIQhs+p10QMCMyuZ/cI7BB0EwPTnV8R4LnrNM
	BTlZ6vvmWg5eXnngB/6WyfX9v9NAaG7EyrfI7x6DaKa0vjQxoU76ya0jU2aq1vJoqSjFWkLFoxG
	rBYRpD29sCO0xqAcBC715LzbvM9b25MROxjKDhNLNdh9lEOF2fDw+n3nwZNzJ2zWCEcvUkHcPlG
	gPq9xx8VhNeHTUfe2HvIJbOLt0EBblSe7lJIzNnQb4GKaILhyuKpoRfgjAWqGmtXb+X8RGunlSf
	nysiAgKlpEtP9N8duSGULX1wM0I67Fsw==
X-Received: by 2002:a05:600c:b90:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb860f622cmr10713925e9.1.1795078992810;
        Thu, 19 Nov 2026 01:03:12 -0800 (PST)
X-Received: by 2002:a05:600c:b90:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb860f622cmr10713525e9.1.1795078992313;
        Thu, 19 Nov 2026 01:03:12 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8526cbd0sm29541955e9.0.2026.11.19.01.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 01:03:11 -0800 (PST)
Message-ID: <a3049b70-fae9-488c-9de7-0c1613e6c480@redhat.com>
Date: Thu, 19 Nov 2026 10:03:10 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can reach
 the device
To: Bobby Eshleman <bobbyeshleman@meta.com>, netdev-bot+sinfo@kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <179487315810.3291.12142099363352099423@kernel.org>
 <avur4Uwbv27bGG67@devvm29614.prn0.facebook.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <avur4Uwbv27bGG67@devvm29614.prn0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aii4c-uL5na3gXNqjSY-tMU3A_hYBYWdWjFmajEAkZ4_1795078993
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/26 02:20, Bobby Eshleman wrote:
> On Mon, Nov 16, 2026 at 11:52:38PM +0000, netdev-bot+sinfo@kernel.org wrote:
>> Hi!
>>
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>>
>>   - How the issue was discovered, e.g. hit in production, hit during
>>     development, syzbot report, manual code inspection, LLM or static
>>     analysis tool scan.
>>
>>   - Whether the issue was actually triggered, or is only theoretical
>>     (e.g. found by LLM and not proven at runtime). If it was triggered
>>     please include the symptoms, like the stack trace or kernel messages.
>>
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account.
>>
>> *IMPORTANT*: If you do repost (for other reasons) - please include
>> the relevant info in the cover letter or commit messages.
>> -- 
>> The evaluation is done by an LLM so it may be wrong, if you think
>> that is the case please reply and explain.
> 
> This is a known issue and has come up in review of the guest netns
> series (so via code inspection).
My reading of the above is this feels like more an improvement than a
regression fix. As such I'll move this to net-next. Please scream out
loudly very soon if you disagree.

/P

