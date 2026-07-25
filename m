Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3B43128B6
	for <virtualization@lists.linux.dev>; Sat, 25 Jul 2026 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784944425; cv=none; b=g4AXen420fiTQcCnGep6KPITyPXkd76jbbyd+U5tdIgpaTmZOQs9h0dksPuvjTtOFhkekFg4vjJWdFplck4I50EQ2nb55e16aXB8KsWrco8FT+FTfinUBU/fuhGrWErEmCWcSqbY3UTOZgmOU6vT8bSVz0hFb0EkAlE/pdGI22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784944425; c=relaxed/simple;
	bh=JFpSuIrmzdJ6+thtl/WRCF+s1b2qeE3d4VDxP6UswBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJPsJ4LHmkncJhSRYiJnuAv6Rkcfot6Qwak66l7CackbpbqY2AEfFu1kuivVHSIMDpRDLvw1emPdW0zDNe0FFuI9jMj5N5YVtjmnMWOMPptVGg/Y6NBBypFpyhBvv2XGXbGQJuaNLSxnrxKCW6bNtx3iPgsUinAg1scKZjc46uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OULb9z5Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OULb9z5Z"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P1C6IH3338741;
	Sat, 25 Jul 2026 01:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+n5J/3
	biCslYghQLMKWqzmleHGIa3z3vpuHr9MQ/rxg=; b=OULb9z5ZoyCcV3CgwzEyre
	+kCa23pKsjJqCrviLvzznmdKdzpNhqyoburLulGWau618ocyJX8i94kOIhyJV+4Y
	vI8RFCQFKhjWIWeTIht2g0wHunxmsBLeBH4r3xXWUylJ7UVgUcnfpCQUgf/X5vYa
	7OlxJ0JaZMNS80b21zf4ozsfXKneNga0VlOeM34OqxqQqs33HG0ykRPnDp7BHYTE
	OrlHiUR3TkGs2snm1NpQSI5+S3Z57ZkOV7Ojm1LP5ue6Olnewpb3bo2V3hHXv841
	Pp1GCzXn7iX57NPPK+5QhnjWeogVzyOFSnyQ6dBBHrfVWLLK4bp5r+3BR1OTDIGA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmjjj8628-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 01:53:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P1nkNT025280;
	Sat, 25 Jul 2026 01:53:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wkh0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 01:53:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P1rJwp50921886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 01:53:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5E842006F;
	Sat, 25 Jul 2026 01:53:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D15702006E;
	Sat, 25 Jul 2026 01:53:10 +0000 (GMT)
Received: from [9.124.223.44] (unknown [9.124.223.44])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 01:53:10 +0000 (GMT)
Message-ID: <0e1623c7-029f-403b-a560-71931f84f03d@linux.ibm.com>
Date: Sat, 25 Jul 2026 07:23:09 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/11] sched, steal_governor: Introduce preferred CPUs
 and steal-driven vCPU backoff
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
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <amPiGgfR4cAF67Mr@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <amPiGgfR4cAF67Mr@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDAxMyBTYWx0ZWRfX5BtfegC9/mi9
 7NvbvUW5D/qfTPeJ26L1J7x1/x5p8umSnA3kVXXOQ46JY80Mnx+bRW6UpMGNXzcqkk7yUxnqBh0
 0wOOWw0vfAYadnhGsArqBVYrfLozKtw=
X-Proofpoint-ORIG-GUID: kjUpSjjXsJehKW8SJ2sGoqvZJ2riAPnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDAxMyBTYWx0ZWRfXzeL3I96Dl+sU
 JJbeE7btdtLPmGf0Lfi4ELC+Y3bzUdrl7xCALvrZbN5a1H06eW1WQlJ3h7cwrH9iK0Vv0PHNDx/
 u9N/A9I0HCSSo9PPimK0ObCjMlnlN4pE4uZt3Q4ouQ9cq8kOgxyd5h1uLBEW645aBYytl0hSd3f
 NcMs2rZYG51+8l7ck4wBBty34T+SeHYJ3qmdS09WEs2NNE/++KLuu7pAOKEI02tWyNgKByFZ+0i
 uOWV+14qa3m/h01Uj76vZ+N+zy/Q8JkQPs8NUVpwXnFYwG2X2L04JJrGmvBNqzlBKC69NDFMzmZ
 NLPJ0a3b9HDxQt9i1vAJiLzhjGyR9MmRr7Xd68AF5q9U6hPC3OtwEGLPjHPBgTn9p46KT9NVPL+
 fq6DtLQjoDnCDQ3p0uZT3pfXA/KAZIzsnt3cHrpcdpUnkgp4G1t1qAhTTHV1ZHwpb9Ba9tWVs91
 kc2QUaELtl30Bulhd9A==
X-Proofpoint-GUID: D-3n4mnG1o6q0h1H4wTRd1oSRPWY9Ms0
X-Authority-Analysis: v=2.4 cv=TLp1jVla c=1 sm=1 tr=0 ts=6a641715 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=wOctuUhgRehkhcMBElYA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250013

Hi Yury, Thanks again for reviewing the code and going through
the patches.

On 7/25/26 3:37 AM, Yury Norov wrote:
> On Fri, Jul 24, 2026 at 07:37:21PM +0530, Shrikanth Hegde wrote:
>> If you have already read v8 cover-letter then see only v8->v9,
>> everything else is same. :)
> 
> No, you submitted v9 in just a couple days after v8. Please allow your
> reviewers more time to read and review the code.

Agree. The only reason i expedited the code was that i was losing
access to the system i was running performance of real life workload
scenarios. It will take a few weeks to get new one, so i sent it out
early.

> 
> Some comments are equally applicable to v8, but because you've already
> sent this v9, I put them here.
> 

