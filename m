Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1539457
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171135; cv=none; b=V+lFEXq7noJNZhnh7y11QL8p/YyILT7Q/0OeYv1RGthqW17PwX30ktito1HnxYRtEtZPLf5Z7j6wawUzguzbdMVfFNa4I0Ol+VZxC+xXit4Gcx2x9BwvmaOIMIYfbfwLQyRnyaKXKMjelMZ691MbJ7Lx01FCnp0Efuj+0ZD7sj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171135; c=relaxed/simple;
	bh=Ha4KtTkxo2LtB5iAREJLY/pM9skq832IrCDpRKv09Wg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rr4h+qD4z/Wtl0GawueYBM7Sn2NdtfmOQdsHzSgkDN7fuAOUxVmQ3FurJ6d7gWzCDVd5kIzLU71nmEpB2A7Ey/zzjQXSx4WSBZvBqEVN5R0ojZbpxCyELxpbX9qlcBqhZ6NrtM8PZW/flXSkMa90+rMgoAt6KAbKwIvxh0SCrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kh3wov+1; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kh3wov+1"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C114606E0
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 02:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aw0hABqXIwio for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 02:12:12 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org EFE76605E6
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFE76605E6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kh3wov+1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFE76605E6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 02:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716171132; x=1747707132;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ha4KtTkxo2LtB5iAREJLY/pM9skq832IrCDpRKv09Wg=;
  b=kh3wov+1rvzN3BlJaDuygrFKYE5d5ZIcMa7o3v40fYDgteIKlMry0ACg
   z61vjBYuy+k40Ckrk/1G7r4y5yqG1Ey0yM2CS2AxblHLR+pd74gs2bEAL
   i2eaZD3LBygqbmzoecAALdFG4yZ3lrdNXx/teUS8a8Dpv1KZwRF7IKXgG
   3WrWllH3l1GhkstE8JEeGfUKnhylylxG3nH15T3+cydui2UIc2dxnGhmK
   mP0EVZ9EWsp8DwencwewJ72D4Ul0LmMvgUWB4pM1sRDl5V5RGWNFTIXx8
   amsy0ndOA5Sianv0EY4UPGXcDRftAqOdP4mUABsGo2W8BIsE9tNKubf4e
   A==;
X-CSE-ConnectionGUID: UUMmj01TSOOAVpermogTnw==
X-CSE-MsgGUID: PBh0ORaFTReeiFDsNh0ngA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12151800"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12151800"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 19:12:11 -0700
X-CSE-ConnectionGUID: cdKakuEwSomHxfTKKygSEw==
X-CSE-MsgGUID: GQDhQmlMQKmedbhhYr28Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32397584"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 19 May 2024 19:12:07 -0700
Message-ID: <bd08d2b0-f226-4b42-8d3b-099c46435aa2@linux.intel.com>
Date: Mon, 20 May 2024 10:10:16 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D582749AD8B619B11B688CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D582749AD8B619B11B688CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:43 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>> +
>> +int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
>> +				     struct iommufd_hw_pagetable *hwpt,
>> +				     struct iommufd_hw_pagetable *old)
>> +{
>> +	struct iommu_attach_handle *handle;
>> +	int ret;
>> +
>> +	if (hwpt->fault)
>> +		ret = iommufd_fault_iopf_enable(idev);
>> +	else
>> +		iommufd_fault_iopf_disable(idev);
>> +
>> +	ret = iommu_group_replace_domain(idev->igroup->group, hwpt-
>>> domain);
>> +	if (ret)
>> +		goto out_cleanup;
>> +
>> +	iommufd_auto_response_faults(old, idev);
>> +	handle = iommu_attach_handle_get(idev->igroup->group,
>> IOMMU_NO_PASID, 0);
>> +	handle->idev = idev;
> 
> why is auto response required in replace? new requests can come
> after the auto response anyway...
> 
> The user should prepare for faults delivered to the old or new hwpt
> in the transition window.

The current design of replace allows switching between one that is not
IOPF-capable and one that is. This implies that if we switch from an
IOPF-capable hwpt to a non-IOPF-capable one, the response queue needs to
be auto responded.

Best regards,
baolu
