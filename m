Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B638665B
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352083; cv=none; b=ga1otmcsPy+IU/VkrGRastNbzF+ZpwQa0sFYGmH1xuY04jkHpadurxlirRawCfEiZ0fg1AHqYzpQCa8l8v9LnABWsjen82knQyFzcJidxkyLaGB4qxLIHMbVrz+oA8Gma/d8Pih8hvFMvP+HC98BJSQG7snEVTJ80vMPATqZjVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352083; c=relaxed/simple;
	bh=BDt3n+MUaCFNO4y3L2tuOOVWGjx2h2RQhyP7NCMw9HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAjo2Zl2JUNqoZ+QcMHilPjr9zCrWD6jAXfx50PfUAfWX85mKyIj2HKeaL2t0+1azDCB1V1pwvVdJv4RlFkwdcWQ9uBruZqLxyAabfLg1yVr4Xc5YySlFeaSfYoIDlJqQ0+rTaXq5z42WBbyj3s07/D5JA5W/8NqPmYjr7mzxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1R2wcGT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1R2wcGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711352080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I4mGWtPnXl+rCWErFK37GiocqArlyDhDISrag+E6MY=;
	b=i1R2wcGTd+Y6Lm1ZGbeZRJxcbz5IFNUilNqnSvsQfwzLjoxRJJENXbZXGDNifelVVvW59g
	H7w29KRs+hd17UWlOyp3aUhpGbFrp48YHetepjmpKeGhKjI8YSKRx1ZxHy/Qz03Yhhk5vs
	P3JX6x41/Rq3gf97d1So4gccx34HqCI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-8Lom4U2TMFqdwoTutu01zA-1; Mon, 25 Mar 2024 03:34:38 -0400
X-MC-Unique: 8Lom4U2TMFqdwoTutu01zA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-22a0191d8f0so1444960fac.2
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711352077; x=1711956877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I4mGWtPnXl+rCWErFK37GiocqArlyDhDISrag+E6MY=;
        b=KBdoef1fGhdEOjzZf4L1NuPhjkDBxJrmDlBzj8sN7l07HBpmsuO1ADWY1oyc1P8sbR
         RWqOPNGNJKq3a/fKcqiTu2S08biEsjku94bKk2TdENKGEdldplikGQDRv2bvDoj0bTmS
         I69Ds60zJiPQOCqFf+da1GXnNYDTvmSwHcAYbEK21DpVZtQk6xE3zw+X5A7CYq9eCB9a
         9idsVTAM9KtooduGPrKa7RIscaymwlihxCkx5DC4kLrDsJTYPD/a+UBzIy7ohsWVzAZt
         G4GZWbZ0tvV2qfNkilb5TRYpVm89HhZmmnP+7FrSksDf+FHgGK3gp6C9nClXVUbuNIeZ
         C7jg==
X-Forwarded-Encrypted: i=1; AJvYcCUCMNfzeFMbfdD+W4O3KyNMPZxmcKYaglY3J4cDY9fHJTttD3DBfZwuZQfzQ17Dsdgp6V1WOw2IWlSy6qgxcokEhG6g3/hag93euLUeADU=
X-Gm-Message-State: AOJu0Yy0nwwM0yDsnO9dLba1BQiWsoKzIyZw3ZRkuF2b+BVubBpsq3Kz
	GcqRI7L62cR2ygwyLEFYbLTcuEVtPBg9mcobMvhZe1UVjlNLZlqnxjnF0NonLMctf46BpWQUcoV
	WRWex9barlX3HQeZWxRw/DvsGa2xGjq4RyfQjW/mSNUUl9zlceHoZzv2CUF7xbVt9
X-Received: by 2002:a05:6871:288e:b0:22a:2446:353f with SMTP id bq14-20020a056871288e00b0022a2446353fmr3755163oac.11.1711352077653;
        Mon, 25 Mar 2024 00:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKY6GYp1/XIaWHrTUl2r4qAWkWvRiG3Ehn1RpYbN3BtHiFYE6R3jh1TKiJs6ZlTqhiC8/SJA==
X-Received: by 2002:a05:6871:288e:b0:22a:2446:353f with SMTP id bq14-20020a056871288e00b0022a2446353fmr3755157oac.11.1711352077282;
        Mon, 25 Mar 2024 00:34:37 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id c17-20020aa781d1000000b006e6bfff6085sm3766624pfn.143.2024.03.25.00.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 00:34:36 -0700 (PDT)
Message-ID: <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
Date: Mon, 25 Mar 2024 17:34:29 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240320030215-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/20/24 17:14, Michael S. Tsirkin wrote:
> On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
>> On 3/20/24 10:49, Michael S. Tsirkin wrote:>
>>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>>> index 6f7e5010a673..79456706d0bd 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>>>    	/* Put entry in available array (but don't update avail->idx until they
>>>    	 * do sync). */
>>>    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>>> -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>>> +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
>>> +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
>>>    	/* Descriptors and available array need to be set before we expose the
>>>    	 * new available array entries. */
>>>

Ok, Michael. I continued with my debugging code. It still looks like a
hardware bug on NVidia's grace-hopper. I really think NVidia needs to be
involved for the discussion, as suggested by you.

Firstly, I bind the vhost process and vCPU thread to CPU#71 and CPU#70.
Note that I have only one vCPU in my configuration.

Secondly, the debugging code is enhanced so that the available head for
(last_avail_idx - 1) is read for twice and recorded. It means the available
head for one specific available index is read for twice. I do see the
available heads are different from the consecutive reads. More details
are shared as below.

 From the guest side
===================

virtio_net virtio0: output.0:id 86 is not a head!
head to be released: 047 062 112

avail_idx:
000  49665
001  49666  <--
  :
015  49664

avail_head:
000  062
001  047  <--
  :
015  112

 From the host side
==================

avail_idx
000  49663
001  49666  <---
  :

avail_head
000  062  (062)
001  047  (047)  <---
  :
015  086  (112)          // head 086 is returned from the first read,
                          // but head 112 is returned from the second read

vhost_get_vq_desc: Inconsistent head in two read (86 -> 112) for avail_idx 49664

Thanks,
Gavin


