Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AF1DE4E6
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745405294; cv=none; b=EZ6TRED2blAi3YLl4Nei7/tfx0l1tPIXSfvxfaLKQQCDLU5ZahLrsbKuo+qYhtm/AjZ2EtCbZzDqjLdZCJiPxeXZy2UJ/Xq55nMvof/Ng5b3JSgOtqCYCaH+0GX4qpidLa9mdDCA17jaf00n3d5eS47GvDNJTkRy8+Tu97LCDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745405294; c=relaxed/simple;
	bh=QBBn9vTmnK8rVIlRrvQjN8xkipKr+QbWyEEEv7UESDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyeMTHGqagBtnbYr71nF424nsVeeg4lqV9H7HWRuBdg88iaTwZn2Frbluu6X5gDXbHfgG2EVBg1OyYH963k3oo/BiJQi3G6R0D/YhrmoXRc/7RzlJv9q/obDMxyFTxXamR4ATZjLGkZxnGxsvgdI1UdgBdHCwykaoKgDCMOAXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arZzhmc7; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arZzhmc7"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1016824766b.2
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745405291; x=1746010091; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yW3Ewl9XC1g0tqlHWENmHDvEOdSUdHOSXTlz2TpUlQc=;
        b=arZzhmc7uLncTkOmoYGqbxbNecqKEZ8hxR5D8yo9Zy8pgEBB5sJLRKeAOfCPpsgCle
         ZBKWAm5bd6u5q4XRPEGvUpKSufxz4vzfYFdWihhIMRYAlYXt9jYof2V7JaZIx8ISXgYP
         sy3I0+ZepYueU4SbAkvorU5scgKUqs48qeiP6WAIvh0H7sTgC6KAoPuhujCTyaRMLdmE
         Nz9gnDGNtrHYr/4qKA3C0TBBi5rFy/gsobk+c4Ishwt+XYSAGZJtNUGpHGwxmygXJosc
         CeiFVXob64+P6ZNHCuljX5c+BQZnO++/6igoPAEBoaDpweL2Yw9QjBz0VZeYGM2T+PnW
         II3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745405291; x=1746010091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yW3Ewl9XC1g0tqlHWENmHDvEOdSUdHOSXTlz2TpUlQc=;
        b=WUhbPfhBCuLmaXyC/HDy7mM3vluVOn1zkuCM7D5BugZwdt1t2S86f+lzhGrq6g0/Wc
         BA2ovQA82l1Nx3AAdQ83f3YoIboiU6dunxlvQUQQDcl3gi1R2kWpYK5EBHO/WLYryLZ4
         s+X+8aVJIl5AB3/rM2HweJLQqjk/eIfi5il55XTJd2fqAcz6EWq/9C8T/RIGorIwu0Ex
         RzaR5383iJECjjPbv9y83gwssUf15gsspeML34RrW1cTICQk2s2ot3BuPbNuCCVcYgk9
         FCFS22s3NG5RBmtdIcjp8mzUXgbOrs2fCkazOCxNLOc99QfnTdTpVGCuHFoHphOTOA3V
         A14g==
X-Forwarded-Encrypted: i=1; AJvYcCU13Znh9Rn5Y6RHy2GnaJv3rhS0/6gSqQhkmFWvi3p8ckfyyCjTGrR6w+Yba9OoC3v9WiZm48e2qGH0WGyAdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8C3tXA6xTvFc3+f9Sd/1e4iVFX5f6VRiTYbFZLYsBjrC2/19R
	zCN4OmUenSyIcMzVwdDk+g3mFENVVNQ7l8TWQwGBKQTHTAGrZGpC
X-Gm-Gg: ASbGnctt27lfNGbkQmCsRX9zjscvtuiGXLXDJ2G+BvSt9jCDnd/PV7dDzPolJxUupnG
	i2qKcYU6yEU6y1ossnxrL21HOsfI5Eh4b+xvJHiH4bnKRtuNUCBXPEPMi4h+PEQRqx73HPGb7nr
	JD3iBT+ZoV6s5T7DPTLxvWo9nSXQRmc1D5b2cbfAb0ReRwkYarvIc9XQRqLH93UCeqFNViIZf30
	LPws1epa+W97dBoBgobPFhwWEPxyCagLWNHy/XrwEY/9/GRsymz7XeC6fxWGaIKBnKM3AwSwdJx
	1GFNp3nvfsRu1gE64uoNa/nM9c6YHsltz0fb0oB4Q1SUIey9xhE=
X-Google-Smtp-Source: AGHT+IGSOkms0vGWAQQk5LDkY0uQOFjlrtaq8CZWRZeiflOHa+/oqFgsKRBzQiPT5EoHF60fgvH8Mw==
X-Received: by 2002:a17:907:1c21:b0:ab7:1012:3ccb with SMTP id a640c23a62f3a-acb74b2e84cmr1451252366b.14.1745405290671;
        Wed, 23 Apr 2025 03:48:10 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.144.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef9669csm780506166b.161.2025.04.23.03.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 03:48:09 -0700 (PDT)
Message-ID: <97fd3326-94d0-4d85-bb33-802ed88fcbda@gmail.com>
Date: Wed, 23 Apr 2025 11:49:23 +0100
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
 <c0bd45f7-0325-4e4b-b0ea-ccae24a1eabd@gmail.com>
 <8c1c6405-1e60-4512-a675-4c00b00d400a@gmail.com>
 <CAHS8izPGuF1PxfdmXUC1XJHpmRqotXh=vUY_a-AEHdAgPmLQ1g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPGuF1PxfdmXUC1XJHpmRqotXh=vUY_a-AEHdAgPmLQ1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 22:10, Mina Almasry wrote:
...
>>> Instead of adding net_iov / devmem handling in generic paths affecting
>>> everyone, you could change those functions where it's get_page() are
>>> called legitimately. The niov/devmem part of get/put_netmem doesn't
>>> even have the same semantics as the page counterparts as it cannot
>>> prevent from reallocation. That might be fine, but it's not clear
>>
>> Actually, maybe it's not that exclusive to netiov, same reallocation
>> argument is true for user pages, even though they're reffed
>> separately.
>>
>> It might be fine to leave this approach, while suboptimal it should
>> be easier for you. Depends on how folks feel about the extra
>> overhead in the normal tx path.
>>
> 
> Right, I think there is only 2 ways to handle all the code paths in
> the tcp stack that hit skb_frag_ref:
> 
> 1. We go over all of them and make sure they're unreachable for unreadable skbs:
> 
> if (!skb_frags_readable()) return; // or something
> 
> 2. or, we just add net_iov support in skb_frag_ref.
> 
> This patch series does the latter, which IMO is much preferred.
> 
> FWIW I'm surprised that adding net_iov support to skb_frag_ref/unref
> is facing uncertainty. I've added net_iov support for many skb helpers
> in commit 65249feb6b3df ("net: add support for skbs with unreadable
> frags") and commit 9f6b619edf2e8 ("net: support non paged skb frags").
> skb_frag_ref/unref is just 1 helper I "missed" because it's mostly
> (but not entirely) used by the TX path.

It'd have looked completely different if you did it back then, which
is the same semantics mismatch I mentioned. For pp rx niovs it'd
have incremented the niovs ref pinning that specific niov down
and preventing reallocation (by pp), and that with no devmem specific
code sticking into generic code.
This patch adds a 3rd way to refcount a frag (after page refs and
pp_ref_count), which is why it attracted attention.

-- 
Pavel Begunkov

