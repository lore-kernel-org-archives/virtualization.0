Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1912C433FE
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:38:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5656E6140D
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 08:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5656E6140D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 11A6A401CC;
	Wed, 29 Sep 2021 08:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8WvuVGcq0Fyf; Wed, 29 Sep 2021 08:38:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6F301400B5;
	Wed, 29 Sep 2021 08:38:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 421A9C000F;
	Wed, 29 Sep 2021 08:38:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B14FC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5D21826A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0wDrwRddklg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:38:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54B0282D0C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632904686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rI4ipp+6p4YsURf5SVEvaXl3JhZmp49Hm7auACiD3c=;
 b=aGLrO075h6l3SS3vaxgxVQnxc2Iiq769tmBx4DHpw4NwRJHV7cCacdPyCn60njuSE25/5L
 G4sP1Ih58rehmC0nGcr3ZAXQgsBluyZy8dp+YYGOZuyG3Ji0MeP511BweWTebKedGUY+8d
 z80i/pyvyx2H224CBudR2P9R0VUSyYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-TKbS9uqIMAq28YcM3c7W4Q-1; Wed, 29 Sep 2021 04:38:04 -0400
X-MC-Unique: TKbS9uqIMAq28YcM3c7W4Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 b139-20020a1c8091000000b002fb33c467c8so874072wmd.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=/rI4ipp+6p4YsURf5SVEvaXl3JhZmp49Hm7auACiD3c=;
 b=D4Qolj+Rjor4O2UUrWYcCeQjlFQpdDG4oTYRrQutAvXZs/RD2qiIcNhXRy4dtXrfkE
 U8CdCjN00rR5J+6VTzNiP08Jk/EvAMFinDtyYvvHRJY+8XKbOXW7GCJYThc12xYPD03A
 VKkV7gr7GRk29SPSJVst+fvif7PflMruh/TSZvHBqXzD8hxtoLLj5PK+JEpY4YpO1CLw
 MCxeTJqC2Ls4YGKIeZXX8kqWpLdcg+vEY02yqqpQ0o4t8slzgEZhuF6Gupu5UYG4+9B0
 RtaNvfpDeabZkMz7kzy8gf76DNdDwZulkNoPFrb0J6eWh+OzQJPN0tZR1L5qcw458TZr
 Hfiw==
X-Gm-Message-State: AOAM532lizOygYQXJ1E9ORoaBO5uhO+BwXb47RcAwbiu0OwktkzEWIyJ
 JgJ4gkHhtfm23AGb4knnERLUClc0mi8hKJpXvDbB20yhmrL/5opK9wTH6+O3DI654SoZ4QTRx3R
 JDSpn3jbXnRTshD45XQhzVeNHjabTqU5xTO6/j63syA==
X-Received: by 2002:a05:600c:3652:: with SMTP id
 y18mr8982010wmq.66.1632904683468; 
 Wed, 29 Sep 2021 01:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1UYD13jo4zi2cV8ML8JLWg6MbDn1wfsjZAud8HZY/udqsA+Bzs8BSxqVjAL69LYYlXkKLHw==
X-Received: by 2002:a05:600c:3652:: with SMTP id
 y18mr8981980wmq.66.1632904683305; 
 Wed, 29 Sep 2021 01:38:03 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
 by smtp.gmail.com with ESMTPSA id
 f17sm1497220wrm.83.2021.09.29.01.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 01:38:02 -0700 (PDT)
Subject: Re: [PATCH v1 8/8] virtio-mem: kdump mode to sanitize /proc/vmcore
 access
To: linux-kernel@vger.kernel.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-9-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e01cdc7f-cda8-3268-c971-1255a71fb8ac@redhat.com>
Date: Wed, 29 Sep 2021 10:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928182258.12451-9-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 x86@kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Baoquan He <bhe@redhat.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Oscar Salvador <osalvador@suse.de>, Juergen Gross <jgross@suse.com>,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
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

[...]

> +
> +static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
> +					 unsigned long pfn)
> +{
> +	struct virtio_mem *vm = container_of(cb, struct virtio_mem,
> +					     vmcore_cb);
> +	uint64_t addr = PFN_PHYS(pfn);
> +	bool is_ram;
> +	int rc;
> +
> +	if (!virtio_mem_contains_range(vm, addr, addr + PAGE_SIZE))

Some more testing revealed that this has to be

if (!virtio_mem_contains_range(vm, addr, PAGE_SIZE))


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
