Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA21C24DCF4
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338990; cv=none; b=gelcSoJdFnJVYNQoImxkFuNP2WtD4H+0G4+F21ea4LvRW2pSmw1x57dv7gUV5o0lIKIxwOtz+jxLaIiv5RAFgnQNLQRtW56tQc06sUll5E5LH2XJV5qgVDQ/x5x4YuVenCm4Prmne6EA0rm4VOym3JC6ib38YsqJKoNywJ2/mWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338990; c=relaxed/simple;
	bh=h7smYiUcX+tT7kLAc4b3pIX/1loHsFg1RnYO6HNTOnw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=K+6d532x8bRep+9rOV9vhLYPBtiwcHo26MgkoxCjlfMo3egbKRWzwRsHupgF4tkxSrbMBb0Y8XOnQpTW8yPkE1VVtJjteNwEJAQY52Tg64Dd/1VERQEAzeMn3J7h14xKxrQLC/jWJcCtbHw5BCfK0254Oy6DqaGTevbpafTQQIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FztWDh6x; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FztWDh6x"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F50260AD5
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.092
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ldqMfpmPbZR for <virtualization@lists.linux-foundation.org>;
 Tue, 27 May 2025 09:43:06 +0000 (UTC)
X-Greylist: delayed 509 seconds by postgrey-1.37 at util1.osuosl.org; Tue, 27 May 2025 09:43:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3835860ACE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3835860ACE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=FztWDh6x
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.254.224.33; helo=mailout3.samsung.com; envelope-from=hyunki00.koo@samsung.com; receiver=<UNKNOWN> 
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3835860ACE
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:43:02 +0000 (UTC)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250527094300epoutp03ed5510a4323b291a189bde79e69dfcde~DWQo5UzJN1624216242epoutp03d
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250527094300epoutp03ed5510a4323b291a189bde79e69dfcde~DWQo5UzJN1624216242epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748338980;
	bh=I54wYfntDzP8WlRHOCqcCZDGI9Uj3cp3k5bSZTUgPwE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=FztWDh6xB2UINXqBnt1Q1rlf0w90ubI0NEbx9aLde8w955yJap0DYKOt32P8v58u8
	 cP3d0Xt1+pfcoBMR8d8khs4oS2hXdLQae0NlOWlX57S5/ggeye7pkQ/oNE0v3Zo7XT
	 vBwLCWtGDyvqGauXxToEIP/oiSsRHeS9fkF7V8xw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20250527094300epcas2p3475f94590c9e9bd18e400e24f552ac13~DWQoUkJYl1636116361epcas2p3x;
	Tue, 27 May 2025 09:43:00 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.99]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b673R4J5dz2SSKX; Tue, 27 May
	2025 09:42:59 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250527094258epcas2p148075e4a9a1ca860feed842f9c7ce61e~DWQmUSixt0190001900epcas2p12;
	Tue, 27 May 2025 09:42:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250527094258epsmtrp13fb50c708fdaca25919466e759a41b82~DWQmTBmBq1471014710epsmtrp1i;
	Tue, 27 May 2025 09:42:58 +0000 (GMT)
X-AuditID: b6c32a52-40bff70000004c16-29-68358921a5c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.00.19478.12985386; Tue, 27 May 2025 18:42:57 +0900 (KST)
Received: from KORCO187997 (unknown [12.36.150.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527094257epsmtip2380c8854e3d5648a72e2f2aa3c1508d7~DWQmEWbBt2686026860epsmtip2T;
	Tue, 27 May 2025 09:42:57 +0000 (GMT)
From: <hyunki00.koo@samsung.com>
To: <john.garry@huawei.com>, <joro@8bytes.org>, <will@kernel.org>,
	<mst@redhat.com>, <jasowang@redhat.com>, <robin.murphy@arm.com>
Cc: <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
	<taeyang.choi@samsung.com>, <bumyong.lee@samsung.com>
In-Reply-To: 
Subject: Please backport 32e92d9f6f87
 ("iommu/iova: Separate out rcache init") to linux-5.15.y
Date: Tue, 27 May 2025 18:42:58 +0900
Message-ID: <000e01dbceeb$badbe050$3093a0f0$@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdvO6aZq9ptLQRizSkqjLQ4e8EdQ3wAAYPng
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCSvK5ip2mGwbS1ZhZ7T1tYLNhvbbHs
	0mcmi037m1gtOmdvYLe4vGsOm8XhjWeYLP7/esVqcfDDE1aLhfOMLJafncdm0XLH1IHH48nB
	eUwea+atYfRoOfKW1WPTqk42j8k3ljN6vN93lc2jb8sqRo/Pm+QCOKK4bFJSczLLUov07RK4
	Mq5cTC5YF1Wx/dsVxgbG3V5djJwcEgImEqsPzWXqYuTiEBLYzihx8tocVoiEjMSEF0uYIWxh
	ifstR1ghip4zSnxrm8rWxcjBwSagIHG3Ow2kRkSgh1Fi7s1okBpmgdOMElO+TANrFhLgkXi1
	YT8jSD2nAK/EhH/WIGFhgTiJg/NXs4KEWQRUJU78CAUJ8wpYSryZMIkVwhaUODnzCQtICbOA
	nkTbRkaQMLOAvMT2t3OgLlOQ+Pl0GdgUEQEjif2TlCBKRCRmd7YxT2AUnoVk0CyEQbOQDJqF
	pGMBI8sqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOAY1Arawbhs/V+9Q4xMHIyHGCU4mJVE
	eLdNMMkQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYJp2
	x6L9wrQ/zxPnXCzJnBQ1N+pYm0PpXA//fgXWx93CRxws1dlWKLnc8/ee9sxvilSDb2x57ieV
	jGfLGB/8ZHhw69NGt45FmsK9t86adbbMWekTV6geWbWGpe3T+zuue6Ys8n8lOz0kaS8je8fJ
	U4s2/Pq3/YxA17EFhiofr5w78YVxGpeI3e6C8HP1S7k6FLX/7Jh3d4tcUWPph+btW+aqNK8W
	kExt0Xb+bhLBP/frr49Gq1X41og6vzCJv86cGiYj0FCQdW7PXbUQw8M3lbNX5zLf6H4QzXi9
	bpZZZ1tQxs390WUPNuzvXSpgf2bLnWO9x+8p/Ba74CEicXjejC4rNvGn7/k4q/cxb7Kbb6nE
	UpyRaKjFXFScCAC5kiFMMAMAAA==
X-CMS-MailID: 20250527094258epcas2p148075e4a9a1ca860feed842f9c7ce61e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250527094258epcas2p148075e4a9a1ca860feed842f9c7ce61e
References: <CGME20250527094258epcas2p148075e4a9a1ca860feed842f9c7ce61e@epcas2p1.samsung.com>

Please backport 32e92d9f6f87 ("iommu/iova: Separate out rcache init") to
linux-5.15.y

Commit de53fd7aedb1 32e92d9f6f87 ("iommu/iova: Separate out rcache init")
fixes below issue.
This should be applied to all stable kernels that applied commit.

Issue
=====

As you metioned in commit message, fails in init_iova_rcaches() are not
handled safely, 
and a problem actually occurs.

By the context of the 2 lines below, 
callback of cpuhp may be called before the percpu variable is allocated .

cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
init_iova_rcaches(iovad);    

The problem occurred in the Linux kernel version 5.15.144, if
remove_cpu(cpu) is called between 2 line, 
The following is the panic log:
[    2.097125][    T1] Unable to handle kernel paging request at virtual
address ffffffcb74a6b004
...
[    2.097226][    T1] Call trace:
[    2.097323][    T1]  do_raw_spin_lock+0x1c/0x12c
[    2.098469][    T1]  _raw_spin_lock_irqsave+0x30/0x60
[    2.118152][    T1]  free_cpu_cached_iovas+0x50/0xb0
[    2.118307][    T1]  iova_cpuhp_dead+0x1c/0x30
[    2.119447][    T1]  cpuhp_invoke_callback+0x2d8/0x5b0
[    2.119608][    T1]  _cpu_down+0x17c/0x4a0
[    2.139216][    T1]  cpu_device_down+0x44/0x70
[    2.139353][    T1]  cpu_subsys_offline+0x10/0x20
[    2.140503][    T1]  device_offline+0xf4/0x130
[    2.140640][    T1]  remove_cpu+0x24/0x40
[    2.160305][    T1]  init_iova_domain+0xec/0x1f0

Here is my modification based on the top of the tree of linux-5.15.y

From 8fc78c5bc321b1183a1edb9331250799e897c911 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Thu, 3 Feb 2022 17:59:20 +0800
Subject: [PATCH] iommu/iova: Separate out rcache init

Currently the rcache structures are allocated for all IOVA domains, even if
they do not use "fast" alloc+free interface. This is wasteful of memory.

In addition, fails in init_iova_rcaches() are not handled safely, which is
less than ideal.

Make "fast" users call a separate rcache init explicitly, which includes
error checking.

Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link:
https://lore.kernel.org/r/1643882360-241739-1-git-send-email-john.garry@huaw
ei.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Change-Id: Ic2e71b82d66f94cd9a4661e593c03c851ef1b91f
---
 drivers/iommu/dma-iommu.c            |  4 ++
 drivers/iommu/iova.c                 | 73 ++++++++++++++++++++++------
 drivers/vdpa/vdpa_user/iova_domain.c | 11 +++++
 include/linux/iova.h                 | 15 ++----
 4 files changed, 76 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48c6f7ff4aef..f9f65ac9b3c0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -364,6 +364,7 @@ static int iommu_dma_init_domain(struct iommu_domain
*domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
+	int ret;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -398,6 +399,9 @@ static int iommu_dma_init_domain(struct iommu_domain
*domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
+	ret = iova_domain_init_rcaches(iovad);
+	if (ret)
+		return ret;
 
 	/* If the FQ fails we can simply fall back to strict mode */
 	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
iommu_dma_init_fq(domain))
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0835f32e040a..ce79c840b9ed 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -21,7 +21,6 @@ static bool iova_rcache_insert(struct iova_domain *iovad,
 static unsigned long iova_rcache_get(struct iova_domain *iovad,
 				     unsigned long size,
 				     unsigned long limit_pfn);
-static void init_iova_rcaches(struct iova_domain *iovad);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain
*iovad);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void fq_destroy_all_entries(struct iova_domain *iovad);
@@ -68,8 +67,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long
granule,
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
-	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
&iovad->cpuhp_dead);
-	init_iova_rcaches(iovad);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -539,6 +536,13 @@ free_iova_fast(struct iova_domain *iovad, unsigned long
pfn, unsigned long size)
 }
 EXPORT_SYMBOL_GPL(free_iova_fast);
 
+static void iova_domain_free_rcaches(struct iova_domain *iovad)
+{
+	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
+					    &iovad->cpuhp_dead);
+	free_iova_rcaches(iovad);
+}
+
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) %
IOVA_FQ_SIZE)
 
@@ -686,11 +690,11 @@ void put_iova_domain(struct iova_domain *iovad)
 {
 	struct iova *iova, *tmp;
 
-	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
-					    &iovad->cpuhp_dead);
-
 	free_iova_flush_queue(iovad);
-	free_iova_rcaches(iovad);
+
+	if (iovad->rcaches)
+		iova_domain_free_rcaches(iovad);
+
 	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot,
node)
 		free_iova_mem(iova);
 }
@@ -799,6 +803,7 @@ EXPORT_SYMBOL_GPL(reserve_iova);
  */
 
 #define IOVA_MAG_SIZE 128
+#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
 
 struct iova_magazine {
 	unsigned long size;
@@ -811,6 +816,13 @@ struct iova_cpu_rcache {
 	struct iova_magazine *prev;
 };
 
+struct iova_rcache {
+	spinlock_t lock;
+	unsigned long depot_size;
+	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
+	struct iova_cpu_rcache __percpu *cpu_rcaches;
+};
+
 static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
 {
 	return kzalloc(sizeof(struct iova_magazine), flags);
@@ -884,28 +896,54 @@ static void iova_magazine_push(struct iova_magazine
*mag, unsigned long pfn)
 	mag->pfns[mag->size++] = pfn;
 }
 
-static void init_iova_rcaches(struct iova_domain *iovad)
+int iova_domain_init_rcaches(struct iova_domain *iovad)
 {
-	struct iova_cpu_rcache *cpu_rcache;
-	struct iova_rcache *rcache;
 	unsigned int cpu;
-	int i;
+	int i, ret;
+
+	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
+				 sizeof(struct iova_rcache),
+				 GFP_KERNEL);
+	if (!iovad->rcaches)
+		return -ENOMEM;
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+		struct iova_cpu_rcache *cpu_rcache;
+		struct iova_rcache *rcache;
+
 		rcache = &iovad->rcaches[i];
 		spin_lock_init(&rcache->lock);
 		rcache->depot_size = 0;
-		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
cache_line_size());
-		if (WARN_ON(!rcache->cpu_rcaches))
-			continue;
+		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
+						     cache_line_size());
+		if (!rcache->cpu_rcaches) {
+			ret = -ENOMEM;
+			goto out_err;
+		}
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
+
 			spin_lock_init(&cpu_rcache->lock);
 			cpu_rcache->loaded =
iova_magazine_alloc(GFP_KERNEL);
 			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
+			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
+				ret = -ENOMEM;
+				goto out_err;
+			}
 		}
 	}
+
+	ret = cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
+					       &iovad->cpuhp_dead);
+	if (ret)
+		goto out_err;
+	return 0;
+
+out_err:
+	free_iova_rcaches(iovad);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
 
 /*
  * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
@@ -1022,7 +1060,7 @@ static unsigned long iova_rcache_get(struct
iova_domain *iovad,
 {
 	unsigned int log_size = order_base_2(size);
 
-	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
+	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
 		return 0;
 
 	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn -
size);
@@ -1040,6 +1078,8 @@ static void free_iova_rcaches(struct iova_domain
*iovad)
 
 	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
 		rcache = &iovad->rcaches[i];
+		if (!rcache->cpu_rcaches)
+			break;
 		for_each_possible_cpu(cpu) {
 			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
 			iova_magazine_free(cpu_rcache->loaded);
@@ -1049,6 +1089,9 @@ static void free_iova_rcaches(struct iova_domain
*iovad)
 		for (j = 0; j < rcache->depot_size; ++j)
 			iova_magazine_free(rcache->depot[j]);
 	}
+
+	kfree(iovad->rcaches);
+	iovad->rcaches = NULL;
 }
 
 /*
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
b/drivers/vdpa/vdpa_user/iova_domain.c
index 0678c2514197..42122d11cbf3 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -488,6 +488,7 @@ vduse_domain_create(unsigned long iova_limit, size_t
bounce_size)
 	struct file *file;
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
+	int ret;
 
 	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
 	if (iova_limit <= bounce_size)
@@ -521,10 +522,20 @@ vduse_domain_create(unsigned long iova_limit, size_t
bounce_size)
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
 			PAGE_SIZE, IOVA_START_PFN);
+	ret = iova_domain_init_rcaches(&domain->stream_iovad);
+	if (ret)
+		goto err_iovad_stream;
 	init_iova_domain(&domain->consistent_iovad,
 			PAGE_SIZE, bounce_pfns);
+	ret = iova_domain_init_rcaches(&domain->consistent_iovad);
+	if (ret)
+		goto err_iovad_consistent;
 
 	return domain;
+err_iovad_consistent:
+	put_iova_domain(&domain->stream_iovad);
+err_iovad_stream:
+	fput(file);
 err_file:
 	vfree(domain->bounce_maps);
 err_map:
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 6b6cc104e300..8616489b97c1 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -22,20 +22,10 @@ struct iova {
 	unsigned long	pfn_lo; /* Lowest allocated pfn */
 };
 
-struct iova_magazine;
-struct iova_cpu_rcache;
-
 #define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size
(in pages) */
-#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
-
-struct iova_rcache {
-	spinlock_t lock;
-	unsigned long depot_size;
-	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
-	struct iova_cpu_rcache __percpu *cpu_rcaches;
-};
 
 struct iova_domain;
+struct iova_rcache;
 
 /* Call-Back from IOVA code into IOMMU drivers */
 typedef void (* iova_flush_cb)(struct iova_domain *domain);
@@ -83,7 +73,7 @@ struct iova_domain {
 						   have been finished */
 
 	struct iova	anchor;		/* rbtree lookup anchor */
-	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA
range caches */
+	struct iova_rcache	*rcaches;
 
 	iova_flush_cb	flush_cb;	/* Call-Back function to flush IOMMU
 					   TLBs */
@@ -155,6 +145,7 @@ void init_iova_domain(struct iova_domain *iovad,
unsigned long granule,
 	unsigned long start_pfn);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor
entry_dtor);
+int iova_domain_init_rcaches(struct iova_domain *iovad);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
 void put_iova_domain(struct iova_domain *iovad);
 #else
-- 
2.25.1

