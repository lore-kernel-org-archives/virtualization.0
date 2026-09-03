Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13863F1ACF
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417225; cv=none; b=A3p//ZLqxROODWDDtMrDJz2XKZHAM8FM2TfID7JhgRjkQc25UV+tlGrL3EPAIj1RGX+Y0Asbnf5shbq7UAL5WZVmH+PgmRrpWNivQuQS3BmvliinuHFr166FSnY3A4ckCzIYsbmJVpnFbFTT+Ifdr9DtGCMeanvLBKyPsUufafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417225; c=relaxed/simple;
	bh=scynNHLZntdnjgSa6fiT0L6du/g5ELrDcNjAOoQ0xrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8OVrSkXDwI8rQaWgY9kd27WwKivGElQ2geEIIanK1f21EK9pi3ZdJtq78+WtQjbO7y7pDUzVX4/SQdXG5hhqV73YR8frmLgAZlsb6JeiZxdGhHGRhDDT03D4hZLjEzgqlnYsKBd3wPJsC8DOx76k9Fzss2ceGICm11KsYbJ9PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DcnX7sr0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DcnX7sr0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361uSI312168;
	Thu, 3 Sep 2026 06:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OpXDqA4IrF6tYgvzL
	FsuOPdgMFXuHYqIjNNRmFkAhO4=; b=DcnX7sr0bdeawRpLJZ8ktrrukKt60sXcP
	/8EaWMNZkZpheMQ8UOi4HXnU0yesqHHExUVgkRL6IDCtoXlYI87fMemCIOQ3GU3M
	CRaPNv8f8P0su5NMhxdDKHqC0jW6r7GrxZUV3pNH9Zto4pSSmmbGNftKfrGFb95q
	Os+E59ekU8n+GgVgzZto8ZIttV7bPsViRRINciE/8bEMtA5h8u881VTRMQlFGoWP
	lTgj8hNXbGk/p1NWtkcwea674kh2/8j0muQci5xytChAObO5rCq3x8fs+7DMRocD
	4FymrQOQLdImS7QCgF6ba6Dp8P4zBIbVX21Igotm5c1ySNKa0gQJQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rkdhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QGck002978;
	Thu, 3 Sep 2026 06:33:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaprb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836XLDS30671494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:33:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 576362004B;
	Thu,  3 Sep 2026 06:33:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C42820040;
	Thu,  3 Sep 2026 06:33:13 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:33:12 +0000 (GMT)
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
Subject: [PATCH v12 03/13] sched/docs: Document cpu_preferred_mask and Preferred CPU concept
Date: Thu,  3 Sep 2026 12:02:30 +0530
Message-ID: <20260903063240.268775-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903063240.268775-1-sshegde@linux.ibm.com>
References: <20260903063240.268775-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a9914b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=2BnLtqgf9UOq1ijo76cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX5khyQ5ytna0l
 kIubaaA66w9Y4V5iPckpEi8vZdq+pArcdkt9nQLAguotIM6JBQwU92divjWxlyIOnQBpSIwSpCx
 5E4nnf4n5Xl3j5gdnEJUCDKmxhkopW8q9DdU6nYJBQtaXtRnqfcurRh0QUU5p3T0ci+zSbtZJ7c
 JSiHqAV0wTFZH8nD9SLegkznGc4J0ngL2DS2L6wIZbVeNxR4kkXnaRAo6rHQ/80dIZ9FPPnixOm
 2Xq+ocgA9Sbp6c1OBsL74VpcEoptztr3K9WbRJSeTaP2s7TBV7UKovR69ER2Edu4+dRLfwjVlD7
 Gw7NaCbBuZgh8urbUq1ekymr+mRFJrh9JLMIv1XuZFBwjl0x2KrdOg8W31OcpDwXoEeSaxMR/Zp
 29dOZLFHzTYSZLrXp1SvemhxOFr9OuUEpcJCuJ70zHZ3rjA6aZig+uEKlQMPHB4YmNkmF6cwwZ7
 Cqb76oGZpRmpqezUYWg==
X-Proofpoint-GUID: srczto0zDuxKQ58XLIX9KTVJkcUU9Ytb
X-Proofpoint-ORIG-GUID: bzzX3l-vM0wJQsJDWBFMf0DeDRlAAf2s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX7EFCvkNzG6q/
 0IgRRFB/0BrVg1SYdo2Yt5zJA8JzDmFwFoXLGQTOSNM2fWCCscQOllYSWSy5sXOdOZ5YRwXT+wt
 mpifvNa2GURPcFmmHHxwgBofWTKedxw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057

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

