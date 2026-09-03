Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E873F54D2
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417315; cv=none; b=Hw4HNw14Wn7G58Ku/f2h3SELCkF2U6lH56IXvk4Sb6v6RLDojv5TI/OVUlWYF4addpBYj9LJFUBaAGMWvxrKrZSWAxH3CPhuumynfmxBc9kH+UIxmIzLbEAqnMX5s12Qs9HlPs87g17JN/q6Iv7vekjxeidTqkLSZcjmqBU6Kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417315; c=relaxed/simple;
	bh=5cENXDoJGErmJsLQ6ZJsBujmig6bC7WS/6A9jKS95EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KV+6wazsnpx2UCuLpyLB6BCkz2qXPAw4GfhqroOJvxJhOqRLZ7QtzWpr2x9jGFsQAL47m4yTH+CCWroAw72vbAhUtqeSN0gx7jRNW6isl2ODbzXDHZ6CVGsL8DRDGzGcIXpzSl7+fR08dTmU8rf8j3TMiqoY2PH9g2ww7G/zmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BbCmSWMN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BbCmSWMN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68361eko2188170;
	Thu, 3 Sep 2026 06:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NoKs6PHgICOPvbPtx
	LXEGO2l3bWSaBBDHM91RDM0iP0=; b=BbCmSWMNA8a1nqrHaX1sS02b5jQSMSIUk
	zObJr6qCzNsXEhUkADk9+LbaaLgA3MK5EPBQZh69dRbTn1fl31M3R+zeKpsGFfLa
	CFPdBwj7neJbokbUZNYBMuTSXCa20IcHRNTcM1Uzqdgv7h8E6V1D2p6RvglDUUIG
	p2s5cYDExOW53/QFHY537gJ0nx+kBGQKsFRA3jmjTiKht0HRKPYk/v48I+0nVdQ7
	6xDRYI4fvU/Mdoa/rqigrFEKROye5ekhWKVzQZInELRkqHzjT2DPmjt0ZRRv6gy3
	bSaKX69HliB9Kr46h0y6tarUmCyOkMO1bhTVsQgo/yie/gIRV2dUA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5udfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:34:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6836QHT5006191;
	Thu, 3 Sep 2026 06:34:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hpa3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 06:34:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6836YnJ246924238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 06:34:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A59820043;
	Thu,  3 Sep 2026 06:34:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78EA720040;
	Thu,  3 Sep 2026 06:34:40 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.27.193])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 06:34:40 +0000 (GMT)
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
Subject: [PATCH v12 13/13] virt/steal_governor: Enable the driver
Date: Thu,  3 Sep 2026 12:02:40 +0530
Message-ID: <20260903063240.268775-14-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a99150f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=jPZz8W9ceouySDeeKuAA:9
X-Proofpoint-GUID: 8jmbw4Nw_27ku6VuTzGCQWkEy4_5J3-J
X-Proofpoint-ORIG-GUID: bFa-iy32QYLkbHUQxW9ewRqS5ISAQxaM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfX1Xt3wXeKIa7E
 SSGcDNnIMeseKPwrUFGe7Dwt9U0CCwBXyyK5EyUi80xvw2gLNzQpdwtoQg7/FBhu/q8hBfKZUCS
 WA+S1mruMLLdfkJwGsfDZvsVa4PEGfw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1NyBTYWx0ZWRfXyY6oQJi+BVM/
 Jifg2iCRzeZWCyuMcfUkUWdxNP9RAcJoVNEDQCbJL0KUCXHUVpQcvf1UqVYH/Iju+s8VUcw4AM6
 +zs2itv/owysnF0lrYycx62lR0h0A3/laKgA4ILcBVRx+IzFv7DLmLmpP9x+3dz3lxM90h1j9XH
 NqDef45LFBKBYShxhA9CGS4VvQ0mzfc2tIi4VwV7HaLHnZJI+v5JEgcLgt9WcAN92fqtvztLQgp
 BQRku1NXFEEPSAkE1/l/++6ufMAeElnbN0QGJ0jVP1kVV4wGhFj7x9kVaDWOcVm6MlRVZUh8jT5
 /T3EPMhHdalF7flC1SRqYm9/LACSd8kv9YcWCvmL3XM8AAqFhdVuBVRlpANAgaaoIpNn7aUDCVm
 qVPuje6xEmeQU22XuZ+2h7beOHi6m1vVdTQ/uaQqIMZwTcy0XcJMhbVX7WRuNjv02BYXcPpqGB6
 NXkilu0W8u7EeuZKRxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030057

Provide a config option to enable the steal_governor driver.
Since the feature targets paravirtualized environments and requires SMP,
enforce those dependencies. The driver selects CONFIG_PREFERRED_CPU
for the core scheduler mechanisms to work.

It is recommended to build the driver as a module (m) instead of
built-in (y) due to the following reasons:

- Module parameters are read-only after initialization. Building as a
  module allows updating these parameters by simply reloading the module.
  Default module parameters cannot work in all configurations.

- The driver can be completely disabled by unloading the module.

- This feature works best when all VMs operate in a cooperative manner.
  Requiring an explicit module load ensures intentional deployment
  across all VMs by the system administrator.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/virt/Kconfig  | 17 +++++++++++++++++
 drivers/virt/Makefile |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 52eb7e4ba71f..eeb84e578ddf 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -41,6 +41,23 @@ config FSL_HV_MANAGER
           4) A kernel interface for receiving callbacks when a managed
 	     partition shuts down.
 
+config STEAL_GOVERNOR
+	tristate "Dynamic vCPU management based on steal time"
+	depends on PARAVIRT && SMP
+	select PREFERRED_CPU
+	default m
+	help
+	  This driver helps to reduce the steal time in paravirtualized
+	  environments, thereby reducing vCPU preemption costs.
+
+	  By default preferred CPUs will be same as active CPUs. Depending
+	  on the steal time when steal_governor driver is enabled,
+	  preferred CPUs could become subset of active CPUs.
+	  More details are at: Documentation/driver-api/steal-governor.rst
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
2.52.0

