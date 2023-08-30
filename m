Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C313C6FA8F
	for <virtualization@archiver.kernel.org>; Wed, 30 Aug 2023 04:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 863E0405CF;
	Wed, 30 Aug 2023 04:24:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 863E0405CF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gq8AeV2W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ElkWk-TfkAlX; Wed, 30 Aug 2023 04:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EDAE2408A7;
	Wed, 30 Aug 2023 04:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDAE2408A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9269FC0039;
	Wed, 30 Aug 2023 04:24:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2584FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 04:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F21EE4174C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 04:24:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F21EE4174C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gq8AeV2W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIevWmo35W_m
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 04:24:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A26764169B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 04:24:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A26764169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693369477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kj1j2W7Rncwakl8+uaZCa8ACzieIXsTkub/0MwTanec=;
 b=gq8AeV2W8TiDhQZBVZm1bQE71uiIDvVXV2qrWcyHI859CvyCrIhc6y9E4QjuwAKt2soNF4
 23hsjeXZVL3gTCJ6Cj+P1d32EvD5KVK1i/2szovfrBQft/OhfHjs4qFvACxfsPW0qVVe12
 o7Y6V/kuoDNtl6Ig3x3G6SfPSi3Qba4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-D3Yo6xW3P3CQ-MiiTFDzvw-1; Wed, 30 Aug 2023 00:24:35 -0400
X-MC-Unique: D3Yo6xW3P3CQ-MiiTFDzvw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1bf5aa81af9so64050825ad.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 21:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693369474; x=1693974274;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kj1j2W7Rncwakl8+uaZCa8ACzieIXsTkub/0MwTanec=;
 b=i88YR2jIR1QMVPgC01pE22q+J6XLWJOeLO6C5WF5qdl08FNPixv2Hpg9y3ubwj1+Os
 8ImriqE9V2j+QTwq9q8FM6SLx0t7bhckLTh+E4EPXfXJb5eUOy8ZZva9ubA6jRI2sQ4d
 7hDLnWYZlAgu5gUNQf/nTc8+vwulHqbSuC47a48qXXOvDqGpc5/8d49iY4aQlQZbO7LQ
 Z4ySEYDiOAwniVgNHbskMbaS2uJVkAeEDl+yvkxvFO/XPW4ta0eerUKIXeQQ6wDYMMFc
 CFH7TkaClijBn6gnDAksHx5r0JGRfcttmSyKn/Acx2uJHbQCz8q6xUsPizOyvT9EcQur
 I5rA==
X-Gm-Message-State: AOJu0Yz5jBDcdNtCbl40tnESnr+zUhLK1oaaLNXWuQIjqLQ54EOEoV6m
 I4gdrBrwhF1pXYOwWnB89ha/Zgxc7Ill1XRxl364kibBPRenHgc9FpVt31eK/KM5PD1RwuuNYeC
 KOqdyGoxvfs9LPALcxQ8YTIkJ2YMnPFdZRus0naOYtTMMJpKpXt6DZNwJu51O5fIeFZo6MqECfb
 Rjo0yzQCvwya49gKNyEUlZKQ==
X-Received: by 2002:a17:902:8f8e:b0:1bc:16cf:fc30 with SMTP id
 z14-20020a1709028f8e00b001bc16cffc30mr960190plo.63.1693369473822; 
 Tue, 29 Aug 2023 21:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4oZ5RU+i1Ya/foOIIWYjMTJ1600KCLxPq/800allU07bEPXQNtyHlYba2jpFLQGMrX6HJ4A==
X-Received: by 2002:a17:902:8f8e:b0:1bc:16cf:fc30 with SMTP id
 z14-20020a1709028f8e00b001bc16cffc30mr960173plo.63.1693369473421; 
 Tue, 29 Aug 2023 21:24:33 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 jw15-20020a170903278f00b001bc6536051bsm10130790plb.184.2023.08.29.21.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 21:24:32 -0700 (PDT)
Message-ID: <55cb12bf-12e4-8da6-629c-5518f8abe85e@redhat.com>
Date: Wed, 30 Aug 2023 14:24:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] virtio_balloon: Fix endless deflation and inflation on
 arm64
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux-foundation.org
References: <20230829015421.920511-1-gshan@redhat.com>
In-Reply-To: <20230829015421.920511-1-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 Zhenyu Zhang <zhenyzha@redhat.com>, shan.gavin@gmail.com
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

On 8/29/23 11:54, Gavin Shan wrote:
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
> Fix it by having the target aligned to the guest page size, 64KB
> in this specific case. With this applied, no flooding QMP event
> is observed and the memory balloon's size can be stablizied to
> 0x3ffe0000 soon after the deflation request is sent.
> 
>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>    {"return": {}}
>    {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    { "execute" : "query-balloon" }
>    {"return": {"actual": 1073610752}}
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 

It was supposed to copy David, Jason and Zhenyu. I don't know how they have been
missed. My script may run into problems temporarily. Amending for it.

Thanks,
Gavin

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5b15936a5214..625caac35264 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -386,6 +386,17 @@ static void stats_handle_request(struct virtio_balloon *vb)
>   	virtqueue_kick(vq);
>   }
>   
> +static inline s64 align_pages_up(s64 diff)
> +{
> +	if (diff == 0)
> +		return diff;
> +
> +	if (diff > 0)
> +		return ALIGN(diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
> +
> +	return -ALIGN(-diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
> +}
> +
>   static inline s64 towards_target(struct virtio_balloon *vb)
>   {
>   	s64 target;
> @@ -396,7 +407,7 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>   			&num_pages);
>   
>   	target = num_pages;
> -	return target - vb->num_pages;
> +	return align_pages_up(target - vb->num_pages);
>   }
>   
>   /* Gives back @num_to_return blocks of free pages to mm. */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
