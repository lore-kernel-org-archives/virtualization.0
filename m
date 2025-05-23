Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054721DDC11
	for <virtualization@lists.linux.dev>; Fri, 23 May 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747991930; cv=none; b=Po5H079PeItq9yM5zsD7cYghCsTU0QL2+FzzdA6TyjYYWVo2gffQzI6J0koD+o/UQHu+8OYYgE+FXw5jiE8FIGIFQRVYfr7iyHZ4MUPsAU/4wnxg0A0z992kHAlYE3Tx5mVYnI3V3ZHaBd8wp4kU9dW/ggjsy1eTat5oP1aF13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747991930; c=relaxed/simple;
	bh=rGFq3hRsaRLAuI27U5a/OCyuFucgK09/K1MMbJIvUYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQr+9Ua0QUNTWxbd07d07ZcJ5NcBr3nBX0wLsEvbmhaz3s4lrcqGIuCMEB696nKarp/egLxsW1ipqMFTqr4yLShIMNUzyfqU+wNdk976S73MTn+hHuacDItaeGsGqxuyjfjLmCYNILFtAkShwy89g42jJOsLZvckADttC+AIsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LHg88W1w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qyiDzrOl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SBgYLN2F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LHIAcL0M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LHg88W1w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qyiDzrOl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SBgYLN2F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LHIAcL0M"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0D9821903;
	Fri, 23 May 2025 09:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747991927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsIsjOsaTKpNfrWu+kt/OF9VH7LhERm5+U9vDLPwdYs=;
	b=LHg88W1wvA62laKbyGLjPDVzEskDD9NqAdI+7vm1VU89pPKuIL/QmTR8DfnoiRbcdlxYQ2
	kHV9vcsOSQQnVa3VPFzgtMtOJXU5kngfxTXBnklHx1Vp9+bFBUChSy/gC4Vh94mYveYszv
	9M4ZHqoaplR1CC4i3t6hLowccHUsXqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747991927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsIsjOsaTKpNfrWu+kt/OF9VH7LhERm5+U9vDLPwdYs=;
	b=qyiDzrOlhugPoqsB1W9h+fjrSgKBidlt15np2PtwFVWsx0p9cL9XgZh/YsxYdRM74h2PgD
	OoWV4ClGlibhIeCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SBgYLN2F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LHIAcL0M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747991926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsIsjOsaTKpNfrWu+kt/OF9VH7LhERm5+U9vDLPwdYs=;
	b=SBgYLN2F3qtNci/ljuuUY0eDkxdG+WZGQzOuLX9Tyv0BGaMbQq6Z/tIZn7jY6xIbmfajBO
	BfDFBHBR+zFzRBWB6SBenl+HfXUwoQIgZXl6epWincqLjP476WYpH833qi4Fh2EJX+2vyt
	LHKDH0xOgK+Ia9pVXUFIUqe5eJKWc0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747991926;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsIsjOsaTKpNfrWu+kt/OF9VH7LhERm5+U9vDLPwdYs=;
	b=LHIAcL0Mvfa9p/RcUSVWMgqd4YEqMsvTZBVir4JqT4e+IDmJMaAu2nQ4xRIDDt6LPENleu
	s4x9UVUSPP6x3xBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C34C0137B8;
	Fri, 23 May 2025 09:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TdfLLHU9MGhcPQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 23 May 2025 09:18:45 +0000
Date: Fri, 23 May 2025 11:18:36 +0200
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
Message-ID: <aDA9bCYzE2qENfDv@localhost.localdomain>
References: <20250520164216.866543-1-david@redhat.com>
 <20250520164216.866543-2-david@redhat.com>
 <aC3V1Sr7rGqqgLzW@localhost.localdomain>
 <d7b756cc-8a39-4124-ab57-912bb97ed967@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b756cc-8a39-4124-ab57-912bb97ed967@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: A0D9821903
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, May 21, 2025 at 03:44:32PM +0200, David Hildenbrand wrote:
> No, the code is confusing.
> 
> All pages are PageOffline. Only the ones that have not been onlined are *in
> addition* PageDirty.
> 
> The relevant bit is documented in page-flags.h:
> 
> "When a memory block gets onlined, all pages are initialized with a refcount
> of 1 and PageOffline(). generic_online_page() will take care of clearing
> PageOffline()."

Ah ok, I see it in __free_pages_core().


> > - If we want to release logically-offline pages belonging to an onlined memory-block,
> >    we ClearDirty them and be done
> 
> PageOffline gets cleared in both cases: See the comment in
> virtio_mem_clear_fake_offline()
> 
> "/* generic_online_page() will clear PageOffline(). */"
> 
> I'll note that I am planning on removing that PageDirty() handling
> completely, and also letting handling PageOffline() clearing be always
> performed by memory freeing core (the latter is easier to achieve).

Cool, I think that would be much clearer.

 
> When re-onlining, the core will set them all PageOffline, and virtio-mem
> will intercept page onlining using the page_online_cb.
> 
> virtio-mem will then online the actually plugged parts (->
> generic_online_page(), which clears PageOffline and exposes them to the
> buddy) and set the unplugged/hole parts as PageOfflineSkipabble again.
> 
> That logic resides in virtio_mem_online_page_cb().

Sorry, I had to re-cache this.
Ok, I think that now I caught up with the code.

I see that we mark it Offline in memmap_init_range(), and then
__free_pages_core() will clear the flag before releasing them to the
buddy.

Ok, I think it is much clear now, thanks for helping me out with the
details! 

-- 
Oscar Salvador
SUSE Labs
