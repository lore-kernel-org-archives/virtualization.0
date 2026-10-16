Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908474D9563
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161323; cv=none; b=LiE4EPnSvebaWH0Gb87ZB29cPrO3OkgvOLHMTrLasA6zlwobBd59v45HZM7R3uSngzyt1PfQuZSqY3y8Ipdy3UQ82VsvoSu1caqo0GdaVEiSytidueuKDH1Hy6K9cjO5HhpPHzZJUz1tXY4k2JP1Il3mt9B5pnJ69/9u/kclmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161323; c=relaxed/simple;
	bh=j6KCEVumfcOPoJKthiY0VvennBzGTDjKegocjAp2ulc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oR3F/TIkXjS+pmAPRV8WUoYXx7gtY9qNNAxn8GdEhreNsKjMIa2blV3MzXt2sSI6/9JLNJeaIuDJ0L0Ee7LR3xbevptKD3i8DplbTr7La3qk8o16q5+SL7cu0sW1IxPKXSZATKV+YdQ5K+2gdx0juaR5iTClpkV29W+gt0uQkEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HaPR83Du; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UD8EToKL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HaPR83Du; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UD8EToKL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HaPR83Du";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UD8EToKL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HaPR83Du";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UD8EToKL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF6451F456;
	Fri, 16 Oct 2026 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792161319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5E93OwKE40qyDdwFKgNKcqO0FbUR/pPxJNB7vT4rn1Y=;
	b=HaPR83Dur3FlESWysi8KoBF79+MWkFbVzuDEZK2UTuOzLaWSfO4y+YH1yD3e3Ap05MKZRy
	KMlAp0a4ypgn/amUrMwnlStUTSxeLA67Q56s2yV92+FLt45WVlzdnNwC5b4Lx4NIoGCpbo
	vRlB9X0JO4jdGelAB37oB15dp9NQh8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792161319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5E93OwKE40qyDdwFKgNKcqO0FbUR/pPxJNB7vT4rn1Y=;
	b=UD8EToKLsSp4wDlW106XiUW8ozm8a9OOrbYWxRoE0T9Oczgxrm4xCMldaWXnjB468Qte4/
	EsCJuC8au2hcbiBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HaPR83Du;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UD8EToKL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792161319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5E93OwKE40qyDdwFKgNKcqO0FbUR/pPxJNB7vT4rn1Y=;
	b=HaPR83Dur3FlESWysi8KoBF79+MWkFbVzuDEZK2UTuOzLaWSfO4y+YH1yD3e3Ap05MKZRy
	KMlAp0a4ypgn/amUrMwnlStUTSxeLA67Q56s2yV92+FLt45WVlzdnNwC5b4Lx4NIoGCpbo
	vRlB9X0JO4jdGelAB37oB15dp9NQh8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792161319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5E93OwKE40qyDdwFKgNKcqO0FbUR/pPxJNB7vT4rn1Y=;
	b=UD8EToKLsSp4wDlW106XiUW8ozm8a9OOrbYWxRoE0T9Oczgxrm4xCMldaWXnjB468Qte4/
	EsCJuC8au2hcbiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5151A1378C;
	Fri, 16 Oct 2026 14:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q0oNCic20mocJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 16 Oct 2026 14:35:19 +0000
Date: Fri, 16 Oct 2026 16:35:18 +0200
Message-ID: <877bjh3e8p.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joonho Lee <mynameisjune111@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: Re: [PATCH v3 0/5] ALSA: virtio: Fix request lifetime and error recovery
In-Reply-To: <cover.1791881787.git.mynameisjune111@gmail.com>
References: <cover.1791881787.git.mynameisjune111@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AF6451F456
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Tue, 13 Oct 2026 10:57:47 +0200,
Joonho Lee wrote:
> 
> A failed PCM start or a timed-out request can leave virtio-snd messages
> owned by the device after the caller returns. Retrying can then reuse
> pending messages, and freeing ALSA or control buffers can leave their
> addresses in a virtqueue.
> 
> This series fixes enqueue-error recovery and keeps the memory referenced
> by outstanding requests alive until completion or device reset. Reset
> also detaches unused descriptors before deleting the queues, releasing
> their DMA mappings and cancelling PCM messages without reporting them
> as completed audio.
> 
> Changes since v2, following the Sashiko AI review:
> - Patch 2 protects all stopped-state accesses with vss->lock, including
>   hw_params, prepare, open, STOP and sync_stop completion. The RELEASE
>   decision and stopped=true transition now share a critical section.
>   Sleeping operations remain outside the spinlock.
> - Patch 5 aligns every DMA region for both cache maintenance and typed
>   CPU accesses, and removes the initial +1 offset. This handles coherent
>   systems where dma_get_cache_alignment() returns 1, as well as odd
>   region lengths that could otherwise misalign later payloads.
> - Patches 1, 3 and 4 are unchanged.
> 
> Validation of the final v3 source:
> - ARM64 W=1 module build and ARM32 CONFIG_MMU=n driver object build.
> - Source-extracted ASan/UBSan PCM, control, reset, ACK and DMA lifetime
>   regressions on macOS arm64. The v2 control allocator produces UBSan
>   misalignment diagnostics; the v3 allocator passes typed header and
>   request/response integer64 accesses with DMA alignments 1, 2, 4, 8,
>   32, 64 and 128.
> - Deterministic stopped-state lock instrumentation catches unlocked v2
>   accesses and passes 73 lifecycle assertions for v3. It covers ACK
>   failure, RELEASE failure/retry and ACK during RELEASE, and checks that
>   blocking operations do not run with the spinlock held.
> 
> The stopped-state test instruments extracted source; it is not KCSAN or
> an actual threaded kernel race test. NOMMU was compiled, not booted.
> Physical non-coherent DMA hardware and host microphone behavior were
> not tested by these regressions. The QEMU ARM64 KASAN fault/recovery runs
> reported in v2 have not been rerun for these v3 changes.
> 
> Reproducer source and instructions:
> https://github.com/whatisyourname0/virtio-snd-reproducer/tree/3ee5c7c1e864dae50a127b0a25cd122532daa6de
> 
> Based on sound.git for-next commit
> 8d70e364e866bdfca81eee24d0688fac9472cfb9.
> 
> AI assistance was used for code changes, tests, review and patch text.
> Assisted-by trailers are included. Sashiko's findings were checked against
> the driver and covered by regressions before incorporating the fixes.
> 
> Previous series Message-ID:
> <cover.1791877396.git.mynameisjune111@gmail.com>
> 
> Joonho Lee (5):
>   ALSA: virtio: Propagate PCM send failures through ACK
>   ALSA: virtio: Recover PCM state after a failed start
>   ALSA: virtio: Retain queued messages through device reset
>   ALSA: virtio: Keep PCM DMA buffers alive through device ownership
>   ALSA: virtio: Keep control payloads alive through DMA completion

Through a quick glance, the patches look OK, but they are a bit too
heavy changes at this very late stage for the next merge window.
I can take those for 7.4-rc1 if the virtio maintainer gives an ack,
but otherwise postponed for 7.5.

Or, if you have some more urgent fixes to address some known issues,
please cook a smaller patch that can be more easily digested.


thanks,

Takashi
