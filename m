Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C4225405
	for <virtualization@lists.linux.dev>; Fri, 23 May 2025 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747992041; cv=none; b=pumoJQMlZ5dVP3UVtg1Of7Li7aWPQfg+c2QtwTTlmSxJ6NUeYdpRGMkH8tmBY3w1gsdzWmOaA6jPMifqB9mnmOzqSkvb7ctth2pBb88rfzFMsKKhyJa+VhIJ6hw/V8g/W/2cAH+/u4ApIMa585mG9g/mhd4sRFlQ+FJkEl0adr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747992041; c=relaxed/simple;
	bh=/EkxK+M2AMYeKqef5dtTIUrZK0FP6bFrkqka0DXQUnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6qircFcyyvNS4mim9AVlBvyxbzdFevD70xyWna4xgQxZ8+P2DMcFUrVibhqeOkpIXSsAx2mV08n2HiwDs3ezbqNtn+KApNI+SkLpN71oVN8nMlW397ba1Sjk0YfoUbvsVAfv0Lz61q96TKZW4wFL6k1VJEJFF3YfoEDJYUv1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YN0IA3On; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cBR3AZxY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YN0IA3On; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cBR3AZxY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YN0IA3On";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cBR3AZxY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YN0IA3On";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cBR3AZxY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52AB21F821;
	Fri, 23 May 2025 09:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747992037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhocMSSXD2Ob4YbeI+06yEIZuiMpJcrclTZN4rAvaTA=;
	b=YN0IA3OnH294PXpXi5dDe00kzw9uu8MzxlzJIvvIMeAdWoZoHcJjpDqTzW7DGsgNUeWcOY
	l7CxoxCrx05CHkag6MSt2bg+6w5w72IqBq4i9LC2zk6D+yqQ9GRzmmvIM+nWpnsz8siHe9
	ByI9YP/xomosUoLSK+5I96RpDViYEyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747992037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhocMSSXD2Ob4YbeI+06yEIZuiMpJcrclTZN4rAvaTA=;
	b=cBR3AZxYlhc0linbdmpXVLkmWYbFS3BRxGGCGZ6LxeHg7U9Jk0E4DNj+m90tV5Fe7bapOD
	VocegoYBxStLaLCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YN0IA3On;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cBR3AZxY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747992037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhocMSSXD2Ob4YbeI+06yEIZuiMpJcrclTZN4rAvaTA=;
	b=YN0IA3OnH294PXpXi5dDe00kzw9uu8MzxlzJIvvIMeAdWoZoHcJjpDqTzW7DGsgNUeWcOY
	l7CxoxCrx05CHkag6MSt2bg+6w5w72IqBq4i9LC2zk6D+yqQ9GRzmmvIM+nWpnsz8siHe9
	ByI9YP/xomosUoLSK+5I96RpDViYEyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747992037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhocMSSXD2Ob4YbeI+06yEIZuiMpJcrclTZN4rAvaTA=;
	b=cBR3AZxYlhc0linbdmpXVLkmWYbFS3BRxGGCGZ6LxeHg7U9Jk0E4DNj+m90tV5Fe7bapOD
	VocegoYBxStLaLCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 691E2137B8;
	Fri, 23 May 2025 09:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q32/FuQ9MGjqPQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 23 May 2025 09:20:36 +0000
Date: Fri, 23 May 2025 11:20:34 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 1/1] mm/memory_hotplug: PG_offline_skippable for
 offlining memory blocks with PageOffline pages
Message-ID: <aDA94oHm1k-I01dv@localhost.localdomain>
References: <20250520164216.866543-1-david@redhat.com>
 <20250520164216.866543-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520164216.866543-2-david@redhat.com>
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: 52AB21F821
X-Spam-Score: -1.51
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,suse.de:email,suse.de:dkim,nvidia.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, May 20, 2025 at 06:42:11PM +0200, David Hildenbrand wrote:
> A long-term goal is supporting frozen PageOffline pages, and later
> PageOffline pages that don't have a refcount at all. Some more work for
> that is needed -- in particular around non-folio page migration and
> memory ballooning drivers -- but let's start by handling PageOffline pages
> that can be skipped during memory offlining differently.
> 
> Note that PageOffline is used to mark pages that are logically offline
> in an otherwise online memory block (e.g., 128 MiB). If a memory
> block is offline, the memmap is considered compeltely uninitialized
> and stale (see pfn_to_online_page()).
> 
> Let's introduce a PageOffline specific page flag (PG_offline_skippable)
> that for now reuses PG_owner_2. In the memdesc future, it will be one of
> a small number of per-memdesc flags stored alongside the type.
> 
> By setting PG_offline_skippable, a driver indicates that it can
> restore the PageOffline state of these specific pages when re-onlining a
> memory block: it knows that these pages are supposed to be PageOffline()
> without the information in the vmemmap, so it can filter them out and
> not expose them to the buddy -> they stay PageOffline().
> 
> While PG_offline_offlineable might be clearer, it is also super
> confusing. Alternatives (PG_offline_sticky?) also don't quite feel right.
> So let's use "skippable" for now.
> 
> The flag is not supposed to be used for movable PageOffline pages as
> used for balloon compaction; movable PageOffline() pages can simply be
> migrated during the memory offlining stage, turning the migration
> destination page PageOffline() and turning the migration source page
> into a free buddy page.
> 
> Let's convert the single user from our MEM_GOING_OFFLINE approach
> to the new PG_offline_skippable approach: virtio-mem. Fortunately,
> this simplifies the code quite a lot. The only corner case we have to
> take care of is when force-unloading the virtio-mem driver: we have to
> prevent partially-plugged memory blocks from getting offlined by
> clearing PG_offline_skippable again.
> 
> What if someone decides to grab a reference on these pages although they
> really shouldn't? After all, we'll now keep the refcount at 1 (until we
> can properly stop using the refcount completely).
> 
> Well, less worse things will happen than would currently: currently,
> if someone would grab a reference to these pages, in MEM_GOING_OFFLINE
> we would run into the
> 		if (WARN_ON(!page_ref_dec_and_test(page)))
> 			dump_page(page, "fake-offline page referenced");
> 
> And once that unexpected reference would get dropped, we would end up
> freeing that page to the buddy: ouch.
> 
> Now, we'll allow for offlining that memory, and when that unexpected
> reference would get dropped, we would not end up freeing that page to
> the buddy. Once we have frozen PageOffline() pages, it will all get a
> lot cleaner.
> 
> Note that we didn't see the existing WARN_ON so far, because nobody
> should ever be referencing such pages.
> 
> An alternative might be to have another callback chain from memory hotplug
> code, where a driver that owns that page could agree to skip the
> PageOffline() page. However, we would have to repeatedly issue these
> callbacks for individual PageOffline() pages, which does not sound
> compelling. As we have spare bits, let's use this simpler approach for
> now.
> 
> Acked-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
