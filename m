Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9223DFC99
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886975; cv=none; b=oCvpkkhIRFo6jGzCP0veN/Zq6pamktIffLhxE90y+qp8JsvIlFGqs6TCe+z+wJ1Z5tDXewAwEozAvc1ZGGv8Fld5PSu5GaP7seyj/SPsDoy8Pz07v3NBVWXV4XBwXeVRJqRUjl9Px5IygHmT+0T7CecMC7E/DqRuTdM0DVxSoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886975; c=relaxed/simple;
	bh=gvdKr9W+7SuAF8zO2+xjoJITGkqYa2TUeXRpC5BOa/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tlhNimATU2vZBwcQ37gR2nGa0LxMLJYzsBIGqP1cBKthhkEi34v6dQg+UvA1uzHoXJsZmd24DXUaRCUiXr2VA5StQTtn0dD23rCcWg807tq6IyfCJodqztUJTMQ+Us8+f81exZdXNkd0aniehmw7gaQ3CQN6TQt2+iXaTb5BRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=idpjCUm+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idpjCUm+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784886969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oRn4RqvNJ/sf4Akhf565cpp2IaOA/zWXYW4oXT+cWNs=;
	b=idpjCUm+lkWasUk69tpF4JavklFUVJ4A3mUqhRvTvN4eoqqlM/+bQ2WCkhXovdxPsz+zRg
	xb02NTu66cVXArJBQUYA/GCgxBs071SpULP+Vd3oFWZdd5zkPCcehsgdepvhzf5do/60Dn
	JW4CVibMW705k3sF4iYGGsYvPYRSGsI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-WH_8AQCePtmsr1fvUNEjCg-1; Fri, 24 Jul 2026 05:56:07 -0400
X-MC-Unique: WH_8AQCePtmsr1fvUNEjCg-1
X-Mimecast-MFC-AGG-ID: WH_8AQCePtmsr1fvUNEjCg_1784886967
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f2de3ba47so184016f8f.1
        for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 02:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886967; x=1785491767;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRn4RqvNJ/sf4Akhf565cpp2IaOA/zWXYW4oXT+cWNs=;
        b=R73qhTxBKEOAr+GjAyybDbaRqfFiR05yfjPPziB5DuOnKyam5MdnGX51es632xZ+Ih
         U6r1hPpOG9Ehvi3l2HfCge7Musrk7enpKd1EzSYApv/IAythf+sQTrm0HNKAemcvWzmT
         LUVks+gCHVP1jKd4aT+w/zEywRIfisPkuqxOuWLcujoxaV1hbKpv8uUyIdgcHan8V502
         lBOt/DR+RqWxC6EvICl38LjscS+bXNneoXlmfJmmw6z+Gx9nJ+PRDYAImvWimdfyAgho
         Hxzz5y5Ur7EPKjmRHrK5GZ6Y8tbV5s8rV9IZ7qbB+v0EvNNkUOb33m0Dy1tXRfBZ3UNw
         I0Kg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2Ej12sfRw8SVMG2OJelPJlgLY7JpgQ+OBpDR+SpQLxhf04SeYdV8BHEdBYJOL2nncoHo4ppuEAiIpaJJPWQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4BTpIzF19qEWebtQc59O7R6PiGvEQiArawLgP/XjtRxncmIaf
	csHj/X9PyZgp2gah81ZD5OtkCAVqDX/+oq4h69vViOiV2Qm8Dar0G1fQRNde5STM/C8QEIH85X0
	xJ68X6gZZmzdyJkybowS4BE8jdl00V9g/p7TJdEYuNj4kthqX4QCwVMefMgU/dBzn6TuUFlShA8
	1g
X-Gm-Gg: AR+sD10axvI2tIs3RxeKg/wPtkuweYTH/rC7jjOcsPd+236V4GqzcDAqHGi0+zDWzQ3
	j0dEhQLiYm01q3n7X8gtsmlgVOLk33uSdIVUW+qokKppe9/E7eN/iuIcUJ493S6rNCQfeIn027N
	KjyaF0iUZ+w/p/29dLVjvdKzv42+VvbOYe/LIH8FwU9SQZbQqSV0EXorSYuJZmSbkIHO1PVH4UW
	j3FCtQ2+DF8CVDwIDSQvJE9S7fIRHuhofPhEwSUQgZjdppveqx8tukrKcOQB3/Q4amuvzb2o9zg
	cNUZyK6Q20RBCmhroZhEwl+aNULeueT+Ys6n0D/lo/VyBz5JxopULmax240s427c0B3ujjq7ZSO
	ARsN84DyQXt6jDMRv/+CLGA==
X-Received: by 2002:a5d:64c3:0:b0:47f:838c:4256 with SMTP id ffacd0b85a97d-47f8d71c7f5mr9083814f8f.16.1784886966615;
        Fri, 24 Jul 2026 02:56:06 -0700 (PDT)
X-Received: by 2002:a5d:64c3:0:b0:47f:838c:4256 with SMTP id ffacd0b85a97d-47f8d71c7f5mr9083766f8f.16.1784886966040;
        Fri, 24 Jul 2026 02:56:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm21269614f8f.29.2026.07.24.02.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:56:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:56:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH 1/3] hw/virtio: Optimize vhost_log_sync_range to avoid
 N^2 complexity
Message-ID: <20260724055156-mutt-send-email-mst@kernel.org>
References: <20260724093750.810018-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724093750.810018-1-xiongwm2026@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _L_H1O6CtGAjp6ANOm0ZRsHTBPFsuoa6Alz3He-h-LQ_1784886967
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 05:37:50PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The vhost_log_sync_range() function iterates through all memory sections
> for each call, resulting in O(N^2) complexity when syncing dirty
> bitmaps. This is inefficient for guests with many memory sections.
> 
> Optimize this by:
> 1. Checking if a section overlaps with [first, last] range before
>    calling vhost_sync_dirty_bitmap()
> 2. Early exit when section starts beyond the requested range

As any optimization, I expect actual perf measurements
showing an improvement to be included please.

> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  hw/virtio/vhost.c | 18 +++++++++++++++--
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -280,11 +280,21 @@ static void vhost_log_sync(MemoryListener *listener,
>  static void vhost_log_sync_range(struct vhost_dev *dev,
>                                   hwaddr first, hwaddr last)
>  {
> -    int i;
> -    /* FIXME: this is N^2 in number of sections */
> -    for (i = 0; i < dev->n_mem_sections; ++i) {
> -        MemoryRegionSection *section = &dev->mem_sections[i];
> -        vhost_sync_dirty_bitmap(dev, section, first, last);
> +    int i, j;
> +    bool section_dirty = false;
> +
> +    for (i = 0; i < dev->n_mem_sections; ++i) {
> +        MemoryRegionSection *section = &dev->mem_sections[i];
> +        hwaddr section_start, section_end;
> +
> +        /* Skip sections that don't overlap with [first, last] */
> +        section_start = section->offset_within_address_space;
> +        section_end = section_start + int128_get64(section->size) - 1;
> +
> +        if (section_end < first || section_start > last) {
> +            continue;
> +        }
> +
> +        vhost_sync_dirty_bitmap(dev, section, first, last);


So it is still O(N^2) right? It just skips calling it for
some sections.

>      }
>  }
>  

