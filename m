Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603463769EC
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316050; cv=none; b=UjNrPVpM2vPL4gM1OSyeZS5sfwuKx2aFVCf5XIcIxUkXvSi1iBnIZ7l54okVdk0X0OEfZ/Kg1NLay6SahxlPMwIcKWp18B/ttHneUllI4Istdc9JRC3UdkMYQRMphrOHFXKiSi4UFIc2YtMRPWW/euGofD2oyHtEUYoKU5cQeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316050; c=relaxed/simple;
	bh=a0Eab8DL9emIRfV+k0U1fyr10lxlZo6PH0bm7czUA9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BWwqioyvoT0J4r+c8+R8ffraIoMsQmtYRMh/GdWHCcZhZg2GEmqspKamTcyorYWqi1WK25N2w/56Qyzdd6aLFsYJlNA4DU3U8Ju9YAVGgh1KJ/KR6MeZCd+4fywSH2HSXqM1baPDvv6JhZDJdDBpKsExWMan5lNTA0SlqJ2X0Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQ8bNbdq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ8bNbdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780316048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8KJursan6RFIgVpOy+Z9gGHMveIQA3OyIKn2aH7TFTw=;
	b=MQ8bNbdqkXJoLoSq0Hpig30ziTGHVaaqGNh72LvgQQOazuB8iZOif085oEeBkseIe+i8td
	1INvULbWag8JmcOjNSvxvUAm+vcuZGdl2nBh9CZNvWJHQoc7wsnHigk/FHjc2AiWC9RPGi
	VSHFKiZCjmShTA4rQwLP9uKKQiOUTJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-bcrsbzzKNeOTTYScZ2d7jw-1; Mon, 01 Jun 2026 08:14:05 -0400
X-MC-Unique: bcrsbzzKNeOTTYScZ2d7jw-1
X-Mimecast-MFC-AGG-ID: bcrsbzzKNeOTTYScZ2d7jw_1780316044
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a7aeaddbso10002005e9.1
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 05:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316044; x=1780920844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KJursan6RFIgVpOy+Z9gGHMveIQA3OyIKn2aH7TFTw=;
        b=ggxAvXJgfA0EuQvRwoMskrP7v66C0xo9eFxuRyJYQ4oyYvAg/ahetcl+4Uy/fjxBuR
         Q2ahrS7FpQPEBmmzHUClOu6Lg586SwbP6DKP2592o28GT3Yhpo0xujdpehrPyJ/RSExb
         pXp07ErvrbL2qYfYRGajm8+ed2DYtM2cDfFDNsSOMO585Aqp3EaXe+EMfEJ88FnwbXnc
         cHN9FYmfC54s+J1S0vbdctZPzYKScfhstqdsRtothzS1WkxwDGwQKvlJtEyUaeUovr26
         rZTb7/rc9qgWbovDHol7Na06vFGbQa8PLGPGzf8Ss5Rfcm3Wl6rUQDhO3A994+p7L0HJ
         F/iQ==
X-Forwarded-Encrypted: i=1; AFNElJ81Ktkw+AiY85sGvPss26s8hV2bYp+mNi2pPIrkZMoCek4kdZAVH0YpPJyWk3JgoTyN8bCBEP1+cSxw/ipctQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb8FANkeUmyrD5fGMaKfk7Z+3Uia2JUMJ4rqfIlCmcZUQuc3Qg
	FmpwFS8f7hIaRWvOPjhQl6S6OP1KCo0pC0I8tZAAGLmO9DCZ82XUwkMU/sjE6I7WuvZEU4IYxMN
	3nvQQ84TlxMOOtzAtuqc8ZpQjQWJuQ6O93K9kHOCQMC8yf83syz/sygIqIZ+JvKYGwuwE
X-Gm-Gg: Acq92OFtOhRGAa+A473JU37dTi7n32VZafC9cjq7xRcbADgnmx4Z4jmX56m2rkyXITq
	ryxIzoRH1ptN0LbybPz4fnzyjCODChX92kAPgOpP7nZJ7GD8dxz696QzPjPkrWetZcbxyli0tuA
	UB4Gwf4d60tA2UPBxBvsJHxwazWVo9yNPUbV9sgUeiaWlburgWItNHVgw3xmNBKbZWClu/SlJch
	eZSCmaLU+kPKsdcS529+xDtNASDpzobFJOkksoTXTVsgVdpTMtzs6rwU2SnRJwiz3ooxcH3yS3e
	G/qj3kBzb4puUBJkKyjgnKyV+b/91+RqtR6bJPYTxskReCJZDxpf95FoFNwCuYKUevhOL4aQBP+
	ZWzFKNcTmH1XCbJxy99CxhY0Z8xszoP4KvX3ls0Q6xOIs21i+2dyCMQ==
X-Received: by 2002:a05:600c:3e8c:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-490a2a02b06mr143723135e9.3.1780316043750;
        Mon, 01 Jun 2026 05:14:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3e8c:b0:490:3d48:6cb9 with SMTP id 5b1f17b1804b1-490a2a02b06mr143722365e9.3.1780316043140;
        Mon, 01 Jun 2026 05:14:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c053029sm75910015e9.0.2026.06.01.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:14:02 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:13:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
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
Subject: Re: [PATCH v9 00/37] mm/virtio: skip redundant zeroing of
 host-zeroed pages
Message-ID: <20260601080712-mutt-send-email-mst@kernel.org>
References: <cover.1779315441.git.mst@redhat.com>
 <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 12lzZM1lQmekKJVxT_u0OA-3uXv6yMfDVRstlxusR10_1780316044
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I went over sashiko review of this:
https://sashiko.dev/#/patchset/cover.1780067977.git.mst%40redhat.com

It's mostly Sashiko apparently not seeing the whole picture
(e.g. is says "an optimization is missing" and it is actually
 added in follow up patches).

Sometimes it is unhappy while there's an explanation right in the commit
log. Weird.


It's a pity there's no way to respond to the review, to make it pay more
attention and reconsider.


It did flag a minor rebase artifact (declaration landed in the wrong
patch during rebase). Mostly harmless but if there's a v10, I'll fix that.

But it also flagged 4 pre-existing bugs:

  - page_reporting_register before DRIVER_OK, theoretical race in virtballoon_probe ordering:
  https://sashiko.dev/#/patchset/cover.1780067977.git.mst%40redhat.com?part=4

  - spurious OOM on large-folio swapin race in do_swap_page:
  https://sashiko.dev/#/patchset/cover.1780067977.git.mst%40redhat.com?part=16

  - free_huge_folio called with refcount==1 on mem_cgroup_charge_hugetlb failure:
  https://sashiko.dev/#/patchset/cover.1780067977.git.mst%40redhat.com?part=20

  - double-decrement of resv_huge_pages in memfd_alloc_folio error path:
  https://sashiko.dev/#/patchset/cover.1780067977.git.mst%40redhat.com?part=21

All seem unrelated to the specific feature, so I'd rather put off fixing
these until the feature is merged.

-- 
MST

