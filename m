Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51B69944
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712801984; cv=none; b=EI0owBQL6jKLEtdyD0cs8FXt60zcJ+I03MLVN+fdxpiCEM/AW+VwXDO3r04RcM4W7sqonsXro7GNUEeLxdK6o2jMfL7icz4YQHg5IKaxFAKhRtfFS/GKareqVLpkIB2pCQCMbqYLXMydTmyUsUH/1AXWb/YDcpfvUkvmevAwgWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712801984; c=relaxed/simple;
	bh=IWbiu2LbJygY4Wwia4cihFFqzvVJ9YE0qArlrWMM93M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQD7qNm40Wwk0pam/Zzgm3XJMgd9VWOyvvwNpgw1qxJH0rLQu/oqpNvC2UMRvtns6UxSj6eR+lIFRNEcnUJTuLv6wvqt5HsPvlTV0Nv6nytqNrtuWRZufN2lehwdpIhFFWQQNZoEIBVLRQGT9nmlTY9MHl+k5OGqW9VJtzg93ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSMK6ZWB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSMK6ZWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712801983; x=1744337983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IWbiu2LbJygY4Wwia4cihFFqzvVJ9YE0qArlrWMM93M=;
  b=CSMK6ZWBkbMLx6abVezeS6Q5WJmQ+WOUkMc5XpDDR9yBJWK+uiuDsiig
   vTJamZF9GKG1Xd+7oLC3XBichb/i49uGdPgDF+Z7yJskAjUhzM5d+zMKz
   u/psQVdzXW/ni9iGUVYAlA3keqMB8uzmh7kQTNuXpgw4RBgV9d4uVLFbq
   noNxVwzEkiuGrO6IAmLr+fpIoYc3suLE1lfwEeQxbFKXssP8eGHJDKK8h
   /33N7ePkCGo3jjCk7cEhj4NyugkGfPC0agykyWKokKXz3v7yphpcNxUAF
   C+ysdvgwumdjzhgESBaehUS8vQhMARe10fer6Zxxvb5tjhkc9F+b1aNxl
   Q==;
X-CSE-ConnectionGUID: zjLEXTGcQN25bRSVy+868w==
X-CSE-MsgGUID: mVQCr9vDSCyIT9eKazowXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8358331"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8358331"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:19:42 -0700
X-CSE-ConnectionGUID: iCltcCHuSmChmhWfii2Juw==
X-CSE-MsgGUID: uGXfaHf6T3GAIk1kTPaRwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25528137"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.249.198]) ([10.124.249.198])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 19:19:41 -0700
Message-ID: <1d6a5761-3a5a-4de8-8472-9a4dbb2db6b6@intel.com>
Date: Thu, 11 Apr 2024 10:19:38 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vDPA: code clean for vhost_vdpa uapi
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, jasowang@redhat.com, virtualization@lists.linux.dev
References: <20240410163716.699708-1-lingshan.zhu@intel.com>
 <20240410052059-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240410052059-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/2024 5:27 PM, Michael S. Tsirkin wrote:
> On Thu, Apr 11, 2024 at 12:37:16AM +0800, Zhu Lingshan wrote:
>> This commit cleans up the upai for vhost_vdpa by
>> better naming some of the macros which report blk
>> information to user space.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> These are enums not macros.
>
> And tweaking UAPI is problematic as it can break userspace
> builds. If you do this you need a #define for the old name
> to avoid that issue.
The enums are not in 6.9 official release yet, so we have a chance and 
agreed
to deliver a fix during RC stage.

https://lore.kernel.org/all/20240331160230-mutt-send-email-mst@kernel.org/

Shall I post a V2 for better commit message: macros --> enums?

Thanks
Zhu Lingshan
>
>> ---
>>   drivers/vdpa/vdpa.c       | 6 +++---
>>   include/uapi/linux/vdpa.h | 6 +++---
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index b246067e074b..6cb96a1e8b7d 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -967,7 +967,7 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
>>   
>>   	val_u32 = __virtio32_to_cpu(true, config->size_max);
>>   
>> -	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
>> +	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX, val_u32);
>>   }
>>   
>>   /* fill the block size*/
>> @@ -1089,7 +1089,7 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
>>   	u8 ro;
>>   
>>   	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
>> -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
>> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_READ_ONLY, ro))
>>   		return -EMSGSIZE;
>>   
>>   	return 0;
>> @@ -1100,7 +1100,7 @@ static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
>>   	u8 flush;
>>   
>>   	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
>> -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
>> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_FLUSH, flush))
>>   		return -EMSGSIZE;
>>   
>>   	return 0;
>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>> index 43c51698195c..842bf1201ac4 100644
>> --- a/include/uapi/linux/vdpa.h
>> +++ b/include/uapi/linux/vdpa.h
>> @@ -57,7 +57,7 @@ enum vdpa_attr {
>>   	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>>   
>>   	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
>> -	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
>> +	VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX,		/* u32 */
>>   	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
>>   	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
>>   	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
>> @@ -70,8 +70,8 @@ enum vdpa_attr {
>>   	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
>>   	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
>>   	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
>> -	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
>> -	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
>> +	VDPA_ATTR_DEV_BLK_READ_ONLY,		/* u8 */
>> +	VDPA_ATTR_DEV_BLK_FLUSH,		/* u8 */
>>   
>>   	/* new attributes must be added above here */
>>   	VDPA_ATTR_MAX,
>> -- 
>> 2.39.3

