Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30C5C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 19:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39B8D40946;
	Mon, 10 Jan 2022 19:31:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G4Gyb_SSNUMi; Mon, 10 Jan 2022 19:31:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D112D40942;
	Mon, 10 Jan 2022 19:31:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AA80C002F;
	Mon, 10 Jan 2022 19:31:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52C9BC001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 19:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B1E183046
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 19:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id INnumImalT6E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 19:31:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B71F8249E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 19:31:20 +0000 (UTC)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de
 [88.67.202.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89E811EC0537;
 Mon, 10 Jan 2022 20:31:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1641843073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Rwo72JYN2NXzToekd3N5Lbv6REyFZSUm1+H2xBFoDYo=;
 b=UAGwGeNRtD02ZVAIhmJeG/PmYrnrsnA19bAMq5iaYpPLVXTGvuP8oG8uKDTV/uqmQKnhHv
 KRplE04133yuzwGE9CW/vfiueTXTksRYngIZrbZYMYhn4L3LV5Q3YgOhoM4tdKpqAue3nE
 EIuN4IfMNYKAf6dokgplYxF8Mr2bJQ4=
Date: Mon, 10 Jan 2022 20:31:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: use %rip-relative addressing in hook calls
Message-ID: <YdyJhFeAWB6OMrms@zn.tnic>
References: <b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com>
 <ba01c739-cda3-cc39-af5b-225d20c20a1e@suse.com>
 <1ef292aa-9107-4e79-9e60-75887bc04dd3@suse.com>
 <764eb4c1-0839-b7da-1c7f-837380fa39fd@suse.com>
 <46270efe-df82-8d95-8b6b-4603f5be7b60@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46270efe-df82-8d95-8b6b-4603f5be7b60@suse.com>
Cc: "VMware, Inc." <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
 Jan Beulich <jbeulich@suse.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

On Mon, Jan 10, 2022 at 02:26:18PM +0100, Juergen Gross wrote:
> Thomas, another ping. Didn't you want to take this patch more than a
> month ago? Cc-ing the other x86 maintainers, too.

I'll have a look after the merge window is over.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
