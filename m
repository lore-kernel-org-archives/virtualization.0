Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1116BE2D
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403084; cv=none; b=M9IwvI+rcDY65zUBOhL8yjNQHZSfGNJGc/RLRr0ldF8/KE1hq2VCirbzTxGXEa8oHkZrfXEFHqkTHg1Fwve4Nq7Sk/DVjviJNKy1T0ZvfZg/ckVPmC9GxFwFiABPGg/Ehw2rpmOnnPe4DX05zPVOmbGK3PM2MChYeMQE7SLRdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403084; c=relaxed/simple;
	bh=z2u3XIUIO6fq3zsKBJpUIQZilOD/xOQQm7u9WYiUdWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3cku8LE+3jtwzdPNTFo4TWTz60w7/S5cilv0804P2sigewkPB4Dq8lLKHgSNdAkp7H1Jyte9IiBQ7ccmmvRjhbYaAf8eRmadV1PaAqMhpuEanseSNwBv5rVgkoTJDxMQe5sh/zFcqlxpYYrKdtLwQXb0Zfm/i4nh5faoQRby94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=WJz3fHMS; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="WJz3fHMS"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94A4160645
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 02:11:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wP8G5Re_Urci for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Sep 2024 02:11:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4F78160641
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F78160641
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=WJz3fHMS
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F78160641
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 02:11:21 +0000 (UTC)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so1060888a12.3
        for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727403080; x=1728007880; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf2tPCUdEA01GCYGd4noA0WD0ijkHEkhZlFEu8nmNFY=;
        b=WJz3fHMSTj1l/snOuNASKv2rgS8ILfySHLf3mgOWdHZKKS8zYXxbMyMHcp/2KKGzyq
         K+zaB1mIusBQmopRyFGLFDc+4M/yrBNG/RNMk4GZn/PsB0uqLi1XniAzSNxKm8LY8l6F
         Lu+e8qs90DtdFfxq5H0+sCUX7uDPdN06WqhAyo2cIhbmbEbcuswq2Ccf4Bq4gQ70eQfi
         70atp33/wID9AoFkGuK/+jRTPHy2UxJVEsbgVP8h5c0Yh2qhN3qihBlkleD4X6OudTfJ
         o8RxiceAllKOHhc37nmJjgAkCZ5fGbG+ZmzZCsUe6N5SskOqgbQpxn84knaanuLEIC/J
         DW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727403080; x=1728007880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf2tPCUdEA01GCYGd4noA0WD0ijkHEkhZlFEu8nmNFY=;
        b=mmA8KTMshMcv+nZcrqX04OXWY5kQif5nzSQO0KcnHXU5pg51w/oRDyEleXJYG0tSde
         sogQdP5kv9QRKDBk8TZAY8fp7g4Y1XZhP8DhwylzLAPFBTbC2gKxiAu2e2Ki8OdXPSoI
         hkT2+BI9x3YVTTdE1cQh9Ar48Nl7GmkdDxgrmQzYcBC4ccbs6CMEP29wSKpXpSR1lPjq
         qqMNDi/Wyaq6IrqGRnq3lsIJYLKEhcVGnv+rAffWpirAr5hkx9kLc3ahsbzssh0Z1lI0
         ObtGDFRUALs8EXwOClxAtYT808dRIS6gQ/+ikNfcI+nUk6+aeRjckXioCCLklKUcBBbI
         eBZg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4DnSrEuB4aSJDPPpTqLQ1D6vJsgse6JejTW2uNBzg+kPhdzhQ9h79XEuNgsM+J4XF/XEZPCPD0jwsvQa2w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzSVZGAG98bz8NQCrFdHFx0poFaLTwOxGGuNm1CNyh6+W/RxOUP
	9rPzVYUIvLdqaz7iEUq0WNHRrBtjVdEeBYagy6A3GnXhFs7JQ3mk3XTWemoMOVo=
X-Google-Smtp-Source: AGHT+IE7cjRrb25dzMXmo+VfgnfSpwEWOl/UW7HQEnq4EHsE9dGMvjEK+lxgfFogzB4DCdWpnrgmFQ==
X-Received: by 2002:a05:6a20:4ca6:b0:1d4:fcfe:e1ee with SMTP id adf61e73a8af0-1d4fcfeee5fmr1089565637.9.1727403080438;
        Thu, 26 Sep 2024 19:11:20 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc1a3sm559085b3a.75.2024.09.26.19.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 19:11:19 -0700 (PDT)
Message-ID: <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
Date: Fri, 27 Sep 2024 11:11:15 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/09/25 12:30, Jason Wang wrote:
> On Tue, Sep 24, 2024 at 5:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> virtio-net have two usage of hashes: one is RSS and another is hash
>> reporting. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF.
>>
>> Introduce the code to compute hashes to the kernel in order to overcome
>> thse challenges.
>>
>> An alternative solution is to extend the eBPF steering program so that it
>> will be able to report to the userspace, but it is based on context
>> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
>> and vhost_net).
>>
> 
> I wonder if we could clone the skb and reuse some to store the hash,
> then the steering eBPF program can access these fields without
> introducing full RSS in the kernel?

I don't get how cloning the skb can solve the issue.

We can certainly implement Toeplitz function in the kernel or even with 
tc-bpf to store a hash value that can be used for eBPF steering program 
and virtio hash reporting. However we don't have a means of storing a 
hash type, which is specific to virtio hash reporting and lacks a 
corresponding skb field.

Regards,
Akihiko Odaki
