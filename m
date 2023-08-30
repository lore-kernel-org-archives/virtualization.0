Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA3FC6FA8F
	for <virtualization@archiver.kernel.org>; Wed, 30 Aug 2023 16:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E19F61219;
	Wed, 30 Aug 2023 16:30:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E19F61219
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXouLeuN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r42bAN_ALF0N; Wed, 30 Aug 2023 16:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FF3E60F85;
	Wed, 30 Aug 2023 16:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FF3E60F85
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64329C0039;
	Wed, 30 Aug 2023 16:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82947C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 16:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B3D941B23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 16:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B3D941B23
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aXouLeuN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NPH30gCHS3D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 16:30:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B4BC41AEB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 16:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B4BC41AEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693413030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFrAeIckcxwdM3BGhgwY2df5vNbcEm/5Om84XOIOQVA=;
 b=aXouLeuNtlgwgeh1ESwrWKSqmW8kUURWJTjRbZWKOK15HZEcXh3WrKzFMGBJC2gFZ/chRd
 VhLhcLYokpXlHTcj4h7r+2K55e9pzXVBXc1cS+v53ogdpavZeukCLTZeMTUzmfNG1OhIxm
 KkN03tXtcvP5HpZvmg+OflGSmY1eOyg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-L1j3kauBNqSRl-MuIWHU-A-1; Wed, 30 Aug 2023 12:30:29 -0400
X-MC-Unique: L1j3kauBNqSRl-MuIWHU-A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c5cc5537dso447578f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 09:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693413028; x=1694017828;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aFrAeIckcxwdM3BGhgwY2df5vNbcEm/5Om84XOIOQVA=;
 b=TxWWPuVt54SYB+QdpG0Xg/Nx+VJ2zel1XeeSaC+X17pwIZ5nPhTEcIrPt64fs7Tda3
 h1g9YXJqrQGrOwZ9jmPDzUB8AbiAUo5+V274isseix1XmQ9xG5tpxVABZvvvmPe0jTO9
 i0FqaoqIRvWmXhFck5aF0Q2mLTsa2c4WjBeC12n7M3UztlIPKNGNK3sRjo3wyMGImY0W
 jt5qau998nu74mSnjM1Ar/gAHqYr+zBXG5rpMM2lPYDMIWWyJ3XPJQ0MfCvN++Qcyqet
 NXcqVe2tJZ28YB6N+B5e9cFfmKmX7d6GjDGGyHTrrs97YkE2tg9yrKCsSXTZgI6TYJtO
 HdrQ==
X-Gm-Message-State: AOJu0YwspbpMkKWdtMH4VFkyFj6p5v3SWq4EiYfmi4M6rMxMPOaBop0x
 vCDi85fk+nChrXyzmmuf0pfiPQanHVLqPEKn9Qd94VSXuy8CLrATvAPurRPuVmCyTQnYygdUSuh
 Ucr2aL/TPwN8eexkeT5APCCVIonSRsQNZro3NinYAaw==
X-Received: by 2002:a5d:4a8d:0:b0:30e:56b3:60fe with SMTP id
 o13-20020a5d4a8d000000b0030e56b360femr131955wrq.4.1693413028099; 
 Wed, 30 Aug 2023 09:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXOzXnjzkCatETTts+G6EKS/KJiIlbcSxMP9jMzfgkBY6L4zKkYcXK5LkfkYMzCGwc/dBzyQ==
X-Received: by 2002:a5d:4a8d:0:b0:30e:56b3:60fe with SMTP id
 o13-20020a5d4a8d000000b0030e56b360femr131931wrq.4.1693413027716; 
 Wed, 30 Aug 2023 09:30:27 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a5d4b4c000000b0031416362e23sm17169032wrs.3.2023.08.30.09.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 09:30:27 -0700 (PDT)
Message-ID: <d2bf8d72-8d41-e26f-2dc7-d45973fe2164@redhat.com>
Date: Wed, 30 Aug 2023 18:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] virtio_balloon: Fix endless deflation and inflation on
 arm64
To: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux-foundation.org
References: <20230829015421.920511-1-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230829015421.920511-1-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 shan.gavin@gmail.com, mst@redhat.com
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

On 29.08.23 03:54, Gavin Shan wrote:
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

We know that vb->num_pages is always multiples of 
VIRTIO_BALLOON_PAGES_PER_PAGE.

Why not simply align target down?

target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
return target - vb->num_pages;


-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
