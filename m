Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA10C0015E
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 11:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65E50612DE;
	Tue, 27 Jun 2023 11:22:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65E50612DE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GiXBeepR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n5tZa2fikFl1; Tue, 27 Jun 2023 11:22:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA44A611DA;
	Tue, 27 Jun 2023 11:22:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA44A611DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C72E1C0037;
	Tue, 27 Jun 2023 11:22:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 982DDC0DD4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A9AC4175D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A9AC4175D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GiXBeepR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pfauMaDd_QWc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7793541955
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7793541955
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687864961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3lZgYf4GUx7yLsElB4csYTB1LQXvieCj0NGb4r43Kk=;
 b=GiXBeepRTYsfWFbuS5trU21wnCCJXsIQ9BnCXxzxYCNZ9tDJ+a+rA62gelwjD7l9qKC8hq
 ypmK6ZFU8LJho+9VJ/FS8B/7WdIqM29Gu3n8gfQdjVlgygW1TsYbeKuubOb6mdBf27JktH
 s8lJI9XWWi9YGN2c+OiW03+7npj7uwE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-SGCc500YMA6d6vSpb4530Q-1; Tue, 27 Jun 2023 07:22:36 -0400
X-MC-Unique: SGCc500YMA6d6vSpb4530Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4EBE1C07588;
 Tue, 27 Jun 2023 11:22:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5588200A3AD;
 Tue, 27 Jun 2023 11:22:33 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] virtio-mem: set the timeout for
 offline_and_remove_memory() to 10 seconds
Date: Tue, 27 Jun 2023 13:22:19 +0200
Message-Id: <20230627112220.229240-5-david@redhat.com>
In-Reply-To: <20230627112220.229240-1-david@redhat.com>
References: <20230627112220.229240-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>,
 John Hubbard <jhubbard@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
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

Currently we use the default (30 seconds), let's reduce it to 10
seconds. In BBM, we barely deal with blocks larger than 1/2 GiB, and
after 10 seconds it's most probably best to give up on that memory block
and try another one (or retry this one later).

In the common fake-offline case where we effectively fake-offline memory
using alloc_contig_range() first (SBM or BBM with bbm_safe_unplug=on),
we expect offline_and_remove_memory() to be blazingly fast and never take
anywhere close to 10seconds -- so this should only affect BBM with
bbm_safe_unplug=off.

While at it, update the parameter description and the relationship to
unmovable pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f8792223f1db..7468b4a907e3 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(bbm_block_size,
 static bool bbm_safe_unplug = true;
 module_param(bbm_safe_unplug, bool, 0444);
 MODULE_PARM_DESC(bbm_safe_unplug,
-	     "Use a safe unplug mechanism in BBM, avoiding long/endless loops");
+	     "Use a safe/fast unplug mechanism in BBM, failing faster on unmovable pages");
 
 /*
  * virtio-mem currently supports the following modes of operation:
@@ -738,7 +738,7 @@ static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
 		"offlining and removing memory: 0x%llx - 0x%llx\n", addr,
 		addr + size - 1);
 
-	rc = offline_and_remove_memory(addr, size, 0);
+	rc = offline_and_remove_memory(addr, size, 10 * MSEC_PER_SEC);
 	if (!rc) {
 		atomic64_sub(size, &vm->offline_size);
 		/*
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
