Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C61FC11C
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110129; cv=none; b=UIwfhxFSIrpccGZRIYlNNml9uO/ydDEvn0j9WTbeGuWk1N8w1dPyMU1OeOrqVTsgrSpwLgBOqPEDiJOMcEi/etJMXZLwZS23J5GjUiaNTwiAZz8n6ldyDYH3o7w+FbDLWTem5nkdPzTTdCulEVjErR+jsy2MjrPbnnk8viCt+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110129; c=relaxed/simple;
	bh=70bfaT34dxfacCnCOxEBqaLDOi2/f294fVDQPUnDUSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=qcKFhOFp0QeA2cxAdQbye31aB0lLeVCxV3E4K73e38FFVf7WYjzRJLxHG7fef9PDKxD6p3Q97sw65PO85F18Aq/RWGmiNzHYQRGMQqtneWywn7RfK8m14Uar4RKwiduumBiYf3ivwdTqSCdSUZDMsnXrW98LHt5MdhP5Ne9YI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=tQTwbsUB; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="tQTwbsUB"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CDC0409AD
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBJ6gZWBWExZ for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 10:35:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D11B84099C
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D11B84099C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=tQTwbsUB
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D11B84099C
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:35:26 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2165448243fso43694135ad.1
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 02:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737110126; x=1737714926; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1s3j+Lo8FohUApnn9jxJmXSbe+FtIPWK2NNPguyY5ds=;
        b=tQTwbsUB1Nqb63s2XSoJQjoBThehD0wLIAw6F77fFK41tevhLoUBW0n2z5+Cp9YV4i
         vx5p1rZG7lXoIbJMRPUcJ3GeFTHL+62gESSamVBBinJuewBIkafCle0Fp2F2pokHYH/y
         RZcXc06LXjg/L/IsvrCYKIzcp5Wz6xQKGHhu3OdSkeYWTVhUvBK+X4jxtAyW0Egz2Coz
         Gknhg9kbeH9exnU6Jg7dFp4/if5dGG3RcdwZp6h4JRNnip/Ua0mTp59Nnyd7yAtJZ82l
         EWnXj0c8RsqwCf+E1Ep7DDtbK5hVxbbBbo1hb0Xs4fXKxu8H8MUH3s2uQnoQgEFFJhK/
         woLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110126; x=1737714926;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s3j+Lo8FohUApnn9jxJmXSbe+FtIPWK2NNPguyY5ds=;
        b=AcnIKsV/ugT7NEIWOXsRrtLpK0o6xEM/onDc+rhuhSvM1syb/nDtIoDwFP52qUZvo6
         7ZabzddHdr/kjH42wdRVOEICZEIYwkZfKYvGzej/6EnEWauolAkD/9R2cTuzrFKmy/tn
         UPH/62FeYUjya9d5/D453haIGnM+71B0FlUB/cRyttUhGuHF/ZzKxcyViXjK+MdHnK7b
         WRB7zB1U+s39mVURT9ZQ6AN17tvTU9j6PLLQtUHs8W54zUB+qaivzTc3VBQFgOQCm1k7
         t/aB3U1g+jB81Wk4OErBpk3a3REIJfFuLW09rLv6Zxhkte+JvIWD2N69hodwRGNj6FR9
         2tWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbQlPqOW7pX04R2qaG+5qXPL4fTkgOeQtuh5slJb/WglJJBrn/QXv1Izb1wTuctSS4Sy8G0vTGPSWi7nplaQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz8Ut3C6XvxjForMqUeRmZrXKI9ngmLtBS9v4Y8o6CzTfc4vCin
	/T7xTNzjH6XDlo49LpqrtzeQOTdX+5h/eIEEJaQ6YL4YExgEDzBNiWsWmIflNJA=
X-Gm-Gg: ASbGncvJFLCpyD0Zi20ZFh/tMyr1XdDI4KH2AE41aHyq8BJTQqwf2Es7T/rKVkLRGRU
	jp+4vG8+0xkb2ehtTocEmVx1g3QcizE93utXIueJPmvtQjIQaYkz0Lr5KXOOZyhram5ENlFrqut
	T3+6c3ktPxzPOaCbm0V8n2cRLuahiCJ97gegzj9ztids8dEYzFh/aTVssi6IPNs8aNZpRr6G17o
	83NxNNq5Ec0GCGeqPC9JNG0YE9qSNAM/SvPUAm7tdKPMKkcwkSCYBDl8wRwN1CEMtQ=
X-Google-Smtp-Source: AGHT+IGPzLz6S37k0uPz0pnAPaNjl5ykAtTRRDNMCEBSSX1EJykbz5I62peVJ/pXXng63XBSAbFQiQ==
X-Received: by 2002:a05:6a21:788b:b0:1e1:9bea:659e with SMTP id adf61e73a8af0-1eb215d4c46mr3415218637.35.1737110125973;
        Fri, 17 Jan 2025 02:35:25 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab81754csm1564334b3a.63.2025.01.17.02.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 02:35:25 -0800 (PST)
Message-ID: <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
Date: Fri, 17 Jan 2025 19:35:19 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Jason Wang <jasowang@redhat.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
Content-Language: en-US
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/17 18:23, Willem de Bruijn wrote:
> Akihiko Odaki wrote:
>> tun and tap implements the same vnet-related features so reuse the code.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   drivers/net/Kconfig    |   1 +
>>   drivers/net/Makefile   |   6 +-
>>   drivers/net/tap.c      | 152 +++++--------------------------------------------
>>   drivers/net/tun_vnet.c |   5 ++
>>   4 files changed, 24 insertions(+), 140 deletions(-)
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 1fd5acdc73c6..c420418473fc 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -395,6 +395,7 @@ config TUN
>>   	tristate "Universal TUN/TAP device driver support"
>>   	depends on INET
>>   	select CRC32
>> +	select TAP
>>   	help
>>   	  TUN/TAP provides packet reception and transmission for user space
>>   	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>> index bb8eb3053772..2275309a97ee 100644
>> --- a/drivers/net/Makefile
>> +++ b/drivers/net/Makefile
>> @@ -29,9 +29,9 @@ obj-y += mdio/
>>   obj-y += pcs/
>>   obj-$(CONFIG_RIONET) += rionet.o
>>   obj-$(CONFIG_NET_TEAM) += team/
>> -obj-$(CONFIG_TUN) += tun-drv.o
>> -tun-drv-y := tun.o tun_vnet.o
>> -obj-$(CONFIG_TAP) += tap.o
>> +obj-$(CONFIG_TUN) += tun.o
> 
> Is reversing the previous changes to tun.ko intentional?
> 
> Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
> over this. In particular over making TUN select TAP, a new dependency.

Jason, you also commented about CONFIG_TUN_VNET for the previous 
version. Do you prefer the old approach, or the new one? (Or if you have 
another idea, please tell me.)

> 
>> +obj-$(CONFIG_TAP) += tap-drv.o
>> +tap-drv-y := tap.o tun_vnet.o
>>   obj-$(CONFIG_VETH) += veth.o
>>   obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>>   obj-$(CONFIG_VXLAN) += vxlan/

