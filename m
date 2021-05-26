Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5B7C47088
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:31:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B06613E6
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B06613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E116C4056A;
	Wed, 26 May 2021 09:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q1Z0Pif8uMNI; Wed, 26 May 2021 09:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5928540540;
	Wed, 26 May 2021 09:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 301E4C000D;
	Wed, 26 May 2021 09:31:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9AF7C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9848683BF3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UQHgT09DaOcl
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED52E83BE3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622021515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwY8egmBhFN4ttOumbwiNB+K87+iDRAp24/+Sy47AVY=;
 b=bdWQTezUW7VSgqzB7Oqcjd4zxTtr7nsMgioeGGEXFwMqDNa4OqW071MiuM4Os/y90V3eiL
 5RRg+oncjrt1QcquZ+KMmy1BBI9mPMyItrpEpglRf7Gq6Y43g3ygLtrWW0ogRM5OWX7HVx
 1Zlq3PDFrC37RyBV9Q2pAt1GLoT7KyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-sylAfsenNgmVBsWBcSkMGg-1; Wed, 26 May 2021 05:31:51 -0400
X-MC-Unique: sylAfsenNgmVBsWBcSkMGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751F7107ACF6;
 Wed, 26 May 2021 09:31:49 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-99.ams2.redhat.com [10.36.113.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3CF25D9D3;
 Wed, 26 May 2021 09:31:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] fs/proc/kcore: use page_offline_(freeze|thaw)
Date: Wed, 26 May 2021 11:30:41 +0200
Message-Id: <20210526093041.8800-7-david@redhat.com>
In-Reply-To: <20210526093041.8800-1-david@redhat.com>
References: <20210526093041.8800-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Let's properly synchronize with drivers that set PageOffline().
Unfreeze/thaw every now and then, so drivers that want to set PageOffline()
can make progress.

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 92ff1e4436cb..982e694aae77 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -313,6 +313,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 {
 	char *buf = file->private_data;
 	size_t phdrs_offset, notes_offset, data_offset;
+	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
 	struct kcore_list *m;
 	size_t tsz;
@@ -322,6 +323,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	int ret = 0;
 
 	down_read(&kclist_lock);
+	/*
+	 * Don't race against drivers that set PageOffline() and expect no
+	 * further page access.
+	 */
+	page_offline_freeze();
 
 	get_kcore_size(&nphdr, &phdrs_len, &notes_len, &data_offset);
 	phdrs_offset = sizeof(struct elfhdr);
@@ -480,6 +486,12 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			}
 		}
 
+		if (page_offline_frozen++ % MAX_ORDER_NR_PAGES == 0) {
+			page_offline_thaw();
+			cond_resched();
+			page_offline_freeze();
+		}
+
 		if (&m->list == &kclist_head) {
 			if (clear_user(buffer, tsz)) {
 				ret = -EFAULT;
@@ -565,6 +577,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	}
 
 out:
+	page_offline_thaw();
 	up_read(&kclist_lock);
 	if (ret)
 		return ret;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
