Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC4747CA71
	for <virtualization@lists.linux.dev>; Tue,  1 Sep 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259239; cv=none; b=uv5hxWQQdoAtT9wDh83fU9kk9R+1GkXj3TmNJbp7p0vgiQUxJkSGWsLV/1T25V7cGlAphcNHHrbS7VgBb41xGwZRBg8XqTIn8fDLDSZvJ1ax8clouWC1EbkFrOwOWV18D6ZBrFzGoQiIPjJJiPou0jlUtEfAw1c1R0S+rWfa/NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259239; c=relaxed/simple;
	bh=xszAzpPB/8wB2ZU3+7zZIkbSXKAfS6N15bO/2mtZhow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiZpBWTDZvUxM4yo27rRCobVU6BCDjAzcO9/d2+azS3dvV20PgFg1O3RH0Oqr8/WQJ9HgMy5mD23O/8nlfvZYw0aUNRyLha8nfeP3qGUa0G6NGQksAgG30JwEVXAJbgWQIvJbDpxnRoUqhjSmXMNquZ/FJ0MVmL4CC4Y7hWH+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l0Bzk9lI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CmP18XOW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l0Bzk9lI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CmP18XOW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJZpV2323301
	for <virtualization@lists.linux.dev>; Tue, 1 Sep 2026 10:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hxDRBSBRVK3WBdeGvq3gY+7hIJoDgMgpm6vjxtzaRS0=; b=l0Bzk9lIegBfmvRN
	rZKPQjfA6NwTdYst3Dyzpn0f+0GSvY6sIKOx+JcTBR4ed0PrQP+H5Zb1irLgtTcU
	nORQScvNIMQXWOFpa5ayfOkLBjOvp2eYM9VuZ+YdTzFVHXqaWXEYx7STFakNPh3/
	zRfhLWNqULuIuXVg55bj+sL1YbilZo07CK7KDjnNl+hvwtKfKWmeVAawWdT8yMZf
	YnLwTtilfSdCFDPZJPxez4ALEA6R6exAQHrLzkSKfsvM1uWB9Zam4fobq3TjUlF7
	W0GKZAngaXOqeIWsCUioEQPvVEwbGSobv6uXVQ4V2EIMEslocxCxJj307tDZe89H
	jrsafA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7c9wqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 01 Sep 2026 10:40:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0aso1453450a91.0
        for <virtualization@lists.linux.dev>; Tue, 01 Sep 2026 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788259235; x=1788864035; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hxDRBSBRVK3WBdeGvq3gY+7hIJoDgMgpm6vjxtzaRS0=;
        b=CmP18XOWvASXaE6Eiu3UGmVjH5lW8kozN0uyPvmkd3r0WEBbEGAWk2dY5fculKfQ2X
         6MdSortlG023fsBSbZzQXstUiTCzKIYOXWCTpx3+7WxEEunj9IEDx7kHvkNQV0MslDxg
         kkPU6VyisE/X1Mpd5Q3NwHB7s7S9A/QnVEi2LHKIBt5jnA5HVe5M5rTjRrI0bO4vofTM
         TppJ6qzPiBHqGjZDR5h7D5vQmHeDJK28J6gOz+EhMYVFkKIe539qn0SfArDQixYKOvvX
         kNBzU8qlc/GJ9WGHrZ9/N6me0qWvhXEjaeKFc2sre8o8KibILTa07Hsp7Fu1x/eIVK+G
         lHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788259235; x=1788864035;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxDRBSBRVK3WBdeGvq3gY+7hIJoDgMgpm6vjxtzaRS0=;
        b=OdDsY/IjbxVPl/9eHPLPCf2kb/GxW1cw0aN9Gxw3QK3l+sjrK28xdtpQ0YYLOwBS8E
         An85q/WJwVpxkgfQlNRdBwhU7vTThqD70GpvqpuOt3P4vAiyQkmgtguN7mhVBF9ucYLy
         rWi3JBEqoBKfwmlF+pbbF5Y1PN5LuvfCRs9GSUYp983g9zYAlgNyZZTTrC6zcWw2OviE
         cynQgA/73NUR1jTs3iZQjRflc6ZEiYX9wpM8XharxeKak/A5YIqFBDwxOPNtiFieyj9Z
         CxNwV0tiXimFGwAX+H8Pon0P64WNL3YsNKToPZ/PCehOh1HJWjxNIPCN5MgJIk1SDMFK
         +x5g==
X-Forwarded-Encrypted: i=1; AKwUvBwNRgXuWw5C6UtkAPzIlZfRDd+0A636mzFwA2F+csN49pWwVgB6uaOcnVBefkIK4ZfLguaVHv6DRmXPqXG5HA==@lists.linux.dev
X-Gm-Message-State: AFuF++kBjy1DfDUIUttYYNa/r1RrtWcbybPKnAluu2fXut91bnpCuvtC
	/2mzJwzioYXrKRAsgIjxrDc22N0CMWiciVzuJNqJP0pdr+fLscmesgWYUafBTmkCk5S7ovb/upx
	rd+J5gEn49CjXGhi8WOoVVvVNKRGYgoXmtu8gYgkmcu1XWmxAC4Tt0O7sYXlHfVSoyzajMg==
X-Gm-Gg: AYBFou0gmMbiQfW51ai8SpYdJ5gaRRjoHTT6xDi4EZHzwG8dMv18EW5s8FVNpynfqvE
	0FBbKJSidby7WKTX/wG6Ttc00DxlTY3UEPxRALw5LKpNbIxHxVpmISwA0zunzKnIqSh5x2KtzZR
	KYeJdPkDDdWuIQWdEX3rUBPfCl9UgI0YkcR+jHs86cWjBRyxTRFVfr/nRZfBYsDsDsnvBDsTx0D
	iCmWvPE22f92DeTH3UlOm2q9+HXh4atV3zqbcivzkROrfjsPtKh2L/MV/eGLVypUFg28Vtg/xaP
	vAsQkJFts4awgTIRmpRHuUkCdR7k/cNm0NmDbbBm1bW6gaiNiAZcMDu/rDZRy+0LQ7tPKofcQq/
	fm8nkpFNlUR6Swz58HZWxzxXNbvzYA5afan8boT3qG1a85l15uHgu5Bbf
X-Received: by 2002:a17:90b:584f:b0:398:9beb:a2b7 with SMTP id 98e67ed59e1d1-3990f90df1bmr4602629a91.25.1788259235147;
        Tue, 01 Sep 2026 03:40:35 -0700 (PDT)
X-Received: by 2002:a17:90b:584f:b0:398:9beb:a2b7 with SMTP id 98e67ed59e1d1-3990f90df1bmr4602571a91.25.1788259234570;
        Tue, 01 Sep 2026 03:40:34 -0700 (PDT)
Received: from [10.110.34.210] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30690555eec.4.2026.09.01.03.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 03:40:33 -0700 (PDT)
Message-ID: <db1488a2-deb8-461d-b77d-849da2783edb@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 18:40:26 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] dt-bindings: soc: qcom: add binding for
 qcom,crypto-virt
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
 <20260827160806.1295313-5-linlin.zhang@oss.qualcomm.com>
 <bf36b0b7-d6c3-4731-b00c-c3a4c02ffc76@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <bf36b0b7-d6c3-4731-b00c-c3a4c02ffc76@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OcyoyBTY c=1 sm=1 tr=0 ts=6a96aba3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=s59Ba9DYA-YjRSie7ucA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: xvGD0Tgm4nRFWEYohUtplCiqvkgwJfpm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5NCBTYWx0ZWRfX7gR12uxvYBV7
 dTnbPKEAB+XRTI9rZHjS4u/8vmHffxhCpbpuF/L4Mytr5s6nHP51aJIirsIRC79ag5dXzoPCz8k
 YdhUgCfgcBZXhy2vjlB583p1DpRAFLs=
X-Proofpoint-GUID: xvGD0Tgm4nRFWEYohUtplCiqvkgwJfpm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5NCBTYWx0ZWRfX86Ksp5P5uhT0
 /tM+h1ZHfNjKITaaAF7G5be0vozrPF1a7jo6wIsrY0XWi1hv/XYs3qAs66gYfagXovEFvieHq95
 FMfVJR8UUloTvu2V1lw7wLOUcMO/f+IcL98HygUyPsv/U0lQzqm3ZJNy19r9/SpY80mQetiYuz+
 DPmtTpauaoP2R9u8rX8dMyuIjGSHKJ+PAVXjTVVZZw8yqmHI0I7IRyvT8rh9MVbcEh1g9ozyI5u
 9dSNNMmLPCOQa6gUvWGQcVuk+P1HE2jfyCNGuMrgVCP2WAYGde6FgKNoEzy8BlZZWHayWpcP+PI
 ANY30mYe7+37JNEmrzTAozr2flc7Mu0JoEOXRcd36LPWtbs7g6/ayzWKX4XyLwY57PmJDApnAkm
 lhzBDFXgERfYDhh7+UC+pLoJQ+xzYmU2+9ktYy7u8EYu7yKKJKASVdYxk6hwLaNpfQ1LNm0OgZJ
 XPdyHwYNbsHvwmueobQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010094



On 8/31/2026 3:01 PM, Krzysztof Kozlowski wrote:
> On 27/08/2026 18:07, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> Document the device tree binding for the Qualcomm GVM crypto-virt node,
>> which provides the wrapped-key buffer size needed by the QCOM_CRYPTO_VIRT
>> driver to perform hardware-wrapped-key SCM operations backing virtio_blk's
>> inline crypto layer.
>>
>> The host does not report this size over virtio, so it is supplied via DT
>> through the optional qcom,wrapped-key-size property.
>>
>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> 
> Your Git does not look like properly configured.

ACK

> 
>> ---
>>  .../bindings/soc/qcom/qcom,crypto-virt.yaml   | 39 +++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
>> new file mode 100644
>> index 000000000000..5eb204f29762
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,crypto-virt.yaml
>> @@ -0,0 +1,39 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/qcom/qcom,crypto-virt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: QCOM GVM Crypto Virt driver
> 
> We do not take bindings for drivers. Follow standard rules for bindings,
> e.g. read DTS101 slides.
> 
Thanks for your comments!

I understand the concern about introducing a DT binding for a software-only
driver. The motivation behind this binding is to provide vendor-specific
wrapped-key information to the guest, since the guest cannot discover it
directly from the ICE hardware.

I provided more details in my reply on the previous patch and in the cover
letter. If current out-of-band key operation handling is approved, I'll
revisit the design and consider whether there is a more appropriate mechanism
that does not require a DT binding, maybe move the slot mapping table to
Trust Zone, Linux kernel only need gets them via SMC request, then don't need
dt-bindings change.

> Also:
> drop second/last, redundant "binding for". The "dt-bindings" prefix is
> already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> Just describe the hardware (not drivers)

ACK
> 
> 
> Best regards,
> Krzysztof

