Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383138F94C
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952402; cv=none; b=dhZ35LM0sVLZqKBuyJZcMNP3hBCanKJHemn9Q1qwVnrdKe83y5v3XByYHLd0ysFr9dQWB0RBHxo4IpC2+vOYqlPlF78b/7YFsek8llfM60/N8jwltHeg1BXCH3eKKMwv2ETS4bLQqucLXBJtFADWVq7SNhmcoV1w5i46H86gSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952402; c=relaxed/simple;
	bh=p+5KsWp7Vxn+ZlwnXQi/31NvKA1uZNkC4C7jfZa55Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8dWAoiythLdL7Uyt/y25WhlsxOE0o0uOD0pZ02U+W6hmCuPLRJsqt5XbV1PI/5eu3aRiZ/YdlNMRX1Tn34u1MKiIffPXTuwhptFarLA95BFEbD2m4Xz8BlPYi1XjgnJaLKeT5EgPaJ1hHWDaAiWuJnrOB8vSSXappBDC2ovZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hMIqdrV0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hMIqdrV0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVepI1865988;
	Mon, 17 Aug 2026 07:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HDGdjk
	i57rgy8smdqMfAFIMKmeK7wqJmr1SK3+L+4PE=; b=hMIqdrV02EXqrBtdZuLZcj
	s7FMejHvNFYoEurVDWnD5iSlBQCpyGTeGiAwp/+kuJ5VZYSp6q3pS8hJxAqFcWj2
	3Uupgl8NAXnfInmN2scDzpG6uLLySdSsfADzd+4gNMYNg4HfrOhHDM4NOwuqyUIa
	M30AFqymdCbFiZM7XUQOPCNuMgftxM6RNtSk1Hi3tL4P4nAqWzt19IiXuZ6dDL2H
	5khfFtaxsTypCOpG5zef2Fx8kgAQRewns6P4GSKgRUTzJ8dhCMGpG5K4CynL+065
	arBMWjK4WMDVeXFw4iqAD07QbYCXa/JbK2KkN4P+G91laeauTMtRXFYYFwYAd4nA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqgwsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:39:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H7QLVx027795;
	Mon, 17 Aug 2026 07:39:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xgvu9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 07:39:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H7dX4W44958190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 07:39:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F81D20040;
	Mon, 17 Aug 2026 07:39:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E073820043;
	Mon, 17 Aug 2026 07:39:24 +0000 (GMT)
Received: from [9.124.211.62] (unknown [9.124.211.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 07:39:24 +0000 (GMT)
Message-ID: <0f3307c8-6fc9-49b6-93e4-7ffd85dd0c16@linux.ibm.com>
Date: Mon, 17 Aug 2026 13:09:23 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/12] sched, steal_governor: Introduce preferred CPUs
 and steal-driven vCPU backoff
To: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com
Cc: tglx@kernel.org, gregkh@linuxfoundation.org, pbonzini@redhat.com,
        seanjc@google.com, vschneid@redhat.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, maddy@linux.ibm.com,
        srikar@linux.ibm.com, hdanton@sina.com, chleroy@kernel.org,
        vineeth@bitbyteword.org, frederic@kernel.org, arighi@nvidia.com,
        pauld@redhat.com, christian.loehle@arm.com, tj@kernel.org,
        tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
        rdunlap@infradead.org, kernellwp@gmail.com, linux-doc@vger.kernel.org,
        jgross@suse.com, virtualization@lists.linux.dev,
        "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfX3DrnLnG51ayJ
 T01d6c07aNMAmjCVnUCboosdsN9WMSFb2oUHTjZeqLoHx9v6ZGjmVEJQ/eUR6V0yP39KzPGeAry
 eLwpXccVMcL82rXZ3HnxxRxkPN34jI8BjHdlvS3VDYHYFlnE/o56KSafg/U3js6h/1tov7j1ltO
 MO9w+uxZ7V7Mtn4sqinDp9vkb9qJ5IedR8ZlS9+PmDwc0Ec1WXuoC7ZSIoXFZYvU3vxWYgClpLG
 Lt+FusymU1YMnsJobTGAvcPliFVufcpwCFbEALp+XSdpFX2k+WrD/TGjEndWfnbFgYNHHWknin/
 Eck85SCgHft7I/fLbwQpeUfxU072pHa8EO13+7YnNsXfnQw4sV8lNPFLIevZDSXMnA2L6JO9T2H
 8OzrxRXmJjFdnI/YZ85PftAkb19tcK5bSZPOxCIzEFILM84/2nfqcXvJB7j3uCAvcszZN5Aqo1T
 x0+yPX83OMRYJb9T0MA==
X-Proofpoint-ORIG-GUID: NYY4IxL8eUlLnlHDUZp7sJ45EKQcizDc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1NSBTYWx0ZWRfX3HoaWR/YxrYh
 8tTpjCLuTceIOXCzT247z3/oxMIVkI65RwKp5tdvkrImdKZfCkJxf+XcjmyTpSZdYQkMzLUyYtp
 QbPCmzoDHpM/WKwZI9svFTA7eHlrUQo=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a82babb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=qfXeEdIPvJuSM99UPqoA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 5oAXszO-fYpLQZdocfXTfPlg7-MHSjsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170055

Hi.

In addition to what's currently planned for v11 which was posted here,
https://lore.kernel.org/all/895a058a-475e-42ca-a7a3-2c854598eea4@linux.ibm.com/

I was going through sashiko's comments at:
https://sashiko.dev/#/patchset/20260812054033.95658-1-sshegde%40linux.ibm.com
This has revealed some gaps. Thanks to some really nice insights too.
Report quality improving day by day!


Vincent, Dietmar, please check the 32-bit task issue fix on ARM64.


On 8/12/26 11:10 AM, Shrikanth Hegde wrote:
> If you have already read v8,v9 cover-letter then see only revision
> changes. everything else is pretty much same. :)
> 

> v9->v10:
> - Introduce kcpustat_field_total helper. (Yury Norov)
> - Always do the design checks. This helps to avoid placing design
>    constraints in core hotplug code.
> - Remove cpu_preferred check in idle balancing. This helps to naturally
>    take care update of nohz.next_balance.
> - find_new_ilb changes are deferred as it isn't applicable for most
>    common use cases.
> - Move scheduler documentation to sched-paravirt.rst. (Yury Norov)
> - Add details of limitation of default values in documentation. (Yury Norov)
> - Remove task_can_sched_on_preferred out of sched.h (Mete Durlu)
> - Updated suggested-by tags for few patches. (I know i should have
>    done it earlier, sorry about that)
> - Minor polish of all changelogs.
> 



++++ Patch [1]: [PATCH v10 01/12] sched/cputime: Add kcpustat_field_total helper ++++
Issue:
======
>>  	int cpus, cpu;
>Does this code leave the local variable cpu unused?
>Since the for_each_cpu loop was replaced with a call to kcpustat_field_total,
>cpu does not appear to be referenced anymore in hd_calculate_steal_percentage.

Fix:
====
I did miss to notice it. Will fix it in v11.

index e5c7c818c178..c21496f0a141 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -207,7 +207,7 @@ static unsigned long hd_calculate_steal_percentage(void)
  {
  	unsigned long time_delta, steal_delta, steal, percentage;
  	static ktime_t prev;
-	int cpus, cpu;
+	int cpus;
  	ktime_t now;
  

++++  Patch [5]: [PATCH v10 05/12] sched/core: Try to use a preferred CPU in is_cpu_allowed ++++

Issue1: Possible crash on 32-bit tasks on ARM64.
=======
>> +static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
>> +{
>> +	if (cpu_preferred(cpu))
>> +		return false;
>> +
>> +	/* Only FAIR tasks honor preferred CPU state */
>> +	if (unlikely(p->sched_class != &fair_sched_class))
>> +		return false;
>> +
>> +	return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
>> +}
>Does this intersection check need to account for the architectural CPU mask?
>On asymmetric systems, 32-bit tasks are architecturally restricted by
>task_cpu_possible_mask(). If a 32-bit task's mask intersects with
>64-bit-only preferred CPUs, this function might return true, causing
>is_cpu_allowed() to falsely return false for valid 32-bit non-preferred CPUs.
>Since 64-bit CPUs are rightfully rejected by task_allowed_on_cpu(), all CPUs
>end up rejected. Could this regression cause the select_fallback_rq() loop
>to exhaust all options and hit the BUG() case for 32-bit tasks?

Fix:
====
I wasn;t aware of this case, thanks to sashiko for bring it up.
Yes, it could potentially cause a BUG in select_fallback_rq.

Do a simple check if mask differ from possible mask which indicates we are on 32-bit task on 64 bit
kernel. Do the below. I think that should solve it.

  static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
  {
+	const struct cpumask *valid_mask;
+	int i;
[...]
+	valid_mask = task_cpu_possible_mask(p);
+	if (likely(valid_mask == cpu_possible_mask))
+		return cpumask_intersects(p->cpus_ptr, cpu_preferred_mask);
+
+	/* 32-bit task */
+	for_each_cpu_and(i, p->cpus_ptr, cpu_preferred_mask) {
+		if (cpumask_test_cpu(i, valid_mask))
+			return true;
+	}


Issue2:
=======
>How does this impact the migration stopper thread during sched_setaffinity?
>When sched_setaffinity updates p->cpus_ptr, it schedules a stopper thread
>to migrate the task. The destination CPU is selected without knowledge of the
>new preference logic in __set_cpus_allowed_ptr_locked():
>    dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
>If this randomly chosen destination is a non-preferred CPU, __migrate_task()
>will observe is_cpu_allowed() returning false:
>kernel/sched/core.c:__migrate_task() {
>    ...
>    if (!is_cpu_allowed(p, dest_cpu))
>        return rq;
>    ...
>}
>Will this regression cause __migrate_task() to silently abort, leaving the
>task running outside its new explicitly allowed cpumask?

Fix:
====
This is a possible race with script which tries to change affinity at the same window
where preferred CPU mask has changed, but sched_tick hasn't run yet and new affinity
mask is spanning across both preferred and non-preferred CPUs and dest_cpu chosen by
cpumask_any_and_distribute is a non-preferred CPU.
So it is a very narrow case, but a possible one. This results in a
task which never gives up CPU, might run outside of its affinity.

Fix it by checking new affinity allows it run where it is currently running.
If not, don't make decision based on preferred CPU state.
cpus_ptr is updated before __migrate_task.

@@ -2503,7 +2506,20 @@ static inline bool task_can_sched_on_preferred(int cpu, struct task_struct *p)
  	if (unlikely(p->sched_class != &fair_sched_class))
  		return false;
  
+	if (unlikely(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr)))
+		return false;


++++ Patch [7]: [PATCH v10 07/12] sched/core: Push current task from non preferred CPU ++++

Issue1:
>> +#ifdef CONFIG_PREFERRED_CPU
>> +static DEFINE_PER_CPU(struct cpu_stop_work, npc_push_task_work);
>> +
>> +static int sched_non_preferred_cpu_push_stop(void *arg)
>> +{
>> +	struct task_struct *p = arg;
>> +	struct rq *rq = this_rq();
>> +	struct rq_flags rf;
>> +	int cpu;
>> +
>> +	if (cpu_preferred(rq->cpu)) {
>> +		scoped_guard(rq_lock, rq)
>Does acquiring rq_lock here without disabling local interrupts create a
>deadlock window?
>The stopper thread executes this callback with preemption disabled but local
>interrupts enabled. If a timer interrupt fires while this lock is held, the
>interrupt handler will call sched_tick() which attempts to acquire the local
>rq->lock via rq_lock(rq, &rf), leading to an immediate self-deadlock.
>Should this early exit path use rq_lock_irq or rq_lock_irqsave instead?

Fix:
===
Yes a possible window exists. Disable irq when taking rq lock.

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b2c011824a7d..51cf0b40a7dd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11335,7 +11335,7 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
         int cpu;
  
         if (cpu_preferred(rq->cpu)) {
-               scoped_guard(rq_lock, rq)
+               scoped_guard(rq_lock_irqsave, rq)
                         rq->push_task_work_done = false;
                 put_task_struct(p);
                 return 0;


Issue2:
======
>> +void sched_push_current_non_preferred_cpu(struct rq *rq)
>> +{
>> +	struct task_struct *push_task = rq->curr;
>> +
>> +	scoped_guard(rq_lock, rq) {
>> +		/* Push the task if its explicit affinity allows */
>> +		if (!task_can_sched_on_preferred(rq->cpu, push_task))
>> +			return;
>> +
>> +		/* There is already a stopper thread. Don't race with it. */
>> +		if (rq->push_task_work_done)
>> +			return;
>> +
>> +		rq->push_task_work_done = true;
>> +	}
>Could missing a check for is_migration_disabled(push_task) here cause a
>severe preemption storm?
>Since the stopper thread unconditionally queues without verifying if the task's
>migration is temporarily disabled, it will preempt the task. When the stopper
>observes !is_migration_disabled(p) is false, it resets rq->push_task_work_done
>and exits without migrating the task.
>On the very next timer tick, sched_tick() will observe the task is still on a
>non-preferred CPU and queue the stopper thread again. This continuous queueing
>of the highest-priority stopper thread every tick while migration is disabled
>defeats the purpose of the migration-disabled section.

Fix:
====
Do the same check before queuing the stopper too.
i.e. same check that happens in stopper.

@@ -11378,6 +11394,9 @@ void sched_push_current_non_preferred_cpu(struct rq *rq)
  		if (rq->push_task_work_done)
  			return;
  
+		if (is_migration_disabled(push_task))
+			return;
+
  		rq->push_task_work_done = true;



============================================================

Other comments which are worth noting, but are not a concern.

- time of use, time of check issue in select_fallback_rq w.r.t to preferred
   mask change. As explained in earlier changeset, this cannot happen since
   select_fallback_rq does two loop. First of nodemask, and then cpus_ptr.
   Lets due to concurrent mask change, first one fails, then by second loop, mask
   will be stable, and cannot race again. Mask updates by 100ms at least.

- Overloading of preferred CPUs. That is expected by design.

- Could the __read_mostly annotation on __cpu_preferred_mask cause cache line
   bouncing and false sharing? Kept as __read_mostly as majority of the time is
   isn't changing.

- Ping-pong doesn't happen since load balance doesn't push tasks onto preferred
   CPUs.

- Does triggering select_fallback_rq() on the hot wakeup path introduce a
   lock contention bottleneck? - yes but not too much, but adding more
   checks there, add more overhead in generic case.
   So it is optimization that is avoided at the moment.

- A non-preferred CPU isn't expected to pull any load and there is no load balancing
   among non-preferred CPUs as said in the changelog.
