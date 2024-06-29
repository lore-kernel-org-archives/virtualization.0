Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE76381AD
	for <virtualization@lists.linux.dev>; Sat, 29 Jun 2024 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719638412; cv=none; b=ewF2QrooEQI4Ika05KWwFWnYXdGL9ia+SWHClE2mtzCBo22mB4RQjFFUUidknSvUqnhzweKd/jBbeCt2Ke7mFZjOfX9IpRW7a6dVeNLDFlFxn7jgMVSNmwnQFsbpSSC7ARqHEHpQdMcznrD+Nm8KcWIOqUO1J4/6vPeGq3QXpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719638412; c=relaxed/simple;
	bh=AdoVOo4uCFHh2X3ETDQ5L+aDQJjKSJtvqIwVF0F48GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUc5PDDlpXGnv6BAlCjZqzEx2NgPwMRtPV8zplc+t913vWJP791QsPydEWCexUgdqWwZQzTx6l8wQ4bnXVYgJXNZGRtdATUkeMH6ej92vrOytPcBDmPtqp7UrBLgTbYeHt/pucOSPPc87DtWRbvlkupD5joDCDh5FeIbVyKc2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0280A68BEB; Sat, 29 Jun 2024 07:19:58 +0200 (CEST)
Date: Sat, 29 Jun 2024 07:19:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to
 blk_mq_alloc_disk
Message-ID: <20240629051958.GA15371@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-13-hch@lst.de> <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 28, 2024 at 03:25:02PM +0100, John Garry wrote:
> I think that we might need a change like the following change after this:
>
> ----8<----
> [PATCH] virtio_blk: Fix default logical block size
>
> If we fail to read a logical block size in virtblk_read_limits() ->
> virtio_cread_feature(), then we default to what is in
> lim->logical_block_size, but that would be 0.
>
> We can deal with lim->logical_block_size = 0 later in the
> blk_mq_alloc_disk(), but the subsequent code in virtblk_read_limits() 
> cannot, so give a default of SECTOR_SIZE.

I think the right fix would be to initialize it where the virtio code
currently uses the uninitialized lim->logical_block_size.  That assumes
that we really want to handle this case.  If reading the block size
fails, can we really trust reading other less basic attributes?  Or
should we just fail the probe?

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6c64a67ab9c901..5bde41505818f9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1303,7 +1303,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 
 		lim->logical_block_size = blk_size;
 	} else
-		blk_size = lim->logical_block_size;
+		blk_size = SECTOR_SIZE;
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
