Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C243935B
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618636; cv=none; b=ICtRkoJeJ29BxCBbZkqfFGkJIZ/kaWs1stPXvh4cHFW0WEz4VO1k9LG+5ZiC3tUULiz4wId+OQNk4W5hKtvddBdVkcTK+8YrcGm8mFttAHlpeTKrqvQdZnyD5+S6Mb8tWFkoP43t8WUyqihS7piBjExqdaYOY0u1ki5TYgNdYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618636; c=relaxed/simple;
	bh=wIIWeSKq/jB+Im6BwZ2Uv4hfwaMhBqbXAuLwpnRaUbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDWrEF1uoe7Ue00DINoA9q4itWNrNe/0/oJDPPF/mMdT0oi+5hKmJVhzQdGSMSQC1JSqkrpGEcTDkxrwlJ1Xb6cctxYjUytqkmZ83u9mwLp+SBFpRuIbBSw62kA1A6QOn2qZ11/dEqd305OFfRwDN8ChE3WI8BxC8+SQQjBo1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j/xcsUBr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j/xcsUBr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98n3K810657;
	Thu, 13 Aug 2026 10:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kPk5Zx
	8yFRE3NGrrIs304fR44QBdoZdFSSk2rpHrKq8=; b=j/xcsUBr70MZA94uEbuHaq
	unI75+OmpgOoIIkIBnvc1LmGpRwW/pdOvQxiuJArkuhvLk8sB5TEbmphyeXgsRzH
	B3Pe0ZzonaBhNYOaTe3xFySiAtrLbuVSAWeWMwsdiVPR+H7KTTRxPvU2AXEpOYrI
	Rya5LqfqRH44qnsOMQhcbxM1vZf9FT6J3u0A7YuZ1r3tJUEZpwdwU6l5ulLEzPmN
	Zh3XGeo6HFzudA3mUTM5mWZM+30J2AGbmtbtF6hRleRFE4gd6T/0/JUhc+TLryCJ
	Js1elHHUzuOtg7ZTyXVhNeLmQtmIgCtN0orJ8a3wgwl3oHNddSzSCK5dS7RM0O1Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23yvpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 10:56:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DAuK3o030735;
	Thu, 13 Aug 2026 10:56:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hamqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 10:56:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DAuk6E42271000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 10:56:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE962004B;
	Thu, 13 Aug 2026 10:56:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A9220040;
	Thu, 13 Aug 2026 10:56:38 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 10:56:38 +0000 (GMT)
Message-ID: <895a058a-475e-42ca-a7a3-2c854598eea4@linux.ibm.com>
Date: Thu, 13 Aug 2026 16:26:37 +0530
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
Cc: arighi@nvidia.com, chleroy@kernel.org, christian.loehle@arm.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, frederic@kernel.org,
        gregkh@linuxfoundation.org, hdanton@sina.com, huschle@linux.ibm.com,
        iii@linux.ibm.com, jgross@suse.com, juri.lelli@redhat.com,
        kernellwp@gmail.com, kprateek.nayak@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, maz@kernel.org,
        meted@linux.ibm.com, mingo@kernel.org, pauld@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, rafael@kernel.org,
        rdunlap@infradead.org, rostedt@goodmis.org, seanjc@google.com,
        srikar@linux.ibm.com, tglx@kernel.org, tj@kernel.org,
        tommaso.cucinotta@gmail.com, vincent.guittot@linaro.org,
        vineeth@bitbyteword.org, virtualization@lists.linux.dev,
        vschneid@redhat.com, yury.norov@gmail.com
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
 <20260812194600.52516-1-sunlightlinux@gmail.com> <an0MMNBkyeeZEa8f@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <an0MMNBkyeeZEa8f@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7da2f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=lMnLDdhGCM_T4P2ZDtIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA3MyBTYWx0ZWRfX/TMKqf5ctt/1
 kG76TYE9PRL+HMC8sYZGMXS9IqI/lUq13EGfmDww6SDHSjglLn1w4UZOK34PYTIEWpTbjiUmSYx
 2KiqPYjX3yK3560We+QQmPfh/MP6ODXqFuHT32LoL2/2udZ4cu2hXABPRQiKOGLfjcdrbo9I322
 +jcK/lG1R2n9R4J2L9lBER1A2w7XTmeWVz0P+8cAihPtPyN/oKdgXdDVRDmCl2eSLjJEA/SSnWp
 jCwFm8wecrEHyt5h/qTAOWa0ghTNTZ/C21dBdDUqJ6YHqTV6vvJeFeKz1B6nBX+cftMr1Q37kkc
 sbyJ+ox5mnr5KN+4W1TSX+h5pzmIATsz53wWt+4xWyfaNrWmj7NHmfTSYiH+GxgIgfXs5+FYYTx
 xMlQ6khzqOHLRbp3doPKb3CGUeg2cd/FM7lpsxFYTlPbD4wjd1+Bv0M6BMMXDqgHfsuqnz63mIg
 eobHwZpFJKCVEarMdUQ==
X-Proofpoint-ORIG-GUID: y3Je984rFbcx4a3WR4tYeSCw0ayItFj0
X-Proofpoint-GUID: ryTvXJbGoo1k32toJS12OkUUTWb45A72
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA3MyBTYWx0ZWRfXxpi2Vl95ijha
 pFxf8GsrZNZHQaF4AYHGl9akgtVGSEf+f3aEkAoLJh1/rlx2fzl5YCPlD8vmNQqMQwKSeLJLk9z
 HmAk0A2h/sS3Y/yIgKezgSabhOYBt8I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130073

Hi Ionut, Yury

On 8/13/26 5:43 AM, Yury Norov wrote:
> Hi Ionut,
> 
> Thanks for the details. It was indeed an informative reading. Let me
> add a couple notes below.
> 
> Thanks,
> Yury
> 
> On Wed, Aug 12, 2026 at 10:45:56PM +0300, Ionut Nechita (Sunlight Linux) wrote:
>> On Wed, Aug 12, 2026 at 11:10:21AM +0530, Shrikanth Hegde wrote:
>>> This patch series represents the result of multiple iterations,
>>> redesigns and community feedback.
>>
>> Nice work, and thanks for the very readable cover letter.

Thanks for reading and going through the series. Really appreciated.

>>
>> I looked at this from the KVM and Xen guest angle rather than from
>> PowerVM, since that is what I run.  Three observations below.  All of
>> them are from code inspection only -- I have not measured any of this,
>> so please treat the numbers as arithmetic rather than as results.
>>
>> Code references are against next-20260812, which already carries your
>> base commit f2c2ba7219e5, so the series applies there directly.
>>
>>
>> 1) Default thresholds are unreachable on common QEMU command lines
>> ==================================================================
>>
>> get_system_cpus() returns num_possible_cpus(), and steal_governor_loop()
>> divides by it:
>>
>> 	delta_ns = max_t(u64, div_u64(delta_ns * get_system_cpus(), 10000), 1);
>> 	steal_ratio = div64_u64(delta_steal, delta_ns);
>>
>> On x86 the possible map is sized by topology_init_possible_cpus()
>> (arch/x86/kernel/cpu/topology.c) from assigned + disabled CPUs, where
>> "disabled" is incremented by topo_register_apic() for every APIC that is
>> registered but not present.
>>
>> QEMU emits exactly such MADT entries for the range [smp, maxcpus), and
>> acpi_is_processor_usable() in arch/x86/kernel/acpi/boot.c documents that
>> this is deliberate:
>>
>> 	/*
>> 	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as
>> 	 * usable in order to support CPU hotplug in guests.
>> 	 */
>>
>> So those vCPUs are registered as usable, land in nr_disabled_cpus, and
>> end up in the possible map.  A guest started with
>>
>> 	-smp 4,maxcpus=32
>>
>> has num_possible_cpus() == 32 while only 4 vCPUs ever run.  The steal
>> ratio is then diluted 8x, and the default thresholds of 5% / 2% become
>> 40% / 16% of the steal that is actually observable.  The governor never
>> leaves the "do nothing" window, and the only symptom is that nothing
>> happens.
>>
>> Xen PV guests are affected in the same way, and often more strongly,
>> because the possible map there tends to be sized for vCPU hotplug.
>>
>> I understand from the v9 changelog why possible CPUs were chosen -- it
>> keeps the accumulated steal monotonic across hotplug, which is a real
>> property worth having.  The documentation does describe the effect and
>> gives a worked example for recomputing the thresholds by hand.  But for
>> a mechanism whose whole premise is that every VM on the host opts in
>> with the same policy, requiring each operator to first derive their own
>> thresholds seems likely to translate into low real-world adoption.
>>
>> Some options, roughly in increasing order of intrusiveness:
>>
>>    - emit a pr_info() (or pr_warn()) at module init when
>>      num_possible_cpus() significantly exceeds num_online_cpus(), naming
>>      the ratio and the effective thresholds.  Cheap, and turns a silent
>>      no-op into something diagnosable.
>>
>>    - scale the thresholds by num_possible_cpus() / num_online_cpus() at
>>      init, so the documented defaults keep their intended meaning.
>>
>>    - keep summing steal over the possible mask, as today, but divide by
>>      the online count, and handle the hotplug discontinuity by resetting
>>      the sg_ctx.steal baseline from a hotplug notifier.
>>
>> I do not have a strong preference among these, and the first one alone
>> would already be a large improvement.
> 
> I asked the same question on v9 iteration, but the problem is still
> there. I don't think that VM with a big number of offlined CPUs is
> something that needs to bring admin's attention with pr_info(). The
> solution should be found withing the driver.
> 
> I thought about saving the steal time for each CPU in an array, so on
> the next iteration we count steal time from the same subset of CPUs,
> regardless of hot plugging.
> 
> Your approach with num_possible_cpus() / num_online_cpus() scale looks
> nicer, if it works. Definitely need a testing for both. Resetting the
> steal baseline on each hotplug is another option, but to me the least
> attractive.
> 
> This problem must be resolved this way or another before we merge the
> driver.
> 

Looking back at based on what you guys suggested,
i am thinking if we do number of active CPUs, it might work.

The reason being, only active/online CPUs will contribute to delta increase.
Since we sum across possible CPUs, spikes due to hotplug will not happen.

See the diff at the end about returning active CPUs.

>> 2) Nothing stops the driver from folding Xen dom0
>> =================================================
>>
>> dom0 accounts steal time like any other domain -- xen_time_setup_guest()
>> in arch/x86/xen/time.c wires up pv_steal_clock unconditionally, with no
>> feature negotiation and no privileged-domain exemption.
>>
>> So loading steal_governor in dom0 makes it shrink its own preferred mask
>> under contention.  That is precisely when the blkback and netback
>> threads serving every other guest need CPU, and the driver has no notion
>> that this domain is different from the ones it is trying to be polite
>> towards.  The effect would be host-wide, not confined to the domain that
>> loaded the module.
>>
>> Given that Kconfig carries "default m", the module is built on any
>> distro kernel with PARAVIRT=y, which includes dom0 kernels.  It is one
>> modprobe away from being loaded there, quite plausibly by someone who
>> read the documentation's advice to enable it uniformly across all VMs.
>>
>> A xen_initial_domain() check that refuses to load, or at minimum a loud
>> warning, seems worth having.  More generally it may be worth stating in
>> the documentation that the driver is meant for guests only -- the same
>> argument applies to a KVM host that is itself running nested guests.
>>
>> Juergen and the virtualization list are already on Cc -- I would value
>> their view on this one in particular.
>>

I prefer this could be done by arch specific hooks. For the initial series,
this has been deferred.

I had __weak symbols way of allowing arch specific hooks. But it isn't very common
practise as yury suggested. So for now, it has been deferred.

For now, i have added check for not loading on dom0.

>>
>> 3) Core granularity degenerates to single vCPUs on KVM and Xen
>> ==============================================================
>>
>> decrease_preferred_cpus() and increase_preferred_cpus() step by
>> topology_sibling_cpumask(), which matches PowerVM, where the hypervisor
>> schedules whole cores.
>>
>> On Xen PV that mask is always the CPU itself, by design.  The header
>> comment of arch/x86/xen/smp_pv.c is explicit about both the behaviour
>> and the reason for it:
>>
>> 	/*
>> 	 * Because virtual CPUs can be scheduled onto any real CPU, there's
>> 	 * no useful topology information for the kernel to make use of.  As
>> 	 * a result, all CPUs are treated as if they're single-core and
>> 	 * single-threaded.
>> 	 */
>>
>> A plain "-smp N" under QEMU gives one thread per core and one core per
>> socket, with the same result.  So on both hypervisors the step size is
>> one vCPU, and convergence to a folded state takes proportionally longer
>> than the PowerVM numbers would suggest.
>>
>> I do not think this is a correctness problem -- per-vCPU is arguably the
>> right granularity there, for exactly the reason the Xen comment gives.
>> The case that does not work as intended is the opposite one: a guest
>> given a synthetic topology such as
>>
>> 	-smp 16,sockets=1,cores=8,threads=2
>>
>> will fold what it believes is a core, but those two vCPU threads need
>> not be co-located on any host core, so nothing in particular is freed.
> 

vCPU effectively becomes a running thread/task in host. So even with KVM,
doing core level means for example SMT2, it means two less tasks in host
compared to 1. Even though it can run anywhere, it should converge faster.

I don't see why using core will hurt. Maybe I am missing to see it.

> On 2 and 3.
> 
> If the governor will become a practical tool for admins, I believe
> there will be the more corner cases, the more adoption the driver
> gets.

Yes.

> 
> That's why I suggested the modular architecture for the governor. Now
> we have 2 options:
> 
> 1. Keep the driver as a single module, and add those checks for DOM 0

You mean add below check in this driver?

I have added it and once we have arch spefific implementation, we can remove it.

#ifdef CONFIG_XEN
	if (xen_initial_domain()) {
		pr_err("Cannot load in Xen Dom0 (Host OS). Driver is for guests only.\n");
		return -ENODEV;
	}
#endif

See the diff in the end.

>     and per-core vs per-thread behavior.

Unless we see using core level hurts, i don't see a reason why we should
switch to per CPU. If one has numbers for using per cpu method is better for KVM/XEN,
then we can bring in that optimization IMHO.


> 2. Rename this driver to powervm_steal_governor, and let KVM and XEN
>     engineers implement their own drivers.


I prefer to keep it as generic, since it would work fine for XEN too.
I am okay to even add XEN specific checks so it stays as one generic module.
This would help avoid many archs doing same thing more or less with few addition
debug checks. Renaming it to powervm_steal_governor would likely
fragment the solution.

> 
> The options are not mutually exclusive. The earlier versions of the
> driver had a 'core' part and hooks for different arches.
> 
> At this point, I believe, keeping the driver simple is the most
> important goal for making it upstreamable. When it's merged, it
> will be much easier to add more functionality and tuning for
> different VMs and architectures.

That's what I would prefer :)

>   
>> So mainly a documentation request: a sentence in
>> Documentation/driver-api/steal-governor.rst noting that the core-level
>> step assumes the guest topology reflects host scheduling granularity,
>> and that on KVM and Xen it commonly does not.  It would also explain to
>> readers why convergence looks slower there than in your PowerVM numbers.
> 
> I agree, this should be documented.

Ok. See the diff it the end.

> 
>> --
>>
>> I would be happy to run this on x86 KVM and on Xen PV guests if that is
>> useful -- the series has no Xen coverage that I can see, and points 1
>> and 3 above would both show up there first.
> 

If you can try the series it would help.
take the below patch and apply it on top.


> I didn't test the patches myself yet, mostly because configuring VMs
> is a separate topic. If you share a script that configures an
> environment with paravirtual VMs that run some payload that overcommit
> the vCPUs, it would be a valuable addition to the series.
> 
> Andrea Righi with his virtme is already in CC. It's a very friendly
> and highly configurable wrapper around qemu that allows to compile a
> and run kernel with a couple commands. Andrea, can the virtme prepare
> such an environment? For testing we need:
> 
>   - several paravirtual VMs, so that the number of vCPUs exceeds the
>     number of CPUs, and
>   - some payload running on them to overcommit the vCPUs, triggering
>     the steal time counter.
> 
> Thanks,
> Yury

I think below should address all the three concerns.
Let me know if i missed anything.

Only compiled tested for x86 CONFIG_XEN.

---

diff --git a/Documentation/driver-api/steal-governor.rst b/Documentation/driver-api/steal-governor.rst
index 672eeccabfe8..62add9f59032 100644
--- a/Documentation/driver-api/steal-governor.rst
+++ b/Documentation/driver-api/steal-governor.rst
@@ -102,22 +102,17 @@ reduce the preferred CPUs by 1 core.
  Limitations of default values
  -----------------------------
  
-Because of the vast diversity in VM configurations (e.g., highly populated
-vs. sparsely populated CPU masks, few offlined CPUs etc), the default
-thresholds may not be optimal for all systems. Users may need to tune these
-parameters based on the system under test to achieve the best results.
-
-For example:
-Possible CPUs = 128 and Active CPUs = 8
-Steal on online CPUs = 50%
-steal ratio: (50% * 8 + 0% * 120) / 128 = 3.125%
-This would fall in between and default values won't work.
-In this example, if one wants effective 2% and 5% limits, then set,
-low_threshold  = (2% * 8 + 0% * 120) / 128 = 0.1250% = 12
-high_threshold = (5% * 8 + 0% * 120) / 128 = 0.3125% = 31
+Because of the vast diversity in VM configurations, the default
+thresholds may not be optimal for all systems.
  
  Using possible CPUs helps to handle spikes during CPU hotplug as the steal
-time across possible CPUs is a monotonically increasing value.
+time across possible CPUs is a monotonically increasing value. Effective delta
+for steal time can come via only active CPUs. Current logic is effective for even
+sparsely populated systems. But, some corner cases can still linger.
+
+Driver reduces/increases preferred CPUs by core-level. This could provide faster
+convergence for hypervisors such as powerVM. But on KVM and Xen convergence
+could be slower depending on the configuration.
  
  Reasons for CONFIG_STEAL_GOVERNOR=m
  ===================================
@@ -132,6 +127,6 @@ It is recommended to build CONFIG_STEAL_GOVERNOR=m due to below reasons:
  
  2. This works well when all VMs work in co-operative manner. When an
     administrative user enables it in one VM, he/she will likely enable
-   it all VMs.
+   it all VMs. But Note that, it should be enabled it only on actual guests.
  
  3. User can tweak the module parameters by reloading the module.
diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index ee92152e64cc..a25eb50a4c7b 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -28,6 +28,10 @@
  #include <linux/types.h>
  #include <linux/workqueue.h>
  
+#ifdef CONFIG_XEN
+#include <xen/xen.h>
+#endif
+
  #if !IS_ENABLED(CONFIG_PREFERRED_CPU)
  #error "Steal Governor requires CONFIG_PREFERRED_CPU"
  #endif
@@ -122,7 +126,7 @@ static u64 get_system_steal_time(void)
  /* Return number of CPUs to consider for steal ratio. */
  static unsigned int get_system_cpus(void)
  {
-       return num_possible_cpus();
+       return num_active_cpus();
  }
  
  /*
@@ -254,6 +258,13 @@ static void steal_governor_loop(struct work_struct *work)
  
  static int __init steal_governor_init(void)
  {
+
+#ifdef CONFIG_XEN
+       if (xen_initial_domain()) {
+               pr_err("Cannot load in Xen Dom0 (Host OS). Driver is for guests only.\n");
+               return -ENODEV;
+       }
+#endif
         if (sg_ctx.low_threshold >= sg_ctx.high_threshold) {
                 pr_err("low_threshold (%u) must be less than high_threshold (%u)\n",
                        sg_ctx.low_threshold, sg_ctx.high_threshold);

