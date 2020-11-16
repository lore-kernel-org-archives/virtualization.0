Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD2C6369E
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783BC2137B
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 15:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OVr7yeWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783BC2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 054CF870E4;
	Mon, 16 Nov 2020 15:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwE+Nd2jTtr7; Mon, 16 Nov 2020 15:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 49713870AD;
	Mon, 16 Nov 2020 15:23:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 121FBC0891;
	Mon, 16 Nov 2020 15:23:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 157CDC07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 15:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 081C68563A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 15:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rJqiWYzfZQ3n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 15:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 40A1B85585
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 15:23:13 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1605540191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hXDPxLHhf2Wu81S1L0YOGGDmDdav6QELXVfWLp0Wriw=;
 b=OVr7yeWC1WJ/1YNfjLfTDpzLFPM5irXSm+vTpdhhYWW0gyPttx4RWUmJDusvFHgGnUjA1f
 6B9Q3UEWCc9Hfdns2tdN/wn130OzGduOD18wLIaCKu3fqq2TgVhL4IToyZS54mNBwyfRQD
 XslVTZ7zthwQfSWOk5zXiuWG4F7uhpA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 30619AF37;
 Mon, 16 Nov 2020 15:23:11 +0000 (UTC)
To: xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [PATCH 0/4] x86/xen: do some paravirt cleanup
Date: Mon, 16 Nov 2020 16:22:57 +0100
Message-Id: <20201116152301.24558-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

Eliminate the usergs_sysret64 paravirt call completely and switch
the swapgs one to use ALTERNATIVE instead. This requires to fix the
IST based exception entries for Xen PV to use the same mechanism as
NMI and debug exception already do.

Juergen Gross (4):
  x86/xen: use specific Xen pv interrupt entry for MCE
  x86/xen: use specific Xen pv interrupt entry for DF
  x86/pv: switch SWAPGS to ALTERNATIVE
  x86/xen: drop USERGS_SYSRET64 paravirt call

 arch/x86/entry/entry_64.S             | 32 ++++++++++++---------------
 arch/x86/include/asm/idtentry.h       |  6 +++++
 arch/x86/include/asm/irqflags.h       | 26 +++++++---------------
 arch/x86/include/asm/paravirt.h       | 25 ---------------------
 arch/x86/include/asm/paravirt_types.h | 10 ---------
 arch/x86/kernel/asm-offsets_64.c      |  3 ---
 arch/x86/kernel/paravirt.c            |  6 +----
 arch/x86/kernel/paravirt_patch.c      |  7 ------
 arch/x86/xen/enlighten_pv.c           | 28 ++++++++++++++++++-----
 arch/x86/xen/xen-asm.S                | 24 ++------------------
 arch/x86/xen/xen-ops.h                |  2 --
 11 files changed, 53 insertions(+), 116 deletions(-)

-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
