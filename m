Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C0AC77B61
	for <virtualization@archiver.kernel.org>; Mon, 24 Apr 2023 07:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ED9A410CA;
	Mon, 24 Apr 2023 07:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0ED9A410CA
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cVz9Sp20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id npPd4En7REGA; Mon, 24 Apr 2023 07:24:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 13025410CF;
	Mon, 24 Apr 2023 07:24:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 13025410CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB16DC0036;
	Mon, 24 Apr 2023 07:24:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECCDEC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4CF781D0C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:24:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4CF781D0C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cVz9Sp20
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y4s7iaplhg7a
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:24:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B112781CEF
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B112781CEF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Apr 2023 07:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1682321092; x=1713857092;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=v+IVkjNDWShCARgPLe6X91HpSOpu39V7GcSVCuZ7jDc=;
 b=cVz9Sp20DYVEoyjj26UFmdPexheG2Od1RiOUi6h1pSCEQx0Zubjve/iU
 RY8eyeiA/JzcsAJReUVzAjdvjQfkdjkc7xeyUI7ir2frDIfzv4z1vG1hc
 Eq/f+KeLFPIPO+N+dvc3MCF1yaOT6PaKmTaDimD2rup3op28qDzqTDGf0
 TH9lavr3FhUoVK/BuueTO/ERcn7PpmOd9oteucW/r/WxgNXE+LPTUQeet
 ZOxBI9VYbh7KIz3CdZON086t04pTi89S6tO4U2NvEx9V+L6+tMX7BMG7B
 dw9j0LH/OaZtcpLdC35fS0ne7K9HVEf8iig/7B0KkJsHjlDdbgW7d1kj9 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="335267589"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; d="scan'208";a="335267589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2023 00:24:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686703412"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; d="scan'208";a="686703412"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.168.173])
 ([10.249.168.173])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2023 00:24:50 -0700
Message-ID: <7139a315-b1bf-042b-2535-71886c67f86f@intel.com>
Date: Mon, 24 Apr 2023 15:24:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] get_driver_features from virito registers
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
 <20230331204854.20082-3-lingshan.zhu@intel.com>
 <20230424005019-mutt-send-email-mst@kernel.org>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20230424005019-mutt-send-email-mst@kernel.org>
Cc: virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 4/24/2023 12:50 PM, Michael S. Tsirkin wrote:
> subj typo: virtio
will fix in V2, thanks!
>
> On Sat, Apr 01, 2023 at 04:48:51AM +0800, Zhu Lingshan wrote:
>> This commit implements a new function ifcvf_get_driver_feature()
>> which read driver_features from virtio registers.
>>
>> To be less ambiguous, ifcvf_set_features() is renamed to
>> ifcvf_set_driver_features(), and ifcvf_get_features()
>> is renamed to ifcvf_get_dev_features() which returns
>> the provisioned vDPA device features.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_base.c | 38 +++++++++++++++++----------------
>>   drivers/vdpa/ifcvf/ifcvf_base.h |  5 +++--
>>   drivers/vdpa/ifcvf/ifcvf_main.c |  9 +++++---
>>   3 files changed, 29 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
>> index 6c5650f73007..546e923bcd16 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
>> @@ -204,11 +204,29 @@ u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
>>   	return features;
>>   }
>>   
>> -u64 ifcvf_get_features(struct ifcvf_hw *hw)
>> +/* return provisioned vDPA dev features */
>> +u64 ifcvf_get_dev_features(struct ifcvf_hw *hw)
>>   {
>>   	return hw->dev_features;
>>   }
>>   
>> +u64 ifcvf_get_driver_features(struct ifcvf_hw *hw)
>> +{
>> +	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
>> +	u32 features_lo, features_hi;
>> +	u64 features;
>> +
>> +	vp_iowrite32(0, &cfg->device_feature_select);
>> +	features_lo = vp_ioread32(&cfg->guest_feature);
>> +
>> +	vp_iowrite32(1, &cfg->device_feature_select);
>> +	features_hi = vp_ioread32(&cfg->guest_feature);
>> +
>> +	features = ((u64)features_hi << 32) | features_lo;
>> +
>> +	return features;
>> +}
>> +
>>   int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
>>   {
>>   	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)) && features) {
>> @@ -275,7 +293,7 @@ void ifcvf_write_dev_config(struct ifcvf_hw *hw, u64 offset,
>>   		vp_iowrite8(*p++, hw->dev_cfg + offset + i);
>>   }
>>   
>> -static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
>> +void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features)
>>   {
>>   	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
>>   
>> @@ -286,19 +304,6 @@ static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
>>   	vp_iowrite32(features >> 32, &cfg->guest_feature);
>>   }
>>   
>> -static int ifcvf_config_features(struct ifcvf_hw *hw)
>> -{
>> -	ifcvf_set_features(hw, hw->req_features);
>> -	ifcvf_add_status(hw, VIRTIO_CONFIG_S_FEATURES_OK);
>> -
>> -	if (!(ifcvf_get_status(hw) & VIRTIO_CONFIG_S_FEATURES_OK)) {
>> -		IFCVF_ERR(hw->pdev, "Failed to set FEATURES_OK status\n");
>> -		return -EIO;
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>>   {
>>   	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
>> @@ -387,9 +392,6 @@ int ifcvf_start_hw(struct ifcvf_hw *hw)
>>   	ifcvf_add_status(hw, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>>   	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER);
>>   
>> -	if (ifcvf_config_features(hw) < 0)
>> -		return -EINVAL;
>> -
>>   	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER_OK);
>>   
>>   	return 0;
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
>> index d545a9411143..cb19196c3ece 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_base.h
>> +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
>> @@ -69,7 +69,6 @@ struct ifcvf_hw {
>>   	phys_addr_t notify_base_pa;
>>   	u32 notify_off_multiplier;
>>   	u32 dev_type;
>> -	u64 req_features;
>>   	u64 hw_features;
>>   	/* provisioned device features */
>>   	u64 dev_features;
>> @@ -122,7 +121,7 @@ u8 ifcvf_get_status(struct ifcvf_hw *hw);
>>   void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
>>   void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
>>   void ifcvf_reset(struct ifcvf_hw *hw);
>> -u64 ifcvf_get_features(struct ifcvf_hw *hw);
>> +u64 ifcvf_get_dev_features(struct ifcvf_hw *hw);
>>   u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
>>   int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
>>   u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
>> @@ -137,4 +136,6 @@ int ifcvf_set_vq_address(struct ifcvf_hw *hw, u16 qid, u64 desc_area,
>>   			 u64 driver_area, u64 device_area);
>>   bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid);
>>   void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready);
>> +void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features);
>> +u64 ifcvf_get_driver_features(struct ifcvf_hw *hw);
>>   #endif /* _IFCVF_H_ */
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index 1357c67014ab..4588484bd53d 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -410,7 +410,7 @@ static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
>>   	u64 features;
>>   
>>   	if (type == VIRTIO_ID_NET || type == VIRTIO_ID_BLOCK)
>> -		features = ifcvf_get_features(vf);
>> +		features = ifcvf_get_dev_features(vf);
>>   	else {
>>   		features = 0;
>>   		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
>> @@ -428,7 +428,7 @@ static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 feat
>>   	if (ret)
>>   		return ret;
>>   
>> -	vf->req_features = features;
>> +	ifcvf_set_driver_features(vf, features);
>>   
>>   	return 0;
>>   }
>> @@ -436,8 +436,11 @@ static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 feat
>>   static u64 ifcvf_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
>>   {
>>   	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>> +	u64 features;
>> +
>> +	features = ifcvf_get_driver_features(vf);
>>   
>> -	return vf->req_features;
>> +	return features;
>>   }
>>   
>>   static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
>> -- 
>> 2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
