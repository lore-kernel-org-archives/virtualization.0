Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AA39448F
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654427; cv=none; b=mFMtKTm9ysmcBTDpSNUsxHOBAAONSJiqRaS6WC708i8inMPIMk4gR3iPcNQTnqHYU8Kk7yN3qZ/9/0dmyKC9WTMJLF91LUOE6D6FSjtgKxyKtET6hXA+Jckxx4hCiwbVM97+NmwhPLHp9527CFqBkz4y0p3N7FrwKo+oUACnyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654427; c=relaxed/simple;
	bh=TDsgIO48g+8UYi8pPB4M66fYIvYKuUVdrZMjt9LJrYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONsACta9g/2SfXGY95mGYIAymM9QF/zRk43WXWp+u3rrIsYTQqMvKQ6pfUMSmz2f620u7R/vwMJmc9tGqm4u0H0ikLPsaFHYmyhJIguJYQpwqMY3k4OTk4VK6lUl7WckWrhizViVg9kX5lVoQA/bDgkxoCMglCrhRGkMhQz9a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kJzKPAPK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kJzKPAPK"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VhHj378168;
	Tue, 25 Aug 2026 10:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IdIQVMSRh1tQgR1Q2
	N7Opt2bZYabyV8zrFakwyWbq7c=; b=kJzKPAPK+0/gcZZcCfPWo1CZfmiZPewX0
	DoMvNY8n92KAWzYHteUixy4mcT4tRNJ1eiEQmrDsgAkbOxRzPo94c7ZZQSSffyU6
	M/Rf6V2kQYy8640bhSYsKA3FDmIv66sZnawvxdiFlkTSsAHsYq2sHYbzQ70vhJxH
	qkooOcoSvGcnHsW5nI9eN7pvk2SereRgTXPTYbst9IDVcL8bOzkTgYw0bv1ah5cG
	dseT6Bx1Qj3F7Ofbg5CCpMbJyLq39SV36U+jr9EabwoRaiiMkFNMJZqRILsu0bN+
	2Znu+VyBQhEaXDKbnako0UrInLzXbAAQg/yaTwZVpkvyyAyauj91Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx7aa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQSwI005304;
	Tue, 25 Aug 2026 10:40:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q3xbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:40:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAe8L529557494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:40:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E669D2004D;
	Tue, 25 Aug 2026 10:40:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C97F520043;
	Tue, 25 Aug 2026 10:39:58 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:39:58 +0000 (GMT)
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
Subject: [PATCH v11 04/12] sysfs: Add preferred CPU file
Date: Tue, 25 Aug 2026 16:08:47 +0530
Message-ID: <20260825103855.721013-5-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX5cvotuUGpPDY
 bW5JSdonH54o3AsAqyECUDBUaPSkl7Fp8tQ07rGM4DX9eIX4uWPtXMXLVGO6q36s4xuwKRqwbPQ
 dVML3+XcCj+xUqgNUhjPq1QQkRSZK+M=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8d710d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=94fVmjRkuoLjN79_KVgA:9
X-Proofpoint-ORIG-GUID: nKLWTKMyAO9f1eo0MzZ6vfuY9c7p0f_l
X-Proofpoint-GUID: VYSb_-2GSExxITTP6TGFadWd3vhICmiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfXwN+/DWK8Lvmj
 za/RYqL0PdoVSlbfND3FSPceAWY/vCaGd1fMB/QrfRjbH4zbUSiKQuatVw1rFXtPEKSSxgMPXbt
 WZv5HSETWMFakQGWUQ0GEVeAHz6U9tk9jdBnF4pDROAzcJRiKiC5zH0fI/GfOtI0XB7Egtmkqwk
 NkLM9Mac17BN82urmV6DgNMvFpMlRHTib8UJGTiN1oB6tbC7iLT3sIOVuPFdYm4kT4OYOurPgWk
 SJ2NTGRJsLFHLClmfW79MmTA256w5Ufe+F3kZQGDlDHtT92PdVlqmHIf+zhdi4czvZiKH3RFqlp
 epm0YgK0ck+FHXdxv4mfbvkZrN2mIybtjppq/D35npICsTrgHrsdXaMLCKvF8uAEL2WcYsK2KfZ
 fh2Jme5ICzy8XIbw8vUCjQdBQ+XOEcBFsbV9oqcj0H36xa/Mw+EIOuBQZqgBd0x8Z6GyT5fkKXj
 1CXZMnSDhwPjOrGkn5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250089

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
index 82d10d556cc8..080c69aca4f0 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -806,3 +806,17 @@ Date:		Nov 2022
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
 		(RO) the list of CPUs that can be brought online.
+
+What:		/sys/devices/system/cpu/preferred
+Date:		Aug 2026
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

