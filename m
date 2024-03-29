Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F94A0A
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723712; cv=none; b=KZB0wAGZYBjPa/ZLI385BrHctN6lxBR2Hr7Raelf/I9LnxdPQ8N1da2UuEFj4todnJU+eP794bHrQIHasXsjwFfOW//XeWCMoRy6PhWwIaROYYBpBABJWjH6b2ofUlMFSQgqAWTGpVWJ9ZMDIwBkvDdz4kqEt1dKjyd40Zefkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723712; c=relaxed/simple;
	bh=ljJBpe+6V7qzay0cWwVDAUfwKssfKEQscel9sdvEA68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRn706RKXD4WlpQCYNfqjPRAvZ3EFRq7TXwksdIjJ7kOSKUB2U8Zz/6jRdNA7xVYIckB3sn8JHhGCFZQtbOaypTPCEZqVWrmwtiDEnZJ6qHaARc6fsitLQrZAvEoeGJl1J6bOHfkQi99ENz1SIPl74XvzL/3trWo528UmsnFCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrDEmuzt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrDEmuzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711723710; x=1743259710;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ljJBpe+6V7qzay0cWwVDAUfwKssfKEQscel9sdvEA68=;
  b=mrDEmuztosYlEnO16oyibITNeDEcC/Dmme+/ZQiqmMGeNuZwdSeN97cU
   EHHMse2w/zQ7tDH6e5g3K9XtGO2bN15DGlXtZxoccVWcPOaQRXSobHs5A
   Ol8CZaHRFiwxckiBZz+utNX2lKWOi3wcttaJK3PNa6hVY/DoMzzf36iri
   YtO9VnVecp4I9/B/HYfFC0bDSODC30BxWW4APXXw1lSwBybVcmjKN43Q1
   grzZbj1ii2uLSO7vPV+OrxNk27dqViQUiSrgkiy+DVJbKyJvX0Pz18r0d
   F/zhKZjL1i9G8ej2jf1I5w9VImIuyhVIBzqer/7TuPbTsBM5CUBPmdlkv
   g==;
X-CSE-ConnectionGUID: DAcU2EieQcKOyyxEYCBK0g==
X-CSE-MsgGUID: F/3O7WRKQ6+KvV6Tbcx6NQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="6850911"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="6850911"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 07:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="16881269"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.249.198]) ([10.124.249.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 07:48:28 -0700
Message-ID: <bfd9be81-d84d-424f-bed0-2e2cfe945bf4@intel.com>
Date: Fri, 29 Mar 2024 22:48:25 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] vDPA: report virtio-block max segment size to user
 space
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-3-lingshan.zhu@intel.com>
 <etmgf3zcsnuz5hoj26g2nr7qunc7dxqg5p5hb43oe2mefkgyk5@4dofowgn4vcy>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <etmgf3zcsnuz5hoj26g2nr7qunc7dxqg5p5hb43oe2mefkgyk5@4dofowgn4vcy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/20/2024 12:04 AM, Stefano Garzarella wrote:
> On Mon, Feb 19, 2024 at 02:55:58AM +0800, Zhu Lingshan wrote:
>> This commit allows reporting the max size of any
>> single segment of virtio-block devices to user space.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>> drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
>> include/uapi/linux/vdpa.h |  1 +
>> 2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index d5ccb618de2b..ee1472d32b0d 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -956,6 +956,20 @@ vdpa_dev_blk_capacity_config_fill(struct sk_buff 
>> *msg,
>>                  val_u64, VDPA_ATTR_PAD);
>> }
>>
>> +static int
>> +vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
>> +                  const struct virtio_blk_config *config)
>> +{
>> +    u32 val_u32;
>> +
>> +    if ((features & BIT_ULL(VIRTIO_BLK_F_SIZE_MAX)) == 0)
>> +        return 0;
>> +
>> +    val_u32 = __virtio32_to_cpu(true, config->size_max);
>> +
>> +    return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
>
> Should we call this VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX ?
I have tried this before, but this macro is too long causing a odd 
format in the header file.

I can change this since you point this out. This is uapi means we should 
merge the
fix during the RC release before 6.9 official.

@MST, does the process work for you?
>
>> +}
>> +
>> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
>>                     struct sk_buff *msg)
>> {
>> @@ -973,6 +987,9 @@ static int vdpa_dev_blk_config_fill(struct 
>> vdpa_device *vdev,
>>     if (vdpa_dev_blk_capacity_config_fill(msg, &config))
>>         return -EMSGSIZE;
>>
>> +    if (vdpa_dev_blk_seg_size_config_fill(msg, features_device, 
>> &config))
>> +        return -EMSGSIZE;
>> +
>>     return 0;
>> }
>>
>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>> index 1bf69226cb96..586bce3c906a 100644
>> --- a/include/uapi/linux/vdpa.h
>> +++ b/include/uapi/linux/vdpa.h
>> @@ -57,6 +57,7 @@ enum vdpa_attr {
>>     VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>>
>>     VDPA_ATTR_DEV_BLK_CFG_CAPACITY,        /* u64 */
>> +    VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,        /* u32 */
>>
>>     /* new attributes must be added above here */
>>     VDPA_ATTR_MAX,
>> -- 
>> 2.39.3
>>
>>
>
>

