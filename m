Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C1C8300E
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:34:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D9E2242B
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UCiLeToK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iNcZKx8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D9E2242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F0279873BF;
	Tue,  3 Nov 2020 10:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dUz3PvjSY8G; Tue,  3 Nov 2020 10:34:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF2CC873BA;
	Tue,  3 Nov 2020 10:34:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9626C0889;
	Tue,  3 Nov 2020 10:34:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B57C8C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 82B772076F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:34:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9FhK+91a04q0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:34:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 2594520768
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:34:06 +0000 (UTC)
Message-Id: <20201103095859.538827102@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1604399639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=37l2/9hMoX995irJwwZT0VNkjmk/OwZo72GhT72QTX4=;
 b=UCiLeToK4AIC+9Dmx7LG5rV2mjuvYVd6Coif2Sdjhi7Si2K86UL165usKvCu+1M57a5ZTs
 3lGdAzYJonKcTuvyMgrOXNx+UrIY8LVcTVNso2JLtpbkE1oygEe/wl748JnAW6AS6EsTrD
 c2VWZi0Trd4Jp1S58g19SzXtzA+u8eA2qRCth6y4qBL25KfIk14Y8/pIC7Pk9xx9opLe+Y
 fYTupCtZR4FQC2/b1qBabqi8Jfeh2ZKqUrq+V0zmNc17uiUhxxjlvxwBR152OCIcLA02mF
 vb+4tkvTlRO1TXdeUxGxjDkLW4Yer0R+EYHQyA+pAWiyVIPp/wbrw75o+T0ZJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1604399639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=37l2/9hMoX995irJwwZT0VNkjmk/OwZo72GhT72QTX4=;
 b=iNcZKx8Fg9QYlTcIp7Z3u6IBgHA5T+EwXNMLuSSTvrJb/3r4DH72OAUwbFyp58bawCPYfQ
 dJ5wikkjaG3JOhAw==
Date: Tue, 03 Nov 2020 10:27:41 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 29/37] ARM: mm: Replace kmap_atomic_pfn()
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

There is no requirement to disable pagefaults and preemption for these
cache management mappings.

Replace kmap_atomic_pfn() with kmap_local_pfn(). This allows to remove
kmap_atomic_pfn() in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
V3: New patch
---
 arch/arm/mm/cache-feroceon-l2.c |    6 +++---
 arch/arm/mm/cache-xsc3l2.c      |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -49,9 +49,9 @@ static inline unsigned long l2_get_va(un
 	 * we simply install a virtual mapping for it only for the
 	 * TLB lookup to occur, hence no need to flush the untouched
 	 * memory mapping afterwards (note: a cache flush may happen
-	 * in some circumstances depending on the path taken in kunmap_atomic).
+	 * in some circumstances depending on the path taken in kunmap_local).
 	 */
-	void *vaddr = kmap_atomic_pfn(paddr >> PAGE_SHIFT);
+	void *vaddr = kmap_local_pfn(paddr >> PAGE_SHIFT);
 	return (unsigned long)vaddr + (paddr & ~PAGE_MASK);
 #else
 	return __phys_to_virt(paddr);
@@ -61,7 +61,7 @@ static inline unsigned long l2_get_va(un
 static inline void l2_put_va(unsigned long vaddr)
 {
 #ifdef CONFIG_HIGHMEM
-	kunmap_atomic((void *)vaddr);
+	kunmap_local((void *)vaddr);
 #endif
 }
 
--- a/arch/arm/mm/cache-xsc3l2.c
+++ b/arch/arm/mm/cache-xsc3l2.c
@@ -59,7 +59,7 @@ static inline void l2_unmap_va(unsigned
 {
 #ifdef CONFIG_HIGHMEM
 	if (va != -1)
-		kunmap_atomic((void *)va);
+		kunmap_local((void *)va);
 #endif
 }
 
@@ -75,7 +75,7 @@ static inline unsigned long l2_map_va(un
 		 * in place for it.
 		 */
 		l2_unmap_va(prev_va);
-		va = (unsigned long)kmap_atomic_pfn(pa >> PAGE_SHIFT);
+		va = (unsigned long)kmap_local_pfn(pa >> PAGE_SHIFT);
 	}
 	return va + (pa_offset >> (32 - PAGE_SHIFT));
 #else

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
