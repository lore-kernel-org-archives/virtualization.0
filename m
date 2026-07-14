Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0E3F5BF1
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016782; cv=none; b=ORTuajJ/ZFAG/WvI80PgnVmFb8fjTYj/T6zZW6B3X0LPAqPIbu1PpEZ9fAili5qbsYlAh6hwHMEV7QOCMmwlZQV6MHwYwsfICo9ukM1qjnr3p1W01aYSLJfI8PZJUOTEyLDDjx1M8rrQQ6YzV5R30p4DiKyYc5rUjD7zg9qmEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016782; c=relaxed/simple;
	bh=KYCEkPEjMD+eAmCIEVEDBEseQ70VdOm4bme0Qa3NvLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=favk2C2v9gQpsqtSHbl9aDlxjdR/EYKHFMIDv+5s6+ZiyX00qRL6g6ImOuNSx0GwSIWkiuJAvNt8FMelT7Mo4zu6dof45Z+T4sJA2A7BV/C1d/ymT0zh6zu2T2wFAciDIP10XJCgqwuWRqcTsNOSownMBOUGE86P2i64QR9dGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwDiIVWa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwDiIVWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784016780; x=1815552780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KYCEkPEjMD+eAmCIEVEDBEseQ70VdOm4bme0Qa3NvLM=;
  b=gwDiIVWaz9uBInb9xk8rpcklaVQzTnVwB/SmVSQJzxgmkWeC81Sy+hXN
   BYTpKXXFrE3ivMrA88uZzRpozxV3qc7f3bO/fWeJe7DAJ8Xmp45CVqeYO
   KCFzY5sDbEO8sAhhF2rQT+CQE6WkZdY9MzMGmmr4cVa34JGsoqy8DnKV2
   I6pGiipqx8NUm/hivcvcm/jDHtTyK8C+o9pSwk124ihSwfcLGUls6RONy
   /VZPCWtARmefQG6aQGzLqY7gIcMgxU21vIQTSt0V/ISN2sPoqrSaEdyW9
   7rl4ADYkT3ERURgctzii1HhymkIMBrS5a0dbIecqqjJx068/lTP3cTlrW
   Q==;
X-CSE-ConnectionGUID: 9vIvYg2cRamooav0Jz3tqw==
X-CSE-MsgGUID: 8IvcllBYQ+erO6yCJu3mag==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84513159"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84513159"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:13:00 -0700
X-CSE-ConnectionGUID: JekA+nGISxSozST9p3Wy1Q==
X-CSE-MsgGUID: arA99Ow/QV6BiW3ChyyflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="280214627"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:12:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 38A6C11F8D1;
	Tue, 14 Jul 2026 11:12:56 +0300 (EEST)
Date: Tue, 14 Jul 2026 11:12:56 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 20/20] gpio: Unify style of various *_device_id arrays
Message-ID: <alXviNrPTBmwgYnN@kekkonen.localdomain>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
 <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>

On Tue, Jul 14, 2026 at 09:24:21AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Update the various *_device_id arrays to conform to the most used and
> generally recommended coding style. That is:
> 
>  - no comma after the list terminator;
>  - a comma after an initializer if (and only if) the closing } is not
>    directly following;
>  - no explicit zeros in the list terminator;
>  - a space after an opening { and before a closing }, a single space in
>    the list terminator;
> 
> Adapt the few offenders accordingly.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
>  drivers/gpio/gpio-ljca.c           | 2 +-

For gpio-ljca:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
