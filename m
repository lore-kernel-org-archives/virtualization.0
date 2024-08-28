Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17591A706A
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866096; cv=none; b=CFxlrRx/AMiI8IZiIZtReine/4O2wIckPIkwXwk1VA1woE7oqgtib5gwBj6P1g3Mb49aPJX3IVcw7IXillNGR5qtCwLjX0TusGiiC/thYGhmEUPAoDIWDQdRGISpXp7nEqaSHzze6Isl4C9s3Eqh/dQ7sA0YM0Y5bvS+EipKKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866096; c=relaxed/simple;
	bh=HypgDgtB4ct/OuJkz4CzqDuTTpFOG82yJbB3Gp9Nl3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCp7Dttqd2aZWs1qP0863xYAW8RDnCunChZPWf5/h4pPWhuc6nXJby6BipM3dNiTdubiraorUdlKKKr6H9t8B7V+QYK0bkarjmt0UJvfbHjbBZuVMxBMsbm972+BWrUwP6dFUwfO+MIlG/DNah66HF5MnvqCv7468evIYAOJ040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=PHRBD79v; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="PHRBD79v"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B1F4605B7
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 17:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppkloeuFS5Co for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 17:28:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=cbilbao@digitalocean.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F65C60B65
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F65C60B65
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=digitalocean.com header.i=@digitalocean.com header.a=rsa-sha256 header.s=google header.b=PHRBD79v
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F65C60B65
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 17:28:13 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-690aabe2600so62007657b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724866092; x=1725470892; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCPXRj4O3bcsketV9hnxl4fQbKxvadzaMLv4xTGbmvw=;
        b=PHRBD79v+Y6HXEqn46y79Jlz+pn3qsGIUeopSsNhyA+xCceBZOAjryr3c55tp3ls3y
         yAC4FsZySCa1G8UVYcf6pqEEyrmbXhMvGR+Pmcm+womnTnGHKjLvocFYBRCrIIcw3CkW
         jy9n5uUv/nwJCZ2RXZWHhIchBW4OkVaRBhcoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724866092; x=1725470892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCPXRj4O3bcsketV9hnxl4fQbKxvadzaMLv4xTGbmvw=;
        b=BlSWSX68OY41CIGL7VjX51LdcFxg9uFhrDssm58eKYlG27dHErZ19hwMXNgF3qfCRp
         4G/TcaIHIxxmPuxh7A1Q/MN4al4AxOtCbsNZWhKYOpVgi1D0j+Fz8ykyYnnWiZIA9PtW
         bYjOmAgO89gU5ojUCdWImNkrvKVyHZ65DI9yC/LYB5N0N2biqVA7fX6zVP3VQ8XgcysQ
         t+leoOAX4w5MD01jGfuw1HEp6UPvsMvbsfWpOxlmUiN1kvwP0nEDuCPLSNA1hMJfgaKF
         9s9EFqE+YpArHJ/KUJGeQeSgQaxM7MUnb6UXc/snF8tCFlBZcXAFfrb8c4zpBZeXCmyE
         OLKw==
X-Forwarded-Encrypted: i=1; AJvYcCVTI8AJZ3VWIlnkc0zWM5SWIX4imYAf44sR9rpEVFxRA4OU9CgXu1PwZNnlSFdH/115VOlZf56ExZBjjd7kZg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwbvA1xYZ+SPg4wDel1jGvjeK5bbpUaOqAl/Iy3iiBDTbpHXeuL
	FCKU/6Xg37xIpSbloVNxevd3w9eHq+Ei4EmIZ4HLxa1C977c2XkNiTwZSWoRhDA=
X-Google-Smtp-Source: AGHT+IFPC41Qak2gZ0YGJ2D7BiYZJ3IUJn9Ef3OAyW792KU6hAe4yKyakK/6d00Omzjp9FW2G84t4Q==
X-Received: by 2002:a05:690c:6512:b0:64a:4728:ef8 with SMTP id 00721157ae682-6d277f51e62mr651667b3.44.1724866092130;
        Wed, 28 Aug 2024 10:28:12 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:b4f6:16b8:9118:2c1a? ([2603:8080:7400:36da:b4f6:16b8:9118:2c1a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39de41cb8sm24217897b3.116.2024.08.28.10.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:28:11 -0700 (PDT)
Message-ID: <41a2a533-549e-4f45-9d8d-68b5ef484b05@digitalocean.com>
Date: Wed, 28 Aug 2024 12:28:09 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, eperezma@redhat.com,
 sashal@kernel.org, yuehaibing@huawei.com, steven.sistare@oracle.com
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
 <fd8ad1d9-81a0-4155-abf5-627ef08afa9e@lunn.ch>
 <24dbecec-d114-4150-87df-33dfbacaec54@nvidia.com>
 <CACGkMEsKSUs77biUTF14vENM+AfrLUOHMVe4nitd9CQ-obXuCA@mail.gmail.com>
 <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <f7479a55-9eee-4dec-8e09-ca01fa933112@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/27/24 11:54 AM, Dragos Tatulea wrote:
>
> On 27.08.24 04:03, Jason Wang wrote:
>> On Tue, Aug 27, 2024 at 12:11 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>
>>> On 26.08.24 16:24, Andrew Lunn wrote:
>>>> On Mon, Aug 26, 2024 at 11:06:09AM +0200, Dragos Tatulea wrote:
>>>>>
>>>>> On 23.08.24 18:54, Carlos Bilbao wrote:
>>>>>> Hello,
>>>>>>
>>>>>> I'm debugging my vDPA setup, and when using ioctl to retrieve the
>>>>>> configuration, I noticed that it's running in half duplex mode:
>>>>>>
>>>>>> Configuration data (24 bytes):
>>>>>>   MAC address: (Mac address)
>>>>>>   Status: 0x0001
>>>>>>   Max virtqueue pairs: 8
>>>>>>   MTU: 1500
>>>>>>   Speed: 0 Mb
>>>>>>   Duplex: Half Duplex
>>>>>>   RSS max key size: 0
>>>>>>   RSS max indirection table length: 0
>>>>>>   Supported hash types: 0x00000000
>>>>>>
>>>>>> I believe this might be contributing to the underperformance of vDPA.
>>>>> mlx5_vdpa vDPA devicess currently do not support the VIRTIO_NET_F_SPEED_DUPLEX
>>>>> feature which reports speed and duplex. You can check the state on the
>>>>> PF.
>>>> Then it should probably report DUPLEX_UNKNOWN.
>>>>
>>>> The speed of 0 also suggests SPEED_UNKNOWN is not being returned. So
>>>> this just looks buggy in general.
>>>>
>>> The virtio spec doesn't mention what those values should be when
>>> VIRTIO_NET_F_SPEED_DUPLEX is not supported.
>>>
>>> Jason, should vdpa_dev_net_config_fill() initialize the speed/duplex
>>> fields to SPEED/DUPLEX_UNKNOWN instead of 0?
>> Spec said
>>
>> """
>> The following two fields, speed and duplex, only exist if
>> VIRTIO_NET_F_SPEED_DUPLEX is set.
>> """
>>
>> So my understanding is that it is undefined behaviour, and those
>> fields seems useless before feature negotiation. For safety, it might
>> be better to initialize them as UNKOWN.
>>
> After a closer look my statement doesn't make sense: the device will copy
> the virtio_net_config bytes on top.
>
> The solution is to initialize these fields to UNKNOWN in the driver. Will send
> a patch to fix this.


With Dragos' permission, I'm sending a first draft of this now.


>
> Thanks,
> Dragos


Thanks, Carlos

