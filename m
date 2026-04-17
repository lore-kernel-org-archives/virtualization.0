Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C95E372EE6
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412181; cv=none; b=ivQbIGlvbldoLc/LTFaIN95abjSXDPgUlI189LG/u1FGHUGsegWc7ZEKLSSBye0XP2hqgHOd4ZOQL9WnU0dh91Yf0/jwY/p1vsJBy6zCmf8J1x0ERDh2xSWLInaprb158vx5zDA0iiTf0z19q8oz/hO3c6APcaQyKa01zS2xLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412181; c=relaxed/simple;
	bh=p8RmUwAU7U/33Fw0c6zNK01iulM49dRAVylcgx+Ptsg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmB7Pcpu6FmMP8JKlSO4acdKd+pXG/QmCco/IP9QpWx2/VMocPNncKLTGH1KS/tnvEWl20mthRD2DBY17wYX6ZZuymxSmopSi2NT5/phYkK2ZQiHWB3yfxU3gYefd35MWdmVtr1IGQmS+VZihNU6n1aWkbJzKBu8Ber6XN5NguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tAR8ZPKB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qnKOD8a+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tAR8ZPKB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qnKOD8a+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tAR8ZPKB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qnKOD8a+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tAR8ZPKB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qnKOD8a+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73B516A98D;
	Fri, 17 Apr 2026 07:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776412170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9Q5IX4NnP3EvODsm2WILEuflHU95fv1s5nhHTz5GYI=;
	b=tAR8ZPKBq/8muKNyLcu0KCxS4+g18JP0W43QKvYwEojby2VWCDb75RDc6EHngoeMGrmfNe
	n4vTPL2hOn/9ErgbPZ2RmdJZohqGCGKSoDU/zso+nVYCM21/IsEELe73CgARIBMmBQ1tMS
	TD/5vftiqGyOFopgSozoUGvGcyZdXV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776412170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9Q5IX4NnP3EvODsm2WILEuflHU95fv1s5nhHTz5GYI=;
	b=qnKOD8a+5P115EvlpH77BZL5DL5iHONhEu9bKOo1szipurLbhYhzjv9GIkDE06bcr50iRd
	IHIqyr9kA9DH2HCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tAR8ZPKB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qnKOD8a+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776412170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9Q5IX4NnP3EvODsm2WILEuflHU95fv1s5nhHTz5GYI=;
	b=tAR8ZPKBq/8muKNyLcu0KCxS4+g18JP0W43QKvYwEojby2VWCDb75RDc6EHngoeMGrmfNe
	n4vTPL2hOn/9ErgbPZ2RmdJZohqGCGKSoDU/zso+nVYCM21/IsEELe73CgARIBMmBQ1tMS
	TD/5vftiqGyOFopgSozoUGvGcyZdXV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776412170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n9Q5IX4NnP3EvODsm2WILEuflHU95fv1s5nhHTz5GYI=;
	b=qnKOD8a+5P115EvlpH77BZL5DL5iHONhEu9bKOo1szipurLbhYhzjv9GIkDE06bcr50iRd
	IHIqyr9kA9DH2HCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FDAE593AE;
	Fri, 17 Apr 2026 07:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Ao0Dgrm4Wk/FgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Apr 2026 07:49:30 +0000
Date: Fri, 17 Apr 2026 09:49:29 +0200
Message-ID: <87mrz2do1i.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-sound@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: virtio: drop an extaneous kernel-doc comment
In-Reply-To: <75a01b73-f46a-47fd-91bb-4ce9d5c30866@infradead.org>
References: <20260216055956.2784399-1-rdunlap@infradead.org>
	<75a01b73-f46a-47fd-91bb-4ce9d5c30866@infradead.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email,suse.de:dkim,suse.de:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 73B516A98D

On Fri, 17 Apr 2026 00:00:17 +0200,
Randy Dunlap wrote:
> 
> ping.
> 
> On 2/15/26 9:59 PM, Randy Dunlap wrote:
> > Drop a kernel-doc struct comment since the struct member was removed.
> > This eliminates a kernel-doc warning when make W=1 is used.
> > 
> > virtio_pcm.h:65: warning: Excess struct member 'msg_last_enqueued'
> >  description in 'virtio_pcm_substream'
> > 
> > Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Cc: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: virtualization@lists.linux.dev
> > Cc: Jaroslav Kysela <perex@perex.cz>
> > Cc: Takashi Iwai <tiwai@suse.com>
> > Cc: linux-sound@vger.kernel.org
> > 
> >  sound/virtio/virtio_pcm.h |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > --- linux-next-20251210.orig/sound/virtio/virtio_pcm.h
> > +++ linux-next-20251210/sound/virtio/virtio_pcm.h
> > @@ -37,7 +37,6 @@ struct virtio_pcm_msg;
> >   *             the device side at resume.
> >   * @msgs: Allocated I/O messages.
> >   * @nmsgs: Number of allocated I/O messages.
> > - * @msg_last_enqueued: Index of the last I/O message added to the virtqueue.
> >   * @msg_count: Number of pending I/O messages in the virtqueue.
> >   * @msg_empty: Notify when msg_count is zero.
> >   */

Sorry, it slipped from my inbox, maybe it hit on a bad day :-<

Applied now this and another one for vx.  Thanks.


Takashi
