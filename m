Return-Path: <SRS0=D/KU=OT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A148C4332F
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 14:37:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF19661452
	for <virtualization@archiver.kernel.org>; Wed, 29 Sep 2021 14:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF19661452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFCB4421E1;
	Wed, 29 Sep 2021 14:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QDFk0WcPOw5B; Wed, 29 Sep 2021 14:37:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F0324218A;
	Wed, 29 Sep 2021 14:37:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BBECC000F;
	Wed, 29 Sep 2021 14:37:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B872BC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B4F5C421D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:37:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZduSORcAmhK9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:37:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E7224218A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632926240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hw0JON3PSPNzJHfAUlyfJy6KTExGOX1e2ePjdnrAKBE=;
 b=IH/8ML6nhlNIskKiDz4Frg131lLtX+EAxXueSkFhsQbafRR7dPbnHbhkJ0NdUnUTzdJFzf
 P9hF+DpX9MBLImx+dpOkuBtcerd1qp6JKqgL/9qIeg3A7yZLC/0SxNrKwaKN+SUucdVKjI
 624tunqB+oUBTcUvRJImVSd//CdTmVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-Xso30JzGNKapCJmAP5WIeA-1; Wed, 29 Sep 2021 10:37:18 -0400
X-MC-Unique: Xso30JzGNKapCJmAP5WIeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1D29802C94;
 Wed, 29 Sep 2021 14:37:14 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.135])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6CE510016F4;
 Wed, 29 Sep 2021 14:37:08 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/6] mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG to
 64 bit
Date: Wed, 29 Sep 2021 16:35:57 +0200
Message-Id: <20210929143600.49379-4-david@redhat.com>
In-Reply-To: <20210929143600.49379-1-david@redhat.com>
References: <20210929143600.49379-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
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

32 bit support is broken in various ways: for example, we can online
memory that should actually go to ZONE_HIGHMEM to ZONE_MOVABLE or in
some cases even to one of the other kernel zones.

We marked it BROKEN in commit b59d02ed0869 ("mm/memory_hotplug: disable the
functionality for 32b") almost one year ago. According to that commit
it might be broken at least since 2017. Further, there is hardly a sane use
case nowadays.

Let's just depend completely on 64bit, dropping the "BROKEN" dependency to
make clear that we are not going to support it again. Next, we'll remove
some HIGHMEM leftovers from memory hotplug code to clean up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index ea8762cd8e1e..88273dd5c6d6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -125,7 +125,7 @@ config MEMORY_HOTPLUG
 	select MEMORY_ISOLATION
 	depends on SPARSEMEM
 	depends on ARCH_ENABLE_MEMORY_HOTPLUG
-	depends on 64BIT || BROKEN
+	depends on 64BIT
 	select NUMA_KEEP_MEMINFO if NUMA
 
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
