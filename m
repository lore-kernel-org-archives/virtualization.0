Return-Path: <SRS0=nkKT=LC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05DBC47082
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A8A6124C
	for <virtualization@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A8A6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 765C440453;
	Tue,  8 Jun 2021 12:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPVm9IE4QH9A; Tue,  8 Jun 2021 12:20:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D60754044C;
	Tue,  8 Jun 2021 12:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A915FC000D;
	Tue,  8 Jun 2021 12:20:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C4D4C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3996C402B0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H0ykpatG4cAu
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A17D400C8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:20:52 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 v27-20020a056830091bb02903cd67d40070so17016634ott.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 05:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aBvx0tMqvnsqasRMwdIjV828Q4KMfEaGuv9isdIMh6w=;
 b=hlcDW9J8z/nVX4ecouWcizuCfKdF9OgLl717Zp/2MEkXf13KiFA991GhywyfNJpLNu
 DRQjkkPb5fud2ZMLEaoKqC/WRYSuVSpslQpPU+pi529nZ0bSOTM8qlMQ+eunvm05N3kW
 wprRhMUFw8jclKXRhj1OMi6WnOKmUmKgpwyfS2dNdgIh9uZkD8+xLtdZBdmDSHN08RqR
 PwnxUrYEaNvC5ovb/jBo8mOJzWyBWSbqVH70uJzIQw6MZFNaOzt3vkeQ1Nc7nR7kS3Un
 juUMOSLlxamUDNNIwR59ZXIlBnI8ie/5qk0foEGaxBG5ThiFizVMOP4tIyzyj6Kqnzy6
 R+4w==
X-Gm-Message-State: AOAM531EzoyN/lCAvn6FTnFxgSFbFvYrVUwz2+mE0OJENpN704K1aqiV
 6UbfNzu2uCjmPm09WnElWjVG82vz9wEy3LIPENk=
X-Google-Smtp-Source: ABdhPJxH/dWUiK6LlZLSUta/Ys0v09YjScxWXuTxxpG59lqd7H1n1RYtnEYQbcCaesHEWVw7jYVneuift9/T5XVCqBA=
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr18583145otl.206.1623154851653; 
 Tue, 08 Jun 2021 05:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210607195430.48228-1-david@redhat.com>
 <20210607195430.48228-10-david@redhat.com>
In-Reply-To: <20210607195430.48228-10-david@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Jun 2021 14:20:40 +0200
Message-ID: <CAJZ5v0is=8897cneU7VwfV-HRpqAk=CU0833xyyxKjDZfJPHMw@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] ACPI: memhotplug: use a single static memory
 group for a single memory device
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
> Let's group all memory we add for a single memory device - we want a
> single node for that (which also seems to be the sane thing to do).
>
> We won't care for now about memory that was already added to the system
> (e.g., via e820) -- usually *all* memory of a memory device was already
> added and we'll fail acpi_memory_enable_device().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_memhotplug.c | 35 +++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index eb4faf7c5cad..0c7b062c0e5d 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -54,6 +54,7 @@ struct acpi_memory_info {
>  struct acpi_memory_device {
>         struct acpi_device *device;
>         struct list_head res_list;
> +       int mgid;
>  };
>
>  static acpi_status
> @@ -171,10 +172,31 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>         acpi_handle handle = mem_device->device->handle;
>         int result, num_enabled = 0;
>         struct acpi_memory_info *info;
> -       mhp_t mhp_flags = MHP_NONE;
> -       int node;
> +       mhp_t mhp_flags = MHP_NID_IS_MGID;
> +       u64 total_length = 0;
> +       int node, mgid;
>
>         node = acpi_get_node(handle);
> +
> +       list_for_each_entry(info, &mem_device->res_list, list) {
> +               if (!info->length)
> +                       continue;
> +               /* We want a single node for the whole memory group */
> +               if (node < 0)
> +                       node = memory_add_physaddr_to_nid(info->start_addr);
> +               total_length += info->length;
> +       }
> +
> +       if (!total_length) {
> +               dev_err(&mem_device->device->dev, "device is empty\n");
> +               return -EINVAL;
> +       }
> +
> +       mgid = register_static_memory_group(node, PFN_UP(total_length));
> +       if (mgid < 0)
> +               return mgid;
> +       mem_device->mgid = mgid;
> +
>         /*
>          * Tell the VM there is more memory here...
>          * Note: Assume that this function returns zero on success
> @@ -188,12 +210,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>                  */
>                 if (!info->length)
>                         continue;
> -               if (node < 0)
> -                       node = memory_add_physaddr_to_nid(info->start_addr);
>
>                 if (mhp_supports_memmap_on_memory(info->length))
>                         mhp_flags |= MHP_MEMMAP_ON_MEMORY;
> -               result = __add_memory(node, info->start_addr, info->length,
> +               result = __add_memory(mgid, info->start_addr, info->length,
>                                       mhp_flags);
>
>                 /*
> @@ -253,6 +273,10 @@ static void acpi_memory_device_free(struct acpi_memory_device *mem_device)
>         if (!mem_device)
>                 return;
>
> +       /* In case we succeeded adding *some* memory, unregistering fails. */
> +       if (mem_device->mgid >= 0)
> +               unregister_memory_group(mem_device->mgid);
> +
>         acpi_memory_free_device_resources(mem_device);
>         mem_device->device->driver_data = NULL;
>         kfree(mem_device);
> @@ -273,6 +297,7 @@ static int acpi_memory_device_add(struct acpi_device *device,
>
>         INIT_LIST_HEAD(&mem_device->res_list);
>         mem_device->device = device;
> +       mem_device->mgid = -1;
>         sprintf(acpi_device_name(device), "%s", ACPI_MEMORY_DEVICE_NAME);
>         sprintf(acpi_device_class(device), "%s", ACPI_MEMORY_DEVICE_CLASS);
>         device->driver_data = mem_device;
> --
> 2.31.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
