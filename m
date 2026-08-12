Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0539A3911C7
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513285; cv=none; b=dC7TnpUZX0pAxCZ4lsLxXTxN9IrCLSE5Fx7y6+m5XW0SOl65jlbRDMEyXjNKq8kKaZtzPmO8IgCno7jH/0KSKorRDmxA7NN6tOofUdia80mivNlBLkZtfuF8aTDIy7OflEuFmOPLIQqJUSqOfcUyz7qCMREEq6G4KeQmA1QCC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513285; c=relaxed/simple;
	bh=qrEJ/vOMRn+hJwEzFw50NZd1Piogma6ZrdDkk7k13bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bayl/DJFHxauS9E85nF30/pvYjASEqPe283NLOCm7ThLi8KdKFbRt77XTB6VUQnNWaeOXS1FiD5AfT1Ik98979/r5eY0LqrFzV5/S9dA/sSPWyj43q2At7770gF3xiFqDIa9lHBpUAFSILC6kF7zZZv/IMUOK0xUovvyf5QNFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OEynovt6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OEynovt6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31Vsp416373;
	Wed, 12 Aug 2026 05:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9xJKG7CyiFCg/Eo9f
	ElnKaEIAlsTOizSYleCtLkAlqA=; b=OEynovt6uDylo3Zz6tn5o+SvNr+DMLLFb
	GMa5lQItHxRR6AATlzITgaINbYw7Gja/R/HAM93WypRnYJPa89WQpMcgr5MkjwBH
	ylcZfNJJIyocc8vsvGEBPxmr2dfVlPrni1wOkLzu/zk8fEARy7ekr+XKm2MNuvkl
	ifRWzWmqseL3WmFhkRbKJDEDYJ5e6Ayn9sOXCfADu55YKHXhWdM+XP065BdQQrSz
	56KdbDk9oPHJGVD9qVhSi32MSGQdOcfXNOzVhmmL5VN/tjMAYVBTdnzVazrYYGgy
	uOBKSr4jcZAkZndh4sXwewI6ABcfkMSQ6QZaUAWEIlW9z2xE/mxFA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk00yj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5QKUu005693;
	Wed, 12 Aug 2026 05:41:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq4uh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:41:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5f2Sh37486982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:41:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0FDB20040;
	Wed, 12 Aug 2026 05:41:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D71D2004B;
	Wed, 12 Aug 2026 05:40:54 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:40:53 +0000 (GMT)
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
        virtualization@lists.linux.dev
Subject: [PATCH v10 02/12] sched/docs: Document cpu_preferred_mask and Preferred CPU concept
Date: Wed, 12 Aug 2026 11:10:23 +0530
Message-ID: <20260812054033.95658-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfXxfGfyzu/inb8
 fgqaT1TzcddeymYyDEeaES6YlfYd2ZdlU8fpOQi8SdD2y7MivmEQ5zMAz61vBmRMx9NALCBGpfO
 cFcBKYEzHt6N0p6phwYqVfNoWTcBDTdDLRkcbyuKbR/uAlQd5HaDDL3h0UaHCI0Ku2Mk4K3ua2x
 0lo/rrDUqu9ykEiS31HOwjASJNgoB78ary4kyOiKbIK+w3rD5nNa6ITOE+B0GIEI6rIvHOF20EZ
 8mIn7ZHljsq1gpDDpv7CJWlFFrqIP9aZbY19MSxw4aRQUR2R0uuHx8G0YLiWhIbh5yrwieiE7G3
 fau935e5d49ZgSgTXmszRVeGQ8EEmnBlAzfKlphXZMYaPXbIaiolWhEkhWB5SYwovIBFKotkDXs
 6eiI5dUahzupfcB2vXnBPrzXV1k+Q/0E4G0xNLyufTBINkuS19aNhsw7x49n/No9MAS5E+Juqkh
 rPIF/4JNhd0OKwPVKGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX8TK9SbAxEf+t
 slhjc/sDketsRLepVpxtnHx88dwAosdHC0IT7ejDXC/Lu3PjrltIemikAk0mFIs0dKoP8ooVr7d
 q5YQY7WpkQ+hk31LSlkrqf8+DCQFvJU=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c0774 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=2BnLtqgf9UOq1ijo76cA:9
X-Proofpoint-GUID: 3t4MCixTYo0ByHz4NIVWokOIKs_lSnjj
X-Proofpoint-ORIG-GUID: c-FCX5a4dEmjxI3JI1yYfp4aCdQN44Uv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120041

Add documentation for new CPU state called preferred CPU state and
corresponding cpumask called cpu_preferred_mask.
This could help users in understanding what it is and how to use it.

Document the role of scheduler and driver for this feature to work.
Details regarding the driver documentation will be added in
later patches under Documentation/driver-api/steal-governor.rst.

Newly added file could be used for other paravirt usecase documentation.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/scheduler/index.rst          |  1 +
 Documentation/scheduler/sched-paravirt.rst | 67 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/scheduler/sched-paravirt.rst

diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 17ce8d76befc..a43647b9706d 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -23,5 +23,6 @@ Scheduler
     sched-stats
     sched-ext
     sched-debug
+    sched-paravirt
 
     text_files
diff --git a/Documentation/scheduler/sched-paravirt.rst b/Documentation/scheduler/sched-paravirt.rst
new file mode 100644
index 000000000000..3f06294714e6
--- /dev/null
+++ b/Documentation/scheduler/sched-paravirt.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _sched-paravirt:
+
+Preferred CPUs
+==============
+
+In paravirtualized environments CPU overcommit is a common scenario.
+i.e. the sum of virtual CPUs (vCPUs) of all VMs is greater than number of
+physical CPUs (pCPUs). Under such conditions when all or many VMs have
+high utilization, hypervisor won't be able to satisfy the CPU requirement
+and has to context switch within or across VMs. The hypervisor needs to
+preempt one vCPU to run another. This is called vCPU preemption.
+This is more expensive compared to task context switch within a vCPU, since
+hypervisor lacks vCPU context and could preempt a critical section which
+slows forward progress.
+
+In such cases it is better that combined vCPU demand from all VMs is reduced
+by not using some of the vCPUs in each VM. vCPUs where workload can be safely
+scheduled which won't increase any contention for pCPU are called
+"Preferred CPUs".
+
+One of the main design constructs is that preferred CPUs are always
+a subset of active CPUs. In most cases preferred CPUs will be same as
+active CPUs. When there is pCPU contention, Preferred CPUs will reduce
+based on the steal time. When the pCPU contention goes away as indicated
+by steal time, Preferred CPUs could become same as active CPUs again.
+The policy decisions are to be taken by driver.
+For example, steal_governor. Look at its documentation for more
+details. (``drivers/virt/steal_governor.c``)
+
+Scheduling decisions such as wakeup, pushing the task etc, need this
+CPU state info. This is maintained in ``cpu_preferred_mask``.
+vCPUs which are not in ``cpu_preferred_mask`` should be treated as vCPUs which
+should not be used at this moment provided it doesn't break user affinity.
+
+This is achieved by:
+
+1. Selecting a preferred CPU at wakeup using fallback mechanism.
+2. Pushing the task away from non-preferred CPU at tick.
+3. Selecting only preferred CPUs for load balance.
+
+``/sys/devices/system/cpu/preferred`` prints the current ``cpu_preferred_mask``
+in cpulist format.
+
+Notes:
+
+1. This feature is available under ``CONFIG_PREFERRED_CPU``. Driver which
+   makes decisions should enable it. For example, steal_governor driver
+   (``CONFIG_STEAL_GOVERNOR``). On enabling the driver, CPU preferred state
+   can change based on steal time. Without the driver, preferred CPUs is
+   same as active CPUs.
+
+2. This feature works for the FAIR class only.
+
+3. A pinned task, which can't be moved to preferred CPUs will continue
+   to run based on its affinity. But no load balancing happens if it is affined
+   only on non-preferred CPUs.
+
+4. Decision to change the preferred CPU state is driven by the kernel.
+   Hence it shouldn't break user affinities. One of the main reasons why
+   CPU hotplug or Isolated cpuset partitions was not a solution.
+
+5. This feature works best only when all the VMs enable the feature as
+   it is a co-operative scheme. If a specific VM doesn't enable this feature
+   it may end up with more CPUs than others, still should lead to better
+   performance when seen from system view.
+   Users who enable this driver must ensure it is enabled in all VMs.
-- 
2.47.3

