Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AE91DDA20
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431027; cv=none; b=o44PPh4Q3YRRX/83wyfnM8+grbBc7ygiK/SG6IGF5GJimkpnFVWMMj0jJUWELNw5/XuE3DhIByB2IPvLW42gbBxaVhhiE8C9PsPGveDcf2mQCJYYY5iSATB4GkzG/JUrj+jnWbBeTdu0Re1PL4GwvhHixnp1M95xYq1SIJdQhvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431027; c=relaxed/simple;
	bh=/1L4VXQZnM4TVg9Q0XEcQOC1Z7dwzdgPChSwdWfL7fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB+88Ez1MJJdPXRKx7Sk04mu0a2xR43ObcJk0C0GMGOfXxo3unoG+sbtjBherjs9ourD/yHqDx2MaBwb59pgCQII++EzeM9jjNhI2YYVrh15HtXCOEUNYjrTZuGcliYWgqTKj/JBAhQJZv59lyRYDceUavHNGDQKVttFEy98I5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EChDzLi6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EChDzLi6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746431024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYutuEk9tS5pMcj+KQxarlK855jenHaF07JshpvJP/c=;
	b=EChDzLi6mzl+nAq2PpZoWWIHgBZtCO61hU3NoUbSPU67LcNPt04D7NAns31Wq6FUPll0hL
	h47nM3WK1t2SVhIw5tDCzJMdIqpqowUtNV/G8MvDoD0+GU0yUpBZzs4PhO1+d3XrGPhd89
	4SRahxVGk9O/ZhvWMS8fcJUrA7Z69n4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-gZN1V6x5OB6Iy1aCHOGHGA-1; Mon, 05 May 2025 03:43:43 -0400
X-MC-Unique: gZN1V6x5OB6Iy1aCHOGHGA-1
X-Mimecast-MFC-AGG-ID: gZN1V6x5OB6Iy1aCHOGHGA_1746431022
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30c4cbc324bso20506291fa.1
        for <virtualization@lists.linux.dev>; Mon, 05 May 2025 00:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746431022; x=1747035822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYutuEk9tS5pMcj+KQxarlK855jenHaF07JshpvJP/c=;
        b=Hg69cMyihVnm5JGiJZF45mXPTFydV9xn6PRj+zP1p0H+29OmFz2NFk0vORGAQz8cAi
         3sztUQpv51q1XXnLrWjNMBmAEybe3eiOUCHuG5ZCOrgDSfhy5WekkAFDUjW7jaTsmRs2
         TGT1uY7kvwevmliVpsIXvNhbSNsm9qhRVi5mp6FzS4dunRumTzXG8bffl6WORK/tHOQ/
         Go/1K7M9Fkmwh4KANS4jN37YrKLqebSBFVYb75he+k47+omzylLjgP4/GL+AIf+ng0AM
         QKtnpOd+ubokIBV3DtskrdJPLV7D47M6/3vqL6yRzijMR4tvbc3fNT7DM7RPWqWtomVI
         IiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU66FGt6hllAlOX9QRq3DFTzl287jztpcyXoZnqVn6N5OBf2I5FHPOoHTr02vYox4FKJJEtFuzeqoQO5sS32A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZpG5IKUkiKf4gLxsONhz70dx12afoL5zmOF3IZlbrhk+8+vCL
	wUIAmzWRY/RrsosVy5Ynrvcj+yCCqV4ezvBY68luuVnVfmIOoT+uqHvk+yT1ctbYK6KRm4EQBH5
	MkDrbBxSYueSRBagq54WyYw7z69I/KIEX/avAQn6wkpmKwZVZbIjqKZCXK1MvGQlO3zzVA+OHOJ
	5mwA==
X-Gm-Gg: ASbGncszZvVKLW3eGMjTT2OHXDPB1q5xNp8amjCpj8Wp/ZBgm3ceQG7YiXkeFoCWVlN
	1i9eiQhZQv/Y+4Fey7z5W6cj1QzgdlNjbXXiLM51jxZYH5DZC7EvGzjJ/oP+oZO1NgCbL0hGWMk
	sb09eNm5rJJYqAP8MO2OFuf+OnfsUyb2Qiv5T1+RpEYu/tK9RaTFFvo5iK+oSQsppMRW37wp4p2
	TmXq2HtIgB+ifE4r3PSTS2sm1DHu9OvaY+/f7zfU7Qz8N2TKx1izhmyCDuMlw9xpNazk2wHFy2M
	XK92qnedNyfdz2Qnb9VHphutRbruo6A9NGFnd3NqJadzOBAgTvV1hbw9nf4=
X-Received: by 2002:a2e:b8d4:0:b0:30d:b25d:72d0 with SMTP id 38308e7fff4ca-32349056a20mr18338281fa.17.1746431021694;
        Mon, 05 May 2025 00:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsEsHgZOcmzKyEYKe53zgGMeSaMF3WinuQkv4wSGTWsyP+GpxlPUt85uINmh0HuIcOZYrSLQ==
X-Received: by 2002:a05:600c:1e09:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-441cb49494cmr15680615e9.17.1746430567130;
        Mon, 05 May 2025 00:36:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b391c42bsm162401715e9.39.2025.05.05.00.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 00:36:06 -0700 (PDT)
Message-ID: <8cdf120d-a0f0-4dcc-a8f9-cea967ce6e7b@redhat.com>
Date: Mon, 5 May 2025 09:36:03 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com>
 <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
 <CAHS8izMefrkHf9WXerrOY4Wo8U2KmxSVkgY+4JB+6iDuoCZ3WQ@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izMefrkHf9WXerrOY4Wo8U2KmxSVkgY+4JB+6iDuoCZ3WQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ap79niqXDul7L9J_oOknoR71b2BuAPjwZPw9IpFCdCA_1746431022
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/25 9:20 PM, Mina Almasry wrote:
> On Fri, May 2, 2025 at 4:47 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>> @@ -1078,7 +1092,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>>                               zc = MSG_ZEROCOPY;
>>>               } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>>>                       skb = tcp_write_queue_tail(sk);
>>> -                     uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
>>> +                     uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
>>> +                                                 sockc_valid && !!sockc.dmabuf_id);
>>
>> If sock_cmsg_send() failed and the user did not provide a dmabuf_id,
>> memory accounting will be incorrect.
> 
> Forgive me but I don't see it. sockc_valid will be false, so
> msg_zerocopy_realloc will do the normal MSG_ZEROCOPY accounting. Then
> below whech check sockc_valid in place of where we did the
> sock_cmsg_send before, and goto err. I assume the goto err should undo
> the memory accounting in the new code as in the old code. Can you
> elaborate on the bug you see?

Uhm, I think I misread the condition used for msg_zerocopy_realloc()
last argument.

Re-reading it now it the problem I see is that if sock_cmsg_send() fails
after correctly setting 'dmabuf_id', msg_zerocopy_realloc() will account
the dmabuf memory, which looks unexpected.

Somewhat related, I don't see any change to the msg_zerocopy/ubuf
complete/cleanup path(s): what will happen to the devmem ubuf memory at
uarg->complete() time? It looks like it will go unexpectedly through
mm_unaccount_pinned_pages()???

Thanks,

Paolo

