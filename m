Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E40C56201
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 11:03:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537522053B
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 11:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IyNoaFai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3CYfPdTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537522053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F1DF86EEE;
	Thu, 12 Nov 2020 11:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DXK6lU74P552; Thu, 12 Nov 2020 11:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ACF2386EFD;
	Thu, 12 Nov 2020 11:03:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 920C7C0889;
	Thu, 12 Nov 2020 11:03:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77C61C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 11:03:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3096F2E19D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 11:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cfolhXZ9J7NO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 11:03:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id 9ABE32E182
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 11:03:24 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1605179001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RyoQNma1D4GVgEfBEnD9HpKfLsmdKQZ2swCCbsJ89u4=;
 b=IyNoaFaiD+NM5KphnaangmvfL0El+UAOD+w5h3trf2Yyosfdrv/YLVOkMULOW/ZGBhg+Y/
 CdApJJvXGBIZ5Y44ibFQmafGLFWCU3g2FoxBkEzR7mbT6bdJj8sJZKMh9WrX346Yk/RRPA
 ObPEWbP1WIFj7Nu0oQW4DAuIZK/gvLY9xJn27pRRcuIRXasgXoUZIFo7CFG246Z8CyXPW3
 lDFsIyNmic0931dDytsaIyKfHvx6VLixbP2g5wvqVZcSxNyP0kB6LHCFDa/PWmE2zunoqs
 ONbIDGQXkPDZeN2NEzrt5DA5ZmFd/tf+3b4Z7uRwEDxb+zVSTZJFZcQwZtL5UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1605179001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RyoQNma1D4GVgEfBEnD9HpKfLsmdKQZ2swCCbsJ89u4=;
 b=3CYfPdTtsJ7bzsqrZTQJEvt1hjj5oOsRpY9HRk4W6lYOEOtLJxrx+ZTCMYthtsl9eIeQcX
 u0l5A2sNhnUsiqCg==
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch V3 10/37] ARM: highmem: Switch to generic kmap atomic
In-Reply-To: <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
References: <20201103092712.714480842@linutronix.de>
 <20201103095857.582196476@linutronix.de>
 <CGME20201112081036eucas1p14e135a370d3bccab311727fd2e89f4df@eucas1p1.samsung.com>
 <c07bae0c-68dd-2693-948f-00e8a50f3053@samsung.com>
Date: Thu, 12 Nov 2020 12:03:20 +0100
Message-ID: <87v9ean8g7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>,
 nouveau@lists.freedesktop.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Huang Rui <ray.huang@amd.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Paul McKenney <paulmck@kernel.org>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-csky@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Mel Gorman <mgorman@suse.de>, Dave Airlie <airlied@redhat.com>,
 linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Christian Koenig <christian.koenig@amd.com>, linux-btrfs@vger.kernel.org
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

Marek,

On Thu, Nov 12 2020 at 09:10, Marek Szyprowski wrote:
> On 03.11.2020 10:27, Thomas Gleixner wrote:
>
> I can do more tests to help fixing this issue. Just let me know what to do.

Just sent out the fix before I saw your report.

     https://lore.kernel.org/r/87y2j6n8mj.fsf@nanos.tec.linutronix.de

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
