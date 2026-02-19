Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F7A33970F
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493404; cv=none; b=WRCtygO43FfAGyNJBvzPNQdt10p7fcWi35DXwz0hsLk2rc7CltgM+pQpGJzkVrcBgV126WQo59Vh7e0d/sttl8gE/bh7QgzQ/swzNhdTdvjFTQ/KRUmpKWDhJZulb9P/IYPIDCFurtdSpTUErs4Wp1vxooNcdLxxfFUv1rwjaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493404; c=relaxed/simple;
	bh=RygtW83dHF2LdzupDl7e1RWiWV5bC3NvpUj9QHFGlXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghCwL9da8VJez1a1CrkfyKcU75rqAgipDQ/HNF3v4PjgizVkXdaMaeWtMMw5gxAIGrkzABj5TUo7iAIIrsxVRZ/o092WKI2btmlw/okDIKRxDneC0WjX78zxNmq+Juy3GuTcJJDjO8tsc7igW/bBdQ0nj9Lm7qJJx5blgh6AYks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iIih+xhq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i8OfIlV1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iIih+xhq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8OfIlV1"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J18KGs3078073
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 09:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJsPVkggm5naZHTouB5P3aQWHbVavGwIin4koVrw3Kw=; b=iIih+xhqETsKZO85
	3Gh6iJUIn1pjzSYOjb8c13/geQBBb3pd42DYOCrDqzZce7GTPScg1ZBMMvexhflm
	Ki/bW7yoCM0hc4vm4WZLvIaiKctd4lTaBH+gWWKZcUh9FZFnQi4TTL3+HDTpBRB0
	LLAZZDAFaV7YEXK+neBqCyZyO0lWLPCP1F1bGpmYkVDUXuWFJ5RT7R8XbRwGz0YN
	a10PQOjHIlBIRwn2jqUtqhNyN1Y0HaBBTdcYWz29ULGvaBE9gb1k6kLArv3U0yxd
	u8IKl6zEWV2sCkhcgRHI0a2dHlLHuhLfucNwVkP2OaeE9Q1HkWGT1qA8bzmrksmF
	eWDiJA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdrk80y1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 09:30:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0eb08ceso4791480a91.1
        for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 01:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771493401; x=1772098201; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJsPVkggm5naZHTouB5P3aQWHbVavGwIin4koVrw3Kw=;
        b=i8OfIlV1GNZwnkH6DYOx29WsRgPyswhGCKT0EQD4QFqq+4i+oysUGmoZv2jLAocrGc
         ISLEnRlYcQXwfrGl2qjacTHk5RQVAbvOtVqbjy42ypUiS38wMN/GTrQKp8MwSgOZdQdg
         CATwT97kuHb23clbzqyCFuqsH0B9hnL+mURBvPeHql6k0ujKo3oPU3qNuGDCMQ4rIkZB
         N9ZcWaH8eUL2XmNRTikGfCfrG4PLZWvnG4gkRL7iU9WyLRBbKXqOrbZWc0oepHWMtxHZ
         w+jie35FwsxJa1dTGfehyRoNTkSKj6zt+e/L9DPWan9EVF4E8e6SyaQnjshZBTGjxwes
         hIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493401; x=1772098201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJsPVkggm5naZHTouB5P3aQWHbVavGwIin4koVrw3Kw=;
        b=ck8lgLZVDC5/wx6x0BgSofl2rAWeJHhTYQvQAy4DrdvOy5kat+SF+/HODalqi8EWpr
         auo8U/td4DZ6pq7xGXu7V+fR6i21h0jC7CNxIKjYF7/Tosal01UUNHt8i+ZV5C9uKYWP
         c6w7iDswkWEYNzarBOYWSWIqF+JKRVxQT6fVQvvVtnwTOQww37BZX2yTgMvxHhabMO6W
         ps5l62H0+Mbp12SjX4rUWrbxt1ycsNVLsgTZJiD36WCF0QUlq2ErzT25VHfjdiuD5d93
         ZmIsGAoy20+DWOK+F8Mtl5Y9gBJxBwQV03rQcscEt5zvT2js6EdTOeWmO3zRZ15gypUF
         uYXw==
X-Forwarded-Encrypted: i=1; AJvYcCWKifxq2CT8POpjugfuMXm8nmq1c4VwHiuCr6eq8tS/oYYxUwqBD2DctmMCOkCQ2n/sPLcFU093DaAwl0/gAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwliG5NHnLWG6+6wqjmIFPDJ/VzaQ0u+PWGtaBKUlIBZCnjNPBG
	fpJ3NECJW0oC7zRLjLwuqjxFHKLa7VGX8iv58dGwyYSZDsezgHpVH6vSj/p0DufNP+gZBG6jdUa
	BQnk5Z1oXj1AqlchriFMjdvLw6Nyz3ARoG9D5Gmj72f8x81tjF0gNYkLHtiWTZUGA+C6oxg==
X-Gm-Gg: AZuq6aJI4iTyxPWuScP+XUHXp5I8KhAe7nxF0b9Gxv++coRJARShmz4rH/97GJn79ge
	/sxNwDW1rQFA5MjHpwZRYZhJvBc1TJdR6rruDXjHp5KQJvKV3ISmAt0O9Ci3dwml11qhrlbNrlJ
	3yEXGhNJfAVijI+az2LTfWHPwod2th2lDwoD0HbDVMc1dW7TLqcW4vyF8J7GI0yce6OzdcSUCJy
	hs3HW0so7A++YR5DvA2S5w2dkz7nNYJT/pN1/qncDOoG8TWdYYC+w/9YwkNYnttjfYhG8QjRSB/
	i/R8aU/D5O8/J/tbGZB4megKWRWvLbqHJAcQguTbcYL/ER9ajETkty4WyI6IQV5fVh+L2sHq8kX
	CJPEGTzfL7SPnczJw2/ZvLaxJLkhVrUcB2TOheXUYilndrYDi
X-Received: by 2002:a05:6a21:489:b0:38b:eadd:449a with SMTP id adf61e73a8af0-394fc339ee1mr4614422637.38.1771493401292;
        Thu, 19 Feb 2026 01:30:01 -0800 (PST)
X-Received: by 2002:a05:6a21:489:b0:38b:eadd:449a with SMTP id adf61e73a8af0-394fc339ee1mr4614395637.38.1771493400788;
        Thu, 19 Feb 2026 01:30:00 -0800 (PST)
Received: from [10.92.198.80] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a627a5sm23548236b3a.27.2026.02.19.01.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 01:30:00 -0800 (PST)
Message-ID: <bb28589e-714b-459d-a609-0153b97ac158@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 14:59:33 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Wen Gu <guwen@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dust Li <dust.li@linux.alibaba.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        David Woodhouse <dwmw2@infradead.org>, virtualization@lists.linux.dev,
        Nick Shi <nick.shi@broadcom.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <51e8d8ce-f291-4e31-a938-2c1a0e8684c2@linux.alibaba.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <51e8d8ce-f291-4e31-a938-2c1a0e8684c2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RLewToJ3oBqnDq6Mj4QGk2ZqYjToG_8L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA4NiBTYWx0ZWRfX8BLAVxOf7aOl
 iL/D117x074Lts0Z5Kl5Dx/JoGZCBbEh8IGAesxeq0NTxN+QTp06lj5OqHbn0i3Alqy+FBmfRdb
 SAga0SQhcxZV3mY7FQ9tlxnUZG6MOGUG2PLvCSMLIk9Rkk85JEesvfk7lPkRGJlJ3hsbLFr1PIr
 o7mh0Yyvr1cFX8HUmKWPRP7SU9EZk6CprSVKuFVSxlaeJAWQa/6KQCUjDBB7Fb+q7/rfw2/2MUv
 YlvnLuiTmfO5K5EgHYAZS3U4dfkZfOIKospT01ECoIbamxb2wdgNyzP26NSgcHpNav4FY87GZ4n
 JKRroeADC3gep6gXhJghGL0T/gd0mMt8aeWqpQjf7LcIjBILEZFfI2FWf2TrPdJiKNEk8OHkmzr
 IBDetEZPuyP8sDudFPdikuwg2BOr855eJvuifW/hOt8PgFLFBJKlMi8S/C2kpeEy8H+6AnX7UtX
 uYg/TE/qYw/gDjkymVw==
X-Authority-Analysis: v=2.4 cv=MJBtWcZl c=1 sm=1 tr=0 ts=6996d81a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=ibL7N2hfcdCGtAndqR0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: RLewToJ3oBqnDq6Mj4QGk2ZqYjToG_8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190086



On 21-01-2026 07:59 pm, Wen Gu wrote:
> 
> 
> On 2026/1/9 10:56, Wen Gu wrote:
>>
>> #
>> ## Proposal
>> #
>>
>> 1. Reorganize drivers/ptp/ to make the interface/implementation split
>>     explicit,
>>
>>     * drivers/ptp/core      : PTP core infrastructure and API.
>>                               (e.g. ptp_chardev.c, ptp_clock.c,
>>                                ptp_sysfs.c, etc.)
>>
>>     * drivers/ptp/pure      : Non-network ("pure clock") implementation,
>>                               they are typically platform/architecture/
>>                               virtualization-provided time sources.
>>                               (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
>>                                ptp_s390, etc.)
>>
>>     * drivers/ptp/*         : Network timestamping oriented 
>> implementation,
>>                               they primarily used together with IEEE1588
>>                               over the network.
>>                               (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
>>                                ptp_idt82p33 etc.)
>>
> 
> Thanks for the feedback so far. It seems we are close to consensus on
> the directory split, as [1] summarized:
> 
> - drivers/ptp/core       : PTP core infrastructure and API
> - drivers/ptp/1588       : network/IEEE 1588 oriented PTP clocks
> - drivers/ptp/emulating  : platform/hardware/hypervisor-provided pure 
> clocks
> 
> For how the existing drivers in `drivers/ptp` are categorized into the
> directories above, please also refer to [1] and the follow-up replies.
> 
>> 2. Transition drivers/ptp/pure from netdev maintainership to
>>     clock/time maintainership (with an appropriate MAINTAINERS entry,
>>     e.g. PURE TIME PHC), since these PHC implementations are primarily
>>     clock devices and not network-oriented. New similar drivers can be
>>     added under drivers/ptp/pure as well.
> 
> 
> Then the open item now is maintainership and the merge path.
> 
> Based on previous guidance[2] and the current MAINTAINERS structure,
> it seems reasonable to have it maintained under the clock/timekeeping
> domain (following the existing timekeeping pull chain), with a
> dedicated MAINTAINERS entry.
> 
> 
> Hi Thomas and clock/timekeeping maintainers,
> 
> Would you agree with this approach? If so, could you please advise on
> the appropriate maintainer/reviewer for this MAINTAINERS entry?
> 
> Below is a strawman MAINTAINERS entry (happy to adjust):
> 
> EMULATING PTP CLOCK SUPPORT
> L:     linux-kernel@vger.kernel.org
> S:     Maintained
> F:     drivers/ptp/emulating/*
> 
> 
> We (Alibaba) are also willing to be the maintainer for this entry as
> a fallback.
> 
> [1] https://lore.kernel.org/netdev/b5a60753-85ed-4d61- 
> a652-568393e0dff3@linux.alibaba.com/
> [2] https://lore.kernel.org/netdev/20251216135848.174e010f@kernel.org/
> 
> Regards.
> 

Hi Wen,

Thanks for driving this discussion.

Is there a patch series posted that reflects the new proposal?

As Manivannan mentioned, some Qcom MHI devices have similar 
requirements. Once the reorganized changes are posted, we will also 
resend our patch series adopting the latest changes.

Thanks,
Imran

