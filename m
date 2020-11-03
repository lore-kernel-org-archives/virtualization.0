Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85879C55178
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:33:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1360A22404
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otNm1FLh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aDUoEgUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1360A22404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8997B873A3;
	Tue,  3 Nov 2020 10:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z5U6gCqVK8w1; Tue,  3 Nov 2020 10:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D449E873A0;
	Tue,  3 Nov 2020 10:33:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBA4EC1AD6;
	Tue,  3 Nov 2020 10:33:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3464AC0889
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2868D8612B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lM8ZOiLy-Ry2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 816F5860EF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:53 +0000 (UTC)
Message-Id: <20201103095858.734064977@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1604399629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=GQtIeN+bNrXtdDJbIY1/lT5u2Qlmlecyg45ylimAqeo=;
 b=otNm1FLhC7ruMh7oNXQtNETNU6+54RFk+t2LyeEF9d9+kDoZ9Kh8ZPgA+UB8A6JQ1ZXrGj
 0TPeQl8iy37SQzf3hhxJ0YH8tjvvuOPaAqFoJKHafSPmEiutw0Ud/5TB6XtJVn4M9v5QlN
 Kc0YPCEkVxgY8QSHdaCi6xZgLgOgc1LgMVaGrZjI4AUGq0ZlUKuDX4Xk4y+i0m9xE3dk86
 7GNBZMVBc/q+vRf7Zxdqgcl3bL7dPvuY81X2pyGhr1m48UNO2c+I7V2+wunozMP8FhvNCm
 gkFktETWxncmi0cgpUqLzaSL8knV0VimchG0Urhi5o5DvILy9hDHjs2CmUtXqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1604399629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=GQtIeN+bNrXtdDJbIY1/lT5u2Qlmlecyg45ylimAqeo=;
 b=aDUoEgUsKRf0mAVHG33KZuw3tdfR+OUYkG1a4FnTBJVD3Vb06TvF7LUgRRezOsbA4xMida
 qFHqtJWvRi1kHPBw==
Date: Tue, 03 Nov 2020 10:27:33 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 21/37] Documentation/io-mapping: Remove outdated blurb
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-aio@kvack.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Ben Segall <bsegall@google.com>, Chris Mason <clm@fb.com>,
 Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Paul McKenney <paulmck@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, David Airlie <airlied@linux.ie>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Mel Gorman <mgorman@suse.de>, nouveau@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>, linux-snps-arc@lists.infradead.org,
 Ben Skeggs <bskeggs@redhat.com>, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
 Roland Scheidegger <sroland@vmware.com>, Josef Bacik <josef@toxicpanda.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org,
 David Sterba <dsterba@suse.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Jani Nikula <jani.nikula@linux.intel.com>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Nick Hu <nickhu@andestech.com>, linux-mm@kvack.org,
 Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org,
 Christian Koenig <christian.koenig@amd.com>, Benjamin LaHaise <bcrl@kvack.org>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-btrfs@vger.kernel.org,
 Greentime Hu <green.hu@gmail.com>
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

The implementation details in the documentation are outdated and not really
helpful. Remove them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 Documentation/driver-api/io-mapping.rst |   22 ----------------------
 1 file changed, 22 deletions(-)

--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -73,25 +73,3 @@ for pages mapped with io_mapping_map_wc.
 At driver close time, the io_mapping object must be freed::
 
 	void io_mapping_free(struct io_mapping *mapping)
-
-Current Implementation
-======================
-
-The initial implementation of these functions uses existing mapping
-mechanisms and so provides only an abstraction layer and no new
-functionality.
-
-On 64-bit processors, io_mapping_create_wc calls ioremap_wc for the whole
-range, creating a permanent kernel-visible mapping to the resource. The
-map_atomic and map functions add the requested offset to the base of the
-virtual address returned by ioremap_wc.
-
-On 32-bit processors with HIGHMEM defined, io_mapping_map_atomic_wc uses
-kmap_atomic_pfn to map the specified page in an atomic fashion;
-kmap_atomic_pfn isn't really supposed to be used with device pages, but it
-provides an efficient mapping for this usage.
-
-On 32-bit processors without HIGHMEM defined, io_mapping_map_atomic_wc and
-io_mapping_map_wc both use ioremap_wc, a terribly inefficient function which
-performs an IPI to inform all processors about the new mapping. This results
-in a significant performance penalty.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
