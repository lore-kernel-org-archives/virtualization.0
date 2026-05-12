Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA743C2BB4
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601367; cv=none; b=bvkcZRNqpQLALoORpKpUxA9OcmlSLFtKpi/fOgTLMflzD5/yVF25XrpNJknOrAhdqC9NDZ87KqN85kKuo8yjjczfpiqSeTWJvvvOMgHuRgAELygRwgYRz1LJ1eKzL1M5GQaJ9oltyIiuUK5G2Jr4EHpTfLBi5AcB6xABS2/rTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601367; c=relaxed/simple;
	bh=1EQ6J44yYhZWgn/zkYAncpsUX5MIcPYdUQgdHICoVmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBck2hxOZxogWSu3xnJtdLKY9QuYvKEK9ycA6wNqgkNnA13VgDTTP5iHLo2IXhXR6n2wJBaf3qUTmNAi9FgItny0RnJDkX5RWypTHsAibeYBWLW1/P6b4FQA29nhv1z5Py2iF1p4EYKqL4iZ2K0N0YU0c6jClkBIVVhXL0f8MoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BJiSxcEG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BJiSxcEG"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b98482b253so77227536d6.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778601365; x=1779206165; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Su8Okdv9QVtgiODRxP6QoL4RhbVAvigNNa5QAGhM4ag=;
        b=BJiSxcEGOdClzNAUxqrO7RjdSknRfPqzl2G9oFH1BUIm+/JXLQdXI1PhE78pOgRa+x
         RgtAJxzvpsaYC8xqtgwczIiKTQhNdRI9tu0IGKRGfrXHOjhpxW+8JTsOLkQXZ0bMHFaq
         RXEiCMvC7hRTU2bpH8u9/+riXvBj2Da725BKlF15/qvGc3jG+59geXvnfigDAXJmKP2a
         IH0VbVQCY0qeyjqdE03Tz5tTGv/pOFVbEBc556TxxMaW8mVjxVRNEtU6zlx/PrcmR8Da
         FzLNUAlXd1RgAX1jL5wb+GteQQF3uRH9ucTo8zQrI09zu8n6iLl9P4kHlKxLKonl13D/
         HC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601365; x=1779206165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su8Okdv9QVtgiODRxP6QoL4RhbVAvigNNa5QAGhM4ag=;
        b=AtrsJr09qzpK9gXvHZuYd/a7YATOluSjEtvJgpXI4GBlku9bezIEHKLc8pU2pPc+1o
         FLP0yeGaibtUKjDzYPC03JsrCkQIimYLEZP5tDnSJc9EnmqMif9wpEEbkeWWgloqZt0F
         H1uIDJcCDq4c1GqCzOBZzq4c6hYaeli6lgxa803i6jv5WsEpSwxA1cnrgO+25DkqePXV
         yU9xvuYal8FXX74Oda4AsXCSLO4D9mJx5Tl/GjlVIhHnpHpdbVTUBSGMKbNJWPhAMkwn
         3pexHEy3jLQCLZZpBfsoHdctTVeXEse3NE/WX4pPk0ZZ3//+vRcciztCZ69a7yDcMREb
         LBgA==
X-Forwarded-Encrypted: i=1; AFNElJ8JW0cGfG7y50fGLjOmmTFgYUH7ZoCcNLNV+qSlzIN90HfuT3VkP560mZ7txa1MmP0NxE8SspIxrbNj8i2yOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2ql0dOeoAbaTdoWQX1VPK08FXVxTORuSyaNp+c02WEADmY/Gk
	gbjKAWpuNTvyGssSbPAJ4upSibpWJvH7vLEy4/ucN7CghxmNtzvFppppWyWjNUbg9pI=
X-Gm-Gg: Acq92OFAD+c7zDDSF9qelcLSAo+5/31YucngBvQ6sf0CXMgSw5menn1FazASMa7LEqa
	5pW3H70UVfdGv5VL/A6ScgTRPQWZV9L+If5JShqOhAdDag3fb2Nt2IWUQBg2k5Dy9hk+lUpdDq1
	16zLst6tbsS/8ArcgorqHa1m09Of0mH1to0Xt4gJ8OknMrq0EvWoUCLQ8W7TDoSIEyAU7IEEmsZ
	6nW4LdUYLlEhSJZbfoCgAUFAl+ni10MYaDOf8Ggt0edap/Nn3qRf3HSNmACRNGCFoifKreEt25y
	qfj17zWah2sy9D04snLinnTm2C7xWjRCJZuLf5/D6vWHq0z0E0HrzBMhVxTC7L48wejp0r+bsd0
	tHKpJA/GJ3cRR9IuRbJ4d6y6D1COuowx+UBgmfnIfNryYcuuR5ZkKgWURT/yJ9famY38V4ZOFVX
	mwQZx4ynS791tZQjNVxJD0y6etDYMTEjmUPlBjVYm0o/u1hnkgacRFX43Y28XO9MbRkJHDCDmC8
	0qPGMBDUJ4Q
X-Received: by 2002:a05:6214:319a:b0:8b0:2017:958e with SMTP id 6a1803df08f44-8c6614dec3cmr60146186d6.13.1778601365090;
        Tue, 12 May 2026 08:56:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a438e3csm129340316d6.19.2026.05.12.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:56:04 -0700 (PDT)
Date: Tue, 12 May 2026 11:56:02 -0400
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
Subject: Re: [PATCH resend v6 20/30] mm: page_alloc: clear PG_zeroed on buddy
 merge if not both zero
Message-ID: <agNNkvRK128bYhrf@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <a09c1848702368c3545b980c17101b5185ab774d.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09c1848702368c3545b980c17101b5185ab774d.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:03:35AM -0400, Michael S. Tsirkin wrote:
> When two buddy pages merge in __free_one_page(), preserve
> PG_zeroed on the merged page only if both buddies have the
> flag set.  Otherwise clear it.
> 
> The merged page would inherit PG_zeroed, and a later __GFP_ZERO
> allocation would skip zeroing stale data in the non-zero half.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: cursor-agent:GPT-5.4-xhigh
> ---
>  mm/page_alloc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index bd3b909cacdf..d70c9ba6b329 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -940,10 +940,14 @@ static inline void __free_one_page(struct page *page,
>  	unsigned long buddy_pfn = 0;
>  	unsigned long combined_pfn;
>  	struct page *buddy;
> +	bool buddy_zeroed;
> +	bool page_zeroed;

If you want to play some code golf, i think you can get away with a
single bool here:

    bool zeroed;
    zeroed = PageZeroed(buddy);
    zeroed &= PageZeroed(page);

    if (zeroed)
        __SetPageZeroed(page);

~Gregory
