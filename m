Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9818E1F
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729493; cv=none; b=ODPTBDOpIY2pCo1yJLCdpCvPpi1mqXWJ1xwwcK+jW3DLEOZIqaFBGkiwYVy+og2pB/mkgt9BbXPHobUBoh40GDlKfv1D44lbX66T1Q+dXB6impqCKh35Z+RUrbpHQxDlJIAuF6k5NHO+aCMYP9cAr5I9kon2cbCyz7jrAtST3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729493; c=relaxed/simple;
	bh=ZsAX6fYNBN8s4cM6prV7+Nw4KR6G6zRcui+vpWCXiiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5flxpwxD2aN9tFyrsy7JDg5nnwT0bzS7ob5nkq2DSvZLvXHJKTuI1wXmTno0d4eiItAQ3KjWbbyeJNdqFlq7CAOjSGL8jdC1H8+1TmsaA0YrBWf33NXf25h+ub/yuB55YSfD3OorwBL9VsXyrebfvKt6kknpFk+VUbXYnsLkco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSaPmSwp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSaPmSwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724729491; x=1756265491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZsAX6fYNBN8s4cM6prV7+Nw4KR6G6zRcui+vpWCXiiM=;
  b=PSaPmSwpM2WrWSQTzvBl5Ud58MQeq/GOIvwHg038+eEphwVZ1NywLfY8
   ZjlOiTvXqCofOx6BouyX6TPokx5uT25bZMT9y4iHxooLXoH7BS0FvKZN+
   vdcf0URZ5khdbPtUmXVBVif/VNWqca48M/Ocm/g+QMwy32c4TAPuZcILk
   Mdsk5MxzEM75Vn5R3of45YZ1pm2e5HcSDwwE9hot22pz4UjHwChqXuMpY
   rpAheBXjN9g8iRUq/IjGjl5vpVRVVEurCSgPHmrFHpOe3doVy4KyVRYEs
   21doYC/7AaJFbUi5n7Mk92clmHgHYA91rSdcF/uLicM5G8na/gCeSNGyu
   w==;
X-CSE-ConnectionGUID: GWD1HdMpQaKs/Q1J59cKFg==
X-CSE-MsgGUID: v/ALJmCYS1eq/kpWnkGeag==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23154129"
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="23154129"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 20:31:30 -0700
X-CSE-ConnectionGUID: QDU5QLH3TqucnA37kaonFw==
X-CSE-MsgGUID: w9+02ioqSw6jKQ/o9ovjaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,179,1719903600"; 
   d="scan'208";a="62698679"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 26 Aug 2024 20:31:22 -0700
Date: Tue, 27 Aug 2024 11:28:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3 2/9] fpga/dfl-pci.c: Replace deprecated PCI functions
Message-ID: <Zs1H+zgzZAuLUnza@yilunxu-OptiPlex-7050>
References: <20240822134744.44919-1-pstanner@redhat.com>
 <20240822134744.44919-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822134744.44919-3-pstanner@redhat.com>

On Thu, Aug 22, 2024 at 03:47:34PM +0200, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Port dfl-pci.c to the successor, pcim_iomap_region().
> 
> Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks.
