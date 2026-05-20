Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DB3C3420
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315756; cv=none; b=E20z28HB11z/13qkii4rK4G1tgSjv3w2RjG6d5OcrnMxVbZdujwAxEHE2tYs4W33lzaKhI7Quxaugok/mUjQNhhIhhHMHBlZiKWZpfyzgVgRkQ9r3K0XLkCZBjQbMP5OKxgA8JAJ9IxKgXNTpb68v9+6BDPJ4N+Q0C8fM8HC8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315756; c=relaxed/simple;
	bh=v8XIPZddn0cM1ZAYTFFDjJe4mcF8BIRTQpXVMkTIuNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hU9ryBP5gO2L/Pk82kkfZNLKZToG+MIU46V0/8vJOV55FqJlib1uKDjiFJBYk/InDy4dW+6z1xCYt2JU9jIeu0YDxRoAHUKN2A2oOI4qvOXg5BOvW/dQMuYpG02Z2wmhlX8oksYuGYmSJvnjLAshwa3zwi35wOpUBZbDKAQ/ry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv1qTEPa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv1qTEPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkdba+Ei5cbofNgiigEWYwJVG7QGPYteKxTN237/DT4=;
	b=Tv1qTEPa7hIQ2mAfBgYWcJbCz1ysnfMOTCh9cyFrBkgM0sbv6f7rgTYF68ENNeUzo6uEef
	Ma01FiRGcOxXAKWX1elg+uRXn3MgI6qWxAon7bitQROc5IJq6/MrZ0ALcLJMqKyJp126ya
	syWxEEEiOGBsYJxomAosDkZW+27JwlM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-MUsSWOhfMq2FIaFynL0YWQ-1; Wed, 20 May 2026 18:22:33 -0400
X-MC-Unique: MUsSWOhfMq2FIaFynL0YWQ-1
X-Mimecast-MFC-AGG-ID: MUsSWOhfMq2FIaFynL0YWQ_1779315752
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d789cebcfso4212064f8f.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315752; x=1779920552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fkdba+Ei5cbofNgiigEWYwJVG7QGPYteKxTN237/DT4=;
        b=nzcVj+021wpYLtu/lLKO2ex5fPdxWtyyXS2d+T+1TU4/ytHnmcXfFoCweE2VqrjwUN
         Kcg+DirNMZG2esr2mV96tnFiLZVSAT9CPFU2v8T3dJPXkfhhvBMLWAPsNwVbZVsTjDlJ
         2sqJCcySD94ygSXZDcPVzZsyuFIlxH45xA+TSHhACOkWMIaYZUaofmoeQSTU0ltkf2cS
         wLluhMCtkQsLg+FNCsQrigKGTlwnJrcn5r3StAvkPGV88xKtJBxdaWXnklPnH7CN/eKP
         kGG0S70B/kYS55cLt5SNQE4yi/NtyELUs78axlBeTR/Ku9X8fRCCUk8FjH1HLGNuN09j
         XE6w==
X-Forwarded-Encrypted: i=1; AFNElJ+2hepyAxtCyvVRpGHxTMgD/co2jJcsMkhd4UFM5QTaVX+rCaGhFLuDr/lXwZd4WXRXNLr1/kfyJF8OmFYdQw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/oDRx0OpZavXLUEwsXlbz7egmnJYK2BjpFkhO+70+NaoxORxY
	eYx60/zfRKh40WJlgOMIi0lSNyhz+27HqfrzhGL3PHj0PR1syl5YdptXjoTqYvhB9LnTi06Gg0y
	3r0B7Rf2QEMVLSNWCXzySGuiarMiUW1FWQJtyGNqk89i5kMSDjf5tDq+8gAQ2WMNhNAXe
X-Gm-Gg: Acq92OE29lR87U//Z8kjBqp/a4KdjKr3+ZhMwPPQ9XtZUuKgW3TBz+KXPv00MAc1aOW
	tIeWQ0I9hd45aGWAyIrj3YgQHLGszL5IYALpPkXHswJfpcrQz9b1BpXT2h/ghJFXDswO7jYzQK4
	5FCNyxphjov4tLmoLvhUkNX1O5CCV1bQYizf6+Cd26z2DuUV52NYV5XUaQkKqOloChh1Sccn1Vu
	Jv2j9KfhcxfOQolh3pEWofQvNE/Ox+gV/PFY1ESrYw5y/CJbUtC9pRdkBuTma+e3eQgEgnQ5DIv
	/PEOib5mkO152dQS7Ceo6evlr7v/iZg228wHVYa6DMaLRf50d2WLBNbG/okaauSjCxYy4A/6k9Q
	x0JxXS7Y79VtmVwNdxJeqhzny63Zj+ddTzTi4inw345w=
X-Received: by 2002:a05:600c:6b12:b0:488:7d5b:125d with SMTP id 5b1f17b1804b1-49035f2e4f2mr2683495e9.7.1779315751921;
        Wed, 20 May 2026 15:22:31 -0700 (PDT)
X-Received: by 2002:a05:600c:6b12:b0:488:7d5b:125d with SMTP id 5b1f17b1804b1-49035f2e4f2mr2683135e9.7.1779315751494;
        Wed, 20 May 2026 15:22:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm53025915f8f.15.2026.05.20.15.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:22:31 -0700 (PDT)
Date: Wed, 20 May 2026 18:22:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
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
	Gregory Price <gourry@gourry.net>,
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
Subject: [PATCH v8 23/37] mm: page_alloc: use aliasing checks instead of
 user_alloc_needs_zeroing
Message-ID: <51265bb3f8374b093b91b07628d418375faacb9f.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sosr5HYK7Qo5yOh7yJ1SUz_egTljIGm8bQTlfvHEisc_1779315752
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace user_alloc_needs_zeroing() with the direct aliasing checks
(cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()) in the
post_alloc_hook aliasing guard.

user_alloc_needs_zeroing() includes a !init_on_alloc term that
means "allocator didn't zero this page."  But in this guard's
context (!zeroed && !init && __GFP_ZERO), we already know the page
is zero; init incorporates init_on_alloc via want_init_on_alloc().
The only question left is whether the cache architecture needs
the data re-zeroed through a congruent mapping, which is purely
cpu_dcache_is_aliasing() || cpu_icache_is_aliasing().

On non-aliasing architectures with init_on_free=true and
init_on_alloc=false, this avoids a redundant re-zero of an
already-zero page.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5158f7e23d18..4cb7e779a6c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1883,7 +1883,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 */
 	if (!zeroed && !init && (gfp_flags & __GFP_ZERO) &&
 	    user_addr != USER_ADDR_NONE &&
-	    user_alloc_needs_zeroing())
+	    (cpu_dcache_is_aliasing() || cpu_icache_is_aliasing()))
 		init = true;
 	/*
 	 * If memory is still not initialized, initialize it now.
-- 
MST

