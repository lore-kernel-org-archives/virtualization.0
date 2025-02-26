Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1025E448
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605941; cv=none; b=oae94VvbOJ0cbYFYsyo3hY0ynEoo4KG33fTk5a4gdglY8inrqCYPDSgdivYId8ZBOyOytf9CgUuHxYMRauo4X/o+JnyUTu1BVYhT9w+TtzEwtTV+/R5dgSf9SqugzXWD1qwH5UiGwAEvtqdcZb8CNwqtbgHwBXHYqkY9UcTlACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605941; c=relaxed/simple;
	bh=QrmEP8tN0yyZl54302laf2o0i1y0v20R661+ErCqyqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enrfeA8Ifvr7e8WkyWyD6v4xf6nBRSF5p+mJRHg6it3gx7k/y3ini8bPudaFbPRbbz396Rb4GMaFXLr9HyCdwdmP4LJyF1ecUQiL+OyviHzliXUaN2YW24vJOn7j6WrVZ6JiOLrfr/4Sn/V9KroNaBZp05suT++QpoFKOEuGl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EhJ+rQ5g; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EhJ+rQ5g"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QKcdj4011306
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 13:38:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=6QWMRWFJaMkolJ4N5fn/a7XdpweKZa/QIaMY7SwUwCE=; b=EhJ+rQ5gnA22
	LPjCW3FVCVOMYRKkT8w6EINOcbZO2B++l2lp1qwEq18MH8Dbp0mNAASd790R/86m
	5+BDX8Wu4McTHfEwdGQWTOssNXUmeIY5SnWPYUBjsQrb8U7MhrMr11R7zp17HVe+
	ViGB+0HL1JA1rYNpZGTI+lW4T6FR7zzUuqUWGPguNxCnZMC71CAaRUdBldwKacJm
	c9JxXoHIY1WOfXcUMetvPH+ACcCodqvTiLzV9L1oOL6n44jAFMEyXxsqv8DIp7TJ
	5nqChHZmU/bt7e/OjCRx8q6VsOZ5Q3ZtbSv5jGGZI7+Dd1xnCVJTjEP2x3wLZ8RA
	lh7k6PZGKA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45257gu747-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 13:38:58 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 21:38:48 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 32A80187DD500; Wed, 26 Feb 2025 13:38:45 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <pbonzini@redhat.com>, <seanjc@google.com>, <kvm@vger.kernel.org>
CC: <x86@kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/2] vhost: return task creation error instead of NULL
Date: Wed, 26 Feb 2025 13:38:43 -0800
Message-ID: <20250226213844.3826821-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226213844.3826821-1-kbusch@meta.com>
References: <20250226213844.3826821-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _6fAGQORR7DwmzUIS5q32RB5kLszRtlZ
X-Proofpoint-ORIG-GUID: _6fAGQORR7DwmzUIS5q32RB5kLszRtlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01

From: Keith Busch <kbusch@kernel.org>

Lets callers distinguish why the vhost task creation failed. No one
currently cares why it failed, so no runtime change from this patch, but
that will not be the case for long.

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

