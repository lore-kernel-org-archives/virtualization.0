Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D03BCD13
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568293; cv=none; b=ivx6gROYTy8347fb8Q8+TPRFUXkSakRYZDidyxUhlzfIUd+jLgb8ihMFZa1xFZgY3C2p08aFxVQcsAxNcoKjyZJgruLuP8vdE/m1XMRebSlmiXafTBea4mtkTrrlXLnO+5ntF+FM03vLWWa6o0McM0t7+F95Fmzt4v5XW9A4fD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568293; c=relaxed/simple;
	bh=gAgQBybyeInWqS/Jps2UHI8s2sjg0LrS7abTgHBRJiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGz0JNZmoLJEP7ymc+SLfpsNOVnWOe4iuinBiaRQphT3OfMfi0lMc3SWklHZGkXCWckhqs/ox2Gs8PBdrp6TUoC0bDFWw6R6BNKSQlnZElc4EiA0pqDz6HGAAQTndmqA8h1g7TP7hFlnPyWR3EZuDFw1lZPIXtjs8hyRG7wRmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wo6tvO3g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wo6tvO3g"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBg042815868;
	Mon, 20 Jul 2026 17:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/Uj2IdE8ZFuqxyd6v
	V9cb+p/drkSgSrLxKK/Nlw5wpg=; b=Wo6tvO3g4eeqLOEzJ1EwlPiqWmEDKPPRH
	plSFbh2Jd6Mt0ViCZYHW1ZdUHu69Ra8qTEpH08jtw5410m/JbVSx45AKmMIn8mXh
	+oJ1soevZm/YWwnA/87/EZajJFqiaa+X3BacE5XIz1E6QoLHAWizhXKwv/9LJSe/
	wmXWhVSAilwRW8iC2oSDMTyUnGjjhUB43hR3HiGj0sK8O+rGbv3YRleG6kugWTTS
	3AQODz8xHZy/EJKkBMYe4hnFN3cSVN0rpfbdklpp6t8RPsUO5xMWzAt8ip8C+A2L
	1CZlaaoa7INTL6Bfew2DggdH/jlxvyhg+WcKD9cedR2EP/1N0cOtA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790rq9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHKAut023843;
	Mon, 20 Jul 2026 17:24:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vxr37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHOQxM24379874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:24:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BBB22004D;
	Mon, 20 Jul 2026 17:24:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 341C520040;
	Mon, 20 Jul 2026 17:24:18 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:24:17 +0000 (GMT)
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
Subject: [PATCH v8 09/11] virt/steal_governor: Add control knobs for handling steal values
Date: Mon, 20 Jul 2026 22:52:48 +0530
Message-ID: <20260720172250.2257582-10-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: r4LOzhnb7KqmwLwZjchrAhyzvQ9fVluJ
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5e59d0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=XC_GqrfF-lTPz34eE_0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX0pdrYH5Y1JNp
 aU2E2NMZ+oCni7hZMOcymDkr8YgSoiA2S27PjawBBTOCtdT9yrPfDsxtL3v9ctWSAnmvbutcCuG
 s1OiDST1tnf3OWsn0jNRwlxZOqtamw4=
X-Proofpoint-GUID: T7ABc4SPSa_R-RuoWeFJCyd8vwtNmYkQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX9Tk1OD2K+a6J
 d5HKEg3LVMFMWv3MLpqc56MP3IxDUQ+My5uCoI5c4ZIMuBO+5Qp6kueOQuz8vCxsUUlMADcr5yd
 98rplo2Ngn8vnS9fptSinOlUHkKRySYgC+X890wYfUHP6eGWYDfv+1OWNe3e/tDzjoL984yYSqo
 sTtd6cPNVxYnemus/PbuJ+Kq17PnaC0RYNTdnfKJGX7uXu21fnm5lU/2ZQEjLGqmlfYzutAcF7y
 Vt046zNkaK9e5ls/ZIf826/OK45ru5XJ29Rftib6I7VerPAPzRR6fj1QKMJT3WEEtFWorRNFT5/
 jcCUUmzCRZcmFcx+IRoNJtLRQQG8qxqz9ZRfq0GRMHkiurA5IWRKDXd9tntfvsZmRz7EU8mfCWd
 2rLZNFtGzS/T0RQlYnt1hrpYFZDA8OFxgE0kil15k57I0gg59J2OzTZV+8f6Pa+mYZZPBNKJ7Jo
 XucmX2eoNXOK9A6RLqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

These are the knobs to control the steal_governor.

interval_ms:
How often steal governor checks for steal time.
(Default: 1000 i.e 1 second)
This controls how fast steal governor driver reacts to changes to
the contention of physical CPUs.
Can be set between 100 to 100000. i.e. 100ms to 100seconds.
100ms is kept as minimum to ensure few meaningful steal values
accumulate even with HZ=100.

low_threshold:
lower threshold value in percentage * 100.
(Default: 200, i.e 2% steal is considered as low threshold)
This determines what values should be considered as nil/no steal values.
When steal governor see steal time is below or equal to this value, it
will increase the preferred CPUs by 1 core. Having value as zero
might cause oscillations

high_threshold:
higher threshold value in percentage * 100
(Default: 500, i.e 5% steal is considered as high threshold)
This determines what values should be considered as high steal values.
When steal governor sees steal time is higher than this value, it will
reduce the preferred CPUs by 1 core.

module_param_cb methods are used to do the validation checks.
This helps to ensure one configures sane values.
Since low and high are dependent, that check is done at module init.

Parameters values can't be changed at runtime. One has to unload
the module and change it. Hence recommended to build it as module.

Also available at: Documentation/driver-api/steal-governor.rst

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/virt/steal_governor/core.c | 73 +++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/steal_governor/core.c b/drivers/virt/steal_governor/core.c
index 055f155d2045..1cb766a8ce28 100644
--- a/drivers/virt/steal_governor/core.c
+++ b/drivers/virt/steal_governor/core.c
@@ -17,7 +17,11 @@
 #error "Steal Governor requires CONFIG_PREFERRED_CPU"
 #endif
 
-static struct steal_governor sg_core_ctx;
+static struct steal_governor sg_core_ctx = {
+	.interval_ms	=	1000,	/* 1 second */
+	.high_threshold =	500,	/* 5% */
+	.low_threshold	=	200,	/* 2% */
+};
 
 static void restore_preferred_to_active(void)
 {
@@ -28,9 +32,74 @@ static void restore_preferred_to_active(void)
 		set_cpu_preferred(cpu, true);
 }
 
+static int param_set_interval_ms(const char *val, const struct kernel_param *kp)
+{
+	unsigned int interval;
+	int ret;
+
+	ret = kstrtouint(val, 0, &interval);
+	if (ret)
+		return ret;
+
+	if (interval < 100 || interval > 100000) {
+		pr_err("steal_governor: interval_ms must be between 100 and 100000\n");
+		return -EINVAL;
+	}
+
+	return param_set_uint(val, kp);
+}
+
+static const struct kernel_param_ops interval_ms_ops = {
+	.set = param_set_interval_ms,
+	.get = param_get_uint,
+};
+
+module_param_cb(interval_ms, &interval_ms_ops, &sg_core_ctx.interval_ms, 0444);
+MODULE_PARM_DESC(interval_ms,
+		 "Sampling frequency in milliseconds. default: 1000");
+
+static int param_set_high_threshold(const char *val, const struct kernel_param *kp)
+{
+	unsigned int threshold;
+	int ret;
+
+	ret = kstrtouint(val, 0, &threshold);
+	if (ret)
+		return ret;
+
+	if (threshold >= 100 * 100) {
+		pr_err("steal_governor: high_threshold (%u) can't be more than 99.99%%\n",
+		       threshold);
+		return -EINVAL;
+	}
+
+	return param_set_uint(val, kp);
+}
+
+static const struct kernel_param_ops high_threshold_ops = {
+	.set = param_set_high_threshold,
+	.get = param_get_uint,
+};
+
+module_param_cb(high_threshold, &high_threshold_ops, &sg_core_ctx.high_threshold, 0444);
+MODULE_PARM_DESC(high_threshold,
+		 "High steal threshold. default: 500 i.e 5%. Must be > low_threshold");
+
+module_param_named(low_threshold, sg_core_ctx.low_threshold, uint, 0444);
+MODULE_PARM_DESC(low_threshold,
+		 "Low steal threshold. default: 200 i.e 2%. Must be < high_threshold");
+
 static int __init steal_governor_init(void)
 {
-	pr_info("steal_governor is enabled\n");
+	if (sg_core_ctx.low_threshold >= sg_core_ctx.high_threshold) {
+		pr_err("steal_governor: low_threshold (%u) must be less than high_threshold (%u)\n",
+		       sg_core_ctx.low_threshold, sg_core_ctx.high_threshold);
+		return -EINVAL;
+	}
+
+	pr_info("steal_governor is enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
+		sg_core_ctx.interval_ms, sg_core_ctx.high_threshold, sg_core_ctx.low_threshold);
+
 	return 0;
 }
 
-- 
2.47.3

