Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31399566C66
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962269; cv=none; b=HMgS11RGWBGf0o8MktlTl7IoQFCBdkYFt3p08LEO0LfGvefssg3G6NHqS2DvI3VzLaLekc+AzVQ5vFaSL0RRjty0m2VA0Iym0b+z4AQLefgGDfPgwu5BRU5wBRelUf8uWH1yKbO0W1gm5Pwrj3pSgE9WgnEq7r5d1T8fy+2wls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962269; c=relaxed/simple;
	bh=KRcnPZxJ3TxjYbvZ/ffwiydMHYyd7oDraGjHWCGvvcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDhhAZEZUSlniqKIUZDv7kg97Cns4Wf2EYpFqMDwGKXHnYcmETOFH/5dl93enftueLVbz+8HJZZ4S/jDbZmW5m/rAvbXh3BuRWmj53ptyiOMNkbKUgnsJGH3Sm8izAlk0i52/hKZo8nT8/iKQinE1XieY/8wKNjf7jjNjLMAY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pvnbzR0y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pvnbzR0y"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1ktF3669941;
	Wed, 9 Sep 2026 13:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zmk93sQzf03EanZhV
	Bee2OYiiS4IEVygsO5Vm1CSPyc=; b=pvnbzR0ylmPna7lHdHrMuFADljixaIfSW
	yx64r50kn51SEGl1AtMTkJKCmJn5+dkhJL+Q5QVvMEWU0+tTzo+To71gLB+rwYX5
	AxJJ/rxp7+0vB8IH2j7mNctRexFkiVAkzlcd6E0IwIjQl4de+Ad3D7O3rNjfbXY9
	J4fvhV5wE/W5QZYRR3aX0W2M69IU8ZackNl7OpY1NwRvki3+qm8fNGH1s+CuIoaJ
	wrQcFftGGhvjGwdbpd6Om9aOJW4F2TlbE/AjdIBkeuNU0jzQ3OkTbrof3yiF3tQw
	u7Q0RuNURQFlcdLb04tNj3r2Z3E1eulIw1LgBwfp+vPr97FHR/IwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8dvjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuDJU008335;
	Wed, 9 Sep 2026 13:57:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswapwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:57:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689DvSiI52101410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:57:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB16720043;
	Wed,  9 Sep 2026 13:57:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBD9220040;
	Wed,  9 Sep 2026 13:57:16 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:57:16 +0000 (GMT)
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
Subject: [PATCH v13 05/13] sysfs: Add preferred CPU file
Date: Wed,  9 Sep 2026 19:26:09 +0530
Message-ID: <20260909135617.871006-6-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909135617.871006-1-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 621YhHMb7To8WUIq3rA2CXvj0gKxvm4Q
X-Proofpoint-ORIG-GUID: iUrGee2DfGJb7H_zlzgj3bZ9OkrRLBXW
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa165cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=94fVmjRkuoLjN79_KVgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX4fb9WAYx0lrg
 KfhLavjxAczgpKyXFSqhpYVN+9XpWDdg7/kYQvhNKATqcROE6n767aJ3mt0v8VSfEo1rfRikkbt
 RNiXtTI3Yq7va2sUwJRV1jNtM5c8Sv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfXy7ckDJUon3md
 f5fMxWzYkeLp1z81yXrT38+vMIUCtv6SluaG5/Moe30Z54MZl1cgYx5gzI6x49Zq04cbf9ewSkT
 5QX8/mnm5c0H8kNob9WOgz1lnfOzDa6fbaRzJzchy8zKPpHhDaVHOWiddfeJGZOITjyyvw3dIHF
 f2E6NlyzVnkGCiANMOjhLx0X35nXlFrmPGhwd2dFNf5eW1UllkJLs8V6ftPNsc4bxnFkbTP6xYa
 nSAywXqF9S6j3buvw+YrZAqhexLy/2J2YhsCx2RDxFXHATUgsgElHi/m5VdwqrlWpp/N18Qf/w7
 O+Rn/WSh8z3FcOGtBQJFoxnwKzQgzqjDyEZPsxsu7S0tyNkF8y5ud895zCZe49fvKG9b0DzWD4S
 HNLNNHhKUc/tgmVQPErcB6S6UrOyk4fBbsMyLiuwNmOuRguOvsQxfrbfCZYjtBpwSbZNzcLdvHH
 iL5Uc4nD1talgN64cmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

Add a "preferred" file in /sys/devices/system/cpu/ when kernel is
built with CONFIG_PREFERRED_CPU=y.

This would help
- Users to quickly check which CPUs are marked as preferred.
- Userspace daemons such as irqbalance to use this mask to
  route irqs into preferred CPUs.

For example:
cat /sys/devices/system/cpu/online
0-719
cat /sys/devices/system/cpu/preferred
0-599        <<< Implies 0-599 are preferred for workloads and 600-719
                 should be avoided at this moment.

cat /sys/devices/system/cpu/preferred
0-719        <<< All CPUs are usable. There is no preference.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 14 ++++++++++++++
 drivers/base/cpu.c                                 | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 82d10d556cc8..8f250b8693b8 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -806,3 +806,17 @@ Date:		Nov 2022
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
 		(RO) the list of CPUs that can be brought online.
+
+What:		/sys/devices/system/cpu/preferred
+Date:		Sep 2026
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) the list of preferred CPUs applicable in
+		paravirtualized environments.
+
+		The steal governor driver dynamically adjusts this mask
+		based on observed steal time. Scheduling tasks on
+		CPUs outside of this list may lead to performance
+		degradations due to underlying physical CPU contention.
+
+		See Documentation/scheduler/sched-paravirt.rst for more details.
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 69e52fed4241..747915ff974f 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -391,6 +391,15 @@ static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
+#ifdef CONFIG_PREFERRED_CPU
+static ssize_t preferred_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_preferred_mask));
+}
+static DEVICE_ATTR_RO(preferred);
+#endif
+
 const struct bus_type cpu_subsys = {
 	.name = "cpu",
 	.dev_name = "cpu",
@@ -531,6 +540,9 @@ static struct attribute *cpu_root_attrs[] = {
 #endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
+#endif
+#ifdef CONFIG_PREFERRED_CPU
+	&dev_attr_preferred.attr,
 #endif
 	NULL
 };
-- 
2.52.0

