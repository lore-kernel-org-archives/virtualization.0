Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6E7C54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 12:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C2D482BC4;
	Fri, 27 Jan 2023 12:28:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C2D482BC4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4+knNcX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jMvtHAFhKj8i; Fri, 27 Jan 2023 12:28:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0AD7A82B8C;
	Fri, 27 Jan 2023 12:28:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AD7A82B8C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE39FC0032;
	Fri, 27 Jan 2023 12:28:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0B64C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8957540452
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:28:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8957540452
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V4+knNcX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PPecyYsYXo-c
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:28:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19B584040D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19B584040D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674822490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xclzS60WKfmjFavTzqp+B0Uxio42pgew/o/vyaA76o=;
 b=V4+knNcX9Vs+MnWBi3kR5iaoFQF6ArT/wX9GWcplHTUfb651p6lQ1zVapFxOwS2sM8poYW
 S6wwLaVDVRjPvN1FRQdOFpgfoxbwXb9MfswK2jGLNUNzGj73q7ns4aw/sbY7ouHdmVG6vK
 Ksa1+3arqUjRKUgqpok+e4uBPXf1Uuk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-135-TLcKac2AMLaI0QMQNxpOHA-1; Fri, 27 Jan 2023 07:28:06 -0500
X-MC-Unique: TLcKac2AMLaI0QMQNxpOHA-1
Received: by mail-qt1-f199.google.com with SMTP id
 i1-20020ac87641000000b003b7fa8c92bcso2051473qtr.15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 04:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5xclzS60WKfmjFavTzqp+B0Uxio42pgew/o/vyaA76o=;
 b=R1TF9a7FgzQ7j5keXSnaEmABVtuHjhYvjPP+RNk7xbuRnrfYSuwISMG3iOPZCnhQvS
 PEy3oDQg6xGQfMlLnx84FOnmSkpqyZh28XEqgrFLEcQ3k1X4/bDqGQGocjeUKUxZ8yKw
 wvqUPzqMT6r2IkGz5aQNKzswWRkDbzQHzqbdLUGqg1WpQbZu7aCjsAApKcSNNslXcfew
 4p9GlRgasS4SSjLgp0OfI7CbmO0E4mC9inoFeC/Sn6lwf8GrNvZeg8xsUJolYpy/aPmt
 ZV8NotouLBap34w4ReCdd/IXhLqhWFg4Ggj9qSC5cHjfM+Fj22L7qS3Tb29ABBnAC8OA
 U/GA==
X-Gm-Message-State: AO0yUKX7/oFtY95rRmn3S9n+WRCAeC0iaoK4blCUgLiUGYQNlTuk1Tpq
 jHnH3DxGHM+9mBmQ1DiX8+YC/gR58Qu8SgYIo5L9CQbN0NTg0YUQs5XXJOwJp0VdHQQUnzeMf79
 dQs4pxB/gN4rScByzmaUf5Tj73EpZ2GSCyzPrB8TjBA==
X-Received: by 2002:a05:622a:1016:b0:3b8:248b:a035 with SMTP id
 d22-20020a05622a101600b003b8248ba035mr2601180qte.19.1674822485733; 
 Fri, 27 Jan 2023 04:28:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8IDSemL3lqiCbkX9GCb5pAEaPeJPkc2xzrAclCoOfx1/pjTc6meh6Iz3ye7+UdTcLWZOvLSQ==
X-Received: by 2002:a05:622a:1016:b0:3b8:248b:a035 with SMTP id
 d22-20020a05622a101600b003b8248ba035mr2601133qte.19.1674822485329; 
 Fri, 27 Jan 2023 04:28:05 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a05620a136f00b006fb112f512csm2751566qkl.74.2023.01.27.04.28.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jan 2023 04:28:04 -0800 (PST)
Message-ID: <5d82047d-411b-a98d-ce0e-1195838db42c@redhat.com>
Date: Fri, 27 Jan 2023 13:28:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] virtio_net: notify MAC address change on device
 initialization
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230123120022.2364889-1-lvivier@redhat.com>
 <20230123120022.2364889-2-lvivier@redhat.com>
 <20230124024711-mutt-send-email-mst@kernel.org>
 <971beeaf-5e68-eb4a-1ceb-63a5ffa74aff@redhat.com>
 <20230127060453-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230127060453-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Cindy Lu <lulu@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 1/27/23 12:08, Michael S. Tsirkin wrote:
> On Tue, Jan 24, 2023 at 12:04:24PM +0100, Laurent Vivier wrote:
>> On 1/24/23 11:15, Michael S. Tsirkin wrote:
>>> On Mon, Jan 23, 2023 at 01:00:22PM +0100, Laurent Vivier wrote:
>>>> In virtnet_probe(), if the device doesn't provide a MAC address the
>>>> driver assigns a random one.
>>>> As we modify the MAC address we need to notify the device to allow it
>>>> to update all the related information.
>>>>
>>>> The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
>>>> assign a MAC address by default. The virtio_net device uses a random
>>>> MAC address (we can see it with "ip link"), but we can't ping a net
>>>> namespace from another one using the virtio-vdpa device because the
>>>> new MAC address has not been provided to the hardware.
>>>
>>> And then what exactly happens? Does hardware drop the outgoing
>>> or the incoming packets? Pls include in the commit log.
>>
>> I don't know. There is nothing in the kernel logs.
>>
>> The ping error is: "Destination Host Unreachable"
>>
>> I found the problem with the mlx5 driver as in "it doesn't work when MAC
>> address is not set"...
>>
>> Perhaps Eli can explain what happens when the MAC address is not set?
>>
>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 14 ++++++++++++++
>>>>    1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 7723b2a49d8e..4bdc8286678b 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -3800,6 +3800,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    		eth_hw_addr_set(dev, addr);
>>>>    	} else {
>>>>    		eth_hw_addr_random(dev);
>>>> +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
>>>> +			 dev->dev_addr);
>>>>    	}
>>>>    	/* Set up our device-specific information */
>>>> @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>    	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>>>>    		 dev->name, max_queue_pairs);
>>>> +	/* a random MAC address has been assigned, notify the device */
>>>> +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
>>>> +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
>>>
>>> Maybe add a comment explaining that we don't fail probe if
>>> VIRTIO_NET_F_CTRL_MAC_ADDR is not there because
>>> many devices work fine without getting MAC explicitly.
>>
>> OK
>>
>>>
>>>> +		struct scatterlist sg;
>>>> +
>>>> +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
>>>> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
>>>> +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
>>>> +			dev_warn(&vdev->dev, "Failed to update MAC address.\n");
>>>
>>> Here, I'm not sure we want to proceed. Is it useful sometimes?
>>
>> I think reporting an error is always useful, but I can remove that if you prefer.
> 
> No the question was whether we should fail probe not
> whether we print the warning.

Good question.

After all, as VIRTIO_NET_F_CTRL_MAC_ADDR is set, if VIRTIO_NET_CTRL_MAC_ADDR_SET fails it 
means there is a real problem, so yes, we should fail.

> 
> 
>>> I note that we deny with virtnet_set_mac_address.
>>>
>>>> +		}
>>>> +	}
>>>> +
>>>>    	return 0;
>>>
>>>
>>>
>>> Also, some code duplication with virtnet_set_mac_address here.
>>>
>>> Also:
>>> 	When using the legacy interface, \field{mac} is driver-writable
>>> 	which provided a way for drivers to update the MAC without
>>> 	negotiating VIRTIO_NET_F_CTRL_MAC_ADDR.
>>>
>>> How about factoring out code in virtnet_set_mac_address
>>> and reusing that?
>>>
>>
>> In fact, we can write in the field only if we have VIRTIO_NET_F_MAC
>> (according to virtnet_set_mac_address(), and this code is executed only if
>> we do not have VIRTIO_NET_F_MAC. So I think it's better not factoring the
>> code as we have only the control queue case to manage.
>>
>>> This will also handle corner cases such as VIRTIO_NET_F_STANDBY
>>> which are not currently addressed.
>>
>> F_STANDBY is only enabled when virtio-net device MAC address is equal to the
>> VFIO device MAC address, I don't think it can be enabled when the MAC
>> address is randomly assigned (in this case it has already failed in
>> net_failover_create(), as it has been called using the random mac address),
>> it's why I didn't check for it.
> 
> But the spec did not say there's a dependency :(.
> My point is what should we do if there's F_STANDBY but no MAC?
> Maybe add a separate patch clearing F_STANDBY in this case?

The simplest would be to add at the beginning of the probe function:

if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
     virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
	pr_err("virtio-net: a standby device cannot be used without a MAC address");
	return -EOPNOTSUPP;
}

And I think it would help a lot to debug misconfiguration of the interface.

Thanks,
Laurent

> 
>>>
>>>
>>>>    free_unregister_netdev:
>>>> -- 
>>>> 2.39.0
>>>
>>
>> Thanks,
>> Laurent
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
