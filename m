Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4EBC433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 15:10:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F85613C7
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 15:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F85613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0D7840638;
	Wed,  5 May 2021 15:10:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lHga6waFLBki; Wed,  5 May 2021 15:10:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 796A9402CE;
	Wed,  5 May 2021 15:10:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45841C000E;
	Wed,  5 May 2021 15:10:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5018AC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 15:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3331C403A9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 15:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4Q1zOMpyoTu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 15:10:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEC0B40367
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620227438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/L/odP+hNbqQUDDWOlbej9giUfvPDpuerxl0425+TBc=;
 b=e/1BlBsYloRIlP5H7nUqQVDa4u1o20rT3rKm6mHYe70SWXyD9i85EJOADcQNCLXm6sQ3Dr
 SCiAxOTukBhnkU1JFggg1VSbL433Qy4XXZh8pukHLS9F+QFnMo0dmxQDowX2l5bGeFtHiZ
 NHw6L7HYASkwiM97gyflqgCETpyxtV4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-deteQfgaO2i4r0wAC5S4oQ-1; Wed, 05 May 2021 11:10:37 -0400
X-MC-Unique: deteQfgaO2i4r0wAC5S4oQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 w21-20020a7bc1150000b029014a850581efso434505wmi.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/L/odP+hNbqQUDDWOlbej9giUfvPDpuerxl0425+TBc=;
 b=haChgsgqNFAv0QE56wSB0uZSxlIUyyjTQim9h3kranAwLg2FWHpJivn9NSER77yBsH
 S075wCZHGh2ACmyeRb0kTxS+sGhFHIaAWmUntlzFVTG8W9ClUWyRjIACwbYepzwBpFb0
 2Idwj7dZiVggF7qrjlbav3/vCecWw0Krc15GN1oDGCpDc1ihl6zFDfXiW+VOvw1YLoei
 EwFrZNyeuJgl0NXKJv/1f7PjDmIU6gWWi2fNPrTg7+Wq/2ZJjPYaeLZXI/6JQygewMHe
 W3/rppmuHeogWnGZz2ByvsT8XVYc9VbQ1xYyIVmY/t9Wz3lRYcZQaMhnkouMlcZ178me
 we6w==
X-Gm-Message-State: AOAM531HFrVZNmYyhbjGIb+vYHR415MiDekxe/3lnarsJbuElouYGu/Q
 a+3Ty+1BKFYrFnLKdCC8tmq7vhuAneO/+jUtascSRNCuVz/+QomntENaEIYuLAhwc05Rwe2KHAz
 pqqcneTa+2FiJYPtRa4YmINeTA6WFKzoqa2uSK/Zkiw==
X-Received: by 2002:adf:e686:: with SMTP id r6mr38035612wrm.187.1620227435727; 
 Wed, 05 May 2021 08:10:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzj10ka75uUq1iMVB73dSK1NoxnunzZR7BfPe0BRAG27lacrjzLCxVkjF8du5Ejfe2oe3wnw==
X-Received: by 2002:adf:e686:: with SMTP id r6mr38035569wrm.187.1620227435461; 
 Wed, 05 May 2021 08:10:35 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
 by smtp.gmail.com with ESMTPSA id
 m184sm6099684wme.40.2021.05.05.08.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 08:10:35 -0700 (PDT)
Subject: Re: [PATCH v1 5/7] mm: introduce
 page_offline_(begin|end|freeze|unfreeze) to synchronize setting PageOffline()
To: Michal Hocko <mhocko@suse.com>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-6-david@redhat.com> <YJKcg06C3xE8fCfu@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8650f764-8652-a82c-c54f-f67401c800e8@redhat.com>
Date: Wed, 5 May 2021 17:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJKcg06C3xE8fCfu@dhcp22.suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Aili Yao <yaoaili@kingsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Wei Liu <wei.liu@kernel.org>,
 Alex Shi <alex.shi@linux.alibaba.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Steven Price <steven.price@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jiri Bohac <jbohac@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>,
 Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>,
 Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>
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

On 05.05.21 15:24, Michal Hocko wrote:
> On Thu 29-04-21 14:25:17, David Hildenbrand wrote:
>> A driver might set a page logically offline -- PageOffline() -- and
>> turn the page inaccessible in the hypervisor; after that, access to page
>> content can be fatal. One example is virtio-mem; while unplugged memory
>> -- marked as PageOffline() can currently be read in the hypervisor, this
>> will no longer be the case in the future; for example, when having
>> a virtio-mem device backed by huge pages in the hypervisor.
>>
>> Some special PFN walkers -- i.e., /proc/kcore -- read content of random
>> pages after checking PageOffline(); however, these PFN walkers can race
>> with drivers that set PageOffline().
>>
>> Let's introduce page_offline_(begin|end|freeze|unfreeze) for
>> synchronizing.
>>
>> page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
>> synchronize with such drivers, achieving that a page cannot be set
>> PageOffline() while frozen.
>>
>> page_offline_begin()/page_offline_end() is used by drivers that care about
>> such races when setting a page PageOffline().
>>
>> For simplicity, use a rwsem for now; neither drivers nor users are
>> performance sensitive.
> 
> Please add a note to the PageOffline documentation as well. While are
> adding the api close enough an explicit note there wouldn't hurt.

Will do.

> 
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> As to the patch itself, I am slightly worried that other pfn walkers
> might be less tolerant to the locking than the proc ones. On the other
> hand most users shouldn't really care as they do not tend to touch the
> memory content and PageOffline check without any synchronization should
> be sufficient for those. Let's try this out and see where we get...

My thinking. Users that actually read random page content (as discussed 
in the cover letter) are

1. Hibernation
2. Dumping (/proc/kcore, /proc/vmcore)
3. Physical memory access bypassing the kernel via /dev/mem
4. Live debug tools (kgdb)

Other PFN walkers really shouldn't (and don't) access random page content.

Thanks!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
