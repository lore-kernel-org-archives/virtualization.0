Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CE2C25B4E
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 07:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C8CCD40BA8;
	Tue, 24 Jan 2023 07:21:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8CCD40BA8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A3wG2I8K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXh0AzGr1ajj; Tue, 24 Jan 2023 07:21:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 21BCA40127;
	Tue, 24 Jan 2023 07:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 21BCA40127
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F398FC0032;
	Tue, 24 Jan 2023 07:21:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C38FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 07:21:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 219AC4052E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 07:21:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 219AC4052E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDT00qW2CjAx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 07:21:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E14E340127
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E14E340127
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 07:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674544868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7q3iqRUHEdMbAtpmNI/eVbLbK/lHpmY+A3ZIsty8k9o=;
 b=A3wG2I8KX70mG0XbEPYyx1gSFHQF7oUrQF4xEynSnv6s44g3FHKpSt7zNZB/O8Ihcm+Xiq
 c5NwzdXdXkjIptKoTdVWqXRUsR+UEAnRIsnEg5VtdjUjMQN9H+FKIkprxB4/UuZOU6trOl
 Vw0ntT+WKZP8SLGABxZnbXm3V3b58po=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-DLywSkkPOLGZp0HtZ1UjoA-1; Tue, 24 Jan 2023 02:19:36 -0500
X-MC-Unique: DLywSkkPOLGZp0HtZ1UjoA-1
Received: by mail-qk1-f197.google.com with SMTP id
 y3-20020a05620a44c300b00709109448a3so8470649qkp.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 23:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7q3iqRUHEdMbAtpmNI/eVbLbK/lHpmY+A3ZIsty8k9o=;
 b=LgFFT8YIiY6b/+dHtoBMMFpFmUoQENfm7JyHExXHCENdbJKWSrCnO7bCjF5JKp9m8h
 ROAfXiPNa02pQXI1P4inkjaVMQuqOy+T1mXsL+rb0MXacsdO2V2XOWHpFv6HmdB8c3r3
 c5Jz5eCvwt6TQBUri7A7bssVdxxxxbHpijqAhJOIs8gNl4Ir4YIyKIJwZPaTr0+PwP7+
 COOyXsBmEzuHjxyarFuvG5ezFBBFJgo0sc0bKjB/rpUWTea3u/uqPMHrfqr0BqIZjXoV
 IFOA6MrJONwNNcEPoA5rChWiFchMHmRVOE+Pu6UqW6ZX/20wO5cRgE/heZnNPLSVcK+3
 4fsQ==
X-Gm-Message-State: AFqh2krqTfNWuUVfvncvepSpp7zBrlgpb2YiPIbw5RchfGDZpuqUpUtK
 NBCRJYvI+u6sFPjSSguhiexcTTg5WTkOzFCQv3w41ztH5yRdWWev12KYhNJYvhfeDh99aGHkIRF
 T4L2HCjN+6s6JtkC8V5ACYhpBsAiz82I1lH70n+N5mg==
X-Received: by 2002:a05:622a:4897:b0:3ab:a3d9:c5c8 with SMTP id
 fc23-20020a05622a489700b003aba3d9c5c8mr45612923qtb.3.1674544775624; 
 Mon, 23 Jan 2023 23:19:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuN2ZdpfTVek/pkskSHS//zZArD9nCjkHIXPrwJoZbwBa9jqTPDSAuz+JqMDr1JkvokbWw8uA==
X-Received: by 2002:a05:622a:4897:b0:3ab:a3d9:c5c8 with SMTP id
 fc23-20020a05622a489700b003aba3d9c5c8mr45612897qtb.3.1674544775412; 
 Mon, 23 Jan 2023 23:19:35 -0800 (PST)
Received: from [192.168.100.30] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 72-20020a37074b000000b00706c1fc62desm909030qkh.112.2023.01.23.23.19.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jan 2023 23:19:34 -0800 (PST)
Message-ID: <3ff50750-de59-dc2b-01a9-1a453e49e26e@redhat.com>
Date: Tue, 24 Jan 2023 08:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/4] virtio_net: notify MAC address change on device
 initialization
To: Jakub Kicinski <kuba@kernel.org>, Eli Cohen <elic@nvidia.com>
References: <20230122100526.2302556-1-lvivier@redhat.com>
 <20230122100526.2302556-2-lvivier@redhat.com>
 <07a24753-767b-4e1e-2bcf-21ec04bc044a@nvidia.com>
 <20230123193114.56aaec3a@kernel.org>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <20230123193114.56aaec3a@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>,
 "David S. Miller" <davem@davemloft.net>
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

On 1/24/23 04:31, Jakub Kicinski wrote:
> On Sun, 22 Jan 2023 15:47:08 +0200 Eli Cohen wrote:
>>> @@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>    	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>>>    		 dev->name, max_queue_pairs);
>>>    
>>> +	/* a random MAC address has been assigned, notify the device */
>>> +	if (dev->addr_assign_type == NET_ADDR_RANDOM &&
>> Maybe it's better to not count on addr_assign_type and use a local
>> variable to indicate that virtnet_probe assigned random MAC.
> 
> +1, FWIW
> 
v2 sent, but I rely on virtio_has_feature(vdev, VIRTIO_NET_F_MAC) to know if the MAC 
address is provided by the device or not:

https://lore.kernel.org/lkml/20230123120022.2364889-2-lvivier@redhat.com/T/#me9211516e12771001e0346818255c9fb48a2bf4a

Thanks,
Laurent

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
