Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0E9C433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 13:18:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8518C613BE
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 13:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8518C613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 161934059A;
	Wed,  5 May 2021 13:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rOPJjZtIluDy; Wed,  5 May 2021 13:18:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6589B4059B;
	Wed,  5 May 2021 13:18:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3808CC000E;
	Wed,  5 May 2021 13:18:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49E8FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 299294059B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:18:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kOOPStFwMc93
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:17:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8EE24059A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620220677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtrXxKUiAvmqmB6yyp++vsOaAc/bZaOc4BH5ZWRKiJg=;
 b=cvmkcuvDFybGFr8kCaBP7OyAsXx6GxLLeEPPFx5NqvE90X4NXOnwJQjmYDYdIq0kYrXklr
 QcUvHGaBwQCrf5LkxWj9yRTcTfk4knbXHbYoPYhXCbQVANWAaDUenr/eHo3xPuqdXQ/jYi
 H/1vqS/UGo9c0KCb26PA4WwWvaOAE6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-axlN0bzrP6i8sm9HKWUmbA-1; Wed, 05 May 2021 09:17:56 -0400
X-MC-Unique: axlN0bzrP6i8sm9HKWUmbA-1
Received: by mail-wm1-f70.google.com with SMTP id
 b16-20020a7bc2500000b029014587f5376dso1417336wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=QtrXxKUiAvmqmB6yyp++vsOaAc/bZaOc4BH5ZWRKiJg=;
 b=M3ZfMKKGwRX0FIWoy8FGFUNBVWMAyIimfyy1OLU0cKFjEgBqV1VD2NMWfTABMrhETS
 kTCUyGIKaimwFxHevc9wcwvp8p5TgiQ9herkVflDEZ8VN685vFipqlGYV6eNtLnv0OaY
 GMcfL1yoPY2DfxBlfYfU5sye9o1CUqQt3LaM8u9rgGrIn3Zgkwmg5NLYeJAWCHNmHXPG
 mqm3EFSMvmwWB2NTxygBspFDnYWO6z1D8KUrcAI0o78qQfbjZzHG3TVtIFtOFv+0eN3y
 8M6d57XdNOHy7N4JQzLDh+JFE52vpHH9KaYJCXuVv19BMsPMa9+FW0meJcOFXI3CUG6S
 u9lA==
X-Gm-Message-State: AOAM5325keNpUd2Oj+XtSsCFmgESg+UNUnWXKYmWbrAHpXiz70L1UxrM
 6eJkr66qhIudCEGuvYgb/8VlsV8V6fygbtkNcgUAXGu5u2AewMwQQsXmzJHV+AAFJjGV3qJJA9i
 g8Shz552iFIjvkkGczGrr+zhjx2JKN5eaeIf/5zl7GA==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr32277702wmk.25.1620220674944; 
 Wed, 05 May 2021 06:17:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznzW0sfSsf6GMPNX1ppZVMk3nl9+IxB31SmKuXCFiIEFbzLjLS3W1tcOolWD10Wc36ulvXeg==
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr32277671wmk.25.1620220674718; 
 Wed, 05 May 2021 06:17:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
 by smtp.gmail.com with ESMTPSA id
 v13sm20005354wrt.65.2021.05.05.06.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 06:17:54 -0700 (PDT)
Subject: Re: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
To: Michal Hocko <mhocko@suse.com>
References: <20210429122519.15183-1-david@redhat.com>
 <20210429122519.15183-4-david@redhat.com> <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0710d8d5-2608-aeed-10c7-50a272604d97@redhat.com>
Date: Wed, 5 May 2021 15:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJKZ5yXdl18m9YSM@dhcp22.suse.cz>
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

On 05.05.21 15:13, Michal Hocko wrote:
> On Thu 29-04-21 14:25:15, David Hildenbrand wrote:
>> Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
>> introduced page_is_poisoned(), however, v5 [1] of the patch used
>> "page_is_hwpoison()" and something went wrong while upstreaming. Rename the
>> function and move it to page-flags.h, from where it can be used in other
>> -- kcore -- context.
>>
>> Move the comment to the place where it belongs and simplify.
>>
>> [1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I do agree that being explicit about hwpoison is much better. Poisoned
> page can be also an unitialized one and I believe this is the reason why
> you are bringing that up.

I'm bringing it up because I want to reuse that function as state above :)

> 
> But you've made me look at d3378e86d182 and I am wondering whether this
> is really a valid patch. First of all it can leak a reference count
> AFAICS. Moreover it doesn't really fix anything because the page can be
> marked hwpoison right after the check is done. I do not think the race
> is feasible to be closed. So shouldn't we rather revert it?

I am not sure if we really care about races here that much here? I mean, 
essentially we are racing with HW breaking asynchronously. Just because 
we would be synchronizing with SetPageHWPoison() wouldn't mean we can 
stop HW from breaking.

Long story short, this should be good enough for the cases we actually 
can handle? What am I missing?

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
