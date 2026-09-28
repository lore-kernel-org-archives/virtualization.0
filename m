Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BD385D68
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573926; cv=none; b=rDSRQiUbBwv10lW7MxnS8MScTbyCTr3DFWkvfaEVC0FKOhhbtnLW/6HSWXjqAkYBsVzjOjpMJUInG0h7DX6EyWqzE8xmBlCrZ5zM1SVYhQnIF4Lso0PRBjviU0eVdyXalbekJy1aNkPG1HsZ8LunDiZRaicSKBRw/zDG2/xilJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573926; c=relaxed/simple;
	bh=scynNHLZntdnjgSa6fiT0L6du/g5ELrDcNjAOoQ0xrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgmO38m8FC/QyUyBmWUVTwb7HNMYe2qnsnJHiYAMZODoWiuLNJHwE7CzEc3oVJoGE3yO1Db33A0OVXuShIebvlda0+/83iANuuT73t/YQx4qyyRBdG9vY1QM5ehvU74oZHGkbgGkQ6nNvBT+Atpa6mkK1ikXMgd5rxLskr3H3XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKScWtKT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKScWtKT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RNYsjt872042;
	Mon, 28 Sep 2026 05:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OpXDqA4IrF6tYgvzL
	FsuOPdgMFXuHYqIjNNRmFkAhO4=; b=VKScWtKTNDXZonh9tWQzFF/pr7BplBhAd
	yIK0v+Lvc1QM2j5TBm8CZjv9O3Zg6n4G8JXW7RyJbMCtFnJ9QkdcK+CPrna2QVEB
	rAHgTMD3UPDjJjkYjhETRMywGWYuJyPAM0bYNQ2NFeT3DApZWyuYIRb/hxc94wMb
	Qqq3HCzBU+YRn4B6bqwfGKXcxgJKYrtuYwI6XOP5W5xYZbAWWKGrT0OBocpCIQPB
	FtznZFa3CBQmk6lfjkiY9a5ixy+742urGJI1Hwrmn0O/TVfLEZ5aHfyOZlYNf53X
	duM7P3K00nb2Wb4hKACVzxaqtbjzA63s3gHt9TV2pWWDBaxtu82OA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j4yjqb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2qg1o2055552;
	Mon, 28 Sep 2026 05:38:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpm02b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5cLIP49742184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:38:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01AD92004D;
	Mon, 28 Sep 2026 05:38:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B54BC20040;
	Mon, 28 Sep 2026 05:38:09 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:38:09 +0000 (GMT)
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
Subject: [PATCH v14 03/13] sched/docs: Document cpu_preferred_mask and Preferred CPU concept
Date: Mon, 28 Sep 2026 11:07:18 +0530
Message-ID: <20260928053728.797539-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928053728.797539-1-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX4x8+7blmNKyT
 0lcTQkQ3OFDIBbeiRS/NZ+DZqs3TuUxzbuK0ZwAm9ZW9QEIgvKP5L/ulxpxpiOE5Y828DFaTqxS
 sZ80duXKSc8TzfYorsC7AaFvfSEwV68=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX7MIUX6YtYtjP
 6VnnCjJEv7uYkSxcZOSKGiCyJvlt1wGqD5Lji/6YEFRr+Do6t9Z+r6+GlPMNZvBV3SRua3xa+Bb
 8/2Kan7NSB4Q1DQMmpXkq7MUsPOSkq87AdiV7nyh1weiI7nbDXF3pYcinfoB4bR9R/7CxPaYXR3
 2lK9JBOiUvKDSnzgPjO0HUJTCPHMLJMhNSm/rdUAr05Uy5LBvz1KTwTdrzD8Of1FuS3MZdDuPlj
 O4fdafSb1yuw7dFLrJWFP7Gf8CCiltM8wuIG2gbI+eagbKe3gJ6OnacEhROGht5ajJkOmg9J16z
 WdSoJX2gOw2bG8pLhX/u/SN6c5MwPuRLFTVIN0HDYS4ZKn3iJjuA9LdWm7YBpfOhLm1Yz+O8UYn
 enlhRBA68AwN17ASlanjVyGG+uh4eUX4yFc3ryDr1coyFw9gCEjhqRo7aih3r1KnsWgyNOUwIzv
 VYWK4JgKmLX79XxiuLg==
X-Proofpoint-GUID: QprxpXiNln2lOpwm82x7ehXLGB_Hnih_
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6ab9fd52 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2BnLtqgf9UOq1ijo76cA:9
X-Proofpoint-ORIG-GUID: MCkVhsel8dnOqiQvg9kiBer0aF65APwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280022

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
index 000000000000..311cdbf2722b
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
+5. This feature works best only when all the Guest VMs enable the feature as
+   it is a co-operative scheme. If a specific VM doesn't enable this feature
+   it may end up with more CPUs than others, still should lead to better
+   performance when seen from system view.
+   Users who enable this driver must ensure it is enabled in all Guest VMs.
-- 
2.52.0

