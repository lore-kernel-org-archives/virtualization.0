Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2A209F48
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507555; cv=none; b=WavN28XmYUUqYwacutbjYo8pF8Cs9NCFS6NoJeVq1MT9CBrhzrn6Qid6GHEG7AVCOxi5FV/KKPjvGai9oakuCb66WPlY67aMjTAXxX4M5KVNQJzKSunL2L2qrPHwozlmPVJye98VgI0l2lTb5BBPvSGJT2ImfWT+0EzW6x0L4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507555; c=relaxed/simple;
	bh=qXSynCY96TYG7wZ7OASI5Muii12uM+aBd0x+fKz2Q64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fapc+Chub51Z9IqzRisxwrN68tGs2DSrSWc1EuVDepaf1f0jq1roBhSsRLrCPyB1SEPWhpyKcSNHnxEW1VsYWx4CEt2OKTZjz3fFonMeXLYvQ5IwKmscfgR6p7JS9LlM78HUAkwJ50GtmCUsyiyge6M6DzdqRfzGIhOIDCrgeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=a+oDhSt2; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="a+oDhSt2"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 231B5404E0
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 11:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BsHEMKH3k2z4 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 11:12:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 46C7140112
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46C7140112
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=a+oDhSt2
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46C7140112
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 11:12:33 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2163dc5155fso33488675ad.0
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736507552; x=1737112352; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUI/Gf/iNdZ2kON6E6PSrhEkMNvEUQIh/sL8yMhLamQ=;
        b=a+oDhSt2j97CrwaKZgP2UggRaiVIYcl7pDmGXdJK4IIsSSBVtT9S7yzhstM4vfH7Tq
         vZbnhB5fsB6cz0wmzd3MGtLRRtkDQWJleyiS0AP6RKNowjhgziKKLlikIfiD1ez5v8GB
         82P9bnFQZvAvzWkciGfe3jFuzB8iZkaoy81bfMU9b6dApoaID7X36D/veT9W2/Emspo6
         ZK1YpQdsmAsicNvqDoFFFBkd8JNtf0k7WsDpHfOm7QDWu9DZ7hmOXZ6b4nsLvtgyMmms
         K0krXeQldUIlhgxUT63UpdvxG1K7DZvLwUKar9wgBcf/EX3mUMheY3aijOdSp2C7nEyW
         eyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507552; x=1737112352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUI/Gf/iNdZ2kON6E6PSrhEkMNvEUQIh/sL8yMhLamQ=;
        b=MmS5RNICCRWJb4RXj1lAd9Kv7ebvniSNQyZrZ5VBT5PYzGwoKseQWBCD1F7zUxMCyk
         yjMK5Z8eEZ46CIw53st3ozUSQP1oWvLAxSP2dcN8gP6Z/mxEINxNy7NiaG97+0so7OzM
         UEU7fMLQEGk3psusJ5tT8PW1r7saRV58IQf6+2UUvK6/5mDFT6TlVxuPXeIWDrD91Wnz
         bl8MC1/5OC71w9ZrXES4qR11AI8BrV5kY84AJm3YU7v2q3R9VLSiK89NfrQn2+6HNc/Z
         4NdK6BOuzWm7KDCPFtRDSynp6EnZtowbNWSNo0FqmTtJhwT9wwBYKYE6lMrAKT34IEde
         FiNw==
X-Forwarded-Encrypted: i=1; AJvYcCWznbZu3kMmN9HOmaxEd0AsklgUb84p/be1uad0FZ+BeiIySclR37nR5Bm2wPPjoUsqN79AxDjEJ1M3L+dopA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxIp0fh4TMBwoMkBBfkEYOs+u9TxLyIERrIq1krnQk4gyG7FqJB
	QbbotifUwnt5+COnEoO610BVix3MJ+LuskUeIVbJy2zT21qNobXQ+CT6AjSZV8E=
X-Gm-Gg: ASbGncs61S23+XvU8d50mqFOvJD1ws96i2x1pVlhF6bXZ33qoSRoJicL9NhmVeYmkME
	IhGBPNfxM4mZUd9GLY56gLFs7cl3HSg2E0dWO0GIb8aRx53qW8lEf+z53xurGLExBMomcM76pTl
	cZjIUhP2Cb/TUyEU9ya9+MJHbWlBYYCFp3CQaduIJPiCH8wxb3CsS1RMgJYXwhAj+YCczjMzf8Z
	JWY6zA8jd/xg9fhocy80tCtL6SbFeWIOy5uxBY20uw5k39waviflz007FUVxVihyzw=
X-Google-Smtp-Source: AGHT+IFsisJKA6JOrR0eUj5WfV8wXSlwG+ErpDxaHPAWov6uHn2OYu5jltHENp4vvgdoL273AAhZWg==
X-Received: by 2002:a05:6a20:244d:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e88d0a4770mr18461822637.36.1736507552500;
        Fri, 10 Jan 2025 03:12:32 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a2cfsm1373935b3a.51.2025.01.10.03.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 03:12:32 -0800 (PST)
Message-ID: <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
Date: Fri, 10 Jan 2025 20:12:25 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250110052246-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/10 19:23, Michael S. Tsirkin wrote:
> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> The specification says the device MUST set num_buffers to 1 if
>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>
>> Have we agreed on how to fix the spec or not?
>>
>> As I replied in the spec patch, if we just remove this "MUST", it
>> looks like we are all fine?
>>
>> Thanks
> 
> We should replace MUST with SHOULD but it is not all fine,
> ignoring SHOULD is a quality of implementation issue.
> 

Should we really replace it? It would mean that a driver conformant with 
the current specification may not be compatible with a device conformant 
with the future specification.

We are going to fix all implementations known to buggy (QEMU and Linux) 
anyway so I think it's just fine to leave that part of specification as is.
