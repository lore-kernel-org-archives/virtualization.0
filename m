Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B3A3F327E
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417248; cv=none; b=Lss1wIPzqgPl3QspPVp8ydGNC9w2CsjrzRK+pMaC8LsqTEyrFl7u0nNr3CzCNnbaQgiRk8UbdKECooFUM92UjhkSD8Apl6Q7RLzlVZM1bBz7qwCo2Kj8kU6hDOk+0quSdT4hs3rx0BukPWN5Ed87+YyZKUOaBZmevmWxB/YTf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417248; c=relaxed/simple;
	bh=KRcnPZxJ3TxjYbvZ/ffwiydMHYyd7oDraGjHWCGvvcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pr3Z1CSQQx0BdVJSG80G9Ap2Hp32DZHdKBqodT2+2xmMKPqpZQ+DpF3SGLaGaNfVDQP72qo4t84m9GkDIG2L3EK3uzGVczIQHogPKialod8QSxIho5LUhcY4EbUwXECImjeWRodE2KOpZwH+aoGr2Uf9eSe1WbfKxPv8iMoHOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Re/C+6Q8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Re/C+6Q8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361RRD2186402;
	Thu, 3 Sep 2026 06:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zmk93sQzf03EanZhV
	Bee2OYiiS4IEVygsO5Vm1CSPyc=; b=Re/C+6Q8WNaPa24naZlzI5B4M7fC/Ja6e
	dBv8U7AaUgKu+Z/TfTyR31SzuI2e95LGHXSHSAu2WpG3pDcuICCwTDieuJ92vOYF
	uH5rVOhVWBtiwUK3vWO7+dM0A/rOFGTF2x/OOzVvrr9FbSRbqVntI4lLpy+KtNtB
	8KMLUPLHuHI+SRHlJANoJytm+3dSyD2LgIJswwma9G32KrjjLhR82TaKQ87lhu2i
	6isy3DnbaI9Q81/zf7eGYupJrpUehNH4EmJCIkR/G5WqvPavv8MMtkkdMpfLqOFy
	SEF88ZFMH8bzEuKRbSwRQQhOKnKjj7CGog/75eyt8WSaa4jHgFhTA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq553fcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QL1v009538;
	Thu, 3 Sep 2026 06:33:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceye61c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:33:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836XcSJ48759252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:33:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2BE420043;
	Thu,  3 Sep 2026 06:33:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B91820040;
	Thu,  3 Sep 2026 06:33:30 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:33:30 +0000 (GMT)
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
Subject: [PATCH v12 05/13] sysfs: Add preferred CPU file
Date: Thu,  3 Sep 2026 12:02:32 +0530
Message-ID: <20260903063240.268775-6-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX5kLtQsPMI8yn
 cMuuODvQwhL9RsAXQLQc1zOkjIwVsokJ66GEaM+8iaSmfIdXmAVzRxP+0f1ROSzmFAVkgwFTt9Q
 03/DLEVcxu3xWI9RXU/EgZ2qAsx7zH1oA22pnIKxrVFdeao7E8B1kzilTY/RtLPo6X6616M5UYF
 kSNf/7yJpHAODnj/Nm6TUnJ2VyEzeUfGQM2Qss668kjnr27n00A1XRJA58x9h5E/r22KoPTB1mB
 E9VAu2KOWLfv3UNDxm7vx8GnNBpRsfPkdEOIsNYVHuZqnpp9XwLUC5P5wW2XhMXJsx/xM15/ejT
 i3HY7Q/WCcjp9mxSabWLzEKF8czArofFDePXTJWFgA0iAQKwNTDAxBeSS+brejNn9g1GBIixNxx
 vBx6413nqnrW9Gd3TKmqAZ3MRFDuK17j0kWBHy5fVPqgFkH8TDn1hxLlow1UFzF1T6IbBOfuvf3
 Ukr6jgdjl0bGAdsBZRQ==
X-Proofpoint-ORIG-GUID: nzvIYDW2euOOE5HIZDo3qhnC_PGk_VRs
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9914c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=94fVmjRkuoLjN79_KVgA:9
X-Proofpoint-GUID: qKhVofSj-YCpys3f_KC3-a1DgfgihM7N
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX7WxTtjI3ksIs
 BJNC5Fo91kO9B+raIrWGZwW36+7fyQ2ihRzdXFEwNsWL5pJA+n9VOc8o3tFrlJs3W3XvGfuEwsv
 wRzxF/LkVEh7X/UOGdfPOGfdVd8bJrA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030057

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

