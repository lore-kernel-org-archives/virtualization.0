Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934113BAF1
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745352211; cv=none; b=PF7Gaih/+PC/BH72QSaeW0/ck8SEdJxCelw0yEtViOStQJNJgegjG5azx6mD5iRNeUEGmSNMaQEspl8F2nvVmrUOwdHEqYaMAgB4OSsCrFP6NQh346l6OPPJNl4W2iKiizDO2VsR3ZQwh5nrBYj5nZkIjOH1k9hF+/nKWaOfwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745352211; c=relaxed/simple;
	bh=flx1X1PjzPEns4chd4qdAsjn7Uq40UIGYu9K3jmqWtc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kAzP34Jo0+NIaZw/qfyDBlyZ34cUBC2oj6YhVGl6HdZB0VmxCdIDXziOJ3m1NPvGNn8iCjri92Ln6WPD9fALE04/w2XOT3ZUJzxRevpxYoa82LWW1eb2/jCybMRdpSDI8ShTpOzu5Ba/N/jSbwr37pw6scDhQ67Q8NbpCW45NbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgOuC3vA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgOuC3vA"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ede096d73so41381355e9.2
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745352207; x=1745957007; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UKj7RHO7Q2wBMbkNPnOSKUZxAmZQvo37ML03ejRqDVw=;
        b=CgOuC3vAP+pvjPglLzFRFEiarRV/WP+Fwj4QjPzM2vbyzpYMBGIstVTHJ70HzJGd/g
         b+tDLapPaxM/apwy3QC0s2J8Kn2AIOaDp3TUdObEij+bd6QM19pBrZ5GV0zPVslw903h
         HYFW8eYjOkaluVEEsCG+vb5C39JZW9PZWG75CJk+B/z5wrxDI2xxHXSi4Jsbj9WL+xJ/
         FFlil1HFTkCz1Cdpdv9blqd7lupMsoFT0is8n2kKhiX4pO1PRV3/Qy1FrcF86fy68zBk
         GG7eYItaAS4vRonRP1/gtgG8YjvEQgozAFUThJchxhnM9501OH6wrXABD8DcmGq0Dwta
         651w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745352207; x=1745957007;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKj7RHO7Q2wBMbkNPnOSKUZxAmZQvo37ML03ejRqDVw=;
        b=YJw6a+hztStCqJnbxQ8NE/idMxiWGd5hN51K9ehWdZMCOVDAJTN0y5d6whq/u2R79V
         Qw4IulDhOfrOC+dyhDKTFf/H1s+jThFwV+HTgtvXA95zIV689+8UcRbJmybs923SJDm4
         jXRAHkrP6WCTEk0su6c1jiIW4riE3XK5tIsJDUoA2sPQglqHoQb6/TKeQZek8S1zB454
         Ojedyf0BL8EUBhPDqTb7CmhQKrv5+0GSOMZtROzOXfG8aaOi9ngrmknUtfU3wXjqaOrp
         uAmE5n7jIVK4yI+rIatb/84HBfHautn1Wm/DACnQV08srdGD7KR0wM/Ebja/URabWt7s
         kE6A==
X-Forwarded-Encrypted: i=1; AJvYcCUN4Fw5U8id8X3mEFp70ABs6u/X7G9x4bj0W8MLLxF+iCRjSgwtJb+cJt85vK7KaHxjvt+OztwljaqXCQ04zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbKJkT6ch3S0/LRwUs959GIUtsCI3jkP2LsoAujXrFEp7ltwSs
	IpnqUEU2Q7W+iVeYHP3JeNqGSbmGbmsZG2eoP4Ymxi3apeS/TP51
X-Gm-Gg: ASbGnctDHsUttnNybArn9/9rOMJFJgYL/8MInbJNaSNVHxsTT9zg/dob7I02SLupSFz
	EnvEK+Wa1O40+TDxfhjLZ4vqLV0NNt/tEOVErOQYM92gZ5bUELubuAVAdyHM4tj9rHmLD9M8aOL
	w5o8jgcYYkjzyJwtdKC3judi01RhU6hjW4WrlHBzslmO6i+I2ZxC9UUG5yMtEl60DlefQBF7Mcx
	NMuq9X/9+PK7MBzlXj9t/7Es4p1MbZ7rJW1Ga3XchFOGB4Iwp3FB2JnW7hVRfTvmV32Gg/lJpFC
	qUR8357c8HOi3kWa8irycSb8HKHUrFU0o+HqbQVltCfCZFzA
X-Google-Smtp-Source: AGHT+IF+gc5hNP3PcfsbBN/YhSJuJTKdae8tm4WgIVh9uwA2+dAe4gQLce8qN+vp5i5Phgl0ysqOIA==
X-Received: by 2002:a05:6000:4a11:b0:39c:dcc:f589 with SMTP id ffacd0b85a97d-39efba3d0d6mr13189843f8f.20.1745352207445;
        Tue, 22 Apr 2025 13:03:27 -0700 (PDT)
Received: from [192.168.8.100] ([85.255.235.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43319csm16518816f8f.38.2025.04.22.13.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 13:03:26 -0700 (PDT)
Message-ID: <8c1c6405-1e60-4512-a675-4c00b00d400a@gmail.com>
Date: Tue, 22 Apr 2025 21:04:40 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/9] net: add get_netmem/put_netmem support
From: Pavel Begunkov <asml.silence@gmail.com>
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
 <c0bd45f7-0325-4e4b-b0ea-ccae24a1eabd@gmail.com>
Content-Language: en-US
In-Reply-To: <c0bd45f7-0325-4e4b-b0ea-ccae24a1eabd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/25 20:47, Pavel Begunkov wrote:
> On 4/22/25 19:30, Mina Almasry wrote:
>> On Tue, Apr 22, 2025 at 11:19 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>
>>> On 4/22/25 14:56, Mina Almasry wrote:
>>>> On Tue, Apr 22, 2025 at 1:43 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>
>>>>> On 4/18/25 00:15, Mina Almasry wrote:
>>>>>> Currently net_iovs support only pp ref counts, and do not support a
>>>>>> page ref equivalent.
>>>>>
>>>>> Makes me wonder why it's needed. In theory, nobody should ever be
>>>>> taking page references without going through struct ubuf_info
>>>>> handling first, all in kernel users of these pages should always
>>>>> be paired with ubuf_info, as it's user memory, it's not stable,
>>>>> and without ubuf_info the user is allowed to overwrite it.
>>>>>
>>>>
>>>> The concern about the stability of the from-userspace data is already
>>>> called out in the MSG_ZEROCOPY documentation that we're piggybacking
>>>> devmem TX onto:
>>>
>>> Sure, I didn't object that. There is no problem as long as the
>>> ubuf_info semantics is followed, which by extension mean that
>>> any ref manipulation should already be gated on ubuf_info, and
>>> there should be no need in changing generic paths.
>>>
>>
>> I'm sorry I'm not following. skb_frag_ref is how the net stack obtains
>> references on an skb_frag, regardless on whether the frag is a
>> MSG_ZEROCOPY one with ubuf info, or a regular tx frag without a
>> ubuf_info, or even an io_uring frag which I think have the
> 
> Yep
> 
>> msg->ubuf_info like we discussed previously. I don't see the net stack
>> in the current code special casing how it obtains refs on frags, and I
>> don't see the need to add special casing. Can you elaborate in more
> 
> You'll be special casing it either way, it's probably unavoidable,
> just here it is in put/get_netmem.
> 
>> detail what is the gating you expect, and why? Are you asking that I
>> check the skb has a ubuf_info before allowing to grab the reference on
>> the dmabuf binding? Or something else?
> 
> get_page() already shouldn't be a valid operation for ubuf backed frags
> apart from few cases where frags are copied/moved together with ubuf.
> The frags are essentially bundled with ubuf and shouldn't exist without
> it, because otherwise user can overwrite memory with all the following
> nastiness. If there are some spots violating that, I'd rather say they
> should be addressed.
> 
> Instead of adding net_iov / devmem handling in generic paths affecting
> everyone, you could change those functions where it's get_page() are
> called legitimately. The niov/devmem part of get/put_netmem doesn't
> even have the same semantics as the page counterparts as it cannot
> prevent from reallocation. That might be fine, but it's not clear

Actually, maybe it's not that exclusive to netiov, same reallocation
argument is true for user pages, even though they're reffed
separately.

It might be fine to leave this approach, while suboptimal it should
be easier for you. Depends on how folks feel about the extra
overhead in the normal tx path.

-- 
Pavel Begunkov

