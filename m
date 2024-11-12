Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB92076BE
	for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430477; cv=none; b=YtY5q2TQmFNi9EG3Dj25nJ6IpdRUP1TElBRslI3zGsppKyXEsYMMg9N8/rserT7GHFc1MUSXqxsKXn2JaQGSjU0kmi2KKtaO1TYICc6IVKMDayDkafEExDemtlEBaCeUtXt1NeWcRdmNstokb/uuz+me4IO0hqlfd5Ktx6VTusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430477; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2lROlRr5IcYdbxGaoiWtTHnf/r7HTNIBxWI/7Vs+rDRSZHSJ0klIWfbFYxHfqEtRzuGax7vhT9UqzkQwWWP/fuOQscquUYxtS72J4gMf4xA5I6XGVTfT5IMW6QNe8iBgjMsWYG7+Sp1PZiSeLt4v2etSvzqpIKS953mi//ivXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6192368D0D; Tue, 12 Nov 2024 17:54:33 +0100 (CET)
Date: Tue, 12 Nov 2024 17:54:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
	storagedev@microchip.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/8] PCI: hookup irq_get_affinity callback
Message-ID: <20241112165433.GB20057@lst.de>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org> <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

