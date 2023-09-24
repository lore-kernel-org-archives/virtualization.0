Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194B7CE7A91
	for <virtualization@archiver.kernel.org>; Sun, 24 Sep 2023 23:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F19140880;
	Sun, 24 Sep 2023 23:58:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F19140880
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0VUEXtr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x0FuJ63GhfPv; Sun, 24 Sep 2023 23:58:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8248540629;
	Sun, 24 Sep 2023 23:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8248540629
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44196C0071;
	Sun, 24 Sep 2023 23:58:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AC18C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 23:58:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D375B813EC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 23:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D375B813EC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N0VUEXtr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id We4UWfW0MWqq
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 23:58:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9135813DD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 23:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C9135813DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695599925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ets5PYkEN00cN7wgOm2RwQsLcoaUgwsPfQGHKYG1F6g=;
 b=N0VUEXtr0AZhVLjjPVU4v94tWsDLMCxSn9xIIhBXdJ7/NqmCwlWsmj2YTXiRhlyEEnAkHu
 AmvcR2WlJvH0Em3LdVZ7ZCXk6g9AII+NSce2r+WpQUiFGCQpI5BkOEWSjYuvkGsak32Puy
 3pZ12SpE5wA6aAKMTMDveczR0tsm4LA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-tfS-5SDrMDOxLD21j0Be7Q-1; Sun, 24 Sep 2023 19:58:44 -0400
X-MC-Unique: tfS-5SDrMDOxLD21j0Be7Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-27731a5b94dso1151280a91.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Sep 2023 16:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695599922; x=1696204722;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ets5PYkEN00cN7wgOm2RwQsLcoaUgwsPfQGHKYG1F6g=;
 b=ky1tI7Fz2sYRiyLkI1GB+JARY3q10P9Yl/33WA7ofwiVmOdOExse1RJB/8Wd6blpSX
 Pjzxry3nrqitjRj8HMtK0BGf17XbdGODiIoJpZH7gESFk7gfJbfKTTNIu2KXZVFGSicx
 n5Sm/FIUdSAUrhRtyzBRyOaV1Mj3qk+/RnOR8NWWP7tDxsD9R4BkkNknYEWH9JqFnAeb
 yQuq58btDjfp7mHsbLngjJ+9/xAa2iMLK3Jj8z7C4iuE/DzleOB7QR9e66zpvjOFVCp7
 3oLKarCo0atYO0V1OxmHesLA02rvoi5DAaAapbPmBq4ngSVST8qW35UQ8QUjK/a+4L2i
 ccgQ==
X-Gm-Message-State: AOJu0YwftJx6rw2CmpO2XNLwojpaJbJoz8feDK9f3M37LOJsBCzfk6+w
 aNbe8gBzeYEEH+Y/avPeYiYycOwCIpCGq5/9Aegp/Pvcaaz2p0ofcEx8l1A5hCImqdoM0ZRE2Hx
 TSJWJMdQpLH6V3af7M7OZ2ZFiFsGX3j7XQ3AwQWhd587qP+epcuS4id0cr7/jblxQGohz3j0P53
 YWrp4dV3v6s7NUjB+VQlWSYA==
X-Received: by 2002:a17:90a:2ca1:b0:26d:ae3:f6a6 with SMTP id
 n30-20020a17090a2ca100b0026d0ae3f6a6mr2819277pjd.18.1695599922302; 
 Sun, 24 Sep 2023 16:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDUhf4oGjVLqD6nDiU8Yq56LBZmA3ph1fj5hxXW40AUTIUnA8R3a4yi1/uEa5ZPgJxtHjHow==
X-Received: by 2002:a17:90a:2ca1:b0:26d:ae3:f6a6 with SMTP id
 n30-20020a17090a2ca100b0026d0ae3f6a6mr2819265pjd.18.1695599921841; 
 Sun, 24 Sep 2023 16:58:41 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a17090a16c900b002772faee740sm1216900pje.5.2023.09.24.16.58.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Sep 2023 16:58:40 -0700 (PDT)
Message-ID: <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
Date: Mon, 25 Sep 2023 09:58:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation on
 arm64
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux-foundation.org
References: <20230831011007.1032822-1-gshan@redhat.com>
In-Reply-To: <20230831011007.1032822-1-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com
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

Hi David and Michael,

On 8/31/23 11:10, Gavin Shan wrote:
> The deflation request to the target, which isn't unaligned to the
> guest page size causes endless deflation and inflation actions. For
> example, we receive the flooding QMP events for the changes on memory
> balloon's size after a deflation request to the unaligned target is
> sent for the ARM64 guest, where we have 64KB base page size.
> 
>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>    -accel kvm -machine virt,gic-version=host -cpu host          \
>    -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
>    -m 1024M,slots=16,maxmem=64G                                 \
>    -object memory-backend-ram,id=mem0,size=512M                 \
>    -object memory-backend-ram,id=mem1,size=512M                 \
>    -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
>    -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
>      :                                                          \
>    -device virtio-balloon-pci,id=balloon0,bus=pcie.10
> 
>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>    {"return": {}}
>    {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>       :
>    <The similar QMP events repeat>
> 
> Fix it by aligning the target up to the guest page size, 64KB in this
> specific case. With this applied, no flooding QMP events are observed
> and the memory balloon's size can be stablizied to 0x3ffe0000 soon
> after the deflation request is sent.
> 
>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>    {"return": {}}
>    {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    { "execute" : "query-balloon" }
>    {"return": {"actual": 1073610752}}
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
> ---
> v2: Align @num_pages up to the guest page size in towards_target()
>      directly as David suggested.
> ---
>   drivers/virtio/virtio_balloon.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

If the patch looks good, could you please merge this to Linux 6.6.rc4 since
it's something needed by our downstream. I hope it can land upstream as early
as possible, thanks a lot.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5b15936a5214..2d5d252ef419 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -395,7 +395,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>   	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
>   			&num_pages);
>   
> -	target = num_pages;
> +	/*
> +	 * Aligned up to guest page size to avoid inflating and deflating
> +	 * balloon endlessly.
> +	 */
> +	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
>   	return target - vb->num_pages;
>   }
>   

Thanks,
Gavin

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
