Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D2FC2BA4C
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 14:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DE8660B70;
	Wed, 26 Jan 2022 14:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id svn9_tY40EEh; Wed, 26 Jan 2022 14:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADB3260AC6;
	Wed, 26 Jan 2022 14:26:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 858A3C0039;
	Wed, 26 Jan 2022 14:26:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E52C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D768641645
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="oxNzeR3E";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="Zf9Zim80"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bW1hiTy2NoU9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:26:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47E0B41672
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 14:26:07 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E8002113B;
 Wed, 26 Jan 2022 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643207164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLyKhfXHS44+Znkmdw5Wkn13IOJ7HmCc2bqdYmRAEVg=;
 b=oxNzeR3EjZyJqfzhIUshnheJ0INLWf66MfyocLgT8F2bMmX9rDhOpeOucc8uVnXkZnlwrL
 N6DmoMYW3MhH5LkEKjNETbnhojlh6h7S2PMJeLFWEUdQHmfizHlU7tRzGWjzCoobQEbKJf
 Ig3Kn6r6NxAW9MfIjTmTj8hdFAJj694=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643207164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLyKhfXHS44+Znkmdw5Wkn13IOJ7HmCc2bqdYmRAEVg=;
 b=Zf9Zim80aCa4MDEXnNy318W3kpCJ/XdcZx5iwGuSF2NMAz3RXI1cSFR9dyB9uSO5TpCLIW
 +YTW2Lzh1DdMS1CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A9AA13E1A;
 Wed, 26 Jan 2022 14:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oZl4FPtZ8WHxegAAMHmgww
 (envelope-from <jroedel@suse.de>); Wed, 26 Jan 2022 14:26:03 +0000
Date: Wed, 26 Jan 2022 15:26:01 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 07/12] x86/sev: Setup code to park APs in the AP Jump
 Table
Message-ID: <YfFZ+SRutJhDoAkz@suse.de>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-8-joro@8bytes.org> <YYv1TPawuorQv1PR@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYv1TPawuorQv1PR@zn.tnic>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Nov 10, 2021 at 05:37:32PM +0100, Borislav Petkov wrote:
> On Mon, Sep 13, 2021 at 05:55:58PM +0200, Joerg Roedel wrote:
> >  extern unsigned char real_mode_blob[];
> > diff --git a/arch/x86/include/asm/sev-ap-jumptable.h b/arch/x86/include=
/asm/sev-ap-jumptable.h
> > new file mode 100644
> > index 000000000000..1c8b2ce779e2
> > --- /dev/null
> > +++ b/arch/x86/include/asm/sev-ap-jumptable.h
> =

> Why a separate header? arch/x86/include/asm/sev.h looks small enough.

The header is included in assembly, so I made a separate one.

> > +void __init sev_es_setup_ap_jump_table_data(void *base, u32 pa)
> =

> Why is this a separate function?
> =

> It is all part of the jump table setup.

Right, but the sev_es_setup_ap_jump_table_blob() function is already
pretty big and I wanted to keep things readable.

> =

> > +		return 0;
> =

> Why are you returning 0 here and below?

This is in an initcall and it returns just 0 when the environment is not
ready to setup the ap jump table. Returning non-zero would create a
warning message in the caller for something that is not a bug in the
kernel.

> > + * This file contains the source code for the binary blob which gets c=
opied to
> > + * the SEV-ES AP Jumptable to park APs while offlining CPUs or booting=
 a new
> =

> I've seen "Jumptable", "Jump Table" and "jump table" at least. I'd say, do
> the last one everywhere pls.

Fair, sorry for my english being too german :) I changed everything to
'jump table'.

> > +	/* Reset remaining registers */
> > +	movl	$0, %esp
> > +	movl	$0, %eax
> > +	movl	$0, %ebx
> > +	movl	$0, %edx
> =

> All 4: use xor

XOR changes EFLAGS, can not use them here.

> > +
> > +	/* Reset CR0 to get out of protected mode */
> > +	movl	$0x60000010, %ecx
> =

> Another magic naked number.

This is the CR0 reset value. I have updated the comment to make this
more clear.

Thanks,

-- =

J=F6rg R=F6del
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N=FCrnberg
Germany
 =

(HRB 36809, AG N=FCrnberg)
Gesch=E4ftsf=FChrer: Ivo Totev

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
