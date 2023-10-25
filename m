Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA96C07545
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 13:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 366B581CE3;
	Wed, 25 Oct 2023 13:45:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 366B581CE3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=OMcAKbyU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KnJM9M9nMHyT; Wed, 25 Oct 2023 13:45:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6AE8818D4;
	Wed, 25 Oct 2023 13:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6AE8818D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CAE8C0039;
	Wed, 25 Oct 2023 13:44:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E742C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 13:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A334818D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 13:44:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A334818D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hAagFtRERFte
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 13:44:54 +0000 (UTC)
X-Greylist: delayed 11421 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 25 Oct 2023 13:44:54 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D25E80E9B
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D25E80E9B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 13:44:54 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8D95A40E00B3; 
 Wed, 25 Oct 2023 13:44:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Fc0bnT_9t_Uq; Wed, 25 Oct 2023 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1698241488; bh=+ieImtZGj+VOp5ccDeztXRroa/BoBO+stfynN77x4s4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OMcAKbyUkyhuqj1UFc9ljgQxXx/4iDnowTXeq7KTMybgZzdM7S0yqlfMFwMNQogK+
 o7cds6WEPJevCOXRK3/plplccqOSImH8RhAjRDu+ivVcaAoc4+flNZBJ7P9p8ExOz9
 eE6xO9TRFbtCyPrNWN1aMmrvTXdra/rLEIhKFMcK+Z4FWklW+46Mr9NfRFTWdx442C
 vQf0ziYnpiAejiwLDVDqN/3skD2n8Z8VmLa5GFnLcfvXxT/EIk4OpvgDUK4Kw/5CU+
 2eZJh92QixzUyta0Vcn51qj3YFDBJbP1Qu2fLKY1Nqc3iTmCfvIZIa63Fmx8KRJAyb
 aGPCeBmtg5fkgb82mRF6wA3bM6IXyjEVs4QQm2Pare6nAha+WmH3QeCz+RSlhdN7iH
 cYkUWvfPzT8EspK1cwlTD6AHy7W2Zz0PYeC/aRQuiBN0ts4jvY6jpTRaJ+4Ak0MBBf
 dMe+r6HUKUPf5a8xS9nhwlgsmk7RaIIsNG35ykeiNGOJd8Ktxewx9K0xkXwYuSHMjR
 TGBdHsXswCUnMdLud8l56yK+te3+72BH2EL+90wue8aqWKUjRW+6AZDoIcsAvCPf0L
 L/HnqzY/x2fUdh7331lw3NQ5alr6ljA/L+9+f8+l5oeP3Xb7gR68t6Z+R0JI3jOSZr
 TgkiOe1BkQgz8i9OugTPbVGQ=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C1F840E0187;
 Wed, 25 Oct 2023 13:44:30 +0000 (UTC)
Date: Wed, 25 Oct 2023 15:44:25 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 1/5] x86/paravirt: move some functions and defines to
 alternative
Message-ID: <20231025134425.GEZTkbua5w0bI2GQlP@fat_crate.local>
References: <20231019091520.14540-1-jgross@suse.com>
 <20231019091520.14540-2-jgross@suse.com>
 <20231025103402.GBZTjvGse9c0utZGO0@fat_crate.local>
 <fde7ffdd-4d12-4821-ac51-e67e65637111@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fde7ffdd-4d12-4821-ac51-e67e65637111@suse.com>
Cc: Wanpeng Li <wanpengli@tencent.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Makhalov <amakhalov@vmware.com>, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Peter Zijlstra <peterz@infradead.org>, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Oct 25, 2023 at 03:31:07PM +0200, Juergen Gross wrote:
> There is
> 
> #define nop() asm volatile ("nop")
> 
> in arch/x86/include/asm/special_insns.h already.

Then call it "nop_func" or so.

> It might not be needed now, but are you sure we won't need it in future?

No, I'm not.

What I'm sure of is: stuff should be added to the kernel only when
really needed. Not in the expectation that it might potentially be
needed at some point.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
