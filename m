Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B41B5AC
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088114; cv=none; b=rJkyA/jejzSJxYgoUVJI/GvSmSZnlCgUDjI9sGdrxkkYn6egZi/xwb58Vf2bKnXq/oUFqbKQDXF+i6UXg2Xuj3K38DIq80TxVdomnlfFT546EGN5wKrTo7v+wy378NjXtRtXyPs0jaSPZvjx1P6XrVx5sKCg8PgYmyAjl67ALCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088114; c=relaxed/simple;
	bh=Q0kfJGwfJNRpe/Ml0n5ViX31n5MiHcRCZGahnNtHrwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7m3fgRpey3bhYpfslokdHTcOVFZBJmrsL/KpaphtbSfyDa/j0w0pyH3IAPZl33GMvGguXEhRU2by6c6TyfTJ2pA0eGyTjuIIGc+R66apRYFCR2ElhTc/+QWnXXK9BvPQUQ8Lm8hWXU00LTtlJ7OZwX6io9vPsU8kJg2vkbbfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0EC1B68AFE; Wed, 24 Jan 2024 10:21:49 +0100 (CET)
Date: Wed, 24 Jan 2024 10:21:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/15] block: add an API to atomically update queue
 limits
Message-ID: <20240124092148.GA28770@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-4-hch@lst.de> <de3cd926-c78c-4e68-bee0-2f571ccdaf8d@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3cd926-c78c-4e68-bee0-2f571ccdaf8d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 07:08:58AM +0100, Hannes Reinecke wrote:
>> + * that there is outstanding I/O by other means.
>> + */
>> +static inline struct queue_limits
>> +queue_limits_start_update(struct request_queue *q)
>> +	__acquires(q->limits_lock)
>> +{
>> +	mutex_lock(&q->limits_lock);
>> +	return q->limits;
>> +}
>
> I'm slightly confused about the lifetime of the returned structure.
> By my understanding, the returned 'struct queue_limit' is allocated
> on the stack of the caller, right?
> Shouldn't we note this somewhere such that people don't start passing
> the structure around, or, worse, calling 'kfree()' on it?

queue_limits_start_update returns the structure by value.  So the
lifetime is that of whatever variable you assign it to, which better
be on the stack.  Tryign to kfree a non-pointer type will get the
compiler complain, as does passing a reference to it outside the
function these days.
