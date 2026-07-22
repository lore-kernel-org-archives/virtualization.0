Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894940F721
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716111; cv=none; b=MKOyntueq+AilDmiCOEGFd88ve98LM5PNvuWBw25+kn4NjEUNGeqNr7w6R78HcAB1lj4b9xU+Kq+3V9LO9Gjj9d0amf/lVsiSm9fq5ty6nZ8omolJmgqIWmg2oHVqTH3xrvwFnhQIdkSZjILcfoOJLEgwVk5AQ/ic/bAtiR5QEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716111; c=relaxed/simple;
	bh=2A92Q4dbQXDGZZxbUMN8v+iziV1zzwIs5KhRxj7zgok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzV7y0+FAmUMdqH/aywXWsf5NXg+gSUPSlB4FwHSnJIvabLHWWQTF2Kqf4YkK/VF9Rv50RkzDgX3Es7ziIyEW5rnj6ULgLA4Lk6xWjwnTt3Ha0oq7Z7BvvhU3YffhBYX9vzl4bJDsPCFZgP0uJP18fJa2pigPdqCSuofdXTiS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OEQyMzu2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OEQyMzu2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M9BjxX3671092;
	Wed, 22 Jul 2026 10:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jw12VN
	KRF2L/qQJtOWQRl49AdfA0YonqWJYk9GdWGW8=; b=OEQyMzu2X3l8LyyAZ/ipP8
	6rlw8CaTK9mLY+IUVvpSVMmOSPs1dLn8/xY+y8BhUnLpQP2EmABskN0wXZcouB1b
	zptEaKOab2k9cpEC8iSgSSJPznoaTmDSxFZl8akD2VuJfINPDozHw1SOTSSnxwcw
	nm793TpsZylTJciYHjb81173flI1aDsJ7vZM7K6FTSODpZJOQIql7QueuKFUD3VI
	ve9J7u8V11X5Vvsc5DiVcEvzDbjlEelVgszc/elm7cs58EyYkYgY0dAlg6xNvq/W
	8kFiWjL8fAy+IzfDTPgcFtXUR9jqy/RKTzl9FgqoNUgBTJ2b98b7PWbHeUa8m6Yg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7911kk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 10:28:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MAJdxj020456;
	Wed, 22 Jul 2026 10:28:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w6xcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 10:28:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MAS7jm62062906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 10:28:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F017E202B9;
	Wed, 22 Jul 2026 10:28:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 155C8202B8;
	Wed, 22 Jul 2026 10:27:46 +0000 (GMT)
Received: from [9.39.19.53] (unknown [9.39.19.53])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 10:27:45 +0000 (GMT)
Message-ID: <7a7e44ec-ea46-4ad4-93a8-3c441120aa0e@linux.ibm.com>
Date: Wed, 22 Jul 2026 15:57:44 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/11] virt/steal_governor: Implement steal_governor
 policy loop
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
 <20260720172250.2257582-11-sshegde@linux.ibm.com> <al_IbeAa3sDrt9A7@yury>
 <c64ed18e-7863-44c3-9c7b-2f1efd1a805e@linux.ibm.com> <amBztSFLg2X72P2N@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <amBztSFLg2X72P2N@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8GAly5C1i1tWS7_nNXY-XJiG4q18zlGY
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a609b3c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zxuFfC-_aFqewpl5KLUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5OCBTYWx0ZWRfX0wdcWLrTZFA7
 0taao0Fr1aOyhDBHz9PSi479d6/iwnEUUSDtShC1cdxQnjpIRQjnJJ3T3N9gavcF0vjhIgWWcV1
 QFuQtakxn7WWBFz+TOYD8RLpfarnOwo=
X-Proofpoint-GUID: FA3SIfztnD4sgCl02gv69jAhriTD0r5p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5OCBTYWx0ZWRfXyYJVPlqM9TA2
 J/XVCJFjQhiFRvQJFZZihtQ40ExjSZcFFIcIEsUmSneOVL72ZFZvmd492t10STcLMztBcSRK7Gq
 NbgAcSBuRVY9rYP6sxpYKUz5JtNSClyaBn2C0eNQKIP0nWbCRMb3ItCQM11sI36M3mbC5oobg+8
 zitdTeGwKDp4zREovIDlMX6IZaiGc/WHQ80pyX14/ERiErIuekbaI3m/eebEIKj/FVsKVpOk1x4
 1A0pV2tzPZQ20KWz4LMu/n/KHNa2y1qMWo4sCoaEvnBoZCrx4cXmrQKkM2it9xzCjYMN/Ih2xMI
 UDrIpYjWvQN95v6Jpv7uSG69sTg+9Pi1peYxWAGFy3RXrZ5piWjFw9CU4i7ueWNMJtfVVdRxKph
 vgWGfA+iuYv+b/Efk+vZbu+ORZ7Sllkqwy8WZVBpcwD73VC44BSxdzkxcvsbR1zFYZUjlye2zsx
 HlSEqygToqidIPw0JHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220098



On 7/22/26 1:09 PM, Yury Norov wrote:
> On Wed, Jul 22, 2026 at 12:44:03PM +0530, Shrikanth Hegde wrote:
>> Hi Yury.
> 
> ...
> 
>>>> +	schedule_delayed_work(&sg_core_ctx.work,
>>>> +			      msecs_to_jiffies(sg_core_ctx.interval_ms));
>>>
>>> If you need jiffies, why don't you have them in the structure, instead of
>>> milliseconds?
>>>
>>> 	schedule_delayed_work(&sg_core_ctx.work, sg_core_ctx.delay);
>>>
>>
>> I would prefer milliseconds as jiffies is very difficult for users to understand.
>> It depends on HZ value and one has to query from configs.
>>
>> HZ can very from 100 to 1000 today. Again I will have to play tricks to schedule
>> the governor at fixed intervals.
>>
>> So i think it is better to use milliseconds here.
>> Correct me if i am not making sense.
> 
> 
> User provides milliseconds, then in init() you convert them into
> jiffies and save in sg.delay. That's it.

Ah ok. That's simpler. Will add a delay filed to the struct.

