Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA1E1667F1
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 02:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727403787; cv=none; b=HGrGr24yMkC0olymj/7M+huCgwKC5yn4NzGJckk4r+albCKjxuGO9s+jl/PAUDGChk06OcZDaYSXHaGksJKHjbKLoOAR9pcJ3JRBlA/cit+MQNlxrgA6icvU1G+Z6kGCftyBZVCl35Q10ETIVRLPafBZnLLCNqsYoVQhzxVziNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727403787; c=relaxed/simple;
	bh=V5nTFEg40BS9fpyNzgTctWWGF7NZtj92BLrRC7NQ+HU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgoVJCU2MaGiYWTdH8uNsYsT9bQuqJXJikGh7EXe/S+LhcTwujo7gwPHPflbUj7pKOfFpq/GhHR61CxR4P+dMP5V4ZngHKF6YzValSyiqtWt3rolJX3Ex6/yUw8Wv5g51im/8VONqiF+tcvH08ROPboVlNwE5SuAoCSseLGSFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=zcSSotp6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="zcSSotp6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A9CE845E3
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 02:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v37chdVC_Tx5 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Sep 2024 02:23:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 48928845DD
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48928845DD
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=zcSSotp6
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 48928845DD
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 02:23:05 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso1176262a12.0
        for <virtualization@lists.linux-foundation.org>; Thu, 26 Sep 2024 19:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727403784; x=1728008584; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm6FdUgor1DMp4AzKUDxfLdY/zKgjnsnnCTT3QZsc5c=;
        b=zcSSotp6/iyXwDCQ0pPb+4WdDZFx96Wqy8sshKpxn4b18mTarGEBMuQaxMonYEqwqm
         jvL4iFYN/UgdRj8LsbgRvP2jrOn9197GGSO4uHGTQvvw07JW6DgYTwqXohqoFyGJrXWt
         gTg4aUots7eQdK5DFUStEjkxiNTuFRNqvI7sDlKh1HIN2iMULqvTtSFfay84BPmbRObk
         XWd41PUXfmcFvC3NLaBIVU5WopIUPgQbOwg+iELhG61XnzeFczX0RQR/mnofjn1VP0gW
         emmIwt3Sh+qFjd5SRMXVLfVhhITkptberz5HjmRuIrtW/FxNpXwqnKKyNhMOv0H8OHDg
         TT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727403784; x=1728008584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm6FdUgor1DMp4AzKUDxfLdY/zKgjnsnnCTT3QZsc5c=;
        b=uCiXITZVhkuOb5Z28fydp5sWlJ1pMh4IYUsmjUFb4n79fpFsgYs4CsdX7O94OR0Xbw
         Yso8SqRUwXLF6BxJmaata2HZ8ux8DP0xIuaJvKU5KKbqSekiXAyPYeggOyl+M+BQRDHM
         t63UHNHKdHefAJ2JDn1ZkMh2Su+f0TMZoY9F0EEI4AF4ib8HLuLQP6rgw3ur8cYrBE8y
         dxPkxjCDSlw4++0lZaC9hDejrfsz0xFzw9a6kAUwyegkImYonZe3yQRDNgkXr2h5w/WI
         fUarWG2zn7+MooDvxehdvXZ/PpIz5M81eXH43aSDOoEUDty9EDL8c/HXnTQ9t2/gFM8N
         9ROA==
X-Forwarded-Encrypted: i=1; AJvYcCW6rbFN1mUo/qZpPaWrCHrkriFlowpIq6iRIm8mA3yGYkX38HGkBX/JwbaCu5YOo7dw7pu1G59XrIPp9QKmmQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwOMef3HhF/biChbshXXh8NDCFdhlc6TwKRiTcQVf6k9Wtq4NfW
	EsCzQcYe6zjtKg7W97Dm3AFyxvWIUqWkq7EOnCsumUaBMZAUBJfuYZmTn7Wr3/I=
X-Google-Smtp-Source: AGHT+IE8eclHHp/rZtYVB0h05WFJYdKId7bC7EfQYU296diw2AVIsMjGQmM4ppAbwhdAEFSQulsWLQ==
X-Received: by 2002:a05:6a20:db0d:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d4fa78b468mr2830052637.35.1727403784277;
        Thu, 26 Sep 2024 19:23:04 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bc443sm570468b3a.70.2024.09.26.19.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 19:23:03 -0700 (PDT)
Message-ID: <66438fad-d697-4b34-89de-528bd5e081b5@daynix.com>
Date: Fri, 27 Sep 2024 11:22:59 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 7/9] tun: Introduce virtio-net RSS
To: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <20240924-rss-v4-7-84e932ec0e6c@daynix.com>
 <20240924130550.GJ4029621@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240924130550.GJ4029621@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/09/24 22:05, Simon Horman wrote:
> On Tue, Sep 24, 2024 at 11:01:12AM +0200, Akihiko Odaki wrote:
>> RSS is a receive steering algorithm that can be negotiated to use with
>> virtio_net. Conventionally the hash calculation was done by the VMM.
>> However, computing the hash after the queue was chosen defeats the
>> purpose of RSS.
>>
>> Another approach is to use eBPF steering program. This approach has
>> another downside: it cannot report the calculated hash due to the
>> restrictive nature of eBPF steering program.
>>
>> Introduce the code to perform RSS to the kernel in order to overcome
>> thse challenges. An alternative solution is to extend the eBPF steering
>> program so that it will be able to report to the userspace, but I didn't
>> opt for it because extending the current mechanism of eBPF steering
>> program as is because it relies on legacy context rewriting, and
>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>> the other relevant virtualization APIs such as KVM and vhost_net are
>> UAPIs.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> ...
> 
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> 
> ...
> 
>> @@ -333,8 +336,10 @@ static long tun_set_vnet_be(struct tun_struct *tun, int __user *argp)
>>   		return -EFAULT;
>>   
>>   	if (be) {
>> +		struct tun_vnet_hash_container *vnet_hash = rtnl_dereference(tun->vnet_hash);
>> +
>>   		if (!(tun->flags & TUN_VNET_LE) &&
>> -		    (tun->vnet_hash.flags & TUN_VNET_HASH_REPORT))
>> +		    vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
> 
> Hi Odaki-san,
> 
> I am wondering if the above should this be vnet_hash->common.flags?
> I am seeing this:
> 
> ../drivers/net/tun.c:342:44: error: ‘struct tun_vnet_hash_container’ has no member named ‘flags’
>    342 |                     vnet_hash && (vnet_hash->flags & TUN_VNET_HASH_REPORT))
> 
> ...

You are right. I couldn't notice this error because I was testing 
without CONFIG_TUN_VNET_CROSS_LE; I'll test with the configuration and 
submit a new version with fix.

Regards,
Akihiko Odaki
