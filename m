Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73488C25B47
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 10:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E40154F3A9;
	Wed, 25 Oct 2023 10:50:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E40154F3A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=THlV6aVy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsEWmyun0N94; Wed, 25 Oct 2023 10:50:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 192224F2F2;
	Wed, 25 Oct 2023 10:50:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 192224F2F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCB66C0071;
	Wed, 25 Oct 2023 10:50:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 325DEC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F32BB850B2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:50:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F32BB850B2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de
 header.a=rsa-sha256 header.s=alien8 header.b=THlV6aVy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fLKV_zAAKZiV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:50:41 +0000 (UTC)
X-Greylist: delayed 599 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 25 Oct 2023 10:50:40 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2B458504C
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F2B458504C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 10:50:40 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BDDE140E01B1; 
 Wed, 25 Oct 2023 10:34:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id QhHASVTCwIga; Wed, 25 Oct 2023 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1698230067; bh=18/mcvH27y89kOfWgOoc8il6KtQKA9GxDmtXxRzFDWs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=THlV6aVyPuO4ttcnuH/sGy+hWth3pFJ07cC8hdq9VyG+NrRs/JloOwG2eT09BBphI
 RlM67phHuDDqlYPZj44DIIVVPEP0IbQLF6FlE7kTMwDkM9ucCXtShvRTn3PURoC7+S
 71N3Cgs86GC7rspSy0IFg1kiTZX9AXS6TRlmhA8CchZBik8YxcJY2RHS8pQnaEgjcJ
 +UDXQ/F6AJ/wmNnWh6fGhA3s0cN1TiXtb3/aP30DNq1EGWpoG5dCVw54fe9CcSnTMw
 LkybLkvVkIJGj5Ax2VPWJsFlGPNwXoiUhtOo39O2PdqpH6rx6Z2f7d7lO3heV4q9Oj
 jmRV9D25H83khSsp3ccugLurO/iUhzlRD8aGNl2b7PkflskJnrV486d+8EOoJFDWup
 H36ii52EzVM/gC1PQheMUv9cNyPpZG3lsIY13i3B1b8uCCh8CwnK05i0M4kqjzyU8A
 v7yevDQlwKxc43uw/0QlTAdTA7sQ4CFT3aRpbSthtG4/CGwXlVRbkDEMUGrcMAMNyV
 SjhVKhf0madhWha83TWsjxX+DndfcCe06zn2F4TzrpxE0ccnwU5xNm0Ou4wP/w3BGq
 l2qJa88fiy1hYv+ux2UZyZustv7joHhOV5ves/f5olzL7HgQaoeDOo9ZaJ3lMal37F
 kiycBZsBh5nho7t4msMZd5IY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3E1740E0196;
 Wed, 25 Oct 2023 10:34:08 +0000 (UTC)
Date: Wed, 25 Oct 2023 12:34:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 1/5] x86/paravirt: move some functions and defines to
 alternative
Message-ID: <20231025103402.GBZTjvGse9c0utZGO0@fat_crate.local>
References: <20231019091520.14540-1-jgross@suse.com>
 <20231019091520.14540-2-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231019091520.14540-2-jgross@suse.com>
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

On Thu, Oct 19, 2023 at 11:15:16AM +0200, Juergen Gross wrote:
> +/* Low-level backend functions usable from alternative code replacements. */
> +DEFINE_ASM_FUNC(x86_nop, "", .entry.text);
> +EXPORT_SYMBOL_GPL(x86_nop);

This is all x86 code so you don't really need the "x86_" prefix - "nop"
is perfectly fine.

> +noinstr void x86_BUG(void)
> +{
> +	BUG();
> +}
> +EXPORT_SYMBOL_GPL(x86_BUG);

That export is needed for?

Paravirt stuff in modules?

It builds here without it - I guess I need to do an allmodconfig.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
