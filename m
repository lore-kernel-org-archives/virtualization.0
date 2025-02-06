Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E2224AFB
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825462; cv=none; b=lOYAP6mRKx11ckzleZkU8W20yFRLMWe8A6Ms4B3m1TYKx/Kh6SZ9XZhRnV2S/FK2RS/TerCVgfWw9xOxSxjqQ3dBg8KlJIs+dPe/LBkQOB2xZhv1gvtQjujzk8i5Fn1S5+eMLW5+qM++wlSX5nmOAfDSokwzza2lJMmJAFfxxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825462; c=relaxed/simple;
	bh=6Z7n8UWnuTd40YxRqOUHsnsjz1hSaR5JYJ7mFXzEuEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=esy5z6bWk8kvUuPY8DFa4RUgn5USqc/1L6kSRvDnEX69IJF65cJD6BfPRVH0fJSCrZonfThGbGqOtmZqJnaV9cF3LRLVwT9EOpW1InGQQ2byk/tClBGtoZMCJQ5LABWAM3i7BalXg+u/X6D9I9i+1Hpzsiv1Gbs1/NQ8nPkhAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=bQSRdT++; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="bQSRdT++"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BD3F81B98
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 07:04:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o23bL4e3-S-J for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Feb 2025 07:04:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8F51A80AD1
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F51A80AD1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=bQSRdT++
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F51A80AD1
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Feb 2025 07:04:18 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2165448243fso15407165ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Feb 2025 23:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738825458; x=1739430258; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSMzQMG1ZHF7w5vbC9dgevornaZeizWpfwbsJmx7bQk=;
        b=bQSRdT++4K1aMVOqWh6cHm3kKHJuS2hoG1n9u383EGWelIeY6XwHcNBqL3EOQmGjZG
         MJWl0UuOR4nqfd49GWMttZHDhzyRx59hFLbgAh/O6d9butRDOaaBNB8+Ubt/vb65f5tH
         3eJBEwriITQQYME/paCfsKd2sH/WTMQB8Xg0pjOztToRDNEWUHDAd/uMXMC8674wfVpQ
         Jg/NKgzfADXH7sJQcrd9lzxQHI7hNX0+4Py9UMi98XKD4UZ3i3XkFEr/EQw/9oMotoyf
         U1HmYG6AGXtPgv5NzCxsreZgXdKhZLtnTi6TjU+WUg78c7Z4gRWvIKOudKbsSON94/In
         JrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738825458; x=1739430258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSMzQMG1ZHF7w5vbC9dgevornaZeizWpfwbsJmx7bQk=;
        b=BLMr7Oofp/aZsTa51jyUOvIzKDFSyxq1Hw84jJtaCMh3VoRJkPV+8DsywDews/jXl5
         0bT11XbHfkW8TzB6rMq8Qr4Eg0fe5rkJKMRPTRuh9wcsrNeEIBOQdc3HIsKFc/KvpB1U
         htNa6b2Vbwd6HJ+L2u7PjzhMljqVwDpKq+qPjE1z77RWvfkxgwLNnL4/hhY9EZeIiGWE
         6wCbYcqUvOS3JCeA7GCEmwpHph87zRTD85/2Cv3r57VoXi0kP4n1IFTTLsceZs6mNV12
         AeoaYn/e9G+Jyvu4YhDKGJKKRLbBXVN1H+6GFEwb3eatrmdfWV+ZoK9CrA2GCdhFp+YM
         LTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuWH5dFqsf8HnsfYQwdQ6y2lP+4fhiSQmhEJI7jofLx2dXwraNYgrwIo9ps86QVggshD0iK9cFJOMiA9gBEw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzotiFLlpbaRGkAAyg57AjCTwvfqxA2WRSOXmJthcrJ+Arbjsii
	QNlI2WE370dRzKjGdUa5aA6PZOQrkd/fKRXogzRp74id7+1EajvP4UV5rF9rC+c=
X-Gm-Gg: ASbGncupJLqp0sn8yDG8QuS/U7KCH+o9kIBwnPCLuEj+LANyXpZMbPeaFgBKTMuHny6
	6+F0yIXdrcOaXObOtItQb3YNPyjBXizrKwY3F74CN4mgMr4b4mhzz22oqjnOxX5bJd0zJCsJ0Th
	+NqBChCbbfa8uhrggrXuWfcBxdZQOJ/swJiWU5o859Vx07kw/Dux8uOT9aq3y3/HGz7IKd1S25w
	XG415OgamFpKkcPgVRiGgpn08nnSXhncIrYDwaKfLOKUW/DU0KjfEHURf/lsUgyMUfIbOukgxEY
	NVA11bl6frD0fn2qbC6xOgFKjqMB
X-Google-Smtp-Source: AGHT+IEGoYiB8pxUq02irm/CU5MvTVOQlUDfWzGd8n7ZsLH5KxtqKlPFWXhqlXZi0kPwplHWCVM1fg==
X-Received: by 2002:a17:902:f64f:b0:216:3e87:c9fc with SMTP id d9443c01a7336-21f17ddf80bmr102170675ad.5.1738825457907;
        Wed, 05 Feb 2025 23:04:17 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecce52sm481627a12.18.2025.02.05.23.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 23:04:17 -0800 (PST)
Message-ID: <8b389981-c04a-4d4f-8a5a-043b4cd6e8db@daynix.com>
Date: Thu, 6 Feb 2025 16:04:11 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/7] tap: Keep hdr_len in tap_get_user()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
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
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-6-15d0b32e87fa@daynix.com>
 <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <67a3d6706c01a_170d3929436@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/02/06 6:21, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> hdr_len is repeatedly used so keep it in a local variable.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
>> @@ -682,11 +683,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>>   		struct iov_iter i;
>>   
>> -		copylen = vnet_hdr.hdr_len ?
>> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
>> -		if (copylen > good_linear)
>> -			copylen = good_linear;
>> -		else if (copylen < ETH_HLEN)
>> +		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
>> +		if (copylen < ETH_HLEN)
>>   			copylen = ETH_HLEN;
> 
> I forgot earlier: this can also use single line statement
> 
>      copylen = max(copylen, ETH_HLEN);
> 
> And perhaps easiest to follow is
> 
>      copylen = hdr_len ?: GOODCOPY_LEN;
>      copylen = min(copylen, good_linear);
>      copylen = max(copylen, ETH_HLEN);

I introduced the min() usage as it now neatly fits in a line, but I 
found even clamp() fits so I'll use it in the next version:
copylen = clamp(hdr_len ?: GOODCOPY_LEN, ETH_HLEN, good_linear);

Please tell me if you prefer hdr_len ?: GOODCOPY_LEN in a separate line:
copylen = hdr_len ?: GOODCOPY_LEN;
copylen = clamp(copylen, ETH_HLEN, good_linear);

> 
>>   		linear = copylen;
>>   		i = *from;
>> @@ -697,11 +695,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   
>>   	if (!zerocopy) {
>>   		copylen = len;
>> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
>> -		if (linear > good_linear)
>> -			linear = good_linear;
>> -		else if (linear < ETH_HLEN)
>> -			linear = ETH_HLEN;
>> +		linear = min(hdr_len, good_linear);
>> +		if (copylen < ETH_HLEN)
>> +			copylen = ETH_HLEN;> > Same


I realized I mistakenly replaced linear with copylen here. Using clamp() 
will remove redundant variable references and fix the bug.
