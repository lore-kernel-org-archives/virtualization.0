Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCA2153F8
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415424; cv=none; b=ioF0dWDzZCUf3/rxdG1V/uMM9eu24hjyb3KPSccxNOff17D+R63kvzWPYTjp9gplQ4z5q5TMgtEoCWxDf3WnNgyAQnwydKi5PEa0jZd8LfohZ1FUk/TQoo9VGsEa/tBzqRUGHcbDeAxHZt2QXdeac/r5NY4HEoP26RYjlgF7bxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415424; c=relaxed/simple;
	bh=/Y7vshFyp+S1ZNQo5QoPrTX6A5Pvuo7WfnstfrwZxZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJxDCzDf2OBXe2YG7nmq+XqRADLCjkE5iKTQzEs9FRSe0L0RH2cd6/R3P/W30VwCHzWfIWGxAXjNexYSlD08IFZ2SvO628esnu8b5DhQyHBBGBU65PlTusQewtYEwHOEiUvSAbtCZEdQyQFvDa/xkN8tsfY/olZVcEMK/iw58S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=a1dPusya; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="a1dPusya"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D41AB403F9
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 09:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hQaBZMlZVecj for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 09:37:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3DFD9402AC
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DFD9402AC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=a1dPusya
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3DFD9402AC
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 09:37:00 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-21636268e43so12810725ad.2
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 01:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736415420; x=1737020220; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcSbx1LF493qhjKry/nZNlaGERbQhtYPTAQgAOWQyVg=;
        b=a1dPusyaZrzStZ2RKRjKSLfYnNadntbeMLhAhpkFTBcZTeO4qYP0KwkdbV7OzXL9ng
         qjutLB6UoWJULn5s5go5BTw5WcIcZVUJzH8t035/ukAKYpJUTbEo5eUSDfhEu64gBGb/
         UpgFSOjobuRPXQddd31e7rI5tRRQhZm6emweIlwfXs+zsSYfYsq5BlQvdiUBBwzEjB7n
         6Fj/eNh3sNpyAecWy5uxE37M1h8zbO+NG0w+FxD1A/QS2gAyo1jdb7YyQ8aXbBR9T0/G
         90cEqUDnqTqDDnzJ3dVhIeJDYTW/4IN7MO3t7G5J4oG4IXy/RIsfhyLIJw1To2Wr1kgd
         RKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736415420; x=1737020220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcSbx1LF493qhjKry/nZNlaGERbQhtYPTAQgAOWQyVg=;
        b=IjI73gVPiWorbFFHk4pJ80VI4zEqDo1KkkSVm3Z5CBx0XfuS2Pa/rnyFit/sUjC99n
         +37lnXt7poUw9a2GjeDBkmpr7sfzn/8GAkpCgTghprIqIpX2TnUuJdHRyN2fZ4VOgOJ7
         qxAHso3+lMdHplJIDUQTB/mk9/W+PcH6BSXFFhg+pD5H/Iy08b/PxqXFhoBwdGCGK1UU
         zJKpRqkBXa9lhe5Fb0ezR+DN7Dovjlu1re0v49Ou3ZUh6iUqqhswLGVpP0vmoXZSLviX
         //PPh+i3ydMeL5N2iH2qVBV1F6r6pm3vwVEPo5jp9YneHD6sL/DX4wCejmaw86KLPjIH
         Pgig==
X-Forwarded-Encrypted: i=1; AJvYcCWVHUmt8yY3Shj+XdHMB1TR/sQR+E2ZFew9E01nwdsiPjLtvDCBHjdwM2sMjmGoH+DhOi/5OotaOFHzwgokRQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxI4vo2i/xR0ohi5JT3Qcpzh+QNy6w3Bwu45IkT/OJ1pWzUbbZ8
	xW8+QB1aY2avyxDPpXp+4to9U2zlDtffYjembyOvuCM5DNn7co9qKnFK4UepRm8=
X-Gm-Gg: ASbGncvgS6Hg+YRIJtPSt57LxncA3LZNQRCIsUfZLytaz2rsAFQq9FyBLNEY/rzTVTk
	WD37mqnpoXRlkMe6ZfHzH0womKZ+Jci7NxojzcTUMIUfXh7nWSFO8ps825YoudP3TXabuKbN+nl
	8jUODJMlXr99TnNInIgdipHdCnpGOBjFpnhiEDMFtlG+0HiK03Zlytcb9C0AEH/hx0sr9M1/oHI
	Xg7+nOL9G8DmRxLSnzbl28vkNdZOXpepLlCulPK9Z480jDehoumewpQQDeKfQBuIzU=
X-Google-Smtp-Source: AGHT+IGojiWk/1gT/7D4/Bn9x5ciCyKBW6DXVbq8kH6J+vNptBrJUgGdPyWUs9OwXpei8EJsrIl0sg==
X-Received: by 2002:a05:6a20:8411:b0:1e1:a434:2964 with SMTP id adf61e73a8af0-1e88cf63b7bmr10109548637.2.1736415420397;
        Thu, 09 Jan 2025 01:37:00 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbab4sm36620666b3a.94.2025.01.09.01.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 01:36:59 -0800 (PST)
Message-ID: <6f33c048-81ad-4d15-872d-187e965e6d79@daynix.com>
Date: Thu, 9 Jan 2025 18:36:52 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
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
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <20250109024247-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250109024247-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/09 16:43, Michael S. Tsirkin wrote:
> On Thu, Jan 09, 2025 at 04:41:50PM +0900, Akihiko Odaki wrote:
>> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
>>> On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
>>>> tun used to simply advance iov_iter when it needs to pad virtio header,
>>>> which leaves the garbage in the buffer as is. This is especially
>>>> problematic when tun starts to allow enabling the hash reporting
>>>> feature; even if the feature is enabled, the packet may lack a hash
>>>> value and may contain a hole in the virtio header because the packet
>>>> arrived before the feature gets enabled or does not contain the
>>>> header fields to be hashed. If the hole is not filled with zero, it is
>>>> impossible to tell if the packet lacks a hash value.
>>>>
>>>> In theory, a user of tun can fill the buffer with zero before calling
>>>> read() to avoid such a problem, but leaving the garbage in the buffer is
>>>> awkward anyway so fill the buffer in tun.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> But if the user did it, you have just overwritten his value,
>>> did you not?
>>
>> Yes. but that means the user expects some part of buffer is not filled after
>> read() or recvmsg(). I'm a bit worried that not filling the buffer may break
>> assumptions others (especially the filesystem and socket infrastructures in
>> the kernel) may have.
>>
>> If we are really confident that it will not cause problems, this behavior
>> can be opt-in based on a flag or we can just write some documentation
>> warning userspace programmers to initialize the buffer.
> 
> It's been like this for years, I'd say we wait until we know there's a problem?

Perhaps we can just leave it as is. Let me ask filesystem and networking 
people:

Is it OK to leave some part of buffer uninitialized with read_iter() or 
recvmsg()?

> 
>>>
>>>> ---
>>>>    drivers/net/tun_vnet.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
>>>> index fe842df9e9ef..ffb2186facd3 100644
>>>> --- a/drivers/net/tun_vnet.c
>>>> +++ b/drivers/net/tun_vnet.c
>>>> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>>>>    	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>>>>    		return -EFAULT;
>>>> -	iov_iter_advance(iter, sz - sizeof(*hdr));
>>>> +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
>>>> +		return -EFAULT;
>>>>    	return 0;
>>>>    }
>>>>
>>>> -- 
>>>> 2.47.1
>>>
> 

