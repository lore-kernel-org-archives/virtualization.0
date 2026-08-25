Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF633A70A
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654403; cv=none; b=V5WloS8dJ2tcLvIyHTE1GB1BPJpV6jE9x+sk25qAgOqnfDsa6Fg+4J/cQ0o8Yub0CqbHgWT/tRaxaejO1EeYeD4E3R2ktyqwgD5bXPuvT/mYp1yHqAFmyIzMCgzSJou9K19qvdLn2pcOqbKl2oX+hD5DxVh5ju/gKWEdZ7qxf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654403; c=relaxed/simple;
	bh=jBPdrBnR4SUzirHoPzmWKV0EpsI9GVTWp8rAwAzf5ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=idvlQd8uzQP0cTOKSD5EJLibX874o7wf/atMYHs1FL6Wxj8OeMqff/nAOZgV+D6qlu39FDL5BdBrcC78eiGQcgGLksb+CG+O2FJTsMRkdaf8EtkC5GRq/dN2j4HMSxyOlL8yANxTdGeWGsCjXCkWcQvGmE8etcNjrTiB+ZFQ9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kna/dYHc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kna/dYHc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VTcC306503;
	Tue, 25 Aug 2026 10:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=EtObetzhKkaLbnzMMf7PXhWA3fGi
	3icQHbZ5vwk3Eb8=; b=kna/dYHcTg+ziVcN98lMijJ9laKu6ik4rK74CABYb/H5
	BU44GFF1tdhtM7t/4zMoJbQn/ALjqQUbB+Rr7rQ7B2hK35zquApebzWiL4worobW
	Q2WehwGn1Wc3WxfHH0W+KGFOVBRLxDRtoTw98QDc9IZN2mX5qvy4QiyQ7k4NTP1R
	J+eN5kLKoTFWoKHFF4k6fGoGKtVdBZ8d1Idoo2l5NZFROiQWEuIWRSX0KrtNAe3v
	hHvJhqe3CCo5BntzW3Y/3mkMnOBe++1Hr6slRWA+JrzYbS21UTwuNSFnqnov1EDl
	Hsfnxfnkz6QEPOQ3j3T/QJRwP+HP/HEDdfvwMdnfSw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393ykcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:39:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQVDe010159;
	Tue, 25 Aug 2026 10:39:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw3ua4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:39:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAdUrY35979626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:39:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 260DB20040;
	Tue, 25 Aug 2026 10:39:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 098E720043;
	Tue, 25 Aug 2026 10:39:21 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:39:20 +0000 (GMT)
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
Subject: [PATCH v11 00/12] sched, steal_governor: Introduce preferred CPUs and steal-driven vCPU backoff
Date: Tue, 25 Aug 2026 16:08:43 +0530
Message-ID: <20260825103855.721013-1-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: TYwPlmyR0dj05XX8ItpYplCN7OW_xDhu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX2TgCBhfXdryZ
 F9gzMW2GMBYU0i/Qi/YHNFCIM5o8xDUNys1XmEhaAUTQIGU6K1nkfqDgM1L7gW6CMED1YXdkj7s
 eajU8F4cmpyFUeQfUQaJFF7tJG8D4+zDLqJ69oz62haHIizj4SnLYQ6MTQJN9N2FDklgBUijMfl
 +nrpTOuBA/IMx6JOvRpU2MpaIlP3HsNz9I9vbIUHcyERMHNwc9SufYiyQamnHynUSdixK71UtCt
 H3ISyzxgpfEYybc0UAaYeRMcsmrueuhf1QpDYG9yyPGzHFHgcZqfa3L0wLHxSNs8cKUWExltfDf
 +57X5/GF+TZKbwui9eGFKujv0dhYzDoNkqG4XrxrARrhfOt7JtLN3dSJ3oFybrQR592V3YmUV82
 lWv18UjcCc/ZsByCKel52bYOzPcE+df0fA/V0574Y7PLhinuTdLhospWVxtJguzJl+Sr4qqcx+8
 u2GWbVZHfYFZtmnUDWw==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8d70e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jJrOw3FHAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=L6LalbJ2hlVtWKjWbVoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX1UkjWwx2jIWx
 qmoOMCRtIhvu/dhOPT6C/ZZPSFJOGeQyIQXAy44dh8VI6CuodhHP7Cq5EhfZ6vAkCDeWOpud181
 eh8HCQmEjpgfdXH3+jKGVspEPDltdkY=
X-Proofpoint-ORIG-GUID: UKgOrqx-ZnokarOGmz2k3svR5DvoTrzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250089

tl;dr

This patch series represents the result of multiple iterations, 
redesigns and community feedback. What started as an arch-specific RFC
has evolved into a scheduler mechanism paired with a virtualization
driver.

The feature is intended for workloads where vCPU preemption has costs
beyond the lost CPU time, such as lock-holder preemption, critical
sections and TLB/cache misses. Database workloads, for example,
contain a mixture of OLTP/OLAP activity and are prone to these costs.
Reducing vCPU preemption in these cases can help improve overall system
throughput. It may regress slightly for pure CPU-time workloads.

I believe the series has now converged and is ready for merge
consideration. The implementation has deliberately been kept simple.
It performs well for real-world workloads on PowerPC, and earlier KVM
testing also showed improvements on s390 and x86.

Peter, Ingo, could this series be considered for queuing in sched/core
during the 7.3-rc cycle, targeting inclusion in 7.4? The feature could
also benefit from a good testing cycle in the tip tree.

This is being posted during the merge window to collect any further
review feedback. Apologies for the timing. If needed, the series will
be rebased on top of v7.3-rc1 once it is available.

The following work is planned post the merge: 
- Design for arch specific interface which could help to bring out
  additional performance gains.
- A test framework for the feature.

Special thanks to Yury Norov for the rigorous reviews that greatly 
improved the series and to everyone who have provided their review
comments so far. (including sashiko) Really appreciated! _/\_

Those who have read previous cover-letters (after v8) may skip to 
revision history :) 

Please let me know if there are any remaining design-level or
implementation-level concerns.

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

tip/sched/core at commit: '68e37487810a ("sched/fair: Fix flat hierarchy")'

For the talk on the problem and discussion on this issue, one can also
refer to the OSPM26 talk[1]. 

[1]: https://youtu.be/adxUKFPlOp0
[2]: https://www.ibm.com/support/pages/ibm-power-virtualization-best-practices-guide
[3]: https://www.ibm.com/docs/en/linux-on-systems?topic=bad-daytrader

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

When there is no steal time (such as dedicated LPAR, or only VM2
is running) throughput was same with steal_governor enabled/disabled
which indicates minimal overhead of steal_governor. 

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

Known Limitations & Future Work
===============================

To keep this initial implementation clean and minimal, a few optimizations
have been deferred:

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

Shrikanth Hegde (12):
  sched/cputime: Add kcpustat_field_total helper
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
 include/linux/cpumask.h                       |  24 ++
 include/linux/kernel_stat.h                   |  11 +
 include/linux/sched.h                         |   1 +
 kernel/Kconfig.preempt                        |   4 +
 kernel/cpu.c                                  |   6 +
 kernel/sched/core.c                           | 132 +++++++-
 kernel/sched/debug.c                          |   1 +
 kernel/sched/fair.c                           |   8 +-
 kernel/sched/sched.h                          |   8 +
 21 files changed, 761 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/driver-api/steal-governor.rst
 create mode 100644 Documentation/scheduler/sched-paravirt.rst
 create mode 100644 drivers/virt/steal_governor.c

-- 
2.47.3

