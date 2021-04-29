Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432E6C43460
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6098613F4
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6098613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7542040689;
	Thu, 29 Apr 2021 12:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKUpiuOmUP7B; Thu, 29 Apr 2021 12:25:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F4324014B;
	Thu, 29 Apr 2021 12:25:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE829C000D;
	Thu, 29 Apr 2021 12:25:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA9D3C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA5FF84D72
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kzf4KY0tCRan
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EDC784605
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619699144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlbUJqtDJSJXZ0talu2Z3XFcFBG+/7XBZRlbnxcqpi4=;
 b=fJHxKypIf4zRRDAzpFmq8iag4rrlofSafrHIPKb5O51p3rS3mBzKV6bWzsGO667Tt5bQAV
 mZNvCJPdGmYDaVdaRKT8EMauK7QiALw3T1+5vjbeURBi46BO6AFthwwXUCa7VsA6rGTgJx
 4Q8ynqcyP8VvdPKSaHsig/0paPuo0wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-McSW6JEJMfKG2TeFwvbHRQ-1; Thu, 29 Apr 2021 08:25:41 -0400
X-MC-Unique: McSW6JEJMfKG2TeFwvbHRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1D518049FF;
 Thu, 29 Apr 2021 12:25:37 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2ABF18796;
 Thu, 29 Apr 2021 12:25:32 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] fs/proc/kcore: pfn_is_ram check only applies to
 KCORE_RAM
Date: Thu, 29 Apr 2021 14:25:14 +0200
Message-Id: <20210429122519.15183-3-david@redhat.com>
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

Let's resturcture the code, using switch-case, and checking pfn_is_ram()
only when we are dealing with KCORE_RAM.

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
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
