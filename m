Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2983D649B
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776605; cv=none; b=lFp9DpvjjAImwoYbJY1NYPMbcqg3/u6zDKw7NyO79MwbS15TVHo5weWQHbq0os7S3OsMq9ovHM9qLuc2ucQClHUJNJt/uf5L/9DYX0rAxWEr4oZSeEUjj81k/I0pjHMqK02wtKXSkKZZxIe8ovF1Uj5R1rEO/6OlHHtZZlUFyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776605; c=relaxed/simple;
	bh=A9z3EUE6nKMyvYqIonXmWDAZV+Q7qvCA03jrurpJIyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ur1Yd0I7fbTRZl84dT8i0StuQrMMlvwMkcqM6m6Fp/9e4u11i/gNTzmmJQ7z+jfdTvaZeC4bk2oRc9I9iP1DA/Px1oDyxiN3t63opEGOP3G+Qslgp4XPDTRCLJxJbDTDwOsf/hfqThK0T61+s/TMaQoWfYDJ46aTBAJ56JG/Gk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJSKJC6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJSKJC6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776776603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sVf8kdVYwRFUCCaA8aQHSDPXaxh6wDEbfv1fdU/ML/U=;
	b=GJSKJC6EhVg2eT39n4ZeKkF4GVwQdO8ZI3/KvpZ3dK5Fkq4zkl27ryaIrRvaxWaLz2VP3T
	ecqc+OkpZo+Cnfrey5xTHOt/Qvc0wTEoZkpxvvTsmBgTBZoPxIR0ypTUI6QhDziHKKhtIF
	6WLGSdOYl8tZu6jMiaDwfiLFnNbuRz0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-s0b11sJTMY61nVaFEYd1CQ-1; Tue, 21 Apr 2026 09:03:20 -0400
X-MC-Unique: s0b11sJTMY61nVaFEYd1CQ-1
X-Mimecast-MFC-AGG-ID: s0b11sJTMY61nVaFEYd1CQ_1776776599
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4891f97aef0so10930075e9.2
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776599; x=1777381399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVf8kdVYwRFUCCaA8aQHSDPXaxh6wDEbfv1fdU/ML/U=;
        b=OIa1OBgdxhgEIrEVRongZU6F4DhRw3PK0K0MFUECih6FAzUERQMpBx+BiicbUhLEcN
         H7XmW/2ILRkloIk9xNkWWz5ovV8KA0oFJLSl5IuCT0sA7vLUYsG5M7yX31GmJXlWs5sy
         wnkyqS9bH2IRCagWcKTd86AZc+hvHIgLftAi1i5p4PKZqtYnxP2UMwFyN7wJfOUrY5Tx
         KZXCy2uRAh4IjjDErpiVgbHFSAYWcHmqiUhtdfF46shIHxwXm0Et0FCjR6gMAgvWeckX
         9WDawauyROdI8W4nDauiY/wSpw7qp3XQHf2J9k56UQnMymZ72CikCyf258VNaoO0Ey6M
         /r6w==
X-Forwarded-Encrypted: i=1; AFNElJ++81kznbhRMg7BQ6MHJzbnGV1y+SvUYwPwo4eo5MDmjaaOp6zCcpv54cHx7Kyz+yI1iVCHCkt9NZuTmdg7Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj7FXGFuxy96MVPn546BhJM57SMDgdfZjtOmfFrKc5IegU+qCQ
	EwJd3P++IGb7d4l7eD6mNuqE+KDJ1DhhrdCXWZWaqIQTyBUeBYNSID4bXcOa6NEfKVZBNe3auIs
	N4VMsiZRJL1yXXa0M71ybI6vG2MH2n/LK5DVWj0c5w2FHgc/MBLwb3pCbKa0dm/8syATz
X-Gm-Gg: AeBDieu9Q+7yDAHuXHjAjrYuLg5+jYA4cJJ4h1VfF6+r+OXuMVr2IWM/j6dD5G2FO0s
	goZ14Is+G/r3q1WtGGSzi/ZtkEuXymPdEj/Xhj0mr2hlZtLeZFDze5+Hn8ou9WZ4o5vaoFhkRZm
	b/RZMuzjXAslstn+lH4HMZEvPs3dfSSmwRjPfK8F8ODT/0zKaxKBMhtOToYlsFwOuGmFG0IODzX
	v38t62xYtpxr8vErH6qQkaYaQXqE8XsgGE+IrF9oiQxtO5e1qHwAbKEyl7HIx0sfEgZ/Vag+aSB
	iVIAF9q1Q6Q03tWjhBsStvsUcQ09r3Wpie6AUmbNPGNAY0GwA4bUnLAT2r9bCq1YY/QsI2jRlLD
	/VTF1zBZ8fUSIVxLgHh4DViMZNi7XUpnDOob0arqOgGE+3eY1kKA9qw==
X-Received: by 2002:a05:600c:c4a6:b0:48a:761:57fe with SMTP id 5b1f17b1804b1-48a07615be4mr102694925e9.0.1776776598663;
        Tue, 21 Apr 2026 06:03:18 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a6:b0:48a:761:57fe with SMTP id 5b1f17b1804b1-48a07615be4mr102693515e9.0.1776776597864;
        Tue, 21 Apr 2026 06:03:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7c0eacsm116411425e9.35.2026.04.21.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:03:16 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:03:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH RFC v2 02/18] mm: add pghint_t type and
 vma_alloc_folio_hints API
Message-ID: <20260421090238-mutt-send-email-mst@kernel.org>
References: <cover.1776689093.git.mst@redhat.com>
 <290d615a001cf121dc0c604eb79451bcc7917baa.1776689093.git.mst@redhat.com>
 <87pl3ti0x8.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <87pl3ti0x8.fsf@DESKTOP-5N7EMDA>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PmxyI4aMzY6XpnkiM-VJu19m7wrkPXLbNfk-4o8FxMY_1776776599
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2026 at 08:58:59AM +0800, Huang, Ying wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Add pghint_t, a bitwise type for communicating page allocation hints
> > between the allocator and callers.  Define PGHINT_ZEROED to indicate
> > that the allocated page contents are known to be zero.
> >
> > Add _hints variants of the allocation functions that accept a
> > pghint_t *hints output parameter:
> >
> >   vma_alloc_folio_hints()  -> folio_alloc_mpol_hints (internal)
> >                            -> __alloc_frozen_pages_hints()
> >
> > The existing APIs are unchanged and continue to work without hints.
> > For now, hints is always initialized to 0.  A subsequent patch will
> > set PGHINT_ZEROED when the page was pre-zeroed by the host.
> 
> Why do we need this feature?  Is there any performance impact?  If so,
> please provide some performance data.


It's in the cover letter:

Performance with THP enabled on a 2GB VM, 1 vCPU, allocating
256MB of anonymous pages:

  metric         baseline        optimized       delta
  task-clock     191 +- 31 ms    60 +- 35 ms     -68%
  cache-misses   1.10M +- 460K   269K +- 31K     -76%
  instructions   4.54M +- 275K   4.10M +- 130K   -10%

With hugetlb surplus pages:

  metric         baseline        optimized       delta
  task-clock     183 +- 24 ms    45 +- 23 ms     -76%
  cache-misses   1.27M +- 544K   270K +- 16K     -79%
  instructions   5.37M +- 254K   4.94M +- 155K   -8%



> [snip]
> 
> ---
> Best Regards,
> Huang, Ying

