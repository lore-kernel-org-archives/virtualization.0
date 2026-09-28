Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5B37646A
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574022; cv=none; b=mHLYtSyVcf49g/mWkCeyoYpsfs3Jqp70+Ezr6vppDS6lkMRs9FwQGLyPWtaH1pUXocmuYKdX6EV8B3FevpUo+1U+ENhFHJs9Va765Wr09Cv7Huuw9U437TnBhVqoAPD2psr2c8M3BX+spLN08VpkXv7xRJRS8qMdkP3xu3Y5Ius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574022; c=relaxed/simple;
	bh=xWTA0IdYijO7IFASgKOZ0Vabj/amKI4jA7+ChmTjM4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+OqdS3j/y0XZBNJdqujWV6ZM0TiQVnS6yTR8el1+7rtcscj/RNQtHO+nshiJxSgaHJSnHWM3J+/2YBmVFp1Q32LwOejqfJnAPVuDeYnDV8bckcD8WUIAyNU9h5uGEvHI3A1nDGHfhRnx/otQ4XmGjPf0PLndEWShO8+NnBPp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NBYwVna3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NBYwVna3"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S3x3rY502601;
	Mon, 28 Sep 2026 05:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lkEEt+Avu0uDBakRz
	khxYQgptYGLHcGm9wFZS1Clsp8=; b=NBYwVna3AfQ3c6HFD7AjPoenDN76BxxHu
	ehIqBZZdM6CMZ0p6hRMminBCIjNW2c8ll7EED+dVVSfryd12ow6i6QCxXuU4w58m
	k/E167w2DzgYpkINYfso9hLHorGwovYE4xkDvKjpzK0Tal9Toy02Fmp2BgRYVgiO
	TtMCbhf/wdtJANvPgY/j2oCIFyS2KsYontUVI/Cm0IMizSJqp3h3XQOMOMO1zZ5a
	868PSjRafJQ+TG3xRbyIjUXFTMLB9iR+xvhAKSziqXfQW8w2j81QKxnPa2vjNnN4
	iOfJiJ8ytFfm1X4q8p501WqzZoZIJ9Y4zssDUnbnoD1lzL3683r1A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fdya9a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2Of7I2055547;
	Mon, 28 Sep 2026 05:39:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpm05c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:39:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5dsM345941028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:39:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EA3920043;
	Mon, 28 Sep 2026 05:39:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFB9B20040;
	Mon, 28 Sep 2026 05:39:42 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:39:42 +0000 (GMT)
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
Subject: [PATCH v14 11/13] virt/steal_governor: Add control knobs for handling steal values
Date: Mon, 28 Sep 2026 11:07:26 +0530
Message-ID: <20260928053728.797539-12-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6ab9fdaf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=XC_GqrfF-lTPz34eE_0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX3HLfie5LgbR3
 3qVfXTWpGOrcGh/s3UqGFWU32uTYqcAN4y3q3IXJ84btEbWYmepDRfhVHrsZ+loVSZsnRpQrDUj
 PYTemDNRNzbnu8biPiPgo/t5HJRahck=
X-Proofpoint-ORIG-GUID: nCvxRwhvZIp7FbWWnAMzjaWKXSugzqJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfXxb4InGqA0ihV
 DdKrKCa4636A2PsUDx8eCHJBMPt6tfGXUJAyeCa31fjximM/rT4dw0aIdtt41A8k/U9cNiTo2k/
 DW0+Mch9eonQ7YFFW/tOHmbangddCTXiqEfR7MdK3cOANuK9PzDASfnCW/rUbGSNmii0w7QTmwI
 ZPoWpVHELNA2tyGYQwQlxvvunPuFer9EkAiBYNsVB6N3A5zxFfV/Xb2OCrBKVsZKhA9Lewp7iUB
 Sn027/9rEeAIY6GudjNYTOYupUANLgE/fC19PwPgnLD125RwuH9XDml1jGJZfRAUL6L+OB5QVoH
 Zg9jkDeGsSA3csIxp/+VTjUMGyTJzKPE3waQ5bcCB/Y73l3m/NKEWNhozhMQ89qmHVIJGxplpVB
 +fcC7eXwL2Rag21ejAp5j6ID/3jdBCxp8ecPTKg6UWdzeoxC99UMaBZTqrGFbIuaPuaJ7hGzJ03
 Z0ZbLKqoenhXYaAs2wQ==
X-Proofpoint-GUID: 8ARhwT5PT9SUc6S3296qQlcKrDnVscvL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280022

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

