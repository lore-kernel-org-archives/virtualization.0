Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE03F1669
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766922; cv=none; b=tDlwId1s4DjfNEezS10yIkZh1DKHCCSDTTOtH2vCcsUKTOesS3VphgvQ/k1zP2pH1rCaJZNWa4bh1jtGaCvRHYDhe+o0/AW1FPZtxrjMdSBENMY9wwqKmlJTPh6CCDER5rOt71o/xL/T+zOWpgSVcIXTTDPJiGjP2WOMZ1uVw+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766922; c=relaxed/simple;
	bh=NvNTTK7oVqMi+Oc1tLQ8KX1F49PSOBt3JtRnBB5mvFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeREta5XuWffnt+KAbXBS7cQDCPoVg+X7enxkrF4JnRCHSp0OfjVRSsU8IJQXOIjVskCgI12iFs9gU/W5ylKRWFNOkil5uNyBmC0o/y6pbAivRKm6i+bC6iztCuzhbq50d+DazhBCxElSKVAxI6AFrGTNSKKKWYN4O7cbu/IXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ci/3O8R2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ci/3O8R2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9102e90bcbeso188253885a.1
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778766920; x=1779371720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqYGPZxgNRcYPxPA7WQ/pm4xhwUDd+98HNryuL77oaw=;
        b=ci/3O8R2Abu+f+/ZBITJTibWBHhsI/tPmcoNdKZrLRsbnc+iyqp2rkj+UwXtTLZQ4q
         7AmHX/2mZtRccRZEq1Dr0rXpPXoMs8QQRbCU4RUGvvNu3U0/8XRakWjxUYoaNwDVYz3U
         fqgazYAQjNJ8xcVvh/TCeYUq1N8zqsPZUgYUlAyARimG8h6Cw39qh7pcK4F+XUFlu4+I
         bnSwJv29ziSr3CIWAexreozBF6rQINGIThL4p0SL8/yXtZpoKgfO58CVPpjN0j0Enc6d
         /BRp5y1/Tiz1UHDxwhZo66iwOfdqmGSLZEA/z2C6T5CNpdHKv/zpQbBcS9alH0bz+lOj
         06MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766920; x=1779371720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqYGPZxgNRcYPxPA7WQ/pm4xhwUDd+98HNryuL77oaw=;
        b=KAavKxMJJZDk4wKuWPlKtYXvJJeFDZFUpsg0JsWw841e34ECBJ0ALNHPpjlZob0Nvj
         qLN50XrYVTelWEaxi33CgDyBYLL9jD+IBoak/yo6Nj1hyKIgNf5AzVAtrfFkecDxqA/4
         CGGOvjavYYMsX6P7zhUIDNelQluCfeu8aZKoSkcIUQm35T9FE5/9AnhRmKYqgLYCtWRe
         NiFtJHbucigdKrZ+R8mh2Js+BNyUfTTeWuQ4PYHg9oNpxSevHysqMRvxzPhiCdIjZi6R
         +gmrmnbAhcXjAfTUCRx6yQDBnOunW2cXvhkOutI6CzzylD38Kopr/033ODHX+UPzRzuj
         w52w==
X-Forwarded-Encrypted: i=1; AFNElJ/8N3Wt0M0pK1+5kEzwV766rd+5oXa+37B7NQhX1x20UAzhszrOPBBscAlV3lQqmpF/5wJ6obZaIO0KD3Hr3w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdaKTKMoRiD044bi0xirp6AN+Tinao8V96zPGGtMylK2z19axs
	SW8Nx35ZLBydElc2WCrWrlGgFsYHup0W0o5r6LTn1T9L58PliKr1QWRSoQrahU6ZS/s=
X-Gm-Gg: Acq92OESM3xZjD+wzb/4+zrLLNwxTPpygRSw4amNIuwssE62VbzolWXTL9lQuVaMN7N
	8AMeOXV6wCZI3mg8G20Oa7f1F/v/IUJuXUaDd4yZrDWtH/nAnET7k8Gnmi4Fmt8G7Rql7bIEDIs
	P6jPPmhk/xHErctOA6HZxDJhwwVnyfITy6KhJWRV8NU15IArtQHsIRjogMW4AWvJrTghWwR6Vuz
	O4Z3Mf/PlSXWRARDfcWrQ80u/7O5kSKwgi/iNZZROLx56JljaKq5m4uq0DsTJcWI7YaYxO6bGIr
	KHug+anarZJg8B8nVF59y5qZ5kO4kIi8P0jwoKgT1c986uIdrtanD6QuZ5PDpxJrNSEX3+HVHuJ
	L2FkSAx2XWrQPexY42vwz1SKPHwdfOe39VyqQXQJKA97NK1KukESUCU2hkDqnq0tHCdVxwYDLmm
	D1MbnDXbw1ycLh8nWktmmaHZsVqVnXcNKHofzMWma9wAywKAjBh7eaji/B6Oxh7+fWrknTJ7H6h
	Llv9rJlGRgL
X-Received: by 2002:a05:620a:2a0c:b0:8cd:9033:1724 with SMTP id af79cd13be357-90f880ffccemr1218244185a.9.1778766920104;
        Thu, 14 May 2026 06:55:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910c0ec392bsm238411385a.41.2026.05.14.06.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:55:19 -0700 (PDT)
Date: Thu, 14 May 2026 09:55:17 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v7 15/31] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <agXURY4899YxaEXn@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <411a7b6a750c1904b99be92fad0e678ad791ca82.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411a7b6a750c1904b99be92fad0e678ad791ca82.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:06:27PM -0400, Michael S. Tsirkin wrote:
> Now that vma_alloc_folio aligns the address internally, drop the
> redundant HPAGE_PMD_MASK alignment at the callsite.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 970e077019b7..d689e6491ddb 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1337,7 +1337,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>  	const int order = HPAGE_PMD_ORDER;
>  	struct folio *folio;
>  
> -	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
> +	folio = vma_alloc_folio(gfp, order, vma, addr);
>  
>  	if (unlikely(!folio)) {
>  		count_vm_event(THP_FAULT_FALLBACK);
> -- 
> MST
> 
