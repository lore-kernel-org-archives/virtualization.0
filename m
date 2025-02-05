Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC11FC7E2
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793777; cv=none; b=kr7JbXkdwTQ62duDluCK1qq4VJiMuxI3vVFzENkpSDsMVQKoUplSOkDazvUR5E/NdXPGHnim1Y9RFuyhhrq7XCWpQGLgxE0D8GdgFOeLF/u49ZoP075Y1evkX9gIBbxNhTZZlv7vJ/NBaHAaLNFqJYys6NU02EInDubiluR8qNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793777; c=relaxed/simple;
	bh=55U68o/HXEWOrqm9K4AOTOcQCPWE93DnNhIT8Ds+a4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGlu88TxDHbJ0m+t6I0LLV/TphcrOul6GUxE+A/vGQoiPR7MkJ9VT1WqF8ET73rI43ttpND+AACLAwTMwpbIFFWPXkP4dedsR+lB/CHtt5cAJanUNHPwk0oU50JfSHJAijGRhXiczi1Py69+l7KAawGJAjSZuyHD0gQ24abNMUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajfg3Rdt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ajfg3Rdt"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38db2be2689so872652f8f.1
        for <virtualization@lists.linux.dev>; Wed, 05 Feb 2025 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738793774; x=1739398574; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdDVNZ5dZQ4AB4CLiIP63HC/J89SDxWWeBPv4iIwUpQ=;
        b=Ajfg3RdtXoKPXxm4YghjyyECQzuLyp92IBrEqY3hVinu7zcOJmc36I58PNbD9AT9Sc
         UIYtzK8JjtbF+5K7VT4wCPcLjQaxDcmyQc3tq223VM0Tz83P+OTIVOZ6oebzupEu44Gn
         nf2hn4/zGMsU7heXFAfZmAyigccgxYX4xfJN3Wwqr2Nc3wX3HnxqtHX3u/L+e0C5MIcD
         2KVbt4/ZOzEc+BuXMOs66opbMHT3Fxdo+O6A51UfTjEjEv3aiNIhSEVvftoyTX37h9hJ
         p39rMS5n/0ABkw+Pn4glK9r1w8mbMbK7W30zpsOm7qBN994lKIlPNN9r4bfHYvQoe3aM
         20WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738793774; x=1739398574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdDVNZ5dZQ4AB4CLiIP63HC/J89SDxWWeBPv4iIwUpQ=;
        b=ANfBt2gET+ouKTO9WEgS6hlDRt/A+GCqY+mLMqY6AIWSYmYtgGpLKG0Rv5qhFL7JoK
         I5e4w0csiRgfQCuboI6o1gh8aQIXrVGRVkAVZGWS5ka6UiWdnvhn7zm4YszwFpuuLGDL
         GEC4PHt3QX82PKcJbpd0GY8m4Slq7T7cDjkJSMs3RqBq6qm2xV7WfsrcMSgwhg7+ZaT+
         agO8ZSgVHVxzIn1knArswkLQgD+2IhSqFahDIolDT7hNn2LgZSqWdJ7NLphmmRGbqa7J
         l9lHOK9IGb4iU4QQXPNi3v4RXgZPb7Z23sHi+KqQkl1lxXC2BeknMztifGkdQPX1hUgY
         /ONg==
X-Forwarded-Encrypted: i=1; AJvYcCUxjlUC61zctQrb09Rt5owYSLR7gO0Nb8BE351cf6j4/KjVlPPh8HGjuYuewT7TMHYytR3scAsVmR9+bSWHlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMTlD9QG0CEvP7w4ob//uUjo8P3WsgdLOdqR5nWBqU5hcPMjAU
	aq7PA+8vUziBg54QaIqirfIyddvXE6tl2zIVehhhHCbLy1RaI+4c
X-Gm-Gg: ASbGnctin+kci+fp13WJ24WVvdK3EAidSZbYlWQrSB/Us1e2ZN2gmAxoxOBdkrDQIsq
	zdO8vZCH7N4FRv4yy+XKrKU2UdQB9DzW57/wszWfCvwZtquI1/rXJagQyVeLgi9JuV+qk8lWUOH
	094zbNszNaxsb9Z7H4aGtrVb5+seeU/tCJ0+R3hRL36jcVc6caZp+yE513/+VVvDi0nYHyl+Hhg
	HIbw9/uJaFZMsNMbye+4mbYMRFAKLoKONnNeCFEwTNl8gK5WrSazyWzI8E3Yb8sipLefHrsoevJ
	lkWe5Czhhop4bIoo759qlck=
X-Google-Smtp-Source: AGHT+IEdwD8+gf+P54b0oq9+6IB9SKMe1dPj4BWvNK0K6VPumKorBNlE9GpHAOH2VL8CKukBAjBygw==
X-Received: by 2002:a05:6000:4009:b0:38c:24f0:fc28 with SMTP id ffacd0b85a97d-38dbb20b3d7mr501077f8f.3.1738793773653;
        Wed, 05 Feb 2025 14:16:13 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c122465sm20046771f8f.47.2025.02.05.14.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 14:16:11 -0800 (PST)
Message-ID: <88cb8f03-7976-4846-a74d-e2d234c5cf8d@gmail.com>
Date: Wed, 5 Feb 2025 22:16:18 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 5/5] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <53192c45-df3c-4a65-9047-bbd59d4aee47@gmail.com>
 <CAHS8izMcs=3qo1jhZSM499mxHh10-oBL6Fhb2W0eKWhJGax4Bg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMcs=3qo1jhZSM499mxHh10-oBL6Fhb2W0eKWhJGax4Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/5/25 20:22, Mina Almasry wrote:
> On Wed, Feb 5, 2025 at 4:41 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 1/28/25 14:49, Willem de Bruijn wrote:
>>>>>> +struct net_devmem_dmabuf_binding *
>>>>>> +net_devmem_get_sockc_binding(struct sock *sk, struct sockcm_cookie *sockc)
>>>>>> +{
>>>>>> +     struct net_devmem_dmabuf_binding *binding;
>>>>>> +     int err = 0;
>>>>>> +
>>>>>> +     binding = net_devmem_lookup_dmabuf(sockc->dmabuf_id);
>>>>>
>>>>> This lookup is from global xarray net_devmem_dmabuf_bindings.
>>>>>
>>>>> Is there a check that the socket is sending out through the device
>>>>> to which this dmabuf was bound with netlink? Should there be?
>>>>> (e.g., SO_BINDTODEVICE).
>>>>>
>>>>
>>>> Yes, I think it may be an issue if the user triggers a send from a
>>>> different netdevice, because indeed when we bind a dmabuf we bind it
>>>> to a specific netdevice.
>>>>
>>>> One option is as you say to require TX sockets to be bound and to
>>>> check that we're bound to the correct netdev. I also wonder if I can
>>>> make this work without SO_BINDTODEVICE, by querying the netdev the
>>>> sock is currently trying to send out on and doing a check in the
>>>> tcp_sendmsg. I'm not sure if this is possible but I'll give it a look.
>>>
>>> I was a bit quick on mentioning SO_BINDTODEVICE. Agreed that it is
>>> vastly preferable to not require that, but infer the device from
>>> the connected TCP sock.
>>
>> I wonder why so? I'd imagine something like SO_BINDTODEVICE is a
>> better way to go. The user has to do it anyway, otherwise packets
>> might go to a different device and the user would suddenly start
>> getting errors with no good way to alleviate them (apart from
>> likes of SO_BINDTODEVICE). It's even worse if it works for a while
>> but starts to unpredictably fail as time passes. With binding at
>> least it'd fail fast if the setup is not done correctly.
>>
> 
> I think there may be a misunderstanding. There is nothing preventing
> the user from SO_BINDTODEVICE to make sure the socket is bound to the

Right, not arguing otherwise

> ifindex, and the test changes in the latest series actually do this
> binding.
> 
> It's just that on TX, we check what device we happen to be going out
> over, and fail if we're going out of a different device.
> 
> There are setups where the device will always be correct even without
> SO_BINDTODEVICE. Like if the host has only 1 interface or if the
> egress IP is only reachable over 1 interface. I don't see much reason
> to require the user to SO_BINDTODEVICE in these cases.

That's exactly the problem. People would test their code with one setup
where it works just fine, but then there will be a rare user of a
library used by some other framework or a lonely server where it starts
to fails for no apparent reason while "it worked before and nothing has
changed". It's more predictable if enforced.

I don't think we'd care about setup overhead one extra ioctl() here(?),
but with this option we'd need to be careful about not racing with
rebinding, if it's allowed.

-- 
Pavel Begunkov

