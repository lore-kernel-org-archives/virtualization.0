Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655921CFEBA
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780201; cv=none; b=Va5trOHppZPD7h0kI9n0eY3bsXZEyjYhRNkjM29I1plps1R4QQx++cyk0csrV5VF1T1rpp1IseeGYW84VxoD8MA2Zj0zY1+DM6igeqNwIiv6S9xmOOJlAEJdC3ulXiUFAJ0D8046ES4cs01700MkitYh5h2BaBKjmHQBIom6jdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780201; c=relaxed/simple;
	bh=zdcEuao6Yueq9nynqlojGySRjewdllFC1HqW1BdVgew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbsqI53LcW05MXDlPHEfj26F6rMNIUMPPY1SL/hsEGqsGYDOzoNBmxqAlyvLlFem4kCCwIDgcRREQZEq2V9t5XrS25MOMERYa/GQUjvs1U4Tb4DKbD5PEQcyscWARmI8VDEckaDQetdktfza578gXZ2Yl5y6vSFHFTG3Oxcfgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=CQJcm76d; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CQJcm76d"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE5ED60849
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 17:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6taG6QLBxedr for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 17:36:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b36; helo=mail-yb1-xb36.google.com; envelope-from=cbilbao@digitalocean.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CAA71608AA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAA71608AA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=digitalocean.com header.i=@digitalocean.com header.a=rsa-sha256 header.s=google header.b=CQJcm76d
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CAA71608AA
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 17:36:38 +0000 (UTC)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-e03caab48a2so4496318276.1
        for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724780197; x=1725384997; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6qsGfI7hgSvO5zF/HF4LG2tjSgMq9IY878EP4P7OTw=;
        b=CQJcm76d1P2aekamvYxinCTsbkJiI6K+PxZCJTRIGDCQtLSH6I5sFGarLmURuPVlA1
         or4Xm3t7/DuJbgRwCD1BHBhQY7xrKgZZaD/QX5DovN3ZF+SiAssM6vt80TkPKbYhICly
         saSOWTKj/2RxwInBlFCWwStRA38LzOZxmK3Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780197; x=1725384997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6qsGfI7hgSvO5zF/HF4LG2tjSgMq9IY878EP4P7OTw=;
        b=cZVNe/eqN+yLcV6PK1wyMJuTLIMSfWuYtH1DhImg/wLwbLPjr9XvMK2OF7c741hSId
         g26hqcnbBZ4gHp4lcUENabIbDFPhOzQJccniXM6Ilx+fNMwBUwAzXOaTGcg1TcnKoLSy
         wKcJoGGDeQml3/di9hwgYYBZrmqkMFVKrZoTBUL+evD0nQR/7x2Pp0jg2WOma0Ml0FQH
         km1p8zXslwdf5V5YtjNQCr3YvBWJuQEy21XCvdDcuc8FU7B1iOkJunBCB9YwgTKd2wIU
         bJfbQkw8+hZZNy2ovwhAejpU3i9jPdgiLOOlMVMy3k6xKe4wyQZ1ojmmt0bwGEQ/VAbo
         LS7w==
X-Forwarded-Encrypted: i=1; AJvYcCX6eSxtCBUR0LS/WoZidhFP6/PkdVufx+XJ0jGbfqJymv7gY61xNI014EdjUfDDJjfnKXFkD0mlgqxq8Zqr0Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwR+R/W6kkGO2ekq7IEhHdEnx6WWT8gKsZmAzggTjnIBFtOAVTD
	pHWMOQ1ZzaQMzAfdaFP9gBdeQgfWKZlpY0pu2IXGcC5QyGTKIkaP76mNy4hA5xU=
X-Google-Smtp-Source: AGHT+IEfVdmQhipnsiOiT6VThaW7IpCX0ncY4BPR8r+WLzd9JbFk7D8SGhOB6tc17o/phjE//9pqUw==
X-Received: by 2002:a05:6902:1883:b0:e0e:83e1:d1 with SMTP id 3f1490d57ef6-e1a29824acemr3606390276.20.1724780197226;
        Tue, 27 Aug 2024 10:36:37 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4b71bbsm2622725276.37.2024.08.27.10.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 10:36:36 -0700 (PDT)
Message-ID: <d3115e7a-6bd0-4d6d-b759-05c9b227013b@digitalocean.com>
Date: Tue, 27 Aug 2024 12:36:35 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why is set_config not supported in mlx5_vnet?
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, eli@mellanox.com, mst@redhat.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 eperezma@redhat.com, sashal@kernel.org, yuehaibing@huawei.com,
 steven.sistare@oracle.com
References: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
 <afcbf041-7613-48e6-8088-9d52edd907ff@nvidia.com>
 <8a15a46a-2744-4474-8add-7f6fb35552b3@digitalocean.com>
 <2a1a4dfb-aef1-47c1-81ce-b29ed302c923@nvidia.com>
 <1cb17652-3437-472e-b8d5-8078ba232d60@digitalocean.com>
 <CACGkMEvbc_4_KrnkZb-owH1moauntBmoKhHp1tsE5SL4RCMPog@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <cbilbao@digitalocean.com>
In-Reply-To: <CACGkMEvbc_4_KrnkZb-owH1moauntBmoKhHp1tsE5SL4RCMPog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 8/26/24 9:07 PM, Jason Wang wrote:
> On Tue, Aug 27, 2024 at 3:23 AM Carlos Bilbao <cbilbao@digitalocean.com> wrote:
>> Hello,
>>
>> On 8/26/24 10:53 AM, Dragos Tatulea wrote:
>>> On 26.08.24 16:26, Carlos Bilbao wrote:
>>>> Hello Dragos,
>>>>
>>>> On 8/26/24 4:06 AM, Dragos Tatulea wrote:
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
>>>> According to ethtool, all my devices are running at full duplex. I assume I
>>>> can disregard this configuration output from the module then.
>>>>
>>> Yep.
>>>
>>>>>> While looking into how to change this option for Mellanox, I read the following
>>>>>> kernel code in mlx5_vnet.c:
>>>>>>
>>>>>> static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>>>>>                  unsigned int len)
>>>>>> {
>>>>>>     /* not supported */
>>>>>> }
>>>>>>
>>>>>> I was wondering why this is the case.
>>>>> TBH, I don't know why it was not added. But in general, the control VQ is the
>>>>> better way as it's dynamic.
>>>>>
>>>>>> Is there another way for me to change
>>>>>> these configuration settings?
>>>>>>
>>>>> The configuration is done using control VQ for most things (MTU, MAC, VQs,
>>>>> etc). Make sure that you have the CTRL_VQ feature set (should be on by
>>>>> default). It should appear in `vdpa mgmtdev show` and `vdpa dev config
>>>>> show`.
>>>> I see that CTRL_VQ is indeed enabled. Is there any documentation on how to
>>>> use the control VQ to get/set vDPA configuration values?
>>>>
>>>>
>>> You are most likely using it already through through qemu. You can check
>>> if the CTR_VQ feature also shows up in the output of `vdpa dev config show`.
>>>
>>> What values are you trying to configure btw?
>>
>> Yes, CTRL_VQ also shows up in vdpa dev config show. There isn't a specific
>> value I want to configure ATM, but my vDPA isn't performing as expected, so
>> I'm investigating potential issues. Below is the code I used to retrieve
>> the configuration from the driver; I'd be happy to send it as a patch if
>> you or someone else reviews it.
>>
>>
>>> Thanks,
>>> Dragos
>>
>> Thanks,
>> Carlos
>>
>> ---
>>
>> From ab6ea66c926eaf1e95eb5d73bc23183e0021ee27 Mon Sep 17 00:00:00 2001
>> From: Carlos Bilbao <bilbao@vt.edu>
>> Date: Sat, 24 Aug 2024 00:24:56 +0000
>> Subject: [PATCH] mlx5: Add support to update the vDPA configuration
>>
>> This is needed for VHOST_VDPA_SET_CONFIG.
>>
>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
>> ---
>>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index b56aae3f7be3..da31c743b2b9 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -2909,14 +2909,32 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>      struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>      struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>
>> -    if (offset + len <= sizeof(struct virtio_net_config))
>> +    if (offset + len <= sizeof(struct virtio_net_config)) {
>>          memcpy(buf, (u8 *)&ndev->config + offset, len);
>> +        }
>> +        else
>> +        {
>> +            printk(KERN_ERR "%s: Offset and length out of bounds\n",
>> +            __func__);
>> +        }
>> +
>>  }
>>
>>  static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
>>                   unsigned int len)
>>  {
>> -    /* not supported */
>> +    struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>> +    struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>> +
>> +    if (offset + len <= sizeof(struct virtio_net_config))
>> +    {
>> +        memcpy((u8 *)&ndev->config + offset, buf, len);
>> +    }
>> +    else
>> +    {
>> +        printk(KERN_ERR "%s: Offset and length out of bounds\n",
>> +        __func__);
>> +    }
>>  }
> This should follow the virtio-spec, for modern virtio-net devices,
> most of the fields are read only.


Ack, according to:

https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html

I believe only duplex and speed can be changed. Will resend patch.


> Thanks
>
>>  static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
>> --
>> 2.34.1
>>
>>

Thanks,
Carlos

