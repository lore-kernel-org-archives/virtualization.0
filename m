Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB59219A91
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351160; cv=none; b=Nd5eRhoerI2qEHeVxcrWO7TuYSy2K8RuywkLV5Z9hPjDOZH5/Q/Y4iMJVqXaY6QHc4Hkm0HqgP0GB2LJ9gflT/Wtui4PNa0pMxWclMP2Z2hPkDXtrgBOcLfgYW6efP1+GjPp2w3bVZUvMtGzZGSLPTsp7uTENZRqqVbWxd/ofCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351160; c=relaxed/simple;
	bh=TuxclNuUfqcerA2pqrf6VxwnTOX21UT3Y4oqusyj6hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBtuh+QTzY+8FwhUm7+Nr3cHMoOtbTwPem6hPfv6uIgOHHPJHorfSQ8wg57aVdQIcMUI6Bc2nZw7GOllNUtPCDlehP94lk6D49L7wdzqW4/4QRZ6tHCI5coHjlk6hK3fqmbauh0s8hzi8KhSnTkn+SVmTE0+7nlqZirtVyDtKQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D20iQ1mJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D20iQ1mJ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4773181f8f.0
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 12:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745351157; x=1745955957; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ot+UV56+ds2L+x6seBu3bJVACsN/bCDZpbfhgi6yxHM=;
        b=D20iQ1mJF00qB8MTPpiEtVnAUW0JlFj1plItED5EK6jo2LXYIKFtf0yM4L19YMhMoE
         hubhJvfV5Ifkixxi9V3woz8iFvDkuhewq5mIbKUVvDK+EYaeHP+RflvjgO+6qAWvHWWc
         3hH+FpVXhw/RGsEU+g//bHIWieMRJBP/G4XfPayUQmTWkXpAYZv+7cdXs6cGYHULBMDF
         4WC36e84EpL3YNUxRSVamqtnDPzIjFf3KJQp6QAJSdDWfFFPTpy9nj4otDFzwOjsi93d
         UTmr36ELZ+ktz1bpM7RP2loVfq/+U/kd4pbTBbf0VggSwHiBpOuxeNjMPM1ompQyPY/i
         xRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745351157; x=1745955957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot+UV56+ds2L+x6seBu3bJVACsN/bCDZpbfhgi6yxHM=;
        b=oSgRdzKpu6oLwtp/Laq1jN2s0Ee1t5JhscFnnx8yQNVuVZijviv7pNA4KFzoXWdmKi
         vZYiBaeQALAwlzWypH7aKrz1c3vO6+l9nsr46y3vNuon3+HgW/0ln2NYEb6ICDiHJEM2
         MiOQfjSwdMbzxEFiBO/m7xmr8bhdxmrYlHHOMjBH2xuVMgklpQ1rP9YASsLm6JlbRKvM
         +QU3soY3TmGjsT7LxYUmz0kEpoCzdMVRL7tONI2zLwNNLwmadWP20MsOcpPiLwBpSOAt
         Y4uy/RUxLXfJ0L9KkZn0zb9TR1K1tY2nRs0dsuiFwsD/PUPG4ipE1sa9VXqsRXokNpc/
         H4bw==
X-Forwarded-Encrypted: i=1; AJvYcCUQjf8xUQ1SdWwwE4HajI3P3E3eaFh4XP1EvKn459Wd5dRKA1Y3FL3w57jTDzzq5NXWrzAEwzpRe6JG0R8nzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLPDEGGYRfY7r+a5t/Q5TNjZRCSy4YdwYUUkMb0KwU5bwiTuKd
	CWXjnWrB1tnqLZgem8c/vq9vnu/v2B6oRvBLviZSBijkZQwPMnFz
X-Gm-Gg: ASbGncsq/XaV0ZXHBFV+rovKiL4KOom50raz/gneL718TqtZNUegGJuTb37Eyf1Ar/8
	02kkJtKeJduBNpDigi2x09uvtoQUI4mX9EzMveiQpEGLRj0fwWYejwfJIxePKC/5uLHJ/lRJld/
	BoM+b5TbixcNipB6W+tT8XBuE7dzCCQKGZHFzJJSpbIozwqhtZExn2fOhBLpggHaT2R/je3Fd64
	RKvTKto1eZmBsvgUak4Zjy9YQaRg3AATDezDOEGy5zE2lzp3g8jjg0VxABdai4p+c9zj6lfnw1r
	3L9y1EHFbylcFnebTnMqXnED0tyuFypwa3dDc6RAe8CIVtVr
X-Google-Smtp-Source: AGHT+IEZ6mFfkFKJXYFnWv0R6K2e+269K01WRtESaCqbhsKRKAntvkXBD22q88SDEn1QFhrdMRwIdA==
X-Received: by 2002:a05:6000:1888:b0:390:f358:85db with SMTP id ffacd0b85a97d-39efba5edf2mr13171386f8f.30.1745351156437;
        Tue, 22 Apr 2025 12:45:56 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.235.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4331a9sm16481640f8f.36.2025.04.22.12.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 12:45:55 -0700 (PDT)
Message-ID: <c0bd45f7-0325-4e4b-b0ea-ccae24a1eabd@gmail.com>
Date: Tue, 22 Apr 2025 20:47:09 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/9] net: add get_netmem/put_netmem support
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-3-almasrymina@google.com>
 <484ecaad-56de-4c0d-b7fa-a3337557b0bf@gmail.com>
 <CAHS8izPw9maOMqLALTLc22eOKnutyLK9azOs4FzO1pfaY8xE6g@mail.gmail.com>
 <957b74ed-f29c-4bb8-b819-af4e1168d6c1@gmail.com>
 <CAHS8izM8+zG6KOhV7ysTsCj_PEty5eL+P+uUxTZhdsOSZTwmow@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izM8+zG6KOhV7ysTsCj_PEty5eL+P+uUxTZhdsOSZTwmow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/25 19:30, Mina Almasry wrote:
> On Tue, Apr 22, 2025 at 11:19 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 4/22/25 14:56, Mina Almasry wrote:
>>> On Tue, Apr 22, 2025 at 1:43 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>
>>>> On 4/18/25 00:15, Mina Almasry wrote:
>>>>> Currently net_iovs support only pp ref counts, and do not support a
>>>>> page ref equivalent.
>>>>
>>>> Makes me wonder why it's needed. In theory, nobody should ever be
>>>> taking page references without going through struct ubuf_info
>>>> handling first, all in kernel users of these pages should always
>>>> be paired with ubuf_info, as it's user memory, it's not stable,
>>>> and without ubuf_info the user is allowed to overwrite it.
>>>>
>>>
>>> The concern about the stability of the from-userspace data is already
>>> called out in the MSG_ZEROCOPY documentation that we're piggybacking
>>> devmem TX onto:
>>
>> Sure, I didn't object that. There is no problem as long as the
>> ubuf_info semantics is followed, which by extension mean that
>> any ref manipulation should already be gated on ubuf_info, and
>> there should be no need in changing generic paths.
>>
> 
> I'm sorry I'm not following. skb_frag_ref is how the net stack obtains
> references on an skb_frag, regardless on whether the frag is a
> MSG_ZEROCOPY one with ubuf info, or a regular tx frag without a
> ubuf_info, or even an io_uring frag which I think have the

Yep

> msg->ubuf_info like we discussed previously. I don't see the net stack
> in the current code special casing how it obtains refs on frags, and I
> don't see the need to add special casing. Can you elaborate in more

You'll be special casing it either way, it's probably unavoidable,
just here it is in put/get_netmem.

> detail what is the gating you expect, and why? Are you asking that I
> check the skb has a ubuf_info before allowing to grab the reference on
> the dmabuf binding? Or something else?

get_page() already shouldn't be a valid operation for ubuf backed frags
apart from few cases where frags are copied/moved together with ubuf.
The frags are essentially bundled with ubuf and shouldn't exist without
it, because otherwise user can overwrite memory with all the following
nastiness. If there are some spots violating that, I'd rather say they
should be addressed.

Instead of adding net_iov / devmem handling in generic paths affecting
everyone, you could change those functions where it's get_page() are
called legitimately. The niov/devmem part of get/put_netmem doesn't
even have the same semantics as the page counterparts as it cannot
prevent from reallocation. That might be fine, but it's not clear
why keep them together where they can't even follow the same behaviour.

Interestingly, you can even replace per frag referencing with taking
one ref per ubuf_info and putting it in the ubuf release callback,
in a way similar to how SKBFL_MANAGED_FRAG_REFS works.

FWIW, I do like the idea of get/put_netmem, it's nice to be able to
easily list all callers, but maybe it should just warn on net_iovs.

-- 
Pavel Begunkov

