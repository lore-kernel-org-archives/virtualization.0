Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E513D0BE
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930710; cv=none; b=hLgUMVRqZ5jo3mbyX1dIZEUZ+x2xniWNXF6SHeZAAi18OWHqVhobxC8ERL/E40Ptz/gLrO7GKnuwwEy2zjFOqbyj4Hmu56bI1Y1QRCI+PK9C6nZlLemP328n1MPkIk6DXR2P3EnK4XgUDyAC+23cTK4RI+lRJXtzL7vXzqhdw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930710; c=relaxed/simple;
	bh=eL+dQm//QMGuxQgfai1L6IO6BlaVJUf9VPWEH5ugn+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=of/z9SGkDJSVvHrW45qjr9zhUdCUCdM2Z83CmlM5gc2/g0BCm6q31CNFt9QWflp25gW5bty43wH9bE+DtOWaHX4WN8i9pSMoclyDCyPRwckRttGT3UiGBhW+dw/vAsH6vwZ1VU9Ixa/avSFXZPRdGsHJR/i68yjSGFz58EuewCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnAzQSt5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnAzQSt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710930708; x=1742466708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eL+dQm//QMGuxQgfai1L6IO6BlaVJUf9VPWEH5ugn+g=;
  b=SnAzQSt5UE9mflWzCcInN+pc+KG+PlRJwmU9Y+DaGfMzTvV6Env+Jsee
   c2vUX78z2O5tkbuXDPmmycXpy9+IBLspvIFt3HAUy0mboXU0RqGej0rF+
   WVDYCpLrTAhusr80x2xQa/TaKMfLE8BZ4mFgn3+GhLyyKl9awv+XyY51V
   csyMPtsgpG5UA6qaxM6WyYpcNJQGCD1dC/r12524XoOzB8icTNXhQI41H
   5puCmsj7qNu5pWPvStH6M4o0t/yAv6jE4OjcK7JvpEa98Pl6WnPEOabdj
   yb2NspOPKYlIeVZPW39IW/dFtG4nLzqob3HT5HpwzXc+UOHiHW7sQr2YB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5683061"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5683061"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:31:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="51560166"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.224.9]) ([10.124.224.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 03:31:46 -0700
Message-ID: <4d87dc97-9ae6-4a23-8fff-c9f688045105@intel.com>
Date: Wed, 20 Mar 2024 18:31:43 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] vDPA: allow userspace query virito-block device
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <ktoczf6fo4ta54lsrliawcdhjuy65kedfnrqdx7w7qlvybje3n@cbb6e4upeu7t>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <ktoczf6fo4ta54lsrliawcdhjuy65kedfnrqdx7w7qlvybje3n@cbb6e4upeu7t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/20/2024 12:49 AM, Stefano Garzarella wrote:
> On Mon, Feb 19, 2024 at 02:55:56AM +0800, Zhu Lingshan wrote:
>> This series allows the user space applications query vDPA virtio-block
>> device inforamtion.
>>
>> testing on vdpa_sim_blk, iproute2 output:
>> sudo ./vdpa/vdpa dev config show -jp vdpa_blk0
>> {
>>    "config": {
>>        "vdpa_blk0": {
>>            "capacity": 262144,
>>            "segment size": 4096,
>>            "block size": 512,
>>            "max segments in a request": 32,
>>            "num of queues": 1,
>>            "logical blocks per physical block (log2)": 0,
>>            "offset of first aligned logical block": 0,
>>            "minimum io size": 1,
>>            "optimal io size": 1,
>>            "maximum discard sectors for a segment": 4294967295,
>>            "max discard segments in a command": 1,
>>            "discard sector alignment": 512,
>>            "max write zeros sectors in a segment": 4294967295,
>>            "max write zero segments": 1,
>>            "read only": false,
>>            "flush command support": true
>>        }
>>    }
>> }
>>
>> Please help review
>
> Thanks for this series, and sorry for the deleay.
> I left some comments in the patch, about the virtio-blk config space
> there are some missing fields:
> - virtio_blk_geometry fields
> - writeback field
> - *secure_erase* fields
> - virtio_blk_zoned_characteristics fields
>
> Do you plan to add them later?
Yes, I will work on them and will send another series which
also addressing your comments for this series

Thanks
Zhu Lingshan
>
> Thanks,
> Stefano
>
>

