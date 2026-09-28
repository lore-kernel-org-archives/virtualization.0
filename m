Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78033384CEE
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573901; cv=none; b=bEeFgyDATyZeQl9io85ZUztiSZdssjGpBPMAkK9zkCYyPAXfBU1L0imKwX3CRLbyJ7VyV7qjraQRo5PDXcPliIesIBuRnuv2DsHDdLTX7KE8dKnVRMiqHA1sFrpuSx/Je19QaKjgwfpfn/ArZ0oezvCWrBRRULjPyaGjCn/5qMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573901; c=relaxed/simple;
	bh=TYGKxPYTAOdqftBqNAkDxK0SceR0TRCnNMrtg8X0A1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/dzDwaqwSduTUa5aq4AS2ezuaY0Mcabd37R2+LW8qF1Zqw7A0QvWYTaEJyHYq9sml4gBcUcpvzgPhDgr+hNgNlZNBXkKDAaCOyOgQoYgskQcHfw/2fomFcakbEpiN6/cDhl+EwM5iznJWigpqmMv/KeL5zmUj/1feGBkP5Yzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OqESwM6Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OqESwM6Q"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RH1oxZ028960;
	Mon, 28 Sep 2026 05:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9DZPx3X+a2qgDnwp9MX+cEGG3fHB
	xPqd7pDMC9/ScoA=; b=OqESwM6QNQBmE0U+JbItn4562YO3To8naLJ5bFHRmtA5
	2vBWlbegtsNckNVvsXe7Qmw3R+x+N7LQbprF95x3x3oNMhkEOqSKsH6dyGtq+VqG
	cTRY426+MYZlXEc9kcfW09QJDjNpAqMB9jtSIkBby3saJlKmSfQXvSoBuNTRGx6i
	Y2chZY2A3m11OSGZVcAIM/fkrOgbmTJCjsKNt8MnjjOvA0vteURY8XHS71a73XUx
	6Ql0VgYfc9l/17Z5TWf22U/aLjO5BkJqyujLGIHecNmPCyidLHSOudk4LudIj9uS
	OJe/EQ9oLWxbQTDUTPytW0Yp8Ri+Tx6NJx/AvQ/+LQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fjyg33-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:37:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S42pas879670;
	Mon, 28 Sep 2026 05:37:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg3ncr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:37:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5blSi42074586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:37:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD07620040;
	Mon, 28 Sep 2026 05:37:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57CC92004B;
	Mon, 28 Sep 2026 05:37:36 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:37:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net, meted@linux.ibm.com, ynorov@nvidia.com
Cc: sshegde@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: [PATCH v14 00/13] sched, steal_governor: Introduce preferred CPUs and steal-driven vCPU backoff
Date: Mon, 28 Sep 2026 11:07:15 +0530
Message-ID: <20260928053728.797539-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: f0gYKy9wmmKcXPXAVPiFGX6FB4-zmH9Q
X-Proofpoint-GUID: wyCEZ-fRXFphLuHh5sk45_k7i-QnfEEp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX7CwlhUDyQTCL
 ZZaptraUUujH4LE6UnBJlaN4C8CvJ+kyo+r4Mvy1uK4CmG8uBPgyC7OVX5mX4uRiJmy8ajRt9aF
 D4z93unAsSZauSDazYYd5KvLU3NzGbs=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6ab9fd31 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=jJrOw3FHAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=gq_bZfSN0OqWnB9g8r4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX5qAowFmqAO7e
 dHUAPskRGxtWcMe05kYXrIgeMCHa9pmwEcxEFBJID9nPWXJyt7gmJJ06kQoSIfEm662DbTyHybY
 Rlwe/rRbq66LU9PER3m93v1uRn81s00PVs27nj+HLbQy9CdBco3aZZsvn2XwFdHGaEPrRMsE3nz
 s8Fx3UcBMCpUv/Ypwd0ELPbJUmqomPCmopATnVvrMxJ6mRVJHv+uQNjh1rFs5r2JG9f3/9Vq9Tv
 ZQBRLBTJCNF0Ixsv5RWjDmLv0ujTiljU/vbHNI9LGufZ4v1AUd1rMDBWabNPkFnJBzumG+3w6Ea
 UGY2nsPbnDbG5EcGNvrREge3TFAw19JhP3/u3101bcEJcouVFetGhhEf0o2xXfjEG2hQCKYoBKK
 dVZCs6vC/91DGczH+hRGXDpHQ0S6ykp3mH+G5dt4/0k6mV8tF/K3MyNYrL4x4a/7R2/cEJ9Xrpy
 cJer57u3A8PvuXI7EIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280022

tl;dr

This patch series represents the result of multiple iterations, 
redesigns and community feedback. What started as an arch-specific RFC
has evolved into a scheduler mechanism paired with a virtualization
driver.

This feature is intended for workloads where vCPU preemption has costs
beyond the lost CPU time, such as lock-holder preemption, critical
sections and TLB/cache misses. Database workloads, for example,
contain a mixture of OLTP/OLAP activity and are prone to these costs.
Reducing vCPU preemption in these cases can help improve overall system
throughput. It may regress slightly for pure CPU-time workloads.

I believe the series has now converged and can be considered for
merging. The implementation has been deliberately kept simple.
It performs well for real-life workloads on PowerPC, and earlier KVM
testing also showed improvements on s390 and x86.

The following work is planned post the merge: 
- Design for arch specific interface which could help to bring out
  additional performance gains.
- A test framework for the feature

Feature has been kept as generic solution for all arch which support
paravirtualization and steal time accounting. If a need arises, arch specific
gating could be introduced.

Special thanks to Yury Norov for the rigorous reviews that greatly 
improved the series and to everyone who have provided their review
comments so far. (including sashiko) Really appreciated! _/\_

Rest of cover-letter is very similar since v8. Version history has been
updated.

Detailed Background and Problem Statement
=========================================

As hardware scales, the density of physical CPUs (pCPUs) per server is
increasing across many architectures. On these massive systems, deploying
a single bare-metal OS for general workloads becomes increasingly difficult
to manage if not impossible. The natural shift is to deploy
Virtual Machines(VMs). For example, on IBM PowerPC architecture customers
frequently deploy Shared Processor LPARs (SPLPARs) to maximize hardware ROI.

Typical enterprise workloads are combination of bursty and long running;
their average CPU utilization is low, but they require high core counts
during peak transactions. To accommodate this, customers often
use CPU overcommit strategies i.e. configuring VMs with a large number
of virtual CPUs (vCPUs) while backing them with a smaller, shared pool
of physical CPUs (pCPUs). This achieves a high server consolidation
and excellent cost efficiency.

However, when multiple such VMs have high utilization simultaneously,
the shared pCPU pool becomes contended. The hypervisor is forced to preempt
one vCPU to run another to maintain fairness. It maybe schedule vCPU of same
VM or different VM.  If a vCPU is preempted while holding a lock or
irq disabled section etc, overall forward progress collapses. There are some
mitigation strategies such as yielding the vCPU to lock-holder, but they
don't cover all the cases. In addition there are hidden costs such as cache,
tlb misses, cost of vCPU preemption, host scheduling overheads etc.

Under heavy contention, an effective mitigation strategy for workloads
sensitive to vCPU preemption is for guests/VMs to voluntarily fold their
workloads onto a smaller subset of vCPUs. By demanding fewer pCPUs,
the VMs reduce overall host contention, which decreases vCPU preemption
and improves total throughput for the system. 

Limitations of Existing Approaches
==================================

CPU Hotplug, Isolated cpusets, cpuset: 
- This is a heavy and administrative operation that requires topology rebuild.
  Crucially, it breaks userspace CPU affinities. 

Explicit task affinity:
- Very difficult to manage for the users, if not impossible.

We need a fast, co-operative backoff mechanism inside the kernel that can
dynamically react to contention without violating user/task affinity
contracts. Since reacting to the contention is agnostic to the user
it cannot violate user affinity contracts.

When there is high contention, fold the workload and use limited vCPUs
and when there is no contention, use all the vCPUs again. This natural
expansion/contraction gives the better performance to the users
based on the underlying contention.

Proposed Architecture
=====================

Current design is built on basis that contention is effectively
quantified by steal time as seen in guest kernel.
Steal time is already a well established construct today in
para-virtualization world.  All major archs support this feature.
It is indication of the contention of physical CPU. It scales according
to the amount of contention. Today it is used by administrative users
for changing the VM configurations. During high contention the steal
time shows up in each guest based on its configuration. The proposed
solution works well when all VMs honor the hint and work in co-operative
manner. Note there is still no inter-guest communication to achieve this
co-operation. Read the section on best practises on how to get the
best out of this solution.

This series introduces a dynamic vCPU backoff mechanism.
It is separated into a core scheduler mechanism and a loadable
virtualization policy module.

Layer A: The Scheduler Mechanism (preferred CPUs)
=================================================

Series introduces a new CPU state called preferred. It indicates that
vCPU can be safely used and using that vCPU won't increase contention
for underlying physical CPUs. This state info is made available via
cpu_preferred_mask, which is strictly maintained as a subset of
cpu_active_mask.

The scheduler uses this mask as a hint to fold workloads onto preferred
CPUs using a few mechanisms.

1. Wakeup: is_cpu_allowed() checks if CPU is preferred. If not calls
   select_fallback_rq, which selects a preferred CPU if tasks's affinity
   permits.

2. The Tick (Push): During sched_tick(), if the current CPU is non-preferred,
   the scheduler actively pushes the running task onto a preferred CPU
   using a stopper thread. 

3. Load Balance: sched_balance_rq restricts its domain span to
   cpu_preferred_mask, preventing tasks from being pulled toward
   non-preferred CPUs.

Design Constraint: The scheduler strictly respects user affinities.
If a task is pinned exclusively to non-preferred CPUs, it will remain there.
The kernel will not break user/task affinity contracts.

Layer B: The Policy Engine (virt/steal_governor)
================================================

The core scheduler should not dictate virtualization policy.
Therefore, the policy is isolated into a new driver: steal_governor.
(Can be selected by CONFIG_STEAL_GOVERNOR)
This module latches onto that concept that contention is quantified by
steal time. It periodically samples the steal time values across the
system and depending on high/low steal values, takes appropriate action.

When it sees high steal times, i.e. steal time exceeds high_threshold
(default 5%), driver reduces the preferred CPUs by 1 core. 
When it sees Low Steal Times, i.e.  steal time drops below low_threshold
(default 2%), driver increases the preferred CPUs by 1 core.

This creates a dynamic, self-maintained stepwise loop. The guest automatically
shrinks its pCPU footprint when the host is saturated, and expands it when
the noise clears while requiring zero cross-VM communication.

Policy Design Constraints:
- Ensure at least one core is kept as preferred.
- Ensure preferred is always subset of active.

Best Practises
==============
1. Ensure all the VM run kernel which has the patches.

2. Keep CONFIG_STEAL_GOVERNOR=m. Build it as module, but don't load it by
   default. When the administrative user enables it in one VM, he/she
   will likely enable it in all VMs. Also module parameters can
   only be changed at module load. Having it as module also allows one
   to disable it to remove additional overhead it brings.

3. Keep the interval_ms=500 to 5000. I.e. between 500ms to 5 second.
   Though parameters allows slightly higher range. 

4. Fine tune low and high threshold depending on your platform for best
   results. Even where is no contention, very small steal values
   might show up. So it might be better to keep low threshold higher
   than 0.

Baseline and Revision History
==============================

tip/sched/core at commit:
'627ea30aca3b ("sched/wait: Clarify WF_SYNC wakeup semantics")'

For the talk on the problem and discussion on this issue, one can also
refer to the OSPM26 talk[1]. 

[1]: https://youtu.be/adxUKFPlOp0
[2]: https://www.ibm.com/support/pages/ibm-power-virtualization-best-practices-guide
[3]: https://www.ibm.com/docs/en/linux-on-systems?topic=bad-daytrader

v13->v14:
- Make sched_non_preferred_cpu_push_stop look similar to
  __balance_push_cpu_stop. (Peter Zijlstra)
- Rename task_can_sched_on_preferred to task_can_migrate_to_preferred
  to make it read more natural. (Peter Zijlstra)
- Clarify that the new migration statistic is per-task and does not
  require a schedstat version change.
- Updated changelogs and Collected tags.

v12->v13:
- Rename push_task_work_done to npc_push_work_pending. (Yury Norov)
- Move it around steal_* fields in rq. (Yury Norov)
  It doesn't increase the struct rq's number of cachelines for both
  128 byte and 64 byte cachelines.
- Put PREFERRED_CPU guard for npc_push_work_pending (Yury Norov)
- Update comments around rq lock's acquisition post select_fallback_rq
  (Yury Norov)

v11->v12:
- Simplify the ARM64's 32 bit task case where p->cpus_ptr
  may contain architecturally impossible CPUs.
  (Dietmar Eggemann, Vincent Guittot)
- Introduce cpumask_intersects_and for that simplification
  (Yury Norov)
- Keep the feature without any arch specific kconfig gating
  for now. (Vincent Guittot)
  If a need arises, it can be brought in

v10->v11:
- Return active CPUs instead of possible CPUs for steal ratio
  denominator. This helps to avoid dilution of thresholds. 
  (Yury Norov, Ionut Nechita)
- Add XEN dom0 blocking check. (Ionut Nechita)
- Update documentation/changelogs.
- Multi arch framework has been deferred. Will be designed after
  this series gets merged upstream. It would depend on enhancement requests.
- Collected tags for patch 1
- Fix possible crash for 32-bit tasks on arm64 (sashiko)
- Fix possible race for task affinity due to abort in __migrate_task
  (sashiko)
- Fix unused variable for patch 1 (sashiko)
- Disable interrupt when taking rq lock in a small window (sashiko)
- Queue stopper iff migration is enabled. (sashiko)
- Document workload characteristics and the possible regression
  for pure CPU-time workloads.

v9->v10:
- Introduce kcpustat_field_total helper. (Yury Norov)
- Always do the design checks. This helps to avoid placing design
  constraints in core hotplug code. 
- Remove cpu_preferred check in idle balancing. This helps to naturally
  take care update of nohz.next_balance.
- find_new_ilb changes are deferred as it isn't applicable for most
  common use cases.
- Move scheduler documentation to sched-paravirt.rst. (Yury Norov)
- Add details of limitation of default values in documentation. (Yury Norov)
- Remove task_can_sched_on_preferred out of sched.h (Mete Durlu)
- Updated suggested-by tags for few patches. (I know i should have
  done it earlier, sorry about that)
- Minor polish of all changelogs.

v8->v9:
- Move to simpler layout. Everything in drivers/virt/steal_governor.c
  (Yury Norov)
- Move design checks into a helper function (Yury Norov)
- Comments update (Yury Norov)
- Requeue work without further checks when steal ratio is within the 
  low/high threshold window. (Yury Norov)
- Renamed sg_core_ctx to sg_ctx.

v7->v8:
- Rename to STEAL_GOVERNOR from STEAL_MONITOR.
- Remove additional defaults.c and move it to core.c (Yury Norov)
- Remove SM_DIR gating for direction control. (Yury Norov)
- Enforce design constraint and restore the state if not met (Yury
  Norov)
- Drop nohz_full tick enable patch.
- Move Kconfig patch as the last patch for enablement. (Yury Norov)
- Use disable_delayed_work_sync to avoid race condition during
  module unload. (Yury Norov)
- Add same kconfig dependency and fail to compile the driver (Yury Norov)
- Make low < high comparison during module init instead as they
  are dependent parameters (Sashiko)
- Update sysfs file helper section (Yury Norov)
- Make preferred sysfs file available only with CONFIG_PREFERRED_CPU=y
  (Yury Norov)
- A few documentation and comments fixes. (Randy Dunlap)
- Fix possible race in sched_push_current_non_preferred_cpu (Yury Norov)
- Move is_migration_disabled check just before actual migration.
- Make 100ms as minimal interval_ms from 10ms.
- Make helper functions static and remove from header file as there
  are no other callers.
- Collapse helper functions and periodic work into one patch.

Short summary on previous versions:
v6->v7:
- Consolidate new driver code to 4-5 patches.
- defer the arch specific interface.
- Use possible CPUs instead of active for steal value calculations.
- Simplify is_cpu_allowed.
- Make module parameters fixed at module load
- Define CONFIG_STEAL_MONITOR and Make it select CONFIG_PREFERRED_CPU

v5->v6:
- Drop the optimization of caching the preferred state
  in select_fallback_rq
- Drop wakeup patch

v4->v5:
- Move the computation of steal time and decide on preferred CPU state
  to a driver. i.e new driver called STEAL_MONITOR

v3->v4:
- Make preferred subset of active instead of online. 
- Dropped RT patch and Defer sched_ext. Support only FAIR class.

v2->v3:
- Introduce a new config CONFIG_PREFERRED_CPU

v1->v2:
- A new name - Preferred CPUs and cpu_preferred_mask
- Arch independent code. Everything happens in scheduler.
- Steal time computation is gated with sched feature STEAL_MONITOR

RFC v3-> RFC v4:
- Introduced computation of steal time in arch/powerpc.

RFC PATCH v1:
- push task mechanism.
- No steal time computation. Manual sysfs hint for preferred CPUs 

v1: https://lore.kernel.org/all/236f4925-dd3c-41ef-be04-47708c9ce129@linux.ibm.com/
v2: https://lore.kernel.org/all/20260407191950.643549-1-sshegde@linux.ibm.com/#t
v3: https://lore.kernel.org/all/20260514152204.481115-1-sshegde@linux.ibm.com/#r
v4: https://lore.kernel.org/all/20260617174139.155540-1-sshegde@linux.ibm.com/#t
v5: https://lore.kernel.org/all/20260625124648.802832-1-sshegde@linux.ibm.com/
v6: https://lore.kernel.org/all/20260701141654.500125-1-sshegde@linux.ibm.com/#t
v7: https://lore.kernel.org/all/20260709215648.1246821-1-sshegde@linux.ibm.com/
v8: https://lore.kernel.org/all/20260720172250.2257582-1-sshegde@linux.ibm.com/
v9: https://lore.kernel.org/all/20260724140732.2683314-1-sshegde@linux.ibm.com/
v10: https://lore.kernel.org/all/20260812054033.95658-1-sshegde@linux.ibm.com/
v11: https://lore.kernel.org/all/20260825103855.721013-1-sshegde@linux.ibm.com/
v12: https://lore.kernel.org/all/20260903063240.268775-1-sshegde@linux.ibm.com/
v13: https://lore.kernel.org/all/20260909135617.871006-1-sshegde@linux.ibm.com/
Even earlier version:
https://lore.kernel.org/all/236f4925-dd3c-41ef-be04-47708c9ce129@linux.ibm.com/ 

========================================
Performance Numbers (powerpc, x86, s390)
========================================

PowerPC:
===================
VM1: 60VP/30EC and VM2: 30VP/20EC
Shared physical CPU pool size: 50 Cores. Each core is SMT8.
(VP - Virtual Core, EC - Entitles Core) -  PowerVM terminologies of SPLPAR[2]

Default parameter values: 1000ms, 200 low threshold, 500 high threshold
Both the VMs are running the same workload. Total throughput/time of VM1+VM2
is being mentioned in all cases.

Hackbench
              baseline    steal_governor        steal_governor
                             disabled               enabled
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

10 groups        5.20   |    5.40 (-3.85%)  |     4.65 (+10.58%)
20 groups       11.39   |   12.01 (-5.44%)  |     7.09 (+37.75%)
40 groups       20.32   |   19.80 (+2.56%)  |    11.31 (+44.34%)
10 groups(-p)    2.37   |    2.26 (+4.64%)  |     2.06 (+13.08%)
20 groups(-p)    3.34   |    3.28 (+1.80%)  |     3.20 (+4.19%)
40 groups(-p)    4.46   |    4.83 (-8.30%)  |     4.26 (+4.48%)
Remarks: Net improvement with steal_governor specially high load points.

schbench ( -L -n 0 -r 30 -s 0)
              baseline    steal_governor          steal_governor
                             disabled                 enabled
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-m 1 -t 128     2475162 |    2621246 (+5.90%)  |      2527299 (+2.11%)
-m 1 -t 256     1467350 |    1470032 (+0.18%)  |      1492372 (+1.71%)
-m 1 -t 512     1408813 |    1454687 (+3.26%)  |      1437605 (+2.04%)
Remarks: Effectively means no-improvements or regressions

kernbench	baseline    steal_governor     steal_governor
(elapsed time)	               disabled            enabled
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-j nr_cpus	231      |      235 (-1.7%) |    199 (+14%)
Remarks: Net improvement in elapsed time.

Daytrader - A real life work which is a proxy for trading based
on db2[3]
              baseline      steal_governor   steal_governor
                              disabled          enabled
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Load@30%	1x	|	0.96x	|	 1.53x			
Load@60%	1x	|	0.94x	|	 1.41x
Remarks: Very good improvement seen at different load points.

phoronix/memcached:
Cloned from github.com/phoronix-test-suite/phoronix-test-suite.git
GET 1:1000 means 1 writer and 1000 readers.
	     baseline	    steal_governor   steal_governor
                              disabled          enabled
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
GET 1:1000	1x		0.99x		1.2x
Remarks: 20% improvement with read heavy variant.
Other variants such as GET 1:1 showed minor regressions. While
inspecting it, it was found that steal time reported by PowerVM was
not as expected even when only 1 VM was running. This is being looked
into by PowerVM hypervisor team. So added a section in limitation that,
this feature expects steal time values being accurate for right policy
decisions.

When there is no steal time (such as dedicated LPAR) throughput was same
with steal_governor enabled/disabled which indicates minimal overhead
of steal_governor. 

=======================================================================

Data from x86,s390 KVM which Ilya Leoshkevich carried out during OSPM26
time. *This was based on v2*. The core idea remains the same, although the
implementation has changed and some overhead has been removed since then.
Note: Other variations of the benchmark shows no observable difference.

x86:
====
cascade-lake: 32 threads = 16 cores
Benchmark      #VMs    #CPUs/VM  ΔRPS     (%std)
===============================================
hackbench         8          16  90.73% ± 9.97%
hackbench         4          24  52.67% ± 7.43%
hackbench         4          16  37.96% ± 11.19%
hackbench         4          32  37.82% ± 4.38%
hackbench        12           8  36.90% ± 4.74%
hackbench         8           8  35.30% ± 3.61%
pgbench          16           4  31.77% ± 2.44%
hackbench         2          24  25.85% ± 8.63%
hackbench        16           8  24.87% ± 3.46%
pgbench          16           8  21.83% ± 2.20%
pgbench          12           8  21.35% ± 2.15%
pgbench           8           8  18.46% ± 1.01%
hackbench         2          32  15.56% ± 4.53%
pgbench          12           4  14.28% ± 2.04%
hackbench        16           4  14.07% ± 2.90%
hackbench        12           4  9.60% ± 3.49%
[...]
pgbench           4           8  -1.16% ± 3.60%
hackbench         4           4  -1.80% ± 9.55%
sysbench         12           4  -2.19% ± 0.78%
pgbench           4          24  -2.43% ± 4.38%
pgbench           4          32  -3.21% ± 0.79%
sysbench         16           4  -3.22% ± 1.09%

S390:
=====
z16: 16 threads = 8 cores (SMT-2)
Benchmark      #VMs    #CPUs/VM  ΔRPS    (std%)
===============================================
pgbench           2           8  73.50% ± 35.91%
pgbench          16           4  61.30% ± 4.09%
hackbench        16           4  54.11% ± 4.38%
hackbench        12           4  36.34% ± 4.63%
pgbench          12           4  34.83% ± 2.57%
hackbench         8           4  29.75% ± 5.86%
hackbench         8           8  25.98% ± 5.09%
pgbench           2           4  23.31% ± 33.44%
pgbench           2          16  19.95% ± 17.12%
hackbench         4           8  19.43% ± 9.33%
pgbench           8           4  19.32% ± 4.50%
[...]
schbench          8           8  -0.79% ± 0.33%
sysbench          8           8  -0.81% ± 0.39%
hackbench         4          16  -1.11% ± 5.82%
sysbench          8           4  -1.62% ± 0.49%
sysbench         16           4  -2.70% ± 0.58%
schbench         16           4  -2.73% ± 0.91%
sysbench         12           4  -2.91% ± 0.61%
hackbench         2          24  -4.99% ± 3.31%

Summary:
- Many improvement across archs specially with real life workloads.
- Overhead of steal_governor looks minimal when there is no steal time.
- Overhead when STEAL_GOVERNOR=n is negligible.
- Pure CPU-time workloads may see a small regression.

Testing and Validation
======================

Apart from performance, To ensure the robustness of the preferred
CPU masking and push mechanisms, the following scenarios were tested:
- CPU Hotplug: bringing CPUs up/down change the preferred mask
  accordingly under no-contention and contention.
- Housekeeping cores: Verified with different combinations of
  nohz_full=<beginning, middle, end set of CPUs> to ensure that
  policy engine restricts to first housekeeping core in extreme cases.
- User Affinity: Confirmed that tasks explicitly pinned to non-preferred
  CPUs via taskset remain on their assigned CPUs.
- Affine Move: Confirmed the affinity move using "taskset -cp" happens
  on all combinations of non-preferred, preferred under contention.
- Affinity and hotplug: It works as expected. I.e affinity gets
  reset if all the CPUs of p->cpus_ptr go offline even if they are
  non-preferred CPUs.
- Extreme load and running threads: for example 4800 stress-ng threads
  on 480 CPU system and it still packs to preferred CPUs.

Known Limitations
=================

- The steal governor relies on accurate steal-time accounting. Incorrect
  steal-time values from the underlying architecture may lead to suboptimal
  policy decisions or performance regressions.

- If the workload is a pure CPU time based such as stress-ng --cpu=<>
  which doesn't suffer from vCPU preemption, it may not benefit from the
  steal governor.

Future work
===========
To keep this initial implementation clean and minimal, a few optimizations
have been deferred:

- Design a selftest like framework to validate steal governor, at least
  for KVM setup where there is infra available to spin off guests.

- Multi arch interface where arch specific hints could be provided into
  the driver's helper functions.

- Push all tasks on rq: Currently, the stopper thread only pushes the current
  running task off a non-preferred CPU. Future optimizations may look into
  migrating all queued tasks on that runqueue.

- Sched Classes: This feature currently only works for the FAIR
  class. Real-time (RT) and sched_ext classes are deferred for now,
  as there is no need for it.

- NUMA Splicing: The steal_governor currently removes last active core
  based on CPU number. It does not yet do complex NUMA-aware splicing,
  expecting that CPUs are spread out uniformly across nodes in
  most cases.

Shrikanth Hegde (13):
  sched/cputime: Add kcpustat_field_total helper
  cpumask: Introduce cpumask_intersects_and
  sched/docs: Document cpu_preferred_mask and Preferred CPU concept
  cpumask: Introduce cpu_preferred_mask
  sysfs: Add preferred CPU file
  sched/core: Try to use a preferred CPU in is_cpu_allowed
  sched/fair: Load balance only among preferred CPUs
  sched/core: Push current task from non preferred CPU
  sched/debug: Add migration stats due to non preferred CPUs
  virt: Introduce steal governor driver
  virt/steal_governor: Add control knobs for handling steal values
  virt/steal_governor: Implement steal_governor policy loop
  virt/steal_governor: Enable the driver

 .../ABI/testing/sysfs-devices-system-cpu      |  14 +
 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/steal-governor.rst   | 151 +++++++++
 Documentation/scheduler/index.rst             |   1 +
 Documentation/scheduler/sched-paravirt.rst    |  67 ++++
 MAINTAINERS                                   |   9 +
 arch/s390/kernel/hiperdispatch.c              |  10 +-
 drivers/base/cpu.c                            |  12 +
 drivers/virt/Kconfig                          |  17 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/steal_governor.c                 | 296 ++++++++++++++++++
 fs/proc/uptime.c                              |   6 +-
 include/linux/bitmap.h                        |  14 +
 include/linux/cpumask.h                       |  42 +++
 include/linux/kernel_stat.h                   |  11 +
 include/linux/sched.h                         |   1 +
 kernel/Kconfig.preempt                        |   4 +
 kernel/cpu.c                                  |   6 +
 kernel/sched/core.c                           | 123 +++++++-
 kernel/sched/debug.c                          |   1 +
 kernel/sched/fair.c                           |   8 +-
 kernel/sched/sched.h                          |   9 +
 lib/bitmap.c                                  |  17 +
 23 files changed, 802 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/driver-api/steal-governor.rst
 create mode 100644 Documentation/scheduler/sched-paravirt.rst
 create mode 100644 drivers/virt/steal_governor.c

-- 
2.52.0

