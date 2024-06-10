Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF806FB6
	for <virtualization@lists.linux.dev>; Mon, 10 Jun 2024 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717993759; cv=none; b=ipuXaxv9DgTkvOIXxr989kgy0yve1ZOJiWahSS4t1E56s/vLd46AN88WckYP6cO72N31t2CCvqrIzKg7QOw+QWnY9JZk1zgRwdArHc5tdlzkACnPF6xr0K8Pob/WB+fTPka8uEgDetydszKSC/Uk/bwWCXkajDmYLcUvQSJ3uhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717993759; c=relaxed/simple;
	bh=Bs/nYembIxGJ7IgdXrW97nm3aE6kxFEAObIdWWF6dFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ582sC0hTtfauJ9AcFENy0rf9inpPDo+Oo5M5TixloNSwy7ot+llrqdQ+Bnnd5uPWFJCUuWEkwXXwvf3BQ+imQUOG1AIJn5GRd/aVqZgjXKotP9KVvzrrj+RLiNBHEBf9q10WS1KwUylD8SDOp7C7Qnzip/3Zq6gBvD2CGDhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ouS1aMbV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xMKg0LFz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ouS1aMbV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xMKg0LFz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ouS1aMbV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xMKg0LFz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ouS1aMbV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xMKg0LFz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD4C1F76E;
	Mon, 10 Jun 2024 04:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717993756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZ0M1mMkyIQjD9GHv7ILLIsJEt6S/v29bdhzDaDdHV0=;
	b=ouS1aMbVEZAQVmHrDj9M+xsCMzi5lTc6/jUPSYA+SppS+h5NEBGkqZ/xLzWibfr8WOv/o9
	cc8rOjHzymZljwOTKMr5dRcYBGcH8jm6EnAkfFpJkmjP6ECb0c8FE+m96t+996chAS7XNW
	bCBh8iHhcqz1FH8y+Mtdlf61/swOKLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717993756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZ0M1mMkyIQjD9GHv7ILLIsJEt6S/v29bdhzDaDdHV0=;
	b=xMKg0LFzrRdT0JzUutNU0hVH0KB4afQ7p5Tw5Clmij6qnvVx6ObtCh65qQCvh1PUPif7Vq
	EyZx8fBScE2Fr4AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717993756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZ0M1mMkyIQjD9GHv7ILLIsJEt6S/v29bdhzDaDdHV0=;
	b=ouS1aMbVEZAQVmHrDj9M+xsCMzi5lTc6/jUPSYA+SppS+h5NEBGkqZ/xLzWibfr8WOv/o9
	cc8rOjHzymZljwOTKMr5dRcYBGcH8jm6EnAkfFpJkmjP6ECb0c8FE+m96t+996chAS7XNW
	bCBh8iHhcqz1FH8y+Mtdlf61/swOKLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717993756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZ0M1mMkyIQjD9GHv7ILLIsJEt6S/v29bdhzDaDdHV0=;
	b=xMKg0LFzrRdT0JzUutNU0hVH0KB4afQ7p5Tw5Clmij6qnvVx6ObtCh65qQCvh1PUPif7Vq
	EyZx8fBScE2Fr4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E42513A7F;
	Mon, 10 Jun 2024 04:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IEF7EBuBZmYbGAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 10 Jun 2024 04:29:15 +0000
Date: Mon, 10 Jun 2024 06:29:13 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org, kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v1 3/3] mm/memory_hotplug: skip
 adjust_managed_page_count() for PageOffline() pages when offlining
Message-ID: <ZmaBGSqchtEWnqM1@localhost.localdomain>
References: <20240607090939.89524-1-david@redhat.com>
 <20240607090939.89524-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607090939.89524-4-david@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Fri, Jun 07, 2024 at 11:09:38AM +0200, David Hildenbrand wrote:
> We currently have a hack for virtio-mem in place to handle memory
> offlining with PageOffline pages for which we already adjusted the
> managed page count.
> 
> Let's enlighten memory offlining code so we can get rid of that hack,
> and document the situation.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
