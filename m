Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA01C43461
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:26:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB23B61464
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB23B61464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 648DF6072F;
	Thu, 29 Apr 2021 12:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2jBnfZFOsAQF; Thu, 29 Apr 2021 12:26:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6BF36069F;
	Thu, 29 Apr 2021 12:26:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B63DAC000D;
	Thu, 29 Apr 2021 12:26:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54005C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41FD96072F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HtbZIy9R3oMy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:26:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73DDA6069F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619699199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OqK47sG85aZfcKTSSN25XorwOXhWot6GcaTYJAm0h7w=;
 b=BMUB1aYEJXWkmgtPRK/lvs/unrJ2bPdaBzYuCWVwX0d8MoyVX5/5pLvoRnA3PMdVvzXkRn
 G5UuDRcdd6AeCE6k+lhy5QdE7pmWi2p28wu0A+RWrGht8XGpxDFIBi2DsKg+03+O7RXLD2
 ol6HFHLNpKsGkeMAuLxDBNIjm4KlFXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-BOB6ZMW4OPaam5VXHtscdg-1; Thu, 29 Apr 2021 08:26:37 -0400
X-MC-Unique: BOB6ZMW4OPaam5VXHtscdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0763910054F6;
 Thu, 29 Apr 2021 12:26:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8A118796;
 Thu, 29 Apr 2021 12:26:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] mm: introduce page_offline_(begin|end|freeze|unfreeze)
 to synchronize setting PageOffline()
Date: Thu, 29 Apr 2021 14:25:17 +0200
Message-Id: <20210429122519.15183-6-david@redhat.com>
In-Reply-To: <20210429122519.15183-1-david@redhat.com>
References: <20210429122519.15183-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Aili Yao <yaoaili@kingsoft.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Wei Liu <wei.liu@kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Steven Price <steven.price@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jiri Bohac <jbohac@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>,
 Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

A driver might set a page logically offline -- PageOffline() -- and
turn the page inaccessible in the hypervisor; after that, access to page
content can be fatal. One example is virtio-mem; while unplugged memory
-- marked as PageOffline() can currently be read in the hypervisor, this
will no longer be the case in the future; for example, when having
a virtio-mem device backed by huge pages in the hypervisor.

Some special PFN walkers -- i.e., /proc/kcore -- read content of random
pages after checking PageOffline(); however, these PFN walkers can race
with drivers that set PageOffline().

Let's introduce page_offline_(begin|end|freeze|unfreeze) for
synchronizing.

page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
synchronize with such drivers, achieving that a page cannot be set
PageOffline() while frozen.

page_offline_begin()/page_offline_end() is used by drivers that care about
such races when setting a page PageOffline().

For simplicity, use a rwsem for now; neither drivers nor users are
performance sensitive.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h |  5 +++++
 mm/util.c                  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b8c56672a588..e3d00c72f459 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -767,6 +767,11 @@ PAGE_TYPE_OPS(Buddy, buddy)
  */
 PAGE_TYPE_OPS(Offline, offline)
 
+extern void page_offline_freeze(void);
+extern void page_offline_unfreeze(void);
+extern void page_offline_begin(void);
+extern void page_offline_end(void);
+
 /*
  * Marks pages in use as page tables.
  */
diff --git a/mm/util.c b/mm/util.c
index 54870226cea6..95395d4e4209 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1013,3 +1013,41 @@ void mem_dump_obj(void *object)
 	}
 	pr_cont(" non-slab/vmalloc memory.\n");
 }
+
+/*
+ * A driver might set a page logically offline -- PageOffline() -- and
+ * turn the page inaccessible in the hypervisor; after that, access to page
+ * content can be fatal.
+ *
+ * Some special PFN walkers -- i.e., /proc/kcore -- read content of random
+ * pages after checking PageOffline(); however, these PFN walkers can race
+ * with drivers that set PageOffline().
+ *
+ * page_offline_freeze()/page_offline_unfreeze() allows for a subsystem to
+ * synchronize with such drivers, achieving that a page cannot be set
+ * PageOffline() while frozen.
+ *
+ * page_offline_begin()/page_offline_end() is used by drivers that care about
+ * such races when setting a page PageOffline().
+ */
+static DECLARE_RWSEM(page_offline_rwsem);
+
+void page_offline_freeze(void)
+{
+	down_read(&page_offline_rwsem);
+}
+
+void page_offline_unfreeze(void)
+{
+	up_read(&page_offline_rwsem);
+}
+
+void page_offline_begin(void)
+{
+	down_write(&page_offline_rwsem);
+}
+
+void page_offline_end(void)
+{
+	up_write(&page_offline_rwsem);
+}
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
