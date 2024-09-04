Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CF1DA63C
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459293; cv=none; b=QZPCL2Y1XX9VS9nCfyjpvbxgn1RYMK7s5vsKZZIyZ0ntuKtZTiFu/o/F4QI833rRLdOccvX1xFU7WgKB3eL1tviPcfJ2YHfu9eJvxAcnsx9ACYJmFHrhinYz7SHMnk+05wqTYt43HniuTaRVx1MPu6bXY8vjhRhVCzt2BX3saDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459293; c=relaxed/simple;
	bh=EAbM2UnFa72wVdWWBqqRyRQgWejPG1DbzUNZnzQJkEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUJviAYLmh1D+biwSkk7SSWiYZw+ja2zA6Od1Nnch8ikP/XdH2DgXC3Yc7JmPuSy4SBLj94W0Ljo/ipVoTpNlzHs0zW3ml3iw0ZDlpx2okQ8YMDxQluec+cAlinzbOUd5dmq+tn07danknHpUEb718e+IoKdKVyvSCyWI4V0TaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=fB77MxsV; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fB77MxsV"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093c94435bso404322a34.0
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1725459291; x=1726064091; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2zFJNjmlh7TSNpNu+D4XoMWDhZuFDjWykzgo/SVb00=;
        b=fB77MxsVHTvTHRO7OgML6y/mm3AQBtXdnvpZ3KidErPSk6x+LKEK1QfNqeZQq68ag7
         tgLDUbSeEBiANxOCwdzmt8r6oQJspuXu2/I46nx0J3ScfQOVrAR+LLYp7vmHW6RB3LDv
         HKdxNqSQ3FFi+Erd+tr8CXoLJI0anT76AE7eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459291; x=1726064091;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2zFJNjmlh7TSNpNu+D4XoMWDhZuFDjWykzgo/SVb00=;
        b=BLyuERezhO7HanoB0OS6lNyh7dxA0FvMeE+t1E88kUn5mXov0qQhStoBQjNW9ilMYQ
         7tEbwRxmu5mhyG3bwEQIussoaSsu68Qr/4Jlb5U749XFe4THwA9wmZMmkj07QvIMyZwb
         GXoEISl6ml4Ufep0JK8J+PTpZbHCPqUgEQzlBMOSjd+tuQAb6T1Jl2RnugcV8Q/jPnEg
         7os4gAgwwvz6Tskbv7TCkgKBKdL4TMGNCpzfKNnWQKUcy3+S91oZNUKmsvfgcC+EXJhi
         2P7RQr3qY0G8FxR4J8p81znOTyOWKdd/yF0ROhuc/8LTySRjNm1bevZ3+sqeVPcCPsy/
         kUWg==
X-Forwarded-Encrypted: i=1; AJvYcCWWddj1Vq6PT4jP9OCIq60mnLtwB1pJNktEcaSbBnl9+/cLVGR6LtprEdEAAOH6KZIHedPgcQnovW+SkZ2h4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaZ2G3nnGSxcMUDz1+922z2IzWLcahar+vYuhM3rWlnsw+Y/vB
	voYkIcpMkdEmGXxyk3cweYOUf0S5Hymz/U8U5S4w3TNHu/k2cPXEVSqh65CT4L0=
X-Google-Smtp-Source: AGHT+IF8x1KRFTbVI/tCqTEz2UCODtWaFHD2bIWQmszStc6yMXrPcpHBsLbt9nMWf8YEb5TSrZ9Kpw==
X-Received: by 2002:a05:6830:4123:b0:709:4829:47bd with SMTP id 46e09a7af769-70f5c3d97b2mr19826590a34.22.1725459290711;
        Wed, 04 Sep 2024 07:14:50 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671c2a8csm2854961a34.73.2024.09.04.07.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:14:50 -0700 (PDT)
Message-ID: <72e24344-2be4-48e5-b29f-7564fae3b15c@digitalocean.com>
Date: Wed, 4 Sep 2024 09:14:48 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vdpa/mlx5: Set speed and duplex of vDPA devices to
 UNKNOWN
To: "Nelson, Shannon" <shannon.nelson@amd.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, dtatulea@nvidia.com,
 mst@redhat.com, jasowang@redhat.com, sashal@kernel.org,
 alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr,
 steven.sistare@oracle.com
Cc: bilbao@vt.edu, xuanzhuo@linux.alibaba.com, johnah.palmer@oracle.com,
 eperezma@redhat.com, cratiu@nvidia.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-2-carlos.bilbao.osdev@gmail.com>
 <3e9a6d05-a76c-4bbf-9f4e-2e126259b70e@amd.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <3e9a6d05-a76c-4bbf-9f4e-2e126259b70e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Nelson,

On 9/3/24 12:37 PM, Nelson, Shannon wrote:
> On 9/3/2024 10:15 AM, Carlos Bilbao wrote:
>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>
>> Initialize the speed and duplex fields in virtio_net_config to UNKNOWN.
>> This is needed because mlx5_vdpa vDPA devicess currently do not support the
>> VIRTIO_NET_F_SPEED_DUPLEX feature which reports speed and duplex. Add
>> needed helper cpu_to_mlx5vdpa32() to convert endianness of speed.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index b56aae3f7be3..5fce6d62af4f 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -173,6 +173,11 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>          return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>   }
>>
>> +static __virtio32 cpu_to_mlx5vdpa32(struct mlx5_vdpa_dev *mvdev, u32 val)
>> +{
>> +    return __cpu_to_virtio32(mlx5_vdpa_is_little_endian(mvdev), val);
>
> I hate picking at little things like this, but this should be a tab rather than 4 spaces.
>

Correct, thanks, will fix in v3.


> sln
>
>
>> +}
>> +
>>   static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>   {
>>          if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>> @@ -3433,6 +3438,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>          init_rwsem(&ndev->reslock);
>>          config = &ndev->config;
>>
>> +       /*
>> +        * mlx5_vdpa vDPA devices currently don't support reporting or
>> +        * setting the speed or duplex.
>> +        */
>> +       config->speed  = cpu_to_mlx5vdpa32(mvdev, SPEED_UNKNOWN);
>> +       config->duplex = DUPLEX_UNKNOWN;
>> +
>>          if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
>>                  err = config_func_mtu(mdev, add_config->net.mtu);
>>                  if (err)
>> -- 
>> 2.34.1
>>

Thanks, Carlos

