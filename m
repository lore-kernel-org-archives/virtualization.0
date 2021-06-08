Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE5EC4743E
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 11:19:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473BE61008
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 11:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473BE61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F13194041C;
	Tue,  8 Jun 2021 11:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id utNrmyq63dbq; Tue,  8 Jun 2021 11:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18D4740425;
	Tue,  8 Jun 2021 11:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E48F8C000B;
	Tue,  8 Jun 2021 11:19:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB42DC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94C6B402CF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LHjtS8AomFsn
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E99F400D0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623151140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBLtrFhiRKeFc7Q7qn/8AZzS8tEb5Usg8INInZ6WYCs=;
 b=NCgNublPpUc65Nv9VMJ1ZXh7G8ulTDOg+GeMHxs5AdLA5wdvFcVbC1riX+BPiVNsB1FrsM
 bnC+0xwjq5QRyorxATrmLJeJ+9atPcJONYGUkeK4ty51NCsaD10GHwoNsQYLa0rZLMLaHb
 stXbO8E4RkU/aCKdNnYhnSeQhE4W4a0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-I0nXD3VeMxiiyu3gv_Jd3g-1; Tue, 08 Jun 2021 07:18:58 -0400
X-MC-Unique: I0nXD3VeMxiiyu3gv_Jd3g-1
Received: by mail-wr1-f70.google.com with SMTP id
 f22-20020a5d58f60000b029011634e39889so9272464wrd.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 04:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=CBLtrFhiRKeFc7Q7qn/8AZzS8tEb5Usg8INInZ6WYCs=;
 b=ul91tzYaxXRg9/B5QCE0V0GNCBos2taEUdy6S+9jfj78scpwl6+kWQT67ccJ8g1k0a
 MYYkv0828TKzcBANftDJ43T60frjrpvMrCcW2JIMJsK0QzlRU0aNfEwGpdkYqwNMzJPR
 FPp/vik40W0fOlr3Ca9XfT/KKZoLgVJYszjLbHjsScsiuqilTRY8LPaaBHiN3HRPkgQQ
 82U5zFv3J2CPA3XAlvbLWoEvVi3JHuPDOuPCpbYiMCdcU02o18xeXQ0pvKF0s+fASAtf
 7sKtgNUr8K0NOAYiG3eOMj9T1nVn782qGtj01AvXhGUCPFx5RqabA+OQgTftVhBFbO5+
 b8zw==
X-Gm-Message-State: AOAM5314Srrv16oYEJTsdAorgIV523SvAQJvANzW7fgHGSQaw/YODzu8
 vjssc5P186cFsjiljTwM79Id6gSiQAb2Mx2/Qgu+1rF/tc8HX3XwXT34C2MUugV5igmVNL8uQDW
 vDVrJXvJwaO+RdA3cXGIQRjKqVctPVh976GinqH57GA==
X-Received: by 2002:adf:df86:: with SMTP id z6mr22061231wrl.255.1623151137733; 
 Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrB9z1bqXKLNgH1xZgLenFDxAm/18wrzcUUIce09tn+BporQC3UeSbXcvGrkz4TceLSHiMMw==
X-Received: by 2002:adf:df86:: with SMTP id z6mr22061199wrl.255.1623151137577; 
 Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61cf.dip0.t-ipconnect.de. [91.12.97.207])
 by smtp.gmail.com with ESMTPSA id
 u2sm19236473wrn.38.2021.06.08.04.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 04:18:57 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] mm/memory_hotplug: remove nid parameter from
 remove_memory() and friends
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-6-david@redhat.com> <87y2bkehky.fsf@mpe.ellerman.id.au>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <7463b3ed-07d3-7157-629d-a85a3ff558d6@redhat.com>
Date: Tue, 8 Jun 2021 13:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87y2bkehky.fsf@mpe.ellerman.id.au>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: nvdimm@lists.linux.dev, Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Laurent Dufour <ldufour@linux.ibm.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-acpi@vger.kernel.org, Anton Blanchard <anton@ozlabs.org>,
 Len Brown <lenb@kernel.org>, Nathan Lynch <nathanl@linux.ibm.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Scott Cheloha <cheloha@linux.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Hui Zhu <teawater@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Marek Kedzierski <mkedzier@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

On 08.06.21 13:11, Michael Ellerman wrote:
> David Hildenbrand <david@redhat.com> writes:
>> There is only a single user remaining. We can simply try to offline all
>> online nodes - which is fast, because we usually span pages and can skip
>> such nodes right away.
> 
> That makes me slightly nervous, because our big powerpc boxes tend to
> trip on these scaling issues before others.
> 
> But the spanned pages check is just:
> 
> void try_offline_node(int nid)
> {
> 	pg_data_t *pgdat = NODE_DATA(nid);
>          ...
> 	if (pgdat->node_spanned_pages)
> 		return;
> 
> So I guess that's pretty cheap, and it's only O(nodes), which should
> never get that big.

Exactly. And if it does turn out to be a problem, we can walk all memory 
blocks before removing them, collecting the nid(s).

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
