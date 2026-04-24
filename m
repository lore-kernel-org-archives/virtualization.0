Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C723CC9FE
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033996; cv=none; b=tiwTCKI/rjqcT6YrKlrAuhuwKo/4NtqUcH18WyzVpSB8je6vosQ9e+LaytRhUsLN7ske399yWZWNOcoDCZFq2lC8Uooy7HSblAUEOlQbal9kCF4CxzrBigyYgf2x9vDFZI5nPtoyEI3NVKPjaA74Rq1bXNvIgb4CiB9ksHBvuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033996; c=relaxed/simple;
	bh=sUphD3ERN3DgK3ao4eQ+aHuLLL6WmNwr6g1UJrLlCj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jNSW4+C0hsqil7mrQijiwgn/1e4ggtzdJzKn5oM1z6SJ4SlC1DP9O3prVEKysFdP8GDsmCTus6SDELhD5iw7+Wqwvkf0fTOyCP+gwwock5kDUsYuuKAYjFHpdRgfmoTnlxaZd4zluNRKHUbjS6yfTaSXLMXUGdxgE+IO30azOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMmTp+r6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMmTp+r6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777033993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iU5HGQMMAHkFsOD8j+WiLpo76Kie/jMXtxjrTFTeJas=;
	b=NMmTp+r6aQk+IZjY5mBWeiK4FmZmkPNj/Eac+HM6tSywTy/esUBNHkIJ3prjWg3ddaS7Wz
	40cbMlLFXQQkpI9bGuF6JUS7ttNTw+vRiEuWxqEGPse6FSsaWTuRDKJiEBVPuacWi4+sRq
	xSLkG8hRf2/LJZwl0hokA9RHxi5xlM4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-2VQN8_JuOZC-zAsZ5l2MiQ-1; Fri, 24 Apr 2026 08:33:12 -0400
X-MC-Unique: 2VQN8_JuOZC-zAsZ5l2MiQ-1
X-Mimecast-MFC-AGG-ID: 2VQN8_JuOZC-zAsZ5l2MiQ_1777033991
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso64856155e9.3
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 05:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033991; x=1777638791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU5HGQMMAHkFsOD8j+WiLpo76Kie/jMXtxjrTFTeJas=;
        b=Nax3CZo3S3kvZVi2kjrs/IxrifAR+dbqtNbx+1X4SZ5ir6rTzYRTUciq2OJp+jcJcv
         /Qv/5vRu1ImWpTvIjPjBPla5Doet0TF9Irf+EyQLli6kKwHSG1/PhvZE/cmz68vj7Z8L
         yra0AUFjiAxwocPAmy65ESNI/BmdofIpF2S2qhwFLR2nzfFTtDfDWR0ovYe1BKE+qJEx
         vtEdiYWuewB5tMYFwDLoPP90jXOw4HAmPo35n0DTDn3AoMDLZCgDoK28+O/2r5YKfoDN
         TiS2itqmJzAWYECBu4XpK77/QjbY0pXkb8l2BFG3aG2G80O/YfVJEW1ciVDIaCaN1DQ5
         d3GA==
X-Forwarded-Encrypted: i=1; AFNElJ9so8GFY+YtwmtYlLvRh3nVm5t0VgxQGZvlSa1ZurlwLzOThG0iGI86IqJsxp52BaOaz/UYp6kDWglhPUvxqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0uCNEyw7I+BwYlCTrpIisNR+cOUd4yECy34HEGt+GegK+LQgd
	n8nftCYd4WVvmewJNWGzEevbJBuJexeRBVlwmfgv90qnWECO1855L1dsZ6OptlDCaETP8XHrZzE
	Q1WeSrFe2ea+w0oNuSqONmXP1s0gvCUiaAnsY8zxcjYi5sNGECjTc4uvtJ+dKSYUDn4Pi
X-Gm-Gg: AeBDieub4aKbvgoEH9NjgqtXDcu/zcEHt1N+8t//4HIA8wchfgkbbsn4svZawMYFDhe
	q34gIUlZbLay0aikKVEztoh1jRGEydw3/UsUouKglUIh5AQRiwPwRO8RtG/L8vZ/Ko87AGFIll5
	84zYXG0oRFhK//hjwG0MsLFmm6PybJ6dPFkleAlN1nfLDZDCQ4Y4tqCRDseyFugjI3CZnBn9Iox
	847CyIZGEicdbLJXdIqMQPVxfl5rmPQPtQkk+yQnyYSphFTexMzLZWvR15yrd/kXIXREg5myqE2
	LfFYWabAk2qNENS+Re4uxMEdu11JNIJylrVCzJoEWxK6lMCqxrNqZtTekn6s/gq8J+a45g+LW44
	NPegL+1t1BGc85JNAlhM+trLFh5cjh9S1+PC/8IlUq3bTnjStuDwFHw==
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr307985925e9.11.1777033991192;
        Fri, 24 Apr 2026 05:33:11 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr307984885e9.11.1777033990672;
        Fri, 24 Apr 2026 05:33:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5a579bd3sm226459065e9.6.2026.04.24.05.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:33:10 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:33:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 01/19] mm: thread user_addr through page allocator
 for cache-friendly zeroing
Message-ID: <20260424083228-mutt-send-email-mst@kernel.org>
References: <aekluxNPxF8CN8fL@gourry-fedora-PF4VCD3F>
 <20260422171315-mutt-send-email-mst@kernel.org>
 <aemglPlcwFFHNj1A@gourry-fedora-PF4VCD3F>
 <c165d6af-4a35-4a41-9086-ee307640c044@kernel.org>
 <20260423074433-mutt-send-email-mst@kernel.org>
 <aeohzbmhQAoOODPm@gourry-fedora-PF4VCD3F>
 <88b0765f-7cfc-4e44-83d2-c01a1755c842@kernel.org>
 <aeozRZ9AvW2jTQkX@gourry-fedora-PF4VCD3F>
 <016cc5e5-044c-46c6-a668-200f90a64d85@kernel.org>
 <aeticBh5XlAlD1vn@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aeticBh5XlAlD1vn@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Y7rRebnuJLdqoo5bKgdRiZz9xRVR640W1lhvw_xcJg_1777033991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2026 at 08:30:40AM -0400, Gregory Price wrote:
> On Fri, Apr 24, 2026 at 09:28:36AM +0200, David Hildenbrand (Arm) wrote:
> > On 4/23/26 16:57, Gregory Price wrote:
> > > On Thu, Apr 23, 2026 at 04:13:50PM +0200, David Hildenbrand (Arm) wrote:
> > >> On 4/23/26 15:42, Gregory Price wrote:
> > >>
> > >> Maybe we could forward the vma+addr here and call a vma_alloc_froze_folio() if
> > >> we have a VMA+addr to have a clean interface.
> > >>
> > >> But really, that hugetlb code is rather messy. I'd vote for leaving hugetlb
> > >> alone on a v1, and focusing on non-hugetlb first.
> > >>
> > > 
> > > If we're ok increasing the buddy surface this way, then I'd vote for
> > > only updating the exact interfaces that MST needs to update for his use
> > > case in a base set of patches, and then have each additional updated
> > > location (or logical set of locations) updated in follow-ups.
> > > 
> > > My initial go around with this - the patch was hard to read at best.
> > > 
> > > But I also think we should also seriously consider not increasing the
> > > surface of the buddy. 
> > 
> > Exactly, that's why I am saying that vma_alloc_folio() is the only external
> > interface people should be using with a user address. all other _noprof helpers
> > are supposed to be internal.
> > 
> > For hugetlb, we might need another interface for frozen folios later, which is
> > why I suggest to defer that.
> > 
> 
> Yeah I follow now - we're of the same mind on all this then.
> 
> ~Gregory


OK v4 incoming, thanks.

