Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC13B3E51F7
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767676; cv=none; b=iHst78bgs/p4ouOZjjsjKr3CofhXOfYt0BDEJEeeSeOktWxfmlV8EVygQmcnTdW5fG7uMKHriCV+cfknFoEpxqRvhsuR194wjawrJVd8khYdSi9KKafkkfscEoJZnYfIbHPP2mIUQX+Sllfh+Vn8tQ9/NlaoBGLy5fQx1nOMqS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767676; c=relaxed/simple;
	bh=gxxWJB/qB/J8fJqa5y8sKRNuXpYzfb0WmIuH/Ebl/eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iloD1xv3BCOjOXfNV09m+RHrfgvKTzcgpuxGIdTI/eFU8QOiDcO1DOHbJMjkz9uzUnRlMcas5mcj9A8fJjfH6V7/n0+9X+zUGUvYApgP/8MLXCQuaOklnehm0Fnr2cmNQyORLuIsGRqHdqxQyE31sCqJ6Cmrq0yaZkJ0iNCw3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qZ94IWAB; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qZ94IWAB"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-911796e9885so27374885a.0
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778767671; x=1779372471; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzkmFh1ZQqsmfN+ZQzPcPofqB0NQiVM+nge3NejXpRM=;
        b=qZ94IWABlzbBeBqt8K2BrMWWigtx7XJCtUmFwMiJOkAeP9CFgt/k/xi78FcnY95fCP
         7e1T5xLZDsTAOLB7fm2DpcZv5R05//Mpcc6M+9hcsp88kgBqPW1W2POSxtzoAXkHH716
         Dc3GkZWuOHuwntIa/4DM/wDfdg7jgtojOq4ed4gdy47ShebanPm6QGV8NGuqyoexCcoJ
         bTgUpOlXdWsPOcbAMFWbiX2r+VhyhynejoPxEqX0/A4TFaRRZ9CYIXH/FgFKQDl6VpV7
         w5+DEd27vrIFiiS5euV4qy4T22ynz+43o4IiOSmsRg8ezJAxbjf792hYlRejdFEHKI//
         hvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767671; x=1779372471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzkmFh1ZQqsmfN+ZQzPcPofqB0NQiVM+nge3NejXpRM=;
        b=NoZMQaiR5WqHxY9OpJnTbH72qJFG1TqYyHp9wRr2YHw93O+pSnd5TyYb4OZcnaqK3I
         s7bzrUL8htZsvptNtCK5dFDfbDRL8BP6bD4mx3hvHEufIe+EuYlKrbs53I9rCKH/+PXK
         UbPu4Cs+QIU9H58ceGl8dgPwJvLa3dNoC626lvPyRzZKShTBW80ru8n2HAfUluEjdD3r
         t4qMRBw8LoWSrgdiqGUNTGXE+SLwhzUJydEppWzQPdOvHdiwBmVioP9eT3sEupTBEnvq
         w5voygA7bQsEKTjf987RI2sw7gnEL+fYvWyo0xaC/7dlfgHwI7Kl6LVTSu/2VSV1RtHR
         rzqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ne9RhHPIo2Z7KMzwm2DpcfHfAHhdT2oil1pdzQOOkdt34t0yuB4dcsIB1WGHTV6hN/IV0FGtXF0c6WrPokQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YydrFkSxzvedY2FM426bm35fFEqGWLF+rFT8K0EMQVaIc5JuEoc
	px7Zv/d+JwzBxHTU3t+RrrGjtBEilvN3W+ZpN3I4IdqLdfNFZGgxT03k+tj74sirRzM=
X-Gm-Gg: Acq92OEo0JmWWOnVerofsTEQRNIr4R32smeMaf0SkX1yl4sYLMQxmAVqTH82efeZkb+
	RODw8B5wErGp0d0Qcwnr8ktAXvWTEDc+rfBGfAkPO9hd72+KirE3hx5+GFxJKMYiAVq0SCPjnJK
	6sBwAYV712INlQu9Sgoechy/mGUjinQCWzSNI3TIy0tFQ5U8F+SUwnybS07LA78TA+cqjfVAHBD
	dnYfhh9k7NhV1aCMGU4sIL4JkiFDW3q3KIKyIcJOea8XDLHggJxG5RGgYvTEkRXFagbnUWjfJWz
	uY42v4NTAl/K76IhhnO2YmVQhYsgP7Z4KBQraWto6sXheheIpiKUoSKvfcnhFamdUcl28bRukyr
	C0OG4bEQQuuFDGDb4rHVq4Qe4+A1tXVPf12/IXK8axxJJzixAFdqnpCs99CLPn5sRRb5qjEvC6M
	PdslVadoFxONk2e6C9IA3BgtkXFspehpV5ykF/2gDplwUcfQBB4RytnGjGh3l9kJFAvyfBDIKy7
	YVQmoEUvgMA
X-Received: by 2002:a05:620a:4809:b0:8ee:b817:9a03 with SMTP id af79cd13be357-910af5599c8mr528786685a.9.1778767671219;
        Thu, 14 May 2026 07:07:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bae27359sm271238485a.17.2026.05.14.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:07:50 -0700 (PDT)
Date: Thu, 14 May 2026 10:07:48 -0400
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
Subject: Re: [PATCH v7 18/31] mm: memfd: skip zeroing for zeroed hugetlb pool
 pages
Message-ID: <agXXNJNR9CV_dlwl@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <0ec51a9091b5ed3f61a49935953dd537d6c87428.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec51a9091b5ed3f61a49935953dd537d6c87428.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:06:43PM -0400, Michael S. Tsirkin wrote:
> gather_surplus_pages() pre-allocates hugetlb pages into the pool
> during mmap.  Pass __GFP_ZERO so these pages are zeroed by the
> buddy allocator, and HPG_zeroed is set by alloc_surplus_hugetlb_folio.
> 
> Add bool *zeroed output to alloc_hugetlb_folio_reserve() so
> callers can check whether the pool page is known-zero.  memfd's
> memfd_alloc_folio() uses this to skip the explicit folio_zero_user()
> when the page is already zero.
> 
> This avoids redundant zeroing for memfd hugetlb pages that were
> pre-allocated into the pool and never mapped to userspace.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  include/linux/hugetlb.h |  6 ++++--
>  mm/hugetlb.c            | 11 +++++++++--
>  mm/memfd.c              | 14 ++++++++------
>  3 files changed, 21 insertions(+), 10 deletions(-)
> 
... snip ...
> @@ -2221,6 +2221,12 @@ struct folio *alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
>  		h->resv_huge_pages--;
>  
>  	spin_unlock_irq(&hugetlb_lock);
> +
> +	if (zeroed && folio) {
> +		*zeroed = folio_test_hugetlb_zeroed(folio);
> +		folio_clear_hugetlb_zeroed(folio);
> +	}
> +
>  	return folio;
>  }

Hmmm...

if the intent is to simply communicate to the next function up whether
the folio has been zeroed just so that function can zero it - does it
make sense instead to just zero it in this function instead?

Also the only user is memfd, and that appears to always want the folio
zeroed, so i think it simplifies this entire patch to:

struct folio* alloc_hugetlb_folio_reserve() {
... 
    if (folio && !folio_test_hugetlb_zeroed(folio))
        folio_zero_user(folio, 0);
    else if (folio)
        folio_clear_hugetlb_zeroed(folio);
    return folio;
...
}

with no API changes

~Gregory
