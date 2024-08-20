Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA218CC02
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150114; cv=none; b=PXvV3jJ3YN0mnXJMaOIUg6dW5X9tkJMqoUMtmHgcgOtqpBmWqCSKFakiHAIRo9C0Nibu11S0jxw7yIUOQmFxRpe0AUxNRW4AFgQGiMEzk2zwPp9Zdg51qPLcCVFyLUZxdzmcEUnpFWp7hFJ8k8Ow2ztrvrK9ki4oj9apl9Qej00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150114; c=relaxed/simple;
	bh=kjiriu1vVPG9LFUBsJpUYaqmI0gKbM2aHKLUbsf8NlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwveSPRLwLnlaTnco75W6SFzKOd3roQyrJjNMee86hGIQ8irwvqvuCwDdFb/wlA2Zs6+EnPetBScHdsYWXqpPf6KIynnHRVMyWUw7afsoOtLydnyJQSUMpyFBa03RAk4gUPXHwmhwzWbIGNGAUggI34LekrWhrqLRbvgv3I/0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: rTsWcKHaRWGeGgPrtbWKyg==
X-CSE-MsgGUID: Tw0vylOvTuK4sM2bpc7swg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33102939"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="33102939"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:35:13 -0700
X-CSE-ConnectionGUID: jPFRCu2HTpiBmNIFCKNJFw==
X-CSE-MsgGUID: pNVVVqHdTHK/wYhkKlAIQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60745183"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:35:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sgMCb-0000000HGUy-3xzl;
	Tue, 20 Aug 2024 13:35:01 +0300
Date: Tue, 20 Aug 2024 13:35:01 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	onathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
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
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
Message-ID: <ZsRxVUmTpT5nHncc@smile.fi.intel.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
 <20240819165148.58201-10-pstanner@redhat.com>
 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
 <ZsOQPbVGQFtUYSww@smile.fi.intel.com>
 <419e91cb2b698a450497dfc1fb86f2c46eb7d8fb.camel@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <419e91cb2b698a450497dfc1fb86f2c46eb7d8fb.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 10:13:40AM +0200, Philipp Stanner wrote:
> On Mon, 2024-08-19 at 21:34 +0300, Andy Shevchenko wrote:
> > On Mon, Aug 19, 2024 at 08:19:28PM +0200, Christophe JAILLET wrote:
> > > Le 19/08/2024 à 18:51, Philipp Stanner a écrit :

...

> > > Unrelated to the patch, but is is safe to have 'name' be on the
> > > stack?
> > > 
> > > pcim_iomap_region()
> > > --> __pcim_request_region()
> > > --> __pcim_request_region_range()
> > > --> request_region() or __request_mem_region()
> > > --> __request_region()
> > > --> __request_region_locked()
> > > --> res->name = name;
> > > 
> > > So an address on the stack ends in the 'name' field of a "struct
> > > resource".
> > > 
> > > According to a few grep, it looks really unusual.
> > > 
> > > I don't know if it is used, but it looks strange to me.
> > 
> > It might be used when printing /proc/iomem, but I don't remember by
> > heart.
> > 
> > > If it is an issue, it was apparently already there before this
> > > patch.
> > 
> > This series seems to reveal a lot of issues with the probe/remove in
> > many
> > drivers. I think it's better to make fixes of them before this series
> > for
> > the sake of easier backporting.
> 
> Just so we're in sync:
> I think the only real bug here so far is the one found by Christophe.
> 
> The usages of pci_disable_device(), pcim_iounmap_regions() and the like
> in remove() and error unwind paths are not elegant and make devres kind
> of useless – but they are not bugs. So I wouldn't backport them.

Agree.

> > If here is a problem, the devm_kasprintf() should be used.

-- 
With Best Regards,
Andy Shevchenko


