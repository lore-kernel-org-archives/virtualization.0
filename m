Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C859414F9E2
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737438289; cv=none; b=YTkUsRyLfQDHJF4agelP5eMimXC2mOV7ky/wq1oSihKEW/N2k+2gSneJ2yj9uE46JN7vk199jksuEaxYk+oMTfiYZTKwdd7ZhrJBe5lSXjbYsKKtPUmOcMTBY+GHJEIYtb6GiY/0xsO7K8gFVAnxn6j8oiTzRQihNmIIugVrwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737438289; c=relaxed/simple;
	bh=KKjKQrSywZ/HAtYTFy2CTQDgCf1VU2GQ+lX5cc5vXaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rzcdeIPFUjfFahBjF5q0kCT++6S1Fs72Ry4jrS6PUUhN8uSZoQPPbYsmwTgZRZ9ecw8AvmCren2xWVWXPRP1tVabzer5WzL02Tu0I8EETfm0ASMVKsq8WAztrxwM1RgZtZcAkLS7/T3fsU5RpatIM6GV5ADGuPC0rpW03p3Tc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=prscOcRU; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="prscOcRU"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69DB284029
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 05:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jjOPbpSWDOde for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jan 2025 05:44:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A8C7284028
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8C7284028
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=prscOcRU
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A8C7284028
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 05:44:46 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21654fdd5daso87410765ad.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 21:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737438286; x=1738043086; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quek95SDTYVXYnePfXxFQzmJR+Lu7obq+8lhE5GmOzk=;
        b=prscOcRUbc56z0McDbYCo2fMzxAmEnQbYbN+Nl3NHgF7l2uwEOCCmXzZmkH8pYX266
         nmUW4CMAJAeGP0VTPFf6an0c55hLbGGoRjvcQBbGW637IiOJUYxybH9V7RdDTfqx3ujF
         54pyuV5+M96Dy6HOOkEjl+KbmxBD4x8nBQj6FEKw1suzUeBqS6frLXoN7YrDeFFq9q5E
         gHri3JR2/1szT7XOaBFI1FHj3lJ8JNoguaZbcrnZbwtlZYyh7BFpzK4myRe2Fjl7YOqL
         tSNm65RhpXd6uxI1zbri50jikRtZYS/4D9Ky+vuq4Za6D8CZO4PO4Ff6jKdp3Ysy9Y3o
         6Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737438286; x=1738043086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quek95SDTYVXYnePfXxFQzmJR+Lu7obq+8lhE5GmOzk=;
        b=EOqax1U7waCiTKn41eqDIVvuJ5Fievebx1FNaOc/92e9P5Un1ZKY7QJB7ArdNdT3y8
         i56CeGKeMl+uII2Yo2BnmJ2vbiaunLmDLB8W0ECGirq5scXwu+LJzPeDZIDsUhtK1XVe
         KR6It4LtyP4FW7lRHnhrmrroxb/Pas3Y4VyDpa0OBhqqoLqD2vdU4ufq7viWspDB4QJk
         rnkjg8ZAft8XKOb1BqfEdHEeZwfwg1fuPgw+XJQu7rY7W39OH/7kXXTCSlrwsF58RE7N
         tpJxrNuv9zqRshrxpKkKAjQ+73H4S5fqjbotrLlUq4gOZxSaArj1oIau9QhjRwHnZMGn
         9Trw==
X-Forwarded-Encrypted: i=1; AJvYcCXfEzf3e7/q6fW/SIB0yq1/HuXoJUIjJeW07uVoryK2euYnrOyZ5ipvZH8u5khOOKj7rzT6EhTekT+R92JAsg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzRKJy/UKfjBvfa4HTsyx0JjRPHmi4ZUcIj+ZSRfSDp9r4UKBUt
	iPufX98OyX1o8Vo7nNST8shQtIurLuwmnoa0zYm6amchVas4iPeZuoSTRq0rDec=
X-Gm-Gg: ASbGncsDv4mlFyGP8QfJqPIsC+IQkSIdf/qReMeEbatl7LHwhIiRlgyX5KGM1KSBeU2
	URMV1Ub1Q8duecv745RSy9U/NI09zvafmzF6bkNWI/iocq6DXycKh7zFA4oy5VDT6OwiGyPM8Tc
	ozRtjhGoIh83nb3t6wJzI2NEP7+Hou8RZQHQNkPRayu9GvpQl18O6RH12DZLrhF+s1lz834CaFH
	Z8KHw3g57W/9wXtwLzm9FlTmWfTzXuIl6v6EJq/1/SBT7kYG9OaXGNmIjpPfAl+oOkNrrAMqqRa
	frYs
X-Google-Smtp-Source: AGHT+IFTVBGY3mBtHPPZNgGiKdheqCTQ97KHaRubQObIyg1+VGXEf+v/0x6j6pVWQSFPga7FkyMokQ==
X-Received: by 2002:a05:6a20:2524:b0:1d5:10d6:92b9 with SMTP id adf61e73a8af0-1eb215894f4mr22737961637.30.1737438285826;
        Mon, 20 Jan 2025 21:44:45 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dababc174sm8360634b3a.178.2025.01.20.21.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 21:44:45 -0800 (PST)
Message-ID: <806def7d-16f3-4d53-abc8-7d18e8c22dcb@daynix.com>
Date: Tue, 21 Jan 2025 14:44:39 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 8/9] tap: Keep hdr_len in tap_get_user()
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
References: <20250120-tun-v4-0-ee81dda03d7f@daynix.com>
 <20250120-tun-v4-8-ee81dda03d7f@daynix.com>
 <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <678e327e34602_19c737294b4@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/20 20:24, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> hdr_len is repeatedly used so keep it in a local variable.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/tap.c | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index 061c2f27dfc83f5e6d0bea4da0e845cc429b1fd8..7ee2e9ee2a89fd539b087496b92d2f6198266f44 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -645,6 +645,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   	int err;
>>   	struct virtio_net_hdr vnet_hdr = { 0 };
>>   	int vnet_hdr_len = 0;
>> +	int hdr_len = 0;
>>   	int copylen = 0;
>>   	int depth;
>>   	bool zerocopy = false;
>> @@ -672,6 +673,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>>   		err = -EINVAL;
>>   		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > iov_iter_count(from))
>>   			goto err;
>> +		hdr_len = tap16_to_cpu(q, vnet_hdr.hdr_len);
>>   	}
>>   
>>   	len = iov_iter_count(from);
>> @@ -683,11 +685,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
>>   		linear = copylen;
>>   		i = *from;
>> @@ -698,11 +697,9 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
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
>> +			copylen = ETH_HLEN;
> 
> Similar to previous patch, I don't think this patch is significant
> enough to warrant the code churn.

The following patch will require replacing
tap16_to_cpu(q, vnet_hdr.hdr_len)
with
tap16_to_cpu(q->flags, vnet_hdr.hdr_len)

It will make some lines a bit too long. Calling tap16_to_cpu() at 
multiple places is also not good to keep the vnet implementation unified 
as the function inspects vnet_hdr.

This patch is independently too trivial, but I think it is a worthwhile 
cleanup combined with the following patch.
