Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1633DC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 15:20:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B192264F6C
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 15:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B192264F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 746CD84322;
	Thu,  4 Mar 2021 15:20:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UuENrbQu9L-b; Thu,  4 Mar 2021 15:20:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03BBE84031;
	Thu,  4 Mar 2021 15:20:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD131C000B;
	Thu,  4 Mar 2021 15:20:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84556C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:20:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6EEEE6F54F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:20:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="FSHWAHNs";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="BMC8gIgn"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TWroI7Nc9uGP
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:20:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCF976E750
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 15:20:12 +0000 (UTC)
Message-Id: <20210303132711.873509407@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1614870850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=u3h/+voGfuQZ8vvFWg0Eh8wQJhEpYLRgbzaO7lOW+aI=;
 b=FSHWAHNsmSIFfiruOKZ8wU93ak4ffq2CPua5ms62JfEDDwQwbdLKDz487hngpO+W3ALSJl
 gw0M1AXAD9z5g4KvDX/2e4Qdq9jnzWlwlj9X1vy1uJesdrTs1WwFS/vdH8H3v/3R0znXoM
 oq13YugQEN0jIJfBx9Sesx/SXVJDRRwQw6KW4bn7nVVyUWEBxGL+rT2SrPW8AdlGZ9jxwg
 /s5zvLwTTNrlyUi2y2imwKPsz2Ll2XZvsF3URJCgFogvFAyAW/QRjoNF0uJTwgkxZWoXV8
 rPY2lTzr1OpSqGg4wALRcll/sMqZHuaZf87+mMAhe14HCu1/zLU+C/hHOKAr0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1614870850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=u3h/+voGfuQZ8vvFWg0Eh8wQJhEpYLRgbzaO7lOW+aI=;
 b=BMC8gIgnDEiQOzywif6l/p5mkFIc5cDcrw9v673ZPmN4Z6uYF3ws0c2luovKIVfbNBBvbs
 HbJiCn5oFqa3koBA==
Date: Wed, 03 Mar 2021 14:20:28 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 5/7] drm/nouveau/device: Replace io_mapping_map_atomic_wc()
References: <20210303132023.077167457@linutronix.de>
MIME-Version: 1.0
Cc: Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Roland Scheidegger <sroland@vmware.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, spice-devel@lists.freedesktop.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Christian Koenig <christian.koenig@amd.com>, Zack Rusin <zackr@vmware.com>
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

Neither fbmem_peek() nor fbmem_poke() require to disable pagefaults and
preemption as a side effect of io_mapping_map_atomic_wc().

Use io_mapping_map_local_wc() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/fbmem.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/fbmem.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/fbmem.h
@@ -60,19 +60,19 @@ fbmem_fini(struct io_mapping *fb)
 static inline u32
 fbmem_peek(struct io_mapping *fb, u32 off)
 {
-	u8 __iomem *p = io_mapping_map_atomic_wc(fb, off & PAGE_MASK);
+	u8 __iomem *p = io_mapping_map_local_wc(fb, off & PAGE_MASK);
 	u32 val = ioread32(p + (off & ~PAGE_MASK));
-	io_mapping_unmap_atomic(p);
+	io_mapping_unmap_local(p);
 	return val;
 }
 
 static inline void
 fbmem_poke(struct io_mapping *fb, u32 off, u32 val)
 {
-	u8 __iomem *p = io_mapping_map_atomic_wc(fb, off & PAGE_MASK);
+	u8 __iomem *p = io_mapping_map_local_wc(fb, off & PAGE_MASK);
 	iowrite32(val, p + (off & ~PAGE_MASK));
 	wmb();
-	io_mapping_unmap_atomic(p);
+	io_mapping_unmap_local(p);
 }
 
 static inline bool


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
