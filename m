Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053D33F6
	for <virtualization@lists.linux.dev>; Mon,  2 Dec 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147345; cv=none; b=qRWXApeMunMJbA+zZH4Nqq4Yq7+8sGk0+pCC0aQONStQKsVuAqlHM+tWcccenDRqDoQeZrZ0qHlp4ybAJgvxoduI/YQutrLbETIoCk/WAvgXtpg5t8m0Kv9v/te5cvVVijE+75CCh1oSBhaqkLenKxMUBbkSzObjqesvCmnSH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147345; c=relaxed/simple;
	bh=Ah5hWMdfPFzst6CBjRABiissd/71Qcp2TxJFwtVPowE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXUTaNVFR/1qeXc7cxF7LnUsr/6Syerpg+kiuN1dUqh/sa4jAtSjvYF+LshJ8G5tqXzcDjmF5imZZx1ccrsS6Pd5uU5I5anFSN9dT/3oCldvVn8VuvGdeUSyCuHqwxFFiyv1iItdro3EOiWuvzmASGHdREgDTyItQdRd4ONQOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSnEGhJM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SVggcK2d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zSnEGhJM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SVggcK2d; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSnEGhJM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SVggcK2d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zSnEGhJM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SVggcK2d"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57201211CF;
	Mon,  2 Dec 2024 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733147342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=zSnEGhJMpzAV7OPerK/ECYunLFUvgXM1b9Cj1v+CMbAyPWhC6r9BRXGm9I36SC8/QOGB9N
	X4DjAEO5M9Vzy4XTjE3SWfhNNbXnYt8JHI0M8G1gnlD9f2GW1I1qjh+LYSqcdujkfmDaO9
	NboozgDQOZdNyLFrVqIs+qwi7ABoUvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733147342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=SVggcK2dh8P33y3NX+FkAluNvDieRYd5y8E3ZgL18r4zVEz4jPqzVqmweaLt0CDetRTb6Z
	rmcbXOcAxo9d0KCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733147342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=zSnEGhJMpzAV7OPerK/ECYunLFUvgXM1b9Cj1v+CMbAyPWhC6r9BRXGm9I36SC8/QOGB9N
	X4DjAEO5M9Vzy4XTjE3SWfhNNbXnYt8JHI0M8G1gnlD9f2GW1I1qjh+LYSqcdujkfmDaO9
	NboozgDQOZdNyLFrVqIs+qwi7ABoUvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733147342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qx7nVrFeR9OVdYomOaMq/GvODW8JLvzaL2rbW3wAPU=;
	b=SVggcK2dh8P33y3NX+FkAluNvDieRYd5y8E3ZgL18r4zVEz4jPqzVqmweaLt0CDetRTb6Z
	rmcbXOcAxo9d0KCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45906139C2;
	Mon,  2 Dec 2024 13:49:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ekEDEM66TWf9EQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 02 Dec 2024 13:49:02 +0000
Date: Mon, 2 Dec 2024 14:48:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 4/8] blk-mq: introduce blk_mq_map_hw_queues
Message-ID: <95035ac7-8707-4a69-8425-86a47841c15d@flourine.local>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
 <20241115-refactor-blk-affinity-helpers-v5-4-c472afd84d9f@kernel.org>
 <8b303ed8-f819-4fa2-b447-8d8f4a42b380@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b303ed8-f819-4fa2-b447-8d8f4a42b380@oracle.com>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Nov 21, 2024 at 09:08:02AM +0000, John Garry wrote:
> > +/**
> > + * blk_mq_map_hw_queues - Create CPU to hardware queue mapping
> > + * @qmap:	CPU to hardware queue map.
> > + * @dev:	The device to map queues.
> > + * @offset:	Queue offset to use for the device.
> 
> supernit: maybe no '.'

np. I've followed the style of the function right above. Dropped them.

> is there still a blank line at the bottom of the file?

It ends with (vim):

	}
	EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);
	~

I hope that is what it supposed to be.

Daniel
