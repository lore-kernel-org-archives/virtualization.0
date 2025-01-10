Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAA20ADCE
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504739; cv=none; b=Z6srFhWNrwvrFNN0q956WLqRPj03RRKGTrYU0LnPDqDoFw73mmTKBa+JsAxjIaJHGUlnbqLO5S3YM5mMNXRkA9VFceqjvvQrzAa7ptvpNXgEF6VTUXCD/e3CySsXPB8SYAcL8W5LZezhzmPlGy0NvZMrCIO4ndGDprTE2UPit2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504739; c=relaxed/simple;
	bh=8au50NRA9MKnrMJHspaeqOs6+2vtRBg/UI1G2kjsrFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPxHR3hQY+hP6RcYNDc9sEmIv0KqOQw0kiiPVadi4BBG6QEJQFsAhkyYEcgXwcYDClv8LkbrwUksIfd+AW3AmHjPDlBhHQBISmtRUUiGXiSJXjMKrIMvNQoG3Ys1vTPsDztxoPgag3/xI82YtvFEoHDiYkdw2sih0SRBhJE9jxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=ZYgMyl3Q; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="ZYgMyl3Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B78064070C
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z42L7L7T-SD2 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 10:25:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BFC6A4071A
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFC6A4071A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=ZYgMyl3Q
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFC6A4071A
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:25:36 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-21654fdd5daso30056465ad.1
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736504736; x=1737109536; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpdUX+5YwuD+zGTb80IjIfkrR9ePLf07c4eG06u5O1I=;
        b=ZYgMyl3QItpowIWOfqFVJDhhQMz6dmAs8JFR32dvnTJAFrAP7HBRg816yG3IVcpfLS
         /PmEYnEVgIej8Yj+Nsh08C9l64kZm3/bkEyS/gzj8ukCPTlOpVsBaELGMl2uaMSu32Fv
         DB5qNgistMV+ezBT7WzsxrHOcH2b7OJJL/idLFvq+UeICjVk2D4oGGIwc78RdtvnwDYj
         o51EUz4XFwhAJBH+Nez5TBz5kb86Z/vbWxEQbube2CefsD2OcNW39KqVzyeNYf3DmxdQ
         Elp6jFzj2BgBMpiRKymev8KgM+pVjRxhyYhLHD+GIoTkjauVe3zhG9lBTHh/N5rpZhuu
         rBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504736; x=1737109536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpdUX+5YwuD+zGTb80IjIfkrR9ePLf07c4eG06u5O1I=;
        b=cbOKMG5AeuhPgBDk84WXlCstFxfgaYS66Yni0WCCdX7n9qQxDvWMeytktrfqTL4xPF
         lwqYm6ROj9zwSji/hwrca+EjKfUxuiownKzYWIDaqDWqv58Jh17HaKXPDchLCsSI0XFb
         Fe7igGN9Q1Yn4MeuR+7yxsQh+bPqbIFlPcNxz0JY2l9xtzizlRCO0QvwOhRGnbPw4tEO
         IlnwH2mZMBJTX+9rEHJALrpJdV2PLCpy4+FYV/61sQbsewYD3WbrwTRpoNLg5WOHXyv6
         aSJm+R6Pwqvvn4mQN0ggvn2CafOmjy0oi0QYZUoZ8pn4wrjdG27Nf+KAsqgLkOlNT7ky
         A6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUNth/xDayTMYKqs8S3lwdQwS3Ovpvwq62NloAu7vk9M3kP79DcJHSJbQpMlxAZqFKuzlrWkT1qGEnGRhavIw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzgpjf9nWKuAYQbMezA3co+irEORirUA/m8P/zykAdbofvlKawX
	SVGdRlZxznj1RERSrUJCvdnohN++agc7E6ncPUknx86hjbHk4k+a23BAeEEQKng=
X-Gm-Gg: ASbGncu0pTFfMxrMnmpAFOTq9Yppc0I0tnCM12ah2T9zPDI7IQAo+8pClEb07+Zv9s4
	XcQnNh3YY+ZuSQEBcA6oachmdUACoLy24J2ndaiN9MeCJFG4I0s55f4k5PtG+Y8Y023Uez2gw+q
	IhEXyv+0W0Z33OMTCgF66MsMgysD31tDQkvnbkrbEH+HWSNibA2yc3SHapjZaZFZdkovivAcnnV
	m+1vBUIt8k4Z3jYPxSUlp46Pz0LFwYiVVJMh0aWB21jHIzJlo3C4z2uN9wZzn+jSnc=
X-Google-Smtp-Source: AGHT+IEPk96o1z16upoqDF0UlLrtkOdu9nG1oSobpYhznvCU7YqxeKG3oXL/nadW69o0yG72TxPalw==
X-Received: by 2002:a17:902:dacf:b0:215:b5c6:9ed3 with SMTP id d9443c01a7336-21a83f43b28mr154387855ad.12.1736504735978;
        Fri, 10 Jan 2025 02:25:35 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253b6csm11183165ad.220.2025.01.10.02.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:25:35 -0800 (PST)
Message-ID: <4843eb55-eff2-4bc8-bed2-ba12dd46b573@daynix.com>
Date: Fri, 10 Jan 2025 19:25:29 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
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
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <CACGkMEs73Pms5FB3ouzrLsDjAsQ4OhMMDVD2LnO6kVHCsN0A0w@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEs73Pms5FB3ouzrLsDjAsQ4OhMMDVD2LnO6kVHCsN0A0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/10 12:27, Jason Wang wrote:
> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> tun used to simply advance iov_iter when it needs to pad virtio header,
>> which leaves the garbage in the buffer as is. This is especially
>> problematic when tun starts to allow enabling the hash reporting
>> feature; even if the feature is enabled, the packet may lack a hash
>> value and may contain a hole in the virtio header because the packet
>> arrived before the feature gets enabled or does not contain the
>> header fields to be hashed. If the hole is not filled with zero, it is
>> impossible to tell if the packet lacks a hash value.
> 
> I'm not sure I will get here, could we do this in the series of hash reporting?

I'll create another series dedicated for this and num_buffers change as 
suggested by Willem.

> 
>>
>> In theory, a user of tun can fill the buffer with zero before calling
>> read() to avoid such a problem, but leaving the garbage in the buffer is
>> awkward anyway so fill the buffer in tun.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/tun_vnet.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
>> index fe842df9e9ef..ffb2186facd3 100644
>> --- a/drivers/net/tun_vnet.c
>> +++ b/drivers/net/tun_vnet.c
>> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>>          if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>>                  return -EFAULT;
>>
>> -       iov_iter_advance(iter, sz - sizeof(*hdr));
>> +       if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>> +               return -EFAULT;
>>
>>          return 0;
> 
> There're various callers of iov_iter_advance(), do we need to fix them all?

No. For example, there are iov_iter_advance() calls for SOCK_ZEROCOPY in 
tun_get_user() and tap_get_user(). They are fine as they are not writing 
buffers after skipping.

The problem is that read_iter() and recvmsg() says it wrote N bytes but 
it leaves some of this N bytes uninialized. Such an implementation may 
be created even without iov_iter_advance() (for example just returning a 
too big number), and it is equally problematic with the current 
tun_get_user()/tap_get_user().

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>   }
> 
>>
>> --
>> 2.47.1
>>
> 

