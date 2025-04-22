Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604C25E45A
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311432; cv=none; b=QpWEXaiZlrtEUqWInPjv5vFRAEtT0xqXAIrDaCMCP6Cwmr/revywCGwpvPM3NVu0B9XeTweL/1LqhMyRVKattvCNqRn3ZmhGGLEv20glngJfR5XYL2zGL2iCuxzfdy1tZ684k1DtLvKMpsXfs/9aiYZ4Q42xxLXafoD/eOEc6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311432; c=relaxed/simple;
	bh=lqD7m89r2sQrsEOmBfAzRt8RKN827E6V2hOjWrQC4mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lS4SUd4wqfue1F6+zrJ7DJXNYSbWCcggKJatgVlD/s8Y8R6fyPEMkNd29d+yLhIKihfNH5VBAOsYKnZ9YHN8UndOENlqCn5jJZnVuvU2Wgz3pviQiLlFpLh+C1rgOToN08sKJOkF7fSyX0wvLZtP2NZLebL2DTeFpv8c/ZUsRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfJr0arT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfJr0arT"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso6734137a12.1
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745311429; x=1745916229; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03SE0QEScorD8X63ZKpeNL8JKETFXurDVO26PPtrnKM=;
        b=jfJr0arTE+5DeN7YA6sdWNIgyIpquKQoeu+9EKGqST9G/pff4w6tMb5a4hwy3SeigT
         oMGQ+gucWus+yTrZn/RVFx53avMAi+is+uZVkTO7xgLtLFdFrKwnJAUqO3j53VdNs2HK
         4suUjKGUVGGbJbmnLpkudkhRc4HF1RmFjtLGoy4tL2VJk32KFtMw9tnANlZcJJq4E9G0
         IJdxpfs/rjtdUg+TW2iN9Pp5jhf9kkDMxXf7u0lXaVo5tZTPrM40F99QkipuIAP+mEBJ
         9DHNLXJrfI1aq8a5yhlmFEFpNAdZaZK7gSFYTy7mejtLmhjV4APD7H+xexPDFSH2vSdP
         0swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311429; x=1745916229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03SE0QEScorD8X63ZKpeNL8JKETFXurDVO26PPtrnKM=;
        b=SkMzxvIFut/IVWhAvXLlp5m9nlxfPldAje1n66XXQvfYDG7Vu76yiY3RJ0sTbTyQVJ
         uD0bexFin32wl3onEPY+zWxX3mserEorTfhTRHfEYPoytPEYMtQFEnyJfsuZENv8FDob
         E8OB+qd5yOfp1V5PHscwab6VoCjLpgkC4zzJxb60SLIfDqDtpxcOa52oqfuva2BZ9Tox
         +Fqk6xr+69eqCQJaZAWcj2qNy+69jKOaaXCpgoOnBnZ5/XyqMpjFV3H4KFG0YHrzrNf3
         UitgwRuTT1CBCUnQXRLl45EobOZb/65p6VfSnehM85KHswb8KdcbblF2sPAikTZZYCBr
         434A==
X-Forwarded-Encrypted: i=1; AJvYcCUpvPdcj2ZR4KCIPjgZH/lWfEHXZCauZA1U7NpCKr71Ob4yIACCiQ4N5RcG+gNeXDAQHD427JMUmesz47+ikw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrP60X/p6CG1C+e5BYOWT4+oErVWr+VNmxdxrs7aaxETsOnfu+
	7LkkBu6R0+GbDJhf0Xv48xQsyI+zn0+Y8aTWgSot1DEezKX571Vk
X-Gm-Gg: ASbGncsq3B7Q4Rq33tD+2uGAc+ixHzvK1B1OnG4hhMIqAUSmLWpViOMyfwjNDFuJYcz
	JHtoe52bkFaiG9gTf3OC7VG1CGQjsMZ7heBnzeecGh4lC9I3LeU/9Ls7Ag76KuTFdqrF4zPt+wl
	AtftZDOu1Zls+gwUkq63ScfuqFzgw2ZUglu9r+FjPJ0FprzcUdmy/jssmc5WIhvDyXJiODnpd6x
	hMoxy5U17A2qHw63f4HMlqi56TFVb3EzhD9PfwXUG/e9lFE1n4FFoQCkM7PRu7fy+qHrMzy6fYm
	f/ZFZOBpByhjH69xzcHV15tF/VDM0rYV3axViApafq/R5pyATnnkG3L39ymNXYBc
X-Google-Smtp-Source: AGHT+IHwRLxRlfj/B+cZPJBkcYi+NC7m90ZU8vBSpXmplNdykziG156hWUX5aB76mCTOP3JqMinJQg==
X-Received: by 2002:a17:906:ef05:b0:aca:db46:8170 with SMTP id a640c23a62f3a-acb74e79d11mr1252517166b.60.1745311429050;
        Tue, 22 Apr 2025 01:43:49 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::158? ([2620:10d:c092:600::1:558d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec42af6sm623375166b.43.2025.04.22.01.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 01:43:48 -0700 (PDT)
Message-ID: <484ecaad-56de-4c0d-b7fa-a3337557b0bf@gmail.com>
Date: Tue, 22 Apr 2025 09:45:04 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/9] net: add get_netmem/put_netmem support
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 io-uring@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250417231540.2780723-3-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/25 00:15, Mina Almasry wrote:
> Currently net_iovs support only pp ref counts, and do not support a
> page ref equivalent.

Makes me wonder why it's needed. In theory, nobody should ever be
taking page references without going through struct ubuf_info
handling first, all in kernel users of these pages should always
be paired with ubuf_info, as it's user memory, it's not stable,
and without ubuf_info the user is allowed to overwrite it.

Maybe there are some gray area cases like packet inspection or
tracing? However in this case, after the ubuf_info is dropped, the
user can overwrite the memory with its secrets. Definitely iffy
in security terms.

-- 
Pavel Begunkov

