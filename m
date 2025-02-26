Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEAD21C9EE
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537788; cv=none; b=eQB8ccu1QreepNiM19Ig4t7K0CPAYW11CgC9AS3zpUzjEL3ZxFZJ7khLu3OUoxcvmS7fDQJz6yvQSQzkVOsAfVi4DDO8wxTRy05FdPFIbhHQYZtABPPwUe9iwgHQdq25tMZwK4FNiik4jvfD0ftzP/mdCUR3GKeFx6qRpJrJHLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537788; c=relaxed/simple;
	bh=psA83hMta0EBtGrc11ASh+95tgy2BmlTdQ+tKcApzOc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntF4X/jvu3KMV/Z6IYek7BCfTQsLQocxWDnuGKB74sf5zCVL+1HsLq0lp/x8EZeNtEVAApHW8xgTfPFTMfGS/j5wkX9q/RvR3HL20WznSVVQEMTRTV4a0sK2jaN9IinY0fe4nQf9ok2N29KZg+tK7WnSdmbePg+D6R4jX5V4dVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=X86UoYCG; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="X86UoYCG"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q26F6q021657
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 18:43:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=Gy6jD5gFh1eD6RankQ
	/cTqdhovkATZtlGGgTCoTnsDA=; b=X86UoYCGd8dZO6pLtsCHvgM4LpQTuvcuft
	JqDJXFZevj1NY5joE/cHCmT+LWw/gY39mH1JRys9L2qUcGuDhlum4MlYEBTm2sqG
	c4r5nxDiFTDJSPiNZAiIV+UMLnmHTZ0K/hqSx4dSCCMgByllGNws0iMeT6BbcRfT
	WzDhkotFJNcoo/bXigyZ8PSaQL2UP2R1Z2PXViXfNRmgKKhiJ8/uLUtcVRfxEK3C
	UbS52sUBinlq7yQ8AekJpQuFl8B5K4CFvH8B7+ft6Eay4KKNaBtcL+W2eodpzl3v
	L5D+l8/q3/8jqmrOURWzkZY780O03YrL/MkD8F0mroFwd2gl19rA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 451ps39s5d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 18:43:04 -0800 (PST)
Received: from twshared55211.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 02:42:55 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 0FA891875B1E4; Tue, 25 Feb 2025 18:42:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>
CC: <x86@kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [RFC 1/2] vhost: return error instead of NULL on create
Date: Tue, 25 Feb 2025 18:42:57 -0800
Message-ID: <20250226024257.1807282-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7TRDatWPst3rr3G_AUdkSruDJ-_kJcXw
X-Proofpoint-ORIG-GUID: 7TRDatWPst3rr3G_AUdkSruDJ-_kJcXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Let callers distinguish why the vhost create failed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 drivers/vhost/vhost.c  | 2 +-
 kernel/vhost_task.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d4ac4a1f8b81b..18ca1ea6dc240 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7471,7 +7471,7 @@ static void kvm_mmu_start_lpage_recovery(struct onc=
e *once)
 				      kvm_nx_huge_page_recovery_worker_kill,
 				      kvm, "kvm-nx-lpage-recovery");
=20
-	if (!nx_thread)
+	if (IS_ERR(nx_thread))
 		return;
=20
 	vhost_task_start(nx_thread);
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473e..61dd19c7f99f1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -666,7 +666,7 @@ static struct vhost_worker *vhost_worker_create(struc=
t vhost_dev *dev)
=20
 	vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_killed,
 				 worker, name);
-	if (!vtsk)
+	if (!IS_ERR(vtsk))
 		goto free_worker;
=20
 	mutex_init(&worker->mutex);
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 8800f5acc0071..2ef2e1b800916 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -133,7 +133,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
=20
 	vtsk =3D kzalloc(sizeof(*vtsk), GFP_KERNEL);
 	if (!vtsk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	init_completion(&vtsk->exited);
 	mutex_init(&vtsk->exit_mutex);
 	vtsk->data =3D arg;
@@ -145,7 +145,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
 	tsk =3D copy_process(NULL, 0, NUMA_NO_NODE, &args);
 	if (IS_ERR(tsk)) {
 		kfree(vtsk);
-		return NULL;
+		return ERR_PTR(PTR_ERR(tsk));
 	}
=20
 	vtsk->task =3D tsk;
--=20
2.43.5

