Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D9423A85
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962360; cv=none; b=EOzR439clufrs02TzhgHPBzMAXks51W9ltPNSTrZJ/5dfyldELbzpKfDGA4gNpEUe9SKLU8wydk0XA8v778ZMUcwrMsd+8mO600f1nuOsjiebRwHTe4+Lm+eD5LuQS9oZ/AtVP9Ow7IhusilmJ1ISC0I18SN/q8bOSYeFbdHT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962360; c=relaxed/simple;
	bh=5cENXDoJGErmJsLQ6ZJsBujmig6bC7WS/6A9jKS95EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf62+TSKZhc7As+zdJoF719Fea0MHlBqRoyUdaoISrCwg5EZL8midjbC4BKXO/VkxVNnNYGTT9lwYJQq4fXmQRw/mKcomkI5rTp5gJ27+5rAvFvDXjM5Bm6jnqiXPpXCRTM5QPxStdxRvHCyhGqzE2lUIv3yhd+bpkhIkJ7oqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hJhVOTLW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hJhVOTLW"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1p6K3817864;
	Wed, 9 Sep 2026 13:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NoKs6PHgICOPvbPtx
	LXEGO2l3bWSaBBDHM91RDM0iP0=; b=hJhVOTLWOTw6HtE7pTKvwXSGG76h4biCC
	HEj8aTBQ9PW9BOja6K8LlJlEBdapiUIaYMYxs1o5R/cy17gd4Y5dK2O1AcbGBBb7
	/ohQyp63OgOQJpmpus5hd+Fv01/vCi/YuKWjfoYt4xKGyCvRAb1lnLftDN9gP0og
	UNAzjjTC0aqNHzJhrrAGveDibfXztzXvqvmpgtqvTYn4Ai9UH4CHAz3CIKaWXjSV
	9Y+d8FVhRTmSqNbq6+96lJYH5cSjD2eDjns/MT6R5OL3uV63XDpzLS2qAFCU7QUv
	2lxhyc7zN+VUO+Js8NJjoYedrUnkh34FuyEec8H1B8gzab6VKTAQw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf468uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:59:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689DuJX2008404;
	Wed, 9 Sep 2026 13:59:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswaq2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 13:59:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Dwx8047120804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 13:58:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B2F82004B;
	Wed,  9 Sep 2026 13:58:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D42820043;
	Wed,  9 Sep 2026 13:58:48 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.210.73])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 13:58:48 +0000 (GMT)
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
Subject: [PATCH v13 13/13] virt/steal_governor: Enable the driver
Date: Wed,  9 Sep 2026 19:26:17 +0530
Message-ID: <20260909135617.871006-14-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hFWI9fRZh-ssm9dTZXi0i1uwhEkvRMfM
X-Proofpoint-GUID: hQDALk3DC2lVMUFDV6Yevqe-pMxEuIp_
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa16629 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=jPZz8W9ceouySDeeKuAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX7NNZIp1bXk96
 fYdvO6lV8/4OB4GdLj/84uS9o1dm3PXVbAbIOLFavBk5dDJK8lxAc+YWDGfMe17n+XMT23Y8nGb
 EJ0tCCk6cVMjtI3wEpP1cLOwvlD5tx65wKtEWLWRUb9vJQHMp8IMNwo16AJ5YKnMixeInCshY6p
 K76RTHzNY87ORVVbUM40rQHRxWVafxDP35yTSEl8qvwfXxqRBgdFdCeX4u2m+C1QJhwbP8DkVjo
 9mLf44Zb+F8TksN3+8d1rsQ0MlVPSCHgLEzMidx1X2dGikJR97ryAFFWJHF+g8DNUMIaK5mI2AL
 5YI0xEA4fudYfFv0gmh7Q4BRLQsS41cGzeTaejGy4jG/nDzk3qK9smTL7osdplV9bbuteIiGqkK
 I/+9xT3UALITWWBcmW5ll5vqqYsp3LxsiAx7u5/G62bmpZjWFIHtlFZesysC1+Uy1XrgSC4A7gF
 hX8d4ZnFBZ1zKBeawrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE1MSBTYWx0ZWRfX2F8JtQZv5v9g
 Y7uwTjio46acC2lpSRvhmTGUgCuOESIQyGY2C+KEgCcdmMEHYFVda8aN3MJajLVgIbZoOVM2z32
 vT3xo//4aw++VHx0cZbRQqGpxp4O8Wc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090151

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

