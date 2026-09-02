Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951FA4A5EC2
	for <virtualization@lists.linux.dev>; Wed,  2 Sep 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361451; cv=none; b=TTznkwXVKXWrile9fKH8zELfa1HHQPITKxV5BFE8vRKr2gQ1kGFDVNg0291+eijorSpj59G0QPzkfjFWXi4DW73bTm8ansnBVHLtpwMADkteRjN550CpgMzj9dUihE+XEWHBuXdx5MyS2M4NK1WGM0GsOVidLDqYwaiAzpGkLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361451; c=relaxed/simple;
	bh=wCCHaHjAyebRsmsmEX2icSW1s+oMksjOOy7EFoGCWjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9n7uIqM/4Jf8EmlvTXCVDgo/wczOhdTT3m4jwnfWtvXW7WGSySVtdDwQg10fv0yp85hANBeHwiMJ1AwbWAO1/sNVTNhtk7BDf8+cDP72eOemmbOBoqXUeJ7gboZ8mnfE0w/5WVihmZjFH9vJxnoAbuGdT2TmyexW1QZbViZ/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gslt+rWg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KUPbOthZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gslt+rWg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KUPbOthZ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682DI0jT1873051
	for <virtualization@lists.linux.dev>; Wed, 2 Sep 2026 15:04:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8d/HYLVaYKgSu6VLD4TUXAuT+WMimsoAlFLEDX6rbHM=; b=Gslt+rWgaEkn8Wtt
	/GY4xVCimRHa2DbrI8POvL6E7qeLQdytf4vC+D7M9SyKb63Zk/egQ/aHObhm5XSu
	34V9wJoSKIIdXswfhBcglWSNWtlppU0yMF0W8bzoiG+2wlczpOXtKelwdMeoD7kG
	d2XmgIofGoxkaz/bwRWU2k0qB2J8ejlZxWBqPkI9Ixy6ZmNh3yRWAZ43JOXZ+/Hn
	ORx3Onu4LCsoqeCGG3G6B246sbXK2ZAX9tO4Ur3C7Qn/lcj48kj66sch0Cd5xSB0
	JlKyaBGQHkbbv7QF0r0IxAZU9Hy5IWzu3aVlynpWBl4F4bzz+a15q0OtyyAOOMPc
	y+04jA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh8dq6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 15:04:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-381250979d5so1534790a91.0
        for <virtualization@lists.linux.dev>; Wed, 02 Sep 2026 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788361447; x=1788966247; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8d/HYLVaYKgSu6VLD4TUXAuT+WMimsoAlFLEDX6rbHM=;
        b=KUPbOthZ66G020hkXJlESTsUYkNuPr8m34rVueIBxwlPvUiFGeCLEGk5VfAJswj5qz
         3pxhhfATSzV4VaXHxFwIZh/NzrPJK9StCc2lSGpevImxx0klBIUWAuLjmGscfe6A+Nxk
         Wh36viTctc6OXGo59jsz3/XQWfFFrsqL209EQMdeOcbmlaG2Kd7mGGm41ZwZXS51TZfr
         dxn5vfBG7qNVKvQ63F9aT2xYIb9TNRBpK/0QbV4ZmyQ/XwE3Au7Uzb+Wwg4c49fSEr4D
         DCeKRPPZOVTxbHhc98crrpp2cSNdMOcpRRbZFHm6dZb9CynTUOYdqPNFvWLMA2oYfV4c
         Baiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361447; x=1788966247;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8d/HYLVaYKgSu6VLD4TUXAuT+WMimsoAlFLEDX6rbHM=;
        b=clPIUbQPW6ayPU3D7ROBBEnXcCcfoPlMQXZaHuZvEcR3jKz2gUy6DD08RCic1JAPX+
         JH9IGV9HCnkHJ9wJ7QMg0MCRlao1XsGJCS/sxnF5fzuLSAuXWmx0Clk3cZAlJwDISZIv
         fdQunBbAuZtirY6h3Hl+yUKptCcCLN0RAtGZR+z409biZaG04HE+hhXGc7+XUiGIpyGN
         5Cqx01KZIyBoqj7ebG+re2WXEd9/DM5F9+qQEAbYdgbEUAMwS8VMO3Z2FEDB1OM4ohWn
         MY1gOHlBlPVO/mjLIs0ezCRtEBBZirWLo9Uu3FB4k3X0yjjD8eT6oQCPKbW31X6mJp9m
         f/7Q==
X-Forwarded-Encrypted: i=1; AKwUvByqYmuVhKJTgFMP43oZ+kenpoxByRwcELFGyAo8n0CnJSTHeojWqGMvAHskA26OmKnnlvjhrBe/rqs2X+FG8Q==@lists.linux.dev
X-Gm-Message-State: AFuF++llPuSN7br1Jh4tMsHxZZGgb7ItNJ8wlkybFzpQUOSHYI84RSlP
	p6yOsVAnIJgf0nTlOPi8e3mQe/IeUFMNupEoQlS/xbqbDugEYsS+yOgE4mIvkg/Qc3qHh3GOLyN
	jRARW8zos1qjVKopEnpLNIgNBwfDJaOGFmmX2CW45w0exj12BLu1JQ0TPuEZHPTKbxtc6kQ==
X-Gm-Gg: AYBFou3sQjmplVHStxsJEs15wsT0dV2KRKhSwUB2+AYN6ZFKFcp5oycFu/lE2gRHqjr
	YC6rEOf5SSxwnHXdfE+odyMNX/hhmiCF9kfKBiuvdfHGZ2ohreh/D6QBqRofJNskYuMnKQvqkJQ
	1VNDlEiOAZFWMeuQH+3VstTPytZwxC9NLYAP5z0YxX/c4C9RgxDM9pxjEfhUE5e16hEibLaGjmW
	7ea0t/gHBQtG7IuJzw/bq9nywPv/mZXCmdbPaF3KzaCESvbD166xcD/hnMG+hgSgb6KiibLzBl4
	yoY7laSK0Po+pTsQfuyq5DUWJqzULkceV/gfOViHBG2Ga4UYZwtvcRxjCcHC92j5Rl6pZNvVmZ6
	8cQUl0nOXdRBXW/roJ+zBTFnhOd4QjTnNohBl/K5taGQ/MkwIlE7DbAk72g==
X-Received: by 2002:a17:90b:2ccd:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39aedf77333mr8400147a91.11.1788361446264;
        Wed, 02 Sep 2026 08:04:06 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccd:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-39aedf77333mr8399969a91.11.1788361445459;
        Wed, 02 Sep 2026 08:04:05 -0700 (PDT)
Received: from [10.110.114.54] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079f1f4fsm7552713eec.11.2026.09.02.08.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:04:05 -0700 (PDT)
Message-ID: <d530f962-4fd0-4897-8022-c7335167f450@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:03:57 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] scsi: ufs: ufs-qcom: support ICE keyslot
 partitioning for guest VMs
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
 <20260827160806.1295313-12-linlin.zhang@oss.qualcomm.com>
 <046e4b62-6d25-40fc-baa3-2978eb96eb70@kernel.org>
 <b571ea8a-4434-45e0-958f-20b2f83ced24@oss.qualcomm.com>
 <ff869d8a-85d1-4148-b19d-af3a70fcc904@kernel.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <ff869d8a-85d1-4148-b19d-af3a70fcc904@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1hrNIIE9l5qixf0xmoSfmgazdbIdBFih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfX9LO5cQWWUQ6F
 uGBFz73l9WIiKHp/2qZH0HXpPvqLav2nRsBt0m4Oi9XzA0+H5zUuQbYbPwsl4sESr8RkxgaTBJQ
 Bx54rgncu3JagRpR0P3JgMcxfq6YnP7iHsi4PqSrWXx2HmQqUmmUAnC3TftGZaXaRTxTy7R6RAC
 IIQcNvbSwiw7lP+amNE7fF4toZC2Xu5kAxKs/scVNi5OGcSDJB4CnQBXQaox5jGpkgRZ6fTZNdl
 E7+nLpZGsZdQ3JiCKPMlutZ22bejersGkEA1DD1w46OIcWXsfZAiKMrkLzk0Z2JGxVqu4sKJUzp
 iDYTpFCs1sWl1xGBCmqSX1I6FwMmeqC93wHWlX468l7vSKPyOMAZVPxGhIUTSbtC8VvSIIB0J2Q
 dpC6hB+4OAlcW+Td+jaFUBInGs4imBax65pkNf3OM6gigRg2e55UR4uABgQYQEdqvVRah0CcSTx
 ZbM/xOiYu01fAuN2lCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMyBTYWx0ZWRfX00mfxLPqiP2N
 2ZHRyadsPtiYrCGRGWDINgmYfM4/ndAaUKLOmTcM6bWvbp0wNK6PtQ0gFj0n+aCEPaXw8jsnIU7
 3Qq/0BAsl8NasuESGs7PhUWk9Kc0KXU=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a983ae8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=Vihkso_W4dyqxCYGQKUA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 1hrNIIE9l5qixf0xmoSfmgazdbIdBFih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020133



On 9/1/2026 10:02 PM, Krzysztof Kozlowski wrote:
> On 01/09/2026 12:54, Linlin Zhang wrote:
>>>> +		u32 off, max;
>>>> +
>>>> +		if (of_property_read_u32(child, "qcom,ice-slot-offset", &off) ||
>>>> +		    of_property_read_u32(child, "qcom,max-ice-slots", &max))
>>>
>>> No, there is no such ABI.
>>>
>>
>> ACK
>>
>> This is submitted for visibility. It may be revised in a future version to use
>> a TZ SCM query interface if current out-of-band key operation in the guest is
>> approved.
> 
> Don't submit downstream code for visibility. It just clutters review and
> wastes our time.
> 

ACK, thanks for pointing that out.

> Such code IS NOT ACCEPTED to upstream, thus posting it is absolutely
> pointless.
> 
> Best regards,
> Krzysztof

