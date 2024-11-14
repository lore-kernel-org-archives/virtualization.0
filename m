Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1921F8F13
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586314; cv=none; b=mraDaz5eEtsbN4rwgbioC7kiqPrQtDzGED6In88ydWROS4mdTSQYFpods+btS2TX1oXsXO0rQtuXxY0h4BOmHYUFsP6NV9Hvb2OYQePvL8HA3ztYhriChiFcxu01qOGrtI757dZddc3FKkQEaK1zjvJ3Rp1SokbHNTKmPMu+4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586314; c=relaxed/simple;
	bh=PWFtEIgkc0mzcM/xXRLuGdPlrM4paLHdMvN0eRuZ+bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzvzoE4rOJ8GZNsC9AzNr0PzZ0/crsuLc3W4QqKAk2//Ta5Pjeup5RB0Y5mfGX3eUTdeVQ9rTN6ZYRJZUYw/JT8ChfdsPqfv/uQIJ6CdsamMA7XG5hdMMjWSl66KXrbe5zRwJFSqGDt6KHKwZuv41d7IAWyaARjECqViem9NM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47A2568C7B; Thu, 14 Nov 2024 13:11:47 +0100 (CET)
Date: Thu, 14 Nov 2024 13:11:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20241114121147.GA3074@lst.de>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org> <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org> <ZzVZQbZOYhNF08LX@fedora> <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local> <ZzW-9rWvKBxFZU1E@fedora> <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 14, 2024 at 01:06:49PM +0100, Daniel Wagner wrote:
> Oh, I was not aware of this ordering. And after digging this up here:
> 
> https://lore.kernel.org/all/20060105142951.13.01@flint.arm.linux.org.uk/
> 
> I don't think we it's worthwhile to add the callback to device_driver
> just for hisi_sas_v2. So I am going to drop this part again.

Yes, I don't really see how querying driver specific information like
this from code called by the driver make much sense. 

