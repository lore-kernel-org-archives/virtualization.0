Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B971779B8
	for <virtualization@lists.linux-foundation.org>; Sat,  8 Jun 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840856; cv=none; b=PI1dasxyjZxGIDkUOGFf2QxqrRXEiUzb0hJH06v59Jgx2zy0AyOSxFOcaerPmr73GbB2G3fR/YsVtiPIYiaxY2pILIuDrxpi8MHRTYEQW4eFPvy0MKgOKUxOhOyoDCcpUswfLNsy0oITVgnbFBp+nW7C2nwCUV5gTklAaWu1xYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840856; c=relaxed/simple;
	bh=dD/2qxPjsTYcJBiszw6+m0kwHnKdGtPseKpmC/MTrdk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FmRrbjH5u076aogOj4YhcTmkcg8dd6kFhuIWnoAnklITCvW0/uF+0ZC7gYgddshaUWiq2O767i5DFDlBqGL67OFB3UtZNzrQO7A6Sp/IbQEu31BFtBKcTK8EEiXF9Slp0JJm/BcF1y9ZcvUudI3f1drAc9VRrz3XECahZtj0BVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X164Lzqs; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X164Lzqs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CDFB40169
	for <virtualization@lists.linux-foundation.org>; Sat,  8 Jun 2024 10:00:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSTrv5FypZBR for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Jun 2024 10:00:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E6F9B40021
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6F9B40021
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X164Lzqs
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6F9B40021
	for <virtualization@lists.linux-foundation.org>; Sat,  8 Jun 2024 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717840853; x=1749376853;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dD/2qxPjsTYcJBiszw6+m0kwHnKdGtPseKpmC/MTrdk=;
  b=X164LzqsTyCVuovy0G2rVrCivvpMnqaKZFLcIBi90hvjNep3zCTBXDXW
   jpZFDoqx5Pk3x4XGEF94hK24hUJy8sP8dOWD34/rgpNI+tacycYLQrrbR
   0HwtzFEUtw2V8sCBK4VZelbfE2Uu6/FP+37v2oia1tPCjaJ3cYAuyKFos
   vQ1JPiYX5jtOdWwivTxlBP+DrpdbkIlbKUoArHan//nBC1kx2UohMOmkH
   lC7b5TRD4mUjJOUOJ/4xiASq+8zfSPs0Lu7v0H2bdcN0ekILxpv9jWbjM
   xKJV7/89khN/suvtBJgmzzdk/QyYjmHllW8xxdZafGPGRpbJUhSSDK9mY
   g==;
X-CSE-ConnectionGUID: srHdQFnbTRWAPVSIegJoMA==
X-CSE-MsgGUID: eL/3f8IQQxyf6vM28z/CyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14366491"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="14366491"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 03:00:51 -0700
X-CSE-ConnectionGUID: lcCbsdoTQd2NporVwlg6GQ==
X-CSE-MsgGUID: T9NVOjipTtmZfYc9dHtNOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="39004890"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 08 Jun 2024 03:00:47 -0700
Message-ID: <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>
Date: Sat, 8 Jun 2024 17:58:34 +0800
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
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 5:17 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
>> +				       size_t count, loff_t *ppos)
>> +{
>> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
>> +	struct iommufd_fault *fault = filep->private_data;
>> +	struct iommu_hwpt_pgfault data;
>> +	struct iommufd_device *idev;
>> +	struct iopf_group *group;
>> +	struct iopf_fault *iopf;
>> +	size_t done = 0;
>> +	int rc = 0;
>> +
>> +	if (*ppos || count % fault_size)
>> +		return -ESPIPE;
> 
> the man page says:
> 
> "If count is zero, read() returns zero and has no  other  results."

My understanding is that reading zero bytes is likely to check if a file
descriptor is valid and ready for reading without actually taking any
data from it.

In this code, it just returns 0 and it's compatible with the man page.
Or, I overlooked anything?

> 
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (!list_empty(&fault->deliver) && count > done) {
>> +		group = list_first_entry(&fault->deliver,
>> +					 struct iopf_group, node);
>> +
>> +		if (group->fault_count * fault_size > count - done)
>> +			break;
>> +
>> +		rc = xa_alloc(&fault->response, &group->cookie, group,
>> +			      xa_limit_32b, GFP_KERNEL);
>> +		if (rc)
>> +			break;
>> +
>> +		idev = to_iommufd_handle(group->attach_handle)->idev;
>> +		list_for_each_entry(iopf, &group->faults, list) {
>> +			iommufd_compose_fault_message(&iopf->fault,
>> +						      &data, idev,
>> +						      group->cookie);
>> +			rc = copy_to_user(buf + done, &data, fault_size);
>> +			if (rc) {
> 
> 'rc' should be converted to -EFAULT.

Yes. I will make it like this:

        if (copy_to_user(buf + done, &data, fault_size)) {
                xa_erase(&fault->response, group->cookie);
                rc = -EFAULT;
                break;
        }

> 
>> +				xa_erase(&fault->response, group->cookie);
>> +				break;
>> +			}
>> +			done += fault_size;
>> +		}
>> +
>> +		list_del(&group->node);
>> +	}
>> +	mutex_unlock(&fault->mutex);
>> +
>> +	return done == 0 ? rc : done;
> 
> again this doesn't match the manual:
> 
> "On error, -1 is returned, and errno is set appropriately."
> 
> it doesn't matter whether 'done' is 0.

I don't quite follow here. The code is doing the following:

- If done == 0, it means nothing has been copied to user space. This
   could be due to two reasons:

   1) the user read with a count set to 0, or
   2) a failure case.

   The code returns 0 for the first case and an error number for the
   second.

- If done != 0, some data has been copied to user space. In this case,
   the code returns the number of data copied regardless of the value of
   rc.

> 
>> +
>> +static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
>> +{
>> +	struct iommufd_fault *fault = filep->private_data;
>> +
>> +	iommufd_ctx_put(fault->ictx);
>> +	refcount_dec(&fault->obj.users);
>> +	return 0;
>> +}
> 
> hmm this doesn't sound correct. the context and refcount are
> acquired in iommufd_fault_alloc() but here they are reverted when
> the fd is closed...

These two refcounts were requested when the fault object was installed
to the fault FD.

        filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
                                    fault, O_RDWR);
         if (IS_ERR(filep)) {
                 rc = PTR_ERR(filep);
                 goto out_abort;
         }

         refcount_inc(&fault->obj.users);
         iommufd_ctx_get(fault->ictx);
         fault->filep = filep;

These refcounts must then be released when the FD is released.

>> +
>> +	filep = anon_inode_getfile("[iommufd-pgfault]",
>> &iommufd_fault_fops,
>> +				   fault, O_RDWR);
>> +	if (IS_ERR(filep)) {
>> +		rc = PTR_ERR(filep);
>> +		goto out_abort;
>> +	}
>> +
>> +	refcount_inc(&fault->obj.users);
>> +	iommufd_ctx_get(fault->ictx);
>> +	fault->filep = filep;
> 
> those 3 lines can be moved after below fdno get. It's reads slightly
> clearer to put file related work together before getting to the last piece
> of intiailzation.

The filep is allocated and initialized together.

>> +
>> +	fdno = get_unused_fd_flags(O_CLOEXEC);
>> +	if (fdno < 0) {
>> +		rc = fdno;
>> +		goto out_fput;
>> +	}
>> +
>> @@ -332,6 +332,7 @@ union ucmd_buffer {
>>   	struct iommu_ioas_unmap unmap;
>>   	struct iommu_option option;
>>   	struct iommu_vfio_ioas vfio_ioas;
>> +	struct iommu_fault_alloc fault;
> 
> alphabetic
> 
>> @@ -381,6 +382,8 @@ static const struct iommufd_ioctl_op
>> iommufd_ioctl_ops[] = {
>>   		 val64),
>>   	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct
>> iommu_vfio_ioas,
>>   		 __reserved),
>> +	IOCTL_OP(IOMMU_FAULT_QUEUE_ALLOC, iommufd_fault_alloc,
>> struct iommu_fault_alloc,
>> +		 out_fault_fd),
> 
> ditto

Yes, sure. I wasn't aware of the order.

Best regards,
baolu
