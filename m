Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCAA17565
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713149166; cv=none; b=QNnkQULIMv948stSQXKyg5Rk6oAhPgtUYyqWup3Hai80M2KCMBTfXQtHODY1yV+dFZ69guP/lYdWOHAHqJcOfz7LQgq59NfjCulZv0DC2w9iFX3ek6trHZtOBJyxAH6bu8mQK7dkA8r+/U6w1dqhxE6Ubypab3HfnTHyvTHDaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713149166; c=relaxed/simple;
	bh=prhO1q+WOtiv/0lD0pKP0UiYsn2UQlZZeNQwz0zL0xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjilM9QaQ5AlpbohfiYFpJ9qtZjKduCibGnFgOTroyf5GyBm26HvA4QlcB45HO1PFIjjrnC/5IiGtnaH/3LpSQWki2uBIYFVIcuRvr4ze7FYGJUwxfSgqwirq0b+2jyH8CJ9+jJ45Zx1EpdbBF4aS366ZG23+ot0LP0ztwgnXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R82hUITf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R82hUITf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713149165; x=1744685165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=prhO1q+WOtiv/0lD0pKP0UiYsn2UQlZZeNQwz0zL0xY=;
  b=R82hUITfMEzc81iuczPkShsKN72hXBQ2hdNGjn8ifYCH5rVBpHFVnNkf
   PYB0J1GYs0WoHgzRFxZd3CoW3diisZeTghBKn5VOL4tfEMk73KiaI1sfP
   SvQOTC2RlnloMoKgXBYl2ZjOXhrs8xUcSv8qv76clH7KXDvvYi8zlz0ar
   RgvImxjv7ZDsLcCj5cVcVJIBfIlQLyXqUFreFKRr4Eyn4TWyhhnS5oPUp
   5KU29ZZKJGVwSS/v0vS07BSbpr4I0eiFtqZK5g26QCqIeNoCD9i9BxsH7
   KoHPO9vmMbZ23LZxGlhl4apGHKWgqj/m53g1tNDoDMiQjwvhSpCUFBPLa
   A==;
X-CSE-ConnectionGUID: UfTKYV+WTfWRLiXmBsPhaQ==
X-CSE-MsgGUID: ukfWoL8uRcKGDLfioXur1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19120669"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="19120669"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 19:46:04 -0700
X-CSE-ConnectionGUID: bepPFCaGT9yJJ0x42cFK9A==
X-CSE-MsgGUID: wgXHa4qtSTaMqx9TU/EfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="52713988"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.124.249.198]) ([10.124.249.198])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 19:46:03 -0700
Message-ID: <5c45b1a9-6c6e-4b13-a6ee-c6cf68a2ab70@intel.com>
Date: Mon, 15 Apr 2024 10:46:00 +0800
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
 <1d6a5761-3a5a-4de8-8472-9a4dbb2db6b6@intel.com>
 <20240411020502-mutt-send-email-mst@kernel.org>
 <20240414042538-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240414042538-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/2024 4:28 PM, Michael S. Tsirkin wrote:
> On Thu, Apr 11, 2024 at 02:05:57AM -0400, Michael S. Tsirkin wrote:
>> On Thu, Apr 11, 2024 at 10:19:38AM +0800, Zhu, Lingshan wrote:
>>>
>>> On 4/10/2024 5:27 PM, Michael S. Tsirkin wrote:
>>>> On Thu, Apr 11, 2024 at 12:37:16AM +0800, Zhu Lingshan wrote:
>>>>> This commit cleans up the upai for vhost_vdpa by
>>>>> better naming some of the macros which report blk
>>>>> information to user space.
>>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>>> These are enums not macros.
>>>>
>>>> And tweaking UAPI is problematic as it can break userspace
>>>> builds. If you do this you need a #define for the old name
>>>> to avoid that issue.
>>> The enums are not in 6.9 official release yet, so we have a chance and
>>> agreed
>>> to deliver a fix during RC stage.
>>>
>>> https://lore.kernel.org/all/20240331160230-mutt-send-email-mst@kernel.org/
>>>
>>> Shall I post a V2 for better commit message: macros --> enums?
>>>
>>> Thanks
>>> Zhu Lingshan
>>
>> Pls do. Add a Fixes: tag listing the commits that introduced them.
>> And mention that it wasn't in any releases.
>
> Still waiting for this. Note I keep changes in next for several days
> so there's a chance to shake out bugs, and if I send a pull
> at the last minute it might not make it in the release.
> We'll then not be able to make these changes to avoid breaking
> userspace builds.
I was on vocations for my personal affairs and will deliver a V2 patch
today.

I see you have send out a pull request, maybe we still have
a chance to fix it in RC5?

Thanks
Zhu Lingshan
>
>
>>>>> ---
>>>>>    drivers/vdpa/vdpa.c       | 6 +++---
>>>>>    include/uapi/linux/vdpa.h | 6 +++---
>>>>>    2 files changed, 6 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>>>>> index b246067e074b..6cb96a1e8b7d 100644
>>>>> --- a/drivers/vdpa/vdpa.c
>>>>> +++ b/drivers/vdpa/vdpa.c
>>>>> @@ -967,7 +967,7 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
>>>>>    	val_u32 = __virtio32_to_cpu(true, config->size_max);
>>>>> -	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
>>>>> +	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX, val_u32);
>>>>>    }
>>>>>    /* fill the block size*/
>>>>> @@ -1089,7 +1089,7 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
>>>>>    	u8 ro;
>>>>>    	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
>>>>> -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
>>>>> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_READ_ONLY, ro))
>>>>>    		return -EMSGSIZE;
>>>>>    	return 0;
>>>>> @@ -1100,7 +1100,7 @@ static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
>>>>>    	u8 flush;
>>>>>    	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
>>>>> -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
>>>>> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_FLUSH, flush))
>>>>>    		return -EMSGSIZE;
>>>>>    	return 0;
>>>>> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
>>>>> index 43c51698195c..842bf1201ac4 100644
>>>>> --- a/include/uapi/linux/vdpa.h
>>>>> +++ b/include/uapi/linux/vdpa.h
>>>>> @@ -57,7 +57,7 @@ enum vdpa_attr {
>>>>>    	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>>>>>    	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
>>>>> -	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
>>>>> +	VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX,		/* u32 */
>>>>>    	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
>>>>>    	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
>>>>>    	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
>>>>> @@ -70,8 +70,8 @@ enum vdpa_attr {
>>>>>    	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
>>>>>    	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
>>>>>    	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
>>>>> -	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
>>>>> -	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
>>>>> +	VDPA_ATTR_DEV_BLK_READ_ONLY,		/* u8 */
>>>>> +	VDPA_ATTR_DEV_BLK_FLUSH,		/* u8 */
>>>>>    	/* new attributes must be added above here */
>>>>>    	VDPA_ATTR_MAX,
>>>>> -- 
>>>>> 2.39.3

