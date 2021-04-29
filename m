Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E59C4360C
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009656147D
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009656147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EBF4418E1;
	Thu, 29 Apr 2021 12:25:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gT2aMcVmN8WC; Thu, 29 Apr 2021 12:25:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89BAC418E0;
	Thu, 29 Apr 2021 12:25:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C262C000D;
	Thu, 29 Apr 2021 12:25:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B45A8C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2711845F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gZL-sI0L1DBo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 784B5845F0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619699133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/OdSxwojrLS5sAnanUpiMcEtuJGNRcvvNrKB0SCQWUs=;
 b=iwxb3NKfe8Lr1aRg//NAO7r1N0CqDGyVjbIvQCGe0eBJYGxYZe6I6D2wBtuN9q4OS1n703
 OvNT89PNVqvMP+5Luj5q5A3amwpNv013b0ZdUVivCvETOltGLy4saRr7CdL7cITR+VNXCs
 HFX2QgXCICX+Y2oBhBnH61/b0XIKSzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-1idR3NXgNvivsbYndrR7Yg-1; Thu, 29 Apr 2021 08:25:29 -0400
X-MC-Unique: 1idR3NXgNvivsbYndrR7Yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75AD4107ACF3;
 Thu, 29 Apr 2021 12:25:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 330B45C1BB;
 Thu, 29 Apr 2021 12:25:20 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] fs/proc/kcore: don't read offline sections,
 logically offline pages and hwpoisoned pages
Date: Thu, 29 Apr 2021 14:25:12 +0200
Message-Id: <20210429122519.15183-1-david@redhat.com>
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

This is (obviously) for v5.13++; no need to rush with review, but I decided
to send it around right away.

Looking for places where the kernel might unconditionally read
PageOffline() pages, I stumbled over /proc/kcore; turns out /proc/kcore
needs some more love to not touch some other pages we really don't want to
read -- i.e., hwpoisoned.

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

David Hildenbrand (7):
  fs/proc/kcore: drop KCORE_REMAP and KCORE_OTHER
  fs/proc/kcore: pfn_is_ram check only applies to KCORE_RAM
  mm: rename and move page_is_poisoned()
  fs/proc/kcore: don't read offline sections, logically offline pages
    and hwpoisoned pages
  mm: introduce page_offline_(begin|end|freeze|unfreeze) to synchronize
    setting PageOffline()
  virtio-mem: use page_offline_(start|end) when setting PageOffline()
  fs/proc/kcore: use page_offline_(freeze|unfreeze)

 drivers/virtio/virtio_mem.c |  2 ++
 fs/proc/kcore.c             | 69 ++++++++++++++++++++++++++++++-------
 include/linux/kcore.h       |  3 --
 include/linux/page-flags.h  | 12 +++++++
 mm/gup.c                    |  6 +++-
 mm/internal.h               | 20 -----------
 mm/util.c                   | 40 +++++++++++++++++++++
 7 files changed, 115 insertions(+), 37 deletions(-)


base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
