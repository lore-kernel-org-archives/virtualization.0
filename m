Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D01E200F
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503457; cv=none; b=ViGNBE/8YrN2msqZpbQOAwOfPiuc9r15GUK3nqUejPumam5VwTurmXyas468SJUHlhUi1IXVW2Qd6VRG4Df0sewRalf9J7Pxoga5JbF5j+18pOgy5tZF3/uO3hr0P2Ay/HRbTEUVhguIF9sgLXufFXWGeVqNd439jCNsGbJ7RN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503457; c=relaxed/simple;
	bh=qNaQzpehQQCjP6U1Smo/Nd38XDFDvWBgAvAJl4KW8uA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bCM12V1MGqNAWjuzU2Y27fGYqD/nrvZtMpS2mFKhtTpRdLwZCDrvb8WjXaK0B5CL8lijmFYAWEECIP4BCDNd1uG8rjy8vPgk2C4HCLTyaPy1k0VXqR+rJaK5YoFEosqGwzUIZ4YksG6Rd8IhhAgSAEZAasmsGTol8fjxGQmqEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=nXt48pVn; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="nXt48pVn"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D12360AF5
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YOD7JERYcCA for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 10:04:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 85E11606B9
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85E11606B9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=nXt48pVn
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85E11606B9
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 10:04:14 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2165448243fso34243755ad.1
        for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 02:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736503454; x=1737108254; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SbCDbM8KQIXhK7Foj8Bp5mpZOBTNVuVCawxI33XikWY=;
        b=nXt48pVnRLujk817bH/wCeufMAifvn+LuFoo+h70kCwC7ZMCNPO2ikL1++PXp/Y90R
         nGK0bp3T4fvjpa87NlWmiaOsAWEwSOzVnCSB+y5Eu3IgesHqKlHISTs8r4nVudsh+bJ2
         ssGJoYHymUCBGqD7DL68G3IbTov2rjKJGBJ+EmA5VfcsDVFPM3lyTauqsdOEg6UGk7tf
         XYxf11l4GPWRJMF1YDptclVx5ACz8wtbOtnujbXddUTcl6DaDTJTBGb58DUMcp5dYIw3
         IBw4FGfYKaalRbO1y5fVZLKUj8gRFX9okAPS+yXaY12bo4d2j3JsbkNN9L6BM+cgS42W
         iSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503454; x=1737108254;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbCDbM8KQIXhK7Foj8Bp5mpZOBTNVuVCawxI33XikWY=;
        b=RQDWGSqI2DV6F0TQHUm2CUFDgDUyDNikVdPMNmw4jBAjUoKUpVKy4CkqDVk4Ntvq65
         ixK3S4CTqAqAxk3om3IW/LToF32JFFcDDMlt5G6SPnfBqktVJ48bfAabxStSEngAKkBv
         A3A+cCqRhQGqNkT0/xZqPlhXLY25834Ts8SllcvOKwajPh/01jycYUfx9gLFVbj0Oa7T
         yY2yVZaGWrUuHXymp+IasEkc80NU75eGFI3bO7ZT713Ww4YuujFbDadbTf6QCorsCFvE
         T4U8c/eXCgXUVXyIWR2RNAopIKtYC/fe+POsfvSwdmSvy0N3ZGssb2tWVC9si1xJj4nH
         VXgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB/Vvj9d9RROqVRsnhsvJvbkKzer/UWFlFZHykgVSZbBKQe2vFSIVutpJC6Vf48/ZtM9D9aaZPRL+uXhQHig==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxPWtwrI/NRWZ6rukaoRoMEpJYigUywDBEu+p82n2Kzhf0ib9X5
	xaYcaxA1HIW3mkgngJPtb2ZXl/tS7qON+dfFvmZz8ZYxtdOqtBy8C90UatqlOWA=
X-Gm-Gg: ASbGncuqBoeGQozuGGmGq8Q5bFrfpg82vaKJBSKsbaNgSoE7TW2ilgTedo04V5REXjm
	rODYx4ab56NdWR/tBzUrFaTYdmqGeYtQ0PIG9WXCRECqao3+nymc1nBx7aVWnLoyV0HNufyvS9P
	JqB9bcXVbsGR7NmcE1qzkkL1b+Hog9uoSJ661Eu0/7CbrPfa4P/gY4GMdpj9dZP+pVmh2qE8A31
	e64ndRKc7kLSr5Gn586sp9gaAXFmGmSIDuoeBPWeEWr2DX2raXMtegQDSr47QDoreM=
X-Google-Smtp-Source: AGHT+IGwGJ74ps/x/Eb/FXDjZwvLuJmQUxKHNbskjBfpmMO+fHvECFMcSxYPTjF3D4hGyGv0Hh3cVw==
X-Received: by 2002:a05:6a00:179f:b0:72a:bc54:84f7 with SMTP id d2e1a72fcca58-72d21f4f2e5mr15271389b3a.12.1736503453610;
        Fri, 10 Jan 2025 02:04:13 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067e9e1sm1247468b3a.131.2025.01.10.02.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 02:04:13 -0800 (PST)
Message-ID: <1f2908ed-e938-4365-8f1e-9f1c7753fb9b@daynix.com>
Date: Fri, 10 Jan 2025 19:04:07 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/01/10 12:27, Jason Wang wrote:
> On Thu, Jan 9, 2025 at 2:59 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The specification says the device MUST set num_buffers to 1 if
>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Have we agreed on how to fix the spec or not?
> 
> As I replied in the spec patch, if we just remove this "MUST", it
> looks like we are all fine?

My understanding is that we should fix the kernel and QEMU instead. 
There may be some driver implementations that assumes num_buffers is 1 
so the kernel and QEMU should be fixed to be compatible with such 
potential implementations.

It is also possible to make future drivers with existing kernels and 
QEMU by ensuring they will not read num_buffers when 
VIRTIO_NET_F_MRG_RXBUF has not negotiated, and that's what "[PATCH v3] 
virtio-net: Ignore num_buffers when unused" does.
https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.com

Regards,
Akihiko Odaki
