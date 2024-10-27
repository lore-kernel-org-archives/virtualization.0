Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F84175D25
	for <virtualization@lists.linux-foundation.org>; Sun, 27 Oct 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039173; cv=none; b=UnQ3Gk6GaYPo/5rWOfB+ciAXsiszPuPfPMDC4qxRUxL79aIROJNRqG2AcyqeQ9RwKHETfIkMauPd45p3uFqOobbjdmfyyBZhDmri27uB58AVjgCU14BajZebuvhSIMBcSgwlQOKTLHvllE6MpTqe89YYghIb44EKbEX4CI1qtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039173; c=relaxed/simple;
	bh=F3T/AAYdoHuTTV/VVVzRbtlg/svgZJGhDsfrjIIQP8E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TccCcm1KvCylNqtCzzXVVjVRviEewQV647z53IM1djG+wnkUxRST4aDclus3LqbIronAtNtTPqhFOU5lA7E09+7SMTiTpxpHNf12TKF0lYnPPkrlUbjPbxcHrDeUEhLvk/DoX/LSmADwGfTBgkrewe5MvH+3FpXCAdGsS1/4QFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVZjIlPE; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVZjIlPE"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 096D080DC5
	for <virtualization@lists.linux-foundation.org>; Sun, 27 Oct 2024 14:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.99
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xnTPcF0UVT11 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Oct 2024 14:26:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E799680BDB
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E799680BDB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JVZjIlPE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E799680BDB
	for <virtualization@lists.linux-foundation.org>; Sun, 27 Oct 2024 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730039170; x=1761575170;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F3T/AAYdoHuTTV/VVVzRbtlg/svgZJGhDsfrjIIQP8E=;
  b=JVZjIlPE5ToezgzJfQ0twZmqY21PnKnfWGqgDsVrxMiwpvYTtGYYRwUh
   P5R1Q3H6KLZHz13NDCUtW0+K9olaoZUzAtuVtSaKJt4MPPad6DGsAkXN8
   9a4TcUPX1l+tp8wa0yjVZ2r/E7J4OETj7wmRw/ag9Guwb0XrTQbkjT/Wj
   qPxmyxJuKkgVAhm4F0XZCeL150QRKhLBzCM3qtE38PCnWx7lOMPSoGKaj
   UVFG6L9m6qFU23J8+AsBazZ+fa4FS7FmuipGogGTWqnnGyR4prNeLp+hS
   6yppAWxTvOLyOGST/iJ50zKsyGeUWx5J2mqnwOsTeTUsA025RWJNz9r5U
   g==;
X-CSE-ConnectionGUID: ZQfpgscrThu/sx0RS7qphQ==
X-CSE-MsgGUID: CXELwFA4RvmkfPbSTkoOdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="41019067"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="41019067"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 07:26:08 -0700
X-CSE-ConnectionGUID: DfJI0M8vRpu4hdIaqKiwRQ==
X-CSE-MsgGUID: 8Jp4mR4jSKighrximlALbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="81002937"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 07:26:05 -0700
Message-ID: <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
Date: Sun, 27 Oct 2024 22:26:03 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca>
 <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
 <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
 <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 22:12, Zhangfei Gao wrote:
> On Fri, 18 Oct 2024 at 10:45, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
>> Hi, Baolu
>>
>> On Fri, 18 Oct 2024 at 09:58, Baolu Lu<baolu.lu@linux.intel.com> wrote:
>>> On 2024/10/17 21:08, Jason Gunthorpe wrote:
>>>> On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
>>>>
>>>>> Yes, you are right
>>>>>    I am using SRIOV vf and stall feature, so is_virtfn == true
>>>>>
>>>>> Our ACC devices are fake pci endpoint devices which supports stall,
>>>>> And they also supports sriov
>>>>>
>>>>> So I have to ignore the limitation.
>>>> I see, so that is more complicated.
>>>>
>>>> Lu, what do you think about also checking if the PCI function has PRI
>>>> ? If not PRI assume the fault is special and doesn't follow PRI rules?
>>>>
>>>> Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
>>>> fault?
>>> This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
>>> a shared resource and current iommu subsystem is not ready to support
>>> enabling/disabling PRI on a VF without any impact on others.
>>>
>>> In my understanding, it's fine to remove this limitation from the use
>>> case of non-PRI on SRIOV VFs. Perhaps something like below?
>>>
>> #include <linux/pci-ats.h>
>>>          if (dev_is_pci(dev)) {
>>>                  struct pci_dev *pdev = to_pci_dev(dev);
>>>                  if (pdev->is_virtfn && pci_pri_supported(pdev))
>>>                          return -EINVAL;
>>>          }
>> Yes, this works on our platform.
> Will you send this patch?
> 
> Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>

Can you please make this change a formal patch by yourself? As I don't
have hardware in hand, I'm not confident to accurately describe the
requirement or verify the new version during the upstream process.

Thanks,
baolu
