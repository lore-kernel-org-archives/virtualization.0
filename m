Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C715ADA6
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005427; cv=none; b=cAa1OIAHyxBzIABeZrHy3bf/9wzKBCLXYGO1cnbxFCVscPvv7j5EjJFN3jlPGH1nGW1qj2Y3bROumtTpY6gB6Fkr5BagpfnabTVgEMsBiKZPHcXnpSkwxh7EguDaLmYqq4UluaiPDU9g8FA5l6f4T3GiiPNLUxz9KWJ+jikKFug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005427; c=relaxed/simple;
	bh=5xQA7+rcyNu9tK/Yw0+0NEwKQ5hjxrD+NiJB5k0WJ3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3ATC0LFMsZluG7KIYe7YX7MycRc2mQKlnvi3dCsJobKeO1mkmnLQ2gNmTINWP/78LBd3WrzZZ2+jW/18DAquiD3laEee297i94JXBzSg0qvsGvbTy4yBfW68TvNzuBuZ70UdgaMa0w+qRF+C/1U6HhsdnezjagfrMHY3YPRU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=aKKHh2AP; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="aKKHh2AP"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD4468491A
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 05:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcEuiINS-cmQ for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 05:30:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 391BC84A60
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 391BC84A60
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=aKKHh2AP
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 391BC84A60
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 05:30:23 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-21654fdd5daso7840505ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 15 Jan 2025 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737005423; x=1737610223; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t85mZgz2Rs3YU6wJKJ13zARpOEqd4Q3PLwsjti7bxDQ=;
        b=aKKHh2APjjCgBK/KQkfXie/amtFaHuV6nsJ9xw/CI6E4UrDeJPPafD5+4zgw328yYO
         oedmjBoi0vMCZhttQGt0DCaO15bK0IQ3R7ZGq5vCh230iTVrpS1Z2O60+BDAmGJTrhnI
         y7yy837BsGNpw7Sram4P3SoeI93EPDr3PWX1nzVUHQ4H+qrrhzB8EyMzEDRLi9qmTrhk
         T/P+6YUosIXmt/0aPjEzc+EGSsg4jif+SqfKqryae8c8cJ4Hq6z3k560TVDc5mh/UcJH
         EfPmjL3rLf+3vrF+VirKF42LkyptpHAv5tL3Sj/Ew20nKIrPDtoL8fGW8JT78zds9Xl6
         0oRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737005423; x=1737610223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t85mZgz2Rs3YU6wJKJ13zARpOEqd4Q3PLwsjti7bxDQ=;
        b=MqHBhgCDO4fzNFnDsS2b1B3vY/hScWNVuKIytA9wtsyfwvWEzNJT15QhuKpu+ys9gj
         SfWQTpoR8cRghypTX1iiWgezFFf2p38jLhktMQSKQzDms3nDIuvtH0UO2K1QCNaaymAL
         Z0fFfiszwP2X7X0+Bi/9B5Jfm62GYTjcOfxLS8pIB/VxtoYDdJXZ+hWI7DsovB3VwByX
         iw4NvvrIz8R+U58MgM/L7P89IgaEVgfXtroxxbeeRFdUWAG1qmPU2rOsoDPaNXgE9Qnp
         u/V73M7iUNUfILBZUPyDFNtqwl5Kg7qEWtwI1fIHiHj2kwIsZaj7tKzZ9E6sDQ7zoPHe
         oksg==
X-Forwarded-Encrypted: i=1; AJvYcCV9TrMW05zIL0nYkbIVYFhArPfUmAVWzWrkTYO15Ag3Jdy0N8CHCIiFTiKXu2Qfr+wIb89bpYNt76aCl3PtCA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxRQeFN/cD9WODVrl1rhTIjQaEYOW3uJCFcWRJ9r6GLHHfKNg/+
	3N+KIwYoJV/WbVEMMtT+1/oaRd76+oHMjk8c+hmGAxMOSVxfSDIVhQrJjzBzcg8=
X-Gm-Gg: ASbGncspt8Odlh3GmUXGCspgek1I419FTJFBKx8MB/mH2UA+jYlqBRtRW21T2KvIpJT
	PHZN7AsbO62/ptBMXBJI21JasA9PJHqOXbWb/9AFGxM2gbTfA+aqp82/VHwKdJZc/oUrolVEmf0
	95RBQArLeh9uEITbGv6YL3Lp7c4mp7Qt95rjl9IdEbhkeLIoRlFByR3iyd2IdRWon2BZzVCEwLB
	TcYRt53nX07t2SZOzSVvLMvbUkfYDWYpoZnI725i+Do46ssjWR+cyCo9tV34ACWCY8=
X-Google-Smtp-Source: AGHT+IEwP5ZyOaLIZ2+ZynbDYG6rMIezxsEt9Oeopwo0vGbe1vdYSLm0vMdAkgahtQxltszD6eVILA==
X-Received: by 2002:a17:902:ea0a:b0:216:682f:175 with SMTP id d9443c01a7336-21a840029a0mr517608085ad.49.1737005423363;
        Wed, 15 Jan 2025 21:30:23 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217565sm90290735ad.125.2025.01.15.21.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 21:30:22 -0800 (PST)
Message-ID: <cc79bef1-c24e-448d-bc20-f8302e341b2c@daynix.com>
Date: Thu, 16 Jan 2025 14:30:16 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvBU3mLbW+-nOscriR-SeDvPSm1mtwwgznYFOocuao5MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/16 10:06, Jason Wang wrote:
> On Wed, Jan 15, 2025 at 1:07 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/01/13 12:04, Jason Wang wrote:
>>> On Fri, Jan 10, 2025 at 7:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
>>>>> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
>>>>>> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>
>>>>>>> The specification says the device MUST set num_buffers to 1 if
>>>>>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
>>>>>>
>>>>>> Have we agreed on how to fix the spec or not?
>>>>>>
>>>>>> As I replied in the spec patch, if we just remove this "MUST", it
>>>>>> looks like we are all fine?
>>>>>>
>>>>>> Thanks
>>>>>
>>>>> We should replace MUST with SHOULD but it is not all fine,
>>>>> ignoring SHOULD is a quality of implementation issue.
>>>>>
>>>
>>> So is this something that the driver should notice?
>>>
>>>>
>>>> Should we really replace it? It would mean that a driver conformant with
>>>> the current specification may not be compatible with a device conformant
>>>> with the future specification.
>>>
>>> I don't get this. We are talking about devices and we want to relax so
>>> it should compatibile.
>>
>>
>> The problem is:
>> 1) On the device side, the num_buffers can be left uninitialized due to bugs
>> 2) On the driver side, the specification allows assuming the num_buffers
>> is set to one.
>>
>> Relaxing the device requirement will replace "due to bugs" with
>> "according to the specification" in 1). It still contradicts with 2) so
>> does not fix compatibility.
> 
> Just to clarify I meant we can simply remove the following:
> 
> """
> The device MUST use only a single descriptor if VIRTIO_NET_F_MRG_RXBUF
> was not negotiated. Note: This means that num_buffers will always be 1
> if VIRTIO_NET_F_MRG_RXBUF is not negotiated.
> """
> 
> And
> 
> """
> If VIRTIO_NET_F_MRG_RXBUF has not been negotiated, the device MUST set
> num_buffers to 1.
> """
> 
> This seems easier as it reflects the fact where some devices don't set
> it. And it eases the transitional device as it doesn't need to have
> any special care.

That can potentially break existing drivers that are compliant with the 
current and assumes the num_buffers is set to 1.

Regards,
Akihiko Odaki

> 
> Then we don't need any driver normative so I don't see any conflict.
> 
> Michael suggests we use "SHOULD", but if this is something that the
> driver needs to be aware of I don't know how "SHOULD" can help a lot
> or not.
> 
>>
>> Instead, we should make the driver requirement stricter to change 2).
>> That is what "[PATCH v3] virtio-net: Ignore num_buffers when unused" does:
>> https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.com
>>
>>>
>>>>
>>>> We are going to fix all implementations known to buggy (QEMU and Linux)
>>>> anyway so I think it's just fine to leave that part of specification as is.
>>>
>>> I don't think we can fix it all.
>>
>> It essentially only requires storing 16 bits. There are details we need
>> to work out, but it should be possible to fix.
> 
> I meant it's not realistic to fix all the hypervisors. Note that
> modern devices have been implemented for about a decade so we may have
> too many versions of various hypervisors. (E.g DPDK seems to stick
> with the same behaviour of the current kernel).
 > >>
>> Regards,
>> Akihiko Odaki
>>
> 
> Thanks
> 

