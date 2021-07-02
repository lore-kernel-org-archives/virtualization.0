Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E54C11F69
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:48:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC38361413
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 11:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC38361413
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A483083DCE;
	Fri,  2 Jul 2021 11:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ez9TQFp0L3uv; Fri,  2 Jul 2021 11:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2622D83DBF;
	Fri,  2 Jul 2021 11:48:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECFECC0010;
	Fri,  2 Jul 2021 11:48:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79E25C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67F1E83DC5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C1ERCDAIzXpZ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C19383DBC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 11:48:50 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D11C62009A;
 Fri,  2 Jul 2021 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=98c5XVosXkxsEF5csivCrj46Eo5ocAf/SNIwP2m+geg=;
 b=oKBp+2dXgQNMp818q+YuiaUS7ky3obkmqy8deUnZzLTorhZlH6jMsrh9Qq/9VJSc/87TIj
 bLhfHyAK7GAiS6SNOAM9z3rPqNfgDBmTutRwfRAeKT6Ybv9jN6KO+WxaxegUTSeTgdfuKk
 GMithEI10iywo9d8M/Ogeg9D/m0VKT4=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 7B11911C84;
 Fri,  2 Jul 2021 11:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1625226527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=98c5XVosXkxsEF5csivCrj46Eo5ocAf/SNIwP2m+geg=;
 b=oKBp+2dXgQNMp818q+YuiaUS7ky3obkmqy8deUnZzLTorhZlH6jMsrh9Qq/9VJSc/87TIj
 bLhfHyAK7GAiS6SNOAM9z3rPqNfgDBmTutRwfRAeKT6Ybv9jN6KO+WxaxegUTSeTgdfuKk
 GMithEI10iywo9d8M/Ogeg9D/m0VKT4=
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 1NKMHB/93mDDDAAALh3uQQ
 (envelope-from <varad.gautam@suse.com>); Fri, 02 Jul 2021 11:48:47 +0000
To: kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [kvm-unit-tests PATCH 0/6] Initial x86_64 UEFI support
Date: Fri,  2 Jul 2021 13:48:14 +0200
Message-Id: <20210702114820.16712-1-varad.gautam@suse.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: thomas.lendacky@amd.com, drjones@redhat.com, jroedel@suse.de,
 brijesh.singh@amd.com, pbonzini@redhat.com, bp@suse.de
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
From: Varad Gautam via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Varad Gautam <varad.gautam@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

This series brings EFI support to a reduced subset of kvm-unit-tests
on x86_64. I'm sending it out for early review since it covers enough
ground to allow adding KVM testcases for EFI-only environments.

EFI support works by changing the test entrypoint to a stub entry
point for the EFI loader to jump to in long mode, where the test binary
exits EFI boot services, performs the remaining CPU bootstrapping,
and then calls the testcase main().

Since the EFI loader only understands PE objects, the first commit
introduces a `configure --efi` mode which builds each test as a shared
lib. This shared lib is repackaged into a PE via objdump.

Commit 2-4 take a trip from the asm entrypoint to C to exit EFI and
relocate ELF .dynamic contents.

Commit 5 adds post-EFI long mode x86_64 setup and calls the testcase.

Commit 6 patches out some broken tests for EFI. Testcases that refuse
to build as shared libs are also left disabled, these need some massaging.

git tree: https://github.com/varadgautam/kvm-unit-tests/commits/efi-stub

Varad Gautam (6):
  x86: Build tests as PE objects for the EFI loader
  x86: Call efi_main from _efi_pe_entry
  x86: efi_main: Get EFI memory map and exit boot services
  x86: efi_main: Self-relocate ELF .dynamic addresses
  cstart64.S: x86_64 bootstrapping after exiting EFI
  x86: Disable some breaking tests for EFI and modify vmexit test

 .gitignore          |   2 +
 Makefile            |  16 ++-
 configure           |  11 ++
 lib/linux/uefi.h    | 337 ++++++++++++++++++++++++++++++++++++++++++++
 x86/Makefile.common |  45 ++++--
 x86/Makefile.x86_64 |  43 +++---
 x86/cstart64.S      |  78 ++++++++++
 x86/efi.lds         |  67 +++++++++
 x86/efi_main.c      | 167 ++++++++++++++++++++++
 x86/vmexit.c        |   7 +
 10 files changed, 741 insertions(+), 32 deletions(-)
 create mode 100644 lib/linux/uefi.h
 create mode 100644 x86/efi.lds
 create mode 100644 x86/efi_main.c

-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
