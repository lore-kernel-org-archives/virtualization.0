Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AD28A414
	for <virtualization@lists.linux.dev>; Wed,  7 May 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633700; cv=none; b=HFW/oPXHfagc3Uvy86X7dVu6uksdD1ulh6KWlyV+WOW/cGrB7I3ibtTHVdPbExXawAYR3zXIcgjJM47kc0y7McTiyHuYa/logko+JJ0BGLYidxyoCNlh75AmeEgm5H5wtQNJSYlQJwtIE9jDkMQZXVbahMz+7YPoCXBvFExvvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633700; c=relaxed/simple;
	bh=2H6b3nh1dKeMmoukhta7R0sBe8aInWjBPDcAcht8dgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXkY59/M7k8ASYqiiK1/7QUMp4/YteUUJqkERJ95J4p/f6azxExbyX71nNfeI6XCYf6/I891U0jvvt0fNQTq28kxY7nqU0m3+VR54sU9aFvkBPHPe4HnKsRwyNOMkPlZVhADC1ovNRFUMbjqqwdCrM51QhzuSZxwg1jk9iaepI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJiu4eja; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJiu4eja"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547BPROA016817;
	Wed, 7 May 2025 16:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7Hb3hC
	X4ws37T6+RhFjuU+hFX+30251K4pI/tNrllNk=; b=qJiu4eja8eTUKJfsDmvaqg
	Wt9Osf+V1IdPZkuGm1z2wlESZC1PPkGnT+JGpph917pknYl7qUYQj0mStjN3RDdS
	hJB2NcR36eXnCVnx9gu87Qvh/8LCmtT4fA0a1ffteP2YkltMhm29EgB3KY+TCMpl
	XB0ajW5rMlOXEHxIMLdDmWoRxgPowEVPfXSAEe2YqgIa6hxuyTZ1gwd50u83Ye37
	dokLBpXxC8GSQ9zzYph2uz7Q7USzgds+zBDZ95FUbbbzEG0H6srhfUbQL2Hoz6a8
	yTERWdGNH6vRsqTKFo63T5/IFd1KSrOh18C3FEsygkpFAp/4A2CblCHqXpxR7eNQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fvd0m5h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 16:01:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 547CE5EW025896;
	Wed, 7 May 2025 16:01:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv01m33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 16:01:35 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 547G1ZTK23986832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 May 2025 16:01:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B16158052;
	Wed,  7 May 2025 16:01:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E034C58056;
	Wed,  7 May 2025 16:01:34 +0000 (GMT)
Received: from [9.41.105.251] (unknown [9.41.105.251])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 May 2025 16:01:34 +0000 (GMT)
Message-ID: <689ab62a-7800-497d-a9a6-3a81e256f98d@linux.ibm.com>
Date: Wed, 7 May 2025 11:01:34 -0500
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] vsock/test: Fix occasional failure in SIOCOUTQ
 tests
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
References: <20250507151456.2577061-1-kshk@linux.ibm.com>
 <CAGxU2F6ssoadHjCH9qi6HdaproC3rH=d-CdYh2mvK+_X4-C4nw@mail.gmail.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <CAGxU2F6ssoadHjCH9qi6HdaproC3rH=d-CdYh2mvK+_X4-C4nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dr-t7Gfk8KfJM_SPjiYZG9BMOX4OjzIw
X-Proofpoint-GUID: dr-t7Gfk8KfJM_SPjiYZG9BMOX4OjzIw
X-Authority-Analysis: v=2.4 cv=LYc86ifi c=1 sm=1 tr=0 ts=681b83e0 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=5k3jPeAxnmsgk_UWXUgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NyBTYWx0ZWRfX1kIjyTpIbXO0 09GN/mayzwc49Lk154Wq8khd7hPOUNm4t6Cb/6YWzeCfHiBXXscuKnJjyTRIiWGxeYMgYYjd3YS IE4Zkm4jrfkNqWzjklw38m499m4HVECLm3aT05Gah7Cdw7e8XGPNAX+6KiLmhTuUIB9xB/TFyiE
 5Mq/evnQ4qRtyR4+H1N+xizvj1JlfDnLigjeQhMPS2NcyYB4ysNYDFmAj11dIi5r0XTs8FJGg7d NSqTcGKQqqeZB1urbUghnSumQflEOrDvC91fsN7LglQfAs7OKrT3KzdKowBoS/0U2YOxoRvS03m iRrOQr70FVyTc9yOSy9zkFAkDoa2H+C0yMHozmc6qQJKYWVa2PhRouufaSoBK5g3173CVu58cmQ
 vcDey5g5S5AiFrg0mqOghNI/KS5wabRAzweVHot5+p2fD0Ri3PvHls6uInZNgu5vnbmajpHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070147

On 07-May-25 10:41, Stefano Garzarella wrote:
> On Wed, 7 May 2025 at 17:15, Konstantin Shkolnyy <kshk@linux.ibm.com> wrote:
>>
>> These tests:
>>      "SOCK_STREAM ioctl(SIOCOUTQ) 0 unsent bytes"
>>      "SOCK_SEQPACKET ioctl(SIOCOUTQ) 0 unsent bytes"
>> output: "Unexpected 'SIOCOUTQ' value, expected 0, got 64 (CLIENT)".
>>
>> They test that the SIOCOUTQ ioctl reports 0 unsent bytes after the data
>> have been received by the other side. However, sometimes there is a delay
>> in updating this "unsent bytes" counter, and the test fails even though
>> the counter properly goes to 0 several milliseconds later.
>>
>> The delay occurs in the kernel because the used buffer notification
>> callback virtio_vsock_tx_done(), called upon receipt of the data by the
>> other side, doesn't update the counter itself. It delegates that to
>> a kernel thread (via vsock->tx_work). Sometimes that thread is delayed
>> more than the test expects.
>>
>> Change the test to poll SIOCOUTQ until it returns 0 or a timeout occurs.
>>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> ---
>> Changes in v2:
>>   - Use timeout_check() to end polling, instead of counting iterations.
> 
> Why removing the sleep?

I just imagined that whoever uses SIOCOUTQ might want to repeat it 
without a delay, so why not do it, it's a test. Is there a reason to 
insert a sleep?

