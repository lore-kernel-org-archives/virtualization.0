Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0544218BB
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516151; cv=none; b=i6LR+XtJn7ptouGaorTEw+L6Q5BGb3Q86T3LXTpVKuTmWDuDUC4ylRh5JiAcSBGmoFDRS9GBOqy/8PStSg0LeheIfaS2/9p5dY3voMf1qsNMLDLxS50F/HGlPU3qmnaiZnPaHuUV3PE7vQ9erDc0TbqdVl/1eHDPmZ1+3Cl3tvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516151; c=relaxed/simple;
	bh=tp3s7XsWeHMzVvK3ORsvPhXsl5xuNWgYBmhjhQzA0y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Crd0qxyFxq5FcQ9fCdo+rNfc33togmfLDizN/B4zIrMsApitYY+qucubrKm4mbA8LQVFHDoWjzFmU0m91mDMbfjyqPXJET4W/VZODcgJlpOsiumrsxICZo6Qi5b71GrYaM9NHSs3Yg7s0PRZjCEkk8w59DFv5fpEukr3Lc6qGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OopHcI+s; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OopHcI+s"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50fbd79350dso41778141cf.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778516149; x=1779120949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjyPQOMxfBGAFix2OI3ZEchIRFpO76FTqe+eu0C6CpQ=;
        b=OopHcI+sW16kG6qF7UrT4V95DHzXclgo1Mf0yM7C+7Kt5IarH6B3KBculNo1uMH0hV
         Euto09Bk/1iljvEd6yUUYNxHfHN5v3JuhQi7QB+O/kjGUKFqlP4hBZm+fdv0joyo7kVv
         yhPSqMF0hYcHi2KcGdrBX4puYDLv2yiviTyL19C1E8K/WDpkJ2lMR4gxXQktDT4OrXxf
         bMDmqeSLBXIY0u6dQ423UeupYJhQfM1gGcj7CzbFjf5U/NdJsJ86LHMFO+2bE+eegmya
         MwHUKrAkSQcxR+mI5F8V/7nitl7V3belrecdKhzj/skTqAQabQ+drU9q97MTbZU1FBQy
         6Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516149; x=1779120949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjyPQOMxfBGAFix2OI3ZEchIRFpO76FTqe+eu0C6CpQ=;
        b=jsryZ/iZ+LXdVLSf5PpVT21Jj9y0a6zuVgnY6m69p9h8/sHJOqluIn/tZHxFuSv/bh
         oQ1VonxgCYJPhzpjguC4pxYbnOpt2jffcacUlaap8D7I4eOefMn8tAnlEhNnjtzBox4S
         JNBuoee6G3G+7caJsAncu2XjSEElj0tSMjHTH4GU4WCYlUHkLvbHaS5CWtAWQCYhqRFH
         Oin/jJ4/Z974S95Mpls26/PopiShbipGsYXWK8UxXw5WWc9ao6UQx5EhYeNHJLU0c0L2
         4AanQ165jjbnlz4GAadRlHBPsnb83yGNooQuHLEs5/JkK76r1C3UF0fvGKeiyWUbPFZ5
         UCnA==
X-Forwarded-Encrypted: i=1; AFNElJ+fsIj6mhapxVtO4+T8e3LC6k3FbzPeIkbeOUVoHOoowc+BID40Oy6T15fw3WyLfGFyUEtPGOSU2ALpxHguQw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya6/ABCw8obb6wMcw+KUvrtG/c37Hn0hwokKcfJBqcjm622AUT
	30Sx6sXUZENqGJ9qLsrFFsp2oTCXi1sQaSNbOxh1hKUMw5DaL1mhC7GUOoWNmR5HdlE=
X-Gm-Gg: Acq92OHLTn6+pLEm8q3c25QWAG4d+JagDmd+yAUOs0khetTuMJTP+XJfz8ZXpy4z9Ix
	+2cvFKb8faNzXQ6ifVhrooqlxPXkW0U58dOs21k2rip/xbjc0XOLVtn+9STangKF9Ecipnf/QqW
	sakh5AHgogoraW4qhne7xFbj/PBxiVYnicVneEU+j7GEtHcQOTJK7t3reJDV14Qhi1yqBl1ViG3
	oDUroMKuRg0Npqyr+3VPrYL77cmbQHBZbqJDwoPx7pXjHD+EXF7wxoDgXPNsjjtsbFKBbUsUZxD
	FVJI9dQfGzZ1ppBJxLfGvPYMYzI5ZnTuGo01lAm8uKL3FvSVa8MtKC72BP8EPPcfyXMueo4Z2dn
	ppz93xvzoZamTfRs5n3YDMfso7zwYC74/zwaGB6YCf6FXcRIYVrAz+uhZysEDVBTyojMCKz6JSt
	fFBnQSdtzrcC2oZkQ3/q7ndk/Hpr6wk1jXtQQM4AOMxUKeq4QOTcvykmWMxR3RQ22RT0MSMOjmq
	A3JRaJ3fUyf
X-Received: by 2002:a05:622a:2612:b0:50d:9efe:97e2 with SMTP id d75a77b69052e-514a0b6ef2fmr155357011cf.44.1778516149163;
        Mon, 11 May 2026 09:15:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148fa78723sm89504691cf.3.2026.05.11.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:15:47 -0700 (PDT)
Date: Mon, 11 May 2026 12:15:45 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH resend v6 11/30] mm: use __GFP_ZERO in alloc_anon_folio
Message-ID: <agIAsVO2o4_gIxHL@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <99c79224ca94e63dfcbe8523cedb2a8d658bdce1.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c79224ca94e63dfcbe8523cedb2a8d658bdce1.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:02:45AM -0400, Michael S. Tsirkin wrote:
> Convert alloc_anon_folio() to pass __GFP_ZERO instead of zeroing
> at the callsite. post_alloc_hook uses the fault address passed
> through vma_alloc_folio for cache-friendly zeroing.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Gregory Price <gourry@gourry.net>
