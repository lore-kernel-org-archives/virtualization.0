Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B2550DA6
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962334; cv=none; b=ak4Kc6NmMBk6e3nvBniuuuWqc0Ze09IEH33XRQJm51Hleg8JhIHJ7KCucUHT2kTwpE0/ohn/+HQ/rUNySFXp9h1R95ve9rDWW+UHGaHL5vpPwV47RzR8ZLSxTdC/pc+x+OANO7YLDAvy2fsKWWaejlQjcRKiYeYzCK3kNPHKco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962334; c=relaxed/simple;
	bh=xWTA0IdYijO7IFASgKOZ0Vabj/amKI4jA7+ChmTjM4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObRi0um7rQ+SIkOhozSh02D4GHTjKoyN0fFjiJBoWBgFYIwjBxJ4zYSw4xW3OlrR/brJKQ0INa07FKoNozhPsDA3PaafkTccFOuzm8kTnZ8LMR6hWSlm3wfPYHG111hR3J/SJkoOhux75w6gIneNrvnJ6SiwvjNZoRCJAT/Gneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EbL9Osoj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EbL9Osoj"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1sLN3670080;
	Wed, 9 Sep 2026 13:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lkEEt+Avu0uDBakRz
	khxYQgptYGLHcGm9wFZS1Clsp8=; b=EbL9OsojH4dYUIuuwn9OTR6O2I3oQr34Q
	t9z7r1aKeO/N9syGE66Euv8aPMSj5XF4uaoPss+0VgwHZIG7yqrAbFpoLHtYH1Q3
	Z4eduaWtZLaJ+kA6rXL277+/D1xiyJyWrZkCsz6rLYXN0rY3BISfOd4WTnIcxB3N
	5Eo+84R3On1ucBAKSTnu/h6q5Ha2k/85/zP5L/7Z1q5dliRCI3Pg3sy1GxNhiSRq
	p4fAIBr9cRgX1IyDlTYb9foblrP98EUtal8J5jJ3KAkAubM0NsVRdctwncGmAHs4
	rgxpqYEEe5fCRC/UIBIIPQQlnn4W/urpvPo6lME+l0/m++VJJKMVw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8dvqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:58:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuGli026482;
	Wed, 9 Sep 2026 13:58:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgjf1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:58:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Dwa0126542750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:58:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B61532004F;
	Wed,  9 Sep 2026 13:58:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8366D20043;
	Wed,  9 Sep 2026 13:58:25 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:58:25 +0000 (GMT)
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
Subject: [PATCH v13 11/13] virt/steal_governor: Add control knobs for handling steal values
Date: Wed,  9 Sep 2026 19:26:15 +0530
Message-ID: <20260909135617.871006-12-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: CDsvSAsDC51ngeqP-ljGPY-_lMgYWIzv
X-Proofpoint-ORIG-GUID: 4lY1ODbJcA_w2mkBy15dyLS1Z2tbYowv
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa16612 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=XC_GqrfF-lTPz34eE_0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX0ppOYzEmGaHt
 Qb7TgEkv/6GOqbTUN4NEaMfYmd+TipvPCaNOEHjGR+UMakCwpeNmJkiZ29ZTTvcxvZTLJBXlZPx
 jeX68E5uI/uswxCTtWJuRIhFwq8Y2ZA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX4RG3hohpA+GB
 hwOXfijhuttryyzsJ9FcP88U2bnG+6rJoFKC9KW8uzbMNi2TglKNre2ejIh5j4vZ6wV9Kc1KhM6
 GOO8Xq+q68uTTlk80VXesYxOR/Wi98ouaW11mpeobC5YXwpUUb/X+R2pHZ+OSI0UDUq5Dv9nzwl
 UXRoYsyt5nTMNm9JwlSHAjmkrAGX0k/2z9S2rFmwfhKEsCxke/Z0pVPSAv0TqRsDN4jWM/sTbrW
 FazzGo5Zw8ElNOLDLwfT9l3RkwyNwZZ3kc3r1FxZnlnByyqHV8GBzB6593dmJgSFT8/8H4S5e68
 bgT/lqeYJ/ggOdE5kBGLZmbSXJDKXPxHJD1pyVBDdiPVeSJQ1xHHP3BUjMxS4WQvZl8PFTfo3wt
 HPE7d8mtD9yBMrYaBTDlSKfYC/Cup7nyEOjBRK3fkz+0/AGDSQ3Ar2mKSU0LJdjR7Y+NDxGyDMA
 pIwWwuj9lYj002ev61w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

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
When steal governor see steal ratio is below or equal to this value, it
will increase the preferred CPUs by 1 core. Having value as zero
might cause oscillations

high_threshold:
higher threshold value in percentage * 100
(Default: 500, i.e 5% steal is considered as high threshold)
This determines what values should be considered as high steal values.
When steal governor sees steal ratio is higher than this value, it will
reduce the preferred CPUs by 1 core.

module_param_cb methods are used to do the validation checks.
This helps to ensure one configures sane values.
Since low and high are dependent, that check is done at module init.

Notes:
- Parameters values can't be changed at runtime. One has to unload
  the module and change it. Hence recommended to build it as module.
- Default values may not work well for all configurations. Tune it
  according to the system under test.

Documentation is available at: Documentation/driver-api/steal-governor.rst

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/virt/steal_governor.c | 73 ++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
index 2320cbfa4b47..27f53ea16498 100644
--- a/drivers/virt/steal_governor.c
+++ b/drivers/virt/steal_governor.c
@@ -40,7 +40,11 @@ struct steal_governor {
 	struct delayed_work	work;
 };
 
-static struct steal_governor sg_ctx;
+static struct steal_governor sg_ctx = {
+	.interval_ms	=	1000,	/* 1 second */
+	.high_threshold =	500,	/* 5% */
+	.low_threshold	=	200,	/* 2% */
+};
 
 static void restore_preferred_to_active(void)
 {
@@ -51,6 +55,62 @@ static void restore_preferred_to_active(void)
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
+		pr_err("interval_ms must be between 100 and 100000\n");
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
+module_param_cb(interval_ms, &interval_ms_ops, &sg_ctx.interval_ms, 0444);
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
+		pr_err("high_threshold (%u) can't be more than 99.99%%\n", threshold);
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
+module_param_cb(high_threshold, &high_threshold_ops, &sg_ctx.high_threshold, 0444);
+MODULE_PARM_DESC(high_threshold,
+		 "High steal threshold. default: 500 i.e 5%. Must be > low_threshold");
+
+module_param_named(low_threshold, sg_ctx.low_threshold, uint, 0444);
+MODULE_PARM_DESC(low_threshold,
+		 "Low steal threshold. default: 200 i.e 2%. Must be < high_threshold");
+
 static int __init steal_governor_init(void)
 {
 #ifdef CONFIG_XEN
@@ -60,7 +120,16 @@ static int __init steal_governor_init(void)
 	}
 #endif
 
-	pr_info("enabled\n");
+	if (sg_ctx.low_threshold >= sg_ctx.high_threshold) {
+		pr_err("low_threshold (%u) must be less than high_threshold (%u)\n",
+		       sg_ctx.low_threshold, sg_ctx.high_threshold);
+		return -EINVAL;
+	}
+
+	sg_ctx.delay = msecs_to_jiffies(sg_ctx.interval_ms);
+	pr_info("enabled. interval: %ums, high_threshold: %u, low_threshold: %u\n",
+		sg_ctx.interval_ms, sg_ctx.high_threshold, sg_ctx.low_threshold);
+
 	return 0;
 }
 
-- 
2.52.0

