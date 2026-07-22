Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693733F5B6
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784699955; cv=none; b=gRQY1V/8plaQP6vm9HcCIcoYgsk8Htd2uNlb624iAhUwII0tGiE1dZRs8PdhJrGCvgVSznc6vTio4WgwPWiLHSzPL2gWwMcj82bFJuvxRNCL6oKpWdzDfIGim9XjcOAQDhYNf9uB4JeU/u8PxYqyjIj2GM1RJBsASGr3EXeASsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784699955; c=relaxed/simple;
	bh=BUtoyWqo8hHh51ufZgbD2+/4ap/luAAtRwkjA0cje5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1i5dT5EeUMk3DRXCildPLqAxRmjFB3Ru6qvIu1uZcWKGb7lmg5SO47Lw+ZECA5aYvou3jLQpEdtXlTYkStZQrKeN/pwqa5sLjlfRt4O8xA1VSi500hOtDEOSlznwAfk/lXCIjwbXHibm5XII5meh/bhd4TDSk8zq8MADjarbv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GiLg25iX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GiLg25iX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M5Bnjt3152891;
	Wed, 22 Jul 2026 05:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B0W/aO
	WXVQjI8IfpoQVtBte2anI1EBYumbYb8b/oY1w=; b=GiLg25iX8LNT8gysq+NA1A
	OipYB0tfQmPZ/fk+I5d/v/oOh9ncZIQqGNIwRCRynqsuIBG37Kkx6ifKxD2DhVWZ
	4FdO37gnwSAk+IJRXweY/tVJTCF5/bHoOoDjhoIryMdwIdzAMmi8WwTM/XOI9yAR
	gm90Yr4e/Xf1dx/dLrry2GVTakx5661Eg5Euc0jkpI0bDQUSytoOAuIJE22u8zoC
	hGKecSXvl7LzjioS1kfwkAJrgN2GGMpbZ7JMzVHB9P4uyJy2isJK+xC6DNMZwH21
	h3KNAx+3KCP31NdEsu7L2TM6dsR/TH2hkWIpaTUim/4bmGREagTonSMd9c4rDVVg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah81x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 05:58:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M5ngFb030991;
	Wed, 22 Jul 2026 05:58:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktq637a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 05:58:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66M5wgJg47317306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 05:58:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D011E2007B;
	Wed, 22 Jul 2026 05:38:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB7B20077;
	Wed, 22 Jul 2026 05:38:50 +0000 (GMT)
Received: from [9.124.218.133] (unknown [9.124.218.133])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 05:38:50 +0000 (GMT)
Message-ID: <2bfa5d49-0ca9-41db-9729-244fcbb351b0@linux.ibm.com>
Date: Wed, 22 Jul 2026 11:08:49 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/11] virt: Introduce steal governor driver
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
 <20260720172250.2257582-9-sshegde@linux.ibm.com> <al-n0iPGnlTr39P9@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <al-n0iPGnlTr39P9@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: sr7KaQdur-H0UOWs1OGIOXdcmj6aDUbh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1MCBTYWx0ZWRfX7Uh3xuQz4/yp
 FAjTHavWPXHOUAj0T/tpULCFOU+DV4Sb27iLcQ9c6uhQcFXlt+c3jbNcOM8I98nfu1xeWltJSzm
 A43ngYwq2LAoDj1FyT0GNeVeO2t6cZtgIL7AISuyvKUhMzPXtdBKdkzhmCvBu0UdSrgA9Lbm9MF
 6STmxEocEmPhaW1MtMPdyPoIQK4DBw4GbXfdf6TV2c/5E0VkPrLcTKjgwD74/IU4eAIm9xIRkv2
 8zUH0b8yuESId9MNqfTvqj0hqF5P+Mr4rB/sTkBjZPtAhzCCK+b9YJknQnfIUENIOyLINQ4w9L6
 OtxREDELNG6fdy403C9UGk0eUSqmTQdZDPxW5OpoBD7w8AhyZHpb0wEHCJf5w04u0hgtIkC8CVB
 mwxBZ8rz7FPIIJBm2OAi2ECt3q9tSOuxhKT8ckjDeop6amFgx0JSU67rXAQ2WJ/DMDETzvzgpTf
 xxkzrj7rMqpaibU5Xag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1MCBTYWx0ZWRfX7v2e+gmaquUD
 zexr/+TCmDMrtNm2RwHags8M4niJ8sej6lo/uqGUsmEuUHlM/KeAnK26yYOEikMfoddsLqUm0t6
 2mj2DSIekmfPzEkqp8ox4W4zi+ByUXI=
X-Proofpoint-GUID: 6TkdxTCnHZxNi9SpA4xI2TAmM8DfSCz_
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a605c18 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=KrMzzVSTZiWGVZp01ooA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220050

Hi Yury,
Thanks for taking a look at the series. Much appreciated _/\_

On 7/21/26 10:39 PM, Yury Norov wrote:
> On Mon, Jul 20, 2026 at 10:52:47PM +0530, Shrikanth Hegde wrote:
>> Introduce a new driver in virt named steal_governor. This driver
>> will compute the steal time and drive the policy decisions of preferred
>> CPU state.
>>
>> More on it can be found in the Documentation/driver-api/steal-governor.rst
>>
>> There is a new kconfig called STEAL_GOVERNOR which is introduced in
>> subsequent patches. That driver is going to select PREFERRED_CPU.
>> This makes configs driven by user preference.
>> When the driver is disabled, preferred CPUs is same as active CPUs.
>>
>> File layout of the driver is being kept simple.
>> - core.c - contains main driver code. This includes the periodic
>>    work function and take action on steal time which is introduced
>>    in subsequent patches.
>> - core.h - header file which includes data structure.
>>
>> Main structure of steal governor has,
>> - work: deferred periodic work function
>> - steal, time: To calculate the delta in periodic work.
>> - interval_ms, high_threshold, low_threshold: debug knobs of
>>    steal_governor.
>>
>> While there, Add MAINTAINERS entry for this new driver.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   Documentation/driver-api/index.rst          |   1 +
>>   Documentation/driver-api/steal-governor.rst | 117 ++++++++++++++++++++
>>   MAINTAINERS                                 |   9 ++
>>   drivers/virt/steal_governor/core.c          |  48 ++++++++
>>   drivers/virt/steal_governor/core.h          |  25 +++++
> 
> Unless I missed something, you don't use struct steal_governor out of
> the driver. If so, you don't need this layout. Just put everything in
> drivers/virt/steal_governor.c.
>

Ok.

By that I assume you mean to move all those headers also into 
steal_governor.c, remove core.h and remove folder for steal_governor.


> Thanks,
> Yury

