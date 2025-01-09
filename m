Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D392147FD
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736408519; cv=none; b=lTmGRu9wHM53pNewfAZ4ZfEFYiWeeo2H+QXHrU5GP5tn6izpDh6AjotABdUMrQrO4RkW7EjzwZ3ANxRq0Y0Mh2lQgsWS3qXqG83VIqrc/+2P1XajoX6xWx3fdXzQvZsmRIzAeBLgnhxAx1/bCIk4XFq0PgHvyYCB7ZGtVrNEaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736408519; c=relaxed/simple;
	bh=Pl+1xEqrW1IF0EiFRc252FTvX3vzsbZHF/HiOa6V3hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSipfA62oSvB5UanapJtTFAedqP7rtP2l2Wle5ocB4b97acJLQfXFgdenwNT2ESvnLcV/+dvUfQsnKFqdLhKQWVmZYlfmRcb5XInlaiCylxe0loIVUbfpVZXmJWX1WfsyWNuE9/JZ2PGHwC1fLpNF7l8D9zfETRq+0wV9perbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=qm7GB3wc; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="qm7GB3wc"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C1464064C
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TrdGT9RKQnL3 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:41:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 338FB40694
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 338FB40694
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=qm7GB3wc
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 338FB40694
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:41:57 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-216395e151bso7338455ad.0
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736408516; x=1737013316; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zujq2FV01D6C2KPe0/EF8xmEzpLBI/t0RD3pI7VCDdo=;
        b=qm7GB3wcQd72FCKHIDjXLrLx8SjUs1+l5h4kaGzegbS7W5JFvQk4l0nUFwYLxQDjqr
         mGDPnQ6k3r+VVkohnDoxc95DGx78MliInm1SRjo3XMAF4ARRUV7o5C90i3ihGTsrhZM8
         WgRUjCc1+tKMUqBezDxfcz+WzPs5l2hCpy5pHppMy3dDZwO4B9hOGSoIgfFb/3E+UQaQ
         0i6WRH5dFruSacRrxpW56vP6MJzPQz3A0PamRGmuoOEKGoFKOlUrseZqncNxsqYnk5qi
         mjMEua3KSZEL2HCpCR8pyAPnVT5p11GOK9+WpoSj9I7fyms5S9yGKX4hkYBTfitoJE4B
         7GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736408516; x=1737013316;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zujq2FV01D6C2KPe0/EF8xmEzpLBI/t0RD3pI7VCDdo=;
        b=i2LJJB3MlXFy1/gQUF4px4Kb9peJ1CVxvsIffUB3yoDJrMR2ZL9FZHjFo3v8iKWUmy
         Ga3AvUGrbRTB4kcIUDM5fyDqhWCevUxZFpnTnDXf8JEQKs6y4P8qtz3KBfQfLB0aBc1m
         nMPDrWFQDuzN6NcqKZZBa6DE/lOMs+ppL4NP3FCK2wc19s7mQJ/fpSWL7PMEboxBbu+x
         zKz+6AHf2i/2KHX7C0E4rhfpbIP6lyRg25KXXuCsxI3yaMarbT4VSRoVh5QJPB8K50N8
         egoi/JN8WA7NWv62lEMhw3F6KylTHRLQkh/cTC6JEPYxJs5BCVV0gfArXon7Upq0Fg+Z
         Ippw==
X-Forwarded-Encrypted: i=1; AJvYcCWYlW0Xa5VCjDcAHeOG+vQhTtM9O8XV+zdeJaeLDt8Rxsf2BIl93ohCDAc6xuG+83Fek5u29BHoqV9N6Zertg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzsrRjuv6yVkQdfOxNoKm/KqwG8+n7Ils9p/lAXihL4/9dPniK6
	HQSskxi02BKwFW2IGulkRlRW6iW6OnSqS6D5+9kWdiMvJj9kirs04ciaFOd5Tr4=
X-Gm-Gg: ASbGncsNJh6R8JJzbEk6dnuUPgaHqwyFGR34zWJPBwKhky8csxKKi7XRxg1fRiUrLHT
	DOH6zXM9MgfgFuw66iBDb7pmzd6ouqeHD2PbMzq7iHkvNf3Xnx5cI6+gdvDLJmqjCB06rCqK6JX
	Vcg3wMUZV9bOSswzdNKZUVX2iJrPhf7J1TTSHch6Gn8xextzUzCA1u3XWFlG4vaoNpRELbQMfH6
	/bXuW+mI2lSs/Gsi99Agg9GvlDQ5fkbG8Hc0H9fXS4QojRYS2Oj1DARPfanLv9tovg=
X-Google-Smtp-Source: AGHT+IHoQ1/i8R8+7m2WyjiW1QZh9ruYZdAVL4zxUuyhPIV5VRkeFn1oW3Ykol5jTRSqrVxVwBQ5DQ==
X-Received: by 2002:a17:902:eccf:b0:215:a808:61cf with SMTP id d9443c01a7336-21a8d6ca6bbmr42525445ad.25.1736408516440;
        Wed, 08 Jan 2025 23:41:56 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d44a0sm338516125ad.165.2025.01.08.23.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 23:41:56 -0800 (PST)
Message-ID: <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
Date: Thu, 9 Jan 2025 16:41:50 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250109023056-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>> tun used to simply advance iov_iter when it needs to pad virtio header,
>> which leaves the garbage in the buffer as is. This is especially
>> problematic when tun starts to allow enabling the hash reporting
>> feature; even if the feature is enabled, the packet may lack a hash
>> value and may contain a hole in the virtio header because the packet
>> arrived before the feature gets enabled or does not contain the
>> header fields to be hashed. If the hole is not filled with zero, it is
>> impossible to tell if the packet lacks a hash value.
>>
>> In theory, a user of tun can fill the buffer with zero before calling
>> read() to avoid such a problem, but leaving the garbage in the buffer is
>> awkward anyway so fill the buffer in tun.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> But if the user did it, you have just overwritten his value,
> did you not?

Yes. but that means the user expects some part of buffer is not filled 
after read() or recvmsg(). I'm a bit worried that not filling the buffer 
may break assumptions others (especially the filesystem and socket 
infrastructures in the kernel) may have.

If we are really confident that it will not cause problems, this 
behavior can be opt-in based on a flag or we can just write some 
documentation warning userspace programmers to initialize the buffer.

> 
>> ---
>>   drivers/net/tun_vnet.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
>> index fe842df9e9ef..ffb2186facd3 100644
>> --- a/drivers/net/tun_vnet.c
>> +++ b/drivers/net/tun_vnet.c
>> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>>   	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>>   		return -EFAULT;
>>   
>> -	iov_iter_advance(iter, sz - sizeof(*hdr));
>> +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>> +		return -EFAULT;
>>   
>>   	return 0;
>>   }
>>
>> -- 
>> 2.47.1
> 

