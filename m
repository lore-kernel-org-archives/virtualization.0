Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE46CC83F2B
	for <virtualization@archiver.kernel.org>; Thu, 31 Aug 2023 08:10:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8892582B21;
	Thu, 31 Aug 2023 08:10:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8892582B21
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uk2ngrnZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xInL-7eqjnzi; Thu, 31 Aug 2023 08:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2F6082073;
	Thu, 31 Aug 2023 08:10:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2F6082073
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD842C0071;
	Thu, 31 Aug 2023 08:10:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85AF9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C77160B9E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:10:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C77160B9E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uk2ngrnZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0QWdBrgm-SOS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:10:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65CAE60B69
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 08:10:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65CAE60B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693469452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z566ZZFlUEIUNPV4JZS2b3O9kCxmD4O/UFGD6TWNjL0=;
 b=Uk2ngrnZVWx6E2jM/+DC8skGxdMRqeBqd5nkcy0PqpRFs0ZjjgWeluLtERLq/g+i/oVjou
 sg049DGlrs89yZcOIA+2595DG6cL4mJ/Pb19xcINfJawm0SbLkKNk5gxQ4How5W6b9TlD0
 eGg0Jo4OJbfgwUVdUOzrZJ/j79baPMw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-nqt140PuMxSpHiCKSdVbZw-1; Thu, 31 Aug 2023 04:10:51 -0400
X-MC-Unique: nqt140PuMxSpHiCKSdVbZw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bcc1e0dfe5so7643221fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Aug 2023 01:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693469449; x=1694074249;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z566ZZFlUEIUNPV4JZS2b3O9kCxmD4O/UFGD6TWNjL0=;
 b=ZUYrZZRcnwL88A5XLtZoe7RENZ3R9WcE9uRB4hjdZ+I1geNkZESUqTrNFC10l9H85J
 tHrbeHano76xv6Zc5W8JhBsQSHCFZl7dGHtn+fl7YJV+amkGwzZiYfUyYeXOijv2WNwn
 9MpOGIspWbhzw9iz7BBv57U94R7eRr691t75i8Rr5TojfAsDLVWKQI2djVonzDXAUCsZ
 CaFflmVZ/RfprXiUn0KKYL86RZgsjZj0nagtU64D6JfWaDg3xD7RjGWbk6mVVAH7Kf+s
 4/U47Q3/yQZmvgS1+f0IBA2pT27xjniMAt6zbxSFuJVdwKny+jzHT5flrl7DKR1eFUXS
 kwZw==
X-Gm-Message-State: AOJu0YyELrBDPffy+s2Vhhg6XkrFubAfrnOODM6Og0CdxsN3NjvW5r/M
 5pzcA2KIc/s7v6UlIowihW6ZX/AaEIVN3Gd6hL0FAqBE2Pjr9qgww1TctdiZuam4c64ZyNFMO9p
 kX/sViw1rfGhQlKzKPR85OAGVYDDBz+kl3FFb9gw73Q==
X-Received: by 2002:a2e:9397:0:b0:2bc:e1a3:fbaa with SMTP id
 g23-20020a2e9397000000b002bce1a3fbaamr3873702ljh.22.1693469449481; 
 Thu, 31 Aug 2023 01:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0fmltGXq6qnXi49mnyirGvJlhacFpekfh2qsAEaM19VNcfoz1PP7C20+IbtMCtQkR2mQbqQ==
X-Received: by 2002:a2e:9397:0:b0:2bc:e1a3:fbaa with SMTP id
 g23-20020a2e9397000000b002bce1a3fbaamr3873688ljh.22.1693469449110; 
 Thu, 31 Aug 2023 01:10:49 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c299300b003fe539b83f2sm4318770wmd.42.2023.08.31.01.10.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:10:48 -0700 (PDT)
Message-ID: <688b18aa-f648-7973-5dda-cc1afdc2c5f5@redhat.com>
Date: Thu, 31 Aug 2023 10:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation on
 arm64
To: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux-foundation.org
References: <20230831011007.1032822-1-gshan@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
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

On 31.08.23 03:10, Gavin Shan wrote:
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

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
