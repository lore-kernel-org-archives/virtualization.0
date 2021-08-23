Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8373C4338F
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 19:15:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D85613D0
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 19:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 51D85613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03C6480C19;
	Mon, 23 Aug 2021 19:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g_3QLbt4i9ch; Mon, 23 Aug 2021 19:15:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A03E080C0F;
	Mon, 23 Aug 2021 19:15:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 806FEC001A;
	Mon, 23 Aug 2021 19:15:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 950C9C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 19:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7012D80C19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 19:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZkTjo_taCybQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 19:15:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C37A80C0F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629746105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbCwTw6xOu3Ht//mhhr4QVYkX1dUGLm9ed7G3TO0npw=;
 b=dh5eB2zKVKX4i06xXqtAab8AfQvO+Bp6StPr/rfrprrv9YWk4yCbM9ADy0pSPy4S8KUvSs
 ULakQjWCisH9LgPI9NRkXT2MXd+xQtIpde4muF7oEX5tB50lMUeqwSKXwU4FddEw8fGLdW
 nhFdcSm+gDR/wPs2Pzxb57zEbquwafw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-2NxoKsW3POifnJfyaNzt8g-1; Mon, 23 Aug 2021 15:15:01 -0400
X-MC-Unique: 2NxoKsW3POifnJfyaNzt8g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5-20020a1c00050000b02902e67111d9f0so3306935wma.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 12:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FbCwTw6xOu3Ht//mhhr4QVYkX1dUGLm9ed7G3TO0npw=;
 b=PBYERaeyC+Mo7/4W0Q9oFKKJcWBQi90VlSXnCaU5aEZenxkeSDGIDu7mdK68uEIWP0
 tsjEYLkSKWuojQZ9WO0WnupQgzsdVXSknwsu4VliKEJeikHnYwiu0UIi6CubvcO8MkrZ
 Nybcg2ACw8jaZDHmGOXGl1emmL/PPgPXApN5wiZV0LR0gQXMggdVtuHVn+wkSpSYVjNE
 9E5gCUae0s0IpkPtVnczUxe2HSv+xDEyT8db36X6Plx4eoRNFNRV7j3/1gagu0Y6uz7Z
 4/XK36VWYMOJm5BlXTyT1ZM8deUSehhl5BtxSpwcA4Zk3dKhY5R0PIMmd4HN1WhZY9qa
 Nj6w==
X-Gm-Message-State: AOAM53080BLmRcw88wIoAiooVbxUQQglk4rZN+ojqM8MLbkn6SC+RMBj
 7Y970EEE8E/pVEUYqzRNvh8GAdj8jPQL/qisYHTyCekmVYjxtp8PHvuANdbqBEX+eTIi/9BVDR9
 SOHU1AR+hSuM0dfuh3oZY88Gkyo0J8WLPpDuREiX1Fg==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr123199wmc.102.1629746100815;
 Mon, 23 Aug 2021 12:15:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmHLZ/yRcGZNEKd6Wx/oxzCAOwoEzlfech47KHL+wKEm8l9PACfZJA4BN1gYFB0YEVFyNQig==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr123185wmc.102.1629746100627;
 Mon, 23 Aug 2021 12:15:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60c6.dip0.t-ipconnect.de. [91.12.96.198])
 by smtp.gmail.com with ESMTPSA id
 y15sm2342827wrw.64.2021.08.23.12.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Aug 2021 12:15:00 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] virtio-mem: disallow mapping virtio-mem memory via
 /dev/mem
To: linux-kernel@vger.kernel.org
References: <20210816142505.28359-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <aa136104-153c-1c85-54df-f55b953ff36d@redhat.com>
Date: Mon, 23 Aug 2021 21:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816142505.28359-1-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Arnd Bergmann <arnd@arndb.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
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

On 16.08.21 16:25, David Hildenbrand wrote:
> Let's add the basic infrastructure to exclude some physical memory
> regions completely from /dev/mem access, on any architecture and under
> any system configuration (independent of CONFIG_STRICT_DEVMEM and
> independent of "iomem=").
> 
> Use it for virtio-mem, to disallow mapping any virtio-mem memory via
> /dev/mem to user space after the virtio-mem driver was loaded: there is
> no sane use case to access the device-managed memory region via /dev/mem
> once the driver is actively (un)plugging memory within that region and
> we want to make sure that nobody will accidentially access unplugged
> memory in a sane environment.
> 
> Details can be found in patch #1.
> 
> v1 -> v2:
> - "/dev/mem: disallow access to explicitly excluded system RAM regions"
> -- Introduce and use for_each_resource() and next_resource_skip_children()
> -- s/iomem_range_contains_excluded/iomem_range_contains_excluded_devmem/
> - "kernel/resource: cleanup and optimize iomem_is_exclusive()"
> -- Use for_each_resource()
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> 
> David Hildenbrand (3):
>    /dev/mem: disallow access to explicitly excluded system RAM regions
>    virtio-mem: disallow mapping virtio-mem memory via /dev/mem
>    kernel/resource: cleanup and optimize iomem_is_exclusive()
> 
>   drivers/char/mem.c          | 22 ++++++--------
>   drivers/virtio/virtio_mem.c |  4 ++-
>   include/linux/ioport.h      |  1 +
>   kernel/resource.c           | 60 +++++++++++++++++++++++++++++++++----
>   lib/Kconfig.debug           |  4 ++-
>   5 files changed, 71 insertions(+), 20 deletions(-)
> 
> 
> base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
> 

More review welcome; I'd suggest this should go via the -mm tree, and 
not via the vhost tree.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
