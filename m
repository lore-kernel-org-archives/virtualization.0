Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64655C4743D
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 11:12:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E74A60FDA
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 11:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E74A60FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C58EC6088C;
	Tue,  8 Jun 2021 11:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nrrFnSrnksNf; Tue,  8 Jun 2021 11:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0068C606C5;
	Tue,  8 Jun 2021 11:12:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5216C000B;
	Tue,  8 Jun 2021 11:12:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0C40C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB02283BD1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:12:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ellerman.id.au
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tsDUcXPROzwE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:12:05 +0000 (UTC)
X-Greylist: delayed 00:21:25 by SQLgrey-1.8.0
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D30483BD6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:12:05 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Fznct061wz9sW7;
 Tue,  8 Jun 2021 21:11:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623150723;
 bh=h1pjcx14WED8GV61yyvX+o5nh/QO2vDigglGzaBUaPo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qaYxKhntxn9domJfTp/b7vZheGgvSG04qAi3oPZszcrG9xJ8L8BtLeFBDdkNbhfRZ
 X8AJHokX7Us9uk+OIikdyp8VwCVfcmpt0jHbXBsbfQ+HEwfgLRBxW3k7uXH4jT5QAg
 8xQpuppzCCGEv/fkG3Q1MEqEdqwDa3GgrXCwBwQ3bGGeK2M1OuWRxuc0qtkEr1keBz
 fDJQZ6qLeVUxjcpDY8AtdZZU3JvH1MC5Y3w/lLqHwiFCGx13AS18HU2Ir33OkNpg2k
 8GyFRxa0K5NYJybxWne97z3ZMcKKDCCW4J0WeaoO69Q+XrReDs4uvXduZSTclQX4ku
 hnEBus8PGkG1w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/12] mm/memory_hotplug: remove nid parameter from
 remove_memory() and friends
In-Reply-To: <20210607195430.48228-6-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-6-david@redhat.com>
Date: Tue, 08 Jun 2021 21:11:57 +1000
Message-ID: <87y2bkehky.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

David Hildenbrand <david@redhat.com> writes:
> There is only a single user remaining. We can simply try to offline all
> online nodes - which is fast, because we usually span pages and can skip
> such nodes right away.

That makes me slightly nervous, because our big powerpc boxes tend to
trip on these scaling issues before others.

But the spanned pages check is just:

void try_offline_node(int nid)
{
	pg_data_t *pgdat = NODE_DATA(nid);
        ...
	if (pgdat->node_spanned_pages)
		return;

So I guess that's pretty cheap, and it's only O(nodes), which should
never get that big.

> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Scott Cheloha <cheloha@linux.ibm.com>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-acpi@vger.kernel.org
> Cc: nvdimm@lists.linux.dev
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  .../platforms/pseries/hotplug-memory.c        |  9 ++++-----
>  drivers/acpi/acpi_memhotplug.c                |  7 +------
>  drivers/dax/kmem.c                            |  3 +--
>  drivers/virtio/virtio_mem.c                   |  4 ++--
>  include/linux/memory_hotplug.h                | 10 +++++-----
>  mm/memory_hotplug.c                           | 20 +++++++++----------
>  6 files changed, 23 insertions(+), 30 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 8377f1f7c78e..4a9232ddbefe 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -286,7 +286,7 @@ static int pseries_remove_memblock(unsigned long base, unsigned long memblock_si
>  {
>  	unsigned long block_sz, start_pfn;
>  	int sections_per_block;
> -	int i, nid;
> +	int i;
>  
>  	start_pfn = base >> PAGE_SHIFT;
>  
> @@ -297,10 +297,9 @@ static int pseries_remove_memblock(unsigned long base, unsigned long memblock_si
>  
>  	block_sz = pseries_memory_block_size();
>  	sections_per_block = block_sz / MIN_MEMORY_BLOCK_SIZE;
> -	nid = memory_add_physaddr_to_nid(base);
>  
>  	for (i = 0; i < sections_per_block; i++) {
> -		__remove_memory(nid, base, MIN_MEMORY_BLOCK_SIZE);
> +		__remove_memory(base, MIN_MEMORY_BLOCK_SIZE);
>  		base += MIN_MEMORY_BLOCK_SIZE;
>  	}
>  
> @@ -386,7 +385,7 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>  
>  	block_sz = pseries_memory_block_size();
>  
> -	__remove_memory(mem_block->nid, lmb->base_addr, block_sz);
> +	__remove_memory(lmb->base_addr, block_sz);
>  	put_device(&mem_block->dev);
>  
>  	/* Update memory regions for memory remove */
> @@ -638,7 +637,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>  
>  	rc = dlpar_online_lmb(lmb);
>  	if (rc) {
> -		__remove_memory(nid, lmb->base_addr, block_sz);
> +		__remove_memory(lmb->base_addr, block_sz);
>  		invalidate_lmb_associativity_index(lmb);
>  	} else {
>  		lmb->flags |= DRCONF_MEM_ASSIGNED;


Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
