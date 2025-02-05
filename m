Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C742288ED
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 12:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759269; cv=none; b=YvBzvyEoo6HQN5ebvRIueSlXeF6KyHNitwcXz9hRFImmmXzXfzz8/hmT6qdbFWqUIMcDZ6GIOWqz9mYNTlNlxRJdYRpdqcs2wwep+vMHZr8TkLoz1stNgzJsBjDp7ijaV/T3UbJGnBVuCWv2bu8WPU/lvXNjpFUkSBD/hHWmaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759269; c=relaxed/simple;
	bh=pYhD+SHOxcSft14VFZBo/hBAX8Nxq+oO+kbTLpeDLGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwlR4My36BryloBfLZLM43gfp0Qb/NqywaLWrsIRh0W4rPPVtUm99fzN0MnF9rP2H9l8sk2Sn+CQbalS1OC9iyg7JHsMa46N9bHk4nWERWbu5vy4ii0QTXRL6yxR08q5axq5Brk5agrMjCSZcFWq+0nQbfp2+SJIcInO2a3+rMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxSfFfyT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxSfFfyT"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3863494591bso3433870f8f.1
        for <virtualization@lists.linux.dev>; Wed, 05 Feb 2025 04:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738759266; x=1739364066; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2nY810+IaZK5n9EujS3czHJOBsB42FBjuOFqVzxuj0=;
        b=XxSfFfyTX8bJk56AFrABzc1VVw9XyyPQqOWc7bpR0wV8uwVNZDILk/Hp4NZpma7dBV
         oAU5SyQOVfrBlxK+xWN21hHsI7tfZCkLSH1lgldRtlm7erFSS722UjzbKKhMN0VH4ArH
         9KmuTm0kO6omA7fWt1J4IUOiU5uMi9Xb0Uj7ckQrjqPunBcbt0/9VNgFzqn8qE+liH4s
         tw7/wLmdK0LRqGyPXfP72wxMV7dPmiahfQf5yR/dOkSa1CSs7J50lZ+HdxS8xIBSUj21
         R9GHUo/EED2mxGGynSAjYkAJ8cN3biVxJoME8eITU0VGcpBmF7nFF1ymtUrVOx8kr23w
         NUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759266; x=1739364066;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2nY810+IaZK5n9EujS3czHJOBsB42FBjuOFqVzxuj0=;
        b=PoTIU1++sbxdnZBFFK9QOfqVfzi56NhKmxm+OONA31Aiz7eG2PGYnCVZE3ekQmlAeW
         Z6aw/5GygU3c/yteybhICOJb6MfoXJ7or/ZeEprJy7mxez5lbJlfsDpsgJ+/HuXhM55X
         bXbNWgLnemyaujYBdEtgBFVf/ezkqBrZTXrbcZKbsZ0WovzgL5AnkcJxRQyI+k7x2C79
         Zdiz/972JfrH49YnNi7Iv2L+l0y0KEJERzak4bMPp7qYXQTVaWT79tM04YGZrLBR/VzH
         OTYtSj8UX7Osdss3eJ6c2ZK3dvhBA8YfvJeW0L0ScBxmP13+hwUvdcaGaqGO6VTNhab7
         RjaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1AbWy9pDll/1B/XZ0zf1FVZwIK3GKqyDh6uYG17fSvv5bu3Uy3raC/fCefXk8TxpQl1ZGSp9oTHTFRYN3GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPa8CoW814gGOYScL8OxiIDolL+g4vfgMIX2Q5AU8KHkV+boXu
	6MHxxKWyGSD/iPYSzbKOUPM5Z1jPrxG4W3Ex2LBsvxYJ5Hyk7VRS
X-Gm-Gg: ASbGncv22LoyDaipIq1J6KYGXr0PU3CRhcqJHMXp/9EDZ7pBkbiz7cYknMxbfD5++5/
	+mnVua+FwFTbsUA6SjoSFKCy0UBR42Uilgnf6KPluTWxjYtLQ7JNMNZHggikvHTd4sH3oOc8syG
	OPino0xkFlEQClPfaepk3g4jZejEtylCPCfvfoeUmJO3hgXlKt0X5zDA6b2/i9Qlk6OqD8oqIUt
	RSnB7lLZ200LKhJMYo9CM+MgYtJwTOmpp2KPm5SuLj0BWX+md/kl3SX6p4v/xOfnJeqHIEPZ6fo
	mMceUFb5NVJ2JYQJUX0+FOw=
X-Google-Smtp-Source: AGHT+IGPDh0UCfW8C0UUaobE12fAfZcaYcWV+qO1/+Q7RfKKWpw6BN/Izj4F094IN//LhwjnBjSyNw==
X-Received: by 2002:a5d:64af:0:b0:38b:ed6f:f012 with SMTP id ffacd0b85a97d-38db48868a1mr1958421f8f.9.1738759265611;
        Wed, 05 Feb 2025 04:41:05 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d93383asm20448845e9.7.2025.02.05.04.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:41:04 -0800 (PST)
Message-ID: <53192c45-df3c-4a65-9047-bbd59d4aee47@gmail.com>
Date: Wed, 5 Feb 2025 12:41:11 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-6-almasrymina@google.com>
 <676dd022d1388_1d346b2947@willemb.c.googlers.com.notmuch>
 <CAHS8izNzbEi_Dn+hDohF9Go=et7kts-BnmEpq=Znpot7o7B5wA@mail.gmail.com>
 <6798ee97c73e1_987d9294d6@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6798ee97c73e1_987d9294d6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/25 14:49, Willem de Bruijn wrote:
>>>> +struct net_devmem_dmabuf_binding *
>>>> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
>>>> +{
>>>> +     struct net_devmem_dmabuf_binding *binding;
>>>> +     int err = 0;
>>>> +
>>>> +     binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
>>>
>>> This lookup is from global xarray net_devmem_dmabuf_bindings.
>>>
>>> Is there a check that the socket is sending out through the device
>>> to which this dmabuf was bound with netlink? Should there be?
>>> (e.g., SO_BINDTODEVICE).
>>>
>>
>> Yes, I think it may be an issue if the user triggers a send from a
>> different netdevice, because indeed when we bind a dmabuf we bind it
>> to a specific netdevice.
>>
>> One option is as you say to require TX sockets to be bound and to
>> check that we're bound to the correct netdev. I also wonder if I can
>> make this work without SO_BINDTODEVICE, by querying the netdev the
>> sock is currently trying to send out on and doing a check in the
>> tcp_sendmsg. I'm not sure if this is possible but I'll give it a look.
> 
> I was a bit quick on mentioning SO_BINDTODEVICE. Agreed that it is
> vastly preferable to not require that, but infer the device from
> the connected TCP sock.

I wonder why so? I'd imagine something like SO_BINDTODEVICE is a
better way to go. The user has to do it anyway, otherwise packets
might go to a different device and the user would suddenly start
getting errors with no good way to alleviate them (apart from
likes of SO_BINDTODEVICE). It's even worse if it works for a while
but starts to unpredictably fail as time passes. With binding at
least it'd fail fast if the setup is not done correctly.

-- 
Pavel Begunkov

