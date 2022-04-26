Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F97C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 17:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6925983774;
	Tue, 26 Apr 2022 17:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXhqPrjDaIFM; Tue, 26 Apr 2022 17:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 18362837AC;
	Tue, 26 Apr 2022 17:40:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB03BC0039;
	Tue, 26 Apr 2022 17:40:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B10CCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 17:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9008D41776
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 17:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Kbaa7NwTOdp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 17:40:41 +0000 (UTC)
X-Greylist: delayed 00:09:16 by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A5B641696
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 17:40:41 +0000 (UTC)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A39F1EC04F9;
 Tue, 26 Apr 2022 19:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1650994274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=+xYV1ChaydvSUgBTfjtQMIuLFvZBBr5YN11vYi9Ld+E=;
 b=mHHpxddAp1KGl7iVSXBqP485BzzHfEiDLirauISvPiHFQA4pKujjt94hu/0G5btJIrAYXs
 AgKOhoTfGuODLk8Pcj96q5/sA/QKxxyESUH1NMiE/NrrGBlMujDp4LDHT+JRqWlnAGsJrc
 IP179lVA+WstNQvMGVBAYBDzybKjVJY=
Date: Tue, 26 Apr 2022 19:31:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 1/2] kernel: add platform_has() infrastructure
Message-ID: <YmgsYvWQchxub8cW@zn.tnic>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-2-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220426134021.11210-2-jgross@suse.com>
Cc: linux-hyperv@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, Dexuan Cui <decui@microsoft.com>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>
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

On Tue, Apr 26, 2022 at 03:40:20PM +0200, Juergen Gross wrote:
> diff --git a/kernel/platform-feature.c b/kernel/platform-feature.c
> new file mode 100644
> index 000000000000..2d52f8442cd5
> --- /dev/null
> +++ b/kernel/platform-feature.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/cache.h>
> +#include <linux/platform-feature.h>
> +
> +unsigned long __read_mostly platform_features[PLATFORM_FEAT_ARRAY_SZ];

Probably __ro_after_init.

> +EXPORT_SYMBOL_GPL(platform_features);

You probably should make that thing static and use only accessors to
modify it in case you wanna change the underlying data structure in the
future.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
