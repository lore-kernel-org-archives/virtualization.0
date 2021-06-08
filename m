Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A37C47082
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2850661352
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2850661352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1D746061A;
	Tue,  8 Jun 2021 12:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JCbOegpq3I0P; Tue,  8 Jun 2021 12:20:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 901C060692;
	Tue,  8 Jun 2021 12:20:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61C97C000D;
	Tue,  8 Jun 2021 12:20:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F8FFC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 629DC839CD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vziysgVfyznw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C95CA82B3E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:36 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id t140so16074449oih.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 05:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OmTdNAirSU2hkyrUMU+ARQjy6bvUlpwnEGNeFoKbjA8=;
 b=O01/kDPihdnAPcVUrc2NsqLr+CfIbjKets1Ju4OAtkjJ4i1lwGeNFpa7XIZ2GPmV+G
 sTVJQXIBHTdr4pYXeqeXTFKHJJCtVIrotInl8pP3I/nx/pNSso/n11/ha/PT0rLPe+4k
 4cYqeUsNJSXUKpc6JyObYVjYjBMA25NCKKTQVYsxfgiP70YWrpT70w/yOZK+hXnF9wqC
 wmP+EMlnYR0LAeVVB9pJzsfpoPR9A9o1SsKOxzwifq3SUkG0TuO064XurkUzcB92CSnE
 /AgfQX9FoWgwxgrs7R8YBNFoBy9MGqbuV66iqPBXABtEk6I0sGnk/vKMgOZM409do4W7
 GuPg==
X-Gm-Message-State: AOAM530gsYkcWK6emiFBJw2+XO9J1Weke/rmLO4bgb9oKL0YG7ji4BlA
 jkYcCV+pS2XWXpqcs3pr1/0nkzh1LuczcF4khXA=
X-Google-Smtp-Source: ABdhPJzGnwuhGOuzkrFQmGHEbYgJZPCAHMUb8TTYp305sD+8WsA0diJEPnVIIf53jR51n274a7P1CxE1tcKsGbw4YpI=
X-Received: by 2002:aca:b406:: with SMTP id d6mr2621167oif.71.1623154835851;
 Tue, 08 Jun 2021 05:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-9-david@redhat.com>
In-Reply-To: <20210607195430.48228-9-david@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jun 2021 14:20:24 +0200
Message-ID: <CAJZ5v0gnT6QSkhcgPbHOXm8_zRQrefkdZk3k3_Ne5XCqoAGguA@mail.gmail.com>
Subject: Re: [PATCH v1 08/12] ACPI: memhotplug: memory resources cannot be
 enabled yet
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Len Brown <lenb@kernel.org>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Hui Zhu <teawater@gmail.com>, Marek Kedzierski <mkedzier@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jun 7, 2021 at 9:55 PM David Hildenbrand <david@redhat.com> wrote:
>
> We allocate + initialize everything from scratch. In case enabling the
> device fails, we free all memory resourcs.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_memhotplug.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 1d01d9414c40..eb4faf7c5cad 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -182,10 +182,6 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>          * (i.e. memory-hot-remove function)
>          */
>         list_for_each_entry(info, &mem_device->res_list, list) {
> -               if (info->enabled) { /* just sanity check...*/
> -                       num_enabled++;
> -                       continue;
> -               }
>                 /*
>                  * If the memory block size is zero, please ignore it.
>                  * Don't try to do the following memory hotplug flowchart.
> --
> 2.31.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
