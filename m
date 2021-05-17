Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D086C433ED
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 15:18:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11D860724
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 15:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11D860724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB5C260AA5;
	Mon, 17 May 2021 15:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id It6-BdcM5gSI; Mon, 17 May 2021 15:18:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3971B60A89;
	Mon, 17 May 2021 15:18:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED947C000E;
	Mon, 17 May 2021 15:18:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9804C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 15:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8333C40377
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 15:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t1_-asrRwlUH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 15:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C53A402C4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621264714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBnQo/J9oz8gnM35x+7tBsgRWTaGkCDWee+DmJ5pKGg=;
 b=N8Y5eBgPTAIroqeRUsNbC1DBfQjo20AjmjUZMdw9It/E1+icZZo+9BSttLP7/56S1ERCEf
 1yvuJyQ9p1uBPOuTK7vJL3D8Xza6R1MyQgtlNmgQ2Sb2oCeZxNDewf3VmZHWtVywCln/rn
 CrpuVldox98ATxXIZOM3wHq6HaGTJv4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-z5e3Doi-Pe-b3YzpoQcPkA-1; Mon, 17 May 2021 11:18:33 -0400
X-MC-Unique: z5e3Doi-Pe-b3YzpoQcPkA-1
Received: by mail-wr1-f71.google.com with SMTP id
 i102-20020adf90ef0000b029010dfcfc46c0so3978495wri.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 08:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JBnQo/J9oz8gnM35x+7tBsgRWTaGkCDWee+DmJ5pKGg=;
 b=LS1iVZkaTJcDu2o1P09WsP1B2h3gzb2Uc176axpcUqx9En9u9Yh+uV1pd8oifbEh77
 C5Z5edHQZIuci54WoT7r9THryQxyJmK8LiUwVJyS6NCS45/6KQNBZm/R7IXZW/Skc+GP
 WEWWXbfA7V2oUfP1saNLZk0klv10JdixAWbG71F/d6mLf6mO5GCr3R/YiVSC+7goTpHt
 eG0s6D5gpgTZREBKpxg70UlQ/Dr9OPJy4upkT264eSblSDi3BBaKH4ul9hX96aRzrM0/
 FSkL7KjeNjZHdFe7n6fv8yhlCvaRWhVzO7AgVbP+dI1/wCJ8vRaCLy3ctOaJElljF7iP
 6Hbg==
X-Gm-Message-State: AOAM531m8usnWFhcKSrf3h3gl/CuIovgrRHh1gYeMkLtyYY3HAZ6kRni
 3qhQPu1DvY6xXj7iR3BMNmKRODWlKtbBMJseMqJVhgZ4UhoNHAgVnR+qzsgIyhlUkph61cjqzBp
 vtCyaJcZFngcoxnurk+Ve8nXsIkj+gS9niiciDyTFJw==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr231547wrv.324.1621264711826;
 Mon, 17 May 2021 08:18:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9pgHxSB1CvA6bP+5A102Vw3q+wpKkw7H+TASfr6okGY07XFAE7cdx9Tfb7WlCOrjNYsTg6Q==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr231511wrv.324.1621264711624;
 Mon, 17 May 2021 08:18:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6833.dip0.t-ipconnect.de. [91.12.104.51])
 by smtp.gmail.com with ESMTPSA id
 g206sm5661736wme.16.2021.05.17.08.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 08:18:31 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] mm: introduce page_offline_(begin|end|freeze|thaw)
 to synchronize setting PageOffline()
To: Mike Rapoport <rppt@kernel.org>
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-5-david@redhat.com> <YKIQfCjq13dSMHOs@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <016e96c9-82e6-3259-7a99-8627c3be11c6@redhat.com>
Date: Mon, 17 May 2021 17:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKIQfCjq13dSMHOs@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Aili Yao <yaoaili@kingsoft.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Wei Liu <wei.liu@kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Steven Price <steven.price@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jiri Bohac <jbohac@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>,
 Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>,
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

On 17.05.21 08:43, Mike Rapoport wrote:
> On Fri, May 14, 2021 at 07:22:45PM +0200, David Hildenbrand wrote:
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
>> Let's introduce page_offline_(begin|end|freeze|thaw) for
>> synchronizing.
>>
>> page_offline_freeze()/page_offline_thaw() allows for a subsystem to
>> synchronize with such drivers, achieving that a page cannot be set
>> PageOffline() while frozen.
>>
>> page_offline_begin()/page_offline_end() is used by drivers that care about
>> such races when setting a page PageOffline().
>>
>> For simplicity, use a rwsem for now; neither drivers nor users are
>> performance sensitive.
>>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> One nit below, otherwise
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
>> ---
>>   include/linux/page-flags.h | 10 ++++++++++
>>   mm/util.c                  | 40 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>> index daed82744f4b..ea2df9a247b3 100644
>> --- a/include/linux/page-flags.h
>> +++ b/include/linux/page-flags.h
>> @@ -769,9 +769,19 @@ PAGE_TYPE_OPS(Buddy, buddy)
>>    * relies on this feature is aware that re-onlining the memory block will
>>    * require to re-set the pages PageOffline() and not giving them to the
>>    * buddy via online_page_callback_t.
>> + *
>> + * There are drivers that mark a page PageOffline() and do not expect any
> 
> Maybe "and expect there won't be any further access"...
> 

Thanks, makes sense.

I'll wait a bit before I resend.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
