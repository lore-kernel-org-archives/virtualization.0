Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7C9111BF
	for <virtualization@lists.linux.dev>; Mon, 23 Jun 2025 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655987; cv=none; b=CivHhmyD1wMz9uepY4mcL5a2xn47mZNHY7ssR7rngBHdidLiLWoEhBW7roRiG6D0OpXc2uEzhsfvQ6fAPWFEVOh2mtn0N1DSf2F8FGyCYwouXcBs5ua5bTBg8VxAIb+hQPnky8zROgBUFMi/8GJZE2OAdydsutVNFvf+4rzbH3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655987; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH8eMsG7T6zTAqwS7Xv8MhYqGxC1qBxu2lFrz/8ZV2Gk2WwBVlAS0cT41B/1AdHy8v9eFc1p+J2e9dd31vYm8Ny8knCk1T6XKZZ1IuaqSmrGpF7r644aWiUgadHyuENT4ni7/yEwmy5ev3b6z6e3IKSt4v3lDfyl4qwm0BNq89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 379D868AFE; Mon, 23 Jun 2025 07:19:34 +0200 (CEST)
Date: Mon, 23 Jun 2025 07:19:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/5] lib/group_cpus: Let group_cpu_evenly() return the
 number of initialized masks
Message-ID: <20250623051934.GA29628@lst.de>
References: <20250617-isolcpus-queue-counters-v1-0-13923686b54b@kernel.org> <20250617-isolcpus-queue-counters-v1-1-13923686b54b@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-isolcpus-queue-counters-v1-1-13923686b54b@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

