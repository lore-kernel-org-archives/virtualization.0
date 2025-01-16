Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACF22A809
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035801; cv=none; b=i3v0E6sXfn/yyKsX35ldXFzNXJ/TNuNAzY7jjynvZZ4n6tXtPzNodEXNP53/k14Hrbn9ICJvLwdC1KhiSbrb5p8rcdLPFn4MmE0DQ8QHG5DmiqQFFNY5WyNHqqB1rjEMyovcOZsYZ9hfNx1Pne7d1zGdvDXgL0rLOvSGeNbTcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035801; c=relaxed/simple;
	bh=FBOdIWSvN+AF8hTbNvRN4h7LIMA+A/Sza0H+lio0P9w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doTCE9sQ64eTmbCC/h+Tz+GgDox6PC82VT0tI/H0B6RF6et+RMTFRVgHyoaJARI4agBHIdqaAKK8xB9EgKTffG8MUV+FqQoyEcWG2I1C8pWEnNyZ9FZ4T55TKxin6x4kmNkjx744Opqq6ZgZgUbu4QqGjetvybMxKp+XAjEa9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AsiH0uCE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TmgmVthR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AsiH0uCE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TmgmVthR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AsiH0uCE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TmgmVthR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AsiH0uCE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TmgmVthR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82822211EC;
	Thu, 16 Jan 2025 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737035797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH9ws4NI7yAw9uNlgf72kIluOgpsV2iPQpo7pOsI9pA=;
	b=AsiH0uCEtt+tVRflHderAd/Rd/JP0eMDc3eAvDC3zuzMJSZZJ7CU1AG2yA+KZQ2+tbrPCN
	zyc5N2NO8grZ2n/2hC/tDKhPBgivzvYlXSdvsbeNu00M2oXypGjE3RuQO1qsqHlgze7omv
	kslrdXeY/uJj5kGhRtcumKJhUI7Sspo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737035797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH9ws4NI7yAw9uNlgf72kIluOgpsV2iPQpo7pOsI9pA=;
	b=TmgmVthRUD/+fXjQ/t46WAfLK93t8xIWmwC8EQhXV66iuhdIOdIEVHVsBItumLyYPYe//B
	/rpRgTrUonfaXADw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AsiH0uCE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TmgmVthR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737035797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH9ws4NI7yAw9uNlgf72kIluOgpsV2iPQpo7pOsI9pA=;
	b=AsiH0uCEtt+tVRflHderAd/Rd/JP0eMDc3eAvDC3zuzMJSZZJ7CU1AG2yA+KZQ2+tbrPCN
	zyc5N2NO8grZ2n/2hC/tDKhPBgivzvYlXSdvsbeNu00M2oXypGjE3RuQO1qsqHlgze7omv
	kslrdXeY/uJj5kGhRtcumKJhUI7Sspo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737035797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YH9ws4NI7yAw9uNlgf72kIluOgpsV2iPQpo7pOsI9pA=;
	b=TmgmVthRUD/+fXjQ/t46WAfLK93t8xIWmwC8EQhXV66iuhdIOdIEVHVsBItumLyYPYe//B
	/rpRgTrUonfaXADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3778113332;
	Thu, 16 Jan 2025 13:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ITMvDBUQiWf3GgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Jan 2025 13:56:37 +0000
Date: Thu, 16 Jan 2025 14:56:36 +0100
Message-ID: <87ed12j20b.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	kernel-team@android.com,
	Betty Zhou <bettyzhou@google.com>
Subject: Re: [RFC][PATCH] sound/virtio: Fix cancel_sync warnings on uninitialized work_structs
In-Reply-To: <20250116062514.2391108-1-jstultz@google.com>
References: <20250116062514.2391108-1-jstultz@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 82822211EC
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 16 Jan 2025 07:25:08 +0100,
John Stultz wrote:
> 
> Betty reported hitting the following warning:
> 
> [    8.709131][  T221] WARNING: CPU: 2 PID: 221 at kernel/workqueue.c:4182
> ...
> [    8.713282][  T221] Call trace:
> [    8.713365][  T221]  __flush_work+0x8d0/0x914
> [    8.713468][  T221]  __cancel_work_sync+0xac/0xfc
> [    8.713570][  T221]  cancel_work_sync+0x24/0x34
> [    8.713667][  T221]  virtsnd_remove+0xa8/0xf8 [virtio_snd ab15f34d0dd772f6d11327e08a81d46dc9c36276]
> [    8.713868][  T221]  virtsnd_probe+0x48c/0x664 [virtio_snd ab15f34d0dd772f6d11327e08a81d46dc9c36276]
> [    8.714035][  T221]  virtio_dev_probe+0x28c/0x390
> [    8.714139][  T221]  really_probe+0x1bc/0x4c8
> ...
> 
> It seems we're hitting the error path in virtsnd_probe(), which
> triggers a virtsnd_remove() which iterates over the substreams
> calling cancel_work_sync() on the elapsed_period work_struct.
> 
> Looking at the code, from earlier in:
> virtsnd_probe()->virtsnd_build_devs()->virtsnd_pcm_parse_cfg()
> 
> We set snd->nsubstreams, allocate the snd->substreams, and if
> we then hit an error on the info allocation or something in
> virtsnd_ctl_query_info() fails, we will exit without having
> initialized the elapsed_period work_struct.
> 
> When that error path unwinds we then call virtsnd_remove()
> which as long as the substreams array is allocated, will iterate
> through calling cancel_work_sync() on the uninitialized work
> struct hitting this warning.
> 
> The simplest fix seems to just check the work_struct->func ptr
> is valid before calling cancel_work_sync(), but I wanted to share
> in case folks had ideas for a better solution.
> 
> I have not yet managed to reproduce the issue myself, so this
> patch has had limited testing.
> 
> Feedback or thoughts would be appreciated!

The conditional canceling is a bit flaky, IMHO.
Alternatively, we can initialize the whole stuff right after the
allocation, e.g. something like below.


thanks,

Takashi

--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -339,6 +339,16 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 	if (!snd->substreams)
 		return -ENOMEM;
 
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		vss->snd = snd;
+		vss->sid = i;
+		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		init_waitqueue_head(&vss->msg_empty);
+		spin_lock_init(&vss->lock);
+	}
+
 	info = kcalloc(snd->nsubstreams, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -352,12 +362,6 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
 		struct virtio_pcm *vpcm;
 
-		vss->snd = snd;
-		vss->sid = i;
-		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
-		init_waitqueue_head(&vss->msg_empty);
-		spin_lock_init(&vss->lock);
-
 		rc = virtsnd_pcm_build_hw(vss, &info[i]);
 		if (rc)
 			goto on_exit;
