Return-Path: <SRS0=9HDO=B2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249BAC433DF
	for <virtualization@archiver.kernel.org>; Sun, 16 Aug 2020 12:53:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8038207FF
	for <virtualization@archiver.kernel.org>; Sun, 16 Aug 2020 12:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvbRzc5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8038207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BFF9A8565B;
	Sun, 16 Aug 2020 12:53:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5eTIOCZa4Q8A; Sun, 16 Aug 2020 12:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD50385546;
	Sun, 16 Aug 2020 12:53:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A448C088B;
	Sun, 16 Aug 2020 12:53:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46DBEC0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 12:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3603F87DC5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 12:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xrNGxM-2yxs8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 12:53:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 87D5887E16
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Aug 2020 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597582427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XGLoJ7O+V6ZZmFm5YMkauKx8SWaJ05qtX0s9I5/GzsQ=;
 b=bvbRzc5alqvh5sFD0p4+8W789EycvNYX3Z650KgaSPsHqtuY9JUfN0Y4Q3Hb6GFhnkSYVF
 MuXaqBeOL4e8YD8oK8PtE1lGA57r8BzcOroHwfjHe5hwKSEVj/un2gSqPgqOVtO6XKs4TY
 1bDW38WT5EcgNM5pd+yxYQBMACdewhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-kB4Cn_1BNAaaJmFGj8OAbg-1; Sun, 16 Aug 2020 08:53:44 -0400
X-MC-Unique: kB4Cn_1BNAaaJmFGj8OAbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36802801A9D;
 Sun, 16 Aug 2020 12:53:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 108476E72F;
 Sun, 16 Aug 2020 12:53:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] mm / virtio-mem: support ZONE_MOVABLE
Date: Sun, 16 Aug 2020 14:53:27 +0200
Message-Id: <20200816125333.7434-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Baoquan He <bhe@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>,
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

For 5.10. Patch #1-#4,#6 have RBs or ACKs, patch #5 is virtio-mem stuff
maintained by me. This should go via the -mm tree.

---

When introducing virtio-mem, the semantics of ZONE_MOVABLE were rather
unclear, which is why we special-cased ZONE_MOVABLE such that partially
plugged blocks would never end up in ZONE_MOVABLE.

Now that the semantics are much clearer (and are documented in patch #6),
let's support partially plugged memory blocks in ZONE_MOVABLE, allowing
partially plugged memory blocks to be online to ZONE_MOVABLE and also
unplugging from such memory blocks. This avoids surprises when onlining
of memory blocks suddenly fails, just because they are not completely
populated by virtio-mem (yet).

This is especially helpful for testing, but also paves the way for
virtio-mem optimizations, allowing more memory to get reliably unplugged.

Cleanup has_unmovable_pages() and set_migratetype_isolate(), providing
better documentation of how ZONE_MOVABLE interacts with different kind of
unmovable pages (memory offlining vs. alloc_contig_range()).

v4 -> v5:
- Rename "mm/page_isolation: don't dump_page(NULL) in
  set_migratetype_isolate()" to "mm/page_isolation: exit early when
  pageblock is isolated in set_migratetype_isolate()" as I was messing
  up things while reshuffling patches (dump_page(NULL) could never happen,
  only the WARN_ON_ONCE())
-- Clarify in the description that this is currently a cleanup only
- "mm: document semantics of ZONE_MOVABLE"
-- Clarified in the memory hole case, that kernelcore/movablecore is
   required to create such rare special cases

v3 -> v4:
- "mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()"
-- Fix typo in description
- "virtio-mem: don't special-case ZONE_MOVABLE"
-- Add more details why we initialli special-cased ZONE_MOVABLE (via MST)
- "mm: document semantics of ZONE_MOVABLE"
-- Rephrase some parts of documentation (via Mike)

v2 -> v3:
- "mm: document semantics of ZONE_MOVABLE"
-- Fix a typo

v1 -> v2:
- "mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()"
-- Move to position 1, add Fixes: tag
-- Drop unused "out:" label
- "mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()"
-- Keep curly braces on "else" case
- Replace "[PATCH v1 5/6] mm/page_alloc: restrict ZONE_MOVABLE optimization
           in has_unmovable_pages() to memory offlining"
  by "mm: document semantics of ZONE_MOVABLE"
-- Brain dump of what I know about ZONE_MOVABLE

David Hildenbrand (6):
  mm/page_alloc: tweak comments in has_unmovable_pages()
  mm/page_isolation: exit early when pageblock is isolated in
    set_migratetype_isolate()
  mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
  mm/page_isolation: cleanup set_migratetype_isolate()
  virtio-mem: don't special-case ZONE_MOVABLE
  mm: document semantics of ZONE_MOVABLE

 drivers/virtio/virtio_mem.c | 47 +++++++------------------------------
 include/linux/mmzone.h      | 35 +++++++++++++++++++++++++++
 mm/page_alloc.c             | 22 +++++------------
 mm/page_isolation.c         | 39 ++++++++++++++----------------
 4 files changed, 66 insertions(+), 77 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
