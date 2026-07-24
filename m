Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C13126B0
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902221; cv=none; b=dGuaAujqYbPZtu/eM1CQ3zvfBaJ3goH06Uj8N+FQhDWI88Wjpgslh0QJRxnr/uOCrJe3kiBtCXo24y8i29+q9fCO0F9calW8zsBpaA6/qf/so2SrmU8s8/nXxrexvkopnaQXolAkrJbG0yx0oX0RDojKSL2U1mp1JMKPR/suoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902221; c=relaxed/simple;
	bh=Cc+Aot7/Ahkv+9OHqikjmzjHWJ1eBD2BrbyN6S2mhPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBJW6qHgicedjpibvx9kd215q4QlyEA3D2krsxR8Y6l/gy/c3NxlHOmax91VlZbvcraXBsk1zSKTahiOnEWzZ7p8uuj11Bfx85OoBA0BPOw3MxkAUqz2yStJbDmMB0goMDwdxcGVczErG7+urzv2l91UtdrR9gA7bHZXZgRLzfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jK+Vdqms; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jK+Vdqms"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfgOc1992919;
	Fri, 24 Jul 2026 14:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IAl3QgpjDXWIjAHYA
	TqpHr0xZQtj7C3ktRw0es8t1Eg=; b=jK+VdqmsO2FA8Ugz7M/pea6dvm5XthtBQ
	taA+0ClLJvU5y+1a34PircrIJl0jLS5kzlx63QNla8Oz29akgzXzHz0iWbx9F/T/
	/r/p8pmpS2NwfsN/Gpl/TzjQE4Hz8oigfR+hag+3owZt4m4vuCWfyoU4cxbOgWfC
	uOhrO3tkEwZg64g9fkBoBWTvfztisTs5Uwqg2XGRoc/hDM+vnjAgZQKQZtpNuGpk
	d42dReKrqRh9VDwVyXLsHzbOIe7a4fz1uFMKytjzdR0opp1KCGkyl15kabQ9aWbI
	2St8srCSXg112HPVUWdUJrQqrvkttVnrDy20Pa70DKimQ9EqgVJ4A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h00a00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:10:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OE4iG1009171;
	Fri, 24 Jul 2026 14:10:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyrxg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:10:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEA1QK40436110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:10:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384EA20176;
	Fri, 24 Jul 2026 14:10:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F8C20171;
	Fri, 24 Jul 2026 14:09:52 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.178])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:09:52 +0000 (GMT)
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
Subject: [PATCH v9 11/11] virt/steal_governor: Enable the driver
Date: Fri, 24 Jul 2026 19:37:32 +0530
Message-ID: <20260724140732.2683314-12-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724140732.2683314-1-sshegde@linux.ibm.com>
References: <20260724140732.2683314-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a63723e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jPZz8W9ceouySDeeKuAA:9
X-Proofpoint-ORIG-GUID: BmgeFVrMpawGRcWxjoGtjB9V0Ic9sk6s
X-Proofpoint-GUID: 69TnEnxxMThsTSv6Yf7-hh9qyn_XjPlI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX0znuyucgssZu
 9ugxENNEoK11xg6ADxH1MrefmOuRKcdFsuvMI6RD+6WH4fFsMj9TsJ7FhDUbCvQ12rvyB7+jVb/
 FCwLThiTOlU/nrBsUCXwGBUNI5wJF9fqqqAykc+zMvX6KWZikj+nxm6Ae029xuiWc2t7adjenp4
 ueNmu35DTpbpvteVCsgtItkC6li43gOUOjRiNKTSMFz12+6j8xqIBYulyeyGk9dpRxViqZUklh0
 3GWFyBz7jmeXFqx9Yyrt5xbjkNZdoEJUZHsnT+Gzhy2MExwf29V6q3o9FMkWN6vpTnJGL8Xl2sn
 jsTTPdBQOH9X3JtrsW6W6HQ4QlmeQ1rsaE9Ep5BccxnJhYHfi3H5kLFbknL4v3IyJ6OpM4KTNvB
 IwLh1TM2PIk7zHSfazp+/ysiCs7q2CmADLVPmWIaMQl8hJBtaUxOmP+yAFPQ3ltUfkEd25BvKGs
 fz7znngLfZ/iRpFidOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNCBTYWx0ZWRfX4M0iV8SPdjfu
 p9zlv8jHbuMHUkoyRoM+jbM6i0VoEuUTg7G/dixrGTqyZ9r10lJ5HIM52/t2ezQoT81iBE5bDzh
 UXHARjZ+OpwoCv9ez3SD8ZfqDm6M5Ds=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240124

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
 drivers/virt/Kconfig  | 18 ++++++++++++++++++
 drivers/virt/Makefile |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 52eb7e4ba71f..5c26a59792c9 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -41,6 +41,24 @@ config FSL_HV_MANAGER
           4) A kernel interface for receiving callbacks when a managed
 	     partition shuts down.
 
+config STEAL_GOVERNOR
+	tristate "Dynamic vCPU management based on steal time"
+	depends on PARAVIRT && SMP
+	select PREFERRED_CPU
+	default m
+	help
+	  This driver helps to reduce the steal time in paravirtualised
+	  environments, thereby reducing vCPU preemption. Reducing vCPU
+	  preemption provides improved lock holder preemption and reduces
+	  cost of vCPU preemption in the host.
+
+	  By default preferred CPUs will be same as active CPUs. Depending
+	  on the steal time when steal_governor driver is enabled,
+	  preferred CPUs could become subset of active CPUs.
+
+	  It is recommended to build it as module and load the module
+	  to enable it.
+
 source "drivers/virt/vboxguest/Kconfig"
 
 source "drivers/virt/nitro_enclaves/Kconfig"
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f29901bd7820..05fb075ef5b8 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
 obj-$(CONFIG_VMGENID)		+= vmgenid.o
+obj-$(CONFIG_STEAL_GOVERNOR)	+= steal_governor.o
 obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
-- 
2.47.3

