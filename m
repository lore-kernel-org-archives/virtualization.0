Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2F1A9B53
	for <virtualization@lists.linux.dev>; Fri,  8 Nov 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109489; cv=none; b=j3HZR6jnInwCe0V4I8GlAJy8oDgYkc7+W8fayoD/NNYMIwjI1oGNB5elffGV3/1Au+ilKxAKYehtUNlAP7sesHtRvHXJI6aWSokWD60t7buiSY2/AMwYg6U6NUB52BYiQDq/UKE0/+7pbxIuLzkQWlEMvuCEZbrLS5thIvwdPsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109489; c=relaxed/simple;
	bh=ExUMXG6FhgrKWAiklD9tM+a73nAXl3Qf+VUQQugGkzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO1eb+XJUGWHXAFagFOb1Kv3sJQrXpTqaD8WxaJzeBr9igcU6PG+dc6Q3oDV3d3Z/K0cDU0Me8KC/pca1SUPsuqAnaxkjcPl9Elf+ic2Oi9qAM+v/qH8xQwcONUrODSAnztpwpZ/OXn9oo35ZF/CDyyZtDrBs8FQXaPQsIc9dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=IaR3VKzK; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="IaR3VKzK"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e60966297fso1473067b6e.1
        for <virtualization@lists.linux.dev>; Fri, 08 Nov 2024 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1731109486; x=1731714286; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXbMh2FWVPnoribRVM7nCxASoiz/7gphLz9Rpu66roc=;
        b=IaR3VKzKwVrQsE7/9CxAGgUIt0r2FimX0ai1709PWwj3ilcDX8t6dXLF0IwnOi1vPh
         vlXkHTN85MDqZlau/DgcpfVQxsO73IzgJj2y4dURiHNvgCMyiLLQE7VsYRZodoOhJCvw
         60XWZ89yvxN4Tujvdo3vQmysk7n2ihtoiMnno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109486; x=1731714286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXbMh2FWVPnoribRVM7nCxASoiz/7gphLz9Rpu66roc=;
        b=ZpJ9s2owC2v4KFiy0Tf7ZcTjqK15dB4D2HLGh4eJ6UwbmTpbAo9J1qrX3LNJgx8nc8
         BRZK0Zxba249Fq5otxBrRNefghLvKtoA33H63+5CyXVP4WVHmPeNKFAgfAO9UsupbDXz
         P5nV6Ji60ap5y1i32jpG6BrXBiMhu58jN8QIz9AH6Um4m4KdKpLkFvjhe1qRCiDxXx2J
         Gv1em9UoiIdesAbxzIqhtJoNoBD1QBChmiGGx38j4HwLBJKrh3Q2M4lb/3vOc83VSt/S
         AANvFJRw5urNii734bFrK4ePAUCfjMCiLncSNli92OlRdzXZuLRDIHHyjQxL1oR+LP6i
         WbLA==
X-Forwarded-Encrypted: i=1; AJvYcCWLQLz5pXpRoE8oKFWvaz0edeJ9XCtTN9w7nWuhDHUw+jo/10LgToHonkY+0MdtNUOj3LQAcWvdoAqOQg0BEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPmlqdnmeIoHc3uJp0yX1PFy9rWWofeLADAu2R/pQvGfzD9/Nz
	3rDYq2okBKHKpZL+tA0DeJbVJF/0g23d0199VDosA3JjPZeO/mXX77FMDGq9gfg=
X-Google-Smtp-Source: AGHT+IG+H1FYbgbfbVNVGwbagbKbs0uGKWVICE1ilxxQpWr7EmkKOvo2KKLljNXMkuaHIGL4cbLpWg==
X-Received: by 2002:a05:6808:13c8:b0:3e6:5580:6667 with SMTP id 5614622812f47-3e79475cf8cmr5606582b6e.40.1731109486620;
        Fri, 08 Nov 2024 15:44:46 -0800 (PST)
Received: from ?IPV6:2603:8080:7400:36da:c10e:e419:c908:c818? ([2603:8080:7400:36da:c10e:e419:c908:c818])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cc6748fsm943945b6e.2.2024.11.08.15.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 15:44:45 -0800 (PST)
Message-ID: <bb010d16-a083-44da-8a72-3ada4c6f8056@digitalocean.com>
Date: Fri, 8 Nov 2024 17:44:44 -0600
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to
 UNKNOWN
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, jasowang@redhat.com,
 shannon.nelson@amd.com, sashal@kernel.org, alvaro.karsz@solid-run.com,
 christophe.jaillet@wanadoo.fr, steven.sistare@oracle.com, bilbao@vt.edu,
 xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com, eperezma@redhat.com,
 cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
References: <20240904151115.205622-1-carlos.bilbao.osdev@gmail.com>
 <20240904151115.205622-2-carlos.bilbao.osdev@gmail.com>
 <20241107164932-mutt-send-email-mst@kernel.org>
 <f1d671ff-0429-4cb5-a6e8-309a8567924c@nvidia.com>
 <20241108065046-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <20241108065046-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 11/8/24 5:51 AM, Michael S. Tsirkin wrote:
> On Fri, Nov 08, 2024 at 10:31:58AM +0100, Dragos Tatulea wrote:
>>
>> On 07.11.24 22:50, Michael S. Tsirkin wrote:
>>> On Wed, Sep 04, 2024 at 10:11:14AM -0500, Carlos Bilbao wrote:
>>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>
>>>> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
>>>> This is needed because mlx5_vdpa vDPA devices currently do not support the
>>>> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex.
>>> I see no logic here. Without this feature bit, guests will not read
>>> this field, why do we suddenly need to initialize it?
>>>
>> IIRC, Carlos was reading data via ioctl VHOST_VDPA_GET_CONFIG which calls
>> .get_config() directly, always exposing the speed and duplex config fields [0].
>> Carlos, was this the case?
>>
>> [0] https://lore.kernel.org/lkml/afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com/T/
>>
>> Thanks,
>> Dragos
> Basically, driver should ignore these if feature is not set.


There _is_ a chance the guest could read this field; As Dragos mentioned, I
was using the VHOST_VDPA_GET_CONFIG ioctl from userspace, and the incorrect
field initialization led me to believe I was in half-duplex mode --
something people told me they hadn't seen since the 80s. But as Andrew
(CCed) mentioned, "If the speed is 0, does duplex even matter?".

I also tried to remove the pointless ioctl call altogether to avoid further
confusion [0] but that wasn't viable due to spec compliance.

Initializing the fields seems the simple solution here (and, IMHO, more
generally, it's as a good programming practice)

Thanks for looking into this!

Best,
Carlos

[0] https://lore.kernel.org/lkml/CACGkMEvfdUYLjx-Z+oB11XW-54ErJsQMKcnu2p=dsj5N_BiEKw@mail.gmail.com/


>
>
>>>> Add
>>>> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>>>>
>>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>>>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>>>> ---
>>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> index b56aae3f7be3..41ca268d43ff 100644
>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>>>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>>>  }
>>>>  
>>>> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
>>>> +{
>>>> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
>>>> +}
>>>> +
>>>>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>>>  {
>>>>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>>>> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>>  	init_rwsem(&ndev->reslock);
>>>>  	config = &ndev->config;
>>>>  
>>>> +	/*
>>>> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
>>>> +	 * setting the speed or duplex.
>>>> +	 */
>>>> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
>>>> +	config->duplex = DUPLEX_UNKNOWN;
>>>> +
>>>>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>>>  		err = config_func_mtu(mdev, add_config->net.mtu);
>>>>  		if (err)
>>>> -- 
>>>> 2.34.1
