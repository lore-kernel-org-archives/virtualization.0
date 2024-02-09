Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6023612A
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484203; cv=none; b=jCmnTGtYTqHyIekil19zoYG41tAEaVOgAWGWk4KtMee4mi3UDo90UlCxmE+bOusn2jiTjwefMQMN2euk6APR4tAbXzy1qIFx98CxAU/ftUN8E2L7rvtpFKaYVDBtn9OfghLol9wGHPUx2By2nopAqq0B2tzxQQxHF2hArY1gyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484203; c=relaxed/simple;
	bh=uk+kzoCASqZmZnqekuxPV+sUaNOX7ZH8i3a3pm1Ynl4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHBNmWUNGJnAMpOc7uI4GiS47UZK1y0eoOs4Lv1kZiw2dZ6OKnuTdlbF6tlUVFSOwvBsANpG82N7StkhDmxG9nOSM+/epykCiYjUIvzKa/cufluFHaZrBVSsoAsB3LStW0mo+bjkzKFrmF+H1UfMo6obBFx830UreHlDWeBjTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EHaT4ps2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k6O7++Wk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EHaT4ps2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k6O7++Wk; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EHaT4ps2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k6O7++Wk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EHaT4ps2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k6O7++Wk"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 932A960723
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 13:10:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UrfL-wufd3YH
	for <virtualization@lists.linux-foundation.org>;
	Fri,  9 Feb 2024 13:10:00 +0000 (UTC)
X-Greylist: delayed 480 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 09 Feb 2024 13:10:00 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8FEE36071D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FEE36071D
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EHaT4ps2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k6O7++Wk;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EHaT4ps2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k6O7++Wk
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tiwai@suse.de; receiver=<UNKNOWN> 
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FEE36071D
	for <virtualization@lists.linux-foundation.org>; Fri,  9 Feb 2024 13:10:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F02C1FD40;
	Fri,  9 Feb 2024 13:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707483717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=EHaT4ps2bfpx1hA7NW0CjjJNjkF5/gt2qgNiYwAUWM4u1GN6nu4WYvzx48rn+PnC5Cods8
	wscVgB3U2Wcx+2RwDEEHNnJm2DxMNPFP9sL144Oo1zfk95nFFObfdvCr3diyVvKrlfdW1X
	pirv5kpUXBHz4OeK2r1vgB2dg+V8xt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707483717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=k6O7++WksDAnfAqyU4ldkaMrHp4IV186RM0LQhBHcndxZnsOLi48imfcD667AXtBhh1f3S
	ZwgOYUcYKhTBsBAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707483717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=EHaT4ps2bfpx1hA7NW0CjjJNjkF5/gt2qgNiYwAUWM4u1GN6nu4WYvzx48rn+PnC5Cods8
	wscVgB3U2Wcx+2RwDEEHNnJm2DxMNPFP9sL144Oo1zfk95nFFObfdvCr3diyVvKrlfdW1X
	pirv5kpUXBHz4OeK2r1vgB2dg+V8xt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707483717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4y8iC/kwLc3EVquXaBjRInwt4CwoNth/+iK0Wr9bVro=;
	b=k6O7++WksDAnfAqyU4ldkaMrHp4IV186RM0LQhBHcndxZnsOLi48imfcD667AXtBhh1f3S
	ZwgOYUcYKhTBsBAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 491D71326D;
	Fri,  9 Feb 2024 13:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZkR2EEUixmVgVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Feb 2024 13:01:57 +0000
Date: Fri, 09 Feb 2024 14:01:56 +0100
Message-ID: <877cjd23ln.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: mst@redhat.com,
	jasowang@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: [v2 PATCH 0/1] ALSA: virtio: add support for audio controls
In-Reply-To: <20240115133654.576068-1-aiswarya.cyriac@opensynergy.com>
References: <20240115133654.576068-1-aiswarya.cyriac@opensynergy.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.43%]

On Mon, 15 Jan 2024 14:36:53 +0100,
Aiswarya Cyriac wrote:
> 
> From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> 
> Changes in v2
> - Fix reporting of incorrect number of items for ENUMERATED controls
> 
> Implementation of support for audio controls in accordance with the
> extension of the virtio sound device specification[1] planned for
> virtio-v1.3-cs01.
> 
> Design　of virtual audio controls is based on and derived from ALSA
> audio controls. It allows the driver to perform all standard operations,
> such as reading and writing audio control value, as well as working with
> metadata (represented in the TLV form).
> 
> The driver part was tested on top of the Linux 5.10 kernel.
> 
> As a device part was used OpenSynergy proprietary implementation.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html
> 
> Anton Yakovlev (1):
>   ALSA: virtio: add support for audio controls

Applied now.  Thanks.


Takashi
