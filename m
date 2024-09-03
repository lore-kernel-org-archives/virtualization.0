Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF4188A01
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379311; cv=none; b=B++w5pNUJE2+pmUwUqlvlNSWT9QNH/hv0yUxo6t+9nZltC5kRs65o6jOsvURZYVy0fHg8FgULf3+48Er8yjmPfK2CZIVGt0COhzGxDpQJnq9/Rjlem7h+S9TIs36COK73lCKK/JJeunUTGWxMWLbftN2nj1zz1SU0UGuXc/i0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379311; c=relaxed/simple;
	bh=NRZT8abCFdh85/3FHugcXrZh7c00Mi9fTSZoCHvP0hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gL9mNEU19neEogY+GCZuWRx4vvp4WmVZNWGzEZ+zWyVr0GJINOnm0445cwtEctBYQQX5Wxwq8QjbGXY01nfNuwh5RXIA7nUEtiWobS/SVZv5pZbEHaXjDK6lisbLOVJXsXei+wmLGAngjE2CP9BcB6tN9/SOgTc79RMdRtV2w2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=FRIrrO3p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="FRIrrO3p"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367990aaef3so3272329f8f.0
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1725379307; x=1725984107; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdVAZ1Lff6N0nukYJ/rHVQx42BffOFWzvcbVrT7bSPQ=;
        b=FRIrrO3porAZs4OeTR2RRJ0qdaJODeP+yTDOjy/4GNa9bII/riDpbfZM14+/ui8XGH
         n+gI3nuIEMxdayP2wtsr43SUkcOeN4aF2sYlRKVuBnKexgV7LL+Js+ls9OyQUcZ/CnKI
         t88VL8lgsZHtbhQ7w4VHLdG9B4giGFYesAcA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379307; x=1725984107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdVAZ1Lff6N0nukYJ/rHVQx42BffOFWzvcbVrT7bSPQ=;
        b=KGFvY0CJrkZH6RQKawYDWMe4uh4BvNRdtgFTzYx+wjmotVlpseLuEX8NVz1G63/Yuf
         QxS6rT43MrAv2P8R7rND3wqcGjawaUaNCv2wvdpo2UIXHrpbrPeCYDzwwxoup/KfypZd
         utagX70LvgXKRkHJc+lqwaBD1ShGsAQtxI2qGmF4qXJDDFsFs/4ylCFD45mXtke7slln
         LPM8Jrj9v6scumhbjYSahCwPI/DVuG1xvdxrcRTXKNTdPVD1DNziW+bSwhM0eXam0Per
         rmMe0LojP7En98WKiv2NWsac3X1UwwGCgoL5X8rHgMWLnW9lt+sJA/2hN0vB0wBi8mDo
         8RxA==
X-Forwarded-Encrypted: i=1; AJvYcCVZabmX1bAlKo8fcopgDhll+5Ep58J82dKGaHjnSfqafpTMMfJGKE8hTbXGaYNb7r1q72j/Gam987LV1juoOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxCKKSoOBmdFFNJvGleMVAn2GqqhEnrr38m/P1CdrGmWDkHqUFR
	1XwSkpr3jFf+2zSrUJo8av9nUvfIh2zgj2RLldN5AJZnsn8t/BTxw6rXZPRxDAY=
X-Google-Smtp-Source: AGHT+IHIL/6aYNZW1Hx3t8q1OA7oE/XZn0XaW2g6YYk2G/Tqz2Q4bQue8JZweBesdA9BWRRKLdOFfA==
X-Received: by 2002:adf:e544:0:b0:374:be28:d808 with SMTP id ffacd0b85a97d-376dd15b11emr891434f8f.20.1725379307085;
        Tue, 03 Sep 2024 09:01:47 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:9198:79cc:8e64:e479? ([2603:8080:7400:36da:9198:79cc:8e64:e479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c08e07b6sm9403391f8f.63.2024.09.03.09.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 09:01:46 -0700 (PDT)
Message-ID: <c383c897-79ce-43fc-966a-06a4d609390a@digitalocean.com>
Date: Tue, 3 Sep 2024 11:01:41 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vdpa: Add support to update speed/duplex in
 vDPA/mlx5_vnet
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com,
 bilbao@vt.edu, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 cratiu@nvidia.com, lingshan.zhu@intel.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240829161620.38679-1-carlos.bilbao.osdev@gmail.com>
 <20240829161620.38679-3-carlos.bilbao.osdev@gmail.com>
 <c15d3682-05ee-437c-b51c-d6a824252d76@nvidia.com>
 <CACGkMEtDSDTS_SVvsf7nwMdabGCN85P-r5WpjgZdVDV5PMdc0g@mail.gmail.com>
 <f5e3768d-bb16-48eb-96df-ce5f9593b843@digitalocean.com>
 <CACGkMEtsNeL+o6Rgb=ehj8OJpfkoojasPK1ZMp4S5bMKBjwcng@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <CACGkMEtsNeL+o6Rgb=ehj8OJpfkoojasPK1ZMp4S5bMKBjwcng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 9/1/24 11:27 PM, Jason Wang wrote:
> On Fri, Aug 30, 2024 at 9:15 PM Carlos Bilbao <cbilbao@digitalocean.com> wrote:
>> Hello,
>>
>> On 8/29/24 9:31 PM, Jason Wang wrote:
>>> On Fri, Aug 30, 2024 at 5:08 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>>> (resending as I accidentally replied only to Carlos)
>>>>
>>>> On 29.08.24 18:16, Carlos Bilbao wrote:
>>>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>>
>>>>> Include support to update the vDPA configuration fields of speed and
>>>>> duplex (as needed by VHOST_VDPA_SET_CONFIG). This includes function
>>>>> mlx5_vdpa_set_config() as well as changes in vdpa.c to fill the initial
>>>>> values to UNKNOWN. Also add a warning message for when
>>>>> mlx5_vdpa_get_config() receives offset and length out of bounds.
>>>>>
>>>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>>>>> ---
>>>>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 34 ++++++++++++++++++++++++++++++-
>>>>>  drivers/vdpa/vdpa.c               | 27 ++++++++++++++++++++++++
>>>>>  include/uapi/linux/vdpa.h         |  2 ++
>>>>>  3 files changed, 62 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> index c47009a8b472..a44bb2072eec 100644
>>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>>> @@ -3221,12 +3221,44 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>>>>
>>>>>       if (offset + len <= sizeof(struct virtio_net_config))
>>>>>               memcpy(buf, (u8 *)&ndev->config + offset, len);
>>>>> +     else
>>>>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>>>>>  }
>>>>>
>>>>>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>>>>                                unsigned int len)
>>>>>  {
>>>>> -     /* not supported */
>>>>> +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>>> +     struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>>>> +
>>>>> +     if (offset + len > sizeof(struct virtio_net_config)) {
>>>>> +             mlx5_vdpa_warn(mvdev, "Offset and length out of bounds\n");
>>>>> +             return;
>>>>> +     }
>>>>> +
>>>>> +     /*
>>>>> +      * Note that this will update the speed/duplex configuration fields
>>>>> +      * but the hardware support to actually perform this change does
>>>>> +      * not exist yet.
>>>>> +      */
>>>>> +     switch (offset) {
>>>>> +     case offsetof(struct virtio_net_config, speed):
>>>>> +             if (len == sizeof(((struct virtio_net_config *) 0)->speed))
>>>>> +                     memcpy(&ndev->config.speed, buf, len);
>>>>> +             else
>>>>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for speed.\n");
>>>>> +             break;
>>>>> +
>>>>> +     case offsetof(struct virtio_net_config, duplex):
>>>>> +             if (len == sizeof(((struct virtio_net_config *)0)->duplex))
>>>>> +                     memcpy(&ndev->config.duplex, buf, len);
>>>>> +             else
>>>>> +                     mlx5_vdpa_warn(mvdev, "Invalid length for duplex.\n");
>>>>> +             break;
>>>>> +
>>>>> +     default:
>>>>> +             mlx5_vdpa_warn(mvdev, "Configuration field not supported.\n");
>>>> This will trigger noise in dmesg because there is a MAC configuration here.
>>>>> +     }
>>>> I would prefer that the .set_config remains a stub TBH. Setting the fields here is
>>>> misleading: the user might deduce that the configuration worked when they read the
>>>> values and see that they were updated.
>>> Yes, and actually, those fields are read-only according to the spec:
>>>
>>> """
>>> The network device has the following device configuration layout. All
>>> of the device configuration fields are read-only for the driver.
>>> """
>>>
>>> Thanks
>>
>> Should I go ahead and remove the ioctl then?
> If you meant mlx5_vdpa_set_config, I think yes.


Ack, I will send a new patch set in which the second commit gets rid of the
ioctl -- but not only for mlx5 but for all vDPA implementations.


>
> Thanks
>

Thanks, Carlos

