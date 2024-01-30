Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F140846B
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625798; cv=none; b=I9yaCWUftF08SYHDUFv4jPPy3++9d1+Js8To34/EXh/BxPweO/eA0LnAFrgFiOHVmaXpjbCApw+DCDiCLg0w9m/C3v+E8XJNa611LV601n0Tc+IMDOcD2W2SQY8ktKHBC3ppUOo2aoG2GoRyPF3SYqE32wyAkpNQFxV3VZTvUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625798; c=relaxed/simple;
	bh=wd5wbUO1Mr6CE5hhSJmP+7cRaMTw0eDCGjrDb+eS/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh1cwYsUr4KguU6HcsRAKhTScm7a72Z3Jd5tZv7dI4Jb+DD43hMLz42EzM5TJl5v4m3aglj56UIWiXKB9Rh6HRNyeyBOB/o3P8FFCZj0ZrN6mIOzvjK0LWUnF2epsmVI5NMxdDDjfvj9OaSu/WAMQ3JIw7UzvzlSQEL90xOGxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 112CA68B05; Tue, 30 Jan 2024 15:43:14 +0100 (CET)
Date: Tue, 30 Jan 2024 15:43:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
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
	virtualization@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 04/14] block: use queue_limits_commit_update in
 queue_max_sectors_store
Message-ID: <20240130144313.GB32125@lst.de>
References: <20240128165813.3213508-1-hch@lst.de> <20240128165813.3213508-5-hch@lst.de> <e65301d3-7274-45fa-a64c-5039257aa333@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e65301d3-7274-45fa-a64c-5039257aa333@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 30, 2024 at 12:14:32PM +0000, John Garry wrote:
> On 28/01/2024 16:58, Christoph Hellwig wrote:
>> Convert queue_max_sectors_store to use queue_limits_commit_update to
>> check and update the max_sectors limit and freeze the queue before
>> doing so to ensure we don't have requests in flight while changing
>> the limits.
>>
>> Note that this removes the previously held queue_lock that doesn't
>> protect against any other reader or writer.
>
> I don't really get why we specifically locked that code segment in 
> queue_max_sectors_store() previously. Was it to ensure max_sectors and 
> q->disk->bdi->io_pages are always atomically updated?

It's been there basically forever.  Back in the day before blk-mq
and lock splitting it might actually have protected something.

