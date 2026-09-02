Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB794A4847
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361302; cv=none; b=ExRdJCw1DheNX2kSFJxLX0gLI6oigHuHNzdPnS0pvQTtUhVGBv+GlXdPuRoq3n3FdlJ+UhYvuWJSL2JmYyrpQUYCwxFV8Y1Dh+HohDVsu2iQ3r8Q4V/uKL2z7r9BAbIFX0vQChPjM9PZgGCQnL1W74h+5UPpLM2e+V5J7OT2FUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361302; c=relaxed/simple;
	bh=bZG08AocPFbLDEUxFFmfC5QIhC/V/PzFbcuqhbde558=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8yO3JykNo3Lj75PfKLh6OOm9h8t9g68qwsw3l5g/mKd/M52eLPVTXbiuI6QQ4e1Jkt1ZO5gi2nLNvEzIjzWlaC/UECYXxW9bVdWV1/AaQe5KN2P9tqzV8+eXp5pJgr8nDNCZhm1PPyKWygZ7eqpuvgDR6X9EQSbP2hPr09Vrfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mnL98ItZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G5exCBwC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mnL98ItZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G5exCBwC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CR7XQ1647705
	for <virtualization@lists.linux.dev>; Wed, 2 Sep 2026 15:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1pxn+AJDlmps3CqVjI1Bkvkq9NQfvaIy9iIccLAqBlY=; b=mnL98ItZ7aKWDYr1
	JcN9+siYyUBeWKF6y12pt7ags+1xAewv/xSGAw8so9f3U229OKlYvt7Rgu0awVl4
	KrFasiQRvYbckBUItDK/Moq5I1OrOLqgxhk2LUSJ5rVzdOI+cGw+JW4/4Z36pruz
	1tg0S1DbhJ4Sy9DX92Tmg52IT3bRPw0TYZPmfeW4k2XbyxxNvkWtxVwWhlQOwlhx
	qKWGs3ZVrb+Px9rL05kZvul41VgocMSQOk1N/CviHSrxjUJj7IVmeckxjSkN6F7L
	Euy0gdmwf+AsRbcez7Jv26cnremQE+71TdA+HV5C6jEk2xGmjyR/Nn1ZlPO2QfuW
	kLLGAw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gejv88uah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 15:01:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso1184924a12.1
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788361293; x=1788966093; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pxn+AJDlmps3CqVjI1Bkvkq9NQfvaIy9iIccLAqBlY=;
        b=G5exCBwCgGxQGEvukX4iuVbLQ71vfoyD7CK1lx5JY+eVSkYtRRgmTnDKOWV7WqOz0M
         NZ3sOVd4L7q6kBO3iO2Xrc8YDR48dHfLMgnQgrc+zAwxGnQ7gF09CNCJXEjQC0LBq404
         P/0/DMDq813cM3iyB0fJevcapWdFfbSX480YbwiuR3im3PKfijMFqfACyYHiLDcafuh2
         TXEQhPqcNoAB5jMmt83OTCuJkY9kgPk/mJHLhL7V4TaNnVX5+Scaz9NQ9L38e0/V/4JC
         4WmnDMY6cQBqFipjbVNqd5jDDiPRMExLBtwvMcS9Iabzt619Nkrdxe6Zn0QHepViZUHe
         Vq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361293; x=1788966093;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pxn+AJDlmps3CqVjI1Bkvkq9NQfvaIy9iIccLAqBlY=;
        b=MBidAaHFtPyyA5x9rupRwVjXLOYrXk03BZzV+mzXnXCXfjVqtc7Qft5qnfd4ZwE+Wq
         t1D35y65iHHjGXKIa+xnStT1ng6AnC6eTe+iO5Hcoli8p6cP8mu7MTcsRfAVp97BLYYV
         kEBf1XcdqgrdFFdimZZSCzKru44WO+MlaWXnLsYUmxRO5E6VDY0JWjRHo0Sh9Ljf7s4C
         W0lqFAFciYtZD4NVuQcByAdE8uyaSS2QtVROaXxrwFMYN591+7A7BXbonuzcZJTewTdE
         2MF1UVZ6/umTo7O3XZa10haIzxYpeN12LDncX53WlWOA18/jUm7StQtaL3L5vInO0xY6
         SJFQ==
X-Forwarded-Encrypted: i=1; AKwUvByrxLV+95KEYJklhiULux+KDZBCCSYJ9KmqDZ5xbkeqY34whM1CmgBR22oqrZg9Xc+XrK27nezvFm/OsXQ+Dg==@lists.linux.dev
X-Gm-Message-State: AFuF++nOTWcyaEo6xw4o8xETFSjKQaJrhL8fqTv7GmrJgn2sS6F/gj6x
	pXP8jLAyJ9RlieoLC3E3yZfsI+jBR6z2A5XHLYTyJwyIIqUW0tJkLCHPEpS5T1Lzl6wjmP6fRrL
	X6sdDlkNNmE5eawwjqpz2HbnpzRMD7YzMO/ZMd5p2ObSRUxoeEhXqL9yEKbkkcIgQQgHemQ==
X-Gm-Gg: AYBFou2lS6Kqof/HtjlDnKkhW6DLTZkUqDW6dujRVA00yvgSDj+xZU6gU3eLIKOAhQB
	R2UrXnccpGwUvyoc9xxF7F7T354OQW4+boajJCgt5wenRcaCKt7Pp5OdNvKpZKoF/eEH6yEQZ5h
	opvi0RPsl+lxvqq1UCayLlLqP9SZTdy86cVcryxHVv+5BaKt3ATX0Qque7IILSRC7SGcV+S1JeL
	wUXdDAL66BehWO1rh5D5tr7FgRFt1w/5tSxv3Lviq/0TLai17BVOUOeP4E/uQHk0KVLepyv8aCn
	+2ZMt93GxnF4mo/VwopInChbDmc41sNEjYKjcAb/EQEHtq3SW7Br6R8WaZY2n5eBdjHvjN+3ftU
	a4MzvAIKxwgnZ1WdkrCv12Pihqw79wctSkEZuIV0zo1UCWNpe/5YYweUEVA==
X-Received: by 2002:a17:90a:e7c9:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39aee219f45mr7642558a91.17.1788361291843;
        Wed, 02 Sep 2026 08:01:31 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c9:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39aee219f45mr7642344a91.17.1788361290870;
        Wed, 02 Sep 2026 08:01:30 -0700 (PDT)
Received: from [10.110.114.54] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07c02203sm8484464eec.31.2026.09.02.08.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:01:30 -0700 (PDT)
Message-ID: <c5aaea57-c9c4-44ca-9bd5-7f09175637b3@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:01:22 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/11] soc: qcom: add crypto_virt backend for
 virtio-blk inline crypto
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
 <20260827160806.1295313-3-linlin.zhang@oss.qualcomm.com>
 <f5915133-ffac-4777-b7d9-cf38ba163d43@kernel.org>
 <03097984-fded-477e-82b6-f9b31fd2f1d3@oss.qualcomm.com>
 <38389106-9609-4ec4-bc83-3d1b7fac3698@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <38389106-9609-4ec4-bc83-3d1b7fac3698@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VOaa-Jqvrd53uSL4Va3085wAaZu722uT
X-Authority-Analysis: v=2.4 cv=L+wtheT8 c=1 sm=1 tr=0 ts=6a983a4d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-WgfA_H36cW_bsA5Db8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfXzyYy88PixFsI
 0n0XmQg+7kAzO1zt5G5LB6EaL9h08n2uayGWowVaD/P2zyVv/ao9zOmV3SIbwkRohaBerBeErza
 MM3wGbpAHDGwn04oUQJh8dFMHKZ0IKpaaTKua5bqK6s7oGrvZDZq7N7LSryaQ2zZvBdUw0/XgbS
 bC7a3P7e6shrUB6kuKD7i7EXeSkux+uDzr6O7TvAT+AdSCEj+xM3Ro+HkhyLQ1WTr1IDPzkVqc4
 YteJdu3ghW5Gch1J8Ch/cytScHuKxLY2JXaIBKwBzT7cajS3wUns58Qx8cock4DckxP7qkvU9m/
 PKXyVRK5btQIClC/HRUGH10wi4YruL0PPx0bGXP9jK+IUGtNACaOedRKxXn8Oght2p6dN/vwR2v
 bUXGnBINJlNzQPomXBvbYdvQ9Opmpiyrp6XRzStX/oBE/GpNt9GwEJAP5efZ2/ZUIizWcp6p6IO
 51zZtLnFHN94MyqytCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfXyhoJsYRqZ6dv
 a92VWsBIbRdfi0UCIKruJlXC8S7LIFbUAyBRnQUHqtgGZfS7FMPAF2j7ASyXVfMiE7/17ni9On9
 dudx7ypfEKCGRJrpOYQ4WpzTPU5ff7A=
X-Proofpoint-ORIG-GUID: VOaa-Jqvrd53uSL4Va3085wAaZu722uT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020133



On 9/1/2026 9:58 PM, Krzysztof Kozlowski wrote:
> On 01/09/2026 11:39, Linlin Zhang wrote:
>>
>>
>> On 8/31/2026 2:56 PM, Krzysztof Kozlowski wrote:
>>> On 27/08/2026 18:07, Linlin Zhang wrote:
>>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>>
>>>> In a Qualcomm GVM environment the ICE hardware is controlled by the
>>>
>>> What is GVM?
> 
> There is no such TLA (git grep).
> 
> Maybe you meant guest in a virtual machine? Don't use some qcom-specific
> TLA.
> 

ACK
> 
>>>
>>
>> GVM means Guest Virtual Machine. This is designed for the virtualization
>> platform.
>>
>>>> host, GVM has no direct access to it. So, key operation in GVM is
>>>> done through SCM calls rather than direct register access. In this
>>>> way the access to ICE registers are offloaded to Trust Zone.
>>>>
>>>> Add QCOM_CRYPTO_VIRT, which implements struct virtblk_crypto_variant_ops
>>>> for the virtio_blk_crypto_ext dispatch layer. It maps keyslot
>>>> program/evict to qcom_scm_ice_set_key() and
>>>> qcom_scm_ice_invalidate_key(), and software-secret derivation to
>>>> qcom_scm_derive_sw_secret().
>>>>
>>>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>>>> ---
>>>>  drivers/soc/qcom/Kconfig       | 12 +++++
>>>>  drivers/soc/qcom/Makefile      |  1 +
>>>>  drivers/soc/qcom/crypto_virt.c | 89 ++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 102 insertions(+)
>>>>  create mode 100644 drivers/soc/qcom/crypto_virt.c
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index 2b524154d9fb..6c632d114d45 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>> +++ b/drivers/soc/qcom/Kconfig
>>>> @@ -298,6 +298,18 @@ config QCOM_INLINE_CRYPTO_ENGINE
>>>>  	tristate
>>>>  	select QCOM_SCM
>>>>  
>>>> +config QCOM_CRYPTO_VIRT
>>>> +	tristate "Qualcomm Technologies, Inc. Crypto Virt driver"
>>>> +	depends on VIRTBLK_CRYPTO_VIRTUALIZATION
>>>> +	depends on QCOM_SCM
>>>> +	default VIRTBLK_CRYPTO_VIRTUALIZATION if ARCH_QCOM
>>>> +	help
>>>> +	  GVM-side hardware-wrapped-key SCM operations exposed to
>>>> +	  virtio_blk's inline crypto layer: per-slot key programming and
>>>> +	  eviction, and key derive/generate/prepare/import.
>>>> +	  Say Y here to compile the driver as a part of kernel or M to compile
>>>> +	  as a module.
>>>> +
>>>>  config QCOM_KRYO_L2_ACCESSORS
>>>>  	bool
>>>>  	depends on ARM64
>>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>>> index 798643be3590..6d4b7546d1fb 100644
>>>> --- a/drivers/soc/qcom/Makefile
>>>> +++ b/drivers/soc/qcom/Makefile
>>>> @@ -39,5 +39,6 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>>>>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>>>>  qcom_ice-objs			+= ice.o
>>>>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
>>>> +obj-$(CONFIG_QCOM_CRYPTO_VIRT)	+= crypto_virt.o
>>>>  obj-$(CONFIG_QCOM_PBS) +=	qcom-pbs.o
>>>>  obj-$(CONFIG_QCOM_UBWC_CONFIG) += ubwc_config.o
>>>> diff --git a/drivers/soc/qcom/crypto_virt.c b/drivers/soc/qcom/crypto_virt.c
>>>> new file mode 100644
>>>> index 000000000000..4ee2a36af6c1
>>>> --- /dev/null
>>>> +++ b/drivers/soc/qcom/crypto_virt.c
>>>> @@ -0,0 +1,89 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/types.h>
>>>> +#include <linux/blk-crypto.h>
>>>> +#include <linux/virtio_blk_crypto_ext.h>
>>>> +#include <linux/firmware/qcom/qcom_scm.h>
>>>> +
>>>> +static int crypto_virt_program_key(const struct blk_crypto_key *key,
>>>> +				   unsigned int slot)
>>>> +{
>>>> +	u32 dus_512_units;
>>>> +	int ret;
>>>> +
>>>> +	if (!key || !key->size) {
>>>> +		pr_err("%s: invalid key\n", __func__);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* Only AES-256-XTS has been tested so far. */
>>>> +	if (key->crypto_cfg.crypto_mode !=
>>>> +	    BLK_ENCRYPTION_MODE_AES_256_XTS) {
>>>> +		pr_err_ratelimited("Unsupported crypto mode: %d\n",
>>>> +				    key->crypto_cfg.crypto_mode);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	/* qcom_scm_ice_set_key()'s data_unit_size is expressed in 512-byte units */
>>>> +	dus_512_units = key->crypto_cfg.data_unit_size / 512;
>>>> +
>>>> +	ret = qcom_scm_ice_set_key(slot, key->bytes, key->size,
>>>> +		QCOM_SCM_ICE_CIPHER_AES_256_XTS, dus_512_units);
>>>> +	if (ret)
>>>> +		pr_err("%s: slot=%u ret=%d\n", __func__, slot, ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int crypto_virt_invalidate_key(unsigned int slot)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = qcom_scm_ice_invalidate_key(slot);
>>>> +	if (ret)
>>>> +		pr_err("%s: slot=%u ret=%d\n", __func__, slot, ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int crypto_virt_derive_sw_secret_key(const u8 *eph_key, size_t eph_key_size,
>>>> +					    u8 sw_secret[BLK_CRYPTO_SW_SECRET_SIZE])
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = qcom_scm_derive_sw_secret(eph_key, eph_key_size,
>>>> +					sw_secret, BLK_CRYPTO_SW_SECRET_SIZE);
>>>> +	if (ret == -EIO || ret == -EINVAL)
>>>> +		ret = -EBADMSG; /* probably invalid key */
>>>> +
>>>> +	if (ret)
>>>> +		pr_err("%s: ret=%d\n", __func__, ret);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static struct virtblk_crypto_variant_ops virtblk_crypto_qcom_vops = {
>>>
>>> Why is a crypto-handling code in drivers/soc/?
>>>
>>
>> This driver is a Qualcomm vendor-specific driver, plays the similar role in the
> 
> Not really, there is nothing vendor specific here. Look at this code.
> 

crypto_virt_program_key calls the interface from qcom_scm driver. Similar to
crypto_virt_invalidate_key and crypto_virt_derive_sw_secret_key.

>> guest, like the ice driver in the host. so I place it in drivers/soc/.
>>
>>>> +	.owner = THIS_MODULE,
>>>> +	.program_key = crypto_virt_program_key,
>>>> +	.evict_key = crypto_virt_invalidate_key,
>>>> +	.derive_sw_secret_key = crypto_virt_derive_sw_secret_key,
>>>> +};
>>>> +
>>>> +static int __init crypto_virt_init(void)
>>>> +{
>>>> +	virtblk_set_crypto_ops(&virtblk_crypto_qcom_vops);
>>>> +	return 0;
>>>> +}
>>>> +module_init(crypto_virt_init);
>>>> +
>>>> +#if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
>>>> +static void __exit crypto_virt_exit(void)
>>>> +{
>>>> +	virtblk_set_crypto_ops(NULL);
>>>> +}
>>>> +module_exit(crypto_virt_exit);
>>>> +#endif
>>>
>>> How do you instantiate this driver exactly?
>>>
>>
>> This driver is not instantiated per device. It acts as a provider of
>> Qualcomm vendor-specific inline crypto operations, which is based on
>> qcom_scm driver, and registers a global virtblk_crypto_ops instance
>> during module initialization. So that, each blk_crypto_ll_ops from
>> virtio block driver in common kernel can be sent via qcom_smc driver.
> 
> 
> If it is not instantiated, then it is dead code. Drop all this. Or read
> my message again very carefully instead of replying with whatever copy
> of commit msg. I did not ask what is this driver about. I did not ask
> what it is providing. I asked how do you instantiate it or clarifying -
> how do you load and run this code in final system.
> 

I agree this does not fit well with the usual Linux driver model, since
there is no device instance, probe path, or explicit lifetime
relationship between virtio-blk and the crypto_virt backend.

Given that, I think the current global registration approach is difficult
to justify upstream and I will revisit the design.

> This is just dead/unused code, straight from downstream.
> 
> NAK.
> 
> 
> Best regards,
> Krzysztof

