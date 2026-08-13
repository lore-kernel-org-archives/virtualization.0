Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BF413D62
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603868; cv=none; b=hEy2FefBPjFFGONJ8Gub01VJ1ZvItw2lChlODvV50dVWDlRLzfz1R0kxatqrR4pjckTFMib05Xtm++6M4ew0gePtlCW7TUsaGA61H0OMTShjbPqTz97p0/h6CRJ4iO6goRWSey7Y1VYYLdBvjq+QFgVEkJgwFU8QoKl5dsv5fPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603868; c=relaxed/simple;
	bh=x75rfk3/xcVtDXBNa8u/YzzObGZuj8q0jI1mJ67Lbss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLx76cWBUgFK4S8KCINM817OCBOKncMvgQizuWJurhobZTjRUBcFQ4MhD/R0nGqUoAG6/ohsjsOx+iGC9oa/8rwQv/4pZq90bZ+lf7cumPOWdRvRrVsM0d3ATpGjPVr6YuTjngB9ouEio0Uz5mESBfXhYDQCBU6dnZ2gbej4rnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LzhNYloX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LzhNYloX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D61nMQ1430735;
	Thu, 13 Aug 2026 06:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aBqLCs
	TQ7rFTSJJarqDaEDm6W1gTw6QjhWITYjimLPo=; b=LzhNYloXpWrrZ5WXbBQyBl
	kjRQBNbL5khVgr4OOBrgQ1k0oQfOuorj9IhD20b6wzHqW/6ixwuyyQgR5wBrAfNg
	W7Ta3SvAVrA32l8zHV6lMdO2+yAP4M8OGJSAMNrvrPPDneKV07elir2a3C7IEOqr
	xFmLr8qBAdZPaa5rOdfRd/Qrytpu8FuBOOBbxodN45sAIj+1/UAkRnkuqJrWJj7x
	sNUXBn7P4VSe7BMXLQG2fmbC2bsV5+ZPTZZACltLD5DhfqVhCAduIXL06c979mS/
	ccc7QQrzzPRVvRDivLP15d7P3FcS95GzxyIaox5QdCcOUpQ6/bfdyWeiDpzRSjOg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp35p3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 06:50:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D6fWud030960;
	Thu, 13 Aug 2026 06:50:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk1w8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 06:50:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D6oipw41156884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 06:50:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAA3D20049;
	Thu, 13 Aug 2026 06:50:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46EA920040;
	Thu, 13 Aug 2026 06:50:44 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 06:50:44 +0000 (GMT)
Message-ID: <a4478425-1914-47d1-b5ec-5e11dba048dd@linux.ibm.com>
Date: Thu, 13 Aug 2026 08:50:43 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Re: [PATCH v10 00/12] sched, steal_governor: Introduce
 preferred CPUs and steal-driven vCPU backoff
To: Yury Norov <ynorov@nvidia.com>,
        "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, arighi@nvidia.com,
        chleroy@kernel.org, christian.loehle@arm.com, corbet@lwn.net,
        dietmar.eggemann@arm.com, frederic@kernel.org,
        gregkh@linuxfoundation.org, hdanton@sina.com, huschle@linux.ibm.com,
        iii@linux.ibm.com, jgross@suse.com, juri.lelli@redhat.com,
        kernellwp@gmail.com, kprateek.nayak@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, maz@kernel.org,
        mingo@kernel.org, pauld@redhat.com, pbonzini@redhat.com,
        peterz@infradead.org, rafael@kernel.org, rdunlap@infradead.org,
        rostedt@goodmis.org, seanjc@google.com, tglx@kernel.org, tj@kernel.org,
        tommaso.cucinotta@gmail.com, vincent.guittot@linaro.org,
        vineeth@bitbyteword.org, virtualization@lists.linux.dev,
        vschneid@redhat.com, yury.norov@gmail.com
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812194600.52516-1-sunlightlinux@gmail.com> <an0MMNBkyeeZEa8f@yury>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <an0MMNBkyeeZEa8f@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7d694a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=ytvUXjNDRGHaUZttXtEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: no_RzowkTuFFWN43HBrYVKw0wweS2OeI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA0NCBTYWx0ZWRfX7kmkn7sBut12
 mAYZIy4OUVv6XC2KDQIUVliN9/u5sGqSPE/wckOsHUCCzK6arq914B+LkJh0ls8w0Kz+AJbnzgb
 DVxS0tyMSeEij++a1oKCrddG16kgEzAMgvTpIKruJ5/hqH1WrUadjDQ/GeO2t1SxhdRqkENXgj0
 1NsFNTxzU783vqz5yxa+zJsiIYq7KtE374n1fHejPzc6FVcRMf055tRHz0mD6xyXNnx3PsMwsNt
 WCvql6rOcCuzE6EE/101zbweMmb2OUm6FiBM01vg69USxcJ1GYX/eUqNXC2qEROm7srk95N1vFl
 4afGXdrj4zSASG6MAmgKBhgcoGhqXGXFaZFScRmjfNLUBqQu1/CLgd3V8vliRofb2LI2W1dFjyZ
 h7oAwmu+KmXuUWaJSdlqvRqLr2fOmHPFZ2Okh7F8+ibWmdSyCTCYcL8//TObJeWSLaFCL6F/tYK
 HWI+evlQngFKactSBWg==
X-Proofpoint-ORIG-GUID: 2fE5d4xrKH3ReufcYIxjdH0yP9eBmjIU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA0NCBTYWx0ZWRfX8x7U8lZAJsRm
 nyQMikEHXeCeYnbrHa1q5+ow0mF0kVw30XJ6nHIE6wF197WqqWaPqpgk2+NOarkiT7Ca0+/OknA
 SZkI8WPGHVZDcP8MJd5w4pdq3FvlQq0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130044

Hi all,

All of the points raised by Ionut are about governor lacking
certain logic for a specific arch. Considering what Shrikanth
mentions under "Future Work";

"""
Known Limitations & Future Work
===============================
...
- Arch specific hints and framework for it as been deferred to
   the future.
...
"""

I think all of these points can be addressed better if
Xen used said framework and implemented their own governor
module. That way we wouldn't see an overinflated single
steal_governor but instead nicely separated arch/platform
specific ones, that are tailored best for their needs.
The current implementation could be the fallback option
if platform does not implement their own and would also
serve as an example.

I really think we should follow the example of cpuidle
drivers and how their framework brings together so many
platforms under a single roof.

Thanks!
-Mete
