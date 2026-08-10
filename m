Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FA3C1D72
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363126; cv=none; b=SJ8IKU+lFmjiBuePJveC3go6gkPJAo+ezlMgIT1wSSXJeOtp6VZgxZfcwQovcVwMpQrNDXo7+lalXkZXn0jWMvNcDbScKLkdoxVHbcOiQeV3AxE/poA99RVhV3Qn4m14wCDjWBFfAm6BVoN2Xa4OBI6FvtB0K6mVVsnapXKQhDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363126; c=relaxed/simple;
	bh=9gzAqTZpO39j/ukdw5H42LdIAbMK+RiLrUZRWXkrSdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfjbZAQw7DXk03luRTYwvY1dCOAhn5wz/Hn6UFTh+IRWimDbDMUOlRJTixRSMIoI1Qy9WCGPS1NLGPlkzzBvKXwQU+OrMsGQV1y5zNGzayjXon2E0h4fk3FZi3OUws5pSrsO/3HxbIBG/HM/7PWTEpDK4KSJhW/KKEM5lDaGKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WInEuD3V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WInEuD3V"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9VdkO3584573;
	Mon, 10 Aug 2026 11:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bj1XCv
	abIt3nxqjly5CGnjcvBRbDhaBaxAPC95vSkiA=; b=WInEuD3VvHuY7IlT1AH5pc
	1O3OC+LijqvJYJzQfMzqTl6gRkpNijAJGUmu0lfF0LWqx2kRhdnJrtQ6B/2u3v5O
	shp4V7p/qWp6HWREPGE+zw43MI504+nqh30zQTkjy30P7aB+GJofZzeT+DMxkDax
	slkOSpNsczyO1WAJOUNaHuuZ43wWkgi/Ov8IytJucP2lPv8a1Wzr1y92RrvhQYl0
	oB+RtUZdV21A5aa9bK2fLTaiVAPrqpcGTHDFIfW3LPHfIrFrJcUM+6eUEIRUbTcJ
	eD3RGfqIjSE0nqcI+UK2i4EfJ589qcntWRJUJAi7WRt6HmTjdmkRki0e1M30lXzQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyqqyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:58:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABuJLv005157;
	Mon, 10 Aug 2026 11:58:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vvr01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:58:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABwJBL51511710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:58:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B8BF2004B;
	Mon, 10 Aug 2026 11:58:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DD0A20040;
	Mon, 10 Aug 2026 11:58:18 +0000 (GMT)
Received: from [9.111.54.108] (unknown [9.111.54.108])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 11:58:18 +0000 (GMT)
Message-ID: <31646728-5af6-4f3d-b461-8992c213e230@linux.ibm.com>
Date: Mon, 10 Aug 2026 13:58:17 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/11] sched/core: Try to use a preferred CPU in
 is_cpu_allowed
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
 <20260724140732.2683314-5-sshegde@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <20260724140732.2683314-5-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX1Eynb2jkVFgv
 FLjose4SH98cCzumRXzR/Qz3x1hBYbsoOkhBtQYpEjGmlkytCZA/IoUXC9ORrLhSN4GPyF9JR0q
 8vu78MZJBK1jrjaHC3fcLaGW8vWeBSFzobeIGNh7WLC1nT3RWvqwwKASctWF1+PfLHroaHJgnY1
 xZAHCfRfoOqL9uryDyGPLYkEzHCcdRCvW3QdlE1p8v4fgsj1qBLQnzWKC/B6+X8jNTQ/US0PTZD
 psSWX8ZXIKDzHc3JDptVNRF+Ry9STnuUE+P6wk8YCyqvDbnH+iDdeDX8Dnf5W/c2C+YEPzqYlkh
 AURAS8G89Bxkd4+0J0XuAzc6zJnmgkQRRgmwWd0PdcjEm2XeLcfKj/YxnzcEovzcBsThbtlLgAQ
 eoLG6PNVjqNnY3KjRGG3XqZig+3AlkqNKVVK0JF69XWVd4nVSbpmxRoKs5g9p3rK3hQ2pmm56lx
 V6dnRtZlZQf+qcACYPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwMSBTYWx0ZWRfX2lXtHOM8ITsW
 QbODE56xhDqNfL/tEDsUMfqceRzCKeV/yCpJbjIhvXxAtnWWwJqjLL0ifNPntHNDSKcxT0FH7qs
 26Gwvw5am4zLjck/iVUGyxA+k/X0VEg=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a79bce2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Jl-25cGGCxnz-ZAPWPUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lLRUl7BWDQEODsyHjMtR5P-JOLF_rZFr
X-Proofpoint-ORIG-GUID: fG0ZwbHXDL9xX-G4gKDb6EynEZarsSBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100101

Hi,

...
> For majority of the cases this would still keep select_fallback_rq
> as O(N). task_has_preferred_cpus which is O(N) is called only if
> !cpu_preferred. Then task running there is expected to move out.
> So subsequent it should run on preferred CPU. This becomes O(N**2)
> only for tasks pinned only non preferred CPUs. That is rare case.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   kernel/sched/core.c  | 12 ++++++++++--
>   kernel/sched/sched.h | 12 ++++++++++++
>   2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a45f7c308329..9e8eec4451b6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2509,8 +2509,12 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>   		return cpu_online(cpu);
>   
>   	/* Non kernel threads are not allowed during either online or offline. */
> -	if (!(p->flags & PF_KTHREAD))
> +	if (!(p->flags & PF_KTHREAD)) {
> +		/* Try to use preferred CPU if task's affinity allows */
> +		if (task_can_sched_on_preferred(cpu, p))
> +			return false;
>   		return cpu_active(cpu);
> +	}
>   
>   	/* KTHREAD_IS_PER_CPU is always allowed. */
>   	if (kthread_is_per_cpu(p))
> @@ -2520,7 +2524,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>   	if (cpu_dying(cpu))
>   		return false;
>   
> -	/* But are allowed during online. */
> +	/* Try to keep unbound kthreads on a preferred CPU if possible. */
> +	if (task_can_sched_on_preferred(cpu, p))
> +		return false;
> +
> +	/* Otherwise, they are allowed to run on online CPU. */
>   	return cpu_online(cpu);
>   }
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 26ae13c86b69..6de6366f2faa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -4230,4 +4230,16 @@ DEFINE_CLASS_IS_UNCONDITIONAL(sched_change)
>   
>   #include "ext/ext.h"
>   
> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)


Sorry, I glanced to the earlier versions but I couldn't find
the answer to my question. Trivial one but still.

FWICT, task_can_sched_on_preferred() is only being used in
core.c, is there a reason why it is defined in
kernel/sched/sched.h and not in core.c ?

Thanks.
-Mete
