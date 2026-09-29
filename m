Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1425B08D;
	Tue, 29 Sep 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693912; cv=none; b=HdX17PDg1ZfObcMvyK0GvME5IkuRJpKKpCKVqc8wdrl8RvWVIr6qWB4GGWSu56MrrE+JR1op9b4xtyi+61Fvd/eogntrGWuWX/q4IckFNctdJqwqgBKoK+AXzcl0Q2RtvCGGmbV4mMM8673mGM8t9Cw2sDgteYpr4CpbWwdLCL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693912; c=relaxed/simple;
	bh=DqeI++b161KtjAHzethdo3fEox1c19TAWzryZUcs3tE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=as4win80LZtCRamsrXqvWfMXD/QrhY6D8ZMAavSThFoli1LFUnHys8YvUNm05Mf0sITpJ6RjH7zXS8nQ7otootw7TukT6t7bOSOocfP5D7A4XCbvz9ZcQjDIQb9XPFGpdLNxhc8NaYN7V3fKOCg6KYC34cUpyBdiczI7RoidorQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XvvrqjJq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XvvrqjJq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB6GLY2189632;
	Tue, 29 Sep 2026 14:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R6JfXv
	ppDwndtGpHNaqd1NG4kbQK5XAbphIjZn2QMB4=; b=XvvrqjJqEMZ89mSdXaLySS
	CjMLp6MTIbywHpMoH9g+y4QVCQAscidvC84BgYYBCsDGT1/Z6vuQQOy4iZIfCCOY
	WdK0UuxJrJ5UWKZ53D7fFcS/UIRk4Gq3HYZzy/bKf6CmZ2+0LV53SLbm1//1UPUS
	ctXPDId3zJAV1Wakmxi7nI/NSrZ6DeedMlmA/ecpgei04M2kmKvbBa1n2PZmOsPJ
	8O8K7cpFPeSvlrPp6PBGtS+umhzQUvgFZ8EGvyt2CXr4KgVGL9E7T6DMOVymFHGT
	Wb0SPsavtNZKUxSrUk51KyQBHexVefyUFtjdF1wlw3M3VLxWclBDZY5dU2OHk4ow
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr7mf1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 14:57:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlU6r1667670;
	Tue, 29 Sep 2026 14:57:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhj493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 14:57:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TEvPqG50397614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 14:57:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05FBF20043;
	Tue, 29 Sep 2026 14:57:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC00D20040;
	Tue, 29 Sep 2026 14:57:14 +0000 (GMT)
Received: from [9.124.214.246] (unknown [9.124.214.246])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 14:57:14 +0000 (GMT)
Message-ID: <4cd3d839-ac67-43ac-9b22-0ded9c3d1f41@linux.ibm.com>
Date: Tue, 29 Sep 2026 20:27:13 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, yury.norov@gmail.com,
        kprateek.nayak@amd.com, iii@linux.ibm.com, corbet@lwn.net,
        meted@linux.ibm.com, ynorov@nvidia.com, tglx@kernel.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
        vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
        hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
        frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
        christian.loehle@arm.com, tj@kernel.org, tommaso.cucinotta@gmail.com,
        maz@kernel.org, rafael@kernel.org, rdunlap@infradead.org,
        kernellwp@gmail.com, linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com,
        Marco Elver <elver@google.com>, llvm@lists.linux.dev
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-10-sshegde@linux.ibm.com>
 <20260929121838.GA1814129@ax162>
 <2964a7d8-8765-435c-af9e-a38024fca877@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <2964a7d8-8765-435c-af9e-a38024fca877@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1OCBTYWx0ZWRfX8QE/bA12ixhQ
 GGCKHdguXOu1egtpLmNkSa72JDnNMUZZ2Nmdt/wi83+3+cOVbAa2IpqRkuF7MOcB8GvpIImbYbU
 /aCAv+pPZakCSsC1GlsvoT/gCc9aOb59pG2Rx0+IKXxlZTfOt7ZL/SheaULLw+dWbMZ87UvRl4V
 VN0912Q/srwuFVnIEGjB2c04S8HBrELYySY2GNulZSMXYXoFoaD8BhjkksgcGH9xejrkckPVSXd
 vTj14oAZFjUZqAj+p3j9mA2NLBMVN2u5DIBo5wg53YTM8zhoubcH8fjxEqqPMNfsy66lyCh9qPQ
 x4HPZzxdQlnj417zp1Zt154lkdDESxmR/7xHkSzuG7w0Eg4sUciwy1KBe0AhOHhbjMfxf6H3x28
 vClA6jrMbejcXQH6K8RLy4eXh5PYG0+NHPVgSA0uj01b8XzXUeTuzqJkdvLfx+yujh84XYgwW8x
 9qZMiUZ1g5tD8mAH+dA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbd1db cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=dZdlNAd9hR_1z_CP-BwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mldWp8I46kJ4NJJmp9bnC7Hus2sjzBBG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1OCBTYWx0ZWRfX01DnDrelLr55
 9G7RaKzPyTtiTdojcqqAUfqUz2rKVRzPClp7+lgC8uZqV83DRtWhwwgLx0fYqxCFTaEF4HbsXUx
 Mbl++ljY7hRH8BlRm78TNcWAhW0HNhQ=
X-Proofpoint-GUID: GtyHGCHu9-nvngSu4wczeaSac3lOIR3C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290058

Hi Nathan.

On 9/29/26 6:13 PM, Shrikanth Hegde wrote:
> Hi Nathan. Thanks for report.
> 
> On 9/29/26 5:48 PM, Nathan Chancellor wrote:
>> On Mon, Sep 28, 2026 at 11:07:24AM +0530, Shrikanth Hegde wrote:
>>> Add a new per-task stat,
>>> - nr_migrations_cpu_non_preferred: number of push migrations while the
>>>    CPU is non-preferred.
>>>
>>> Since this new stat is per-task, it changes only /proc/<pid>/sched.
>>> It doesn't update /proc/schedstat. Hence increasing the schedstat version
>>> is not necessary.
>>>
>>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ...
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 5049eff58fb7..7465c983e6f6 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -11236,8 +11236,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
>>>           update_rq_clock(rq);
>>>           context_unsafe_alias(rq);
>>> -        if (task_rq(p) == rq && task_on_rq_queued(p))
>>> -            rq = __migrate_task(rq, &rf, p, cpu);
>>> +        if (task_rq(p) == rq && task_on_rq_queued(p)) {
>>> +            struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
>>> +
>>> +            if (rq != dest_rq)
>>> +                schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
>>> +            rq = dest_rq;
>>> +        }
>>>           rq_unlock(rq, &rf);
>>>       }
>>
>> This breaks the build for me with clang-23+ (which have context analysis
>> enabled by default), although it bisects to the final patch of the
>> series since this is under CONFIG_PREFERRED_CPU and it is not selected
>> until then.
>>
>>    kernel/sched/core.c:11292:25: error: calling function '__migrate_task' requires holding raw_spinlock 'rq_lockp(rq)' exclusively [-Werror,-Wthread-safety-analysis]
>>     11292 |                         struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
>>           |                                              ^
>>    kernel/sched/core.c:11298:3: error: releasing raw_spinlock 'rq_lockp(rq)' that was not held [-Werror,-Wthread-safety-analysis]
>>     11298 |                 rq_unlock(rq, &rf);
>>           |                 ^
>>    kernel/sched/core.c:11303:1: error: raw_spinlock 'rq_lockp(__this_rq())' is not held on every path through here [-Werror,-Wthread-safety-analysis]
>>     11303 | }
>>           | ^
>>    kernel/sched/core.c:11286:3: note: raw_spinlock acquired here
>>     11286 |                 rq_lock(rq, &rf);
>>           |                 ^
>>    3 errors generated.
>>
>> Not sure what the proper fix for this is, maybe another
>> context_unsafe_alias()? cc Marco just in case
>>
> 
> I suspect it is due to using of dest_rq = rq and rq is changing context.
> 
> let me try locally and see the fix.
> One fix is use rq->cpu instead of rq comparison to see if migration happened.

Well, it was rather due to Patch 8/13 which had rq marked as context_unsafe_alias
after acquiring it.

I have tried below and that helps to fix the warnings.
I will write a changelog and send it across soon.

Let me know if it works for you.

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0bb86a43a592..23677d76f9d2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11283,10 +11283,10 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
  		 * safely bail out.
  		 */
  		cpu = select_fallback_rq(rq->cpu, p);
+		context_unsafe_alias(rq);
  		rq_lock(rq, &rf);
  		rq->npc_push_work_pending = false;
  		update_rq_clock(rq);
-		context_unsafe_alias(rq);
  
  		if (task_rq(p) == rq && task_on_rq_queued(p)) {
  			struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
