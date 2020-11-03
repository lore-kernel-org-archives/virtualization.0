Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693CBC63699
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:33:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B852244C
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBayNHLC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQ5pkdX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B852244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 70FCC86E4A;
	Tue,  3 Nov 2020 10:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXb2h6ZNHYPH; Tue,  3 Nov 2020 10:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D648586DB2;
	Tue,  3 Nov 2020 10:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE24CC1AD6;
	Tue,  3 Nov 2020 10:33:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9927C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D6E5D86079
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1XzN0cFLReX9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 146E986044
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:33:29 +0000 (UTC)
Message-Id: <20201103095856.870272797@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1604399606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=mHGaObavEXdpklPpAdB/Vc9tQphwJ4HtjtNI7fLm1v8=;
 b=IBayNHLC8hDXJPq5spbDcH2wKyiWbuyexwHwfVt89VcAakRhxfizYqbQCAAKER9L/0L/m1
 Kn6tmBkR3xWZrx6tJ/BA5rsYN4HGNPFD48Ua4frK3vrnlVg9aLM4m5aIJw9ym5mSbN61k5
 EHHJS0+GcvKD5mXRHapBzJaiaTtrRGQL9/oIkA+EXvVydTfP9WAjd4wBDbJghjylU6Hl+v
 cbUiIXxIilBIpfO0gAqBvTDU+ZaYnr+9b9dZHzEpb1hZtXN8oqnkWtU4heJMQKd9pbhu3F
 Udw+2wxDQStY2AooCfpVR6WbhoIEGNiJw2A//IRPpAYo18WAjI/Kj422cg4K+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1604399606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=mHGaObavEXdpklPpAdB/Vc9tQphwJ4HtjtNI7fLm1v8=;
 b=ZQ5pkdX4DsEbSRpww8iUtueplpi1akZRVpDjtrypi3SvuIOi8H/SrYDmUdCkGKxD3wiqTh
 yikxYY0p6mIHukBQ==
Date: Tue, 03 Nov 2020 10:27:15 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 03/37] fs: Remove asm/kmap_types.h includes
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-aio@kvack.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Ben Segall <bsegall@google.com>, linux-mm@kvack.org,
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
 Nick Hu <nickhu@andestech.com>, Chris Mason <clm@fb.com>,
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

Historical leftovers from the time where kmap() had fixed slots.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-aio@kvack.org
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
---
 fs/aio.c         |    1 -
 fs/btrfs/ctree.h |    1 -
 2 files changed, 2 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -43,7 +43,6 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 
-#include <asm/kmap_types.h>
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
 
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -17,7 +17,6 @@
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <trace/events/btrfs.h>
-#include <asm/kmap_types.h>
 #include <asm/unaligned.h>
 #include <linux/pagemap.h>
 #include <linux/btrfs.h>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
