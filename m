Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B1AC41513
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 09:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 221B042156;
	Thu, 19 Oct 2023 09:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 221B042156
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=uzf8nm/k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zPBZ9e0BhN_E; Thu, 19 Oct 2023 09:15:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B65C4214B;
	Thu, 19 Oct 2023 09:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B65C4214B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BAF4C0039;
	Thu, 19 Oct 2023 09:15:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33CF2C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FBD183B80
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FBD183B80
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=uzf8nm/k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4Pr49X5FfIi
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:26 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 46DA883B7E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 09:15:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46DA883B7E
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 613971FD8C;
 Thu, 19 Oct 2023 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1697706923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E3yro6bOZUqvaCMDNWEbvLZF+xxJcY0szaQQ5wMVbyY=;
 b=uzf8nm/kDJ+Ijp17n13oFoIE7j/nvomj+PI1AhcOSTPUbSVZB89yeloWUG9gW0czwezlEX
 Rmd8qHGjSKbfyJKkmfywo27aazWr0Ly2hKZGaUp6TKwLU8xPn/2nSVgclz2877RCOeXbFE
 RcaJPPTgbJXdypAZiks/+uDe5klZpeo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2359139C2;
 Thu, 19 Oct 2023 09:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fnsqMarzMGWwVAAAMHmgww
 (envelope-from <jgross@suse.com>); Thu, 19 Oct 2023 09:15:22 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH v3 0/5] x86/paravirt: Get rid of paravirt patching
Date: Thu, 19 Oct 2023 11:15:15 +0200
Message-Id: <20231019091520.14540-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[18];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Cc: Juergen Gross <jgross@suse.com>, Wanpeng Li <wanpengli@tencent.com>,
 Alexey Makhalov <amakhalov@vmware.com>, xen-devel@lists.xenproject.org,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ajay Kaher <akaher@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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
From: Juergen Gross via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This is a small series getting rid of paravirt patching by switching
completely to alternative patching for the same functionality.

The basic idea is to add the capability to switch from indirect to
direct calls via a special alternative patching option.

This removes _some_ of the paravirt macro maze, but most of it needs
to stay due to the need of hiding the call instructions from the
compiler in order to avoid needless register save/restore.

What is going away is the nasty stacking of alternative and paravirt
patching and (of course) the special .parainstructions linker section.

I have tested the series on bare metal and as Xen PV domain to still
work.

Note that objtool might need some changes to cope with the new
indirect call patching mechanism. Additionally some paravirt handling
can probably be removed from it.

Changes in V3:
- split v2 patch 3 into 2 patches as requested by Peter and Ingo

Changes in V2:
- split last patch into 2
- rebase of patch 2 as suggested by Peter
- addressed Peter's comments for patch 3

Juergen Gross (5):
  x86/paravirt: move some functions and defines to alternative
  x86/alternative: add indirect call patching
  x86/paravirt: introduce ALT_NOT_XEN
  x86/paravirt: switch mixed paravirt/alternative calls to alternative_2
  x86/paravirt: remove no longer needed paravirt patching code

 arch/x86/include/asm/alternative.h        |  26 ++++-
 arch/x86/include/asm/paravirt.h           |  79 +++++----------
 arch/x86/include/asm/paravirt_types.h     |  73 +++-----------
 arch/x86/include/asm/qspinlock_paravirt.h |   4 +-
 arch/x86/include/asm/text-patching.h      |  12 ---
 arch/x86/kernel/alternative.c             | 116 ++++++++++------------
 arch/x86/kernel/callthunks.c              |  17 ++--
 arch/x86/kernel/kvm.c                     |   4 +-
 arch/x86/kernel/module.c                  |  20 +---
 arch/x86/kernel/paravirt.c                |  54 ++--------
 arch/x86/kernel/vmlinux.lds.S             |  13 ---
 arch/x86/tools/relocs.c                   |   2 +-
 arch/x86/xen/irq.c                        |   2 +-
 13 files changed, 137 insertions(+), 285 deletions(-)

-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
