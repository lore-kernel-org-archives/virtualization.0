Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2C8C433EF
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 13:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFA0684D26;
	Fri, 14 Jan 2022 13:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nlps2qgu53rB; Fri, 14 Jan 2022 13:38:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8625284CB5;
	Fri, 14 Jan 2022 13:38:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BAE2C002F;
	Fri, 14 Jan 2022 13:38:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D7BFC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34EF641559
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id stVaeLttwcSs
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19ECF410E8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642167514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NbLWpbs04Fbr52VNRcUjKYlBXFjrwmcMdjglRxFIjmA=;
 b=HO8d/pSWWln9JIByT+svp59FAkwJgeMf8u+OrQZ/v7UDnPGDsEk/bHSNnt/RgOc/DuU/Ex
 F7HPMA/pzci+4CaGQWtM1OGOwSX/UINq60E3/wtSZ7M4yuCcLf4mK/mYw17UQjZY2ApHjK
 rBv68MgCycXBx8tN+RMKoFiZCGrciVg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-FAHEiKnLOginFDxAv2WWiw-1; Fri, 14 Jan 2022 08:38:32 -0500
X-MC-Unique: FAHEiKnLOginFDxAv2WWiw-1
Received: by mail-ed1-f71.google.com with SMTP id
 x11-20020aa7d38b000000b004004e4fc8fdso5857996edq.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 05:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=NbLWpbs04Fbr52VNRcUjKYlBXFjrwmcMdjglRxFIjmA=;
 b=1ZMfm8CN5aT+rWmzX/BnWqi92wVTLavlYpNYpoLFzDyEpQii9tmCsLXjYchLPVq8XB
 yCMP9whNFyGlDJVbyuZr94vBFKut5ySLUn3uDrWTV5W2SEukGJmN/bsaqkgMby497raG
 RAHjd0tOp+uxoKsgEMxK0jRv26r7JXk19+BgbSGE9cCmQhe4r/l5s8JLvTERIkyjOpCa
 MUdyWmtefakYY2+R+leKGe3B3pbx6D4L5mKCvAzk0JFa1CoLtC53aCC39mZxyJjLn5O8
 8aKOrvZ940E+RdWF3W5Jx7L1oQKo+FlhxEQ+ztRVoV6bKqVKVik9ksXeGUeuplH5OwdU
 RW/w==
X-Gm-Message-State: AOAM530Gc+yV1i2AUwNbFVNe0fXdhKsUesK06r+vhF/YpGUENR/Olsrf
 nRyqjhCFRKfoTGYTHRa0YRCigqOfmPb7f3fn5nDcSvsxf9CwSADtLR60DtTRXIdcemAeuxwEMmy
 jYsFjmAxhICv4Owoaul4dpbN3A8qH37uLLcrl6GBfWQ==
X-Received: by 2002:a05:6402:22f5:: with SMTP id
 dn21mr8277781edb.195.1642167511651; 
 Fri, 14 Jan 2022 05:38:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHvYz3VQ9C1aagG3+wcF6jvkOYHX0vhK+bpyMkPVNgdDNTqGPKVyjbaru5jr4nQAEJhmT6JQ==
X-Received: by 2002:a05:6402:22f5:: with SMTP id
 dn21mr8277761edb.195.1642167511469; 
 Fri, 14 Jan 2022 05:38:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c701:9d00:ff87:1c9b:108a:9702?
 (p200300cbc7019d00ff871c9b108a9702.dip0.t-ipconnect.de.
 [2003:cb:c701:9d00:ff87:1c9b:108a:9702])
 by smtp.gmail.com with ESMTPSA id c13sm1900839ejj.144.2022.01.14.05.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jan 2022 05:38:31 -0800 (PST)
Message-ID: <ead90b32-da2b-4d66-f103-6fbec0937e93@redhat.com>
Date: Fri, 14 Jan 2022 14:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 5/8] mm: page_isolation: check specified range for
 unmovable pages during isolation.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-6-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-6-zi.yan@sent.com>
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
> Enable set_migratetype_isolate() to check specified sub-range for
> unmovable pages during isolation. Page isolation is done
> at max(MAX_ORDER_NR_PAEGS, pageblock_nr_pages) granularity, but not all
> pages within that granularity are intended to be isolated. For example,
> alloc_contig_range(), which uses page isolation, allows ranges without
> alignment. This commit makes unmovable page check only look for
> interesting pages, so that page isolation can succeed for any
> non-overlapping ranges.

Are you handling if we start checking in the middle of a compound page
and actually have to lookup the head to figure out if movable or not?

> 
> has_unmovable_pages() is moved to mm/page_isolation.c since it is only
> used by page isolation.

Please move that into a separate patch upfront, makes this patch much
easier to review.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
