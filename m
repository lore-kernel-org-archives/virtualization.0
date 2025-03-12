Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEF1E7C05
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762632; cv=none; b=Voqk8D0WJQmp3bGivjWQSr4GpHtEWrGf5fTYPdm6XNES6t9e4ElGkL+tsaIvlZCanmS1kmzTkkc2iI+ptoTRnQ3cN1TUi0tp+iHwXgy3fiO3pUAcwtGCHmZh5OUfdU6+5xvYCu/03TixP7qBjKsrwZbWoKaP/0/VW4qRqujVZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762632; c=relaxed/simple;
	bh=CGj6X8im0j6eyvz1ZiOGqKpsN+vOoTYaN9QnyzioSZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sObrZ5V/8gMFgJz2QumB47/fLYD05DjemD9USjce8EF4kCXqH+WNTGO+2iV/8yAcIQ57aczBNzadEWzEEQrDatyQbTEbrvrdcwRP+0oHpYwIYN2FvVM9oT+TIjC6dzBAJF3DDccldjT0HOuOvRTBkHsWWfBK6dBzFqnpvMyvIIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fR2bK2dr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR2bK2dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ngFN5P8pa+SiEt1Ew8FmKgFK9481luIZ3P3zqtJw6G4=;
	b=fR2bK2dr5T79ne4/tlY2iLTzh/GRoyLVUYAK2lEwZdDyZFJ9vPM2ehC2aWc+mjekxiDQLP
	04BJzXwpkgImC7XppPtxy9vb0B29Sl+iYR5yWFOGPy0WgJix7Smt12J6gA3lEpF9QSrW2M
	+v2bAswfedX9rbyNq5ZAbjUqlodmiyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-dRSoNJWdNqKfT04TQ_mZdg-1; Wed, 12 Mar 2025 02:57:06 -0400
X-MC-Unique: dRSoNJWdNqKfT04TQ_mZdg-1
X-Mimecast-MFC-AGG-ID: dRSoNJWdNqKfT04TQ_mZdg_1741762625
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-438da39bb69so44446465e9.0
        for <virtualization@lists.linux.dev>; Tue, 11 Mar 2025 23:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762625; x=1742367425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngFN5P8pa+SiEt1Ew8FmKgFK9481luIZ3P3zqtJw6G4=;
        b=OSltq8PY8DUnB3y5N5uNdCspSmJoQkKZK+ERFRTmFCfFikbm9PiVfNgkfA7RIPNsW8
         TGW+rng/Si343aV697OCovwzdLM5FgFHLsRAlVIZCVS9Piih+IV1KP2Mm6ldcS59G5hr
         lF8U22LlpzBa3JiNEakwudeCjm8tIXMw8fzGu0H9vnIaCD7Qo4oplXEOUMOhPXD7qAcc
         VRMCbwlRKIQuI4ZrEc5IL7xIYSCOT00Ao0J0iPvPVL7Vt74OcM1SWjquovTJDsoOfVEh
         m4mAx/Z760raZn5iSHov7ELXMfcsfLtaKfjuCAnMH91MrDlsiuTwOqXMr1yPFw91P9ho
         f21w==
X-Forwarded-Encrypted: i=1; AJvYcCVXXQnhHq1U+POGBkK/Hlk8DMdAWiueGQzQ+O/ZMR9wOlLWISkejeoOBHhDpTnzWSfmWZXU2EiU/bS7iRlw5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4kCytrMDxcEM/rrS5/IlBFEq1TpSQb6ZWxBg4TAxiAP3GQzlb
	FlZFRA0nMp4xwmh6zrALElSQ9Vi8+cMcih+Bi+Mb25DLGz+GJgEB/VoYU9qkTAilF05czMayUNN
	UrkwymbSdtXyzlk5htSTN4b7oXKxrKmz/oy+eTsdlBAjzENaFHruHRIZ2V3h+reYr
X-Gm-Gg: ASbGncssA0R7RW9xmLC+9e1Xl5n9W78zJoN9RUILIblTZpV3Ob0Ur8EnwGaW8D3/SdV
	TZcyVDNSh+HaoBt3kWnVlHbjf3jVmtoX3BioCgNiZ3J5v02nKPUCPEbQRhWL6DOOytrFoC7UuzW
	Q7GXhZGb+BXraxZsEHsjylhaaAgTQ6VJaW/xvL3qKVjFvZWeFsyirAp3TgBi3E8BEiBoizjBU3R
	5qNmKHSQ7CLk5zyKyY8/UJrdlCqcLemasTh23ylChh3wh4SJh7MNlcZXCpKMn2/EezeoeIZ0LTN
	T0AItYVvug==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43cdfb7db88mr143183305e9.29.1741762625057;
        Tue, 11 Mar 2025 23:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXQUbnjKhdX7cSTwHc/sH5KUBC9yqYpY1/TKqBEmz2tDiKoCFs3roMwKysiE2/kbKi5UsENQ==
X-Received: by 2002:a05:600c:5618:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43cdfb7db88mr143183025e9.29.1741762624636;
        Tue, 11 Mar 2025 23:57:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a731031sm11806955e9.7.2025.03.11.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:57:03 -0700 (PDT)
Date: Wed, 12 Mar 2025 02:56:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312025607-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-5-npache@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250312000700.184573-5-npache@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fs6Dtsc0BwqHZ7ZrddtT5Ewk3-yGPPDmZveSYGP1zME_1741762625
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> Update the NR_BALLOON_PAGES counter when pages are added to or
> removed from the VMware balloon.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  drivers/misc/vmw_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index c817d8c21641..2c70b08c6fb3 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
>  
>  			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
>  						 ctl->page_size);
> +			mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +				vmballoon_page_in_frames(ctl->page_size));


same issue as virtio I think - this counts frames not pages.

>  		}
>  
>  		if (page) {
> @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
>  	list_for_each_entry_safe(page, tmp, page_list, lru) {
>  		list_del(&page->lru);
>  		__free_pages(page, vmballoon_page_order(page_size));
> +		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> +			-vmballoon_page_in_frames(page_size));
>  	}
>  
>  	if (n_pages)
> @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b)
>  
>  		/* Update the balloon size */
>  		atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> -


unrelated change

>  		vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
>  					    ctl.page_size);
>  
> -- 
> 2.48.1

