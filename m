Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A294C47095
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 10:05:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4518A610C7
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 10:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4518A610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 096C0404E5;
	Wed,  9 Jun 2021 10:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7aMd6NmTZgH; Wed,  9 Jun 2021 10:05:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5273D40218;
	Wed,  9 Jun 2021 10:05:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 269C0C000E;
	Wed,  9 Jun 2021 10:05:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0244CC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 10:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF35C403A8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 10:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Es7qfFJtKu2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 10:05:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 983EA40388
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 10:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623233115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RHwERDV3Ik2w6kA7FU7L2RqGuM08Lzd2/FD6Wyr2HFk=;
 b=OKF0Pu3YGkBZJDNm+EeNVM3hL/Z5lMjWEc9ddTK7nxB1rSGR3/K5KmzGXy5rRxzTLVci/G
 o6i0yPksO3Gfvxh3Fa/4LGQgOTfkgB0pq3LokmNM/jcnHASdZOpzOGhTy4bh1/AO7HCK2n
 FzNBa10snN6upxIxjsXnySg8BFBsxN8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-2P3G5QMwMhuxhQcDIkun1g-1; Wed, 09 Jun 2021 06:05:05 -0400
X-MC-Unique: 2P3G5QMwMhuxhQcDIkun1g-1
Received: by mail-wr1-f72.google.com with SMTP id
 r17-20020a5d52d10000b0290119976473fcso8353544wrv.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 03:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RHwERDV3Ik2w6kA7FU7L2RqGuM08Lzd2/FD6Wyr2HFk=;
 b=bq+msUHlhFSrcrP5mCS4gtfU2BN2dCJEWm2HdOcurYLQPG89SrcjvAmC58dGAnFzNM
 cXL/Ky7pYCR0WZQhkhsigfYz8d+zFPJDCLp85/SNIpXvoKWvMwpM8H/VDZGwxm4htwED
 DmEnwPufXCbEt+8MJGNixkdh9XmS1eMbsbsY/55wdAM4cYoA5muV/0f9S61C83xe1n1y
 R5wrKJ+Ofed7zp5lPcT7+QX5kt8RI29kXeVFPVviFHvPmTHDXDBDAUoouDPHjEZYuMEF
 /Tn2IfIvPQcRkEbRpoaGpLZqOcf/Q7r9ibcJhL5pjhGwZSFseL6CH0rz1fOJzDoRIjUU
 3lEg==
X-Gm-Message-State: AOAM531PZ/LYJ/ymUsemuJYGX6gBaqdKKDrNdP4gqLLFXISWQwjHlchp
 IZHBiG14pT1wvytST28p2JS8SRFPDOvp8au/uJ9nb38Cg1TKc2lbCbv2C01SzSRihAIS3gf5OEW
 oeqgvDcKexPgxyiKgYS30shOYmRGcqRslL8RfFhHSHw==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr26997704wrk.216.1623233103791; 
 Wed, 09 Jun 2021 03:05:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxisdlmQ9hbEJc7XyIIogfmbAP40COfOWXq53QTDVV5O2yA236wwdWl7PrbHqWMhmbVzLyEcw==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr26997662wrk.216.1623233103520; 
 Wed, 09 Jun 2021 03:05:03 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
 by smtp.gmail.com with ESMTPSA id
 l31sm9209629wms.31.2021.06.09.03.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 03:05:03 -0700 (PDT)
Subject: Re: [PATCH v1 05/12] mm/memory_hotplug: remove nid parameter from
 remove_memory() and friends
From: David Hildenbrand <david@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-6-david@redhat.com> <87y2bkehky.fsf@mpe.ellerman.id.au>
 <7463b3ed-07d3-7157-629d-a85a3ff558d6@redhat.com>
Organization: Red Hat
Message-ID: <fe3e8d93-4e69-84c5-3dd3-ab4aca3317ab@redhat.com>
Date: Wed, 9 Jun 2021 12:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7463b3ed-07d3-7157-629d-a85a3ff558d6@redhat.com>
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

On 08.06.21 13:18, David Hildenbrand wrote:
> On 08.06.21 13:11, Michael Ellerman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>> There is only a single user remaining. We can simply try to offline all
>>> online nodes - which is fast, because we usually span pages and can skip
>>> such nodes right away.
>>
>> That makes me slightly nervous, because our big powerpc boxes tend to
>> trip on these scaling issues before others.
>>
>> But the spanned pages check is just:
>>
>> void try_offline_node(int nid)
>> {
>> 	pg_data_t *pgdat = NODE_DATA(nid);
>>           ...
>> 	if (pgdat->node_spanned_pages)
>> 		return;
>>
>> So I guess that's pretty cheap, and it's only O(nodes), which should
>> never get that big.
> 
> Exactly. And if it does turn out to be a problem, we can walk all memory
> blocks before removing them, collecting the nid(s).
> 

I might just do the following on top:

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 61bff8f3bfb1..bbc26fdac364 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2176,7 +2176,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
  static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
  {
         int ret = !is_memblock_offlined(mem);
+       int *nid = arg;
  
+       *nid = mem->nid;
         if (unlikely(ret)) {
                 phys_addr_t beginpa, endpa;
  
@@ -2271,10 +2273,10 @@ EXPORT_SYMBOL(try_offline_node);
  
  static int __ref try_remove_memory(u64 start, u64 size)
  {
-       int rc = 0, nid;
         struct vmem_altmap mhp_altmap = {};
         struct vmem_altmap *altmap = NULL;
         unsigned long nr_vmemmap_pages;
+       int rc = 0, nid = NUMA_NO_NODE;
  
         BUG_ON(check_hotplug_memory_range(start, size));
  
@@ -2282,8 +2284,12 @@ static int __ref try_remove_memory(u64 start, u64 size)
          * All memory blocks must be offlined before removing memory.  Check
          * whether all memory blocks in question are offline and return error
          * if this is not the case.
+        *
+        * While at it, determine the nid. Note that if we'd have mixed nodes,
+        * we'd only try to offline the last determined one -- which is good
+        * enough for the cases we care about.
          */
-       rc = walk_memory_blocks(start, size, NULL, check_memblock_offlined_cb);
+       rc = walk_memory_blocks(start, size, &nid, check_memblock_offlined_cb);
         if (rc)
                 return rc;
  
@@ -2332,7 +2338,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
  
         release_mem_region_adjustable(start, size);
  
-       for_each_online_node(nid)
+       if (nid != NUMA_NO_NODE)
                 try_offline_node(nid);
  
         mem_hotplug_done();



-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
