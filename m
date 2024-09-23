Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA619FA91
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114286; cv=none; b=Np0OSdrPzXOK7Gcyg/CUNwnvKejJpXrY+vOcwcRNmwEkLOFZhO7HPnJP/54H7f/53C2tIVMyT0Xt6cMMXl5veghwN7vlEfq2GYkeWOJHiNcaNVwZE94PqXfd8zXSUfcm/NICAZr+lns3ldlD8cBwQbzKjV+tA7BwfNWcPaL5a/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114286; c=relaxed/simple;
	bh=uZwoYgcVajR3HZVdBXuMYB+l5DXtrqtEemr8LFR4GzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlXAkk8HBd1bXXQMTlgPxghW8lvA9XyyQl4Ng4f7Vcp8fw/tdACCWLL3PdvRSxzobgwU1ZYvG1YmcX60lhV2F0Q9tZNVSUzUePnxpD4esH3ioU6Uo73bi7m17+ZcMt5rumRPC6sr96T4n+mOcpOSecYcnP7P7kDV5EgDdqR1wYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=w0FyLu/G; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="w0FyLu/G"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ECC4640A8A
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 17:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XpJmTyv5BjLs for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Sep 2024 17:58:02 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 369E740A78
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 369E740A78
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=w0FyLu/G
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 369E740A78
	for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 17:58:01 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so7016974a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 23 Sep 2024 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727114280; x=1727719080; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8B2VxfA36wALlD20rKzanMGJ4TcWL9akGgnKfYckb4=;
        b=w0FyLu/Ggrf7kMve0c/BCpvq+P7NYGpvN6xjphW1bxXADwAdnwpCoU9L9Gnu6jTnaF
         m0Na+7DtoCJBFu2LG/hVzsgA+eMfHTk/qQsQjlrMqXdX8hR9dsjyUo+jaH6P8dpadgmJ
         jmOv+WZr3ThH8RAqR3tfVOcelA2ofPCIItDTQXzpvW1x05CPSBbAmvnfNsYrfozObw8h
         SSFu7tflNBdaac8Z4ka1Eq/nH22QqK1AUrncOGKDtd5hW12vXPo7mA3U3uUy0BNZdMZi
         U8c45O1h+vodMwMD2h94E5dFVtb671GqjtXFcAmAotWl4uGBNqwrpvL8TjxrNzTJjet3
         M69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727114280; x=1727719080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8B2VxfA36wALlD20rKzanMGJ4TcWL9akGgnKfYckb4=;
        b=gujv+EeRkKbLnncrY8eZMYEoo58UW8JG/ul6NEi7lIjsf5km7SL2IgVLYLxsg9gZ6S
         PwTJGMmJ+b9GZl+NyzPy4CvwteP2QzSYgVAVvUmW9a9NmpASczTeKS1509o3ujObojbD
         bNSMQBRATgrHxsWti357p26YFTpS0RJOVa6UOFf0EG0RwWxigrqMA3BqtNztYpcG9zqW
         YRix3mXcltXPa2MUsdD7bhRXafK/2t00+IDpd0W/3C6vXcWIpWsb1UsudwPvaMCeugaX
         JQoFdWeso89XbrTj/N5i1GxjlHU2eiqiMM6dGc14fkyJskU+EGBuwlCLBUMBtX+uPM+O
         3HlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOKYf1VNip5vY/walM1BQz4hV+u5foHwdFY8yl91T4tYArjy8aXbzOHwF76tf7mDPs3z5RW/jQK40cpFzbcg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw47exSCAmN+Uo6VybhNDjls/GFlbDKXIqCGSrMNGlfmVOfFkqN
	mCS4tYaYpRot6i3TmDkfrFKZwRUa6A6k5soUvtKoFXeVatSYNfcmAkldHy3gVKY=
X-Google-Smtp-Source: AGHT+IHxrY3ucRKh97wx+nkV5psN+Kb2p868ccznvAGCqF4s1A84WPgovtg4ccAlF/He1jwEhUdFDQ==
X-Received: by 2002:a05:6402:40d5:b0:5c5:ce3d:41a2 with SMTP id 4fb4d7f45d1cf-5c5ce3d41ccmr501122a12.10.1727114279788;
        Mon, 23 Sep 2024 10:57:59 -0700 (PDT)
Received: from [10.102.105.220] (brn-rj-tbond07.sa.cz. [185.94.55.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89e2asm10550958a12.73.2024.09.23.10.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 10:57:59 -0700 (PDT)
Message-ID: <e59f0525-4f3b-4f9c-a359-659fd47dc385@daynix.com>
Date: Mon, 23 Sep 2024 19:57:56 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/9] tun: Introduce virtio-net hashing feature
To: Stephen Hemminger <stephen@networkplumber.org>
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
 Andrew Melnychenko <andrew@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915124835.456676f0@hermes.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240915124835.456676f0@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/09/15 21:48, Stephen Hemminger wrote:
> On Sun, 15 Sep 2024 10:17:39 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
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
> 
> This will be useful for DPDK. But there still are cases where custom
> flow rules are needed. I.e the RSS happens after other TC rules.
> It would be a good if skbedit supported RSS as an option.

Hi,

It is nice to hear about a use case other than QEMU or virtualization. I 
implemented RSS as tuntap ioctl because:
- It is easier to configure for the user of tuntap (e.g., QEMU)
- It implements hash reporting, which is specific to tuntap.

You can still add skbedit if you want to override RSS for some packets 
with filter. Please tell me if it is not sufficient for your use case.

Regards,
Akihiko Odaki
