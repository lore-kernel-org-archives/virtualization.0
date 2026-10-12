Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E96C2E7F20
	for <virtualization@lists.linux.dev>; Mon, 12 Oct 2026 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791790141; cv=none; b=q6ITL8PvFxSMJsUbakIW+d59ruFftV12QW8upFngpkWPpvVC72BcVwGZhPTP4rdeNcbO6Jf+or4S+Qe/lafTVFE4vX/kODkmKGvOI9cC/BLnQ8kMfKBifCWkZDplTe0cXRElIXrArJCT3UBnneigdCLfkZiyrlm9CDSoU8E9U7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791790141; c=relaxed/simple;
	bh=6jcphYnXMgcYxMAb79n6V/hcAcS5MKof3S1hFbQL+ec=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IL6sCxt+4Xll520iQ1wgwXP2sGkF1G4ERPBENom7Kh3x5EAvS4PVBNDPvmsZraGDzX34DRgC58fkdmIit9UI5hiY4YgdfPz7b6UbLQZNLvjyCGw/oTUrId8OGu4hQT+Ktpdwgo2QsfZc1rwzOVX81igm0dbbOJj1ACVCKuh+K7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=namNmu6T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fc5P9kdU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sWzN9nXS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vb4eTYYi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="namNmu6T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fc5P9kdU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sWzN9nXS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vb4eTYYi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B79511F791;
	Mon, 12 Oct 2026 07:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791790138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjOXIGQy+i/5DrfRzrko/LNHxuUSj4ZwQC8QQbMhYNg=;
	b=namNmu6TC83w6mppInNa+hL9eioJlcD07ZpUXQSCLG8NTlWbyhYFow1UugRRCYWMw7z39c
	jlXwqFFFp/KPTN8uMa3tLBo6qR93fz+2bd/nJZ9Huyo4XrDo5Iyjop+L2yRxpE9Kcy4Knz
	kxNJwEIcabREL2kmgRJowb5M4PXDQg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791790138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjOXIGQy+i/5DrfRzrko/LNHxuUSj4ZwQC8QQbMhYNg=;
	b=fc5P9kdUB33J5B+cC36IMp6tGoxX/e59wqXntHy0VGL2+ujYaG5x3dz1WVP3u9oiC68QMh
	uy/tqLwRiAMyxODA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sWzN9nXS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vb4eTYYi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791790136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjOXIGQy+i/5DrfRzrko/LNHxuUSj4ZwQC8QQbMhYNg=;
	b=sWzN9nXSlrh5NhlGJgas89MpI/3lokTk5U+jhi955w0KFtHFtUYqvUi3+7u/YOIXCMP2yc
	E5QQzTwpMMCGrY5CPrCOcok76qNkb7FD2qCzR9kKaKt+TYSzYFuD9ELBB+0nnw2+E8tj8m
	YQGU3kk9L2JPMCVK/5EZq0MCDYBoCqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791790136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bjOXIGQy+i/5DrfRzrko/LNHxuUSj4ZwQC8QQbMhYNg=;
	b=vb4eTYYiXP+k0rmuFbvblSigpa58HU55CWe97fnkQSiJi0UIihQ5uUX18t1lbnd3K5c0z0
	BxLIouZDJXJqtoBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E64913314;
	Mon, 12 Oct 2026 07:28:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mhWPDTiMzGp8YgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Oct 2026 07:28:56 +0000
Date: Mon, 12 Oct 2026 09:28:55 +0200
Message-ID: <87zewjgyx4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ting-Han Hou <ue081723@gmail.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: virtio: reset I/O message fill level on prepare
In-Reply-To: <20261011125426.35745-1-ue081723@gmail.com>
References: <20261011125426.35745-1-ue081723@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: B79511F791
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Sun, 11 Oct 2026 14:54:26 +0200,
Ting-Han Hou wrote:
> 
> Since commit fe981e67568c ("ALSA: virtio: use ack callback"), an I/O
> message is only queued to the device once the application has filled
> the whole period: virtsnd_pcm_msg_send() accumulates the transferred
> bytes in msg->length and queues the message when it reaches
> period_bytes.  msg->length is reset to 0 only when the device completes
> the message.
> 
> If the substream is stopped (e.g. snd_pcm_drop()) while a period is
> only partially filled, the corresponding message is never queued and
> keeps its partial length.  virtsnd_pcm_prepare() resets msg_count,
> hw_ptr and the indirect PCM state, but not msg->length.  After the
> next start, the stale length is added to the new data, the sum never
> equals period_bytes, and the message is never sent again.  Playback
> then stalls once hw_ptr reaches that period: writes fail with -EIO
> ("DMA or IRQ trouble") and drain fails with -EIO.  Capture is affected the
> same way after a partial read.
> 
> Clear the fill level of all messages in prepare.  Outside of the resume
> path, virtsnd_pcm_prepare() already refuses to run while I/O messages
> are pending, so no message is owned by the device at this point and the
> reset does not race with message completion.
> 
> Reproduced in QEMU (virtio-sound-pci, wav audiodev): prepare, write 1.5
> periods, drop, prepare, write 16 full periods, drain.  Without this
> patch WRITEI returns -EIO after 14 periods and DRAIN fails; with it all
> 16 periods are played and DRAIN succeeds.  Period-aligned prefill works
> in both cases.  The same sequence on capture (read 1.5 periods, drop,
> prepare, read 16 periods) fails with -EIO after 10 periods without this
> patch and reads all 16 with it.
> 
> Found by code inspection, confirmed with the reproducer above.
> 
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
> ---

Applied to for-next branch now.  Thanks.


Takashi
