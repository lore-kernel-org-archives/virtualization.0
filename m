Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89C3FADEE
	for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967950; cv=none; b=mgazGIlSy+61no5kx94tgdsn7aw75IdSDIbt0cD8tOJZ1LkNJFMCM4Kt1ketDcXkFyAOF82+gFQAT75tJvWVwm/pLqzur/AP1pTLCcFVQc2dO6/R31xXyTFFG+JYNK1QBdheHCi7D/4SYxPyrqp5ZfSm2SWv3nKosvpbWUcKvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967950; c=relaxed/simple;
	bh=GMrCPecVJzvTJhOOu1MZMFhbqWBNWNi0pDSzmWI0JSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WURhDPAQn7htWl0T+wkQjqhXBC0l/ztqEEJP6x+btdgGXWhynopO5wqSk4adaIBQydBzmzLlxysW11cdPqmMZ+LUNvueczQe4bEtlDmrasbKNkFFxpcVG9fQWEhAY+BKvKN/Untk8CTDEmI0LyBLOngmwiFRg4QHWM6ntg/CEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Umnn0F+T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umnn0F+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774967948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPCR3PMvQkWFspGuikt51070xkjVMXE9QsAUDQr8XCM=;
	b=Umnn0F+TKhZiRRzva+GfGhHrZH2QjsSmja5QYpBYWwDlKcmsDMSCtmsGQmQtk6W4vUvhIN
	OAdovxii0+KW0Km6RkscAVNF7tGVyq1eFnTwXBb9DoCIzPOTzZQmnkNSW8UKwufDd2U/VF
	ONR5gmpAiuUFSMMZf4BVNHjvPv2DaN8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-NUg_BZvgPb-TKe0VMRiSuA-1; Tue, 31 Mar 2026 10:39:06 -0400
X-MC-Unique: NUg_BZvgPb-TKe0VMRiSuA-1
X-Mimecast-MFC-AGG-ID: NUg_BZvgPb-TKe0VMRiSuA_1774967946
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so62730475e9.0
        for <virtualization@lists.linux.dev>; Tue, 31 Mar 2026 07:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967946; x=1775572746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPCR3PMvQkWFspGuikt51070xkjVMXE9QsAUDQr8XCM=;
        b=U4SElcJql2kAEmLBKs2PY2lGOXBv8JmeOcgegkQy/QAs0hke8sfjNbJluEpvr81BcI
         BEt9kKtsjZ2BzNvxYq404ZeIp5X7o7EuY57KvEm7OnN51j/YawH9HZmRYwM6MT4sOGdX
         BW+UCmJn3HKoDMJ3UaN8PJEc2OV/lyRJtE3Zr3MmgMs4Teg6ySTtE1RMTZnbkXsQRhyz
         8gQrxfN0DYAPycxyvzVb5t2ytdtzzE4i8mWFa48Ob4xgS2SLHmOOgN9FPw9l1n1K8qZw
         9heqzwyxLlb0yO73mxlAktiFwIOnNHmO5KsNVV+4KxSY2hRp10VkhZd5PQeHU3gxzOek
         VaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkPNej6gRwr9GeeBMYpVfln9mq4tIIfv/1RLed0HLi9qH5WQ71dUrRP5SiNAgc6W9EmugZBY65NY6cgi9rZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzObB/4NR7Rqro37YhXiwMB592Vhv2X11e46JubTGu9A090m3Yn
	uBI6V/7Cx7i0K133Q5O3BmbUGBafDJMHQIPo6zaGPrnM9dlAw1tRIp2qHZljL+hKq+ir+8tersW
	WO6AWQQY9HdxByUWe9lJBTmApmZxZzewv5EunAaTEOaYo42KDCna2gt7/iUZQXWIMYJH7
X-Gm-Gg: ATEYQzxyEnHFjq1Jh/m2OT61B8W6WcsNNMzlNXamRs1WOBXthz9b+L6EIzlleNMQAqm
	J2IrdHC0Jfi61vb3+8FvBWjK+A14/M09e5Jf381XTLbJ8XwSrnhgG6CZclv3a3QlbA8hj7fiNRz
	F+1YZHsryCQQxVkthMCCxtFT/e2hXkfU1Zf9I6OY5rhtOngnadjepjseKUK1vZ6fvuf+JGfgtLm
	i0QWC7UYcadjFGFeWGwd8SuNyCsQtDjufLaQ+g9QV/5EiDH4S+F6+QFzN2pptfA4FzF0F8WxbAb
	Mm9+/Fn+EFpq19r1nuHOaEiELtKhpi93UoG/FaL9kMsEqnsV5Ow1z0PbkG5VOjRhrTnpVQCmMtx
	q2adVX+QdnAQCQHtoL5yoTVafD8kzeglFz4mzRCsCP9hkgoaHiie/LjLu
X-Received: by 2002:a05:600c:4744:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-48727d5a313mr286613245e9.6.1774967945562;
        Tue, 31 Mar 2026 07:39:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4744:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-48727d5a313mr286612585e9.6.1774967945001;
        Tue, 31 Mar 2026 07:39:05 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm28987415f8f.1.2026.03.31.07.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 07:39:04 -0700 (PDT)
Message-ID: <68ca0a8c-27f9-45f1-94cc-7e3c7936181f@redhat.com>
Date: Tue, 31 Mar 2026 16:39:02 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net,v5] virtio_net: clamp rss_max_key_size
 to NETDEV_RSS_KEY_LEN
To: Srujana Challa <schalla@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
 Shiva Shankar Kommula <kshankar@marvell.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260326142344.1171317-1-schalla@marvell.com>
 <ba027306-e5e0-4d4d-8357-f6080441167d@redhat.com>
 <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CH3PR18MB6379D39BA068565667CF2B06A053A@CH3PR18MB6379.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gzw-_oKT6_apY0CrvfWL9GWVt3HB3Ypz-Mf9Ls73WRk_1774967946
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 3:29 PM, Srujana Challa wrote:
>> On 3/26/26 3:23 PM, Srujana Challa wrote:
>>> rss_max_key_size in the virtio spec is the maximum key size supported
>>> by the device, not a mandatory size the driver must use. Also the
>>> value 40 is a spec minimum, not a spec maximum.
>>>
>>> The current code rejects RSS and can fail probe when the device
>>> reports a larger rss_max_key_size than the driver buffer limit.
>>> Instead, clamp the effective key length to min(device
>>> rss_max_key_size, NETDEV_RSS_KEY_LEN) and keep RSS enabled.
>>>
>>> This keeps probe working on devices that advertise larger maximum key
>>> sizes while respecting the netdev RSS key buffer size limit.
>>>
>>> Fixes: 3f7d9c1964fc ("virtio_net: Add hash_key_length check")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Srujana Challa <schalla@marvell.com>
>>> ---
>>> v3:
>>> - Moved RSS key validation checks to virtnet_validate.
>>> - Add fixes: tag and CC -stable
>>> v4:
>>> - Use NETDEV_RSS_KEY_LEN instead of type_max for the maximum rss key
>> size.
>>> v5:
>>> - Interpret rss_max_key_size as a maximum and clamp it to
>> NETDEV_RSS_KEY_LEN.
>>> - Do not disable RSS/HASH_REPORT when device rss_max_key_size exceeds
>> NETDEV_RSS_KEY_LEN.
>>> - Drop the separate patch that replaced the runtime check with
>> BUILD_BUG_ON.
>>>
>>>  drivers/net/virtio_net.c | 20 +++++++++-----------
>>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>>> 022f60728721..b241c8dbb4e1 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -373,8 +373,6 @@ struct receive_queue {
>>>  	struct xdp_buff **xsk_buffs;
>>>  };
>>>
>>> -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
>>> -
>>>  /* Control VQ buffers: protected by the rtnl lock */  struct
>>> control_buf {
>>>  	struct virtio_net_ctrl_hdr hdr;
>>> @@ -478,7 +476,7 @@ struct virtnet_info {
>>>
>>>  	/* Must be last as it ends in a flexible-array member. */
>>>  	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer,
>> hash_key_data,
>>> -		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>>> +		u8 rss_hash_key_data[NETDEV_RSS_KEY_LEN];
>>>  	);
>>>  };
>>>  static_assert(offsetof(struct virtnet_info,
>>> rss_trailer.hash_key_data) == @@ -6717,6 +6715,7 @@ static int
>> virtnet_probe(struct virtio_device *vdev)
>>>  	struct virtnet_info *vi;
>>>  	u16 max_queue_pairs;
>>>  	int mtu = 0;
>>> +	u16 key_sz;
>>>
>>>  	/* Find if host supports multiqueue/rss virtio_net device */
>>>  	max_queue_pairs = 1;
>>> @@ -6851,14 +6850,13 @@ static int virtnet_probe(struct virtio_device
>> *vdev)
>>>  	}
>>>
>>>  	if (vi->has_rss || vi->has_rss_hash_report) {
>>> -		vi->rss_key_size =
>>> -			virtio_cread8(vdev, offsetof(struct virtio_net_config,
>> rss_max_key_size));
>>> -		if (vi->rss_key_size > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
>>> -			dev_err(&vdev->dev, "rss_max_key_size=%u exceeds
>> the limit %u.\n",
>>> -				vi->rss_key_size,
>> VIRTIO_NET_RSS_MAX_KEY_SIZE);
>>> -			err = -EINVAL;
>>> -			goto free;
>>> -		}
>>> +		key_sz = virtio_cread8(vdev, offsetof(struct virtio_net_config,
>>> +rss_max_key_size));
>>> +
>>> +		vi->rss_key_size = min_t(u16, key_sz, NETDEV_RSS_KEY_LEN);
>>> +		if (key_sz > vi->rss_key_size)
>>> +			dev_warn(&vdev->dev,
>>> +				 "rss_max_key_size=%u exceeds driver limit
>> %u, clamping\n",
>>> +				 key_sz, vi->rss_key_size);
>>
>> NETDEV_RSS_KEY_LEN is 256 and virtio_cread8() returns a u8. The check is
>> not needed, and the warning will never be printed. I think that the
>> BUILD_BUG_ON() you used in v4 would be better than the above chunk.
>>
> Thank you for the feedback. In net-next, NETDEV_RSS_KEY_LEN is 256. This fix is
> also intended for stable kernels, where NETDEV_RSS_KEY_LEN is 52, and
> I added the message to make clamping visible in that case.
> I will remove the check and send the next version.  

I'm sorry, I haven't looked at the historical context when I wrote my
previous reply.

IMHO the additional check does not make sense in the current net tree.
On the flip side stable trees will need it. I suggest:

- dropping the check for the 'net' patch
- also dropping CC: stable tag
- explicitly sending to stable the fix variant including the size check.

@Michael: WDYT?

/P

