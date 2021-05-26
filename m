Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D0CC2B9F7
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:31:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A9A613D8
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A9A613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1506C40529;
	Wed, 26 May 2021 09:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vtt-SEalW5ko; Wed, 26 May 2021 09:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9640D4052D;
	Wed, 26 May 2021 09:31:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80A61C000D;
	Wed, 26 May 2021 09:31:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62D23C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 439E640533
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ne-F8fP2BY53
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 627C44052D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622021483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeyyYgXMaIv1KkLK2Mxpk2s8iuflkxKOKdYcMCECEco=;
 b=LaenYMzBz5H+4qqK8cZzZQE8rJWnVthzpQWRNhUadxI9NMk3Jd+DZuCnfk6mIP/18+oxmA
 SkOfYvGGmA2ZbZ8UTBp1VgpEvQhE1oFLeeR09tnsR8gFAaz0T1KamAx9FiW/6nrRDAhBwy
 QpkE0UdgZR/xdjNQtGSiFM8mYL0qSBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-KMaDda-lNSilAZz1rrmwcg-1; Wed, 26 May 2021 05:31:19 -0400
X-MC-Unique: KMaDda-lNSilAZz1rrmwcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 083AC180FD65;
 Wed, 26 May 2021 09:31:17 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-99.ams2.redhat.com [10.36.113.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CB925D9CC;
 Wed, 26 May 2021 09:31:01 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] fs/proc/kcore: pfn_is_ram check only applies to
 KCORE_RAM
Date: Wed, 26 May 2021 11:30:37 +0200
Message-Id: <20210526093041.8800-3-david@redhat.com>
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

Let's resturcture the code, using switch-case, and checking pfn_is_ram()
only when we are dealing with KCORE_RAM.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/proc/kcore.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 09f77d3c6e15..ed6fbb3bd50c 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -483,25 +483,36 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				goto out;
 			}
 			m = NULL;	/* skip the list anchor */
-		} else if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
-			if (clear_user(buffer, tsz)) {
-				ret = -EFAULT;
-				goto out;
-			}
-		} else if (m->type == KCORE_VMALLOC) {
+			goto skip;
+		}
+
+		switch (m->type) {
+		case KCORE_VMALLOC:
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
 			if (copy_to_user(buffer, buf, tsz)) {
 				ret = -EFAULT;
 				goto out;
 			}
-		} else if (m->type == KCORE_USER) {
+			break;
+		case KCORE_USER:
 			/* User page is handled prior to normal kernel page: */
 			if (copy_to_user(buffer, (char *)start, tsz)) {
 				ret = -EFAULT;
 				goto out;
 			}
-		} else {
+			break;
+		case KCORE_RAM:
+			if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
+				if (clear_user(buffer, tsz)) {
+					ret = -EFAULT;
+					goto out;
+				}
+				break;
+			}
+			fallthrough;
+		case KCORE_VMEMMAP:
+		case KCORE_TEXT:
 			if (kern_addr_valid(start)) {
 				/*
 				 * Using bounce buffer to bypass the
@@ -525,7 +536,15 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 					goto out;
 				}
 			}
+			break;
+		default:
+			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
+			if (clear_user(buffer, tsz)) {
+				ret = -EFAULT;
+				goto out;
+			}
 		}
+skip:
 		buflen -= tsz;
 		*fpos += tsz;
 		buffer += tsz;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
