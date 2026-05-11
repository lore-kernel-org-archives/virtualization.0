Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F940B6F3
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514850; cv=none; b=FykBWWVrOWAa7YVmkCL6wYqSa/zRHtCxJjvHqfn5wl31YVeYtCXH77hPG70lgQsdy7f+6pXCc5LlgzjVHHuLNVvUWyOPcozQiq4W0XZTlN544CVZCtH7HBTJFN3XiT45xwrJZ3AdkNpmH/5n8wm7qR5PaJ6MiEQq4oe7k9P32rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514850; c=relaxed/simple;
	bh=aiGFJQW61WDqG9XpD7Ci1ql3gHNF+E9K3gUxwH/LCHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF8asW+PBWoad2B2/r/ScoDBDeqb+IMz1+awelvsnuav83NTBoaujovZniOcq8XrIPZjnkq3GcD3g/h03WTVjP073ah2pFdUTwDT+rDb6w9PGi7gttvkba3aW0mE20rxzgaR38EOXxcbvjT0c9W3fwuAHJs4HNTgMxFfb9g1JHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mkjyhrVj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mkjyhrVj"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so33358066d6.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778514846; x=1779119646; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20yoGM3whVtKvNYZZgGIezStzCSDmI46twhVwHYN4Ew=;
        b=mkjyhrVjW0IKyvdchw4HZLxIf+V6y2B4AiBynATUSdRXML0WYsJfPKCBFQT+BOa72C
         AYTv6V8AbnUqqOeTBpMro/0WlmBzEBIGyCk0d4vz/t6a0sd08ItOHo40jHbFDYcbCFQK
         wl0QfoNZmO5+9NSsOURZAFNL5DyygFlInu1r4umVzFoPwUq4fT31hoRnNZ3zeXspB9Mu
         PufmZJSDNJBJL7vTpbdO368XwT6eA5sr1/kY2JvXv2rgrhwaIAkkobsf20/M+OIr/0z6
         bk3g8FVz2XNDbhZBzD9Q5ya6cOjYvXkmsKxZkCHQFG4dENAAZOLG9NzrmqMHMcCR/acL
         dbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514846; x=1779119646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20yoGM3whVtKvNYZZgGIezStzCSDmI46twhVwHYN4Ew=;
        b=oM0KT09X/aplAnucl3AEzvDicrzTCsO6kad6/LR4wWFOM+ugXH+h3osoZqAtk1nr+8
         FWafe+9qHELejeuTzZly/9IvI86YxksXWbFOVuYUZ6BaNzuslr0aotOlLSfRDry6iTzm
         0VjLrAJnV1+eOoDx4wYFTBkELP3a2XqupKz9d90OPzjDjS5nNUS2OYkWPgKMNNyW4B2O
         Z4JUv/A618aMFzsp7Pu1RRwe86aMgm3jb4KCrNAa+z/4XArSIdBKN8kyUjU7wUawHNGq
         sLhdG4K/mvffi3o1zTp+cpn02LiU54+f4OLclAD1FTfFPrksZ0esHsQKRmdS7KxatFR8
         bE2A==
X-Forwarded-Encrypted: i=1; AFNElJ/JayfVZDXo5+Ob0CNMCpYoSocSoDMHTYipBP7JaPp6oqf/vw+ocOIfUayIpz4DHUTajRFXQMV58NlPS0709A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxISbrP8lCDmzIX4/9BtKvLQnjlBwdD9CeohA/d2Ryx57+pmXnV
	/Xztf86zKa7ZBdWu9aP6nwJhHyHLF5xAsALJq5kUfqPXu5FenTNaFDPt4i60iy4WrA0=
X-Gm-Gg: Acq92OERQd9/tz9eec4ClzUmHh2htWSMpe6Tj8TsNiGJ+X6iLDgtMO+XU36zstD9A0n
	ZiXZaFR+UjYSEy2Ri7GuWYQq6nkr6yxw5sPu/Gx1qw+MIUPsugsbufJ1Rwc6DPkOSXMY8gBdahG
	VExosPX5O/yDohtG3I9fPA+mNTflDUASRDuewi9XGswKlzaswRro1KQsZkm3PPRlKjJiuFpHv1u
	JzMBl5nmv6YZ4QF3RYGD7f5tvsP8ShkYCi5QKGxBfNeW1AcVeFyacr9RwnxrJFUQ3OjQihpr78B
	rdn5SIrXLkO/+8mCkXsIPQ9ScE6iNCecrbWu0zZXufNc/G0rQFOJ+hGmt9gRYXrK+WEUaUZMu23
	Rt/xcAMjnOnTrz8JFNMELaazgCbvETkSeBAsF5tnzzahyyzCztcV1LWhbKk/fsM01d31HcIam59
	qRJ7YTVJ2lF5oDLIID5+UKLMvUTXJ/K1km8Iol5pEMpaxELRUwNGxn64vSi/A4hq9F/jWoDaGWN
	YG1Ghdbwkmy
X-Received: by 2002:a05:6214:c45:b0:8bd:7192:9506 with SMTP id 6a1803df08f44-8bd71929608mr325423396d6.7.1778514845601;
        Mon, 11 May 2026 08:54:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831ac7sm309701326d6.49.2026.05.11.08.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:54:04 -0700 (PDT)
Date: Mon, 11 May 2026 11:54:02 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: Re: [PATCH resend v6 05/30] mm: page_alloc: move prep_compound_page
 before post_alloc_hook
Message-ID: <agH7mtbcEzogYuk3@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <6345727fdfa76157ba0518e2148d1848e0bdbc16.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6345727fdfa76157ba0518e2148d1848e0bdbc16.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:02:06AM -0400, Michael S. Tsirkin wrote:
> Move prep_compound_page() before post_alloc_hook() in prep_new_page().
> 
> The next patch adds a folio_zero_user() call to post_alloc_hook(),
> which uses folio_nr_pages() to determine how many pages to zero.
> Without compound metadata set up first, folio_nr_pages() returns 1
> for higher-order allocations, so only the first page would be zeroed.
> 
> All other operations in post_alloc_hook() (arch_alloc_page, KASAN,
> debug, page owner, etc.) use raw page pointers with explicit order
> counts and are unaffected by this reordering.
> 
> Note: compaction_alloc_noprof() has the opposite ordering
> (post_alloc_hook before prep_compound_page).  This is fine because
> compaction always passes USER_ADDR_NONE, so folio_zero_user() is
> never called there and folio_nr_pages() is never reached inside
> post_alloc_hook().
>

We can't really know that this will stay true forever, may as well
change the ordering there to prevent a tripping hazard.

Possibly you might want to just squash this change with the next patch
and add a comment that the ordering is now explicit and required that
way to be correct.

(possibly patches 4-5-6 should just be one patch, since it's all really
 the same change, but 4 seems fine by itself).

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh

Reviewed-by: Gregory Price <gourry@gourry.net>
