Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADC0C25B50
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 11:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AC766106C;
	Tue, 24 Jan 2023 11:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AC766106C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JfGUHzG9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WtMz2CKFx3W2; Tue, 24 Jan 2023 11:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A1A3561026;
	Tue, 24 Jan 2023 11:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A1A3561026
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E2D3C0033;
	Tue, 24 Jan 2023 11:04:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB2CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 11:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A8B781E47
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 11:04:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A8B781E47
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JfGUHzG9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cVzAq2I2TbN6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 11:04:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED6D981E31
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED6D981E31
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674558270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5l+qwp9PIP4UMT13KE8TPEvHJmJnDmbT8DgfaO68LBE=;
 b=JfGUHzG9Y9R2sU0ovnY4v3PGlK8wG1c6k27pHnjmBmyTRkjJ9PQPz8VrVJGZ9ePP9SG+Q2
 QzVvX9NAoqvhXuM5H3BPFMEHe0wymxa/1FUVTfbVMp33jGPX2xc64TrMIZfYQZRqVtYW2R
 e9jEwtErwehJ5QOaOyg+01AmC0zqyMI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-435-R1eXCTyWM_qoCvHOW6qXaA-1; Tue, 24 Jan 2023 06:04:29 -0500
X-MC-Unique: R1eXCTyWM_qoCvHOW6qXaA-1
Received: by mail-qv1-f72.google.com with SMTP id
 c10-20020a05621401ea00b004c72d0e92bcso7385064qvu.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 03:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5l+qwp9PIP4UMT13KE8TPEvHJmJnDmbT8DgfaO68LBE=;
 b=VVROVs3Oj9J7YRJzPY6KRI+3AOC8XSNCZDgpnKcrBz4+h+WH0hvrCjP7jNy0OlsnJF
 umLWBLGg2OTOheBgDHcFOYIfXz33qOEyzINRzP5q5rd8VvwNobz8t8zMeTr9d3pa89Ru
 HjhmsOaaq1qTsLuTIEooSf1Fu8jWM97UBwvwLtdLYXyI7OwP1d7ohEW9rwGwGb1HQgrl
 OzNO/gd9GHV4TRC8y6rD7L38/CDd8cmrMQev8vj895DoWczCNsg1XHC/VUjL6C2CsJ/W
 cffsxNP8YB24uPCOMhF0HjuR4bU4Y1DZNoLNM9P3NP0dDN9TzUI7jJVyoeiTigNxUNCH
 CNUg==
X-Gm-Message-State: AFqh2kps8FRLr2KDwXLFo6N8JYfCgt6LjzKDZ17uh3oBH6pY2ORYqlua
 ClnAflAMHEr9q5JGu21plG+83FllwVp+s9E+PL47EZaq2rgT8RbKu5Lu28/9wx6Y3hkcHhsUvQ6
 n13+D/5Ijzf1aL7qF9u/bo4Tog2A/WNZ0uzO+cg95UQ==
X-Received: by 2002:ac8:6891:0:b0:3b0:8493:233a with SMTP id
 m17-20020ac86891000000b003b08493233amr38474833qtq.10.1674558268614; 
 Tue, 24 Jan 2023 03:04:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvEGuF6kTFogQP7xYOSKUWDtoNWJ81cZ7WERRCS0jkB7L/cJzzmgZjcEZJaEKNKPChFexQ0Pw==
X-Received: by 2002:ac8:6891:0:b0:3b0:8493:233a with SMTP id
 m17-20020ac86891000000b003b08493233amr38474812qtq.10.1674558268339; 
 Tue, 24 Jan 2023 03:04:28 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 r2-20020ac83b42000000b003b6464eda40sm1052332qtf.25.2023.01.24.03.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jan 2023 03:04:27 -0800 (PST)
Message-ID: <971beeaf-5e68-eb4a-1ceb-63a5ffa74aff@redhat.com>
Date: Tue, 24 Jan 2023 12:04:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] virtio_net: notify MAC address change on device
 initialization
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230123120022.2364889-1-lvivier@redhat.com>
 <20230123120022.2364889-2-lvivier@redhat.com>
 <20230124024711-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230124024711-mutt-send-email-mst@kernel.org>
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

On 1/24/23 11:15, Michael S. Tsirkin wrote:
> On Mon, Jan 23, 2023 at 01:00:22PM +0100, Laurent Vivier wrote:
>> In virtnet_probe(), if the device doesn't provide a MAC address the
>> driver assigns a random one.
>> As we modify the MAC address we need to notify the device to allow it
>> to update all the related information.
>>
>> The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
>> assign a MAC address by default. The virtio_net device uses a random
>> MAC address (we can see it with "ip link"), but we can't ping a net
>> namespace from another one using the virtio-vdpa device because the
>> new MAC address has not been provided to the hardware.
> 
> And then what exactly happens? Does hardware drop the outgoing
> or the incoming packets? Pls include in the commit log.

I don't know. There is nothing in the kernel logs.

The ping error is: "Destination Host Unreachable"

I found the problem with the mlx5 driver as in "it doesn't work when MAC address is not 
set"...

Perhaps Eli can explain what happens when the MAC address is not set?

> 
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7723b2a49d8e..4bdc8286678b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3800,6 +3800,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   		eth_hw_addr_set(dev, addr);
>>   	} else {
>>   		eth_hw_addr_random(dev);
>> +		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
>> +			 dev->dev_addr);
>>   	}
>>   
>>   	/* Set up our device-specific information */
>> @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
>>   	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>>   		 dev->name, max_queue_pairs);
>>   
>> +	/* a random MAC address has been assigned, notify the device */
>> +	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
>> +	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
> 
> Maybe add a comment explaining that we don't fail probe if
> VIRTIO_NET_F_CTRL_MAC_ADDR is not there because
> many devices work fine without getting MAC explicitly.

OK

> 
>> +		struct scatterlist sg;
>> +
>> +		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
>> +		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
>> +					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
>> +			dev_warn(&vdev->dev, "Failed to update MAC address.\n");
> 
> Here, I'm not sure we want to proceed. Is it useful sometimes?

I think reporting an error is always useful, but I can remove that if you prefer.

> I note that we deny with virtnet_set_mac_address.
> 
>> +		}
>> +	}
>> +
>>   	return 0;
> 
> 
> 
> Also, some code duplication with virtnet_set_mac_address here.
> 
> Also:
> 	When using the legacy interface, \field{mac} is driver-writable
> 	which provided a way for drivers to update the MAC without
> 	negotiating VIRTIO_NET_F_CTRL_MAC_ADDR.
> 
> How about factoring out code in virtnet_set_mac_address
> and reusing that?
> 

In fact, we can write in the field only if we have VIRTIO_NET_F_MAC (according to 
virtnet_set_mac_address(), and this code is executed only if we do not have 
VIRTIO_NET_F_MAC. So I think it's better not factoring the code as we have only the 
control queue case to manage.

> This will also handle corner cases such as VIRTIO_NET_F_STANDBY
> which are not currently addressed.

F_STANDBY is only enabled when virtio-net device MAC address is equal to the VFIO device 
MAC address, I don't think it can be enabled when the MAC address is randomly assigned (in 
this case it has already failed in net_failover_create(), as it has been called using the 
random mac address), it's why I didn't check for it.

> 
> 
>>   free_unregister_netdev:
>> -- 
>> 2.39.0
> 

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
