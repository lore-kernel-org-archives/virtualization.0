Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4841FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 09:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C131740B86;
	Thu, 27 Jan 2022 09:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0xTHGMUkULyV; Thu, 27 Jan 2022 09:01:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1827B400C1;
	Thu, 27 Jan 2022 09:01:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6C17C0011;
	Thu, 27 Jan 2022 09:01:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FEDAC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 09:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D18960F93
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 09:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="VqCRighS";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="vGIapNrO"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MaaTSKRgjuyl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 09:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8761B60F40
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 09:01:36 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87ABA1F882;
 Thu, 27 Jan 2022 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643274093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf6L1U20L42jQ06xefiKuwA7v4ertkV/8P81jUSoYis=;
 b=VqCRighSWgCkUFJuLikNgA17cNUdoQJUUMG40XffnG266MZ4zbi84gI2NlZBRuFTgJEaa0
 fELyOdxO5Leeh+/wwz6VwxGtf+BdohVQUq4AQrdEgo3ph2A2b9/RzhSfnndwAtTjMobW1X
 RTKbzaqsHULmA3qdggTQzuSflnpTVG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643274093;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf6L1U20L42jQ06xefiKuwA7v4ertkV/8P81jUSoYis=;
 b=vGIapNrOTT3gC/AXlc2MXAoxBVjNtZ5L1hGxECi4SW4qf5MejumWnp/9gYGPfVvWB+VRLl
 rSXoTgEUWwhr6uAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B85E313CFB;
 Thu, 27 Jan 2022 09:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7cJPK2xf8mFaEwAAMHmgww
 (envelope-from <jroedel@suse.de>); Thu, 27 Jan 2022 09:01:32 +0000
Date: Thu, 27 Jan 2022 10:01:31 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 08/12] x86/sev: Park APs on AP Jump Table with GHCB
 protocol version 2
Message-ID: <YfJfa955Pkg1y6Gv@suse.de>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-9-joro@8bytes.org> <YY6XQfmvmpmUiIGj@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YY6XQfmvmpmUiIGj@zn.tnic>
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

On Fri, Nov 12, 2021 at 05:33:05PM +0100, Borislav Petkov wrote:
> On Mon, Sep 13, 2021 at 05:55:59PM +0200, Joerg Roedel wrote:
> > +		     "ljmpl	*%0" : :
> > +		     "m" (real_mode_header->sev_real_ap_park_asm),
> > +		     "b" (sev_es_jump_table_pa >> 4));
> =

> In any case, this asm needs comments: why those regs, why
> sev_es_jump_table_pa >> 4 in rbx (I found later in the patch why) and so
> on.

Turned out the jump_table_pa is not used in asm code anymore. It was a
left-over from a previous version of the patch, it is removed now.

> > +SYM_INNER_LABEL(sev_ap_park_paging_off, SYM_L_GLOBAL)
> =

> Global symbol but used only in this file. .L-prefix then?

It needs to be a global symbol so the pa_ variant can be generated.

Regards,

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
