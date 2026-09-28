Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E838CFF8
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573957; cv=none; b=Dfvj+F2dH9ivmkoyrahrr8xf0RQSY7o3TwHbyu8YS0G93un96cAwsLAi7kbp7SZ/wzUwUJItmGBntMno2JrbgTmIUb3edfIDuHhbGfdFzK7wqnywyDW3QiIDsdlD70773MkMqBF17sQJJHESZz2A3os8cqfERkMdCvXVuxfplm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573957; c=relaxed/simple;
	bh=KRcnPZxJ3TxjYbvZ/ffwiydMHYyd7oDraGjHWCGvvcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5hQ+L9AG/Jh+RakhFMGA9SQSFy2nBk9e4Kyhc50oBN3X/NxYKRJt5FbYEPRGMR4XnEcolwlr2vISxI5G8Z6pB5IzZgkMXWLZdMLKomVe9e5qnsr2YdaZT0tPBm4DAzyjJDIWbOkr3F4Wt5SZVN/v7wvVz9dT8oi/Rle0NIzfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ev73wQAE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ev73wQAE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68R807O7188598;
	Mon, 28 Sep 2026 05:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zmk93sQzf03EanZhV
	Bee2OYiiS4IEVygsO5Vm1CSPyc=; b=ev73wQAEY0tAJyDFdwYMAaxjttJ4hNWY2
	mqPM+ekX/FT4NqnjcFXa5YgORH8ZmeVr4tkNYD1pulrz4QyxYXmrrFL28yfCwnCR
	7/FJ4jVsl5sti9vSBy+rhefV3Xsh63asHDf2MY9fXRGHP4duOHxjv3ke3n6o5kLw
	WQtVSBUzKyFlGwb+ieh/MvBAW/snyYni+pxqyCajhxv+nezeB2BJKaRqOax86ssa
	nB3HdI+LZLwJ/jLz79pNH5JnE87oV4iJA9j3qoNJ55YT8wH5nwxzaf27MEnsBhZ8
	B/MyUDc7MgBKzk5dNvvBQUNz+3DEazXRM8SvdEZqJbRCobaOtJOfQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qqyg2d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S559ld2234289;
	Mon, 28 Sep 2026 05:38:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y3jq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:38:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5cjWV43254188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:38:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED2422004B;
	Mon, 28 Sep 2026 05:38:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24E620040;
	Mon, 28 Sep 2026 05:38:33 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:38:33 +0000 (GMT)
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
Subject: [PATCH v14 05/13] sysfs: Add preferred CPU file
Date: Mon, 28 Sep 2026 11:07:20 +0530
Message-ID: <20260928053728.797539-6-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX7xFTp9VID2sD
 ugFI+h2NoziYQ4xvB7Sx8N/QD7pyxmJHGyuGRwoUx7RMsaFwmCgtwCeOq8yWEwJpoHrFISMBvQm
 ePFoq+6Vsrk4syejEuyI4qAubc83uheWkxOwQJXUoxrQCfgCtKB3BmKM07xY25868BNrBm9Coxg
 H+Ev+L/yb4k0Ge4EKdBMj9CUKf5Afm+MSF95iKT1y5rJRS0DgNtjZCQdUJt6BMgV2eAZfYi1m7r
 jhg85CM5nfeMi/lgxFhHwYS7ARpBUoVb+ED6X51Y9f4Szt68Wu+1/LcyHZeWZaDT3Q7JYqjKixW
 CujGCZQ+bRdgv64XTemfEYFntYuhn27fQB+tn7y7u7UoIL0Cd19w/oUVNDrjmV8I7p8fHjBfRaM
 YQkIPE4auUooTjUMXE7jrqu0NLsfxLgkAwiz2oBzaJqAmCE/T3b4iDi6wPw/LEjbzPwKuGcrKEW
 VCyS3q14Vpm5vR3EDtA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6ab9fd6a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=94fVmjRkuoLjN79_KVgA:9
X-Proofpoint-ORIG-GUID: LDgFbdq6Iw3tcR86z6Y-HPL8SsDbHBpb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX5QxeX2hYV26N
 N7jY2DBNBPqDPQXLcLitbmghpYteZDAD/XEH8r/+wtZk7XUGzxDtD7lAYIOT0rTOXdMP2QzRTgB
 YDzmn8oebjWaDfoc7ljgjnIbO/lReTg=
X-Proofpoint-GUID: 1NwaQPwEnR1PVlFsllFh9HrN5BFwmDhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280022

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

