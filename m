Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01C15B54C
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737349089; cv=none; b=lL1wvTP7xaLLdoyyYd6rF9vKTkL+umXyyUpA6ieARwC/IWzYXpdpp4g0WHiNQc47e4Sn2Mjiiw03zR+pFXe76lJHAbU3tPDXZ995q8DcMYH081yZaKRKVxNHYBPNlOYYKaAn7CYpnl3j4gr/Mj30mtjOjHwG15YA5uYJo7S8m6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737349089; c=relaxed/simple;
	bh=JBhx4FBRzKbzrz2Al5pNMHO5F3JgbgRL5B/gVFGVg/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJL8v5bhxIXVyvA/LJNAOecoSXLlq+tGwpFxYf3QzWrz8YJNgA3Zd8euCYjjH1f2U74ku9LqqQtkAcEzPdZHQ5fmCL35e2ALzPOMIOyElwhZGpFHu95c8M8tSZAQJXgEQ+z5pMy4++fVn8GSXYvgvjmDoe16AeJMapDhQZE18pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=r1ojTZ2F; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="r1ojTZ2F"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10F41408BF
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 04:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id diCjFUFJYitN for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 04:58:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5FC8940719
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FC8940719
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=r1ojTZ2F
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5FC8940719
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 04:58:06 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-21661be2c2dso72784105ad.1
        for <virtualization@lists.linux-foundation.org>; Sun, 19 Jan 2025 20:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737349085; x=1737953885; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4oIihNr6GZKGbnqtazZfNL+Wdu+eK7TRKf6H4jFUt4=;
        b=r1ojTZ2FIe1LQ+mSuq4XZ6t51MLXMWTfHsVPVlwS5RCipwQRKWyBMgXgxLO4GW3MI8
         E2MsCc5D7NqLdb/X1GEiLvBTlJxpNIQpnwiRN/YRdb1X8vrKTqL+K9djSYKkoMy3NN3O
         JRrZV7EecTlNnF/vOi4f6taFtENr/JiCCyDHUpC9xliwUmLHJNPJraFXhTqSlz5JWTLh
         zu1LxCWn7t9rOPI8P2TyUmYjOfm2I/f073jyhFebSF0wfKHCRWGeOikSW9DmLkplm+ZU
         qVDRJN7uwJaCUEVLU+BGKGu78Rv8q65MtarS1HOCy8wRoY9GN3TKEEZJBhMd8NAQ1hdR
         Znmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737349085; x=1737953885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4oIihNr6GZKGbnqtazZfNL+Wdu+eK7TRKf6H4jFUt4=;
        b=QGqgEJrttbONHntPtab/s6oVjouMoFv4c+rxLJYh1hF6yBRyORT0Lhd7FpWilQQt2E
         XaNHRNLeP56s5MYf+VAocUqdNfPupOu2nTpAwrbX8SpJgT20YUeQV2ZXVgyaxt0BVQpd
         6EE6VuoWyD8gTuPPEQXr44TVQG2xai4wcM741h/rThpcie8ZiU2R26f2aNdz3N4dzOf+
         X+8eEaeuBS85PeIVLXh8OttC6/JoRW7O1Z0+C/ebNgSSZGy/F7AC54/LfWHWkH1sJ3E4
         3k1cw3DhhyF7MW0zd3F+BYdSSg9HZGAON36W5jH18XNxcXLFmo86ANbN0trrbQwb3Qvt
         +Ixw==
X-Forwarded-Encrypted: i=1; AJvYcCX98gfOsf6Yc2Km0B45wUYqgqkqZSwX+xFUpxJ5MWwp1uR7Yw5ydoFEphDbSMYJGxjWzTpvq+DPf4sis3P7xQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywkj1e//g8yUTitUGHSykuboKIB8Sbjy9TJ40yz5PO9mZ6s1pZ6
	3y/GKgHnsyccaF7noQo8unsfDJoWujKzdNHtCXVEEgwN5dpYeqlzpCIIhLry0kc=
X-Gm-Gg: ASbGnctg9oWMJ77xuDQYA7eiV9yMok/X6NyVDEi5SBFzeHkB/VvnGi6NewB2BN5y/T0
	EuYv1WZ0GOoByS58nBmFSfoh2eGlLiM0qDwMUC/CKA6V2mgvP+qSqTAFMeyxIKohHIYYU1Oz51F
	ohRshL6oYvJBcLwNyuuU9QZXezq294hSqa/LQ/SYBjfjVwBuFp+Yu1jBbI381+lzgyKOOPV1GJP
	Ad5n1YDLpHe7/ef/8eMW3dZjMPfgTx7XQ+ecMFy9QC48bH8ehVvHHDXe3uOMlo42zWfmQfnPYNC
	qkD8
X-Google-Smtp-Source: AGHT+IE8MzXrgaBKBfP61PbTUvr8PgxgGWYeOWK4EEWyIPyWkez8gj6KrIAnQzmUFU9EFnwQTPVCzw==
X-Received: by 2002:a05:6a20:914e:b0:1e1:70ab:b369 with SMTP id adf61e73a8af0-1eb214983dfmr16605568637.13.1737349085531;
        Sun, 19 Jan 2025 20:58:05 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab817529sm6251103b3a.67.2025.01.19.20.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 20:58:05 -0800 (PST)
Message-ID: <8052733d-3e79-4fd5-9bea-9d3724820bb8@daynix.com>
Date: Mon, 20 Jan 2025 13:57:59 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org>
 <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
 <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
 <fcb301e8-c808-4e20-92dd-2e3b83998d18@daynix.com>
 <CACGkMEvBU3mLbW+-nOscriR-SeDvPSm1mtwwgznYFOocuao5MQ@mail.gmail.com>
 <cc79bef1-c24e-448d-bc20-f8302e341b2c@daynix.com>
 <CACGkMEsJUb3ZLm3rLuaayDAS4kf-vbY03wL4M9j1K+Z=a4BDig@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsJUb3ZLm3rLuaayDAS4kf-vbY03wL4M9j1K+Z=a4BDig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/20 9:40, Jason Wang wrote:
> On Thu, Jan 16, 2025 at 1:30 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/01/16 10:06, Jason Wang wrote:
>>> On Wed, Jan 15, 2025 at 1:07 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/01/13 12:04, Jason Wang wrote:
>>>>> On Fri, Jan 10, 2025 at 7:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>>>>>>>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>
>>>>>>>>> The specification says the device MUST set num_buffers to 1 if
>>>>>>>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>>>>>>>
>>>>>>>> Have we agreed on how to fix the spec or not?
>>>>>>>>
>>>>>>>> As I replied in the spec patch, if we just remove this "MUST", it
>>>>>>>> looks like we are all fine?
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>
>>>>>>> We should replace MUST with SHOULD but it is not all fine,
>>>>>>> ignoring SHOULD is a quality of implementation issue.
>>>>>>>
>>>>>
>>>>> So is this something that the driver should notice?
>>>>>
>>>>>>
>>>>>> Should we really replace it? It would mean that a driver conformant with
>>>>>> the current specification may not be compatible with a device conformant
>>>>>> with the future specification.
>>>>>
>>>>> I don't get this. We are talking about devices and we want to relax so
>>>>> it should compatibile.
>>>>
>>>>
>>>> The problem is:
>>>> 1) On the device side, the num_buffers can be left uninitialized due to bugs
>>>> 2) On the driver side, the specification allows assuming the num_buffers
>>>> is set to one.
>>>>
>>>> Relaxing the device requirement will replace "due to bugs" with
>>>> "according to the specification" in 1). It still contradicts with 2) so
>>>> does not fix compatibility.
>>>
>>> Just to clarify I meant we can simply remove the following:
>>>
>>> """
>>> The device MUST use only a single descriptor if VIRTIO_NET_F_MRG_RXBUF
>>> was not negotiated. Note: This means that num_buffers will always be 1
>>> if VIRTIO_NET_F_MRG_RXBUF is not negotiated.
>>> """
>>>
>>> And
>>>
>>> """
>>> If VIRTIO_NET_F_MRG_RXBUF has not been negotiated, the device MUST set
>>> num_buffers to 1.
>>> """
>>>
>>> This seems easier as it reflects the fact where some devices don't set
>>> it. And it eases the transitional device as it doesn't need to have
>>> any special care.
>>
>> That can potentially break existing drivers that are compliant with the
>> current and assumes the num_buffers is set to 1.
> 
> Those drivers are already 'broken'. Aren't they?

The drivers are not broken, but vhost_net is. The driver works fine as 
long as it's used with a device compliant with the specification. If we 
relax the device requirement in the future specification, the drivers 
may not work with devices compliant with the revised specification.

Regards,
Akihiko Odaki

> 
> Thanks
> 
>>
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Then we don't need any driver normative so I don't see any conflict.
>>>
>>> Michael suggests we use "SHOULD", but if this is something that the
>>> driver needs to be aware of I don't know how "SHOULD" can help a lot
>>> or not.
>>>
>>>>
>>>> Instead, we should make the driver requirement stricter to change 2).
>>>> That is what "[PATCH v3] virtio-net: Ignore num_buffers when unused" does:
>>>> https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.com
>>>>
>>>>>
>>>>>>
>>>>>> We are going to fix all implementations known to buggy (QEMU and Linux)
>>>>>> anyway so I think it's just fine to leave that part of specification as is.
>>>>>
>>>>> I don't think we can fix it all.
>>>>
>>>> It essentially only requires storing 16 bits. There are details we need
>>>> to work out, but it should be possible to fix.
>>>
>>> I meant it's not realistic to fix all the hypervisors. Note that
>>> modern devices have been implemented for about a decade so we may have
>>> too many versions of various hypervisors. (E.g DPDK seems to stick
>>> with the same behaviour of the current kernel).
>>   > >>
>>>> Regards,
>>>> Akihiko Odaki
>>>>
>>>
>>> Thanks
>>>
>>
> 

