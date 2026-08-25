Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D82039448F
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654407; cv=none; b=pm7NF0v5/btZaJTfKTHr+sNN06v3T8RnZxqkU7jCSkdbGLewKnPxluOP0jFvHWz8oc3TCb5uswQ8aGdaLxmL9UJ+rP5w1MXTIjjsHoHIqHk6pIhKmUJwC05x1btsgHrR72AI1eiG+nYZvgKweauoBPl0CZzmA/p87O6jUkayS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654407; c=relaxed/simple;
	bh=5f6u/bpKkYFPlM11kmtFl8Gsefsb4H7gRu7Ky6MhlBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tONMA6oXxqEaxtXAhgjC2H9biu48Yidst2Ku7WgtM8zW4Ij/0RIVGBjzncWCKKDGeF+YE12jXVadb9u02CYD7PnIAmY7jFabQD5+AKQ73ypD9Bir8JLkRmKoILFKzN7WhsT18+NexukXIarlqQnuW9yuQI7O7nFzviq4nAJf9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pilZF5SB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pilZF5SB"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VcGv378029;
	Tue, 25 Aug 2026 10:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wy0qUHa14/8d9qC8o
	WOxhgxGkFyPlhyXtVR7sYKZh9w=; b=pilZF5SBS81ViHlPEv+I4ZHvDHCUyT1yd
	ho9fJIK8TSpopQv4znW9uVVw8wHmmoApX2tYKVW2HPvG3PGRjWdsn4ytQcKEMp4p
	gHs4Q+a+2Zu8xkS8jn89YUmyznT4iNhP2N2A9EYKp7QqMzQNG7aWmvoBM80tZ9Od
	ErInnK/1D3BJSrTE0a8fDWsgDPocYE6hRuhHL+OFp6WKYhWIOobI0c1PMurHy9Md
	HmDT37T0ukzt8hqGwyygw1gSlFW+vFT01FBm2LhnSbdsW9x0JQvVcWXISsz8h3TR
	8MFWb1hAi5ebvNirrZuIPOzferW33Yt9JeHHq6Or5aflx9+tBs36A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx7a7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:39:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQH0H003307;
	Tue, 25 Aug 2026 10:39:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh3me1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:39:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAdnVF45613474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:39:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31CD72004B;
	Tue, 25 Aug 2026 10:39:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 465DD20040;
	Tue, 25 Aug 2026 10:39:40 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:39:39 +0000 (GMT)
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
Subject: [PATCH v11 02/12] sched/docs: Document cpu_preferred_mask and Preferred CPU concept
Date: Tue, 25 Aug 2026 16:08:45 +0530
Message-ID: <20260825103855.721013-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825103855.721013-1-sshegde@linux.ibm.com>
References: <20260825103855.721013-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXzYADsK+pp6xG
 WsDc/lr7knXXwj8Y4TFGZ4D7J1FkijTRtZDPE+JUHv8wO2aELHVox1F2beec4iaY1RPQjd5hDQi
 /8NIy3rJ6VOZLamIx66KIKQe4EqwL8I=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8d70fa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=2BnLtqgf9UOq1ijo76cA:9
X-Proofpoint-ORIG-GUID: bjtvlSC7gvrDvVokii5-b_LY3tIS9qUh
X-Proofpoint-GUID: MZrm8c5WWtIlUcplxRQ6MkFzCFuDVrlX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX6RUWkqndCdz8
 eNlocqfCHxGBxgBsyfRx5xSzgiQa7BL1dmFyVz41NtQZ6UU4DR3FKuKT7RDRY4bzYGuycZodXu0
 cvzrt/eoKuoMkgbA+bs01q3yzxmmDZtBa9ktIkpSvKp5NNIxAYhgyGnmHBfD1Fa2/UWX396yvYT
 df2fjjEWj0OYmWBTs9mtkR1tUd5TKPTto47W27nA84B5E82fdT5BB10/2MHEkhpYEVNqAmwx50X
 e+ZvkB8FoTH2hrta6gVz6iXw4vYMvEWYXEP3zLUKsBsrOtyYNfh3GlLmc3kqzFi84SXnimueJs+
 wpwBOT3l6+2PfJ2qkERbzvqoNP58rFnbjqP/FAu01u9Z/kgETncvx2BsQV4DtHVIQRlmmHf4GVC
 1p7KnnGo38JsxoctVI4rN6Ib/BseDtIF87iCgNB9eze2tmTT6HjLJjmLwBXEPk+PZTdiBVy7K8G
 RKHz+l0yauFNHJ9d3eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250089

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
2.47.3

