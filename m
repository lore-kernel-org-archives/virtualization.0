Return-Path: <SRS0=ciji=MH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D911C07E96
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 09:42:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C36613A9
	for <virtualization@archiver.kernel.org>; Thu, 15 Jul 2021 09:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C36613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8260B402B3;
	Thu, 15 Jul 2021 09:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sshe9GBDEafm; Thu, 15 Jul 2021 09:42:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 087E8400BA;
	Thu, 15 Jul 2021 09:42:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A587AC001A;
	Thu, 15 Jul 2021 09:42:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 651D8C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F72882572
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VpqR9aA4kI0l
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:42:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 837DC82505
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626342146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PdOfMSnG9LJU18W2DtAkqVS77pNiWqr5hxkOihWpm0=;
 b=gRgFDNxfhUWL5CnIjetV6CTPYtIkNNb8wzRGAJ1ypWXAo+NpwQOnWjVEIBCADqRU2nF5Iw
 BWcHdGDUHASueFrCh1YORvGrYTeyEebuHq/nGh9LMr1e1NBQR/Gzt6F9zxlUtQnjDIfbkD
 Cn9DvcHuWP/QqdcK3Q8RQdjwluz+FQw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-eiuweBugMAKz91pU3xXTeQ-1; Thu, 15 Jul 2021 05:42:25 -0400
X-MC-Unique: eiuweBugMAKz91pU3xXTeQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 m4-20020adffa040000b02901404c442853so3054705wrr.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 02:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:organization:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4PdOfMSnG9LJU18W2DtAkqVS77pNiWqr5hxkOihWpm0=;
 b=fgWKe8KDD/L8ZLqnWUkfHpghNz8MT5V16Tx3N/iUBSVlWtMbskWgrOSPPfyLDOcTnt
 T0X7o+KjOXEg2/MXDrnr5qZQtpUPa7C4gBBDYKa/39rRIr+SgAW6sl3NV4JdbSdNeUAo
 5R/HudrKvc+ks+Bj4FghyYCi2nEzYnu4GEl0L35k4dLuD6Ikz3KylqVpRGZ2sm7izw7Q
 Q/O8aI6AyyWg8r4F1kr8U6m9MtPBEnkebf3Am1bmNBF3yCaLw1iJQL5chwsax6FbRWNc
 v4a/VWifRqlaSyqUe31FPuxFl61dwNUAkMn3O7139tdzaCCYcMAzxkqp59qgBhd9LumH
 NVUQ==
X-Gm-Message-State: AOAM530M7Zt7hLGJQ5P4Ymy1x/X1mbO5EqJsIZ2tQpQgPXpcdujWn5ou
 9+jj1mlX4ueH3/5rxKyQ+75uK581SVVe3S51S3lAzRhIoSdB2MlgZSWq1Lv7BLUoF89kRjjMW1i
 UUZWIRJAO3a6uWfXGa9T8Zc8l2aq79+4ZeLgEMTMpPg==
X-Received: by 2002:a1c:4e18:: with SMTP id g24mr3536112wmh.175.1626342144022; 
 Thu, 15 Jul 2021 02:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAXwE/gJvtgWH3VbzGQK7W3cyGE+l9fkhB4QJqLvhmzLWnJPkHReE1uIFCe9c8tBBrApBQSg==
X-Received: by 2002:a1c:4e18:: with SMTP id g24mr3536099wmh.175.1626342143837; 
 Thu, 15 Jul 2021 02:42:23 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
 by smtp.gmail.com with ESMTPSA id q5sm4533504wmc.0.2021.07.15.02.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jul 2021 02:42:23 -0700 (PDT)
To: Heiko Carstens <hca@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20210712124052.26491-1-david@redhat.com>
 <20210712124052.26491-2-david@redhat.com> <YO9FWrT9h21e/G8X@osiris>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN in
 zone_for_pfn_range()
Message-ID: <99c59db8-4c3d-6bee-9acc-41a8f76899ef@redhat.com>
Date: Thu, 15 Jul 2021 11:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO9FWrT9h21e/G8X@osiris>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Michel Lespinasse <michel@lespinasse.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Rich Felker <dalias@libc.org>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Laurent Dufour <ldufour@linux.ibm.com>,
 Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@ozlabs.org>, Len Brown <lenb@kernel.org>,
 Nathan Lynch <nathanl@linux.ibm.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Borislav Petkov <bp@alien8.de>, Sergei Trofimovich <slyfox@gentoo.org>,
 Andy Lutomirski <luto@kernel.org>, Jia He <justin.he@arm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>, Christophe Leroy <christophe.leroy@c-s.fr>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Pierre Morel <pmorel@linux.ibm.com>, Scott Cheloha <cheloha@linux.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Joe Perches <joe@perches.com>,
 Mike Rapoport <rppt@kernel.org>
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

On 14.07.21 22:13, Heiko Carstens wrote:
> On Mon, Jul 12, 2021 at 02:40:49PM +0200, David Hildenbrand wrote:
>> Checkpatch complained on a follow-up patch that we are using "unsigned"
>> here, which defaults to "unsigned int" and checkpatch is correct.
>>
>> Use "unsigned long" instead, just as we do in other places when handling
>> PFNs. This can bite us once we have physical addresses in the range of
>> multiple TB.
>>
>> Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/linux/memory_hotplug.h | 4 ++--
>>   mm/memory_hotplug.c            | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> I'd propose to add Cc: <stable@vger.kernel.org> since I actually had
> the fun to try to debug something like this a couple of years ago:
> 6cdb18ad98a4 ("mm/vmstat: fix overflow in mod_zone_page_state()")
> 

Good point, and thinking again what can go wrong, I tend to agree. We 
are trying to keep zones contiguous and it could happen that we end up 
with something like ZONE_DMA here (via default_kernel_zone_for_pfn()) 
and would consequently online something to ZONE_DMA that doesn't belong 
there, resulting in crashes.

@Andrew can you add  Cc: <stable@vger.kernel.org> and

"As we will search for a fitting zone using the wrong pfn, we might end 
up onlining memory to one of the special kernel zones, such as ZONE_DMA, 
which can end badly as the onlined memory does not satisfy properties of 
these zones."

Thanks Heiko!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
