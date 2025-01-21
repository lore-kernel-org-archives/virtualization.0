Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A01A83FF
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737437243; cv=none; b=RZquEvywusTUujmYAxBAfm4KapzttUHu5yRqnYR5LpgzS25q3oEMUs9+FQ1X8hlY25rz7f+bvrdlMJ6l14TZApQ/8gngLtxnkd+sTvee2/fiMmusDeprBYV6555sKIaK2OsZrw5GvJeo2S5L7zbdMAnAK6GGNmeq4mmOA5lcGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737437243; c=relaxed/simple;
	bh=17jdquf1O8HrGT7YX1JbIULVdHRHHmmF5bL1fyAoM9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUkJ0VNzMpBfxKeVwwYxzp+VibAGdWTeTYuy6JtDwly8CWoxOjb1KF/GUgU2plxevjskAXoLHOTVI+EjInJGoqN43bCMExLaGZnkKUziPI0P/+BqYZ/8Z/cZkuVCDSN8dGg9SyhBwbpjCCctgH6PBGu3dusinBAdQ2WYpJVp7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=WJvm8Ux0; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="WJvm8Ux0"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D23040616
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 05:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2aaQ6qcNBHU for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jan 2025 05:27:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 24E914141F
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 24E914141F
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=WJvm8Ux0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 24E914141F
	for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 05:27:19 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-21670dce0a7so108254455ad.1
        for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 21:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737437239; x=1738042039; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuNe0V4SlZE9V8OcN/E4qhh/fBRX/xaiMcicz54Ypbc=;
        b=WJvm8Ux0qVZYwh1odJw7DdoH9xPdQoB0NmsOIfpX0m6boK+DUIbqnbac+LJIXVRq+p
         vSaTLJi3R7YArqHETHYHf+TVLToq+lDQCz/tYcs5V2BGwRdt0dmPiTTm0Dmx6kxlSzJw
         pMEITELRjWfe+7LFUUHz22+ki0AtLLFvTx3pwSSK+AiKU9Jju14fbzuxnPbhTeEMK4qf
         nW+g2ss+tmeHQP1fD4c/xdk5Pvce0F8w0el/+zVI52HVG+nwcXeHGuiSLAwh2HlRmys8
         0lA/ZZ2YB3rP+BIkm0G+Df98cbrHDPTtDPO7KGkeyKK/tHzLicJYFlgi5yf1j/ME/CA6
         mtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737437239; x=1738042039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KuNe0V4SlZE9V8OcN/E4qhh/fBRX/xaiMcicz54Ypbc=;
        b=vYXyNMMLXu7wVORzaMJcSRv256HnobvJ7KZzXBSH6Rep818jfvoFWrPPm4GkIXI66V
         9mMW3CO7M1/QjwPc6To4NhacEtg4cUSN5mZIYB8dFR7KPlJ5qyPVe9RZ6J7/HLwG3u1D
         0lgvrB6JDnKb1U79wfP8I0fJ3AhLXYsTlA5zTm+gtZIidG7gRsZID7Dng6/ERa1N2wq0
         7v3P+Y5IP5g9RM2KGBV+Y5h6MrGJ289cdE+P0Jv3Dz+r3+9GauGvYCdy7oglUvU0HGvf
         Xq9ra13z5NcNwOFxtq7Y2HaA6hT6dESg6a9T8egvEiAIYfmFLnf9ZBed3ZAmUv4j9qab
         BQhA==
X-Forwarded-Encrypted: i=1; AJvYcCX6+NY6EJKMuV/OURDIu7NwFwpm4zalX+fkutp2culfb9B0iMuWo3Og9YcV0md9kTUmWvHxoAVTozDTBMpvbw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxlyfnUoP2uOoctr2vvWsxZpN1Bb6wT9BSSGk+FDoDTxJ0A8QTR
	hG1Ym4TMAj6Z9LPGJGwhKSAU7sNqao3EF82ijD/7SpPuSDZv9KVkZCAicuwM4U0=
X-Gm-Gg: ASbGncvMSSsXICIc9womOoLNDOzT1LCcwWXNVxjlnK1OT5W9jW1sxfRP5L5p30mCPHm
	KkQ4vECXXqDH8VyZpvEcWH+N3KU+m/z9jW4ru3+ENkWXFYv/JHlkTyNNDd6QUXLojdvZi8VQy3X
	Csk9AM8iH1Hzynhxscl8nNBZbAxx1gcPx0mNxh1iRLPN6V6hOtKZoHmCBZbdLlaHzU+zSf10+FP
	gjN2uosLTHfIJqKY0Se5vGPYt3IgbeJJIs7MjtrYKuFuo1+VXweNGaPhkvm/0YzbKkrJ6NXoEzL
	8rDK
X-Google-Smtp-Source: AGHT+IF8AscE6lKE6K9gAMAkVavPAuy5ImBZTIR2UjEzttP05cs28ECPVkex5+WoyQz221rWXZqSKQ==
X-Received: by 2002:a17:902:f7ce:b0:215:773a:c168 with SMTP id d9443c01a7336-21c352de425mr241247485ad.1.1737437239066;
        Mon, 20 Jan 2025 21:27:19 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdf0b4503sm6710167a12.67.2025.01.20.21.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 21:27:18 -0800 (PST)
Message-ID: <92675e51-cbaf-4905-8cf8-dff741a26db9@daynix.com>
Date: Tue, 21 Jan 2025 14:27:12 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>
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
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
 <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
 <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
 <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/20 20:19, Willem de Bruijn wrote:
> On Mon, Jan 20, 2025 at 1:37 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Fri, Jan 17, 2025 at 6:35 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> On 2025/01/17 18:23, Willem de Bruijn wrote:
>>>> Akihiko Odaki wrote:
>>>>> tun and tap implements the same vnet-related features so reuse the code.
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> ---
>>>>>    drivers/net/Kconfig    |   1 +
>>>>>    drivers/net/Makefile   |   6 +-
>>>>>    drivers/net/tap.c      | 152 +++++--------------------------------------------
>>>>>    drivers/net/tun_vnet.c |   5 ++
>>>>>    4 files changed, 24 insertions(+), 140 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>>>>> index 1fd5acdc73c6..c420418473fc 100644
>>>>> --- a/drivers/net/Kconfig
>>>>> +++ b/drivers/net/Kconfig
>>>>> @@ -395,6 +395,7 @@ config TUN
>>>>>       tristate "Universal TUN/TAP device driver support"
>>>>>       depends on INET
>>>>>       select CRC32
>>>>> +    select TAP
>>>>>       help
>>>>>         TUN/TAP provides packet reception and transmission for user space
>>>>>         programs.  It can be viewed as a simple Point-to-Point or Ethernet
>>>>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>>>>> index bb8eb3053772..2275309a97ee 100644
>>>>> --- a/drivers/net/Makefile
>>>>> +++ b/drivers/net/Makefile
>>>>> @@ -29,9 +29,9 @@ obj-y += mdio/
>>>>>    obj-y += pcs/
>>>>>    obj-$(CONFIG_RIONET) += rionet.o
>>>>>    obj-$(CONFIG_NET_TEAM) += team/
>>>>> -obj-$(CONFIG_TUN) += tun-drv.o
>>>>> -tun-drv-y := tun.o tun_vnet.o
>>>>> -obj-$(CONFIG_TAP) += tap.o
>>>>> +obj-$(CONFIG_TUN) += tun.o
>>>>
>>>> Is reversing the previous changes to tun.ko intentional?
>>>>
>>>> Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
>>>> over this. In particular over making TUN select TAP, a new dependency.
>>>
>>> Jason, you also commented about CONFIG_TUN_VNET for the previous
>>> version. Do you prefer the old approach, or the new one? (Or if you have
>>> another idea, please tell me.)
>>
>> Ideally, if we can make TUN select TAP that would be better. But there
>> are some subtle differences in the multi queue implementation. We will
>> end up with some useless code for TUN unless we can unify the multi
>> queue logic. It might not be worth it to change the TUN's multi queue
>> logic so having a new file seems to be better.
> 
> +1 on deduplicating further. But this series is complex enough. Let's not
> expand that.
> 
> The latest approach with a separate .o file may have some performance
> cost by converting likely inlined code into real function calls.
> Another option is to move it all into tun_vnet.h. That also resolves
> the Makefile issues.

I measured the size difference between the latest inlining approaches. 
The numbers may vary depending on the system configuration of course, 
but they should be useful for reference.

The below shows sizes when having a separate module: 106496 bytes in total

# lsmod
Module                  Size  Used by
tap                    28672  0
tun                    61440  0
tun_vnet               16384  2 tun,tap

The below shows sizes when inlining: 102400 bytes in total

# lsmod
Module                  Size  Used by
tap                    32768  0
tun                    69632  0

So having a separate module costs 4096 bytes more.

These two approaches should have similar tendency for run-time and 
compile-time performance; the code is so trivial that the overhead of 
having one additional module is dominant.

The only downside of having all in tun_vnet.h is that it will expose its 
internal macros and functions, which I think tolerable.
