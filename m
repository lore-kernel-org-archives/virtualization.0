Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DBA374E0
	for <virtualization@lists.linux.dev>; Tue, 13 Feb 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825666; cv=none; b=l26LiYjB4WvWdnIVQ88o7Pb0W4em9EuJVp3UDTbY3SHuGrLiVz1aC1nBrmfk85ColqyAZD7PVYe5zX5ondCEMsAFRu2auNwui1JrMqUCaViXl3pwdX/rqBufpWGWmrOo3JjF0QbB7YdzVlQn71pYRch9mBw53W9hpZnwPxyv7Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825666; c=relaxed/simple;
	bh=LlqMFc0KD+ARHuUxOVdF0nMLCR2bchX0uM6oN9g/KuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEyck8aE+BBCSlyQ96IxcgMilYuXvlzRCv6OvJ76gTlCD3zkIxO/2RTKt7cMawe3fKCeUAfe/cYNOxi668y3mC+EcxUy3xwZkbZJOETbnh7IcsTqnKNjqQR76U4BOt2wP5QVE03BIynKp7mZNNyxTb9+X9g3/Xjj4UEuL4Qcrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nYilzl+Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgak5yNP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nYilzl+Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rgak5yNP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nYilzl+Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgak5yNP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nYilzl+Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rgak5yNP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C34C22202;
	Tue, 13 Feb 2024 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=nYilzl+Q07/6rNMhbnC5vggZookLDqxqf29Fyfoio8cSQF2Nq+N1K0B7x9tqr5QySlgAd+
	d2HZJoJhA88KyuvspRh9hpYeLv1wOlkTZyYlOwt0X/WreomX3LmxShl3Ys5VgjVzgJSz0y
	ekecPa14JXxFd+s/JrmH1NquXKRmQvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=rgak5yNP+kOMVGyU9iyzXolzTVGr5kXyksSw8p4ssrRYRdHIRXimPEr0eB7+3iLAB4VgZT
	67HqdUaivg0LRXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707825660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=nYilzl+Q07/6rNMhbnC5vggZookLDqxqf29Fyfoio8cSQF2Nq+N1K0B7x9tqr5QySlgAd+
	d2HZJoJhA88KyuvspRh9hpYeLv1wOlkTZyYlOwt0X/WreomX3LmxShl3Ys5VgjVzgJSz0y
	ekecPa14JXxFd+s/JrmH1NquXKRmQvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707825660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfGsMKhC3RUEfvaT5VCui4TBVLfYZd6NdpQbaFjP+Bo=;
	b=rgak5yNP+kOMVGyU9iyzXolzTVGr5kXyksSw8p4ssrRYRdHIRXimPEr0eB7+3iLAB4VgZT
	67HqdUaivg0LRXBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F32D1370C;
	Tue, 13 Feb 2024 12:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ujJdCvxZy2UaAgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 13 Feb 2024 12:01:00 +0000
Message-ID: <63665452-69a0-4589-82c9-6ee5de735c67@suse.de>
Date: Tue, 13 Feb 2024 13:00:59 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240213073425.1621680-1-hch@lst.de>
 <20240213073425.1621680-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240213073425.1621680-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nYilzl+Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rgak5yNP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.58)[98.15%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -6.08
X-Rspamd-Queue-Id: 5C34C22202
X-Spam-Flag: NO

On 2/13/24 08:34, Christoph Hellwig wrote:
> Add a new queue_limits_{start,commit}_update pair of functions that
> allows taking an atomic snapshot of queue limits, update it, and
> commit it if it passes validity checking.  Also use the low-level
> validation helper to implement blk_set_default_limits instead of
> duplicating the initialization.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/blk-core.c       |   1 +
>   block/blk-settings.c   | 228 ++++++++++++++++++++++++++++++++++-------
>   block/blk.h            |   2 +-
>   include/linux/blkdev.h |  23 +++++
>   4 files changed, 217 insertions(+), 37 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

