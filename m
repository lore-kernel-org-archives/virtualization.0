Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C818A950
	for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968353; cv=none; b=nQ0MX2eNSga0TeK3iTmGHLfyc4OLHIdhjIYuv0bg7SFtXAeEM0C3HJ6ldZyu3HzHV/04e1Igzi4Vwzbxoy5v/wEIO7xBvlZ/PqIPfbUhhisaz8a7cBg8sOtPrmQB2nNBI5ajvGvA5xc8Ae5L1vbGYhjASqrwwK4vetbYXJ4Bhvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968353; c=relaxed/simple;
	bh=/CcmcTMnessIb6rMXo6Vz2q2P03f6osUH9ntyJOQAxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml5h7Om5fZtBkww8cQFxFwBEc9Oa8Rh/lF/C3vxE8MC4JtItBLuvQCz06prM+hgS7KneJE2izj+Pxem+zRzOrhZCmoEDrXcOYDg7oTS1SKt/1lzr5A1uVfNZOqm38RSWFMXo1f4NdD9sVATs2t5XEsHEMMCZ7RvQku5oi0ZN3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=iCxKL60G; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="iCxKL60G"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-716609a0e2bso162876b3a.0
        for <virtualization@lists.linux.dev>; Thu, 29 Aug 2024 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724968350; x=1725573150; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nbmb+IWtpDLVzhb8oZPS2dnRSnnkWab/SsKmSrsVb4=;
        b=iCxKL60Gs0tbcJ2p/WNiYplsjHCRoEGczgjqRaE6gL/047mD49fYzFAA/kVwv9qSpa
         JP+m/WLs636/xuMoJjGbkBDSG6C4SWYbSHH0zfV0gvvYtVXKDFKi8qGy679sI+qltSwz
         kA7/VKDGgqf8XL038Yk8JHczvt/Fe770qBMKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968350; x=1725573150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nbmb+IWtpDLVzhb8oZPS2dnRSnnkWab/SsKmSrsVb4=;
        b=doNe7vBu4UfSpkIudOPJM3qb20Ezx6nisQvyLR3AbaW789P7kQ2L6/E9Us/oUfR/tn
         Wu/LXXDsgBFD0xQnwiW2+fMJemBU1YTAQ5nglxthhm/m0hJXXtzSeyaIqlB9zkqUtn50
         UPC5H22QL7Mo141Yd3swS7bje/yp2WU1UaERZiax8WnJaUn2NbAnSSgYtrlXmbU/0S59
         QN6P3ykdqpzPp7VDTE+pfmEer9MNf80IJ2N9w3nfHEJ2EAOojhHOciQGPXRx/TjmnCbv
         QJGbvMo9APWlI97jZ6mS7lrR7ZZqyIt3+WwbieCReW8STHPUQ3qJenJjB4Le2X3KjUMU
         QkQA==
X-Forwarded-Encrypted: i=1; AJvYcCUFtizJalTWyAWlVNxCR+THy+PZhXUot1C/89RBjfmdsEl3L9EamRu3ZN9mCstEzixgrxrQhTbRSlfO7JhcVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4NOa1Ghy3l1yxcPry+N6c3xdFaQasOCWvxwMhpmLvS12YEs8F
	imcvMByJEs0kxXw738ZhEgonMQQs9BzMT+3aSXn+VMxZEO1YoiNpZIgdbX+Zl+M=
X-Google-Smtp-Source: AGHT+IFOTao+ygbBsNeq08peBUYhqOzW1NLF2cvp5AwTrSk4J8BKeL7KcmVJZPv+rR6r542tbxicXg==
X-Received: by 2002:a05:6a20:cd91:b0:1cc:e969:a783 with SMTP id adf61e73a8af0-1cce969b0admr2221511637.20.1724968349291;
        Thu, 29 Aug 2024 14:52:29 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:b4f6:16b8:9118:2c1a? ([2603:8080:7400:36da:b4f6:16b8:9118:2c1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5223sm1587084b3a.72.2024.08.29.14.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:52:28 -0700 (PDT)
Message-ID: <a5d0e215-87ed-4fda-917d-7f95409a3d55@digitalocean.com>
Date: Thu, 29 Aug 2024 16:52:27 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mlx5_vnet: Set speed and duplex of vDPA devices to
 UNKNOWN
To: Dragos Tatulea <dtatulea@nvidia.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 jasowang@redhat.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-2-carlos.bilbao.osdev@gmail.com>
 <06bda32c-6670-4d47-bd68-f8d0771aa838@nvidia.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <06bda32c-6670-4d47-bd68-f8d0771aa838@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 8/29/24 1:44 PM, Dragos Tatulea wrote:
>
> On 29.08.24 18:16, Carlos Bilbao wrote:
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
>> This is needed because mlx5_vdpa vDPA devicess currently do not support the
>> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
>> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> Nit: prefix is vdpa/mlx5. Once that is fixed, for this patch:
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>


Thank you, will keep that in mind to fix in v2.


>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index fa78e8288ebb..c47009a8b472 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -193,6 +193,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>  }
>>  
>> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
>> +{
>> +	return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
>> +}
>> +
>>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>  {
>>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>> @@ -3795,6 +3800,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>  	init_rwsem(&ndev->reslock);
>>  	config = &ndev->config;
>>  
>> +	/*
>> +	 * mlx5_vdpa vDPA devices currently don't support reporting or
>> +	 * setting the speed or duplex.
>> +	 */
>> +	config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
>> +	config->duplex = DUPLEX_UNKNOWN;
>> +
>>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>  		err = config_func_mtu(mdev, add_config->net.mtu);
>>  		if (err)


Thanks, Carlos

