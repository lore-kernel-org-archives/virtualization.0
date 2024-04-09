Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E47E58C
	for <virtualization@lists.linux.dev>; Tue,  9 Apr 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651844; cv=none; b=mZYv49MAjKN78RTLx+Y7l3A0EP95oTtKjiEYTtAZlr6gwxJE8IFEetrK/xxS9/PQzh4TSY5DQDJSLpw4O3E/62n7gzV9iFkv0yVb8B9Wxv/FJ9qUpiq36ve7pOL/xTgETf0aOCkxPtafLIxNI4NHvjJZQWFVyjvOFt5+MlosJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651844; c=relaxed/simple;
	bh=SedDHtQxHwlMe+ftuWwMuJ7InOSuis1VajqtjEEo+0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDzwtI8oL7V2477PEdBNoYTVNstSBDSZChKvYoikoMA3LxXHqkWLMmM7PuaIggSp4h5bnDOX1cIcMc0w0UDZoMDajnjxgv8W0iEHZ4ZWUyP8mjXI3tkhA7h3WLnI5XzuH6z5VQUBbVzafO4NOTMxUUNB07Nk4OeUknqcqiFrcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2wp69V9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2wp69V9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712651844; x=1744187844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SedDHtQxHwlMe+ftuWwMuJ7InOSuis1VajqtjEEo+0s=;
  b=T2wp69V9JF116mXiC65hs6Cn7qPSFEm59dcg4lntnnfJMihAGcf9tePa
   53kNabNF+zzoGkGRHuRjkXTt0RWye6gotBmCk8qTzCOhrQ1YaWFkVB3NG
   DgeVD2VlIKXst5T6sgI3IsGKQqF6RCZy18GdZRAuv1LF1gGxOQWwZEUmo
   HCN9pkK7V+dnALKtWwts1pvnrMuItUd6jNISe9AxWPnRT2UnM+tQfSCQQ
   IzNNr2BhWC8sVTCs2W3uSMibe/ZcEBEpotAc2KBY2vV4lx+KBRo1BL1zL
   1BOWxusViia28PyZRirLESDQi8Y+UutbvJdJn/w5Giau6GFu0Gcl2XUZc
   Q==;
X-CSE-ConnectionGUID: yqOUtoFDTUO/9ZCBLX1T5w==
X-CSE-MsgGUID: zyGQFNDqQyCFHOJ1P9JY3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8080902"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8080902"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:37:23 -0700
X-CSE-ConnectionGUID: uomU7DyoRnynfvtonyI7og==
X-CSE-MsgGUID: cSgh90yNQlyFRoDXP5qFHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20724954"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.249.198]) ([10.124.249.198])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 01:37:22 -0700
Message-ID: <a0672e72-5c17-4457-9f31-9f9db6f9f229@intel.com>
Date: Tue, 9 Apr 2024 16:37:18 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] vDPA: report virtio-block read-only info to user
 space
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-10-lingshan.zhu@intel.com>
 <ms2roqd326s5j5ynksciz4tdijqx4taeoyjvtzelbttkt4vich@b4geobrynwj5>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <ms2roqd326s5j5ynksciz4tdijqx4taeoyjvtzelbttkt4vich@b4geobrynwj5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/20/2024 12:40 AM, Stefano Garzarella wrote:
> On Mon, Feb 19, 2024 at 02:56:05AM +0800, Zhu Lingshan wrote:
>> This commit report read-only information of
>> virtio-blk devices to user space.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>> drivers/vdpa/vdpa.c       | 14 ++++++++++++++
>> include/uapi/linux/vdpa.h |  1 +
>> 2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index adbcbc7b18b2..d6fd3cadc44f 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -1084,6 +1084,17 @@ vdpa_dev_blk_write_zeroes_config_fill(struct 
>> sk_buff *msg, u64 features,
>>     return 0;
>> }
>>
>> +static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 
>> features)
>> +{
>> +    u8 ro;
>> +
>> +    ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
>> +    if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
>
> This is not really related to the config space, what about renaming it
> to VDPA_ATTR_DEV_BLK_READ_ONLY ?
>
> Also the type, maybe better to use "flag" and set it through
> `nla_put_flag()`.
Hi Stefano,

I am implementing this change.
In my humble opinion, maybe using a boolean(the u8 above) is better?
Because using the flag means we conditionally put a "0" into the 
attribution,
or the attribution does not exist, this is still a bool logic but
a little vague.

Thanks
Lingshan
>
> Not a strong opinion on that, it just seems a little more consistent to
> me.
>
> Thanks,
> Stefano
>
>> +        return -EMSGSIZE;
>> +
>> +    return 0;
>> +}
>> +
>> static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
>>                     struct sk_buff *msg)
>> {
>> @@ -1122,6 +1133,9 @@ static int vdpa_dev_blk_config_fill(struct 
>> vdpa_device *vdev,
>>     if (vdpa_dev_blk_write_zeroes_config_fill(msg, features_device, 
>> &config))
>>         return -EMSGSIZE;
>>
>> +    if (vdpa_dev_blk_ro_config_fill(msg, features_device))
>> +        return -EMSGSIZE;
>> +
>>     return 0;
>> }
>>
>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>> index 797d5708492f..4be8e3a15874 100644
>> --- a/include/uapi/linux/vdpa.h
>> +++ b/include/uapi/linux/vdpa.h
>> @@ -70,6 +70,7 @@ enum vdpa_attr {
>>     VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
>>     VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,    /* u32 */
>>     VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,    /* u32 */
>> +    VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,        /* u8 */
>>
>>     /* new attributes must be added above here */
>>     VDPA_ATTR_MAX,
>> -- 
>> 2.39.3
>>
>>
>
>

