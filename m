Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6935DD02
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030268; cv=none; b=axKo6cuWRGjs9y1uvDy3BbauvUxsxyoN2iMQ7fHKRZXIFBRQJ0U5yp4Gjt9hGMqb+xTqyEnRBuJdRD/E4fetzZrIqbHXt8+Xz+lTDYsDE5Ozq19Q8xUo8pRe3tZVNmsMllhWlj5FZjX4CsD8u36ju8ZOMuIi3ceDH0dFrDheMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030268; c=relaxed/simple;
	bh=nM8/mPmcpF2IB9y8k1rI6PzWyX/nU/v4hE+k12HL1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJz+5vhlL/LvmHnEq+jueTAdXzTt16WSJHV9buTKnQ8Hspq+VoZu2F9W54S5b6Vt/4qFIkvs8dGanIMAmk8C1yP95gwtibeeKXCJu6FNJzQi2Ug+OPPK8s5Vu9n8FM67fBiT/nElLIswBx+hWJck2mghfobGaCU/pszCaGXP3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VcHreQ2z; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VcHreQ2z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770030262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZEap9olFo7mT2sNYk1w5rpD3JOe/VQuaiSKjgwHkTY=;
	b=VcHreQ2zTk7FVhSAZ6GgUVFwokNTeD4Qx5X8cU/BISIGZVGpdy7EuBWbXiewHlZJITBq1v
	h/0NPTey/RmvLR2J0f+PVlOVl0tKua0+75bhoCb7KXd8iwLBkGedJYaf/5skYt6MUHgfFl
	4MeXi+ZucQEe1Qgwzqawa5cry7k29lc=
From: Lance Yang <lance.yang@linux.dev>
To: peterz@infradead.org
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	arnd@arndb.de,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	boris.ostrovsky@oracle.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	david@kernel.org,
	dev.jain@arm.com,
	hpa@zytor.com,
	hughd@google.com,
	ioworker0@gmail.com,
	jannh@google.com,
	jgross@suse.com,
	kvm@vger.kernel.org,
	lance.yang@linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mingo@redhat.com,
	npache@redhat.com,
	npiggin@gmail.com,
	pbonzini@redhat.com,
	riel@surriel.com,
	ryan.roberts@arm.com,
	seanjc@google.com,
	shy828301@gmail.com,
	tglx@linutronix.de,
	virtualization@lists.linux.dev,
	will@kernel.org,
	x86@kernel.org,
	ypodemsk@redhat.com,
	ziy@nvidia.com
Subject: Re: [PATCH v4 0/3] targeted TLB sync IPIs for lockless page table
Date: Mon,  2 Feb 2026 19:00:16 +0800
Message-ID: <20260202110329.74397-1-lance.yang@linux.dev>
In-Reply-To: <20260202095414.GE2995752@noisy.programming.kicks-ass.net>
References: <20260202095414.GE2995752@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, 2 Feb 2026 10:54:14 +0100, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 03:45:54PM +0800, Lance Yang wrote:
> > When freeing or unsharing page tables we send an IPI to synchronize with
> > concurrent lockless page table walkers (e.g. GUP-fast). Today we broadcast
> > that IPI to all CPUs, which is costly on large machines and hurts RT
> > workloads[1].
> > 
> > This series makes those IPIs targeted. We track which CPUs are currently
> > doing a lockless page table walk for a given mm (per-CPU
> > active_lockless_pt_walk_mm). When we need to sync, we only IPI those CPUs.
> > GUP-fast and perf_get_page_size() set/clear the tracker around their walk;
> > tlb_remove_table_sync_mm() uses it and replaces the previous broadcast in
> > the free/unshare paths.
> 
> I'm confused. This only happens when !PT_RECLAIM, because if PT_RECLAIM
> __tlb_remove_table_one() actually uses RCU.
> 
> So why are you making things more expensive for no reason?

You're right that when CONFIG_PT_RECLAIM is set, __tlb_remove_table_one()
uses call_rcu() and we never call any sync there — this series doesn't
touch that path.

In the !PT_RECLAIM table-free path (same __tlb_remove_table_one() branch
that calls tlb_remove_table_sync_mm(tlb->mm) before __tlb_remove_table),
we're not adding any new sync; we're replacing the existing broadcast IPI
(tlb_remove_table_sync_one()) with targeted IPIs (tlb_remove_table_sync_mm()).

One thing I just realized: when CONFIG_MMU_GATHER_RCU_TABLE_FREE is not
set, the sync path isn't used at all (tlb_remove_table_sync_one() and
friends aren't even compiled), so we don't need the tracker in that config.

Thanks for raising this!
Lance
