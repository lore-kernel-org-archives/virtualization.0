Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47683EB7E8
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766829; cv=none; b=mSeVNJFxlOftjW0zXzcGobNxggQKx7AxbiLhro159ul0AtjJp9UUhpAlPWwd4bLlmcBWhrVlKsZzwfChVftJtYU/igqJH1WrOKpKEEoJkLbjrTI3Ym5Yc+Xn2P425uUluH/fuOfoCu0luiXJU6mzRFsrDdOWFuitTRupmhcbhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766829; c=relaxed/simple;
	bh=csuW3myMDRTwfSkVr/fGJ+LdsWf9iBuZuAecKJ3RvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irNWSQ0f39bw/Fct5UZyFYeH0YW70quMaPz0L5mH8+JMdSKgYmDvcQJuleY1iEfREafs7qcnpr8sVusfqiWnEFYM+1DzNgXp3jSD+JbDsHuyNcg1quclfVewavpMl3sM/FF9yUSKelaH+tSBGrkaGQGXpZ3fcg5cx9cNgX9JwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=laDEyBlh; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="laDEyBlh"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-90d13fa59e8so337239885a.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778766827; x=1779371627; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+SudBIcbJEYVdXIJisNlY3md8aZgEue8Fntr+vI0eA=;
        b=laDEyBlhYU2wOsyE6TjIcdP7l+7qUZUOZ36XoFmGdnyzFZRkVDrlRsfMHZofHvGmPU
         eQ6NMYW4QTgtEG2GkT1QxTEsSqeOpfa/tGQ9GKAoYFP4pLkOBuUUOJNUMvsMQ+1JGlUp
         PaHeQY3h0WJqhP5qWLKyxMSKu9oVTxxOhSgpW774u5rfS4GXv46LDNoP7IQe3if/Zrwn
         jmBu+Hr2e6rZahjx9VHOUcqB+ggeGFy+6frNnpRbJi0ZM4bNS02XgY2cgCTNFiOV80fC
         3DLjnb9xUYFjQKD8upe0rh3RjxJbWtcQ8hNxWmrZ2TlaRuLfKTZ+4GNvnDPdbktQln3g
         tXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766827; x=1779371627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+SudBIcbJEYVdXIJisNlY3md8aZgEue8Fntr+vI0eA=;
        b=fyQ+DyqDhH2N58fjSY8/mTBaFtAsA8zV5ZVXBpHukeWzHLKmoAwLZyY4XGT5rSJmQ7
         tbQaznNknZ0jpSgtX3HHH/qaPPeHuWXwDmcLaE+oxNXwuUT+aDDFKBKAu3lRLmTxhRaE
         ogru+HFXBhPY/lMFbDEkWPOwx44EbJWFlDPlmixlkMRjgBzLbrgHsxs9JJwbYebKhWZq
         UE4T52SMltIEtpBQjNzxPQdcReLYSCfqlc4GsWhXuNB0qYsWZ4XZq/k8/o8HTB5oY72B
         7PMTR/S9Dn+saKIcA5SSz3D8grS4g8Kb8jJqwizlnIgHawlimyesUclEYrbSkRNWyx98
         UQyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bvX9Rd9mrO0VCKflddxfqbdiA3rCUwZpzlijZdn6kHVRQvsg55gTK5jwNg+VG24ZROVQ9DA9rPJDykIdq5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/UaTsOOhXIdnF33I9eqwZglcSWGCfSySW36+BsQkOPp2JKXMi
	IMpfoOs0XrBaizewHKRRB3NiTictETYYD2isAdXvS1XKMDpnneMxta6h2HaCEtWQsIU=
X-Gm-Gg: Acq92OFDaUYM02cGldIpDgquiV72bUEvh+Rk+30+S3xnXfaIweQc934UzHOUfls2sz8
	+g0UwQDIuFzyUn2M64VZ2oSyjShJA7GsqLJaEKbeHKYvdoh9DYlJElb5G+9/ozson3XRqX8RWiz
	4AzOSkUFM5dy72td7yaUr+vWYySdOlVXv27ycWT1K+0IXEfgQN26WpTklERtteXcbBrT0kYt0ux
	YWEreDl49mI6VxLaXfq7jj70RajBR1KD+MuEoH/7V3wkuLcdrtfBWQJKTzMYi4TWFCJnLsdGyyI
	8ciGkqZuehzfV1TaX5bSoY6RJrxjHpDlamcbAWY1V1BBGgNsx/h3R1Ytd69S2kLJEKr/lZNGndO
	OyOsHihahx3G9y9CNVOM7KxberwV7YR69Yh7Sab3cubHuEOlvsSuTE1LdmzgaQ/kqzFQiCuKTSJ
	Im/0b5SXztVMhzwIXuC7YEptT7XzIQJkjcLNUne5B/wnqHQink4t+9LT15k6wbRoCyNQ+Atfx8B
	L9AbsN56iX5
X-Received: by 2002:a05:620a:7283:b0:90f:d004:5480 with SMTP id af79cd13be357-90fd0045772mr809098685a.6.1778766826553;
        Thu, 14 May 2026 06:53:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba9454basm253697485a.12.2026.05.14.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:53:46 -0700 (PDT)
Date: Thu, 14 May 2026 09:53:42 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 11/31] mm: remove arch vma_alloc_zeroed_movable_folio
 overrides
Message-ID: <agXT5s4FLL54MS-e@gourry-fedora-PF4VCD3F>
References: <cover.1778616612.git.mst@redhat.com>
 <7d637bcac4bb5705388136a75f0fdfe2881e5f20.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d637bcac4bb5705388136a75f0fdfe2881e5f20.1778616612.git.mst@redhat.com>

On Tue, May 12, 2026 at 05:06:04PM -0400, Michael S. Tsirkin wrote:
> Now that the generic vma_alloc_zeroed_movable_folio() uses
> __GFP_ZERO, the arch-specific macros on alpha, m68k, s390, and
> x86 that did the same thing are redundant.  Remove them.
> 
> arm64 is not affected: it has a real function override that
> handles MTE tag zeroing, not just __GFP_ZERO.
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

