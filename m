Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D630C433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 13:39:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A4C61222
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 13:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A4C61222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D75F607D1;
	Wed,  5 May 2021 13:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n1Ih-cGjBC7q; Wed,  5 May 2021 13:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADC5B6059F;
	Wed,  5 May 2021 13:39:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93C9EC000E;
	Wed,  5 May 2021 13:39:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB5B4C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9291607D1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8FZHErPVWj8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:39:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F02CA6059F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620221952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHQUE4RBuZmI4g/5aOXOPIjM70ZyTC143fCzVAJ8P/8=;
 b=XbA6lx0bzuvGnsjamzB2SN5ZQqkhC/MSRn0LBavuLTAXoANKROhp1DJt5RpaDYza/h2wET
 0vukOKzX1m9g4KUfmUuzZVLR5YP6A8pz1VHcVf2KwhBf+JfkWM3VqwGLa+xGTKelQC1Msn
 GU4B7P6epI1FBbOIqwEpZF8l0ZFCN10=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-lMcOmeF1MC-SfQTlGohFNw-1; Wed, 05 May 2021 09:39:11 -0400
X-MC-Unique: lMcOmeF1MC-SfQTlGohFNw-1
Received: by mail-ed1-f69.google.com with SMTP id
 s20-20020a0564025214b029038752a2d8f3so878494edd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 06:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IHQUE4RBuZmI4g/5aOXOPIjM70ZyTC143fCzVAJ8P/8=;
 b=JLUsF9Ax/fH81UgvqrmIXultWRFuBURct5Czf49ZaMUkIqdlwU9TTlBOgNjXIA9Mfr
 LR1rw4skejBXKMgelXqR0RxVsIMmOGMSNld4jwFHOOmss3Fxk84W6n4NUz8zi2CqZixd
 7uVJuq1XWJ7540up8qq599gUcWYWsVkuSZ+ebFIcEPbMwSJS5yWloNCkkpGYKObJRueD
 fMxIUB6KzRMNzvSjpffzUuwX/H6nXrn80ym6UUlEtDw9Z/3WuYKcvUGYPAPfdrZ/Rq4B
 FEF3f6ti2SLgzMr8PmeRSVQBwa/W2t8NO79HcDON6X4/cmCm4+Zx5XGGWCNItQ8G79ml
 BpqA==
X-Gm-Message-State: AOAM531uuT9gdDJiLLg6cw1R9poimhcSbS1Oj6pSdeEHPI5pTUiKXC8r
 YIWgbG0bw8MxsC+G7eNZtzzynzGv3gzr/jKCGu/vjzHCnnwaJHG4hBkyyG+AJrXPnquBd4mhO3F
 lk1A51sjipUKCn9KyTv6PbW/qVI5VfQeExdKSSD2aHw==
X-Received: by 2002:a17:906:2406:: with SMTP id
 z6mr3443997eja.396.1620221950190; 
 Wed, 05 May 2021 06:39:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGWyxHBPyyOetZHpx601TcawWH0Fo+idEg5VdUHFvJAR1tTdcZpi84XXPEA0gN5zGGPMwDGA==
X-Received: by 2002:a17:906:2406:: with SMTP id
 z6mr3443980eja.396.1620221950000; 
 Wed, 05 May 2021 06:39:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
 by smtp.gmail.com with ESMTPSA id
 p21sm16699366edw.18.2021.05.05.06.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 06:39:09 -0700 (PDT)
To: Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com> <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
 <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
 <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Message-ID: <57ac524c-b49a-99ec-c1e4-ef5027bfb61b@redhat.com>
Date: Wed, 5 May 2021 15:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJKdS+Q8CgSlgmFf@dhcp22.suse.cz>
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
 Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

>> Long story short, this should be good enough for the cases we actually can
>> handle? What am I missing?
> 
> I am not sure I follow. My point is that I fail to see any added value
> of the check as it doesn't prevent the race (it fundamentally cannot as
> the page can be poisoned at any time) but the failure path doesn't
> put_page which is incorrect even for hwpoison pages.

Oh, I think you are right. If we have a page and return NULL we would 
leak a reference.

Actually, we discussed in that thread handling this entirely 
differently, which resulted in a v7 [1]; however Andrew moved forward 
with this (outdated?) patch, maybe that was just a mistake?

Yes, I agree we should revert that patch for now.

Regarding the race comment: AFAIU e.g., [2], it's not really a problem 
with a race, but rather some corner case issue that can happen if we 
fail in memory_failure().


[1] https://lkml.kernel.org/r/20210406104123.451ee3c3@alex-virtual-machine
[2] 
https://lkml.kernel.org/r/20210331015258.GB22060@hori.linux.bs1.fc.nec.co.jp

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
