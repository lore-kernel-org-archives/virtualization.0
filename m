Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017A354AE7
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764870962; cv=none; b=QiW4Bj8btWIvZrGRylggWJKqOa+b5B5vKZD2o0lOf7E9taCOgCZOVFdG5AFoI0NAxJFsSllLuj/rSQfoNrc4v5bVuj76XQFIZKK4U3vkcxRATZRfadWJVkcxcudlFK3ylAXz4hg8onV0Z0Dg7wRd2UoyZtNUxgCy52VboBKuK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764870962; c=relaxed/simple;
	bh=1b1aJGj/nmcXXvsdCm04uLzpI2p/2ikLE/n2dRlWVUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF3sOw8q8gw4z0BYVmOymONXM28K0uLsr2NggdrYaqMgSoQrbe2b8qyhQ4fob6iDfRoajTHOomAI/SK62yixrXdHOmygg0fcOgh9tB8VInmE8wSyILiGeEbVhnm00KPWI0fCGtCw47KiUVcIXBCVzbu8IvfEU8YzYhdnCN8hD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QqbbTS/s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QqbbTS/s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4CcGUQ001693;
	Thu, 4 Dec 2025 17:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DEoPgJtZqvXLtS6bR
	UnlT+Janjhd3JxuIr6B9rUJSpc=; b=QqbbTS/sq1tv7wbvOASKZtnVgKiGeFwOx
	FjStQHT66SW21NztqXMnA4gJhiT6OydQCmapmkxzDWNg9N43kJv65rfLaQtU9xZT
	QWCv4RjCtvgsQa7zGe6sFyAZScktA1CFOwnmbYX0LuvPeaGCgCa+CcDaiFxUbWhL
	EcJIKrnT3jikaFbPO/Ucn3imAmyWoHHcrR/C9Hg9TpBo1I4TmIcb/hKruuIp6kUB
	cQdU6MhkzBT2WvjiZknMMGc/RqSgWd3zv7Ji3GqOVayhI+kHjUSru61iUv3/9Pmo
	oo8RT6xjhR6Ts0MdmiIP+aIs5m1tdaJ5uxTiLoJgAg3OVUocNjFWg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh79vss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 17:55:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B4HtXfI020542;
	Thu, 4 Dec 2025 17:55:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh79vsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 17:55:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4FtTO5003864;
	Thu, 4 Dec 2025 17:55:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardck0x44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 17:55:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B4HtSmE14745994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Dec 2025 17:55:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE99720040;
	Thu,  4 Dec 2025 17:55:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C7AA2004B;
	Thu,  4 Dec 2025 17:55:25 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.39.29.188])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Dec 2025 17:55:25 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ben Segall <bsegall@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Thomas Huth <thuth@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        virtualization@lists.linux.dev, Yicong Yang <yangyicong@hisilicon.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 04/17] powerpc/smp: Add num_available_cores callback for smp_ops
Date: Thu,  4 Dec 2025 23:23:52 +0530
Message-ID: <20251204175405.1511340-5-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251204175405.1511340-1-srikar@linux.ibm.com>
References: <20251204175405.1511340-1-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=6931cb16 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=-j1-LL9dA9zlJV2-Wa4A:9
X-Proofpoint-GUID: ojgn4LuqSgngAxu1HZ_rKX3FqYYqQAJa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfXyjv58sO0Jw50
 Yylpj/9qAtsnNPtcwqBsw2Td29tY5hl5v+0P3+Qf3QFcx4OdeziVgrzv9zT4vSAXlpd/Via+gZX
 w6yWIl3x/D5lZcsEUSMnYZKq/HoXIFit2Ll7YUWp4k+yDmDCgdKxwdR8Obm8F8QKWlhdk4e2VYm
 aXsFvKJe/DtZJ+w6X8pmuLNj0vwygDwE7K2Z2tiI0An72i97K3DgiJFuTHM8wcJ40UYRqwcH7wU
 agI7t0UIZYkKkye13OtMKV/y5Q9bQH2+LU3XlX2MrC5iUqNATzpQRJmJXsC8aFqu1/+jV3jQL8w
 77iZ2VEtT/BLqxWWywDHnbnZNrRYH1vur/4kD/KrsohtK45Mz/qa46vYoe08l73MSpWXHkuySVB
 krI4FCTcjF5rb3jgHzgJnDxpr8RJ1g==
X-Proofpoint-ORIG-GUID: kOhr0FG4DjqBkKm6VAcAFCCm3cib37NT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

num_available_cores callback will update the current number of available
cores. If num_available_cores() callback is not defined, then assume
all cores are available.

Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/include/asm/smp.h | 3 +++
 arch/powerpc/kernel/smp.c      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index e41b9ea42122..fe6315057474 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -60,6 +60,9 @@ struct smp_ops_t {
 #ifdef CONFIG_HOTPLUG_CPU
 	void  (*cpu_offline_self)(void);
 #endif
+#ifdef CONFIG_PPC_SPLPAR
+	unsigned int (*num_available_cores)(void);
+#endif
 };
 
 extern struct task_struct *secondary_current;
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 68edb66c2964..c33e9928a2b0 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1732,6 +1732,11 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 	dump_numa_cpu_topology();
 	build_sched_topology();
+
+#ifdef CONFIG_PPC_SPLPAR
+	if (smp_ops->num_available_cores)
+		smp_ops->num_available_cores();
+#endif
 }
 
 /*
-- 
2.43.7

