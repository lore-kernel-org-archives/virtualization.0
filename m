Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092505;
	b=NGTUWkhff+kQfAdbdKXc7WKgGhAkKFXE94P0oQ+DT3U+zUKHqCnf6Ixvg/luN8xH+gxt
	 n/xBYrbh9re/WCRRjRVtqYclk7hmY97e7906mQ0yg4VZ/F1hgITmQhtOnIakIB2h9VrcY
	 ljeDullg4+ypysrEZKT2DmTL51+XQoOedAeLBRoeQC6C8l6WPO9HnB0RMMjT4TcdQrKDG
	 6WbIIgrlftm0CGjnkuh5SxEsjne6oevjLaAenTDDsDTNyWlw6BWzJNY/B7vXMkjBcVXW0
	 CwoBimTzS1GFmk+wdPiTolnNZBURMLUprGfWtiMHtEtOFEW2dnWb04eUgc8OxDVK9lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092505;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Ujm34fnOIGPSTccM2EPBmX3ApSn6Ieb0vSFOU048XLI=;
	b=eh8U4cW73J5M/kIU6HknZao5i0p2jM5xYZ6qmS1zvXlvqyVsWUGFGaKA+zl/Jt/bvtp/
	 WR43mz3dD9e/Ih0hTdhAkyL8XLOTeSd8lZZ2O5UExASbZef0s3OPLdlQGdyWmorqX3nH1
	 SBfXXy7byHWeL2EUimZwv7pmkWeDcbNi/VMFq0JuP+8RFHV1fHX3vZ4z5R2ySa6JPq0ND
	 8Wq25q1BbPe5tzOGdMSKBZT9qNVYFlng7E4LLM8vW6Ps0R1fw0IxHcdas6DlbkWPK3pW+
	 yuWCNqaLUcWBWZE3B9B61HKWj0k4lpm/G8+dy7sNlXH2W8QKtxN6iUUW5J/OWhPIoeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GXXCk0b5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=da3zDgLo;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GXXCk0b5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=da3zDgLo;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D144606A320
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 09:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D144606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GXXCk0b5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=da3zDgLo;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GXXCk0b5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=da3zDgLo
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4951D21DE7;
	Tue, 27 Oct 2026 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793092502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujm34fnOIGPSTccM2EPBmX3ApSn6Ieb0vSFOU048XLI=;
	b=GXXCk0b5hYzjSh4mTjEBZNeZsajzCA9yrz/7ZowmqfMNVjLNG6xAqr/3cf45gTMaRcGjUp
	QdjYFCxBEWn77RgRw549Bsf06QhsIvsiiv3ggThg/yalj7fIGYW3Go44aQKv7OxARuhBR+
	Tk/lDXsqNXKzsaOZcHoqhHUVRpm/53s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793092502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujm34fnOIGPSTccM2EPBmX3ApSn6Ieb0vSFOU048XLI=;
	b=da3zDgLo0D0AGuVFuLX1e9yj5oiI/1n59qyY6Glz48xgSVSXppnei+NUgHXc4U+7gd6+XH
	33fVXUPPTs9uE9Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GXXCk0b5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=da3zDgLo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793092502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujm34fnOIGPSTccM2EPBmX3ApSn6Ieb0vSFOU048XLI=;
	b=GXXCk0b5hYzjSh4mTjEBZNeZsajzCA9yrz/7ZowmqfMNVjLNG6xAqr/3cf45gTMaRcGjUp
	QdjYFCxBEWn77RgRw549Bsf06QhsIvsiiv3ggThg/yalj7fIGYW3Go44aQKv7OxARuhBR+
	Tk/lDXsqNXKzsaOZcHoqhHUVRpm/53s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793092502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujm34fnOIGPSTccM2EPBmX3ApSn6Ieb0vSFOU048XLI=;
	b=da3zDgLo0D0AGuVFuLX1e9yj5oiI/1n59qyY6Glz48xgSVSXppnei+NUgHXc4U+7gd6+XH
	33fVXUPPTs9uE9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E868613319;
	Tue, 27 Oct 2026 09:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c4eSLpVr4GpLQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Oct 2026 09:15:01 +0000
Date: Tue, 27 Oct 2026 10:15:01 +0100
Message-ID: <87cxsv33oq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joonho Lee <mynameisjune111@gmail.com>
Cc: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ALSA: virtio-snd: fix dsnoop capture with staged buffers
In-Reply-To: <20261025064038.81674-1-mynameisjune111@gmail.com>
References: <20261025064038.81674-1-mynameisjune111@gmail.com>
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
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 4951D21DE7

On Sun, 25 Oct 2026 07:40:36 +0100,
Joonho Lee wrote:
> 
> Hi,
> 
> Changes in v4:
> * Arm synchronous stop before paused capture enters XRUN through ACK or
>   period work, so recovery releases pending RX requests before prepare.
> * Add read/forward ACK regressions for first-prepare recovery and direct
>   close/reopen, with native pause and pause-restart on one and two vCPUs.
> * Keep patch 1 and the prerequisite metadata unchanged.
> 
> Sashiko identified a missing cleanup path in v3 patch 2:
> https://sashiko.dev/#/patchset/20261025055702.69259-1-mynameisjune111%40gmail.com?part=2
> 
> Previous version:
> https://lore.kernel.org/all/20261025055702.69259-1-mynameisjune111@gmail.com/
> 
> This series fixes dsnoop capture on top of the staged-capture virtio-snd
> changes. dsnoop configures its slave with stop_threshold == boundary and
> can keep capture running without advancing the slave application pointer as
> an ordinary reader would. The staged-capture accounting currently exhausts
> its bounded unread capacity in this configuration.
> 
> The first patch marks stop_threshold accesses used by the driver's policy
> sampling. READ_ONCE/WRITE_ONCE provide single-access annotations; the
> virtio-snd state transitions remain protected by the substream lock.
> 
> The second patch caches the prepared boundary and samples the stop policy
> under that lock. A completion uses one sampled policy for validation,
> copying and queue refill. Free-running capture keeps requests queued and
> retains the existing frame, payload and pointer-window checks. Returning to
> bounded capture restores unread accounting from the monotonic counters. If
> the outstanding data already fills the ring, the policy helper returns
> -EPIPE without changing the cached mode or counters. The detecting RX,
> pointer or ACK path then reports XRUN through its existing error path.
> Native pause-release refill failures schedule the period worker to move a
> paused stream to XRUN and wake capture waiters.
> This does not guarantee a synchronous error from the sw_params ioctl.
> 
> The ACK accounting and subsequent queue refill each sample the policy under
> the appropriate locks. Prepare and teardown reset the cached state. The
> existing ACK-race and priority changes are prerequisites to this series and
> are excluded from these two diffs.
> 
> New testing for v4:
> 
> * v3 reproduced -EPIPE from paused read/forward ACK, followed by -EBADFD
>   on the first prepare in both native pause and pause-restart modes.
> * The corrected module passed 16 combinations of ACK operation, recovery
>   route, pause mode and vCPU count under ARM64 QEMU with KASAN/lockdep.
>   Prepare recovery uses the first prepare without an intervening drop.
>   Recovery and reopening each capture 48,000 frames.
> * The native-pause regression and 13-case mode suite also passed.
>   No KASAN or lockdep diagnostics were recorded in the six final VM runs.
> * Direct close/reopen succeeded even on v3 in this fixture; these results
>   establish the prepare regression, without establishing a persistent
>   buffer leak across close. Forced RX/pause interleaving, new physical
>   microphone tests and KCSAN reruns were not performed for v4.
> 
> Earlier testing for v3:
> 
> * ARM64 QEMU with KASAN and lockdep, native pause: v2 returned -EPIPE
>   but stayed PAUSED, and a waiting poll timed out. The corrected module
>   reached XRUN, woke poll with POLLERR and returned -EPIPE from read.
>   Prepare recovery and reopening each captured 48,000 frames. The
>   corrected case passed with both one and two vCPUs.
> * The 13-case mode suite passed with the corrected module, including
>   direct and mmap capture, policy transitions, delayed-reader recovery,
>   reopening, mixed-rate dsnoop readers and client departure. KASAN and
>   lockdep reported no diagnostics in these runs.
> 
> The following testing was performed on v2 before this focused change:
> 
> * ARM64 QEMU synthetic dsnoop capture: 12 files and 2,160,000 frames
>   matched the reference sequence from each client's observed starting
>   position. All 48 corruption, loss, duplication and reordering controls
>   were detected.
> * Default KCSAN: 13/13 cases and 619 policy transitions passed without
>   race or lockdep reports. Forced RX/ACK policy changes and four isolated
>   policy-helper branches passed under KASAN and KCSAN.
> * macOS VZ with MOTU UltraLite-mk5 at 48 kHz: comparisons used one or two
>   vCPUs and idle or CPU-saturated guests. The baseline failed all 32
>   shared-client captures. The candidate passed 48 captures and eight
>   recovery diagnostics, including mixed-rate sharing, client departure,
>   reopening and recovery after an intentionally delayed reader.
>   Loaded shared captures ran for 70 seconds. All eight accepted VM runs
>   shut down on the first request.
> 
> The physical tests checked frame counts and nonzero input. Exact sample
> continuity was checked with the QEMU synthetic source. VZ exposed mono;
> these tests do not establish physical input-channel routing or multichannel
> support. Aggressive KCSAN still produced dsnoop client-threshold XRUNs with
> a 160 ms buffer. Further isolation supports a deadline sensitivity, but
> does not exclude every kernel timing contribution. Separate generic KCSAN
> reports remain recorded in the test evidence.
> 
> This series depends on the staged-capture prerequisite stack below. The
> tested local base is 8d0d4c1a6c4bcb81ae9f52d1c0d979fafb2e22f2, consisting
> of nine prerequisite patches above sound.git commit
> 5618f6837ef3314e2c581d4c05ec13b7ed975cb4.
> 
> Prerequisites, in application order:
> 
> 1-5. Lifetime and error recovery v3:
> https://lore.kernel.org/all/cover.1791881787.git.mynameisjune111@gmail.com/
> 6. Generic teardown/control wait v2:
> https://lore.kernel.org/all/rfc-v2-generic-control-wait-0.2eddd58a796e497f@gmail.com/
> 7. VZ staged capture v2:
> https://lore.kernel.org/all/rfc-v2-vz-capture-compat-1.b9ab4c1540dc4691@gmail.com/
> 8-9. ACK accounting and high-priority period work:
> https://lore.kernel.org/all/rfc-virtio-snd-capture-followups-1.f2737c95c12e45b4@gmail.com/
> https://lore.kernel.org/all/rfc-virtio-snd-capture-followups-2.f2737c95c12e45b4@gmail.com/
> 
> This fixes the staged-capture accounting introduced by that prerequisite
> stack. The reproductions do not establish the same failure in an unmodified
> upstream kernel.
> 
> The policy uses the existing stop_threshold == boundary convention.
> Sampling it under the driver lock avoids introducing a PCM stream lock into
> RX completion. A completion overlapping a policy update may finish with the
> previous policy; its accounting and refill use that same sample. Rejecting
> a transition whose bounded accounting cannot be restored preserves
> explicit overflow detection and lets the caller recover the stream.
> 
> Patches:
>   ALSA: pcm: mark stop-threshold accesses for capture policy sampling
>   ALSA: virtio-snd: fix dsnoop capture with staged buffers

The patch2 doesn't seem cleanly applicable to the latest sound git
tree.  Could you verify and rebase/submit?  I think it'll be a
material for 7.5, as it's no regression fix, though.


thanks,

Takashi
