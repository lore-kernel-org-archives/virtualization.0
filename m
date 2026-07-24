Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05142414DC9
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902127; cv=none; b=P1950FgEfzTVhB6ff7Blu047eLmdhAyJ9uEy87MY9YNA3G+XmpEZRPE5uNECA7CjM9spHfDSwcdeWp2wkV2Vl7oxSFiFfa5/Ft0r2dTR3goIVJa+BiP93Ga5kkEP9q5lEEkE2Xvd+KylJvqG2+L8iqteCSSkgMIZ/1s2B/BwSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902127; c=relaxed/simple;
	bh=lza7gAmu1NvMzOMCe/mEw7H+KQNibNl/rUY8Ja34NoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJguDo/euoxBgW3sMh0WHKFppKwIkR2lVSNWmTAaNmTcCvJu/Rs7CCAYZI46zc45wYkz4xng53oDAofqNvMURDoNVuvjbTPKii5f7+2i5FADvQIqMBzf1rl3ZtKcicJfXJChNaj5eL3ZQbAIZHcJzS1asvQISj0vJM2LEmM+ZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dJbhphku; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dJbhphku"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfofG1994009;
	Fri, 24 Jul 2026 14:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=84eDZR6v1SPSl+gau
	/CA/4fFYnWZbtnOnkAICw3TfgA=; b=dJbhphkuyjUwOUFMKGDFairvLwO/ygSkg
	ApXY0yaY/dryG2AMX6Mp6rn2nvIGMTMDxBQ5my3APUjJjJNmks2eBPNEVdpmMVZO
	61azdwWt/lsG7WximlUrb8b1FMASaDDYJEzUiEzbGLTKeq0Die0EtTKh1HEqyIyY
	++IzwanHnSzPc/LOGhriZiZe/4Q8tHsJb1qFK4rS+9HUHzd9/MBkKzmrMkpsvoEa
	GrZAy6NYPWb/paY16sf1uBh7AcPF0S7H8MyJ0nbgqbHm3Z4BqAgIaQmh/yczDbwM
	SypBJQoNQVyXDjL4YBQA2xhLkwbhIn8szAjEArBwaKYU0a1CK/IAQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahmcg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:08:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4iXx014385;
	Fri, 24 Jul 2026 14:08:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqhca2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:08:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OE8NGi39190940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:08:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD03020176;
	Fri, 24 Jul 2026 14:08:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92A8320171;
	Fri, 24 Jul 2026 14:08:15 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:08:15 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
        corbet@lwn.net
Cc: sshegde@linux.ibm.com, tglx@kernel.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, seanjc@google.com, vschneid@redhat.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        maddy@linux.ibm.com, srikar@linux.ibm.com, hdanton@sina.com,
        chleroy@kernel.org, vineeth@bitbyteword.org, frederic@kernel.org,
        arighi@nvidia.com, pauld@redhat.com, christian.loehle@arm.com,
        tj@kernel.org, tommaso.cucinotta@gmail.com, maz@kernel.org,
        rafael@kernel.org, rdunlap@infradead.org, kernellwp@gmail.com,
        linux-doc@vger.kernel.org, jgross@suse.com,
        virtualization@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: [PATCH v9 01/11] sched/docs: Document cpu_preferred_mask and Preferred CPU concept
Date: Fri, 24 Jul 2026 19:37:22 +0530
Message-ID: <20260724140732.2683314-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724140732.2683314-1-sshegde@linux.ibm.com>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zfJtBqWYy4RPBgg9Ra0grRIQS4B_uzAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX5Nm9c30R9/aR
 pbK1I1UvrcHZs1wiX2nrgLD8D7CI02N4EL3iISTPnQkEvxAeg+slKx0zwr5762UzumzSXKoBT3R
 lCUrhefislCRYIgHh5EldQCZCj25NkYQB3JyiGAIAvplUECaXp6ff0mUC5uegoAx3srwys6J801
 FMtRa2bvy0doUQUiI+rF+A533Q85dYhKY2haOJkQ+VkcUt/+sMeWx84qykSo80dFIKyIMb59dpW
 KW8e6wW6seUdaWpr5zm2X2m/4raxnt6gBj1YjUOBpdEPlBMPahiE8jm/EflIbnT5qALiN08KVeY
 omdh7egm0FLrqhFHHJVlKS+uKzZzr+ZJiPi0E/mgVIZNi7IxUQNxcIgf6w6N4NO1jI49TLnqXJk
 Qp9L61D8wBVz3aFMKxMDHlr5wfPB35kq2C/T0pL5bnKGvZA52Gl9M9dsgFOgSJuARTIkOk9DF8K
 UJv/cfA6jAIg4q4PwDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfXxi4KmnWVBiEV
 vZ73AyK8OZeD9gElBftOQf7mL46f+BAK6BHA2lT2rUqin5AhYgaXY5UOqb0giT96wPGl5bygDCG
 6oUtHpNfdtuuNkesYTU+dYnkEmUdlZI=
X-Proofpoint-GUID: SkJLJ8YmHLcpd8gHNSfk7wC9QoY1eToF
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a6371dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=d8MiXRUMn4SEn--m04oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

Add documentation for new cpumask called cpu_preferred_mask. This could
help users in understanding what this mask is and the concept behind it.

Document how to enable it and implementation aspects of it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606180717.yNM0yb41-lkp@intel.com/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/scheduler/sched-arch.rst | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/scheduler/sched-arch.rst b/Documentation/scheduler/sched-arch.rst
index ed07efea7d02..0a0a8eadbfd6 100644
--- a/Documentation/scheduler/sched-arch.rst
+++ b/Documentation/scheduler/sched-arch.rst
@@ -62,6 +62,64 @@ Your cpu_idle routines need to obey the following rules:
 arch/x86/kernel/process.c has examples of both polling and
 sleeping idle functions.
 
+Preferred CPUs
+==============
+
+In virtualised environments it is possible to overcommit CPU resources. i.e.
+the sum of virtual CPUs (vCPUs) of all VMs is greater than number of physical
+CPUs (pCPUs). Under such conditions when all or many VMs have high utilization,
+hypervisor won't be able to satisfy the CPU requirement and has to context
+switch within or across VMs. The hypervisor needs to preempt one vCPU to run
+another. This is called vCPU preemption. This is more expensive compared to
+task context switch within a vCPU.
+
+In such cases it is better that combined vCPU ask from all VMs is reduced
+by not using some of the vCPUs in each VM. vCPUs where workload can be safely
+scheduled which won't increase any contention for pCPU are called as
+"Preferred CPUs".
+
+Main design construct is preferred CPUs are always a subset of active CPUs.
+In most cases preferred CPUs will be same as active CPUs, when there is pCPU
+contention, Preferred CPUs will reduce based on the amount of steal time.
+When the pCPU contention goes away as indicated by steal time, Preferred CPUs
+will become same as active CPUs again. These policy decisions are taken by
+steal_governor driver available at drivers/virt/steal_governor.c
+
+Scheduling decisions such as wakeup, pushing the task etc, need this
+CPU state info. This is maintained in cpu_preferred_mask.
+vCPUs which are not in cpu_preferred_mask should be treated as vCPUs which
+should not be used at this moment provided it doesn't break user affinity.
+
+This is achieved by:
+
+1. Selecting a preferred CPU at wakeup using fallback mechanism.
+2. Push the task away from non-preferred CPU at tick.
+3. Only select preferred CPUs for load balance.
+
+/sys/devices/system/cpu/preferred prints the current cpu_preferred_mask in
+cpulist format.
+
+Notes:
+
+1. This feature is available under CONFIG_PREFERRED_CPU. It is selected
+   by steal_governor driver (CONFIG_STEAL_GOVERNOR). On enabling the
+   driver, CPU preferred state can change based on steal time. Without that
+   driver, preferred CPUs is same as active CPUs.
+
+2. This feature works for FAIR class only.
+
+3. A task pinned, which can't be moved to preferred CPUs will continue
+   to run based on its affinity. But no load balancing happens.
+
+4. Decision to change the preferred CPU state is driven by kernel.
+   Hence it shouldn't break user affinities. One of the main reasons why
+   CPU hotplug or Isolated cpuset partitions was not a solution.
+
+5. This feature works best only when all the VMs enable the feature as
+   it is a co-operative scheme. If a specific VM doesn't enable this feature
+   it may end up with more CPUs than others, still should lead to better
+   performance when seen from system view.
+   Users who enable this driver must ensure it is enabled in all VMs.
 
 Possible arch/ problems
 =======================
-- 
2.47.3

