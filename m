Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5A3C37BA
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600414; cv=none; b=WD1RQscExYSLftJhLrmkwyj2EKVDdtyB+vwrWs/3LBO8DYxBae10Eibx6q80U41RW2WREE24DvqZ1/tX3lk01pwp9JVRKor7Kcuq08u2tu8XHieDJeo5A1i+aZfkiFx4V+Aj2bve6PZoVVyZfI6ScoXR3a1TvbpCoC12BzVRWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600414; c=relaxed/simple;
	bh=37/0dGsKGXLdxrESXaIymxbV6EGpsUKGLfdf2277/wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvYQF3OXTxg7Uy36Mju7P6AodRn5jmEy8mKN513zbu56+AAmX1gQfKTq0h6sulaANgzCx+H1f05oCTw8HzJERIhrRc/ZGAEX23dAO32O7YrRdTAyr7Tz6onN0QAVRgYPgX/Bq1tescoBU3LmIvFkNkmFlAnCu0PPB/YX5jxKwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=h4g8W5cS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="h4g8W5cS"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50fb1ad3734so68588471cf.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778600412; x=1779205212; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nRmPo6ChRyQRQvzU7w1RFJ68U7NrVdIIy+TpNNJLR10=;
        b=h4g8W5cSNgJT06UidxCGhfCy8m6DuRFQl56eIoz892meCCP8AnAcsLeiLTSny8xI6O
         e94snOA3WO7oh1Ycx/i/CKvUy5/azmdgCDQ6X5G2bk7yb9kSm8E3ukRk8mbaga+XU0rb
         FjBaoHkSnKrGWxKrvCMeZsYtO9tn9pgbtzUSWrDiSkwK6wXmfD/5qQwoaDImiJicOSow
         EG6yzcmIYq1InBI/r4lNduDg1mSVAK0cIdezGc8LrEAJn6kIcnKQQSFDbaDhUvyXampn
         cNredfsX1SR8VskiEoHVxq6uLMn1GXocVLTig4KiHrRjmZcTVKIxGUqJhlZjJEEVMulz
         TXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600412; x=1779205212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRmPo6ChRyQRQvzU7w1RFJ68U7NrVdIIy+TpNNJLR10=;
        b=BYaph+2ywWIF684keHxVBNCB0u9/9qsQq8JHnQaj0INS3s0/qcJO+3JZcBLd3HhoKe
         9Ui1GJpNXayhMZoGdGjH8ZLMej8aumsV9AoimMrLRLxJup7/2L7jjC5kT4gxcCut0LnT
         UFFpc++KJ5oDNFyBFpyrOO3kWu/NOXaRDSRk5QM98AoSNFEdMEQLmbn2fC5FG7vSjMWt
         Q9qlQrdoVZFDw2b71STyyxwrjd0KW2QP6PV77QEbiRuMXDPFXjT8c+3rlh5n3ZxSUtGY
         e0H85pN47MKS0fXkYBgaG95bgM3CW6n3Xplvh2LHVBeTR0FXEMsySAtLItiUkoAqSkH0
         5xiw==
X-Forwarded-Encrypted: i=1; AFNElJ9/VnRVilutjKChiZS0YKmgwaKdqzjgeVreiIbbZ1I9U3xaMLjjH3jIryf0cZUsfIrarEb6r04rzjnxjX2UPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZyjokOADL0PKSnVlYWGhlf69yd0qTA8Xs3VZZkX+fLeDiizZC
	Up85rjkewv3Ip4hmavoojdOlM6TgA7IDRI8pcQ3xoYL0X/v3WBk/9pjsyi4Cyhv/djU=
X-Gm-Gg: Acq92OG5ubw2QdnY7G1CMp9OloaVOQUP68XmnHGYVVFu90mFR6x7+tHChBhoRKP7PMm
	tfQF+AB8wTmOdy2TdrPb13iy81q6CTN75fPeZWXxFhTIzPfHuoj66Giwe0PcHMPdURC4K4RmLU4
	4HVBxaRnTJoJK6KuTQpS+Lpsl5cOmBEZaWCIjQp9utD/kjOFvMZ+Z5O2PXq8/oEvvXh9RErpj19
	XjcK3tptWWhPuEXDKAlLwcZGzjd9psunPoCJ7IMKDOK+05OqRyNqnxJrH34E74hKCEg/rvQl04f
	mMa76z/7MV8vvUAQ7bDT56sCvl2azOKXwexjat3VpG90XBS8fzzN5RG4l45vQIclNC5dDy5+mQw
	/wVZvCxaawiIwFYPRcsUTJp0WVPz3d3HT9vmMhSkz76sfP7n42czlwNON4tk50sl+aKMK4GsesT
	ntjLwuATTjwqrN/XILIelKD76csgXNPB4CnaL3knUrw7L/6zGRe4K7Oj1jLg5HNGoY55NADrYpj
	xwkWDkwLNsj
X-Received: by 2002:a05:622a:1a85:b0:50d:af03:c9ca with SMTP id d75a77b69052e-514cf02bcabmr55182511cf.38.1778600411826;
        Tue, 12 May 2026 08:40:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-100-36-248-188.washdc.fios.verizon.net. [100.36.248.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83dd35sm121584711cf.29.2026.05.12.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:40:11 -0700 (PDT)
Date: Tue, 12 May 2026 11:40:08 -0400
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
Subject: Re: [PATCH resend v6 17/30] mm: page_alloc: propagate PageReported
 flag across buddy splits
Message-ID: <agNJ2BFRVTKINliT@gourry-fedora-PF4VCD3F>
References: <cover.1778489843.git.mst@redhat.com>
 <6d98a35c94fa44b550afa66923c620511e2826f0.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d98a35c94fa44b550afa66923c620511e2826f0.1778489843.git.mst@redhat.com>

On Mon, May 11, 2026 at 05:03:19AM -0400, Michael S. Tsirkin wrote:
> When a reported free page is split via expand() to satisfy a
> smaller allocation, the sub-pages placed back on the free lists
> lose the PageReported flag.  This means they will be unnecessarily
> re-reported to the hypervisor in the next reporting cycle, wasting
> work.
>

Is this issue generated by the changes in the overall patch set, or an
issue present regardless of the proposed zeroing avoidance feature?

If the former, then maybe just submit as a standalone patch, seems like
a useful improvement regardless.

If fundamentally tied to the zeroing-avoidance feature, then nudging
this to the front or end of the series (depending on conflicts) would
help focus the review of the core new feature.

~Gregory
