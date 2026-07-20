Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44D445AF9
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568229; cv=none; b=AGKNMipW+RNzBIWfDTWNxITGAqmYLB4iFa2ilwQQKcrvbOn/5HlgIcLvIGDmnY4l6Xtsx4+6GZNEeX6lMKFdfDQEObySW1YKgEGU6WimFRYSeQYYDOHno4lvkMk8VLwn0eGKuYj+leUjVc4to5TXYfa7vw3krQBnnvVNNZGJXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568229; c=relaxed/simple;
	bh=dqOWdcCZX2VlhJA4pzXkTcQFDzFSnKgIi2ryjATM0bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxUg/Y455nUp0X+vUkEXIWj8Yejq7jrQYBjTVW/sOgyKlGJeD8H3+qpYx0BWJtqX6AhztXnZ/DB38gQgNjGPIYYiXb3zBItn4CcQk/aAgbXgwYwdjFs213B3qAOl2a/tAEEuxuTp62+QxFN7TrUrsw4wJ672vgf3u7fCBbY00qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B/hdMBjp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B/hdMBjp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBp1r2713374;
	Mon, 20 Jul 2026 17:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=42tRobD+wTCxjiLRN
	3tF22lDXmf9gwQXTXq2JNgKVRo=; b=B/hdMBjpzYaRTXl8PX1VooT4O12TexKMO
	zUNqhSilwnj97lec7so/OnUMgej13BlFB3hJ5tfs74QquL0nXGhZLW+ObKVSBFm4
	T1MmzEOBZMUpkZJtitzGPUOOLhW8OxPtqLDtgPV5tBJNxqQbDslctLidFsSH8c5c
	CwlTD8DhEhV7z4pYbqC5QG0k1+4+KNV9978dB4NUJfXdB45ukJR/yC+p8KHYXpie
	n2ATqnF7KxMheZCH6/vv1UTOB+K8fRPsAIyTOlMpFjXsFahGsoOQO0/lIyR4tjy5
	F4pMvHxW1snWau/cRNESqQGYKYOD3KpcyQW2f0t1d/YEjA2OI/YpA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g0d5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KH4cnP016150;
	Mon, 20 Jul 2026 17:23:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjpkxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHNGUd29753830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:23:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACECC2004E;
	Mon, 20 Jul 2026 17:23:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1229920043;
	Mon, 20 Jul 2026 17:23:08 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:23:07 +0000 (GMT)
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
Subject: [PATCH v8 01/11] sched/docs: Document cpu_preferred_mask and Preferred CPU concept
Date: Mon, 20 Jul 2026 22:52:40 +0530
Message-ID: <20260720172250.2257582-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720172250.2257582-1-sshegde@linux.ibm.com>
References: <20260720172250.2257582-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX75JsjDgUTbv5
 GSTytuAiSoTOAhCYUjv532Ggc+qjgiLx42qGlYJeV/2p81fzoSC5ehBsXxviKyoeAeqkiTmgTqi
 Tt0vl4UlIowJvz+e+8OFcyqf8X7ITgyTrz9xQxBNPmaRs5TabKOf+626IcrT7/eeGChYxH1dtQt
 g6AvniFK/2/5pH0dZR/ae1a4wNNd5NiuykxeNpsqrHIq5qC/TGSXgR2Um13V7Lv8A7NFTfowycq
 ARQjILxGQmJSSrd+4zXcjb8hu0zZh4T/D9FmOkXsvdziHseIgQmdJF6tiAEnHwBTvaV1XLfGNP4
 aIC7bemkqDr4XBdXJPD3Hb9JJyAZjWBNA6OUFy86S+T8/Vz8jNk6E6SbyIwFG8q3rkJbyCIK8fZ
 ab/3cTSasWL4bMxu2GEh7AZIYrQyBkoJGgzLNLEtBzExtlH0NUYmkXBXbnotoxCADKVpMBK//qn
 X95rL69oiePsXCIeW3g==
X-Proofpoint-GUID: gwTy5Sd5vLSl-e7sRmyMt8llY1Mv0fsj
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e598a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=d8MiXRUMn4SEn--m04oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX1WItabpm635J
 mP4jPvSlWeC7CpJ5OvGRjF3qAdmnLpFU6+6tVSexa0INs6AB16gIkUMz6W6Ggv7AyMD5kPcFOTY
 /a7k76ZZEWZEGvgc315JV+IWVSoWBZE=
X-Proofpoint-ORIG-GUID: TMbTfP6QlKi6KnhQfW4FJ5O2XpfN5BsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

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
index ed07efea7d02..1ce0f92bc3f2 100644
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
+will become same as active CPUs again. This is done by loading the
+steal_governor driver available at drivers/virt/steal_governor.
+
+For scheduling decisions such as wakeup, pushing the task etc, needs this
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
+4. Decision to use/not use is driven by kernel. Hence it shouldn't
+   break user affinities. One of the main reasons why CPU hotplug
+   or Isolated cpuset partitions was not a solution.
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

