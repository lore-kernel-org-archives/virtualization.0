Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 16:14:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F266060F58
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 16:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F266060F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB53D40113;
	Mon, 13 Sep 2021 16:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2VNlmPAPjmRE; Mon, 13 Sep 2021 16:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 25D4F40004;
	Mon, 13 Sep 2021 16:14:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F17F3C0011;
	Mon, 13 Sep 2021 16:14:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05257C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAB3C401B2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="P/4IFY9R";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="Q7q10t86"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DqIkA_z6PO1P
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:14:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CCBD4018B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 16:14:19 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85FAC1FD99;
 Mon, 13 Sep 2021 16:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631549656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=am3WMc1q9XARynRDUM7E3FUGoxi9LsITJzf3oeQ+Lww=;
 b=P/4IFY9RCf3aKGlNrhp4PnGQUQUBpMMsHj0KqsHTSXt5OdpCfML/CO9aOsYMSrM2X9fQuN
 +uG8yEn3iOcJ4wLeht3ztrh5E3yCcwpzPJm7JFM92jmUw918wl5ZBG27ouscyAT4J34f1T
 N3cV0Ud03Kmk8mK9YOC4/ANyQFbWLa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631549656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=am3WMc1q9XARynRDUM7E3FUGoxi9LsITJzf3oeQ+Lww=;
 b=Q7q10t86FU0aIasjf0FzLIFUI+diQ5WAToTZOr1nw6kx/bpWHfTpn4UjvYcHbt8+s2poj8
 UAtG7spSEyhbPVAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A329613AAB;
 Mon, 13 Sep 2021 16:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 62cXJtd4P2F6IQAAMHmgww
 (envelope-from <jroedel@suse.de>); Mon, 13 Sep 2021 16:14:15 +0000
Date: Mon, 13 Sep 2021 18:14:14 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 00/12] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Message-ID: <YT941raolZvGTVR/@suse.de>
References: <20210913155603.28383-1-joro@8bytes.org>
 <4e033293-b81d-1e21-6fd6-f507b6821d3c@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4e033293-b81d-1e21-6fd6-f507b6821d3c@intel.com>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
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

On Mon, Sep 13, 2021 at 09:02:38AM -0700, Dave Hansen wrote:
> On 9/13/21 8:55 AM, Joerg Roedel wrote:
> > This does not work under SEV-ES, because the hypervisor has no access
> > to the vCPU registers and can't make modifications to them. So an
> > SEV-ES guest needs to reset the vCPU itself and park it using the
> > AP-reset-hold protocol. Upon wakeup the guest needs to jump to
> > real-mode and to the reset-vector configured in the AP-Jump-Table.
> 
> How does this end up looking to an end user that tries to kexec() from a
> an SEV-ES kernel?  Does it just hang?

Yes, the kexec will just hang. This patch-set contains code to disable
the kexec syscalls in situations where it would not work for that
reason.

Actually with the changes to the decompressor in this patch-set the
kexec'ed kernel could boot, but would fail to bring up all the APs.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
