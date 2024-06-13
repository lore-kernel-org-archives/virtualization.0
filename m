Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA3137C44
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261362; cv=none; b=vC9p751CsB53zjG7VRZsqtcdOQWdaoTbdSKch/6DldCICYB5S8lDEzpsGV+EzQke/GIxtuCuY8ts/mqxmSkLX1e8fS4au0izZWvDePoQe2BMS3HoQY/43ytQAl8Hiu65tOWUNm6LzSC0gsFLGTqNPjQxyo5eps3CQRUShEKxBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261362; c=relaxed/simple;
	bh=WBIDa8EW/dX05X0Pb8ExnAzcKRiIOjXdz3UGKRYDqMk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LRNda+IJ6y+DDl2+PByx604nmVrCegwRC+9FZV8xn6a1glPh1S7X+oCXFv7X403x99WkKQ1IX/83THcKPm5OuSb8Ft3b8FbLEZedlGJJZPMSTEZB9zApom8W3n/I+4P+zurR4yuM860WFEuINvyvXXe26Kd13xs2bN00XOFPZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBsWzl+K; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBsWzl+K"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BF0260B59
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:49:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crTYf5FI-sox for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 06:49:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5D86160684
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D86160684
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZBsWzl+K
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D86160684
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718261360; x=1749797360;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WBIDa8EW/dX05X0Pb8ExnAzcKRiIOjXdz3UGKRYDqMk=;
  b=ZBsWzl+Kpw6WuJ0/5VCAkQcZV6+kUhHZ7QhSbVoIQglPNPb9LBR0yOc6
   CrtiAvBzDoE+daSQahahms+QM2J2J54yHIZqt2lqEM3gn5ocwvqNASCW/
   I75D/3lR3VK7rx3Lak0YX9P79mZP+ZklyGXa7iW7cn5oyE4vcVN+jUF57
   tyHXEIEBXZ6xYyzi3auee5XTcRBaQabYBHiumBO+JsmRIsbxAszsl+hmV
   yxoUjOtBCTPo868Exa8MlIH8bKid/n+XHy2HIb6ds/3xHi6f/99LNe+oW
   GwkYJSpK7yaC7U0jXludCCNegnnAmgQFTC9Zm8QMen3kiYWyp9KwuH2cI
   A==;
X-CSE-ConnectionGUID: 0dSWVt/XRMa8GKMWPKuO1Q==
X-CSE-MsgGUID: REJis9t0Q2mcnAE0/I2i9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25698816"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25698816"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:49:15 -0700
X-CSE-ConnectionGUID: Mle86pKBToOVONWcQvcFmA==
X-CSE-MsgGUID: /uYyYCSzT6qjB04x0FYQaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44944503"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 12 Jun 2024 23:49:12 -0700
Message-ID: <4ba5a1a6-80f2-46eb-84f7-921b9ac27efc@linux.intel.com>
Date: Thu, 13 Jun 2024 14:46:53 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/10] IOMMUFD: Deliver IO page faults to user space
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240612135426.GA2151677@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612135426.GA2151677@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:54 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:07PM +0800, Lu Baolu wrote:
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework. One feasible use case is the
>> nested translation. Nested translation is a hardware feature that
>> supports two-stage translation tables for IOMMU. The second-stage
>> translation table is managed by the host VMM, while the first-stage
>> translation table is owned by user space. This allows user space to
>> control the IOMMU mappings for its devices.
> This looks pretty close, will you post a v7 with the minor changes?

Yes. Sure.

Best regards,
baolu
