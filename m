Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D817DC43331
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 15:14:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C82E64F8F
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 15:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C82E64F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C53A14EBD8;
	Thu,  4 Mar 2021 15:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtTuJQmBHxGh; Thu,  4 Mar 2021 15:14:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48DE44EBE1;
	Thu,  4 Mar 2021 15:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F29F0C0011;
	Thu,  4 Mar 2021 15:14:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38097C000F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 256064EBD8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fRQIOB4M88O5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CBA81475AA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:14:10 +0000 (UTC)
Message-Id: <20210303132711.645314577@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1614870848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=P7h+Ao9vOsNudD955CeMK9tU9n4YH9q4LoCgy/oWh2E=;
 b=2uXV0ePRVVVN5aKy2Fo0e96bYkFzUnbSPbDA9mnjFGs+bbvURtfkKgZsQJOXfsFhfOqAx3
 OKSUQ7A2lNXYMCPR5mt7GR8WB0thYvCiB4N4KF25U224lG1bd10Wr84gbQIvOPtxPz3S61
 OTBC7TJIKKNT+7owvCTNX96McxO5XIkAJM607UjWjAXvuDuzKj/vkGN/mMIFPVgKtW7FiY
 sMDkWETXLSLQCzV0BfhUq6uLpZrsKcZbHLAlqzznBehEpom/zQ1YITugOutFHAyMs86+RS
 kQNSvVUTjxm2uWu56Y8iErhFOW+/7R5MUYLuWMVdNNi/wd0eYJsJQIPIhJonBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1614870848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=P7h+Ao9vOsNudD955CeMK9tU9n4YH9q4LoCgy/oWh2E=;
 b=yQ29yECbLb01f6/UnQLUET487mIC0cSmmm0evPuZXcme37cSI8DlyGVW46Rppt1VI46dBD
 FPkb1BDl/xOp+sAQ==
Date: Wed, 03 Mar 2021 14:20:26 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 3/7] highmem: Remove kmap_atomic_prot()
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Cc: Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Roland Scheidegger <sroland@vmware.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 spice-devel@lists.freedesktop.org, Andrew Morton <akpm@linux-foundation.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Christian Koenig <christian.koenig@amd.com>, Zack Rusin <zackr@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/highmem-internal.h |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -88,16 +88,11 @@ static inline void __kunmap_local(void *
 	kunmap_local_indexed(vaddr);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
+static inline void *kmap_atomic(struct page *page)
 {
 	preempt_disable();
 	pagefault_disable();
-	return __kmap_local_page_prot(page, prot);
-}
-
-static inline void *kmap_atomic(struct page *page)
-{
-	return kmap_atomic_prot(page, kmap_prot);
+	return __kmap_local_page_prot(page, kmap_prot);
 }
 
 static inline void *kmap_atomic_pfn(unsigned long pfn)
@@ -184,11 +179,6 @@ static inline void *kmap_atomic(struct p
 	return page_address(page);
 }
 
-static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
-{
-	return kmap_atomic(page);
-}
-
 static inline void *kmap_atomic_pfn(unsigned long pfn)
 {
 	return kmap_atomic(pfn_to_page(pfn));

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
