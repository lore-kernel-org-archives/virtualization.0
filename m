Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB332BF24
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303090; cv=none; b=Xvq4pMtX6/pdKYb+G5epi/AtcsYc/XHHLLaQ5qVWx1D0IJmhf1ZdTlRXQweaTTjTAPq6PQAiQjE3o9NH7622wtZX1qBdefpsuRrqywnkIJ08Zz/uyRHKbXWwJN4Doe0H2gSRsS0vjp1FeyT/9EDhwfR1s/68B56IW0+3RJKJjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303090; c=relaxed/simple;
	bh=D+2h7xzpt7GbaEk60JIFREm5FvhK4UL6KmPvk8SIeTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zr+7ejwt0ZtQRzYFjpLCK2Xt9RBGU9gHp4G8V67CONvZks7DH5SUleUah2XThh7uW5y2/ZgxTLMcnc81+155biocBN+qdVgM+beaJi3th9QbbRrGLwu/H478kYPdwxmhhIRZplZ5oZVx1zpcXeBP3xgT4bnvzX8J/7yZZ0UzKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlyZp5CZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlyZp5CZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777303087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsHOVCUXvaEIYIkpmuMRaDJg98RHwYpOJQfqxhVn1Is=;
	b=HlyZp5CZlZhM5TAQz1JVsXjJjnWJQrjLo/le2mN/NMgyg4KG6N/vwLDEP1NK6AKz9jWMT+
	98j43RwJ6NmIOHAY1y/Tbax86Wy9gEsZvGvK3278YE44YNls4q/P6r54MjryXc+mSKX0mK
	L5NMOXYMXKdAPPWs2mSKLAzaJ4g2MxE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-zjZoFcwdPGSoLzVENv6YWw-1; Mon, 27 Apr 2026 11:18:06 -0400
X-MC-Unique: zjZoFcwdPGSoLzVENv6YWw-1
X-Mimecast-MFC-AGG-ID: zjZoFcwdPGSoLzVENv6YWw_1777303085
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43cff5ef652so6759605f8f.2
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 08:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303085; x=1777907885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsHOVCUXvaEIYIkpmuMRaDJg98RHwYpOJQfqxhVn1Is=;
        b=nAQy/qDpBDGQFqH8saU/bf/yZ0lmOIJwdJVkgJva1Jdg96EArnONKDfTO93LY/0foT
         l8fhUI2FsvpX3NKvocBEL4/UjgCA/DB5MMl5MJNiYx51zm9xjYWNm+zDniKaLRSTtVsR
         4pP/UFYc1w2bJXeGd1mvcKWRLoQB9Yi8+JpYOvoz9GiVkTiSe4rlQfLqaf7sI1BevwS4
         UWfFk0aPhfFZklr/e+O+K3SLJ4oBtl0H1wALLgupbWino7EbR8bMhsPnQxvJh+78vNGg
         8bcR5uG7/qCLsdR2t5ay4A9Np9m4XkskezeKlYLl0EK+LcHuZdtRjz03XVWjMGOIx8Ss
         l0wA==
X-Forwarded-Encrypted: i=1; AFNElJ/5RfQIx3ERqJq/FoLmq/V6BiwwIpIn6kaMfl20T/BkXnKY6tKIKSG0PhyZrRGWrbbClRcwaVkvKtCjxROkEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk8B1YHih04EZSc/bdt/f0edF5zjiMitexSaxa7Dic1qjgTEJb
	wqvMh4Fzrx/VkI7hjY2/ZHdriIj8B5sYrr7G8oCjJ/Uv+04gJ6ieniMxB29rYupUQK7AAtMlUE0
	JSwew9aTGP38zPlwl/F5uY7wgYyx6FG+Aeviy08f1/ByFi4DhgW1l7e+Bu4mbjMf7Q+7P
X-Gm-Gg: AeBDiesH7OEMr4iEqK0d1WoNGqtfbFqidjHgNaBpbNlbbN/USWrid4+PCXA5A875LP1
	X9yW0735UHmfyy2trgHyXH7gJDlZ9IQ43LsbJC/V5x6TWTZlZIbd+n43uvmMB76YB7+SCFW3Ka4
	7uiVE5LLmf4qFGYNpuwKR1kYawOJEJZbvwUtbgA7i6+XZgEIk+ko0BaT0YdfEe6bYzXXIUX4K7a
	6UqhPs33TRSWwFeo9FyvQJSwzhjaDshf0Qcs/WiBOFlcDn8s/crR/35GDSZkEV7XQo6ShuFBVbt
	rAE+sVgCMdxxVTMoO+jNlMkpMChSY0fv2Pecy+sO520L8IW3EhWS+Mg5QMnZr6S2K1fcIFLFKW/
	nalbmbixC2smb90fnrlBaPn6CPelKvz1+0xUw9cK+Y99VPAE2qYuJOJP0
X-Received: by 2002:a05:6000:40de:b0:43d:7946:badc with SMTP id ffacd0b85a97d-43fe3e073dcmr66488032f8f.26.1777303085281;
        Mon, 27 Apr 2026 08:18:05 -0700 (PDT)
X-Received: by 2002:a05:6000:40de:b0:43d:7946:badc with SMTP id ffacd0b85a97d-43fe3e073dcmr66487949f8f.26.1777303084696;
        Mon, 27 Apr 2026 08:18:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e44f69sm85358069f8f.25.2026.04.27.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:18:04 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:18:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v4 14/22] mm: page_reporting: skip redundant zeroing
 of host-zeroed reported pages
Message-ID: <20260427111724-mutt-send-email-mst@kernel.org>
References: <cover.1777223007.git.mst@redhat.com>
 <788d5a09394ed1456beaab23f75d91846ceeb611.1777223007.git.mst@redhat.com>
 <DI419PSP5050.15VGMJFDMWBQU@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DI419PSP5050.15VGMJFDMWBQU@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nh1t4FjHtvdnMsUYFSNYX_5DiqIxBc0Kts9HEbYhqHc_1777303085
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2026 at 11:13:44AM -0400, Zi Yan wrote:
> On Sun Apr 26, 2026 at 5:48 PM EDT, Michael S. Tsirkin wrote:
> > When a guest reports free pages to the hypervisor via the page reporting
> > framework (used by virtio-balloon and hv_balloon), the host typically
> > zeros those pages when reclaiming their backing memory.  However, when
> > those pages are later allocated in the guest, post_alloc_hook()
> > unconditionally zeros them again if __GFP_ZERO is set.  This
> > double-zeroing is wasteful, especially for large pages.
> >
> > Avoid redundant zeroing:
> >
> > - Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
> >   drivers to declare that their host zeros reported pages on reclaim.
> >   A static key (page_reporting_host_zeroes) gates the fast path.
> >
> > - Add PG_zeroed page flag (sharing PG_private bit) to mark pages
> >   that have been zeroed by the host.  Set it on reported pages during
> >   allocation from the buddy in page_del_and_expand().
> >
> > - Thread the zeroed bool through rmqueue -> prep_new_page ->
> >   post_alloc_hook, where it skips redundant zeroing for __GFP_ZERO
> >   allocations.
> >
> > No driver sets host_zeroes_pages yet; a follow-up patch to
> > virtio_balloon is needed to opt in.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Assisted-by: Claude:claude-opus-4-6
> > Assisted-by: cursor-agent:GPT-5.4-xhigh
> > ---
> >  include/linux/page-flags.h     |  9 +++++
> >  include/linux/page_reporting.h |  3 ++
> >  mm/compaction.c                |  6 ++--
> >  mm/internal.h                  |  2 +-
> >  mm/page_alloc.c                | 66 +++++++++++++++++++++++-----------
> >  mm/page_reporting.c            | 14 +++++++-
> >  mm/page_reporting.h            | 12 +++++++
> >  7 files changed, 87 insertions(+), 25 deletions(-)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index f7a0e4af0c73..eef2499cba8b 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -135,6 +135,8 @@ enum pageflags {
> >  	PG_swapcache = PG_owner_priv_1, /* Swap page: swp_entry_t in private */
> >  	/* Some filesystems */
> >  	PG_checked = PG_owner_priv_1,
> > +	/* Page contents are known to be zero */
> > +	PG_zeroed = PG_private,
> 
> +willy,
> 
> I was discussing with willy and David about removing PG_private and
> repurposing it to PG_folio to identify folios. IIUC, PG_zeroed is only
> set for PageBuddy, so it should not be an issue to set it for allocated
> pages for folio identification. Let me know if I get it wrong.
> 
> Thanks.
> 
> -- 
> Best Regards,
> Yan, Zi


Exactly. Trivial to switch to another bit, of course - most are
unused in the buddy.

-- 
MST

