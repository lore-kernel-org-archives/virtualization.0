Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCC03AFAE6
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955626; cv=none; b=tdu6s1vy5Gn+hQKTcXsBOHr1QNY78tJmCX5Yr2tAnBk/xP3DMZqCdoUqQvhX1YTpjpzavy7yN1Qat/Ou56lmrJIoro4LEFVLhyv9XqBsKWSvnik36NVKvGTwOJvVMn3iQdu5vHOx4/gjA3f1+QSlcKmrMhsWoJkvTQxyVh0rjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955626; c=relaxed/simple;
	bh=h/r1GMmokzmyFyxMCNqp5rDZQeTxEmAM5rpoFQ86kWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iioMDNRYhbSMCvLW8zyZ7Phq38eNlMYdhuOQpfbMMOHSm2Ki3c2jCbg9fmmOV2gxtkdYDx+RaUiV66Q40/GvGQSo79tbGqTKpd1bbxrCQgLmyeINgjCiDxEe3GUDpoen+MnrDKP9TVeOzxnsMeI2IMG2EYtTOfbP/O4crlu2vNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L5HVGc7J; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L5HVGc7J"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ce9de10985so57812826d6.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780955624; x=1781560424; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqf56sX2NNRInjSI0xIcWKifhIm+jUCIOxbaCaOEv34=;
        b=L5HVGc7J2YRgxXyFVFfZtdC9Yg3t5uaSb5DVo85Z8AA1xgOp34lfxT4cVgSiXNLMAy
         J/TxtV9TFeGvvevlM2bjb+EifCOqWNYAXI4N7O8pZTIUA/UgkuAoIADM6nO6E0EWUXSb
         G/bffw/13YAXpz6aiyP++MZdsUXydOFBrcAgcE0xVDxm1YK/ENba3a84JPaKJtOoKZEV
         gnq+PmggKHQ4Rsk+mAlUSPakNZMwHxq9wyosYoKUS67JwRHAxPhBOIGJUvr7cH8pfqbU
         EXl53P91zc20j6WfN/SmmNcxMe7IfMME51yZDmX5nP9utfgC9Y+yyqKI4vwGpjiuc9jG
         zG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955624; x=1781560424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xqf56sX2NNRInjSI0xIcWKifhIm+jUCIOxbaCaOEv34=;
        b=l42jQUYGRMBCJSIopG58vhDxbERfIH5SsegFNgYVqL6ee7DaTgLGOnrndDXBRIog+1
         EiqSINzHEiCZ2t3M2ziPdDNLh6raKTWtDMZbetvSX0/SE93SUU4Sm13Ldco8V5JcUtt+
         hsFMkBhr/3YSvM14AVYCcIs0SgN1J4+tP+V7xT1HYQ0Yrv78sLCWELgKOCfr8orpMNqs
         YDLkUQ44ftDFeWI/L4PPWi2taJMtwkelRdoLVqE6D+nfewfSRJ9pZWzy+uQCptag/l0L
         HGm/tkK68YmHK4oDp8dFGJJXJRZ+3F/s7k8tIPG+sBPIE6aF5XA5VOEBWJ0OP5MPConQ
         0+Aw==
X-Forwarded-Encrypted: i=1; AFNElJ8x6oDo+iiGUVi+LqdDUVt1Tu5YYPPAshP1oNy3GtBcVqFaEn3xh1y4jT7W9I00+Nu5ZfstDSQuGL1AsPQTPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yypra3cSIUDjVkV4iDPYTlBXGPh3LnYxtuucrLagu2Wed5q2Aam
	tFhp9+1lw7N+izGhOSIHW2K8oV7w2T+kmw/laVFPQ9gYFOMxlbe0u7AIAABMNX5v434=
X-Gm-Gg: Acq92OHDSoAwFTk6SFp4S+BMuPGSX6I2ltuMhCS1+IlfK4U5CZSYwec9303t7dbCx98
	37JnGqhA0tQamGQXfxRTLNrJgrru3wUlIwr95IrUA+1yHAfLiOlTu0djMjXL3YMT39+MY9TcDDb
	b8V1Q66m4aytExTGhP4tn4mSKYujGkjKiB+9NtnHVf8F8fBE7LW/f4Wt7Zt+3BcGrzaulbs66QA
	lBCzcilsaVmwueYuNtigETwor06dISHFNEQMvaaZNpohlS75dvm3xj8p9c6Lg3b/M78AcEtJ107
	H+meABnMvr4mW1tnbFbDwBh7DvOWj5iMDV/5+IxG0Txl6MNoEVqo2b1+cMemM+5wiVS/aDe9tt+
	LDzuZpeRMmU2rZ1XfN58yqtxXLAe00jD90QoWw/09I1kmj8poTuyf00ZSMzob8F3YAe7QnknLgY
	C54pB1ScgtTVVe+LivHaFvZWdMLGqR5RUqPMmWv+zfy20auQZG1gyvo4nZb+J2+dmfIbUKdSvpm
	ljmDN+eXReWyQEF7w==
X-Received: by 2002:a05:6214:1242:b0:8ca:256b:8751 with SMTP id 6a1803df08f44-8cee8b1db55mr210068126d6.1.1780955624660;
        Mon, 08 Jun 2026 14:53:44 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fe25sm183503066d6.3.2026.06.08.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:53:44 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:53:42 -0400
From: Gregory Price <gourry@gourry.net>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v10 12/37] mm: use folio_zero_user for user pages in
 post_alloc_hook
Message-ID: <aic55lsQQ4Hegw7-@gourry-fedora-PF4VCD3F>
References: <f92f6f06e5804b4ea7f68b8664b7e69953b50f4e.1780906288.git.mst@redhat.com>
 <aiacZ6_7SG3nvVjM@lucifer>
 <aiblhJv_BvMn_8XY@gourry-fedora-PF4VCD3F>
 <20260608154354-mutt-send-email-mst@kernel.org>
 <aicjNRrHYOOBt0Hx@gourry-fedora-PF4VCD3F>
 <20260608161810-mutt-send-email-mst@kernel.org>
 <aicruns_4nOx0hD-@gourry-fedora-PF4VCD3F>
 <20260608170646-mutt-send-email-mst@kernel.org>
 <aic1PoxSiHzZ40Jr@gourry-fedora-PF4VCD3F>
 <20260608174430-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608174430-mutt-send-email-mst@kernel.org>

On Mon, Jun 08, 2026 at 05:46:27PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 08, 2026 at 05:33:50PM -0400, Gregory Price wrote:
> > 
> > You'd save yourself some revisions by taking the attention you have
> > right now and starting the discussion thread (and consider submitting
> > the topic to LPC if that's something interests you!).
> 
> Well it's in october, is it not? I don't think I have the patience to
> keep fiddling with that for half a year.
> 

You might be able to find a way forward that doesn't take that long, but
that starts with trying to build consensus on what to build before you
build it.

You're proposing a non-trivial change to the page allocator API, I would
not expect this to move at the speed of claude.

~Gregory
