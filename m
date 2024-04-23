Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA921345
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863641; cv=none; b=WH9nqesDxVXkTmnold4bf/nxpK7gCMz3x9qrB7MoQSiYuaW6ZH1PGPnxLsCan6Lz6G0GZ+e29RVjdQGjavqM0Lk/yLPkd8nXNOkl/cjQntf0KLexIpKn71vz+XctaVkR3viCPhOfDGb5df9fnIAxheHGdSIgcf+xQv633lZ6ed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863641; c=relaxed/simple;
	bh=+HYC9r8wTCRmGIBMgAS0O5zj7Qmlb2jFg4GebaRKIp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FP6DDPPgR0IUXfRYA2bIRwvlkTCjixHcUCNS9eKY4GyIZ/8Q8JFDoHqG6NayagGH39JYJVt3PtMLwe0SKImrhDlworaW/+V3Yekm+ngQE2qqdfYJWyEfQgqaAtfOOXeBeyOsNKW22ymmuAqhIKBkVohKP9MObViT8E1g2QXkGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWiYY/s3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWiYY/s3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713863638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1xckAbIaUxfV2U1fI0YjievZgsT18mecVG8rOgbjUb8=;
	b=CWiYY/s36hHtEL67Bm+5EWyU+LCfEG1UpfLWnEVIbXz0KuWAko7PgPVD3dk4UJWqNe6Cy8
	pipte2Mok/ZysRZpH8n9oy09LCjzYr+mUm9XpGEmOY9faaMhPiWTv3NELmf1vqiUg0UCrj
	XVldl4laWxKDdJksranNVMNeFhmUpjQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-6kq0LUnTMhSl7D6FCB9AQw-1; Tue, 23 Apr 2024 05:13:56 -0400
X-MC-Unique: 6kq0LUnTMhSl7D6FCB9AQw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34a4ded7d49so4635687f8f.1
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 02:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713863635; x=1714468435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xckAbIaUxfV2U1fI0YjievZgsT18mecVG8rOgbjUb8=;
        b=wZT0fB6Hdr5mhK4O1dE1/6VqDclLSKYS/kM6lCkwokGqzOlRhZB4830DhRuuxktFbS
         bKyDlQ6luoVLoVqJ9SVz3Zgjyqk5owOkpbeFeQdAAUcpXrCCd/c5yH0fcXIC3RJVvFaS
         AEHm21n4MYo/LUvKfRiLlQEu59pyNcQKQMO1QTyzuVZ5few/7PLdvtBoN8PL/yBh1Nyc
         FjYmg8rag96vQhc0HbnA+ODt+m525H8mfk8dGNqijzUnWrVqhbNOnPrwWlHpiNBuPiVn
         Mycggl16vWxvBp2+bnTc/BvFN+4eW0T+ZqCEdYP0EaDDwDYD99YrPytJsqr7kNi/B0rg
         L+8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7xHntB8uoGoMB7h8UFbd/CHQ7GC+W2Ug0p+jyQxGFnHzGtUbK9dO8jYMr25Rfl47cXUvdg9TG1kMA6rtHI+CeAAvdq5URBDrzXQYimZ4=
X-Gm-Message-State: AOJu0YykJBQOY3azevX8E2bhtPr/MYUU2XzS28rzlk4fY4wjvLKOrjz2
	PeB6vJs75s0+OyzGSqwVii67JwiDjL3VrD/D3gwSRcvvw4Mp8DoV7iz6KwCUn5yNoeztoiO4Trh
	OfWKoCqpVAKVMhZe3cqIHGjnZMtDxz9MRpE0AjbP3iIweZTMKpivHF1BkOyK+2Lod
X-Received: by 2002:a5d:6d8d:0:b0:343:f335:2489 with SMTP id l13-20020a5d6d8d000000b00343f3352489mr9334361wrs.59.1713863635399;
        Tue, 23 Apr 2024 02:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrpMdpbG8FFAw85brCrIe+xZ/QGNjBiBptgCa0RJlLmPxE7ErKfP7eMNOPOzyyRh2eNOA1Bg==
X-Received: by 2002:a5d:6d8d:0:b0:343:f335:2489 with SMTP id l13-20020a5d6d8d000000b00343f3352489mr9334339wrs.59.1713863634871;
        Tue, 23 Apr 2024 02:13:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id z2-20020adff742000000b00343ca138924sm14071319wrp.39.2024.04.23.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:13:53 -0700 (PDT)
Date: Tue, 23 Apr 2024 05:13:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, david@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH v3 2/4] virtio_balloon: introduce oom-kill invocations
Message-ID: <20240423051151-mutt-send-email-mst@kernel.org>
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
 <20240423034109.1552866-3-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240423034109.1552866-3-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2024 at 11:41:07AM +0800, zhenwei pi wrote:
> When the guest OS runs under critical memory pressure, the guest
> starts to kill processes. A guest monitor agent may scan 'oom_kill'
> from /proc/vmstat, and reports the OOM KILL event. However, the agent
> may be killed and we will loss this critical event(and the later
> events).
> 
> For now we can also grep for magic words in guest kernel log from host
> side. Rather than this unstable way, virtio balloon reports OOM-KILL
> invocations instead.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/virtio/virtio_balloon.c     | 1 +
>  include/uapi/linux/virtio_balloon.h | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1710e3098ecd..f7a47eaa0936 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -330,6 +330,7 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
>  		    pages_to_bytes(events[PSWPOUT]));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index ddaa45e723c4..b17bbe033697 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -71,7 +71,8 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
>  #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
>  #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
> -#define VIRTIO_BALLOON_S_NR       10
> +#define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
> +#define VIRTIO_BALLOON_S_NR       11
>  
>  #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>  	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \

Looks like a useful extension. But
any UAPI extension has to go to virtio spec first.

> @@ -83,7 +84,8 @@ struct virtio_balloon_config {
>  	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
>  	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>  	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
>  }
>  
>  #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
> -- 
> 2.34.1

