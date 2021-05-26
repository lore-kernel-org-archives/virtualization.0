Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06329C2B9F7
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:31:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C13613D8
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 09:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C13613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77B9A4052B;
	Wed, 26 May 2021 09:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pkn1OBMCpt3Q; Wed, 26 May 2021 09:31:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 638524052D;
	Wed, 26 May 2021 09:31:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36985C000D;
	Wed, 26 May 2021 09:31:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 288F7C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C72F560638
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6OCUBx0EniuR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8CDA26060A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622021462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uXwHyc8YEWzgO7cvp9x09kOnIf54F6bkUKMKciKUfB0=;
 b=iejICi/pC2L27CKIZhMyMsMOTglMu40AU47j4/cPn9iHsIoYUeba5VmOCQUDo6+X+BbRcY
 kC4PxkzW/IrEO+5k/RZ78BNjftAMieQCaOJf0R+48KL0fW+dvMMc8hfehpQ2TxTPD3pD07
 pOdsJVD5Llb264x9rn3Ld86jF64pnRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-sT7g9JJoMvawfd5AZdW9aQ-1; Wed, 26 May 2021 05:30:58 -0400
X-MC-Unique: sT7g9JJoMvawfd5AZdW9aQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCD0D106BB2A;
 Wed, 26 May 2021 09:30:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-99.ams2.redhat.com [10.36.113.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 924105D9D3;
 Wed, 26 May 2021 09:30:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] fs/proc/kcore: don't read offline sections,
 logically offline pages and hwpoisoned pages
Date: Wed, 26 May 2021 11:30:35 +0200
Message-Id: <20210526093041.8800-1-david@redhat.com>
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

Looking for places where the kernel might unconditionally read
PageOffline() pages, I stumbled over /proc/kcore; turns out /proc/kcore
needs some more love to not touch some other pages we really don't want to
read -- i.e., hwpoisoned ones.

Examples for PageOffline() pages are pages inflated in a balloon,
memory unplugged via virtio-mem, and partially-present sections in
memory added by the Hyper-V balloon.

When reading pages inflated in a balloon, we essentially produce
unnecessary load in the hypervisor; holes in partially present sections in
case of Hyper-V are not accessible and already were a problem for
/proc/vmcore, fixed in makedumpfile by detecting PageOffline() pages. In
the future, virtio-mem might disallow reading unplugged memory -- marked
as PageOffline() -- in some environments, resulting in undefined behavior
when accessed; therefore, I'm trying to identify and rework all these
(corner) cases.

With this series, there is really only access via /dev/mem, /proc/vmcore
and kdb left after I ripped out /dev/kmem. kdb is an advanced corner-case
use case -- we won't care for now if someone explicitly tries to do nasty
things by reading from/writing to physical addresses we better not touch.
/dev/mem is a use case we won't support for virtio-mem, at least for now,
so we'll simply disallow mapping any virtio-mem memory via /dev/mem next.
/proc/vmcore is really only a problem when dumping the old kernel via
something that's not makedumpfile (read: basically never), however, we'll
try sanitizing that as well in the second kernel in the future.

Tested via kcore_dump:
	https://github.com/schlafwandler/kcore_dump

v2 -> v3:
- "mm: introduce page_offline_(begin|end|freeze|thaw) to synchronize
   setting PageOffline()"
-- Rephrased a comment as suggested by Mike
- Collected acks and rbs

v1 -> v2:
- Dropped "mm: rename and move page_is_poisoned()"
- "fs/proc/kcore: don't read offline sections, logically offline pages ..."
-- Add is_page_hwpoison() in page-flags.h along with a comment
- "mm: introduce page_offline_(begin|end|freeze|thaw) to ..."
-- s/unfreeze/thaw/
-- Add a comment to PageOffline documentation in page-flags.h
- "virtio-mem: use page_offline_(start|end) when setting PageOffline()"
-- Extend patch description
- "fs/proc/kcore: use page_offline_(freeze|thaw)"
-- Simplify freeze/thaw logic
- Collected acks/rbs

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Aili Yao <yaoaili@kingsoft.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: linux-hyperv@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

David Hildenbrand (6):
  fs/proc/kcore: drop KCORE_REMAP and KCORE_OTHER
  fs/proc/kcore: pfn_is_ram check only applies to KCORE_RAM
  fs/proc/kcore: don't read offline sections, logically offline pages
    and hwpoisoned pages
  mm: introduce page_offline_(begin|end|freeze|thaw) to synchronize
    setting PageOffline()
  virtio-mem: use page_offline_(start|end) when setting PageOffline()
  fs/proc/kcore: use page_offline_(freeze|thaw)

 drivers/virtio/virtio_mem.c |  2 ++
 fs/proc/kcore.c             | 67 ++++++++++++++++++++++++++++++-------
 include/linux/kcore.h       |  3 --
 include/linux/page-flags.h  | 22 ++++++++++++
 mm/util.c                   | 40 ++++++++++++++++++++++
 5 files changed, 118 insertions(+), 16 deletions(-)


base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
