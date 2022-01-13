Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9CFC433EF
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 15:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3D726FC51;
	Thu, 13 Jan 2022 15:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ooTzv89L7CV; Thu, 13 Jan 2022 15:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 678BC6FC4A;
	Thu, 13 Jan 2022 15:50:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2648C006F;
	Thu, 13 Jan 2022 15:50:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51A3CC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E30440901
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:50:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UUzWGZiugbEv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:50:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3EAA405E9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642089041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RQ3puUcYuHO/5UfsU4Xhhp2Gu/t2oxOAbK9fU144eE=;
 b=RwcpVaOQpoP3+Jj5f1l3w6B8jXiSIQ40wz45tKZzM54sRhUJyTkeYAENGk7VoN7J0yQnwq
 Rf7o4qiSSmFyQd2XwCKgivDua/xvusrPRcoYdu2yFKgYHuZSMsx7vyKYWlBUWmi2Pp7qax
 GejVf5xk6yZ70cHIDzqdmSENEPQ84e0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-S3KrJ8P-M-igwDIsjHPbog-1; Thu, 13 Jan 2022 10:50:40 -0500
X-MC-Unique: S3KrJ8P-M-igwDIsjHPbog-1
Received: by mail-ed1-f71.google.com with SMTP id
 x11-20020aa7d38b000000b004004e4fc8fdso3202274edq.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=0RQ3puUcYuHO/5UfsU4Xhhp2Gu/t2oxOAbK9fU144eE=;
 b=Gj6vqvIoNBQkeptb8J1Mw24vsLHCbArKDRNx2Ppz5cdPL+NGphAMFBgQUyX1ZITnJn
 OvqeHV6Ou3lfCxXPgwaq/l4rgkS5G0oDrekNDBmf7fVC4XmAyWXnOW98IIk1DUUPmzuq
 ewCFWtQVCU4PmjhTcWUEmRmW/tpoYWvm8OUHEgPnGOrnN8RWbKfZMs1qvKjHVqtHhD55
 5cnEV1vjwFzIwFrer9S6oIzgXbYliLe2pTjQQGDMsmIglocH6R7k1TdF0mxityxSNyn6
 SycWkCiCatUAVEb59vsyfIihotU19wguJ7ifpT4dHasWS4a9FdsCa0RaX0h3hHr8OIEi
 38oQ==
X-Gm-Message-State: AOAM530PowueRekTqOt+MuYKrEcsFfU8WemOqPU5KEVR9V6Osw5mEtIW
 uFWppX2DuN8yR7hYM7lgkEmepYSMvuzXwc5+1tXoy3DkFvjjTpeBqAcJhMFkj9amgYjM0cpT5AP
 P9V4aRiJwDX/4dxupwK/bP1upN4l9ThXFvwu+9/F/ng==
X-Received: by 2002:a05:6402:3588:: with SMTP id
 y8mr4824684edc.147.1642089039283; 
 Thu, 13 Jan 2022 07:50:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNFlqW+90z8MqJGfmQJtPI4aVOG3CgxuC8pcaaa86GGnEzwNl0A4gvDtrNM26vya8mfn/rVA==
X-Received: by 2002:a05:6402:3588:: with SMTP id
 y8mr4824671edc.147.1642089039121; 
 Thu, 13 Jan 2022 07:50:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7?
 (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de.
 [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
 by smtp.gmail.com with ESMTPSA id qw4sm1026745ejc.55.2022.01.13.07.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jan 2022 07:50:38 -0800 (PST)
Message-ID: <5da2e9ae-24bc-a146-053d-a43063bad73e@redhat.com>
Date: Thu, 13 Jan 2022 16:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 3/8] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
To: Zi Yan <ziy@nvidia.com>
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-4-zi.yan@sent.com>
 <970ca2a4-416d-7e8f-37c7-510c5b050f4b@redhat.com>
 <15E26B9B-8AE2-4916-94E7-D0BBB2491B1B@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <15E26B9B-8AE2-4916-94E7-D0BBB2491B1B@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Eric Ren <renzhengeek@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On 13.01.22 16:46, Zi Yan wrote:
> On 12 Jan 2022, at 6:04, David Hildenbrand wrote:
> 
>> On 05.01.22 22:47, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> alloc_migration_target() is used by alloc_contig_range() and non-LRU
>>> movable compound pages can be migrated. Current code does not allocate the
>>> right page size for such pages. Check THP precisely using
>>> is_transparent_huge() and add allocation support for non-LRU compound
>>> pages.
>>
>> IIRC, we don't have any non-lru migratable pages that are coumpound
>> pages. Read: not used and not supported :)
> 
> OK, but nothing prevents one writing a driver that allocates compound
> pages and provides address_space->migratepage() and address_space->isolate_page().
> 
> Actually, to test this series, I write a kernel module that allocates
> an order-10 page, gives it a fake address_space with migratepage() and
> isolate_page(), __SetPageMovable() on it, then call alloc_contig_range()
> on the page range. Apparently, my kernel module is not supported by
> the kernel, thus, I added this patch.
> 
> Do you have an alternative test to my kernel module, so that I do not
> even need this patch myself?
> 
>> Why is this required in the context of this series?
> 
> It might not be required. I will drop it.

That's why I think it would be best dropping it. If you need it in
different context, better submit it in different context.

Makes this series easier to digest :)


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
