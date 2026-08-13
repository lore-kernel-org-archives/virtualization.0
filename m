Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F1219E8
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619554; cv=none; b=fcRLEzvZh7rqVfZhQIBF1yfWQR8WA0dVUEofnd2yyFoFUMYYrSogIV+IiQiuIYl3DFN4orV1Nq3vcOhkldYkiTkS3RJmS7HZrfPc54evgWT41xX+nPs1KvDCZnmwLHhnArfYJbYVLhmurzPsgF8XhOaLasCSyf1PllSnrJHAVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619554; c=relaxed/simple;
	bh=cWHIpBL/UDcgBQw8HjmcxGxBbqKa2aBrR9/+ILe9qqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sRN85VydQTV5uoLXils3RGIhcbtVoZuaa8Ds/OOXsaCHTGQoJUF4IrXlhRJFwCSwbXc7SUHepz655p0D4d7kW+Y8bo5qbdIJro5NgwheZbbRqVbWQGwxIB+vYs1HflaCZbCr86AepVWqRT/ipu2q03eUTwdyItUZlfizOHYzrls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SDImlLNi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SDImlLNi"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98q5F810709;
	Thu, 13 Aug 2026 11:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aiMo3w
	hf2fq2Oos4QQwwyox6NIjhMeEpWcHceLl19VE=; b=SDImlLNi4mOzd7QO6XV97h
	Z97hAbOJAshjXEQVoBzcOicFevEpSZMzX+dhREmqLN9Zq2MHxLLsjPxrNt3eDW5O
	Tz3eLG9r0j0sLoGoA+MbosPBc8YqKyMqGrghzPpc6LHe7XCmmzUtLHkba1xSaVc3
	4Dhqrjmj+5vKVBPNnllLqwZFTC6qEjAF0Uq1gUlE07mtwc1A3smq214xWiWUVvMf
	OkIWXdW3pvyfXJ/ZvIUmQGYVm0xgh/cKWmvaoXyEPfcVYTLSsvD3YU5N01Gix0tO
	xgtis9IFMsTXUD3MrJdaTpDiT8sZbp6E6LsPMsKjqTEhSyDo7GCTI5V+juJXTxrQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23yxe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:12:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBBH8Z024741;
	Thu, 13 Aug 2026 11:12:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfyaj07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:12:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBCCT347907298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:12:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DAD32004B;
	Thu, 13 Aug 2026 11:12:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BCBA20040;
	Thu, 13 Aug 2026 11:12:05 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 11:12:05 +0000 (GMT)
Message-ID: <20aa609c-6b11-41a1-875e-3aaba2809883@linux.ibm.com>
Date: Thu, 13 Aug 2026 16:42:04 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Re: [PATCH v10 00/12] sched, steal_governor: Introduce
 preferred CPUs and steal-driven vCPU backoff
To: Mete Durlu <meted@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>,
        "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>,
        frederic@kernel.org
Cc: arighi@nvidia.com, chleroy@kernel.org, christian.loehle@arm.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, huschle@linux.ibm.com, iii@linux.ibm.com,
        jgross@suse.com, juri.lelli@redhat.com, kernellwp@gmail.com,
        kprateek.nayak@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, maz@kernel.org,
        mingo@kernel.org, pauld@redhat.com, pbonzini@redhat.com,
        peterz@infradead.org, rafael@kernel.org, rdunlap@infradead.org,
        rostedt@goodmis.org, seanjc@google.com, tglx@kernel.org, tj@kernel.org,
        tommaso.cucinotta@gmail.com, vincent.guittot@linaro.org,
        vineeth@bitbyteword.org, virtualization@lists.linux.dev,
        vschneid@redhat.com, yury.norov@gmail.com
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812194600.52516-1-sunlightlinux@gmail.com> <an0MMNBkyeeZEa8f@yury>
 <a4478425-1914-47d1-b5ec-5e11dba048dd@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a4478425-1914-47d1-b5ec-5e11dba048dd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7da692 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SfQhua3PvPfpT-rxooIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfX7ONJ2/yJPsWB
 DgAnuRW0kwGy+fH6og1mBsmFMrne7Jx5Z4NXebcJYvfCJBNr1lilBoc2JclTXcfJQ6YTioYr7Gs
 p2zA1+xolUe+5DaSBmZneSpHaXw1IcZJpHuwGE40X7UiUSdCeeDcEeHrqIb7gLM6w+eqkIqitcp
 9hdzw06FmMixioG1FI7FjPJHSBDAvwQYg/1+SIGBeOlnECwmSXFe7TJZmFEAZWVnZS0U/W9nNUZ
 nUwsP+n69aDIP6UokVgfuXIP5lF4UXRQ/jSZF6aRp3AH5aq8r6q+bymvvXJ/CwcmVyig63JXKvN
 ogck2oF1jGD8z+vIowKBS1VFRQVLXlT9iAL3Mg1rB4OurAHgO60yNl+ehX4F772b9Z37XJ4yKik
 3Gxqu2G83cgx6mFUep34cAIqjw2Q3qbFqNhkLyHPxlCh0auvRU2KOUFQEaEvjp4Qa9yCbOqfyXx
 +/Pz5ssUMqGIuTLFf+Q==
X-Proofpoint-ORIG-GUID: sSnQb8kE7Qd8l6HXRkZpa6sRtJz5HmsN
X-Proofpoint-GUID: ZGZ3zDi8DY8N3h9UafM1rLg_PPBgRmvN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3NyBTYWx0ZWRfX5K9JCZ2fQQI9
 M6EByBaouIAWxS6kpyGy0is4BsStq5UypmIElikD2Aqbv3Vrp4UqWtiXsO+jXW0mGDZbmsyOK9u
 KIQvFPfMqTYmhlJq1hepZoM8QonLVB8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130077

Hi Mete, Thanks for going through the patches/discussions.

On 8/13/26 12:20 PM, Mete Durlu wrote:
> Hi all,
> 
> All of the points raised by Ionut are about governor lacking
> certain logic for a specific arch. Considering what Shrikanth
> mentions under "Future Work";
> 
> """
> Known Limitations & Future Work
> ===============================
> ...
> - Arch specific hints and framework for it as been deferred to
>    the future.
> ...
> """
> 
> I think all of these points can be addressed better if
> Xen used said framework and implemented their own governor
> module. That way we wouldn't see an overinflated single
> steal_governor but instead nicely separated arch/platform
> specific ones, that are tailored best for their needs.
> The current implementation could be the fallback option
> if platform does not implement their own and would also
> serve as an example.

For now, I prefer adding a defensive check for dom0
and keep the driver simple.

> 
> I really think we should follow the example of cpuidle
> drivers and how their framework brings together so many
> platforms under a single roof.
> 

But I remember fredric saying it isn't ideal either and he had
planned to clean it up. (Fredric, correct me if i remember it wrong)

> Thanks!
> -Mete

I prefer we defer the arch specific hooks for now, until there is a need 
for one. If you guys insist it should be done, then i can start looking 
at cpuidle framework. But it will be a bigger rework.

But if the patch given in other thread is good enough for XEN, then we 
could keep it simple one file for the time being.

If the driver eventually outgrows a single file, we can work on a 
modular framework post-merge. But for now, let's keep it simple and get 
the simple version upstream.

Thoughts?
