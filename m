Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648883BBFCF
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259741; cv=none; b=iCjgPbGG62g0C1jBQDvzdOSoPdtFF82jBuBgMNreInVm/P3Xn6IWF50xyPPN1NUpbXdjQH3HknJCrHZ79T3kW1cyRqO5uUfv0S8PVAQnJFxgWjCXenxMjjBziUamcWSgBhfeD+2v9Mz4Lkr8FhVKBkl9izYrSHRKgBZF4mLIC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259741; c=relaxed/simple;
	bh=SLGSseQaf0vJp+4kOQXKmxaBEuZ8Z93Jn47quXknsh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUHHM/pCLMSxQUsW6T2BiuY8UPOZlGVDwMWrVJ4fs1LH0ab5K1Jneiaer/1PKW4a2YHmMZWuAICB5lS7w4hcC8eX2IpgFkqxXsUjRaWnrImHFvvPJHTIm3zLuFPLrxtZZIaeXWs/Yp3LgFugCAD8dSN/45wiVdz/N0E7LFyhycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0tDVZcd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VV5u3Y+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0tDVZcd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VV5u3Y+I"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJjj92752209
	for <virtualization@lists.linux.dev>; Tue, 1 Sep 2026 10:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWfgeNOyFGDYlfIW9v/3p67LM/pgSzbvLJN7re/Y3h0=; b=T0tDVZcdsuc35KoL
	Gl6yMhEOiZ77racbSuMPOeyFCek1TfOwHIawgO58AD9OmvRvrARY9NNGUnCcHrMn
	Hk58PTGkYRaetFb9JtWN9d5dCPDB+51x3xDF20d07maqT2CRv5oPFo1qP/6huy4V
	SBL/fT9yi09owKqSlStcb1zk8wojBlOpQAT4bz7n7S88JLlFeZJqvbsF4C5fdWow
	PL7iWTXsp26kkr4zeqPTC/6WPQZnP5b3rF4g8SeCBgIHcqgBYdgfgubpbUI9J2PH
	7GJKwOwuD6uMGiZXuqdhzTbzR+TBcyy5usm+NBIinlvT1wx4GpXrpn6eksXn6r4N
	8YE1qg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdfchbhkd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 01 Sep 2026 10:48:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso1026982a91.0
        for <virtualization@lists.linux.dev>; Tue, 01 Sep 2026 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788259737; x=1788864537; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWfgeNOyFGDYlfIW9v/3p67LM/pgSzbvLJN7re/Y3h0=;
        b=VV5u3Y+Iv+hUNXE2JZlwKlIswiTgnmyBOs9saSakSNvgb2h83R6d9iRXZQVB6mNoQm
         gnJpMIECTnD07+fOre/sXAak5BjL5zFy3cw6aNwgW4NxX2pDzZCbQkkcvwzeCzdHQuxa
         qNdcIJkoJL2uyzwAidouoyWH2su29meJIBLmBfujAhttX/MqztIi114g4ueCVB9oc3uR
         GKFBdV4CKYZLnUQVuOesP+d/GzjWl16F8kXS8XAI2NYPgZNRIGQ/mzDVKDCAS/RO2BNe
         naqwrGNvvgTix2IfDqsqCX++f/w6FcPlT0FGCYFOeH8uWRnNWIhZoA3DEaxe8uG0znEr
         GQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788259737; x=1788864537;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kWfgeNOyFGDYlfIW9v/3p67LM/pgSzbvLJN7re/Y3h0=;
        b=dvrm2cBoddiPO94T6CuL2L3k5L7eS1GzU6C/L/zxDlfBAu+SpBaEsrYFQeoFNIvzpN
         G2oOOXZjndanD+MTKxRuV4Er6WJjc1NfNc46Bdw0eyUQsLGIZoFNTIrl3ljbgykZm4XM
         qaeYQYTqg5XHPwBepXKEj/9HvuOumMrbq9/5cQG+b6vufx5kYpQITThRsAYXe1BA6HTK
         9wJOJFPZGU9I5N49QlcDDm5jnZj/U1B2ZxBf3OqclkT7BHiKW9SfleAH1F0OwGEXyoEC
         MmV6Uf++7ZfwJM9/rmC/EJJaBkYtEexxlAUAm3yPP7914CWoh7D+rpcgE8OTTTbjswn2
         JM1g==
X-Forwarded-Encrypted: i=1; AKwUvByynrgr+fKLZQ1HopLOgxwKkzLNSVG3VOjY9E5qN5m2+IiGt3GLLl3tLu7qjvi4R9LATemcB1A0exiT3IIvWw==@lists.linux.dev
X-Gm-Message-State: AFuF++kB0OWRlspbWd1KyQtIpQ46ekKvCdsYeH4AoNpV2cgAEGyF4Hha
	BAipEgsiZpEJg/ICN2nTDeQ9TJXkzV/4huocVeFddxfd7cu271Ba5NlN57lsdRJaC6WlVbL7XL3
	es+DyqJVFQYWEvCtjgwOcr3dDTm+vfUzTK7pSSQ5d3cSY/cY1fQsMZpIl4cReyAK5tBjIVQ==
X-Gm-Gg: AYBFou1j0g+KFoMxT3syJqZa0Stiptez+iIBTqTab4OW9CUpGtht7xYdkN/CIusTAuI
	QZJkQz3Aps6CRTRYBl5ohqhnFvbZ502Jkl0Av8ctAyiisYcYrZprCOS0EMi+N4+BCSUjkkwHERF
	sFnW2a771ffvTL/MVIOIS7KNdQG+by7a5RjjDfamG4GYY4ylas5+T9EPelJnd3uO/Wy4HOisnZo
	+VS6cpLb61s+0EspZjpA82JUA4r6HP6SeY1W+wQasimnKEb23P2zuNuzU9d1ZvqdYiJtw1g2eHi
	marlcOfYg6iSPAnJE9n7I/C8YqMoqHjIBROBNXy2Hct+ECmoPDBSwdGdM8x14MbNC/H7bZud8YZ
	h+KhRzhGPmpQX10I/TiObjBccleiQrdfQQ8mLQCT67Zs7lTCzJ2mVrr+H
X-Received: by 2002:a17:90b:5586:b0:398:c8f3:d076 with SMTP id 98e67ed59e1d1-3990f93210fmr4803914a91.31.1788259735000;
        Tue, 01 Sep 2026 03:48:55 -0700 (PDT)
X-Received: by 2002:a17:90b:5586:b0:398:c8f3:d076 with SMTP id 98e67ed59e1d1-3990f93210fmr4803842a91.31.1788259734429;
        Tue, 01 Sep 2026 03:48:54 -0700 (PDT)
Received: from [10.110.34.210] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b5bef7683sm23429688eec.12.2026.09.01.03.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:48:54 -0700 (PDT)
Message-ID: <4d2d0d17-391c-4c81-8748-bf1025ea6f75@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:48:46 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] soc: qcom: add ICE keyslot partitioning driver
 for guest VMs
To: Krzysztof Kozlowski <krzk@kernel.org>, ebiggers@kernel.org,
        axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        stefanha@redhat.com, pbonzini@redhat.com, eperezma@redhat.com,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
 <20260827160806.1295313-10-linlin.zhang@oss.qualcomm.com>
 <e23142e8-41b3-40f5-9d63-53c9c38fba38@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <e23142e8-41b3-40f5-9d63-53c9c38fba38@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KpewwUuXhH9Vv3aDRZwjOKGHVE93eKdO
X-Authority-Analysis: v=2.4 cv=G9Ms1dk5 c=1 sm=1 tr=0 ts=6a96ad9a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=puuXhSqztIu-OQ_ZuWYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: KpewwUuXhH9Vv3aDRZwjOKGHVE93eKdO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5NSBTYWx0ZWRfXyCxvKLYv8ice
 78XGnEcAoqA2bFUVnCWzmM1uXct0zJZq1PCT2zz8wakr0ccnC76f6onI1Oh/oC4cZOuMyTk6AyR
 sALtreC5VGghabl8xR/XTf+YBDqBV4A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5NSBTYWx0ZWRfX1FZS1DV1qbf8
 4QyWqJjczHtQbLiVD65Dz8x6RUMOjJTKtqOPXv0L9hAlh4g/DnLubXxMi/TQOGytpPA3TrOe/4q
 sk2t48E2G6yR1GiScPZj4q3EaKWFH8bFaIVH+PJ9iHfDW7EFauz54gQN/NZyMFiFqZLWTd/D4A8
 16MRKqjgtoD3k5g0Rwa6Z+4ebrjO7PqYgVwY31EQUT75129rWH0m+RU76HC50tz6Zrzzl8IxRqb
 c3szG41ZaeoNLhNW571XSi+ccvvivPVyRpVXOJ4U3bOzFknLi0lAg0A7a3fmjQ7nxKahNtMZUe5
 PeS9qNDJvK1+Ek+lTm5x1ZW6yXnzwxYNbKJ2Tv5OSNwvSYprWQWLXuXxJHwzWOnEalsFG6xmHxQ
 qDi3MzizOzJCKryFgoMAd8FEq+dCCsCM2illeodjBqFCmEB2Nx6cmrHWbjfAJbSF6aDLpRmWsHJ
 YgwFSxlejENUp+PeMzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010095



On 8/31/2026 3:02 PM, Krzysztof Kozlowski wrote:
> On 27/08/2026 18:07, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> On Qualcomm platforms the ICE hardware has a fixed number of physical
>> keyslots shared across the host and all guest VMs.  A userspace
>> virtio-blk backend handling VIRTIO_BLK_T_CRYPTO_IN/OUT requests needs
>> to translate a guest's virtual keyslot index to the corresponding
>> physical ICE keyslot without letting one VM access another VM's slots.
>>
>> Add QCOM_ICE_SLOTS, a platform driver that implements bcp_slot_virt_ops
>> for the /dev/blk-crypto-proxy device.  It parses a
>> qcom,ice-keyslot-map device-tree node describing the per-VM keyslot
>> allocation table, where each child entry maps a guest_id to a
>> contiguous physical slot range [slot_offset .. slot_offset +
>> max_ice_slots).  Entry 0 is reserved for the host; guest entries start
>> at index 1 and are excluded from the guest-facing translation so that
>> blk-crypto-proxy cannot accidentally route a guest request into the
>> host's physical keyslots.
>>
>> The driver exposes two callbacks:
>>
>>   get_guest_slots()  — return the number of ICE keyslots allocated to
>>                        a given guest_id; used by BCP_GET_CRYPTO_CAPS to
>>                        populate the max_slots field in the virtio config
>>                        space.
>>   vslot_to_pslot()   — translate a (guest_id, virtual-slot) pair to the
>>                        corresponding physical ICE keyslot index; used by
>>                        BCP_SUBMIT_IO_BY_VSLOT before calling
>>                        bio_crypt_set_ctx_by_slot().
>>
>> The singleton pointer to the parsed table is RCU-protected; the hot
>> path reads it lock-free.  Probe validates that no two VM entries share
>> a guest_id or overlapping physical slot ranges.
>>
>> Note: This patch is submitted for visibility. The keyslot partitioning
>> is based on the current DT-based keyslot allocation with vm_id known.
>> We are aware this may be revised to use a TZ SCM query interface in a
>> future version of this series, submit it RFC for design discussion.
>>
>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>> ---
>>  drivers/soc/qcom/Kconfig          |  18 +++
>>  drivers/soc/qcom/Makefile         |   1 +
>>  drivers/soc/qcom/qcom_ice_slots.c | 232 ++++++++++++++++++++++++++++++
>>  3 files changed, 251 insertions(+)
>>  create mode 100644 drivers/soc/qcom/qcom_ice_slots.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 6c632d114d45..e1f383b4dc63 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -294,6 +294,24 @@ endif
>>  # Options selected by other drivers from different subsystems must be outside
>>  # of the menuconfig if-block:
>>  
>> +config QCOM_ICE_SLOTS
>> +	tristate "Qualcomm ICE keyslot partitioning for VM guests"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on BLK_CRYPTO_PROXY
>> +	depends on BLK_INLINE_ENCRYPTION
>> +	help
>> +	  Parses the qcom,ice-keyslot-map device-tree node and provides
>> +	  per-VM ICE keyslot accounting and virtual-to-physical slot
>> +	  translation for guest VMs sharing ICE hardware on Qualcomm
>> +	  platforms.
>> +
>> +	  When enabled, guest virtual keyslot indices are mapped to the
>> +	  physical ICE keyslot range allocated to each VM, preventing one
>> +	  VM from accessing another VM's keyslots.
>> +
>> +	  Say M here when multiple VMs share ICE keyslots on a Qualcomm
>> +	  platform.  If unsure, say N.
>> +
>>  config QCOM_INLINE_CRYPTO_ENGINE
>>  	tristate
>>  	select QCOM_SCM
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 6d4b7546d1fb..952a57554f9d 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -38,6 +38,7 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>>  qcom_ice-objs			+= ice.o
>> +obj-$(CONFIG_QCOM_ICE_SLOTS)	+= qcom_ice_slots.o
>>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
>>  obj-$(CONFIG_QCOM_CRYPTO_VIRT)	+= crypto_virt.o
>>  obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
>> diff --git a/drivers/soc/qcom/qcom_ice_slots.c b/drivers/soc/qcom/qcom_ice_slots.c
>> new file mode 100644
>> index 000000000000..364ac93077c1
>> --- /dev/null
>> +++ b/drivers/soc/qcom/qcom_ice_slots.c
>> @@ -0,0 +1,232 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * qcom_ice_slots.c - Qualcomm ICE keyslot partitioning for guest VMs
>> + *
>> + * Implements bcp_slot_virt_ops: translates a (guest_id, virtual-slot) pair to
>> + * a physical ICE keyslot index using a per-VM allocation table parsed from
>> + * the device-tree node with compatible = "qcom,ice-keyslot-map".
>> + *
>> + * Device-tree layout:
>> + *
>> + *   ice_keyslot_map: ice-keyslot-map {
>> + *       compatible = "qcom,ice-keyslot-map";
> 
> NAK, there is no such stuff.
> 
> Drivers for undocumented downstream DTS are not allowed.
> 

ACK

This is used to set slot mapping table in DT node. It will be moved
to Trust Zone if current out-of-band key operation is approved. Otherwise,
if virtio block devices implement blk_crypto_ops, this driver is unnecessary.

> ...
> 
>> +
>> +	dev_info(dev, "registered: %u VMs, %u total ICE slots\n",
>> +		 idx, total_slots);
> 
> This does not look like useful printk message. Drivers should be silent
> on success:
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

ACK

> 
> 
> Best regards,
> Krzysztof

