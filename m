Return-Path: <SRS0=DeYQ=MX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C978C4338F
	for <virtualization@archiver.kernel.org>; Sat, 31 Jul 2021 07:18:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C6D60F3A
	for <virtualization@archiver.kernel.org>; Sat, 31 Jul 2021 07:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12C6D60F3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6BFB404D3;
	Sat, 31 Jul 2021 07:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8FCj-nr5g0cU; Sat, 31 Jul 2021 07:18:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83362404D4;
	Sat, 31 Jul 2021 07:18:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5972FC001B;
	Sat, 31 Jul 2021 07:18:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B056C0010
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Jul 2021 07:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B2E683BCE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Jul 2021 07:18:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="SIZqtvPz";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="W5JnI93A"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vLffAy51_RYw
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Jul 2021 07:18:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EC9A83BC8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 31 Jul 2021 07:18:52 +0000 (UTC)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C982C221EC;
 Sat, 31 Jul 2021 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627715930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYXKdOA0fBvv3pT9/gbt1KAOZlZXQo7vqAE3CEoQmhc=;
 b=SIZqtvPzmOG/Ra46XoIlPdRUWTuUFNuTDrzOMC50MSV4nxIMkY5X4fyufS4wSZ25YIqksq
 KyNFHPZL6TJLku52OIdWlXz7sly68sLZKaWjTRandjx8g52RO0N39dvaz7FAIO7aMWMavo
 qmJJ/cdDK69bA4jpapVwzUKN0oEkU74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627715930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WYXKdOA0fBvv3pT9/gbt1KAOZlZXQo7vqAE3CEoQmhc=;
 b=W5JnI93AVF4zlV18NHpo6fRUwu6MQgLRiKthCmKHv0li9fxNDaTCx2VrYtLlIcSEbgagVh
 1LnIRyxI9ZxFaTAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0524B1368F;
 Sat, 31 Jul 2021 07:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id eWMiO1n5BGG4OQAAGKfGzw
 (envelope-from <jroedel@suse.de>); Sat, 31 Jul 2021 07:18:49 +0000
Date: Sat, 31 Jul 2021 09:18:48 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 04/12] x86/sev: Do not hardcode GHCB protocol version
Message-ID: <YQT5WPANjqXSytPR@suse.de>
References: <20210721142015.1401-1-joro@8bytes.org>
 <20210721142015.1401-5-joro@8bytes.org>
 <1eef6235-a8d0-1012-969e-ef6f0804d054@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1eef6235-a8d0-1012-969e-ef6f0804d054@amd.com>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Martin Radev <martin.b.radev@gmail.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, linux-coco@lists.linux.dev,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Erdem Aktas <erdemaktas@google.com>
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

Hi Tom,

On Wed, Jul 21, 2021 at 04:17:38PM -0500, Tom Lendacky wrote:
> On 7/21/21 9:20 AM, Joerg Roedel wrote:
> >  	/* Fill in protocol and format specifiers */
> > -	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
> > +	ghcb->protocol_version = sev_get_ghcb_proto_ver();
> 
> So this probably needs better clarification in the spec, but the GHCB
> version field is for the GHCB structure layout. So if you don't plan to
> use the XSS field that was added for version 2 of the layout, then you
> should report the GHCB structure version as 1.

Yeah, this makes sense, exept for the struct field-name ;) But anyway, I
keep the version field at 1 for now.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
