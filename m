Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C143DA4B
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836921; cv=none; b=eIRl+p2QNdN5DF5aaVm3Fg+BRQ0OvX26f0AsLRMRasx+FP66YUIPSSxC0VlShrKt5lHatHphQIq/K+76OFXm6K2kh3UhebVRFJmJh6j5uaWEojgW3xkuTsDyZd1C5yTVfFsoJyOD8cHw35vGTiy8Zrojs0oztE0CLxXjOReUZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836921; c=relaxed/simple;
	bh=BzIZ2Js6Ee3WqJhSyTJNHhDtTiyLZnraCSY+K9Ta9X0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syyWNMnPYp8cCS9ryPINR1SJzu3URBlkYfgEszoCkZALqQwagUMhOmQlnjH1HZKvI3dbBbJJnyZjoeMghNnsG2bQnVTNlpDsa7JYqg3Nbbjv97Nt2m27nTxAsu9brj2hLgc9TlXSlutLWkEGHJPOVs9KMp0Sz72kEoOxfhbYz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FECjXTAB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LM3vZH3u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tF5tMWAh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/UL8X7Vg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FECjXTAB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LM3vZH3u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tF5tMWAh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/UL8X7Vg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B379A5CFC9;
	Fri, 15 May 2026 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778836918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=FECjXTABr4ThkQ+cxBcfFo3FJIW8Vr8VEVyKAsBU8IiRWuzy+YsDbSBGkkg2Ln4MSNYzoc
	NYlhN0EV/Csbse+Q05sQmoafkYnh/sA831R5x9XTxKnxbLPuXE9hiUysyKV+Np9OiYvreI
	mBTkKjhAS54Bk/soTA++G3SFL8u8JfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778836918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=LM3vZH3u9yuLa7+udBWkkEm5Bz1JxIbH0NCLySJ9yp5/j0AqF+nV+CESsywn+7HEheOomB
	rxcKPcNiJPA30jDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tF5tMWAh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/UL8X7Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778836917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=tF5tMWAhHY0+eirCEkDkyM1L5NQMmB0zVumlVNFt/KLBy9e6ctigH3XdtH+x8ybNQf1z8l
	OfbzRmpjmKge+5/g1x66ETUAp8NxzBgA7TWDOMfntB70V+jx3d5nRsH9fonH1OaHFRahjX
	ZCkoNE03rlAR0j2Hpp3suWplixc7rBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778836917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=/UL8X7VgEB9fszJkueKxUSpN8+Z8kQ8q6Xa7FnEDYL1g4Tzx+Y6kM15/jHIn9clITnyffB
	MInAcVhg10sOzSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 692B6593A9;
	Fri, 15 May 2026 09:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p2BhGLXlBmowaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 09:21:57 +0000
Date: Fri, 15 May 2026 11:21:56 +0200
Message-ID: <87h5o9t4cr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: virtio: Validate control metadata from the device
In-Reply-To: <20260507-alsa-virtio-validate-kctl-info-v1-1-7404fb12ec37@gmail.com>
References: <20260507-alsa-virtio-validate-kctl-info-v1-1-7404fb12ec37@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B379A5CFC9
X-Spam-Level: 

On Thu, 07 May 2026 16:28:30 +0200,
Cássio Gabriel wrote:
> 
> virtio-snd control handling trusts the device-provided control type and
> value count returned by the device.
> 
> That metadata is then used directly to index g_v2a_type_map[] in
> virtsnd_kctl_info(), and to size loops and memcpy() operations in
> virtsnd_kctl_get() and virtsnd_kctl_put() against fixed-size
> virtio_snd_ctl_value and snd_ctl_elem_value arrays.
> 
> A buggy or malicious device can therefore trigger out-of-bounds access by
> advertising an invalid control type or an oversized value count.
> 
> Validate control type and count once in virtsnd_kctl_parse_cfg(), before
> querying enumerated items or exposing the control to ALSA.
> 
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi
