Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD50B3793B3
	for <virtualization@lists.linux.dev>; Wed, 12 Aug 2026 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513337; cv=none; b=JjD7TJeTpk887Tkn3I4BJph9+RkvC860i/285SQI/TgqFgtXnctLqxsOR/fauLJcOe4TglosXQdW/wK9jnTcfO6+weRqisICKUJOaAlFPiVVEsATua1QE0gTGFXs/WJledx5VPvG7sVUsyN/iv9A7tIcJ8w8LfF3y8EZMl88QoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513337; c=relaxed/simple;
	bh=dMC6uo8OqzZCfT6Bj3/B6PIQvNxpLMj3RhP420uPsCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSw50RqQKcAB5JHQ8qeghpUOeCrIRFI1+KlTQYzw722+cVz+TR7niLkabLiRJ0Q06Kp8LmF1vsUzYWB2ZOcrVEBwWDjdfq7bXPFRK6h7hNzjv7qp1IwyfAA9992kxa2hbcHt8d9J85kQCH8CK6aiZ/KyvK1rXbpSBwrwErcMaUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sW0AqnxG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sW0AqnxG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31n4E2313788;
	Wed, 12 Aug 2026 05:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UGCMfmVJfrHqaR3yv
	2LCyWHobLH2A6rmfzx3Hj7NYIM=; b=sW0AqnxGzoPAGmwzqOZf1nJdev2Dn5iN9
	bH3AaFwbweDljmARNP8H60TbxqupwFB31wLK2VRVJUPdVF/X/jmU7X2g0C76R+CZ
	0t8Cs8vD2K4WzVOT7BV9Nj698wnGJX0HlsQEuqh9nh5evZS9YxhhS51P6ebYCQPW
	96Rkq5X5AD5cxX6kaAR0SjGm7xmuvsG05SkXRgSy+ua7w+y7n9JveaDxlDx2Uu8S
	JceoqPdm3gxkF8cxaIwh0m+tLAMlDUXetf9gbAeftwCLtmKfJfYvWjnKdiUAyhw9
	fWfQnyvKSQ4+R9qdcBxyLvaDgNVWwCqFptIgebzIgc/q9kh1IQWpA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw87t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:42:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C5fHTN025138;
	Wed, 12 Aug 2026 05:42:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w4t3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:42:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C5fwlA51708160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 05:41:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBEB920043;
	Wed, 12 Aug 2026 05:41:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E77AD20040;
	Wed, 12 Aug 2026 05:41:47 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.151])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 05:41:47 +0000 (GMT)
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
Subject: [PATCH v10 08/12] sched/debug: Add migration stats due to non preferred CPUs
Date: Wed, 12 Aug 2026 11:10:29 +0530
Message-ID: <20260812054033.95658-9-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7c07ab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-i9lZGrASMRMKgkbeRgA:9
X-Proofpoint-GUID: QYQY4Mw9rCvdG_CaUW8tsMSpTsu7lHgD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX4+hPbOxv6Fge
 bXcejbUntNTatoAqmEha9NUpHbLiGC9vl5F0UnsypK+k80qSTuRhAFmh81KbeeCKeNoBpe25rfP
 AIals2s3ForyYMqqnNEmwLBe2uQ78XfhZZtJY1EhSTvhSIkStz5e0ejeZkApLUQDNsHxxxKKF4u
 OdPfNFfXT436V7ZwhJ4OA0jmHOB8r52MNDFXvhAAQBDf8rNwU0gPMgvsSr6L5N2JRiTsWshSrFn
 a4AYuEyocFSgEPufjzuF3m1Qube4Vv0fe5qHj/a1dze3wuCcxCFv3BOYalVgdhn0hObDujDEg3T
 ydhsjaEMAcRyz8EAXFzN50nGECavqvw3A2PPocH4tHe0nsPnL4R8Vtndb6Oqi1VocJKiwTVg3WI
 ixEXOLDQQp/kLsAeIX7glQPqCrmxUT/GLxryZYiyIQiaDWczST2f6aUkFVM/ykWVgsvbUOAf6Cg
 1Bkcf97Wb4J/L1zCw0w==
X-Proofpoint-ORIG-GUID: xLELYBjBkbAdnW1zg38ZuYJ6xunjnP8L
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MSBTYWx0ZWRfX8QmO+uIFsU2V
 LMw/RKbuAwT6K5wcE77RY6CGyGra+nyKBcZ1LxI0L+U+6yoYOqRa7GWqGOyC672veAimRafMIMO
 rYuRAZF1PjVbhKJBz4ksS/q0ENj6Sxo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120041

Add a new stat,
- nr_migrations_cpu_non_preferred: number of migrations happened since
  a CPU was marked as non preferred due to high steal time.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/core.c   | 9 +++++++--
 kernel/sched/debug.c  | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 968b18a7f470..37849d2f1dbd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -554,6 +554,7 @@ struct sched_statistics {
 	u64				nr_failed_migrations_running;
 	u64				nr_failed_migrations_hot;
 	u64				nr_forced_migrations;
+	u64				nr_migrations_cpu_non_preferred;
 
 	u64				nr_wakeups;
 	u64				nr_wakeups_sync;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c51ba2979496..5fda8234e843 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11336,8 +11336,13 @@ static int sched_non_preferred_cpu_push_stop(void *arg)
 	context_unsafe_alias(rq);
 
 	if (task_rq(p) == rq && task_on_rq_queued(p) &&
-	    !is_migration_disabled(p))
-		rq = __migrate_task(rq, &rf, p, cpu);
+	    !is_migration_disabled(p)) {
+		struct rq *dest_rq = __migrate_task(rq, &rf, p, cpu);
+
+		if (rq != dest_rq)
+			schedstat_inc(p->stats.nr_migrations_cpu_non_preferred);
+		rq = dest_rq;
+	}
 
 	rq_unlock(rq, &rf);
 	raw_spin_unlock_irq(&p->pi_lock);
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 72236db67983..5ebb2055e6d5 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1446,6 +1446,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_failed_migrations_running);
 		P_SCHEDSTAT(nr_failed_migrations_hot);
 		P_SCHEDSTAT(nr_forced_migrations);
+		P_SCHEDSTAT(nr_migrations_cpu_non_preferred);
 		P_SCHEDSTAT(nr_wakeups);
 		P_SCHEDSTAT(nr_wakeups_sync);
 		P_SCHEDSTAT(nr_wakeups_migrate);
-- 
2.47.3

