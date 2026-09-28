Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D87395DBF
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574043; cv=none; b=D3IFFbH3woKamzYulEfPJaIPcqJc10rjuAEPeFVSaOh7o6HrNHUfywYCMhmc4p4+W8KMoKc4D4x1ifOSME+tXBlbrg+2ejclEeIbokh+IrotCXp3EYyGAV0GHTtZcGbqmeIiSpAZNzimVhrU0jlL4/QXmO1Aa7phfkc05TgfJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574043; c=relaxed/simple;
	bh=5cENXDoJGErmJsLQ6ZJsBujmig6bC7WS/6A9jKS95EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KApYj+trqm9Z1tks5jYyQtcErdTQZgDUVYNJUS/U5qUL4Waw5M7mOPdwunyhcqbe2dFPcXpIvfzFB6dz/J5Ujlcv2YzfjNI4TkH8Ubpl+GTdq7d0EYHG1uIRNR/Y/nhYwKAiGzaZtMAbPXUTZGSdU6Pr1co07CGSOZSetN9IjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eDfkswRH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eDfkswRH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68REpkCf2793177;
	Mon, 28 Sep 2026 05:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NoKs6PHgICOPvbPtx
	LXEGO2l3bWSaBBDHM91RDM0iP0=; b=eDfkswRHeRH9jtW2ns/6BJd+3G7k5J2Pa
	wmoCyygWSqm4SeFxpbPW6LByPRtgYr79w+tVCeXwvOymGe6GyEcuqX0rW1x7UYFz
	+PrsJkBjgyUUxE6Va3G6nZWJSU2aaLNSiefRgvp9L6ylRVyV2bzy/KKvyGPMnP9u
	SAobT+/efY++d9lPASlQ+prkZVF3j47AaXV3VwpV91bBU0UEyXrBC/Hne/uAUCKm
	P7zbQ/V5E+jVk0HnQ9nzgFjmVCQuQgQQW182Ar6UX1EIEon/lANnDvBjMah+jXWD
	0klEOK/FVMiFAu3h+qyfNJDufq5ejZZH6n0+ftSB3CnqHi2E1WvEQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5psy5xn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:40:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S40LVK879648;
	Mon, 28 Sep 2026 05:40:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxtkg3nkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:40:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5eG3l42336758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:40:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A7A2004E;
	Mon, 28 Sep 2026 05:40:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27B0F20043;
	Mon, 28 Sep 2026 05:40:06 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.213.68])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:40:05 +0000 (GMT)
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
Subject: [PATCH v14 13/13] virt/steal_governor: Enable the driver
Date: Mon, 28 Sep 2026 11:07:28 +0530
Message-ID: <20260928053728.797539-14-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QMHq_TlRisyR4k0zX9lbuwxViarNPZIO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfX/1sfDkYxdBUi
 mPuLpto047MAFNMOvO7xy6H+lbcQirfBs2pOrzRCklC4P7S8eRZ/nxcl8hf1DK2KRui9MId38Zg
 iMM0MQYMeSdhFOO7V1S1089C0IC0T1YsDHlZcGN6t+gyfKZDnwwwGUb6r4P+v0a1KuDPRZuqqh4
 YWwATVhuOLsplKEEaI4Ae7WPZvyXpBn1GWtI0SAVxULG32ltgp+KNuV2YK3KRQnl2/fKNTj5qLZ
 LSxLjALvjQhh762/JcTBS5HLv4VruW1ESDJx7RgTjj+jqroFk7csJ6FC7NMCeGc4e/hJBQqWjGj
 v7d601Jeq5QzvqiexjHAlFwQCiSwSDuQpufC+n60esnE8aFzYXL+WL9b+YjT9xWwHlSF46HPAM/
 HXhsAmuqfb3TMLcNmhh3X46f9N6kqCo9tfJBpr62QTrVgcTLGQDnJ5jc4UVMN+JucBvqBficrtI
 dFwYEi9UrVvkN8pY46Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMiBTYWx0ZWRfXwuRXXxQICQTF
 I15s9LP1KLciaVwVjmBXFcIQ828NjJ9ri3/gRZ+278sLvan05SmWPqlOylsYdcw/kC2ps14s59t
 G+43KMAiyypNKr4nVCokXu1k9qI/Xdw=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6ab9fdc5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=jPZz8W9ceouySDeeKuAA:9
X-Proofpoint-GUID: XvBfZy04nl--oNLV5fyCd0X2ks4ECtEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280022

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

