Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E533C433FE
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 11:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9FBA428E9;
	Wed, 12 Jan 2022 11:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0m_MTaZ5f0Yl; Wed, 12 Jan 2022 11:04:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 522C9428EB;
	Wed, 12 Jan 2022 11:04:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18710C0030;
	Wed, 12 Jan 2022 11:04:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB9EEC001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 11:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9331560601
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 11:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZWhOymz5thqE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 11:04:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00A9A605EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 11:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641985476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQRmWQJO7h35wGy22fa7tdbvt7nutmZtPTdgCQaUOQQ=;
 b=M3kfY68GE+dYQYOrIAD6qpxDGtdqdsgzCW7zV+E0zRJI6sRVO49KO3YS+6MVS9CD1WeAM7
 +NJDXx6Bc0oKeC+9Sxr3Wu9xCZ21WRlXxFRBAwFM8dXTteQ+qMZmdiAnbbbLWdx8oY59e0
 TVio8LF2zPVrRFrLAW5iWFSWjcFQtY0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-uOdU8RMTODacXSWwTk6wPg-1; Wed, 12 Jan 2022 06:04:32 -0500
X-MC-Unique: uOdU8RMTODacXSWwTk6wPg-1
Received: by mail-ed1-f70.google.com with SMTP id
 g11-20020a056402090b00b003f8fd1ac475so1978695edz.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 03:04:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=eQRmWQJO7h35wGy22fa7tdbvt7nutmZtPTdgCQaUOQQ=;
 b=DnoAu+fpGc9pl8gmG/oPh4/wKkead896sKM0AdLzgD/d9nZgjBcp59zn/mVmOSqSOz
 yxxKDG8XSgfMocRmeVWjwCIBagkXcXqwDHuBVlrWfAM6SHwxolX6Yzb0j4gcbtqYVXqf
 MIrhBMLn1SyKhjfF6fW/4YORBSY01WCT0OfBov/843cGxOxtUccaVzgvS0VYEM9mAPr9
 H5uV4XyZ+d7RxaBy9SCWKe8n0rth/nOFiXjZ/PrgfxoFbZT0htBprB9CF9OvWYthxVhW
 dX6jbZmhDxk6gpf6ahQZxR9qTCAk09+NrZffXgEntK/6axSrhmgb/ZvRjLj4W09MWwT7
 WTSg==
X-Gm-Message-State: AOAM5335XX8jCT8MMXMdbs91mDZzmBEw1dPzYSrOOt3+fNDSgk00Btpl
 12Cmtbu6U6OOEku7ScIhvp1pJ7x/NhXELAR41VYOeF2oasgyTobmusanRJxp669FS1AOhqItaeS
 cPZnMifQP39QkgcLYHb7oixsqO8xSfbTIwPEDMBrAnQ==
X-Received: by 2002:a05:6402:486:: with SMTP id
 k6mr8580281edv.330.1641985471846; 
 Wed, 12 Jan 2022 03:04:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLu6iWsDVwPl07dmV9nmwCMbbplxs+ZFDOgPiX/VhbSWFK2LAa03DeMHirncilimRMIa9S6A==
X-Received: by 2002:a05:6402:486:: with SMTP id
 k6mr8580274edv.330.1641985471689; 
 Wed, 12 Jan 2022 03:04:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec?
 (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de.
 [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
 by smtp.gmail.com with ESMTPSA id qw4sm4413621ejc.55.2022.01.12.03.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 03:04:31 -0800 (PST)
Message-ID: <970ca2a4-416d-7e8f-37c7-510c5b050f4b@redhat.com>
Date: Wed, 12 Jan 2022 12:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v3 3/8] mm: migrate: allocate the right size of non
 hugetlb or THP compound pages.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
References: <20220105214756.91065-1-zi.yan@sent.com>
 <20220105214756.91065-4-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220105214756.91065-4-zi.yan@sent.com>
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
> alloc_migration_target() is used by alloc_contig_range() and non-LRU
> movable compound pages can be migrated. Current code does not allocate the
> right page size for such pages. Check THP precisely using
> is_transparent_huge() and add allocation support for non-LRU compound
> pages.

IIRC, we don't have any non-lru migratable pages that are coumpound
pages. Read: not used and not supported :)

Why is this required in the context of this series?


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
