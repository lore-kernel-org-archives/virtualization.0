Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7A25D540
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534320; cv=none; b=UfB4GdNmDZx7De2y+C3sVRlq663ipFY5wopckjYJSSRTDLLZL6bL4Yo8FCDsfbjuuLmdlOcZW27cN8x1yZV9JZ+E7A9xv2kzKmP3n3Bb0H3Tnob1j3KjSlgNf1jxSLYPieQsYUE8Sh/PaOvGbsvs/f9bUr1dF55GIf7LIUC/FUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534320; c=relaxed/simple;
	bh=Bw1Wni8PVJKB8ct4C0lBm/mrz/yGSL/9h3pNutsqldY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swKcj5DdVjYrMJbsEbNUv9LaKKhhpSUmFRUln1oO/nu4nj9KmjNkLjWVRNOF7H/D2YLqLHZ6z1sfES2xThmA7TiuNOYYctAIm4jQjEW+x2aFiLgcjK+6d5eWwppy0HpgXfadKxgWWG2Vvphf1h1mifAUktT1r0oDmM8LQ39uKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZoCe3upb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LMzMvxCn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZoCe3upb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LMzMvxCn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZoCe3upb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LMzMvxCn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZoCe3upb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LMzMvxCn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C16711F381;
	Fri, 14 Feb 2025 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739534315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQjespEd5/tNEXzDlgnq2wiQ7RZeZd7mguA0lnqj8b0=;
	b=ZoCe3upbuSoryaYtdRg8wsw7jxUWrRnTU987WIhS5D61AMn31YiT8r/zo695i8uSZXuzfo
	wkx7N5GxPpOsFGNBdDXJPSgY2WVjM4+uZgqv/KvyIYsd3l1NQdg6uh037e/0G/pHFAscuR
	1hfJoSi1cMcAmanhtWOsrWdi9KFBf3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739534315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQjespEd5/tNEXzDlgnq2wiQ7RZeZd7mguA0lnqj8b0=;
	b=LMzMvxCn3l0m3zvsP3ZJ0qoiTn546ODceZnwzVXENc66GFu4bNZNldUUQn5TV6gpkCUA+L
	WlHfj1ak+3vnB5CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739534315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQjespEd5/tNEXzDlgnq2wiQ7RZeZd7mguA0lnqj8b0=;
	b=ZoCe3upbuSoryaYtdRg8wsw7jxUWrRnTU987WIhS5D61AMn31YiT8r/zo695i8uSZXuzfo
	wkx7N5GxPpOsFGNBdDXJPSgY2WVjM4+uZgqv/KvyIYsd3l1NQdg6uh037e/0G/pHFAscuR
	1hfJoSi1cMcAmanhtWOsrWdi9KFBf3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739534315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQjespEd5/tNEXzDlgnq2wiQ7RZeZd7mguA0lnqj8b0=;
	b=LMzMvxCn3l0m3zvsP3ZJ0qoiTn546ODceZnwzVXENc66GFu4bNZNldUUQn5TV6gpkCUA+L
	WlHfj1ak+3vnB5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF27C13285;
	Fri, 14 Feb 2025 11:58:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YE61Nuovr2cfbAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Feb 2025 11:58:34 +0000
Date: Fri, 14 Feb 2025 12:58:34 +0100
Message-ID: <874j0w3fh1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,	Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>,	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	linux-sound@vger.kernel.org,	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,	Anton Yakovlev
 <anton.yakovlev@opensynergy.com>,	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_snd.h: clarify that `controls` depends on VIRTIO_SND_F_CTLS
In-Reply-To: <20250213161825.139952-1-sgarzare@redhat.com>
References: <20250213161825.139952-1-sgarzare@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 13 Feb 2025 17:18:25 +0100,
Stefano Garzarella wrote:
> 
> As defined in the specification, the `controls` field in the configuration
> space is only valid/present if VIRTIO_SND_F_CTLS is negotiated.
> 
>   From https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html:
> 
>   5.14.4 Device Configuration Layout
>     ...
>     controls
>        (driver-read-only) indicates a total number of all available control
>        elements if VIRTIO_SND_F_CTLS has been negotiated.
> 
> Let's use the same style used in virtio_blk.h to clarify this and to avoid
> confusion as happened in QEMU (see link).
> 
> Link: https://gitlab.com/qemu-project/qemu/-/issues/2805
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Applied now.  Thanks.


Takashi
