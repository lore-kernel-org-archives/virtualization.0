Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1B375AC6
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513381; cv=none; b=hL0+acaVq/qysEJa8BTVZh/cWit4puyqWW5IU2c+9hotrRHaTBgvOMxpcZXFMRSItxPr2S2CTcGj7yK57x5EuuwiabgDylBebLHNoz+sCgzaNqkyBpgAWYTzFOXfNY04cizo/v2AA+GBdxW58ccWauXbd35Ifne0RQfKjZQH72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513381; c=relaxed/simple;
	bh=TBYD3Ma107LANX8ztUdMoJjdekI0UIGp8ILn0r3D3HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eyr/8/kKL6aRXa00oNJWq/bBgunusdbM+Y/DUm1dNPkeFrDDEyK1OOUOtULFP3KjHStCK05/FmXQ1baOqI6+dEXkq03Z3JSiDdIbc0eEycDweNX9PE+Z63In5YgAek8WKOX9O8VLIFv5AxqnBiDRf765+1ZIBu4YHICkC6xmcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CCpotSEr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CCpotSEr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31eZI416548;
	Wed, 12 Aug 2026 05:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BRkUi9dTiYNKZ4ssM
	Ju8kNyywnPRjg93Lb0gWTNKtqA=; b=CCpotSErOfINOci++OePtSZbPNQ/jR4zw
	FCyiOAUEAaWe93dwESxlEyscLrAgTtJTYYTRUXQDc1lGFe+zDiB6JHIKXeQyL3Ga
	W13LNJVGoOwzaxBBJbIdNrah7/hGwspK0oOFl0/Nu0Pe0tuClsKl4Pn9n1/3wira
	rzNIgsM3WRB2uYorH2ocMH9y7bO366tnsB6FN5aUK0eHgYkWK9vloSeiPXEkRv64
	U9VfgvJaKkHZgQmui3LUVe9CBOCpnoPntMksYwJpEtQd+ZyzlgXZ64+BJER6DHqF
	h29QsfpwxuAl2vh3yNaVZW7W7XIRjBw/vRa4ow0+SemWeYBt9oGdw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk00yns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:42:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5fHWb010376;
	Wed, 12 Aug 2026 05:42:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gcj4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:42:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5gdsp32375210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:42:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8CFC20040;
	Wed, 12 Aug 2026 05:42:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C6D20043;
	Wed, 12 Aug 2026 05:42:29 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:42:29 +0000 (GMT)
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
        virtualization@lists.linux.dev
Subject: [PATCH v10 12/12] virt/steal_governor: Enable the driver
Date: Wed, 12 Aug 2026 11:10:33 +0530
Message-ID: <20260812054033.95658-13-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812054033.95658-1-sshegde@linux.ibm.com>
References: <20260812054033.95658-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfXwvucWGPicbZY
 NnxZI+LgMgIIUt+BXkVV3Bn0bZFHVXGtj7hJcAvIgB5U+I27Y9puMHLn1vcaTqYoWAVRvej+NMi
 5X2fI36a295aKhKuFmj2R7XwYTMvBiLGTKB0KLWBZkPn4R5apyk9m87zLNs2FzWX1Yvl7xBSU6c
 +1sajpTcoStPcNg6/izONuxTj/ENHHosuJTHVHMAquZqbuQiM9dEEKZ+E8ItKxSTyDHPDhT/DhE
 m4DusMfQltl+2F5m/kkDnidniO7h6MjjTU58vhMlGvBeHyuhjltzFeASchF+AeBRxQWTgZAAA2y
 7OU2FpWHCpdz9rwoscvXZD9WOmwME2XnPHeJnCMJaOh80/0JkJKRdFKs2jf/ZDcM2Va8C9NHXZA
 X4jERgMgbU5rDLNI4suCTED7J9iM5fNai00gjRnDEoPnbPSWj9D95LYFi4tF/MYUhSpxxWBEvg6
 ajL3zWHZEulscAdoZ7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX/KM4XSZ583gb
 JC3PsJhGlkDg1ik9GwBtXJyYnzcwDAZsvJk+XnrJNHttX0y4cm4MxzcN8D3bmJCY+Kt48/rjR1W
 A0LuUHa34+DLAS5dnD5Qd/c0LHDl3dg=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c07d5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=jPZz8W9ceouySDeeKuAA:9
X-Proofpoint-GUID: 74O_N2J7JsooKqFnOfo9qDp-x3ty-TP3
X-Proofpoint-ORIG-GUID: FqpydhhX7-4ecHn6p9n_gVrC8mogoktv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120041

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
 drivers/virt/Kconfig  | 18 ++++++++++++++++++
 drivers/virt/Makefile |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 52eb7e4ba71f..6681d06363f9 100644
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
+	  This driver helps to reduce the steal time in paravirtualized
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

