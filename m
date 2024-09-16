Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730C4E1CA
	for <virtualization@lists.linux.dev>; Mon, 16 Sep 2024 06:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469333; cv=none; b=Lm9CNrWxhqnCXDCVYeu+kPKH7VsBwbGGGqATq0Dtw1TUSNsdWb3aIdGrgSOZQPI4qug534GibluFr14nQawA8sePxvwVfrE52JkAlShfV3Qu9hqeHgLyBHXWnfPSIVxPCrSc5OWsRq2EgFypbiPvnqOXmlBKUaoLBQ+UZPSlZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469333; c=relaxed/simple;
	bh=y8BURP73rNIkllDOPgxsGnvJZjK9VISFdAoxhnkEplA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMjWcpYink/mT4c95O4ZuFAnavVeFhsJaIJxXHFqcB2s73j/wfY2Bmjga6ky2oJKkVHd8v5H2YtsuWrRngS6Sr/ognTY5YY/94ruP4vwjSoCsfefZH0u2wbbe/I01jioTxGX6UJlgau5qeKNe7X/6qxfT9lPgWTVQ/MhFqRN2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92036227AAA; Mon, 16 Sep 2024 08:48:46 +0200 (CEST)
Date: Mon, 16 Sep 2024 08:48:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de,
	Ming Lei <ming.lei@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20240916064846.GA15950@lst.de>
References: <20240913-refactor-blk-affinity-helpers-v1-1-8e058f77af12@suse.de> <20240913162654.GA713813@bhelgaas>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913162654.GA713813@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 13, 2024 at 11:26:54AM -0500, Bjorn Helgaas wrote:
> > +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
> > +					      int queue)
> > +{
> > +	struct pci_dev *pdev = dev_data;
> > +
> > +	return pci_irq_get_affinity(pdev, offset + queue);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
> > +#endif
> 
> IMO this doesn't really fit well in drivers/pci since it doesn't add
> any PCI-specific knowledge or require any PCI core internals, and the
> parameters are blk-specific.  I don't object to the code, but it seems
> like it could go somewhere in block/?

That's where it, or rather the current equivalent, lives, which is a bit
silly.  That being said, I suspect the nicest thing would be to offer a
real irq_get_affinity interface at the bus level.

e.g. add something like:


	const struct cpumask *(*irq_get_affinity(struct device *dev,
			unsigned int irq_vec);

to struct bus_type so that any layer can just query the irq affinity
for buses that support it without extra glue code.
