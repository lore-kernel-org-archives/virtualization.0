Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A005DC433ED
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 17:23:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4636145E
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 17:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4636145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 25A0240604;
	Fri, 14 May 2021 17:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rlvzNS_7dpFq; Fri, 14 May 2021 17:23:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C238740610;
	Fri, 14 May 2021 17:23:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5F3C000D;
	Fri, 14 May 2021 17:23:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 621FDC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 17:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E28282DFC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 17:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwamFlxrWURB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 17:23:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADB90845BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621012995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/osWbHv9H+D8jMkXYe0YG4c0I4+JjXX9FiaLxBUqIoc=;
 b=d2dx2X4wQSbZIwPtQEIlXMX9cMPdjcbfe6pykJ19NlRvKxFSXMRJNGDpiYhBwFucsLVCAG
 fhOxCBPES+IA50e/cgQX4OZRLR+J9YUsFYTYAyJ2BRRrLo8ewci3/7B7fprHUXVmeqn3nq
 Nwu1ADwwa59+TFP2oMmFWFXWCfB+WFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-RRS-fpidOpKW1sq9Y9-_rQ-1; Fri, 14 May 2021 13:23:14 -0400
X-MC-Unique: RRS-fpidOpKW1sq9Y9-_rQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D2E3107ACCA;
 Fri, 14 May 2021 17:23:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 367F519D9B;
 Fri, 14 May 2021 17:23:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] fs/proc/kcore: drop KCORE_REMAP and KCORE_OTHER
Date: Fri, 14 May 2021 19:22:42 +0200
Message-Id: <20210514172247.176750-2-david@redhat.com>
In-Reply-To: <20210514172247.176750-1-david@redhat.com>
References: <20210514172247.176750-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Aili Yao <yaoaili@kingsoft.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Wei Liu <wei.liu@kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Steven Price <steven.price@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jiri Bohac <jbohac@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>,
 Oscar Salvador <osalvador@suse.de>, Mike Rapoport <rppt@linux.ibm.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>,
 Mike Rapoport <rppt@kernel.org>, Mike Kravetz <mike.kravetz@oracle.com>
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

Commit db779ef67ffe ("proc/kcore: Remove unused kclist_add_remap()")
removed the last user of KCORE_REMAP.

Commit 595dd46ebfc1 ("vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when
dumping vsyscall user page") removed the last user of KCORE_OTHER.

Let's drop both types. While at it, also drop vaddr in "struct
kcore_list", used by KCORE_REMAP only.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c       | 7 ++-----
 include/linux/kcore.h | 3 ---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 4d2e64e9016c..09f77d3c6e15 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -380,11 +380,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			phdr->p_type = PT_LOAD;
 			phdr->p_flags = PF_R | PF_W | PF_X;
 			phdr->p_offset = kc_vaddr_to_offset(m->addr) + data_offset;
-			if (m->type == KCORE_REMAP)
-				phdr->p_vaddr = (size_t)m->vaddr;
-			else
-				phdr->p_vaddr = (size_t)m->addr;
-			if (m->type == KCORE_RAM || m->type == KCORE_REMAP)
+			phdr->p_vaddr = (size_t)m->addr;
+			if (m->type == KCORE_RAM)
 				phdr->p_paddr = __pa(m->addr);
 			else if (m->type == KCORE_TEXT)
 				phdr->p_paddr = __pa_symbol(m->addr);
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index da676cdbd727..86c0f1d18998 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -11,14 +11,11 @@ enum kcore_type {
 	KCORE_RAM,
 	KCORE_VMEMMAP,
 	KCORE_USER,
-	KCORE_OTHER,
-	KCORE_REMAP,
 };
 
 struct kcore_list {
 	struct list_head list;
 	unsigned long addr;
-	unsigned long vaddr;
 	size_t size;
 	int type;
 };
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
