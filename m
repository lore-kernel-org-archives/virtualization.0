Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524257;
	b=dmEYVgk0/Kd+Gylu9hlS1NhYsf4ighqutgv+5i9bWRHaj4u/owjU+Y8rUq5K8iy5hLll
	 uYy3oPAXvoMrHB+Aw2pw0CA8w8Tvh4J5qHGXDAVYdAwNuJvbV77AE0NZS7cOduvKwEBWH
	 8e/LbX3w86xHtR3vP3GOA+2/BaMXyJvC3kpe3B5MnlSyrkpTiPvPZ98mghIjvTuFrEnjl
	 NfFh1mKdIFE6YZY32qlQWaAlwP8kEAyTZnIFggv5Rus2CuIv5dylRH0jCQqj5YxDXvog4
	 1mGUd23nhlKjYiwkAs6j0YgAmnlMjq3oSOP2/8ZRdwdUoaqwzJZwdc3I7cK8D8J8K/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524257;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Pi9W+SnUbuME95dbO6kC+pZvkmFqMfmgqlTyjXruwiU=;
	b=BAkjuGZBc6A8LQtkCIPPDW0gtuvWMTuNxHUTJWBBDnZaLSS61bqM+frP8YAGNwbYaK3t
	 DI0n2ml4FLpUg52VTREkOB6AXqkQqEbwa0cd6N8peuUGVgCHQn1EiSv7jDIs4WvYLd3nG
	 FenLkLG2W+PGv0Q3MBg3B1/z1yZ6JqkE0GYmc91ihHssmTgZKrTplMEIqQbJpxiRWe+xE
	 Sp8XTzPfIarMNZzCZ876+hVv/zSwBG0jie9ms8SanAHailshOJ7kO9E4l2ORWtJr8AAp8
	 spn3sSEZYxF13mV7lpfUnjE3H4osYG2Fjvcg1G5rKf4bfqhT89M2HOUIKIi880PY2IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QkOHIVZX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVg5tcBy;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QkOHIVZX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVg5tcBy;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B597606A31E
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 12:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B597606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QkOHIVZX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVg5tcBy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=QkOHIVZX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=GVg5tcBy
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E97522033;
	Tue, 24 Nov 2026 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795524255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi9W+SnUbuME95dbO6kC+pZvkmFqMfmgqlTyjXruwiU=;
	b=QkOHIVZXhSD8KwFDyjeilmchuvxo2cMmW6NjN5QQqSs9e2KfN2Ikkt9GI16v7zaJXd8XFG
	9Hw+Ze+txFU+ADcajTYiWOyWBfvoUc7uMKqs0skBcA+gThuzXrR2kyfykDF6iPGHYDSlce
	MG7DZenNK8CGBMdYudKZsbBaycgWT+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795524255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi9W+SnUbuME95dbO6kC+pZvkmFqMfmgqlTyjXruwiU=;
	b=GVg5tcByOGKz+yfnWng6l0RnHOTdGdvAtiEkeA0LZfig20EgSs/jnUxehg9wc84S1jgivQ
	mZ/0AL0gNWQG44CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QkOHIVZX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GVg5tcBy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795524255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi9W+SnUbuME95dbO6kC+pZvkmFqMfmgqlTyjXruwiU=;
	b=QkOHIVZXhSD8KwFDyjeilmchuvxo2cMmW6NjN5QQqSs9e2KfN2Ikkt9GI16v7zaJXd8XFG
	9Hw+Ze+txFU+ADcajTYiWOyWBfvoUc7uMKqs0skBcA+gThuzXrR2kyfykDF6iPGHYDSlce
	MG7DZenNK8CGBMdYudKZsbBaycgWT+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795524255;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi9W+SnUbuME95dbO6kC+pZvkmFqMfmgqlTyjXruwiU=;
	b=GVg5tcByOGKz+yfnWng6l0RnHOTdGdvAtiEkeA0LZfig20EgSs/jnUxehg9wc84S1jgivQ
	mZ/0AL0gNWQG44CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C0D01339F;
	Tue, 24 Nov 2026 12:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zf/5Fp6GBWt/FAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 24 Nov 2026 12:44:14 +0000
Date: Tue, 24 Nov 2026 13:44:10 +0100
Message-ID: <8733sqbdr9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: mynameisjune111@gmail.com,
	Joonho Lee via B4 Relay <devnull+mynameisjune111.gmail.com@kernel.org>
Cc: linux-sound@vger.kernel.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	tiwai@suse.com,
	perex@perex.cz,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v33 00/18] ALSA: virtio: preserve PCM progress
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-11.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[mynameisjune111.gmail.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -11.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 1E97522033

On Fri, 13 Nov 2026 10:21:24 +0100,
Joonho Lee via B4 Relay wrote:
> 
> This series is based on sound.git commit
>  a4311e9447bbb219044db38897f95be112f46a8a.
> 
> Previous revision:
> https://lore.kernel.org/linux-sound/20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com/T/
> 
> Changes since v32:
> 
> - Keep a replacement capture stream in DRAINING intact when an older
>   sync_stop callback arrives. The active-state check now covers capture
>   and playback, with the teardown marker retained for later cleanup.
> - Check the settled device state while holding the queue and stream locks
>   before rolling back a failed PAUSE. A late successful STOP keeps the
>   queue closed and does not restore the old capture quiet sequence.
> - Give each uncertain control incident one additional window of four
>   msg_timeout_ms intervals. Sleepable callbacks share the remaining time.
> - Close transfer admission and quiesce period work before waiting for a
>   late control reply. Preserve the stop marker on failure and resample
>   teardown state after the reply settles.
> 
> These changes are folded into patches 12 and 18. The other sixteen
> retained patches have unchanged diffs.
> 
> Automatic device reset from v32 patch 20 is deferred. Its review exposed
> an ALSA link/open lock cycle and unresolved ordering with transport reset
> and power management. The supporting CONFIG_PM-independent suspension
> change from v32 patch 19 is also omitted. Their review findings remain
> open for a separate recovery design.
> 
> A permanently unanswered PCM control request still requires an explicit
> driver rebind. Late control replies remain supported by patch 18.
> 
> Validation:
> 
> - ARM64 virtio-snd module build with W=1: no warnings. The review-fix diff
>   passes checkpatch without errors or warnings.
> - Eight QEMU KASAN/lockdep cases cover RW/MMAP capture, RESET/DRAIN,
>   reopen, and playback. All passed with the loaded module hash checked.
> - A test-only sync_stop gate forced an old DROP to resume after a new
>   capture reached DRAINING. The original first-eighteen-patch baseline lost
>   the readable tail with -EBADFD; the candidate preserved it and returned
>   32 frames. Both used the same fixture.
> - A 1500 ms delayed STOP reply smoke test passed on v32 and this candidate.
> - Scarlett 2i2 input 1, macOS VZ, 48 kHz: v32 and the candidate each
>   passed twelve captures totalling 170 seconds, including 70-second RW
>   and MMAP captures and repeated reopen. The candidate passed four more
>   short captures after a fresh VM boot. All three VMs shut down normally.
> 
> The physical tests used the existing ABI-matched 7.3.0-rc7 KASAN kernel
> with rebuilt driver modules, capture_packed_status=1 and
> capture_pause_restart=0. Other host recorder processes remained running.
> Expected frame counts and nonzero signal windows were checked; no known
> waveform oracle was available to prove exact sample continuity.
> 
> The delayed STOP smoke test does not force the exact late-reply/PAUSE
> rollback interleaving. No fresh KCSAN run or full-kernel rebuild is claimed
> for this revision. Automatic transport reset and PM recovery are outside
> this reduced series.
> 
> Assisted-by: LLM
> 
> ---
> Joonho Lee (18):
>       ALSA: pcm: mark stop-threshold accesses for capture policy sampling
>       ALSA: pcm: report partial progress under the stream lock
>       ALSA: pcm: add an optional reset operation under the stream lock
>       ALSA: pcm: notify drivers after linked prepare completes
>       ALSA: pcm: serialize linked buffer actions
>       ALSA: virtio: propagate playback send failures through ACK
>       ALSA: virtio: Recover PCM state after a failed start
>       ALSA: virtio: Retain queued messages through device reset
>       ALSA: virtio: bound PCM transfers and retain DMA buffers
>       ALSA: virtio: Keep control payloads alive through DMA completion
>       ALSA: virtio: wait through signals for PCM teardown
>       ALSA: virtio: use request-owned capture and serialize recovery
>       ALSA: virtio: prioritize capture period work
>       docs: describe virtio-sound capture options
>       ALSA: virtio: reject invalid playback completions
>       ALSA: pcm: add an explicit application pointer to indirect playback transfer
>       ALSA: virtio: preserve playback progress across pause and buffer access
>       ALSA: virtio: settle PCM control state from late replies

So v33 is supposed to be the final one?  Or any newer is planned?


thanks,

Takashi
