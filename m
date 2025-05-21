Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2127AC43
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834332; cv=none; b=QG3oe+UQfM1n1YzoLuurOxdRhG9GWzg4rVhcPM+MkENaOQnWTx61RG5nklHlbWDV9tBlPbK95DeYt5dFff7blwrQV5mB1qozcjdM4v1hzzUJd//T34LAc/JlnSJPYYNuAHuV2YlsiMDed8+Hkj6vX7mrnvFN17SJStpxIB1Kb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834332; c=relaxed/simple;
	bh=NsgWVYIVCZt03Z+/FjuPKG0apM0JOgVnAzS+yvOjUo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3tNa/a6FagHXvetaCCu6oxVQjdkJA4YFuDL47FZSYI/q/cr2A6+Z1za3R7EqTDIzMOlu2n92kct7VKBQFNbdjA/MCWIipNkj8daJBQ9fqzB99NdihjKXTPLih+/KTSYVDQbiMS8BVNw+e+Cm5CKdHODFF7vXHUNeAbt41xxhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lNBfg775; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jE/36a9A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V/XrrZNn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nz8vuZpn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lNBfg775";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jE/36a9A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V/XrrZNn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nz8vuZpn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36507337F6;
	Wed, 21 May 2025 13:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747834328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJNiWFvwBFXo0EFgpeAs+JtNoelOy/ITO4unDPZL+PA=;
	b=lNBfg775/t9gNMm5eTRzzTW+sNb7tz7wp7yW0g0+8vqYxIGpP5uzlYcDYe+EGtO/65iGp9
	kKBwMQda0hoeUNOgWGwfH7goYzVhe6H33d93aJE622DgddU6VA6rQt1DJrmURm4zjc026d
	j1djAVUFx7yggtTOkivvRs0GmQOrJPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747834328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJNiWFvwBFXo0EFgpeAs+JtNoelOy/ITO4unDPZL+PA=;
	b=jE/36a9AfJT+XI34M073LiBW6Wr36u0PLwAPrb1XWDevJuGzjWRH6rtPs9SUnLUSlzhBaX
	VAWeRJYRSKAXwTDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="V/XrrZNn";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nz8vuZpn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747834327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJNiWFvwBFXo0EFgpeAs+JtNoelOy/ITO4unDPZL+PA=;
	b=V/XrrZNnxUQRLPH4davKNb79TiSS68XnxISaOTfSAJu4XuXpZKXYlIR1N9FtqlRgXCDrAV
	wWabWoF/kG86xTsV0fO6y/pF5goyoV/mtGMJB/rBNXil2Jz7VGMf6UtGnYhOUW7Obo9qQA
	t1Bg5q2X9ognBjdvmLtUc3LQj6wOWFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747834327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJNiWFvwBFXo0EFgpeAs+JtNoelOy/ITO4unDPZL+PA=;
	b=Nz8vuZpnKjOZxTTrwd6Y4POPElKu5cEifobVkDd5d92Za41tHQVUloJOcimO7bSWmtIYF3
	L9hQ3GMPfIcTyfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E634013888;
	Wed, 21 May 2025 13:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xy1hN9bVLWi2BQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 21 May 2025 13:32:06 +0000
Date: Wed, 21 May 2025 15:32:05 +0200
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
Message-ID: <aC3V1Sr7rGqqgLzW@localhost.localdomain>
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
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: 36507337F6
X-Spam-Level: 
X-Spam-Flag: NO

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

Hi David, sorry for jumping in late

> @@ -1157,6 +1083,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>  			SetPageDirty(page);
>  		else
>  			__SetPageOffline(page);
> +		__SetPageOfflineSkippable(page);
>  		VM_WARN_ON_ONCE(!PageOffline(page));

I think I am having some issues understanding this, let me see if I get
it.

- virtio-mem defines PageOffline pages, which are logically-offlined
  pages within an onlined memory-block
- PageOffline pages have a refcount of '0' once they are properly
  initialized, meaning that refcount > 0 implies somebody is holding
  a refcount and that should not really happen
- logically-offline pages belonging to onlined memory-blocks are marked PageDirty,
  while logically-offlined pages we allocated via alloc_contig_range are marked
  PageOffline (I am getting a bit lost between fake-online, fake-offline, my fault)
- If we want to release logically-offline pages belonging to an onlined memory-block,
  we ClearDirty them and be done
- If we want to release logically-offlined pages belonging we allocated
  via alloc_contig_range, we clear PageOffline and be done
- PageOfflineSkipabble are unmovable PageOffline pages, which cannot be
  migrated? 
- So for a PageOffline to be able to be migrated away must be Movable or
  marked PageOfflineSkipabble, making do_migrate_range ignore it
- PageOfflineSkipabble will be marked PageOffline upon re-onlining? Will
  still be marked as PageOfflineSkipabble?

> +
> +		/*
> +		 * Only PageOffline() pages that are marked "skippable" cannot
> +		 * be migrated but can be skipped when offlining. See

It is probably me, and nevermind the comment but I somehow find
"PageOfflineSkipabble are not migrated but skipped when offlining" a bit
easier.

 

-- 
Oscar Salvador
SUSE Labs
