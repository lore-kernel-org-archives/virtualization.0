Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CBE29BD80
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Sep 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577367; cv=none; b=Tz3X2iYVHphLQPTl0+2QX0x8B8a+Fjt6BD/dRAOQFww19/3p3wrWYtHuQmnQ8RDzEy1Nrv6dH6s53xpjHOBiayYNozis7l0UX4p40cU2tdbb9IaJTkH41+fDil5ELMQphR0Mxj6wzWdu2ieEH41j1B1YDiXYBRFehRjdVvtgT3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577367; c=relaxed/simple;
	bh=GVFo1kkBKEsPHJOvbjim7jezaF6LjLLFPCd7At02oz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJR6DAgtrh9OLJvRJA3oySa5AvcsXpOA8Ft0mDrPl7pXanCQbyiG0OPL/fbvFUGWGz9Z2cwgng/5rYUF1MMyHGU1t3CMpGi/i9n+TX7LfEaiUuJEfKLYL2jXYybRtr7IxxEQ8OTdhfKbtwD4MoTooyWlQpRXcdqjZYGLOwGEfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LroFMg2a; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LroFMg2a"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64D298432E
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Sep 2025 07:56:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fRv70Wtr3AZ for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Sep 2025 07:56:02 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 11 Sep 2025 07:56:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 11C4F8443C
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11C4F8443C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LroFMg2a
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=andriy.shevchenko@intel.com; receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 11C4F8443C
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Sep 2025 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757577362; x=1789113362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GVFo1kkBKEsPHJOvbjim7jezaF6LjLLFPCd7At02oz8=;
  b=LroFMg2aLy45rXvVeeg4PdOpS3oj/aiCpJU+gk+FS6+zvNsEVSfnHluK
   p4Y8qO6bMtkN+6jQCOGfahrcYNn6vzZ+yotEVZ5K1LCP8CP7CKpBi5qJa
   z6PTPUrDXdMCsm6BBjnAhaaUbH4KJ1KkNpm9Gb4wLpXvM4H1kY5qRJybK
   Upc6WgzLtQKO0ut6kbaCr8k/sAYcbpaer98QEQXCYATCvWyAYl8w5lBp/
   Bf87z7A3jjzgvI1f32at34XTFdynic4o78zuN75AxBuAYJZMUBUnFvAyn
   m8opCUcOChP9NuIs3pREDWVwFv3U9y+xrllc8RNg4JcxSMmbG+iOYnJCv
   g==;
X-CSE-ConnectionGUID: yFaDMBQERy69VLSg/7xMYg==
X-CSE-MsgGUID: PXFe70mVT/O/B8YFiE0fWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59974625"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="59974625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:48:53 -0700
X-CSE-ConnectionGUID: J9Nv+4YtTNSxO55M48ZoVQ==
X-CSE-MsgGUID: 9MixVzbQQjW7yZnMLMRJYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="204612371"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 00:48:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uwc2x-000000022PY-3Jay;
	Thu, 11 Sep 2025 10:48:47 +0300
Date: Thu, 11 Sep 2025 10:48:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: harald.mommer@oss.qualcomm.com, quic_msavaliy@quicinc.com,
	broonie@kernel.org, virtio-dev@lists.linux.dev,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
Message-ID: <aMJ-32RkzRuUQ_CP@smile.fi.intel.com>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
 <5dcabe90-c25b-4af5-b51f-5cda7113b5f4@quicinc.com>
 <aLgYLS6Lr5O2cIhK@smile.fi.intel.com>
 <b9e9b4e5-7004-471b-a067-b6bacda2a0ca@quicinc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9e9b4e5-7004-471b-a067-b6bacda2a0ca@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 10, 2025 at 11:51:03AM +0800, Haixu Cui wrote:
> On 9/3/2025 6:27 PM, Andy Shevchenko wrote:
> > On Wed, Sep 03, 2025 at 05:04:46PM +0800, Haixu Cui wrote:
> > > On 9/1/2025 8:07 PM, Andy Shevchenko wrote:
> > > > On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
> > > > > This is the virtio SPI Linux kernel driver.

...

> > > > > +#include <linux/completion.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/spi/spi.h>
> > > > > +#include <linux/stddef.h>
> > > > 
> > > > A lot of headers are still missing. See below.
> > > 
> > > This driver compiles successfully, and I believe all required definitions
> > > are resolved through indirect inclusion. For example, since I included
> > > virtio.h, there is no need to explicitly include device.h, scatterlist.h or
> > > types.h.
> > > 
> > > I avoided redundant #includes to keep the code clean and minimal.
> > > 
> > > If there are any essential headers I’ve overlooked, please feel free to
> > > highlight them—I’ll gladly include them in the next revision.
> > 
> > The rationale is described on https://include-what-you-use.org/.
> 
> Thanks for your feedback and for pointing me to the iwyu guidelines.
> 
> I've experimented with the iwyu tool, and while for spi-virtio.c I noticed
> that it recommends header that is not directly to the code - such as
> vdso/cache.h - and occasionally suggests re-include header like
> linux/spi/spi.h that is already present.

> iwyu is a power tool expecially in application-level development for C++
> projects where header dependencies are more straightforward. However it
> seems iwyu may not yet be fully suited for analyzing Linux kernel due to its
> complexity and conditional inclusions.

I was not talking about the tool, yes, this tool is not ready for Linux kernel.
Jonathan Cameron played with it to make it useful for the Linux kernel project,
but it seems the work is stalled.

> Additionally, I’ve verified that the driver compiles successfully with both
> gcc and clang, which indicates that all required definitions are either
> directly or indirectly resolved.

The IWYU principle is against the includes that indirectly resolve types and
APIs. The problem that some headers are included in others and that relation
is guaranteed, but we do not have an official list of the guarantees, so this
is a tribal knowledge.

Basically the developer should know a bit more about the Linux kernel header
organisation to fulfill IWYU. And this is currently problematic.

> I appreciate your guidance and will continue to refine the patch with
> clarity and maintainability in mind.

-- 
With Best Regards,
Andy Shevchenko


