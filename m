Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9315C433FE
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 12:28:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55DA360F23;
	Wed, 27 Apr 2022 12:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfbOAfp1qRPO; Wed, 27 Apr 2022 12:28:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D8C4060B37;
	Wed, 27 Apr 2022 12:28:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1867C0039;
	Wed, 27 Apr 2022 12:28:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53FAAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 12:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C32C418D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 12:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wp2QbPIPyVsi
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 12:28:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16193418D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 12:28:49 +0000 (UTC)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03CBC1EC0535;
 Wed, 27 Apr 2022 14:28:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1651062524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=aKBRkdcOUK2pnp+vQSbUvbTqtIXnLKj0VJmSDmt7oC0=;
 b=NHfKIFQJ+SZeRMFRR7iG7AvrorZ4sGeAQW951IHLqZGiIhH8xsnL4MEoCvZdO988HVhjCs
 QiJ/yZkmdzpdCcjdb2XM/Jk4CwXtZtIij26TQdC9Zn+whgo9bcaGJcoQKIQwADOIUE7sTC
 lJ/9+OjkWEUKJjYRxqSk5MOYidSpSXw=
Date: Wed, 27 Apr 2022 14:28:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
Message-ID: <Ymk2/N/DdAyxQnV0@zn.tnic>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-3-jgross@suse.com> <Ymgtb2dSNYz7DBqx@zn.tnic>
 <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c1a4a7d-a273-c3b0-3683-195f6e09a027@suse.com>
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

On Wed, Apr 27, 2022 at 08:37:31AM +0200, Juergen Gross wrote:
> On 26.04.22 19:35, Borislav Petkov wrote:
> > On Tue, Apr 26, 2022 at 03:40:21PM +0200, Juergen Gross wrote:
> > >   /* protected virtualization */
> > >   static void pv_init(void)
> > >   {
> > >   	if (!is_prot_virt_guest())
> > >   		return;
> > > +	platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> > 
> > Kinda long-ish for my taste. I'll probably call it:
> > 
> > 	platform_set()
> > 
> > as it is implicit that it sets a feature bit.
> 
> Okay, fine with me.
> 
> > 
> > > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> > > index b43bc24d2bb6..6043ba6cd17d 100644
> > > --- a/arch/x86/mm/mem_encrypt_identity.c
> > > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > > @@ -40,6 +40,7 @@
> > >   #include <linux/mm.h>
> > >   #include <linux/mem_encrypt.h>
> > >   #include <linux/cc_platform.h>
> > > +#include <linux/platform-feature.h>
> > >   #include <asm/setup.h>
> > >   #include <asm/sections.h>
> > > @@ -566,6 +567,10 @@ void __init sme_enable(struct boot_params *bp)
> > >   	} else {
> > >   		/* SEV state cannot be controlled by a command line option */
> > >   		sme_me_mask = me_mask;
> > > +
> > > +		/* Set restricted memory access for virtio. */
> > > +		platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> > 
> > Huh, what does that have to do with SME?
> 
> I picked the function where sev_status is being set, as this seemed to be
> the correct place to set the feature bit.

What I don't understand is what does restricted memory access have to do
with AMD SEV and how does play together with what you guys are trying to
do?

The big picture pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
