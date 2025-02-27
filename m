Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F423E356
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697611; cv=none; b=JgX3X9f5MoX1L2Bz/YWvT0ON/ixTBoXD+08TOdtbIPdi1WPyqiqNTzLKkgei/ph1VLz/+cCz1ko1MRyR/AG8xDo6quvA+U7EuqKviYTzEj1gnLfn+FRIDFUBl5YgrUE+JKxINNY15CQTgWt0ly7PML5It094DwvJT4BMOpRrixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697611; c=relaxed/simple;
	bh=n20JTjqARi3bIKMGVpnP5071GH6mRPRCGiKcCnHkOuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auPNdk6joBYe1jagbWkg0BtxCObPY4BkYnzlt26oFneU8+b3phqVGSHCv0xnXx20pn/iLM+SCZZvSRDgDJVOL5brAnJF9+0tZKxOFmo0jgGhrWEXwguVasTicya6th2iy0JBPnL453384MUYmURhcG6YH5YH6iO8SAxFVvk0WiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jGfJyFnA; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jGfJyFnA"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RMbm1f032471
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 15:06:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=vCIsZt403ulsh6i+1Y7fMucf02/XpxKVHcBj4IVeiiA=; b=jGfJyFnAQszI
	2ufui3RvKjM83ALgN63+lwWFbsbDB4L2MAQgcbedrS8irYOU9R6KNTZoAHosD9pj
	odb2mhidwdrdbHsMvoqSA4Ssw4597YjDBRGD0QdoFElP4ndpHVhGTHc+6gwTKew+
	FzvXUlbYbEK1B2MwWxbly1zZupamgNeQD9c5eA27ms2asLLXClVf+j/V3spHPMcG
	uxJH3fBpDOkAZASBzkKjYoB+mVefeYTOznEzDl2/T8atnNnkFu0qVQxYAhVFU/vO
	DP1T3BwBG8/k65iaKppmztGjEp0V0ZKE1yc+Cn0qw8pfEfRlU4xzAhzUD8xSBVGD
	zBXNJHaEYw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4530qwga3s-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 15:06:45 -0800 (PST)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 23:06:34 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 9A9C318885339; Thu, 27 Feb 2025 15:06:31 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>
CC: <leiyang@redhat.com>, <virtualization@lists.linux.dev>, <x86@kernel.org>,
        <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] vhost: return task creation error instead of NULL
Date: Thu, 27 Feb 2025 15:06:30 -0800
Message-ID: <20250227230631.303431-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250227230631.303431-1-kbusch@meta.com>
References: <20250227230631.303431-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lFqgCIYQaBgvaNDQH-Nlo6ITa_anfwnG
X-Proofpoint-GUID: lFqgCIYQaBgvaNDQH-Nlo6ITa_anfwnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Lets callers distinguish why the vhost task creation failed. No one
currently cares why it failed, so no real runtime change from this
patch, but that will not be the case for long.

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
index 9ac25d08f473e..63612faeab727 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -666,7 +666,7 @@ static struct vhost_worker *vhost_worker_create(struc=
t vhost_dev *dev)
=20
 	vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_killed,
 				 worker, name);
-	if (!vtsk)
+	if (IS_ERR(vtsk))
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

