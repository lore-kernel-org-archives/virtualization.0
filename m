Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609869;
	b=i9G+8AKsShHCUjsMclJJQXQ8C5EsGr2qo1smpg9Elw5ykcasDhIqm9ptGECNAPR8axjX
	 Vbl6tvhfvpjeL23POK6V8OPUAuA/vv0PQfrUn/zEuqg1noGuwyDzOLcFjwHOkQURxvaMV
	 ZetMA4APt0J1P0ZZkVYsb7vE5fe9yCwDcIsThWQ08v9v7+DclXKwEE7DMC5xQ+U3NJAxA
	 JbPJ9Ib/BcXPDm7xfi2bgId3cLNeneaPKQ9VYARqtxo7aDFUtOSyrqhgdFTxfMl+s6gGT
	 HE/uVAD+Gv0+cWNTCBC3k4Dsq2HxM7SBu/iVsL4kAnpIkjFSRsQp9ljh9yHDShKMG0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609869;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=3fxGFnrLPenEBS3hRgN9fftoOHtXAct/Kj+2DSQLtFw=;
	b=wKbRm5Acfp8Jhn+TRjWxKR3hUby/DpsVzFJ60+ODeCgT74vMd+Hpls5OnZ7XaIv2y88l
	 mNC5QBx8ZqV/UMpmbf1ZAHg62ru1zEPR/ScmmPTEuFaPkU8vQLlcIdszQVMk5TeJ5gfzH
	 amje9dMvl2kpIBYhFwg5nGDQrQEi+jOgj3bomdLECla37UoR9Sl3M34I5tQon0cdRLk2x
	 YKlrOGEyD5Gfsr0sMD+sVJj5b5AWhxHXOHMA5HftjM3ZplQ1nmbZAhVYvz8+yRYi8HO56
	 mrJUe+o1UTz/5fcQJy5SLA6QF+sttZ9noIrMZXxcTaVSFMjAllajv02xaUdBYL4pH5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z7Oj74UK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cIiyNdLY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z7Oj74UK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cIiyNdLY;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA4606A329
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 08:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51DA4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z7Oj74UK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cIiyNdLY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Z7Oj74UK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cIiyNdLY
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91F7E21EB8;
	Mon,  2 Nov 2026 08:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793609867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fxGFnrLPenEBS3hRgN9fftoOHtXAct/Kj+2DSQLtFw=;
	b=Z7Oj74UKbtdUkAKOLh+GKY5N/GfaHCWXDYMHK2ntHPbTqbdaImIRuM5fFvbspPEFKBIoSo
	QXlE+NdSCLUsLYZxRPskM6kgT8NveBaWIUg7wHGla+smbkcnKISSYCHlNXTO8e/nqIVhvU
	JRbXWoKve1rKi/neB2bjPwNzegsVQLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793609867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fxGFnrLPenEBS3hRgN9fftoOHtXAct/Kj+2DSQLtFw=;
	b=cIiyNdLYVOhJHW590PBqD2l5SlhN/37+jP940ns8cA/lCEkQXvnQfHWbX3MPmCc0j3oqXa
	MO+nbwpWekP8rXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793609867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fxGFnrLPenEBS3hRgN9fftoOHtXAct/Kj+2DSQLtFw=;
	b=Z7Oj74UKbtdUkAKOLh+GKY5N/GfaHCWXDYMHK2ntHPbTqbdaImIRuM5fFvbspPEFKBIoSo
	QXlE+NdSCLUsLYZxRPskM6kgT8NveBaWIUg7wHGla+smbkcnKISSYCHlNXTO8e/nqIVhvU
	JRbXWoKve1rKi/neB2bjPwNzegsVQLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793609867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fxGFnrLPenEBS3hRgN9fftoOHtXAct/Kj+2DSQLtFw=;
	b=cIiyNdLYVOhJHW590PBqD2l5SlhN/37+jP940ns8cA/lCEkQXvnQfHWbX3MPmCc0j3oqXa
	MO+nbwpWekP8rXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11900134B8;
	Mon,  2 Nov 2026 08:57:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xSa6NYZQ6GrYUAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Nov 2026 08:57:43 +0000
Date: Mon, 02 Nov 2026 09:57:42 +0100
Message-ID: <87ecd34nll.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joonho Lee <mynameisjune111@gmail.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 00/14] ALSA: virtio: staged capture recovery and PCM RESET synchronization
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Sat, 31 Oct 2026 03:08:41 +0100,
Joonho Lee wrote:
> 
> Hi Takashi,
> 
> This revision supersedes v10 and includes the unmerged prerequisites.
> Apply patches 1-14 to sound.git for-next at
> a4311e9447bbb219044db38897f95be112f46a8a. Targeting 7.5 or later still
> works for me.
> 
> Previous revision:
> https://lore.kernel.org/linux-sound/20261030052629.27742-1-mynameisjune111@gmail.com/T/
> 
> The series adds staged capture accounting for shared clients such as
> dsnoop, lifecycle recovery, and synchronized PCM RESET accounting. The
> capture compatibility options remain opt-in and disabled by default.
> 
> Changes since v10
> 
> Sashiko raised nine findings in patches 4, 9, 12 and 14. This revision
> folds the corrections into the relevant patches and carries the queue
> retirement checks from patch 3.
> 
> Patch 4 seeds ordinary RX once per prepare. Native STOP leaves requests
> and unread samples owned by the current ring, so resume preserves them.
> Consumed or discarded space returns through ACK and RESET. This avoids
> inflated pending lengths and resubmission of unread DMA slots.
> 
> Patch 9 restores notifications after rejected native pause and handles
> both success and failure on the already-running START path. Ordinary
> capture now honors the XRUN latch in ACK. Its monotonic completion count
> also detects a whole unobserved ring and reports XRUN for prepare
> recovery. Capture completions preserve the latch from this patch onward.
> 
> A first version of the recovery notification exposed an old ring of
> samples after paused RESET. Passing every wakeup through period_elapsed
> let ALSA infer a wrap without a newly completed period. The worker now
> uses the partial-progress helper for synthetic wakeups and retains PCM
> timer notifications for actual new periods. The sample comparison and
> a periodic PCM timer test both reproduce the candidate regression and
> pass with this separation.
> 
> Patch 12 removes the second appl_ptr assignment after a callback member
> has completed prepare. A linked member's prepare can sleep while the
> first member accepts SYNC_PTR. The callback path now preserves that
> acknowledgment under its PCM lock. Explicit RESET retains playback
> silence handling; prepare leaves filling to the normal START path.
> 
> Patch 14 checks the existing XRUN and lifecycle state before mutating
> paused indirect accounting. The RX queue and substream locks cover its
> pointer observation, temporary accounting and refill. The notification
> floor follows the RESET observation. Refill failure retains the existing
> zero-return policy while the worker reports XRUN and prepare recovers it.
> 
> Patch 3 retires each queue wrapper under the detach lock and checks queue
> identity in PCM, control and event callbacks. The proposed detached-ring
> IRQ failure was not reproduced on the tested PCI transport: forced
> callback tests passed on both versions. This part strengthens teardown
> ownership boundaries; the transport reset callback synchronization
> contract still applies.
> 
> Patch layout
> 
>   1-6: ACK errors, START/RELEASE recovery and request/DMA lifetime.
>   7:   Core stop-threshold accesses used by capture policy sampling.
>   8:   Partial-progress notification under the PCM stream lock.
>   9:   Staged capture, shared capture policy and lifecycle recovery.
>   10:  Staged capture work priority.
>   11:  Capture compatibility option documentation.
>   12:  Optional PCM reset operation under the stream lock.
>   13:  Staged capture RESET accounting.
>   14:  Ordinary capture RESET accounting.
> 
> The core API additions remain separate from their driver users. Drivers
> without a reset callback retain the ioctl path. Linked RESET and prepare
> retain their first-error, partial-completion contract. A zero RESET
> return allows the core rebase to finish; later I/O can report -EPIPE and
> require prepare or reopen. The internal snd_pcm_ops addition requires
> out-of-tree modules using it to be rebuilt.
> 
> Validation
> 
> The functional candidate passed 23 ARM64 QEMU runs with KASAN and lockdep,
> covering error injection, recovery, reopen and compatibility tests.
> The core fixtures covered 72 atomic/nonatomic, callback/legacy and linked
> failure cases, including playback silence. snd-dummy and virtio-snd each
> passed three playback/capture cycles. Additional timer comparisons kept
> real period ticks and removed the synthetic resume tick.
> 
> For both ordinary and staged capture, an uninstrumented kernel recorded
> 70 seconds through RW and another 70 seconds through MMAP after
> PAUSE, RESET and resume, followed by reopen. All 14 segments,
> 14,208,000 S16 mono frames at 48 kHz, matched independently generated
> SHA-256 values from QEMU sequence metadata. The oracle includes the
> intended RESET discard and backend epoch boundaries. The earlier failing
> candidate and its sample comparison remain in the local evidence.
> 
> The paused interleaving test verifies the new atomic observation
> boundary; it does not establish sample loss in the original code.
> ARM64 W=1 Image/modules and ARM32 LLVM object builds passed. Test hooks
> remain separate from the submitted code. Each mail patch is applied to
> the pinned baseline and compared with its expected intermediate source.
> 
> Fresh v11 postimages at stages 3-14 built without compiler warnings.
> Nine additional stage VMs passed, including eight injected recovery cases
> at patch 9, staged native and pause-restart capture, and paused RESET at
> patches 13 and 14. All six additional MMAP segments matched the sequence
> oracle. Neighboring patches have refreshed contexts where earlier changes
> moved their code.
> 
> Packaging also adds braces to one existing staged if arm. The new module's
> executable, relocation, data and symbol sections match the tested module
> byte for byte. The fresh stage tests above use this formatted source.
> 
> These results cover QEMU synthetic input. Physical VZ/MOTU acceptance,
> an independent KCSAN run and broader format/multichannel and ARM32
> runtime testing remain pending. The high-load TCG scheduling results
> from earlier revisions still limit performance conclusions. The new
> ordinary full-ring check reports -EPIPE where the modulo-only path could
> wait indefinitely. The core progress helper and linked RESET contract
> still need maintainer review.
> 
> Coding assistance was used for analysis, implementation, fixtures and
> this explanation. The patches carry Assisted-by: LLM.
> 
> Thanks,
> Joonho

Sashiko reported still a few issues.  As they seem to be rather minor
issues, I can work v11 now and you can fix incrementally.  Or you can
resubmit v12, if any.  Let me know which way you prefer.


thanks,

Takashi

