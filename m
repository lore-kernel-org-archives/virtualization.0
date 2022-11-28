Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3EEC4332F
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 08:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7569B414E6;
	Mon, 28 Nov 2022 08:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7569B414E6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/tWeFEP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sF7bYrUOlJOu; Mon, 28 Nov 2022 08:22:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C3AE408A1;
	Mon, 28 Nov 2022 08:22:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C3AE408A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40838C0033;
	Mon, 28 Nov 2022 08:22:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1971C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 08:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 787D560ADD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 08:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 787D560ADD
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/tWeFEP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nOcA0bFADXpb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 08:22:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B1176072A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B1176072A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669623766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=08ACbZbm+f4rrW15utHPQxye3zrEyxUiKLzM8Bx4A7A=;
 b=Z/tWeFEPBT+UmmcRi6LInvcL60AY9V7vv52d17mfGDV8XR2iEABQ0m2YmmrVXzYQKxBI8w
 OtoDIGXbUob13B5BysiToG6jOVTFHCqhxLFD6lLBDPWgmfivrdHLm+U1LG2Gqv/dhO629q
 E0us1vCoO6ohD7lakwFah+WlG7Kz81M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-nhqsx9yXOUeYXV1EG1l5Jg-1; Mon, 28 Nov 2022 03:22:44 -0500
X-MC-Unique: nhqsx9yXOUeYXV1EG1l5Jg-1
Received: by mail-wr1-f71.google.com with SMTP id
 o8-20020adfba08000000b00241e80f08e0so1606728wrg.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 00:22:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=08ACbZbm+f4rrW15utHPQxye3zrEyxUiKLzM8Bx4A7A=;
 b=UfJB2inLVSmmMXMDiwku224NMKP7aE6JYdqaz8wOFuBTsNyQDV6AZ7zRrLyCF3zNQI
 8yPTknFbvLuQhrsnwNYKJOP5lIoL7RyHi039h2QASceLqP1O+u1SE2wAM3jlrPLXNMlZ
 VZrzEEIaman4VMpkFYYpGeyJWkRxEU3DJD8Oos2I7xvQodahf3VEXwPPyw3UTzK4N5FY
 veh3yXsIimEi0TCquyXlfCmt7MXtzzvWhyGlomxo+4kiWAyWA1B39XlZlgmLIrQkYJYr
 KzWkLC1IvLdulhR/i49Y/dH98qpQwc918uQL2c91u4MyHwLKaanVPF2NxglapVvmvMYx
 6rMw==
X-Gm-Message-State: ANoB5pmGKI2tiIzrpgM4zDWbWHdk+63u5a9HrPd526dnVqVwYCGpH4XV
 58VNby25C11aL2eerU6GjdTIlFfHbo5EC2StocP7+Wa6vroBDshT88dhPE319yI0igiaL9XLFv4
 wJU82rAbuyxTTNqaL0Pe1Tn19wcMxyUMmFtL2sNl+7g==
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id
 t10-20020adfeb8a000000b0022e31b2ecb9mr30942291wrn.693.1669623763100; 
 Mon, 28 Nov 2022 00:22:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf50AS2I3KjwPnQrek1jGvg+yRK5+MF+33CkcubpJsA9CW/SHNSir8fcEWGsp4QA6DOlcXT2PQ==
X-Received: by 2002:adf:eb8a:0:b0:22e:31b2:ecb9 with SMTP id
 t10-20020adfeb8a000000b0022e31b2ecb9mr30942267wrn.693.1669623762803; 
 Mon, 28 Nov 2022 00:22:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf?
 (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de.
 [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a056000023300b00241de5be3f0sm10082939wrz.37.2022.11.28.00.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Nov 2022 00:22:42 -0800 (PST)
Message-ID: <af62e7fe-d848-acb8-ca77-cdf01022b8de@redhat.com>
Date: Mon, 28 Nov 2022 09:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Li Zetao <lizetao1@huawei.com>, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
 kraxel@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
 asmadeus@codewreck.org, linux_oss@crudebyte.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rusty@rustcorp.com.au
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128021005.232105-3-lizetao1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 2/4] virtio-mem: Fix probe failed when modprobe virtio_mem
In-Reply-To: <20221128021005.232105-3-lizetao1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-block@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On 28.11.22 03:10, Li Zetao wrote:
> When doing the following test steps, an error was found:
>    step 1: modprobe virtio_mem succeeded
>      # modprobe virtio_mem      <-- OK
> 
>    step 2: fault injection in virtio_mem_init()
>      # modprobe -r virtio_mem   <-- OK
>      # ...
>        CPU: 0 PID: 1837 Comm: modprobe Not tainted
>        6.1.0-rc6-00285-g6a1e40c4b995-dirty
>        Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>        Call Trace:
>         <TASK>
>         should_fail.cold+0x5/0x1f
>         ...
>         virtio_mem_init_hotplug+0x9ae/0xe57 [virtio_mem]
>         virtio_mem_init.cold+0x327/0x339 [virtio_mem]
>         virtio_mem_probe+0x48e/0x910 [virtio_mem]
>         virtio_dev_probe+0x608/0xae0
>         ...
>         </TASK>
>        virtio_mem virtio4: could not reserve device region
>        virtio_mem: probe of virtio4 failed with error -16
> 
>    step 3: modprobe virtio_net failed

virtio_net ?

>      # modprobe virtio_mem       <-- failed
>        virtio_mem: probe of virtio4 failed with error -16
> 
> The root cause of the problem is that the virtqueues are not
> stopped on the error handling path when virtio_mem_init()
> fails in virtio_mem_probe(), resulting in an error "-ENOENT"
> returned in the next modprobe call in setup_vq().
> 
> virtio_pci_modern_device uses virtqueues to send or
> receive message, and "queue_enable" records whether the
> queues are available. In vp_modern_find_vqs(), all queues
> will be selected and activated, but once queues are enabled
> there is no way to go back except reset.
> 
> Fix it by reset virtio device on error handling path. After
> virtio_mem_init_vq() succeeded, all virtqueues should be
> stopped on error handling path.
> 
> Fixes: 1fcf0512c9c8 ("virtio_pci: modern driver")

That commit is from 2014. virtio-mem was merged in 2020

Fixes: 5f1f79bbc9e2 ("virtio-mem: Paravirtualized memory hotplug")

> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/virtio/virtio_mem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 0c2892ec6817..c7f09c2ce982 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2793,6 +2793,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>   
>   	return 0;
>   out_del_vq:
> +	virtio_reset_device(vdev);
>   	vdev->config->del_vqs(vdev);
>   out_free_vm:
>   	kfree(vm);


Apart from that

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
