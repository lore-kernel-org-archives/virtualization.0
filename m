Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE6248F73
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339067; cv=none; b=nHHJxOuZZx20SA5/3xW5EyBs+gVQV0P/tbzIJgkqn6MrsBqU+3cPkOcipAhXm2xCUWWng2e9LfFkeLAyPP8rP/r21nYxGSLegz5H2+1gylFs14sbrB56TFLhbfleIL4Q4WWTQZlPzBWj8Gz1zV3suqw4HPWDQCo9hkxYGA8RXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339067; c=relaxed/simple;
	bh=POVU09RRorUzDphhZzX5iBIkP1p1HjruuE6wRTen/2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=KCBfM1SojgigaXyZYE48UMFglAF9SYHrf2xpCCMh4Uhi0a/T5bn02yFw2ArvbhqP/J2Vc6OhkLJ9SHVOoAx0GsUFs1i8reHgyF0pY64Qo6AP+j1AlbVr0eJQUHtZlOHkAYJUGkxKweh+e7QUHRb6/Il2v5883scv7EIuTYUG0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NyCOlfN3; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NyCOlfN3"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ABC780B68
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -8.095
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lMCuNI9Nv1n for <virtualization@lists.linux-foundation.org>;
 Tue, 27 May 2025 09:44:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=203.254.224.25; helo=mailout2.samsung.com; envelope-from=hyunki00.koo@samsung.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2E4D180AFC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E4D180AFC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=NyCOlfN3
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2E4D180AFC
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:44:23 +0000 (UTC)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250527093432epoutp0221eb7b281febadab690e0e2f32087f4d~DWJPKkikq1806318063epoutp024
	for <virtualization@lists.linux-foundation.org>; Tue, 27 May 2025 09:34:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250527093432epoutp0221eb7b281febadab690e0e2f32087f4d~DWJPKkikq1806318063epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748338472;
	bh=xYGelAVB0voM2HyQARDHZF9wpiRDObiAfkkhC+Tsj5U=;
	h=From:To:Cc:Subject:Date:References:From;
	b=NyCOlfN3MKEhZSIL8DE/HKkmY6O8FhN2kPXTWgDSwvJYmpH7Vre/Bnl1gd4jBed96
	 x9EetfFMRufsf6QpTNG/JzmF1nJirqUqquacuXs4NtH34dMB3Bib0PHNSAypAFRol6
	 Zg2iQr6MKIKOJqnsDRw4WBHS+eFLn3XpXc9+vijc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250527093431epcas2p13084371dc859a06ecebebcbc6c7be011~DWJOhfuH33037130371epcas2p1J;
	Tue, 27 May 2025 09:34:31 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.36.70]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b66sf5XCNz3hhTB; Tue, 27 May
	2025 09:34:30 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250527093429epcas2p1ae70ad7304305bf547ce34a70f9badc6~DWJNIHHF10452004520epcas2p1X;
	Tue, 27 May 2025 09:34:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250527093429epsmtrp10b4a4667deec0bfde670f082054e1392~DWJNHXDmR1031210312epsmtrp1y;
	Tue, 27 May 2025 09:34:29 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-5a-683587253150
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.AA.08766.52785386; Tue, 27 May 2025 18:34:29 +0900 (KST)
Received: from KORCO187997 (unknown [12.36.150.128]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527093429epsmtip229ed4625164472fc703cc7263b4c5a3f~DWJM52XKv2264022640epsmtip2S;
	Tue, 27 May 2025 09:34:29 +0000 (GMT)
From: <hyunki00.koo@samsung.com>
To: <john.garry@huawei.com>, <joro@8bytes.org>, <will@kernel.org>,
	<mst@redhat.com>, <jasowang@redhat.com>, <robin.murphy@arm.com>
Cc: <xieyongji@bytedance.com>, <iommu@lists.linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
	<linuxarm@huawei.com>, <taeyang.choi@samsung.com>, <bumyong.lee@samsung.com>
Subject: Please backport 32e92d9f6f87
 ("iommu/iova: Separate out rcache init") to linux-5.15.y
Date: Tue, 27 May 2025 18:34:30 +0900
Message-ID: <000d01dbceea$8bfec3c0$a3fc4b40$@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdvO6aZq9ptLQRizSkqjLQ4e8EdQ3w==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvK5qu2mGwZxOY4u9py0sFuy3tlh2
	6TOTxab9TawWnbM3sFtc3jWHzeLwxjNMFv9/vWK1OPjhCavFwnlGFsvPzmOzaLljajH5oIID
	r8eTg/OYPNbMW8Po8e/EGjaPliNvWT02repk85h8Yzmjx/t9V9k8+rasYvT4vEkugDOKyyYl
	NSezLLVI3y6BK2PPzAcsBXujKr48f83cwHjSq4uRk0NCwETi78TzLF2MXBxCArsZJb5/2s8G
	kZCRmPBiCTOELSxxv+UIK0TRc0aJP/sWAhVxcLAJKEjc7U4DqRER6GGUmHszGqSGWeAFo8Sc
	f7PAmoUF4iQOzl/NCmKzCKhKXF6xiBHE5hWwlNh8+iwbhC0ocXLmExaQmcwCehJtG8FKmAXk
	Jba/nQN1g4LEz6fLWCF26Umsav7KDlEjIjG7s415AqPgLCSTZiFMmoVk0iwkHQsYWVYxSqYW
	FOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHnZbmDsbtqz7oHWJk4mA8xCjBwawkwrttgkmG
	EG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqZou5D5G8Qj
	73a8Ctt1oeR2xEShiYc3fNgVoel10zUzd/HZPoW44JCgvPrZW7+uXK227oTHy08lzzhjTp2S
	Ov8mTbBU23fCb6uXGbtNJGq/+bwwdr8+UZXz13eBG6cKTA43vFyimNx2oUx630GWvcIejBX9
	imZ7Lk+4ci/q4W8Gi2MuS+f2LAnZ8a874Tbb3Wrbk/tvxXClW51IF9qs+1eNZS1nHn9+iRz3
	SYn/sRfnfmot5ZGI1zlZXdGiYhzdVFwqfbfumsvVe67Mh7vTWw4yb405dI/v7Z3V988WSn4p
	vGLqvcrwmJNZ7oeohG7N37fWzTl01Oix8cGIjRf288xceMeuUOJBxGW3uxuvhQkpsRRnJBpq
	MRcVJwIAUSdLxikDAAA=
X-CMS-MailID: 20250527093429epcas2p1ae70ad7304305bf547ce34a70f9badc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250527093429epcas2p1ae70ad7304305bf547ce34a70f9badc6
References: <CGME20250527093429epcas2p1ae70ad7304305bf547ce34a70f9badc6@epcas2p1.samsung.com>

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

By the context of the 2 lines below in linux-5.15.y, 
callback of cpuhp may be called before the percpu variable is allocated.

cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
init_iova_rcaches(iovad);    

The problem occurred in the Linux kernel version 5.15.144, if
remove_cpu(cpu) is called between 2 line. 
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

