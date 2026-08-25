Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF313EE1FE
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654485; cv=none; b=kZRDjVZYAAOUKSaQHDsjocC7O97aT+ViVmpY+h3/FmBRm0WMJic8tX0a7S6cvAtlb4bDmLvUOommQhDxkXWidxa5JNuAAjQTwNEKCUTm46m2yHYA2+VlaGFkCi8NYEDAhQBRIgfH1ePQDYMkVUAuU3zYKzvI1kBDqtDVyps766Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654485; c=relaxed/simple;
	bh=Ai7BZFUwbrN1gH9HpwgUQK3VLaG28dly6FZX8ayTblY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWEpFH3slV2EnJtgdLClRjqV/DI+vvRxPD6cHYHXdQni2qi5N/L3+1L8u3ZaJwEIgDY3RzWfODdwHi3r7+W19SIekfKimmUnfmOT47/EB08YXgytWPs15rW+sVxxHxrH6vGYpj2/4glleQEQniwlGSUPuRvfFdJ+0b6HanxFCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C3KUmZSd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C3KUmZSd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8Vcpi378024;
	Tue, 25 Aug 2026 10:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M/Nty/8xoMmBzlksU
	iq0rAIJjnFP0kPDZRGSr+wzHPM=; b=C3KUmZSdybMt8OS9uwfcjhT8whbhiaxwM
	983AbY4N+qaDf1YxFNH2UnjNOLc/k9UMdQQN21VbS65X9ZE5LgOv+230/z4nTi4s
	qmX2UwbAxO4BPjQWvwhGWdu5vXTpQz3/HoBU22n4BCrmOV4vUZU82ZRHWK7Oq1Jh
	5gPuciVf0Qu75+JWTd5EM4ev11bA6IaGeClKNKrUH8SPnPX8PhuLRv9hsR/gxan3
	jD40rDQqZ1AbXfZjsNybOoUws5PwYVcZonOkmZk4hAC/e0RdzpoMNgpaBKJhKUtF
	xKBShdaM+c1APP6YoXlmm79YR75zShcZHw8yRBtixt80qqzT0XX8A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dx7aep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:41:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PAQGrw009616;
	Tue, 25 Aug 2026 10:41:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw3uhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:41:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAf6j247120842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:41:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B24D20043;
	Tue, 25 Aug 2026 10:41:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AD7620040;
	Tue, 25 Aug 2026 10:40:57 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.103])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:40:57 +0000 (GMT)
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
Subject: [PATCH v11 10/12] virt/steal_governor: Add control knobs for handling steal values
Date: Tue, 25 Aug 2026 16:08:53 +0530
Message-ID: <20260825103855.721013-11-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX631Pp3szzZcd
 h0qEoVBYwj3LVYew+yeYrDtaxdcOpPaaSvYibHCHYU2KKSDzXCNVXelQAwcR6AyS2XiD0jcAHMJ
 mUF1ws2XvH2eiz1CUe0aaZW0nwkMrUg=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8d7147 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=XC_GqrfF-lTPz34eE_0A:9
X-Proofpoint-ORIG-GUID: ji1YcgYUIhtntHhy1V64SJTHn-tW0ji7
X-Proofpoint-GUID: IQaOsq3wr4zoB7vJoGytVHpasZ47nb06
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4OSBTYWx0ZWRfX19qu84Y012aR
 Q1JgjsClvbdSas1TfUAWtBY8FIQujuLUG1smmnb/h4muL+wq32DmCaURNoY5B9SSbkGXqZE/mY0
 6sJbEap6xkz1IFshQN+bsOwgfCgVRXWKX/G/8Wkg6b+XOVfd+bhv59hPuA+MbODHt74fVS7fgAh
 DDGH9SCe+b9yWc0WwiR9dK8dp5mY0x88SJr4fjznqNEdKikk3aHnDfgXgVpso9DhkDNTLxa3Boz
 W6+Wi6aet4vMPI4A0xwlk7wge+2RTfSKbvUHkA9BcN3jBzk7DLg+YCgIDDHWABNSgeoDvlE3gtN
 Za5FoO8nhGZiA/zPY4jE2he1taPZTT+1gdBxRmFb3BBbHtjHZ/fiwcyL9pAeug17gPOS44eBWmf
 2dfXwk2VgTlwXgww/1jFeg4CRSpHKc08jEcQ5LGwEz/i6BTkMmSA1wgjhcLplz5+frlZEA21+my
 9cp8nn//ienXMnqunew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250089

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
2.47.3

