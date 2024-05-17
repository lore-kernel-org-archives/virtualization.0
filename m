Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34DBA39
	for <virtualization@lists.linux.dev>; Fri, 17 May 2024 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715919804; cv=none; b=r+VNwO+tt+KWvvozft3wtyBGssrjT6uRjp2+XsAj3X4RfBoGagoJNYOOP6qUHaFXhCXkINjFM36lrUu1zoPht4W/aHIxtZ4RW5msL3CcqZpK9iDdwFU/OD/2ihq/kzqAOiR/ndQO6Tw1riMsJN0n1oVFabpKN3j//oyctaEh5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715919804; c=relaxed/simple;
	bh=B8lPeYICjRVlFzy8ZWGt+5D5Z8oq14Gpu1cxH4cO8qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuDZhh4IP3yY8QPrs8QzbzicLr6b+NnhdplvLcroolnLJhKvbGelzmlH0aaXNQommHsIhv1k5fYFNEKOQ1jGvgruvFif2bcKNSqdsz8JJOJ3jdQ36fUYqHQsywUYxBQe2ZR2ZfdixIgn6C5mu6I90ud1c+g/XOUguzmw1oYsQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0qOCiaX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0qOCiaX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715919803; x=1747455803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B8lPeYICjRVlFzy8ZWGt+5D5Z8oq14Gpu1cxH4cO8qI=;
  b=i0qOCiaXST3HYE89DowYYDirC65RAIKrVKfdnhb37eJ8s+LFJQPiSgWk
   YGswDPia2dd/b/vMkJgJ5H8NxGqO80tB03i4TFGhqAe8BuCFdslUVay/I
   Hjr24Brx3+PipE7cYe43LfqvwaIAqOLZu6ixbW/iA3bZETd38Vvlth4Cr
   rV0CdKOw43dAOvjc/zWJEy4Ln2rC/zDcEvnz6y3+EbV3rsnPDqn10aTlE
   HmtkwrtAaQTvj7aWTm5iVXuDP4gvu5mcR6qQSbV/WcXJautTlHt5YgxPt
   a66oxfts54gji+uOn7HNcpeJVN6Zyrw9v8WV82W43jl6daB/g5SgWi85X
   A==;
X-CSE-ConnectionGUID: UfxP2RxmRR6olXwhure9Fw==
X-CSE-MsgGUID: l1WcFTZnRkC7MX980jSItA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15027692"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="15027692"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 21:22:48 -0700
X-CSE-ConnectionGUID: pmrS0T03RKuUpfxqDl5fLg==
X-CSE-MsgGUID: hlG9Ozs3S+C14DQdvJESwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="36104574"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.125.245.197]) ([10.125.245.197])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 21:22:47 -0700
Message-ID: <9542fe5a-893f-4e93-91fb-6e2007c50d7b@intel.com>
Date: Fri, 17 May 2024 12:22:44 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] MAINTAINERS: Change lingshan's email to kernel.org
To: jasowang@redhat.com, mst@redhat.com
Cc: lingshan.zhu@kernel.org, virtualization@lists.linux.dev
References: <20240514165125.74802-1-lingshan.zhu@intel.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240514165125.74802-1-lingshan.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,

My transition period ends today, before I get a new email account,
I will use this lingshan.zhu@kernel.org email address(cc-ed) for patch 
works and communication,
this email address represents me.

Thanks
Zhu Lingshan

On 5/15/2024 12:51 AM, Zhu Lingshan wrote:
> This commit changes lingshan's email from intel.com
> to kernel.org.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d75527f7bb0d..501b81b61b6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10466,7 +10466,7 @@ F:	net/ieee802154/
>   F:	net/mac802154/
>   
>   Intel VIRTIO DATA PATH ACCELERATOR
> -M:	Zhu Lingshan <lingshan.zhu@intel.com>
> +M:	Zhu Lingshan <lingshan.zhu@kernel.org>
>   L:	virtualization@lists.linux.dev
>   S:	Supported
>   F:	drivers/vdpa/ifcvf/

