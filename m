Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59141C70;
	Fri, 22 Mar 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126825; cv=none; b=Sx5vDYusApsb6uC1u5GVtA0vUBL9+ujc5hQ+6xpRHGZcb/HsspCNWF60KLYSVQ6Y8YJVH7x9Ez/dkkn3rTcFZTgdd610CmAk6UvLzOyAZVGmSe0piXMpj3TtHM0l6gHJZkhQjJujdVykZiQxdjOX4AvO1+vNO30fKnEfbbWokog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126825; c=relaxed/simple;
	bh=eijYIPLIRnSAkyrL//Qucwww06P+qCR4wOCt19HryXE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znjpi8UD18sVLby9N6kmWM8UAW8yzhWZhQbVvqGk+YYWUjQhRdf8ex8UgOW1VZIZMMLSSBYoR53JhO4djET04tzCYSKWCwJZP4/RDeZi/J4Vb+jiD9k3mp0Ad5KBYYkSh6Oeext2qSjtR6h6bkSeDhNbJMyq8EmQaIq/vedJObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WoQ1kxcV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WoQ1kxcV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711126823; x=1742662823;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=eijYIPLIRnSAkyrL//Qucwww06P+qCR4wOCt19HryXE=;
  b=WoQ1kxcVR7L9KXWTzZ6Io7+6bra9+l12d6RZjGdaPg8zezMmtkU03cpj
   SXu+X9QETrhk9xTNymYRlAML4YDZq/Zdlwee9fT0/2hoVkOn7JlfpjnaK
   EA6BV6XFLPCxpYwsIMIIldPu79aaJVfc97dTO+PL7Xa2PqZ7F7muWcbKB
   4wCtuH1tDA3HdZG5lcsM3JQqrZVKp0Gik9KuBCB4ROezjQ1T8kzi2fCpZ
   p70F+YH7g2jt6/JB53PEpVpHbXbnnRKYPglKpUirRAKbitJ4bG22ACSKq
   3zWRoIAwNZJ0PLxkXK7By2VXzdwXlX/nwQWjW85OpxmYAwvJJWmaOj1VZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="17619592"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="17619592"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="914749126"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="914749126"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:00:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rniFb-0000000FDED-2Q86;
	Fri, 22 Mar 2024 19:00:15 +0200
Date: Fri, 22 Mar 2024 19:00:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	imx@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 64/64] i2c: reword i2c_algorithm in drivers according to
 newest specification
Message-ID: <Zf25H-LlAFmfuyYT@smile.fi.intel.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
 <20240322132619.6389-65-wsa+renesas@sang-engineering.com>
 <Zf2tSLJzujUHbJjp@smile.fi.intel.com>
 <Zf22dmwBpN7Ctk3v@shikoro>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf22dmwBpN7Ctk3v@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 22, 2024 at 05:48:54PM +0100, Wolfram Sang wrote:
> 
> > >  static const struct i2c_algorithm at91_twi_algorithm = {
> > > -	.master_xfer	= at91_twi_xfer,
> > > +	.xfer	= at91_twi_xfer,
> > 
> > Seems you made this by a script, can you check the indentations afterwards?
> 
> Yes, I noticed as well. But other (not converted) drivers have issues
> there as well, so this will be a seperate patch.

The problem is that you add to a technical debt. We don't want that.
If you have not introduced a new indentation issue, it obviously is
not needed to be fixed in a separate patch. So, please consider this.

-- 
With Best Regards,
Andy Shevchenko


