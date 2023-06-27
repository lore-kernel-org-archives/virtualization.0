Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23980C001DB
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 11:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C628141714;
	Tue, 27 Jun 2023 11:22:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C628141714
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KKgYqPPT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RgvVICdLGPZD; Tue, 27 Jun 2023 11:22:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F0C0402E5;
	Tue, 27 Jun 2023 11:22:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F0C0402E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3685FC007C;
	Tue, 27 Jun 2023 11:22:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DADAC0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42CB741714
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42CB741714
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5sxQc6-oADc1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 99A2540B52
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99A2540B52
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 11:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687864955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tWgJbMty0vF+sRGgcNfqljzE54wPeczugMOQkaZlck=;
 b=KKgYqPPTmVA4gHipNXOy6A0FUY/TkqNtSwEvrzOdfCOzYPyWRvkSxWSFXqHzzeU2kt8yAB
 h9ZNY75m7MGwoH/Yu52PNJPawd/wNqUvlToFPLaCLhqSFqKHrOmPAm2QmMoo8x7BH2mQqz
 Gu8lsXy/SGZR0OTQ39c64vnzf7MsInA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-FJnFfwwzPY-Qr_PfD7F3LQ-1; Tue, 27 Jun 2023 07:22:30 -0400
X-MC-Unique: FJnFfwwzPY-Qr_PfD7F3LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C720F381494D;
 Tue, 27 Jun 2023 11:22:29 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1185200A3AD;
 Tue, 27 Jun 2023 11:22:27 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] mm/memory_hotplug: check for fatal signals only in
 offline_pages()
Date: Tue, 27 Jun 2023 13:22:16 +0200
Message-Id: <20230627112220.229240-2-david@redhat.com>
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

Let's check for fatal signals only. That looks cleaner and still keeps
the documented use case for manual user-space triggered memory offlining
working. From Documentation/admin-guide/mm/memory-hotplug.rst:

	% timeout $TIMEOUT offline_block | failure_handling

In fact, we even document there: "the offlining context can be terminated
by sending a fatal signal".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..0d2151df4ee1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1879,7 +1879,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	do {
 		pfn = start_pfn;
 		do {
-			if (signal_pending(current)) {
+			if (fatal_signal_pending(current)) {
 				ret = -EINTR;
 				reason = "signal backoff";
 				goto failed_removal_isolated;
-- 
2.40.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
