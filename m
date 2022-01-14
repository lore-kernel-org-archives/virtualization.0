Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C183C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 13:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0024860F35;
	Fri, 14 Jan 2022 13:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZoI88vY0ouw; Fri, 14 Jan 2022 13:44:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A846960B56;
	Fri, 14 Jan 2022 13:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C549C0072;
	Fri, 14 Jan 2022 13:44:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84E06C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F9FC402EB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ckbQDveAr-6N
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:44:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63841404FD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642167877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfjFLSHiBQKga3FwXwxrCNc9DhWW0rRljO+uSdIGNDI=;
 b=eSlalJItA1fAVeZ4lPifC1zKADSLB1XFI24QmLbj/CORxM2iHCkLA/C9iltecnBJ2jvxbV
 iJ7kVrleBjitaKDkAL+9D7B2XjeuUNWqmSLgOZ4WsU+N/XTLkihUEiQ4q/ogWLOqzu9gze
 seFz3ufpxA2CKQ+kvZU75+eYUTRf7Es=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-sJMrKaoiPoqGhj_ZBvTqXw-1; Fri, 14 Jan 2022 08:44:36 -0500
X-MC-Unique: sJMrKaoiPoqGhj_ZBvTqXw-1
Received: by mail-ed1-f72.google.com with SMTP id
 m8-20020a056402510800b003f9d22c4d48so8370186edd.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 05:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=nfjFLSHiBQKga3FwXwxrCNc9DhWW0rRljO+uSdIGNDI=;
 b=avZOTaNihsjEsOtasP2xvLySnE52QT1wSad3Br3lyll7h406FUdk13Uaca1rhvtcme
 HmjGjoc8SBzsOI5hRt/zC75HKudDlB88k9W5kpQ/IlS/oL9G10hmBM7zQP0kVTHKinv1
 iTRjatyuJfOmdJN1JhOGl+8Zrsoz9w0pYNc1h3whGhXaURs1N4xAOnwhWU9wtOkgZHu7
 gQ9xjLEej0Rt3XMIsfzGUAF8ZC2RaOHdkgtFQNh+QHhc/JKeCID3eY6+17rJqCBFPMpn
 DFLvGrMhWzJZ8oprOkAVi8KfThISKFquXXTLbrhCfFnn+t6D25tdlynDw8/mo/RZhwz0
 bPYw==
X-Gm-Message-State: AOAM532Z223b18VbzahR4zUT5xCYogQyeQDngF+t+s3kP7t+auAMljUX
 vRSPXxAaQ7oao9+9pZG7+XdNYcOYWiQRXAN+Ij40bxvDSF6prMtGXnSuUmguTYqiSXRz76FBaB/
 Y2BDGKEx8/Lpr4AK2+NB/NOGJdEnLziY8EtXuee788Q==
X-Received: by 2002:a05:6402:1008:: with SMTP id
 c8mr9115183edu.114.1642167874595; 
 Fri, 14 Jan 2022 05:44:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5OFak9AC/l+A6gU6QqTI2K9zWFX8t7yOZXV50BOSN3qj9pr1cdJHhBXdsT7LCgDNpLjpiDw==
X-Received: by 2002:a05:6402:1008:: with SMTP id
 c8mr9115163edu.114.1642167874354; 
 Fri, 14 Jan 2022 05:44:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702?
 (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de.
 [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
 by smtp.gmail.com with ESMTPSA id 10sm1861145ejy.174.2022.01.14.05.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jan 2022 05:44:33 -0800 (PST)
Message-ID: <60778775-b5f5-0837-092f-9911cec84854@redhat.com>
Date: Fri, 14 Jan 2022 14:44:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 7/8] drivers: virtio_mem: use pageblock size as the
 minimum virtio_mem size.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-8-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-8-zi.yan@sent.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Vlastimil Babka <vbabka@suse.cz>, Marek Szyprowski <m.szyprowski@samsung.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 05.01.22 22:47, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> alloc_contig_range() now only needs to be aligned to pageblock_order,
> drop virtio_mem size requirement that it needs to be the max of
> pageblock_order and MAX_ORDER.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  drivers/virtio/virtio_mem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index a6a78685cfbe..2664dc16d0f9 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2481,8 +2481,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
>  	 * - Is required for now for alloc_contig_range() to work reliably -
>  	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
>  	 */

Please also update this comment.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
