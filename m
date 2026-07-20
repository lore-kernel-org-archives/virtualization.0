Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E8445ADA
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568239; cv=none; b=ttdTD29Lb218Ghk3EjdXqeUDMqMyApYm8nE3jKlUNRxS5fS1UkiOvNzx3/pikfx6CxM9bT2n6gxBa+gfFofHt9NdULpzHnfWzX6gXvTYgPUSP2C4nyzL72pEbNfr6eUYqiNCKFsW/qISG6riO/YYT6cSl8jdGiAhOdTzOvMdeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568239; c=relaxed/simple;
	bh=6228di3K+K40oi6cCOvgEmLnJ4IaBH3W+zV/3UUL2cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHEvoUAORMqDGgSeg8ruy4mMHq+x+sCQ2IatuXobR7yGCpbjNo1PM6ip8m/EtXqTchzJVZvuk4CjfBYmqsQ1+YEZI8eygzRr4tMAPPMigaQjaImeRz4aITwkEZrptvigbtPixQd63ch8Lpl1k6P9veh3KSP0jVue5FXXo8VQ8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o2A0nb8B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o2A0nb8B"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBr4r2713512;
	Mon, 20 Jul 2026 17:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cPfhGVrlIhSc9SxNl
	84q15+rcHKUKn8NOKKLryxp2NU=; b=o2A0nb8BwCBSvnhEQi97M4/p/0JJSGajY
	I0//0k4d75gQBHvZSvbGFoBovUsVDPOC3886ti/nRZhQp0iC826gRs1VamyV3VMe
	jYRpn+OKYWaVIh+rpJEjhLJKWJbZTRGMgwVjLY9sxEdMZqkDhnr3xiHb6s17lgW3
	E6itZ1wk+A3CAMZT5m4gzEgJDU4NPMp/PvYHzqxJgkBE7qeV+K9K4G1DpJMXIbcY
	cxY8huVRc9aVdjd5IsLO/jmtztQjDJXdnGrH+BiiIKzri7WTCnZYqvng+QkCLATe
	lIQ6vfCDIoBQK4/MuyTEly3UOEUuWLOuI06xSvUSWn25aZSTOYP7w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g0d7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHK0J6002260;
	Mon, 20 Jul 2026 17:23:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagxjq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:23:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHNXP639584098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:23:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7DAC2004B;
	Mon, 20 Jul 2026 17:23:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0B6F20043;
	Mon, 20 Jul 2026 17:23:25 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:23:25 +0000 (GMT)
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
        virtualization@lists.linux.dev
Subject: [PATCH v8 03/11] sysfs: Add preferred CPU file
Date: Mon, 20 Jul 2026 22:52:42 +0530
Message-ID: <20260720172250.2257582-4-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX85tE+tyQQuEw
 ABgofXbJHuamfBJ2aSR6TYM2acA90ZDWbJV0OWMPJ8I1qnwgUs8ftbxhcyTDfz3vhzeVHutErA1
 VE9tD7yE2rsq6FeoFR0wlro9Y+s7Dv2Y/d37mShNVKZ/U2KuiOUzBHJWUYGwJRI0F4DYJwfyp0Z
 Rzm2ELqDRUZMTqE+JfT96pPsGByDPIXS8mBzUo3MP0S26k8SymNlL1opErPYVT4DN8+zRVuB4fk
 K0dZvLh4a74lAn6VGAHI98OcTKNpb9iosCJ9/EIUcS/t18B22HYLwGBZ297fDAKlPaiTouM2Jmo
 aqUnCUTYFOzgcbLEoJ8YSflQjI3Bt6XK/im9AWGzBIMO9Pb8gBEbp9KbEx0gu4OrlAVX3O0PTpU
 Zw2IMYhear5hpADx7K+wNnF5cVUktWkWAtkri5szhZ7Ju0pngmEl+DY4LbuAw6UUUmckB7CUU5q
 OEPBVexmQ6EOJy6g9qA==
X-Proofpoint-GUID: 15BXk6vYYeecepVdn4aZBIAxACSfipwY
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e599b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=Tj8IOOKMsRt27BSU_nUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX8JGVi6S79VtD
 gYt5QA6+AcFUVFtohfad7yhDjkHo0Ol+L9Q0PB4LWA3iPmWQ8FCb3UeHWer7+E+dkCeyBpMkubY
 HF8X7T3s2Df1ts5xh80cUwR/QLWL5QI=
X-Proofpoint-ORIG-GUID: GJMdKyygHZ4jGcGRpOH4EhFa3U_4dJIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

Add "preferred" file in /sys/devices/system/cpu

This would help
- Users to quickly check which CPUs are marked as preferred.
- Userspace daemons such as irqbalance to use this mask to
  send irq into preferred CPUs.

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
index 82d10d556cc8..676412c46b2a 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -806,3 +806,17 @@ Date:		Nov 2022
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
 		(RO) the list of CPUs that can be brought online.
+
+What:		/sys/devices/system/cpu/preferred
+Date:		July 2026
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
+		See Documentation/scheduler/sched-arch.rst for more details.
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 19d288a3c80c..5da2a96fb37e 100644
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
2.47.3

