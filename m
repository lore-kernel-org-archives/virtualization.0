Return-Path: <SRS0=0f46=CZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E7EC43461
	for <virtualization@archiver.kernel.org>; Wed, 16 Sep 2020 07:31:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34CD2076C
	for <virtualization@archiver.kernel.org>; Wed, 16 Sep 2020 07:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcGt8lwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34CD2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 50D6587370;
	Wed, 16 Sep 2020 07:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mBz0NBN7T2kn; Wed, 16 Sep 2020 07:30:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 605AB8723B;
	Wed, 16 Sep 2020 07:30:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45EE9C0859;
	Wed, 16 Sep 2020 07:30:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06C77C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 07:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E6608872BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 07:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9+KcLKHMKt6F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 07:30:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E00518723B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600241455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wF/hDQsxWFeJttqotpNYCePCKYRYUJaa1tQ1ZRR0EAY=;
 b=OcGt8lwcuPm9huSmn3o7TZH8l5FGWvD4OMAV3/zxWIhKCQIizQnEWuFXG+sgKjs479stwC
 7xJsyZPFAF68ZvFKfRZaQlq+SiSPqbySUk6SNWcVqyo0X6jADcq26k53BnbdX1JFml3lo5
 SPoulwUt1mGb6xJjuisa8hZ9ytqmMCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-8Xm80AAoPHqeed1mdsZ8Iw-1; Wed, 16 Sep 2020 03:30:51 -0400
X-MC-Unique: 8Xm80AAoPHqeed1mdsZ8Iw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 795B585C733;
 Wed, 16 Sep 2020 07:30:49 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-190.ams2.redhat.com [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D49751000239;
 Wed, 16 Sep 2020 07:30:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/resource: make iomem_resource implicit in
 release_mem_region_adjustable()
Date: Wed, 16 Sep 2020 09:30:41 +0200
Message-Id: <20200916073041.10355-1-david@redhat.com>
In-Reply-To: <20200911103459.10306-1-david@redhat.com>
References: <20200911103459.10306-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, linux-acpi@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, linux-nvdimm@lists.01.org,
 Jason Gunthorpe <jgg@ziepe.ca>, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Baoquan He <bhe@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

"mem" in the name already indicates the root, similar to
release_mem_region() and devm_request_mem_region(). Make it implicit.
The only single caller always passes iomem_resource, other parents are
not applicable.

Suggested-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Based on next-20200915. Follow up on
	"[PATCH v4 0/8] selective merging of system ram resources" [1]
That's in next-20200915. As noted during review of v2 by Wei [2].

[1] https://lkml.kernel.org/r/20200911103459.10306-1-david@redhat.com
[2] https://lkml.kernel.org/r/20200915021012.GC2007@L-31X9LVDL-1304.local

---
 include/linux/ioport.h | 3 +--
 kernel/resource.c      | 5 ++---
 mm/memory_hotplug.c    | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 7e61389dcb01..5135d4b86cd6 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -251,8 +251,7 @@ extern struct resource * __request_region(struct resource *,
 extern void __release_region(struct resource *, resource_size_t,
 				resource_size_t);
 #ifdef CONFIG_MEMORY_HOTREMOVE
-extern void release_mem_region_adjustable(struct resource *, resource_size_t,
-					  resource_size_t);
+extern void release_mem_region_adjustable(resource_size_t, resource_size_t);
 #endif
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern void merge_system_ram_resource(struct resource *res);
diff --git a/kernel/resource.c b/kernel/resource.c
index 7a91b935f4c2..ca2a666e4317 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1240,7 +1240,6 @@ EXPORT_SYMBOL(__release_region);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /**
  * release_mem_region_adjustable - release a previously reserved memory region
- * @parent: parent resource descriptor
  * @start: resource start address
  * @size: resource region size
  *
@@ -1258,9 +1257,9 @@ EXPORT_SYMBOL(__release_region);
  *   assumes that all children remain in the lower address entry for
  *   simplicity.  Enhance this logic when necessary.
  */
-void release_mem_region_adjustable(struct resource *parent,
-				   resource_size_t start, resource_size_t size)
+void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 {
+	struct resource *parent = &iomem_resource;
 	struct resource *new_res = NULL;
 	bool alloc_nofail = false;
 	struct resource **p;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 553c718226b3..7c5e4744ac51 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1764,7 +1764,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 		memblock_remove(start, size);
 	}
 
-	release_mem_region_adjustable(&iomem_resource, start, size);
+	release_mem_region_adjustable(start, size);
 
 	try_offline_node(nid);
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
