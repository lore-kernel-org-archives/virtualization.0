Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F30445AF5
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568310; cv=none; b=KPZCIaZA+TFcroeqSvC8MK0CzaCWmOb+2fQc3wqtv0p5IMfBd2aDydSHxwoE71tw79uYm4AEc0AI7bti6+5E9zwLRO9M5GGWCCidK31cicbwZUTOg/q52VS8dXiT6xEw1i0oYgV9UH8s9uqsGbJhR0q1Aror6i+w+qV8R7bUMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568310; c=relaxed/simple;
	bh=iafCAOaP3qDmEL0lab8nmndNwkPiW5QlXAdGGkZoRqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xgh2ikeyazmu0lEW5yhkToqZd/pfA/G38bJNzScOtKRNxszNehFUkbzMGLnE4qR+SMp6ijQwuXcxOQA4K1UhKZeGPrvWXmLqkqPk9NJ2Voyuvp/5f2Qt9PNtD9TkdT29q+kEUJKG4902QOWSFoiKPscpzpQkUnrjdU1XwMiuB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lFK14ZP/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lFK14ZP/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBjfG2807807;
	Mon, 20 Jul 2026 17:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O/TMGpUmCSAvPYTnc
	V9etfBFBMEtb4gIkAdn6Y9c4W8=; b=lFK14ZP/Sy9WJFjAfhyfbCshUpvuQD3GY
	b5onCqxMS5l+/fdF+567QcrAyqNXTyIU/MFFBymaj58xT6LsRtgWwsnFbo1K8VAn
	OJ4ZwkO+va89CHwss4dwXJeaO3FTNX1S6iOsHHXAujsE2vIZD4Wl663Xoa9qKhkC
	AcMXRk136s0FpUgHItflFMigQ3HIZQyH98q1BrijrB61Sdz5h7Aw+5sWaTpCG9WV
	bBguNt7kp1PEiCKEriD1QkfMWnzh5p1e+lI2OZILE3hvp/kOkSp1DyNEqL8Ysorl
	Zvh4zE/ZAAmjTLpuzEDW58NwKWAFc5tbvTeRlO+b9w5ifTGcNboIA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab8qv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KHK2UG002609;
	Mon, 20 Jul 2026 17:24:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktpxskk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 17:24:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KHOhDF53215644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 17:24:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329132004B;
	Mon, 20 Jul 2026 17:24:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3515920040;
	Mon, 20 Jul 2026 17:24:35 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.17.130])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 17:24:34 +0000 (GMT)
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
Subject: [PATCH v8 11/11] virt/steal_governor: Enable the driver
Date: Mon, 20 Jul 2026 22:52:50 +0530
Message-ID: <20260720172250.2257582-12-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfXw22NCCToRlAI
 vIwx7W9I3Oit3fpgwI78GkoqFh6qREUgemblwtBAwNz2uwwCgFvDLAXfpiClseU1KUJBcl0bmdU
 CeS3hUGh1Zo/HgvdQoEUb7DYapZAVfUIo+PxkmZzB4NbyvfWgsJFGaR5Ch7rvgpptpZ7outN3UF
 JNLzaDV5MB8QICLyVKaHrUiGuKaYL+uVsxtSPoJ9yRD1k0q7hxPEYx+x4sGps8IhtOJ+Ovz4nRr
 ySd+9mZEwX44TeeVrrq/IflmPK7lA80G3XAhh/GZ+KiOHBZgGmDw/6Y7vSs3rI4xhDYkZAbcPNZ
 9u2YkM0HAGUEj31kuL5HHju6aAlGM+1ELstqUh4Cuy24bpmxMdiklyYhh0fsoAJgrLZZUc8mx2z
 SPjqZfzQFsuLdGYKsMILQk8Uw1EFYdH+CKoO2mNlRQiLynT0EYFtWDmujxbbNE+VjbLuFQyycNT
 rcI7FkwCzI6PONYVqIg==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5e59e0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Ch_RIXSWQKBjZD2gOggA:9
X-Proofpoint-ORIG-GUID: 24_NxIg5Gw9YIz8WIFEoGMdbCvlens1T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MSBTYWx0ZWRfX8xSKIDlpX5+g
 YdETS0mME3TCJcukWuUUlW1KHzCboepEVue6GlOlDiHWsgGPs+XA6dgi5Pa19mk3FrildTmy4/Y
 Z4MAfcKygbgPckRzUz/ZEB0r3XL2BTI=
X-Proofpoint-GUID: zGNLYPVMuMLHqYrgRnbKlYKuKzly0L2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200191

Provide a config option for users to enable the driver.
Since the feature works for paravirtualized case and make sense only
with SMP, enforce those dependencies. Driver is going to select
CONFIG_PREFERRED_CPU=y for scheduler mechanisms to work.

It is recommended to build the driver as module instead of yes
due to below reasons.
- Module parameters are read only after init. If one wants to change
  them having as module allows that.
- Driver can be disabled if it is built as module.
- If it is module, admin user has to enable it. Since this feature works
  best when all VMs work in co-operative manner, admin will likely
  enable it in all VMs.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/virt/Kconfig                 |  2 ++
 drivers/virt/Makefile                |  1 +
 drivers/virt/steal_governor/Kconfig  | 18 ++++++++++++++++++
 drivers/virt/steal_governor/Makefile |  6 ++++++
 4 files changed, 27 insertions(+)
 create mode 100644 drivers/virt/steal_governor/Kconfig
 create mode 100644 drivers/virt/steal_governor/Makefile

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 52eb7e4ba71f..4fbc928022a4 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -47,6 +47,8 @@ source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
 
+source "drivers/virt/steal_governor/Kconfig"
+
 endif
 
 source "drivers/virt/coco/Kconfig"
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f29901bd7820..512dcfd6c73e 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -10,3 +10,4 @@ obj-y				+= vboxguest/
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-y				+= coco/
+obj-$(CONFIG_STEAL_GOVERNOR)	+= steal_governor/
diff --git a/drivers/virt/steal_governor/Kconfig b/drivers/virt/steal_governor/Kconfig
new file mode 100644
index 000000000000..926bb351db4f
--- /dev/null
+++ b/drivers/virt/steal_governor/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config STEAL_GOVERNOR
+	tristate "Dynamic vCPU management based on steal time"
+	depends on PARAVIRT && SMP
+	select PREFERRED_CPU
+	default m
+	help
+	  This driver helps to reduce the steal time in paravirtualised
+	  environment, thereby reducing vCPU preemption. Reducing vCPU
+	  preemption provides improved lock holder preemption and reduces
+	  cost of vCPU preemption in the host.
+
+	  By default preferred CPUs will be same as active CPUs. Depending
+	  on the steal time when steal_governor driver is enabled,
+	  preferred CPUs could become subset of active CPUs.
+
+	  It is recommended to build it as module and load the module
+	  to enable it.
diff --git a/drivers/virt/steal_governor/Makefile b/drivers/virt/steal_governor/Makefile
new file mode 100644
index 000000000000..eb90ed6b94d7
--- /dev/null
+++ b/drivers/virt/steal_governor/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Steal time governor to alter preferred CPU state.
+obj-$(CONFIG_STEAL_GOVERNOR) += steal_governor.o
+
+steal_governor-y := core.o
-- 
2.47.3

