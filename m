Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275A200108
	for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430526; cv=none; b=vGnA7UrXw2qEoHyC/R154hiYgiTo7g0RDA4MW7JiG/ghVN5RTIBkJrl8mXH9Sd/aiICixw3FuJuKO4e/1fUGCnT/aCzlQON67XZ+U160ZNOWcD/i1p5rzP4I7LklDguBGl8wjxF/7K/Mo9/oPIX+Af9RMvVs8U1R9VVq9boHosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430526; c=relaxed/simple;
	bh=oHV8dgGJODRzQnAXfGtHcp8b24tt13yTkYH7gtMa1WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlX3yS6+KHYwTsbenSXhBWiHvNl1Wtiw8vWE4dQpPKAVGanI41eEFBVH9rQUQ61NTejLYHzPmAtcz8y5Lchvhdj5qjIlkLsWGl+QP1kEz4vcJWxQ3CnIvEp7EChNI4dJ7/7yg12HIQIOPxA5Gp4fAIFyCT/LNpecA9VhzmV6Erw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 56FAE68D0E; Tue, 12 Nov 2024 17:55:22 +0100 (CET)
Date: Tue, 12 Nov 2024 17:55:22 +0100
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
Subject: Re: [PATCH v3 3/8] virtio: hookup irq_get_affinity callback
Message-ID: <20241112165522.GC20057@lst.de>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org> <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-3-573bfca0cbd8@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 12, 2024 at 02:26:18PM +0100, Daniel Wagner wrote:
> struct bus_type has a new callback for retrieving the IRQ affinity for a
> device. Hook this callback up for virtio based devices.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

