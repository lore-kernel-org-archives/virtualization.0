Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADE3C433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 17:00:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F3460F58
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 17:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8F3460F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90B564038A;
	Tue,  2 Nov 2021 17:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZi8_X0-wZfQ; Tue,  2 Nov 2021 17:00:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47C264036A;
	Tue,  2 Nov 2021 17:00:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ED10C0012;
	Tue,  2 Nov 2021 17:00:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C36AAC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 17:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D5E540122
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 17:00:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="LN+ZU9zV";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="ja6aDrNj"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TikUkwC81mMJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 17:00:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C23B4400E8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 17:00:26 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F12D22191E;
 Tue,  2 Nov 2021 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635872424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnCsQ7BN32L02J/65RauwbZm1QvjnZr+v+hxhCe8MxI=;
 b=LN+ZU9zVSkG+f0o1YeJTC9q80r9sNYe6LxDrXS7XF8DzJ53ODTemD9FbGpNEHMy+hyDNXE
 hdCigzNumqte3Rcc9+thzX+rrlZxhUHNqmkECg5/UMzrWtj7pGm1s+8O7g8aXdyMZf7HDq
 BtYnASAc7IuY5Caj6S3VgneFfyq5XBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635872424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnCsQ7BN32L02J/65RauwbZm1QvjnZr+v+hxhCe8MxI=;
 b=ja6aDrNj7Fh4aeiNIcEUe8KPzSQl+xaRPWbSKjWn8xpSUgSP3K6SrDUs+ZMp4zP3RFNhuJ
 g7inhpvxt12rZPCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0963513E74;
 Tue,  2 Nov 2021 17:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OXF4AKdugWFDfQAAMHmgww
 (envelope-from <jroedel@suse.de>); Tue, 02 Nov 2021 17:00:23 +0000
Date: Tue, 2 Nov 2021 18:00:21 +0100
From: Joerg Roedel <jroedel@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 01/12] kexec: Allow architecture code to opt-out at
 runtime
Message-ID: <YYFupTJjUljpuZgL@suse.de>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-2-joro@8bytes.org> <YYARccITlowHABg1@zn.tnic>
 <87pmrjbmy9.fsf@disp2133>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87pmrjbmy9.fsf@disp2133>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, Borislav Petkov <bp@alien8.de>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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

Hi again,

On Mon, Nov 01, 2021 at 04:11:42PM -0500, Eric W. Biederman wrote:
> I seem to remember the consensus when this was reviewed that it was
> unnecessary and there is already support for doing something like
> this at a more fine grained level so we don't need a new kexec hook.

Forgot to state to problem again which these patches solve:

Currently a Linux kernel running as an SEV-ES guest has no way to
successfully kexec into a new kernel. The normal SIPI sequence to reset
the non-boot VCPUs does not work in SEV-ES guests and special code is
needed in Linux to safely hand over the VCPUs from one kernel to the
next. What happens currently is that the kexec'ed kernel will just hang.

The code which implements the VCPU hand-over is also included in this
patch-set, but it requires a certain level of Hypervisor support which
is not available everywhere.

To make it clear to the user that kexec will not work in their
environment, it is best to disable the respected syscalls. This is what
the hook is needed for.

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
