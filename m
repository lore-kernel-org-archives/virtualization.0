Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04FDC38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 09:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20EE560ABB;
	Tue, 31 Jan 2023 09:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 20EE560ABB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGSnsjpF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5G57IH9UnKV; Tue, 31 Jan 2023 09:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C2EA60806;
	Tue, 31 Jan 2023 09:33:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C2EA60806
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE7DBC0033;
	Tue, 31 Jan 2023 09:33:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01EBDC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:33:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBEEE410C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:33:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CBEEE410C7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGSnsjpF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PECQSQPOkq7j
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:33:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D665240921
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D665240921
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675157578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBQzfQxX4tLE3XglxaxRBTAUCUwV8ydRvRoWUBFiIAU=;
 b=DGSnsjpF8+hAxK9Dp6jp1WVDbiuROwtSAN/W8bvMZhT5RZ82wX12ixVJVS+BNFV2XV1PqQ
 ikizPHVgho8ASpxYpQfkzGoS11s3yLXccRyNZiD8Qwzx4RaBuvC8oJJY36x00LvTqbLaBE
 +TEYNUtsKG2LAt5DIWLeXjmyYS7/rXM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-ACa8WGBoM5eplT_vlXXSCQ-1; Tue, 31 Jan 2023 04:32:57 -0500
X-MC-Unique: ACa8WGBoM5eplT_vlXXSCQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 q26-20020ac8735a000000b003b63165d87cso6346493qtp.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 01:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBQzfQxX4tLE3XglxaxRBTAUCUwV8ydRvRoWUBFiIAU=;
 b=LzHAXlTvflNoFPA84sFGbH5bDmvY2JfOf1f5plP+/hk9PPqPAkML/ki7IE7e5joh8Z
 4lWjPV6L2AtGENXiLCcgX346EF7PK2b35Dr4IBLxfAcLgv/no7T/cT1Y8bf9XEs6NYCk
 I8iJ6rhUsvnzYQCRsm+FUkN7BaVYYMOgAUJvig4CywowS2u8varf2pJ1RP5DKMSkHkOi
 xhPW+HTcKEsy/0gYQXQhfBmFspNRypZUXvA1auJ2HqmvpgQtQoZ6T5iuGQFNkEBaSyja
 RLOafvAKSwD6txmCrQao4UpDRZsuBQSdND5l3VT4vBMmgg+IivK978ETFxXwzgtR0F8Q
 VubQ==
X-Gm-Message-State: AFqh2koMSdV4wBelTLM3WN3VxBDK6/+5fEuPn7//c8rysSqNJHgq329C
 ZKFQOVvexRDdCVrFvhDol1nTgV9rFNBBEjSfhhyIKnVOIcazfaqMnvlBFhiWe9VU2EC1dJN0q/F
 95C2gCa/SO2CGyabQQFeRqf8QpqKxz21+nyttaCZe/w==
X-Received: by 2002:ac8:454e:0:b0:3a8:fdf:8ff8 with SMTP id
 z14-20020ac8454e000000b003a80fdf8ff8mr71681304qtn.36.1675157576800; 
 Tue, 31 Jan 2023 01:32:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuFcusn7/Z9gSKN7OA3kQNo5zOuRPcVs4oJi5oHw2k5cV6S5N4fhP31zSpvJcDZwlm/3V5sOg==
X-Received: by 2002:ac8:454e:0:b0:3a8:fdf:8ff8 with SMTP id
 z14-20020ac8454e000000b003a80fdf8ff8mr71681284qtn.36.1675157576463; 
 Tue, 31 Jan 2023 01:32:56 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a37c244000000b00706a452c074sm6737880qkm.104.2023.01.31.01.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Jan 2023 01:32:55 -0800 (PST)
Message-ID: <8bb17aed-d643-2e33-472a-9f237e26e4d1@redhat.com>
Date: Tue, 31 Jan 2023 10:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
To: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20230127204500.51930-1-lvivier@redhat.com>
 <20230127204500.51930-3-lvivier@redhat.com>
 <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <949500bd10077989eb21bd41d6bb1a0de296f9d8.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

On 1/31/23 10:01, Paolo Abeni wrote:
> On Fri, 2023-01-27 at 21:45 +0100, Laurent Vivier wrote:
>> In virtnet_probe(), if the device doesn't provide a MAC address the
>> driver assigns a random one.
>> As we modify the MAC address we need to notify the device to allow it
>> to update all the related information.
>>
>> The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
>> assign a MAC address by default. The virtio_net device uses a random
>> MAC address (we can see it with "ip link"), but we can't ping a net
>> namespace from another one using the virtio-vdpa device because the
>> new MAC address has not been provided to the hardware:
>> RX packets are dropped since they don't go through the receive filters,
>> TX packets go through unaffected.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7d700f8e545a..704a05f1c279 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   		eth_hw_addr_set(dev, addr);
>>   	} else {
>>   		eth_hw_addr_random(dev);
>> +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
>> +			 dev->dev_addr);
>>   	}
>>   
>>   	/* Set up our device-specific information */
>> @@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   
>>   	virtio_device_ready(vdev);
>>   
>> +	/* a random MAC address has been assigned, notify the device.
>> +	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
>> +	 * because many devices work fine without getting MAC explicitly
>> +	 */
>> +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
>> +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
>> +		struct scatterlist sg;
>> +
>> +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
>> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
>> +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
>> +			pr_debug("virtio_net: setting MAC address failed\n");
>> +			rtnl_unlock();
>> +			err = -EINVAL;
>> +			goto free_unregister_netdev;
> 
> Since the above is still dealing with device initialization, would it
> make sense moving such init step before registering the netdevice?

It depends if we can send the command using the control command queue or not.
I don't think we can use a vq before virtio_device_ready().

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
