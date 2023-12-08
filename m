Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF256ADF
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdMxk/Tw"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3079A836C5
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 05:52:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3079A836C5
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VdMxk/Tw
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlBtBDQVBlNI
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 05:52:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 72DAC83168
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 05:52:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72DAC83168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702014743; x=1733550743;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2CgvhfqEe7oPS8iAqYFe0ARHhvX5HhGtxuEy7yZmrms=;
  b=VdMxk/TwhgCrLCGXDbGtOt77wiRFDjYFDMCwLJnPaEBMssP4v2/w3kqi
   G0Q2lqPpU09pU9kc2DlGoljjzcgN6kiBUJyh3bfThEhvGF65u0W8J1Pc9
   8oEU8tUomhtgIQ8WkhTtkEZv+z2g4WanQheQtoKUErS0UpTwdrjNgjKIY
   Gnq9NejZHXzJGwXIz6Tx+lIgjSueMJGtEG5QTQU6j7KTAknk+GmfCakX2
   XB6oaua3uXDewkkziu6XV0CmOA/QsW9jjKJniPZCtRKY44ZO4UY9nbG8w
   tnmgRxt9b/mGZ0abIWAtPcVcUvg9CUPnSfBsglVX49orGb60VkzzLUtTZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="7685680"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="7685680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="838016425"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="838016425"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2023 21:52:12 -0800
Message-ID: <c72184d8-693d-43ce-aed9-00a8fc684137@linux.intel.com>
Date: Fri, 8 Dec 2023 13:47:35 +0800
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommufd: Deliver fault messages to user space
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-5-baolu.lu@linux.intel.com>
 <CGME20231207163412eucas1p2fa912b4923031804c27c764e5c8d67e7@eucas1p2.samsung.com>
 <20231207163410.ap3w4faii6wkgwed@localhost>
 <20231207171742.GU1489931@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231207171742.GU1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 1:17 AM, Jason Gunthorpe wrote:
> On Thu, Dec 07, 2023 at 05:34:10PM +0100, Joel Granados wrote:
>>> @@ -58,6 +255,8 @@ static void hw_pagetable_fault_free(struct hw_pgtable_fault *fault)
>>>   	WARN_ON(!list_empty(&fault->deliver));
>>>   	WARN_ON(!list_empty(&fault->response));
>>>   
>>> +	fput(fault->fault_file);
>>> +	put_unused_fd(fault->fault_fd);
>> I have resolved this in a naive way by just not calling the
>> put_unused_fd function.
> That is correct.
> 
> put_unused_fd() should only be called on error paths prior to the
> syscall return.
> 
> The design of a FD must follow this pattern
> 
>   syscall():
>     fdno = get_unused_fd_flags(O_CLOEXEC);
>     filep = [..]
>   
>     // syscall MUST succeed after this statement:
>     fd_install(fdno, filep);
>     return 0;
> 
>    err:
>      put_unused_fd(fdno)
>      return -ERRNO

Yes. Agreed.

> 
> Also the refcounting looks a little strange, the filep reference is
> consumed by fd_install, so what is that fput pairing with in fault_free?

fput() pairs with get_unused_fd_flags()? fd_install() does not seem to
increase any reference.

Best regards,
baolu
