Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848218C900
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119075; cv=none; b=mnI1HLpme+evff1W1bFapJdTGiVQVAgLKmfN72FOJbujDgjfV6w4FkvLdhfmw81bsbmV2xwMfonsw2ylGT1ECPJXKZOfqbQ9QnlXMISa+yc2PVy7dlCntWHVp8NT6FLFNy5tPkX8Mq60kPe8oND/RUJ6iblYr3bEA/2lpp/qlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119075; c=relaxed/simple;
	bh=uBbGQMddf7yPjAGm8/+2FG7H+rzLcr5LybqGlSJ0B+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGOGSg6+3oew3yj8+W80HknFrUZp54DXoP27w7dekloIQ9tuf6xNmiLqOOo53GlJEJUmMs5a1YwlbUKDq6zguheMlNb3nX/9PcnV2K2ou46i/D0Vy7RW3q6x2W5T1CvzVK8ID2AlJLh2Emx2bRMMDCKqDXdWSkMgIWNmlq6cBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSgoy2Fa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSgoy2Fa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723119074; x=1754655074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBbGQMddf7yPjAGm8/+2FG7H+rzLcr5LybqGlSJ0B+I=;
  b=nSgoy2FasVxBVSefhN5XMEhoJpWdpIRh3PR3WEoiHd+9vvLZtDKvrjZM
   TTgx3sLJAmAjH8QO/DT7vuPI3IaA4oNz4kCQVsfqe925CnMWI1P+N3xjA
   wqCq8V/CErMfqHDZpv/3n8ZnYho7a66HYSFrbjS9MWvZ+/5Jp0xg6JP6b
   YtN52qTTL0/1p+eigRPqPJn4ZkV757nr3w05HivR0FH9ag1qahgwNcWOU
   LQZXgLpNe/DGhfnRV9LKwJpeOFqx4T8Pf1HQXZEXxqBi/cVym6EG86XjL
   Es+oojHaZr/ZIMFLGRUdno8Plom3geuQzI5E+g6jAhdY/Jvcp9J8huxDi
   w==;
X-CSE-ConnectionGUID: 7WDo+MJrRCyT+X8pWecCzw==
X-CSE-MsgGUID: fmYgyRmESqyWmLFi3/XtJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="25031696"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="25031696"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:11:13 -0700
X-CSE-ConnectionGUID: QW06WbOUTSWyvFyEGw1uKA==
X-CSE-MsgGUID: y4r8n4hSQe+uN/lCHBEWVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57159705"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 08 Aug 2024 05:11:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 073CA4C7; Thu, 08 Aug 2024 15:11:09 +0300 (EEST)
Date: Thu, 8 Aug 2024 15:11:09 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>, 
	Hongyu Ning <hongyu.ning@linux.intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <o7duejn6zoua2zu6ff5x4nn43bdbqllsmhqtc2i3dkqme5pmig@4nsfqi6wsjsd>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <ZrSuBlWkE-USicQw@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSuBlWkE-USicQw@nanopsycho.orion>

On Thu, Aug 08, 2024 at 01:37:42PM +0200, Jiri Pirko wrote:
> Thu, Aug 08, 2024 at 09:51:41AM CEST, kirill.shutemov@linux.intel.com wrote:
> >Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> >accesses during the hang.
> >
> >	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> >	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> >	...
> >
> >It was traced down to virtio-console. Kexec works fine if virtio-console
> >is not in use.
> >
> >Looks like virtio-console continues to write to the MMIO even after
> >underlying virtio-pci device is removed.
> >
> >The problem can be mitigated by removing all virtio devices on virtio
> >bus shutdown.
> >
> >Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
> 
> Could you provide a "Fixes:" tag pointing to the commit that introduced
> the bug?

I am not sure if it is a regression. Maybe it was there forever.

Hongyu, could you please check with bisect if it is possible to point to a
specific commit?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
