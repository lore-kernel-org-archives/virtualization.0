Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFDA40D58D
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036669; cv=none; b=sCPwmtK+3HCUeV0PL0Kt9bbnEAp1UvvrDMXJ8pkexWSN+ez5YHxQHyN2PsVkGsLxW+Y0OBOZMUgsF+LM4XFhWCI1oC2TIVQS+AD0poeTTSB4BScXAx0NcjLljX+vstBTz/ZE2jc3rtccvo1fmH2cIKfUNeu427YUjeWFszPLpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036669; c=relaxed/simple;
	bh=IhujjSgqeJpws/Riu9DYUzx33Ve6XDr9WLgE2Q20XtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SBo1TEjG4QpLRw0hDXs45b5h0qskoGiGm3OiXJ6aT2wHVBHkJduKNNDv788JbjNeBPiV30QOPWIrloh9at3anxWQgt7X8TQUNAoRmpufw8epmMTLiS6BUAQPfX5TdcU4Bwm4XPG4QTm9oQCxpmY+ALRkuy3J1BR0cESwpAimQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgO1q+TW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgO1q+TW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781036667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTUa2dI672FDZzKGV04n9VclX+EgypGNikp/bmy4IOc=;
	b=RgO1q+TWO8/tFnevqDoV0a0ucccHN42YiLl67jxFW0vgLsHQ/Kl3+HmciZZeHFCXI4NYky
	oPdoSFSqiVlVFkNpafkkF6kegF4dKiY62YyXTZYPMUnnotEyT7I2RODJcan1b+7df8ispa
	N55OA4nxhEeZmbKNAnVMAWT8f4G2nuw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-jpgiGxyzNQi64HVzWnGUNA-1; Tue, 09 Jun 2026 16:24:25 -0400
X-MC-Unique: jpgiGxyzNQi64HVzWnGUNA-1
X-Mimecast-MFC-AGG-ID: jpgiGxyzNQi64HVzWnGUNA_1781036664
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490ab3f6e55so22754845e9.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 13:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036664; x=1781641464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTUa2dI672FDZzKGV04n9VclX+EgypGNikp/bmy4IOc=;
        b=ORarKIOqW4myqQSoXsefKFj+wqTVU+wKCA5z0S/9vmlYzN1hf3DovuFEXxpTJdF9Z5
         tEt1V2MzRiUOvsrqc9D9qKCcBsBpNFo66+hkLuXGQTNHOV++ECHT9Te0FTGiqxLi+v/s
         4XEyVeBpf0ROQwpJxqB418jjpVSKAl+FmOIe1dW+7ERd98A7LTi18Vidxl4tSgbIi4fB
         oqk8ew/OdoAuADZZAx6homL691QFF/jhi5MQUBi/cXIViY9/LGMq05HyOiWhvPY7H0YH
         yzboF8GykYpDqhBGBgZL4oAfDAWgl4BxvG5vNyRXBhusPw3V40o19wPSKz2VDo8qN6Ww
         FKCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hSy3UVaa2kkud5XYBqzF8TBHxWileVK5/vCalLIeLa/PtHfxOEQli9HpicuyoVEDpuM22NIUeYKUIPnh9eA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSz2Sjmi6b4NQYCgkHvHxwJRRxRb4vdKjyQmkjtJhlaBuTef1c
	xPFkCcAI0ZwrXd37Xhcdn8Ll9K9cizj+xuISDDc3iwfxTvoTTYH/TsVM76MhLLK5BRXfd5GG9bj
	gB0mPdrnAUYEqyPbJxWYLFfxumWWdTpBVD5Bc9lQsneZQYSyVTluZUYSs7XVUf/rKG0HR
X-Gm-Gg: Acq92OGPzKh9Ik+wsFTOO9xE1BLdoUFewasKljridsB4gMabgv0kxSEndoiRTIUQxe4
	7aZqPbPptKABDUyugO53oYlFcsFMi7pHdYmcqB3nTbHl90R3Lj20iphfccFX4Y/0Q3eFtxRWH8x
	KhO4j1dpa4J/lSUFVdZhsU+OYam42nlEWaPQYnqJOq5AECLnYhIOJD3yQ5/9dWY5+Rx8zCHx7KY
	HH/5vnFlEq9RLksszr9311X1nzO1opT+Bir3VuzRNt2WrWi3LB11i2hck8PsLWotNrf+bAJ0I47
	FGQH7d9ifzBVYMFwMYjprbn0tcAMKKVrB+2d11RGH7ydY85KZVn/buoN/BVNlZ2EraaysDyzHci
	o53WIrzya9jj6+6YZSjLJ9P2om2tPQQV94zsGrLwOgDFtPWKA/NEEBw==
X-Received: by 2002:a05:600c:674f:b0:490:b4bc:4f3d with SMTP id 5b1f17b1804b1-490c25b06a1mr339837705e9.18.1781036664332;
        Tue, 09 Jun 2026 13:24:24 -0700 (PDT)
X-Received: by 2002:a05:600c:674f:b0:490:b4bc:4f3d with SMTP id 5b1f17b1804b1-490c25b06a1mr339837295e9.18.1781036663783;
        Tue, 09 Jun 2026 13:24:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm62850063f8f.25.2026.06.09.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:24:22 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:24:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
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
	Andrea Arcangeli <aarcange@redhat.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH splitout] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-ID: <20260609161227-mutt-send-email-mst@kernel.org>
References: <df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com>
 <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260609111020.e88f51a7b6ebc37360d66fdc@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZTUM52lYOjpfMrFhwRFMxSi3qWLzLCfj7tmZmySho4M_1781036664
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 11:10:20AM -0700, Andrew Morton wrote:
> On Tue, 9 Jun 2026 06:12:49 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > TestSetPageHWPoison() is called without zone->lock, so its atomic
> > update to page->flags can race with non-atomic flag operations
> > that run under zone->lock in the buddy allocator.
> > 
> > In particular, __free_pages_prepare() does:
> > 
> >     page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> > 
> > This non-atomic read-modify-write, while correctly excluding
> > __PG_HWPOISON from the mask, can still lose a concurrent
> > TestSetPageHWPoison if the read happens before the poison bit
> > is set and the write happens after.  Will only get worse if/when
> > we add more non-atomic flag operations.
> > 
> > Fix by acquiring zone->lock around TestSetPageHWPoison and
> > around ClearPageHWPoison in the retry path.  This
> > serializes with all buddy flag manipulation.  The cost is
> > negligible: one lock/unlock in an extremely rare path
> > (hardware memory errors).
> > 
> > Note: SetPageHWPoison and TestClearPageHWPoison calls elsewhere
> > in this file operate on pages already removed from the buddy
> > allocator or on non-buddy pages (DAX, hugetlb), so they do not
> > need zone->lock protection.
> 
> Sashiko is saying this doesn't do anything "Because
> __free_pages_prepare() executes entirely locklessly".  Did it goof?
> 
> https://sashiko.dev/#/patchset/df06b66fe4ff8e925ee0714955abc2183a727b90.1780998980.git.mst@redhat.com
>

Oh. So it only helps with the prezero patches. Maybe other places where
flags are touched locklessly. Not __free_pages_prepare. I was too
focused on that. Scrap this please. I'll try to think of something.


-- 
MST

