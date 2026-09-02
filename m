Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1855377EDC
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363225; cv=none; b=lBpqheZt07VsHQlWZGUJ+D8Mcvjtu+9tvoP1jjKjfon2ck6UUu6oSv3kPEMZCr6mxVMUeHSqZ25c0sl4eqZQhXr46chd5/CIW7wthp5SAQ9bLPfJOIx0nLOwe62O0xjg1yTiV9vk0hezJfkSBl0zn2kefEOPHlODOLliZYDf+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363225; c=relaxed/simple;
	bh=6lYF9KV2HEwLFq6+al6aDkTRtGMquGYtFJdFYnQXEN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HijaY3vX0uG3Iz75pDw+Tkqxrwp3gXAHD91ZqdJukFOZtr6Eji0PMPoOirQ2vM5MPCfuNYaVyqXL+YAdUwXzVy4z+Hy3BpQQnGyDf60S3RgcIB+vCVV8kcXjtHNFuOAC5cp88RGZ8OvcmKbvQYpRqERQmjqtkRWt+2QVtjdA2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GE5dYC28; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=USGgLulW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GE5dYC28";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="USGgLulW"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682D1ttq947699
	for <virtualization@lists.linux.dev>; Wed, 2 Sep 2026 15:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rEUZ3PVE55ql740l9KlzWi1uLalDgnols2pTFF/fh60=; b=GE5dYC28o04T50C0
	MXh94TFSKPDeiSYrFJ1HggyWYY2E7z2bj12OGdQ9WZVTbNggrcxgO57Nb2usJh1o
	N/1ujNarxL4hmJeNoiMB1634vamDrENqIR30vnWvna+bPUUs4gKUVQr3Wjphgjpv
	+9ICOfwtZ4C7UREApQ0jio9n0N9EXHu/Q9Em9LqQKjIBun/kwmJv1vV1LjokUGjt
	uPtIX0yx9J35OEPpdfGMHgPybL7JNDjhVQlpX5wzKxOVMY7bV2bfY67irjMEt2xS
	2le7WpLIxdWm589t5rXlUrwQTiJF2g/qzPJUdrCIHZUnkR7kSg8fMNtg+wqdpws/
	0mNTUQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemb00k7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 15:33:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc39363cc88so1039155a12.0
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788363222; x=1788968022; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rEUZ3PVE55ql740l9KlzWi1uLalDgnols2pTFF/fh60=;
        b=USGgLulWIRWR+V6RwiwQsRcQA3Wco0A6eGVBcR82RS45s7c4cA15Ph/+StUXXYPkJI
         OoPw3auFSiJwcg/EZo3rNFabPdlQfDkMK1rId+JCW2xBYqST/erCoKNs/OldnlsTMoA9
         yphMsUUrJBk8AX3j4OeT0OAQkX4YTU1O25WbM8HGIqa8EVddNTLBw09/3/XoovGn/xxX
         wLzJuXQ1w14X8DgOblJKnztJCtsHJi7xskmj1ZkExYA/9FXd+2DKZR5UQsTdtVZVvY0Z
         EmaszGZ3jwgPyEBamaEtVBeZq80HiA74vtTwVsSLkdxEqayR3H6RrIpBh65vJvCipXUe
         y/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363222; x=1788968022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rEUZ3PVE55ql740l9KlzWi1uLalDgnols2pTFF/fh60=;
        b=cYmfEgH/78oqG12+g9u9wFwK0TR6KaHdDnAIe+8xFj362Y6yJrnTaAPIflniklKvUy
         J5OQk0bXcy4zUmNkXflCycltGTLULH9z5mRon1390oPP2kLc3AlJTx9wHA0FGSITr+6F
         R2YE4aJMATDhNZT3p4ct3QIht4VqbocNw0ELs3fZN5vJXrticjQkkPd8jUDATGvo9hDs
         /sAUdbiwUTHTujcXli1UvGM4zevNeCjzCAXObKL0zGEmHNgj5WXutcD3mco5Q3SDM+lz
         dpTNVkA/LSsDuS2seAdUrKmjeQt/lvlr87KsmXEWpNX6HKFO1PXY54bD5ZA6x7aOm84Y
         pvOA==
X-Forwarded-Encrypted: i=1; AKwUvBwDP5jIWMsm2lKrm0AjvkHm0QW3Zfbw9ugxA8rd9JiC0LT8EP+/MTeQSo5tXU0cAEZpdocqe8YGW4glr6bjUw==@lists.linux.dev
X-Gm-Message-State: AFuF++kNIhyO5D9FKyblpzEmiEWtQw7ruwIrSs/g4ihuhUGccRUIs1yg
	DhUtB1SYfTaH7oun5OUzLZIFaGu0HXDH6/ZV8+hXsfeYWFpWhDFh0W5vB21l7f58UI/dwbDDK7p
	OCt9mJaJf06iq42thTQZZAYizdsDeK38Bil6iQYHiIsj8CbaU28pwGTqV4sq7OGjm8qsP5g==
X-Gm-Gg: AR+sD11k3ZwWFXemG0ov2iD+aTr6We5NAm+mm8HZ+62sFTtyCiPH93lN790N3EgNw0K
	cfwgGre4MdA2wjYev7NcUSBqBVTt4Gt9+SxlRKrKwWxtdK+sDqLOgogX1B8JhPHk4q5+9ZdyeoS
	TNb42hPeymGAC6DyVVM2X+OK7augKTScCJ8HP6+Z2fbicXg6Z8qLL8QSVT5icVtBHs1EqvnI3Er
	BrAnTdvi4V3shEVL7KLudhWUT8X7PROklhKJ6bBiBvRKJEWULZPqUZL1qlUEq6SIT+7KX+ObnCt
	+Dh3zireP282ZqKmKnbP5v7R5u2L6qgfDIO+0thnNwp3VNIS8f3VWi33wsU1nCevBTJMey2MJup
	+Q4mjZ0mg4keqUnz95FL+CFSxUMVtUjSBUSzn4FkXSqyI2KmZZSywR6pEjQ==
X-Received: by 2002:a05:6a20:9f43:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3d9aecf72e3mr9896584637.24.1788363222095;
        Wed, 02 Sep 2026 08:33:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f43:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3d9aecf72e3mr9896470637.24.1788363221571;
        Wed, 02 Sep 2026 08:33:41 -0700 (PDT)
Received: from [10.110.114.54] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079ee369sm7964033eec.7.2026.09.02.08.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:33:41 -0700 (PDT)
Message-ID: <418e2285-bb95-42cc-8543-bd540df9d0b5@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:33:33 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] soc: qcom: crypto_virt: add support for create,
 prepare and import keys
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
 <20260827160806.1295313-4-linlin.zhang@oss.qualcomm.com>
 <4594e3db-a8e3-4f8d-95c2-a4edcbc8ca7c@kernel.org>
 <40156974-6637-49b7-8629-11e7d0d4e55d@oss.qualcomm.com>
 <650ac172-312f-43a3-ab5f-82318796472d@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <650ac172-312f-43a3-ab5f-82318796472d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: B79K1DZ01QX90cZ6Pdwc6mWu0Gx0chnD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfXyw0ZdvdaPW2k
 4Cj+XxFapEEJ7DsBkE1yLv92u4HGKlsxLwKrnU9zgKcvbRM+atquBkyFNxH9lSUP2IhkRnvut1c
 RW3YNNs+JwCB5Jfw44j0L0XvR09NbkHT8jhfo9xLwmtI4+Uo8YyXZa2KYW+ZJzLSoPq+sU1H0tk
 lP+TVynx2BjWI3tvoTP9pPsuYCg+s+YrvdrCMdH5VTYuxClpb+ysTPikJMWtYrmJPdSsFXEJhPu
 AQyze45hcoYOdwFDOe1Gqslg8/knhqn6nRTvlh86FKL/gT4cz49y1r8pOFV2z3mUmwunX9foVr7
 CCxTVBbzEwLHZ97pWbnI3EigrzvMbo5brspP5hCXe1SmjaBfqRHNX/UorMvr47CbzWuVA+6i3+u
 lzhE52o/7OpsUskwrF8fmfnV8gzZ6l/WzsYhBi7fISdMdtdQCYgurcUfko57iFDYJ8yEkY/ggTI
 N3rY9l+gVhZH1AXDI/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzNiBTYWx0ZWRfX9XZtgfjrDsqU
 aT6qD0L1+CfkddUv9Vw9CsKAyL/DNOpj+/btr2oIiEK9DPXHvtFixBSFeBg316hP/JkMet6QUiT
 F1dH8DFweb6PUW8tVe4OyT/ehrpjjb8=
X-Authority-Analysis: v=2.4 cv=EuPiaycA c=1 sm=1 tr=0 ts=6a9841d6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7gRScLy_F1O9BZcavHAA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: B79K1DZ01QX90cZ6Pdwc6mWu0Gx0chnD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020136



On 9/1/2026 10:01 PM, Krzysztof Kozlowski wrote:
> On 01/09/2026 12:31, Linlin Zhang wrote:
>>
>>
>> On 8/31/2026 2:58 PM, Krzysztof Kozlowski wrote:
>>> On 27/08/2026 18:07, Linlin Zhang wrote:
>>>> +static void crypto_virt_remove(struct platform_device *pdev)
>>>> +{
>>>> +	virtblk_set_crypto_ops(NULL);
>>>> +}
>>>> +
>>>> +static const struct of_device_id crypto_virt_of_match[] = {
>>>> +	{ .compatible = "qcom,crypto-virt" },
>>>
>>> Undocumented ABI, also not really allowed. We don't take bindings for
>>> drivers.
>>>
>>
>> The dt-binding document is included in another patch in this series.
> 
> And what does the submitting patches document ask you?
> 
> 
>> The concern about introducing a DT binding for a software-only driver.
>> The underlying problem I am trying to solve is how to communicate the
>> wrapped-key size to the guest.
> 
> I am not asking about your problem. Can you please stop answering to
> actual problems with irrelevant other aspects?
> 
> You cannot have DT for a driver.

ACK

I'll drop the DT binding and this patch, and look for an alternative
mechanism to convey the wrapped-key size and key relevant requests.

> 
> That's it, please read DTS101 slides.
> 
> 
>>
>> Because the guest has no access to the ICE hardware, it cannot get
>> the key size by reading the ICE hardware directly. In the other hand,
>> the wrapped key size may vary across ICE versions, it's infeasible
>> to have a fixed wrapped key size in the code. Additionally, wrapped
>> key size is vendor-specific, it's nor proper to pass it via virtio.
>>
>> As an experiment, I used a DT property to set this wrapped key and
>> wanted to get feedback on whether this is a reasonable approach.
>>
>> Is there a preferred mechanism for handling this kind of vendor-specific
>> configuration, or are there similar examples elsewhere in the kernel
>> that I should follow?
> 
> Not DT. Use whatever other mechanism kernel provides.
> 
> 
>>
>>>> +	{ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, crypto_virt_of_match);
>>>> +
>>>> +static struct platform_driver crypto_virt_driver = {
>>>> +	.probe = crypto_virt_probe,
>>>> +	.remove = crypto_virt_remove,
>>>> +	.driver = {
>>>> +		.name = "crypto_virt",
>>>> +		.of_match_table = crypto_virt_of_match,
>>>> +	},
>>>> +};
>>>> +
>>>> +static int __init crypto_virt_init(void)
>>>> +{
>>>> +	return platform_driver_register(&crypto_virt_driver);
>>>> +}
>>>>  module_init(crypto_virt_init);
>>>>  
>>>>  #if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
>>>>  static void __exit crypto_virt_exit(void)
>>>>  {
>>>> -	virtblk_set_crypto_ops(NULL);
>>>> +	platform_driver_unregister(&crypto_virt_driver);
>>>
>>> You just added this line, so previous code was simply wrong?
>> No. In previous patch, virtblk_set_crypto_ops is called in
>> crypto_virt_init and crypto_virt_exit. This patch moves the caller
>> to the driver probe and remove APIs.
> 
> Heh?
> 
> Let's look at your previous patch:
> 
> +#if IS_MODULE(CONFIG_QCOM_CRYPTO_VIRT)
> +static void __exit crypto_virt_exit(void)
> +{
> +	virtblk_set_crypto_ops(NULL);
> +}
> +module_exit(crypto_virt_exit);
> +#endif
> 
> And you claim that you did not add this line?
> 
> Do you understand how diff format works?
> 
> Best regards,
> Krzysztof

