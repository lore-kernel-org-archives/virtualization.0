Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A33E3152
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018267; cv=none; b=DxQ4Dz5nMw1hrqp39+/ALIvIFMdLVsDrQrTc3FUqT+0jPbe1AbVxU8HFDuQC5W4xos9VrCATfPEZCmNfSekH37sbud2aKerFexETPCjsJcxcwDN4U1TzYvZyy8UAE2qJULgzTdDZmxnWhFA3lSh3NvsRDPphTwuSdOg3zqv1TwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018267; c=relaxed/simple;
	bh=t02JFYvt2q6C6vocZJa0Gxw0ReMXr+FUBEDBNnbVEUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pozbqvTON7I3xjoEmhxgigpavUhhH3w8d0NcPMp+OlNsD/CKaGRhMMIyHnJb2cJ95X3Im46eBzCTeiBUzIVUdNdD5+Z3XFcjJ3DuAKCptDocJrmeRUKztSTpKTvvPMm5uW1hCizHfMyQbyTix+UpQPhN4QXYwS4xj+/m1/9Z9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbhk2Fe+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbhk2Fe+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784018262; x=1815554262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t02JFYvt2q6C6vocZJa0Gxw0ReMXr+FUBEDBNnbVEUE=;
  b=lbhk2Fe+uke99LlBrscXrr8yHYE0EV4dNtEC8VllMFNb6jjZkkbm1TzO
   UVwjbCYVfznC7xZSqg3cjc3bbKR3c3HdPF6PmLxsjqdbpl/+OjUTZcxQ3
   aBaMQMzPNzlrXcaewhXABjTPqTr6fH2KcqFXzm3150QcGiepZoTMGz3xl
   Qt9DHQYE7CRjqjjHNnu8rPJrlmyWorbqkEJfuaJwWUNSXUgpqVIomrL4V
   LkhIr/4HmpqMbuaKiEqurWJ7VwJEr9znAmoy+ZPSzvrhBJ6Z8VAeLFU7G
   poHN7+W6t7/DVibXTQOMi/sU9vE38ughcQFXcm2z+DvKKc4xLlQjTQr8T
   Q==;
X-CSE-ConnectionGUID: 2+hvrWA7TLuQ4Yoate8GcQ==
X-CSE-MsgGUID: GnWjy8iyRxqqWyCtdstY2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="102061371"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="102061371"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:37:37 -0700
X-CSE-ConnectionGUID: QRyz5A+HS3+Xxr+IZ8qxiw==
X-CSE-MsgGUID: 9kRuPCg6RHKOO/4ZDHER5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="251848007"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:37:34 -0700
Date: Tue, 14 Jul 2026 11:37:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 20/20] gpio: Unify style of various *_device_id arrays
Message-ID: <alX1TNKpn_eU3a7f@ashevche-desk.local>
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
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


