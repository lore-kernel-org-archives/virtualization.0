Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2E0EDEC46
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 11:44:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6D2C418B6;
	Wed, 13 Sep 2023 11:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6D2C418B6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=sUXrGqZZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ZlEFbOV47MP; Wed, 13 Sep 2023 11:44:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC4E4418BB;
	Wed, 13 Sep 2023 11:44:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC4E4418BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8885DC0071;
	Wed, 13 Sep 2023 11:44:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E599FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 11:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2D3560A65
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 11:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B2D3560A65
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=sUXrGqZZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mpTm4jpYhgs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 11:44:37 +0000 (UTC)
X-Greylist: delayed 363 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 13 Sep 2023 11:44:36 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8B0B60A62
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8B0B60A62
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 11:44:36 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B28341F385;
 Wed, 13 Sep 2023 11:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1694605110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uJxCMUIT09a7qNSpE55xAHMI/oO/Stvr6RHMZiPfub0=;
 b=sUXrGqZZOoVIQv+OGxhDBecrjHjH49ZzQmiR8HgriyCUNOyvY51cp4MNfw9H1W6dCN5PWU
 nlskKpBvJv3CbZBLqFWxt7NaFEeKD7XRZUMlyWluXouJQXkXs4bbOOzvEQlLkhJAKeb+KB
 zwEY9BZ/BObVZJyxnDHCZXPPTtSlHnI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36BE613582;
 Wed, 13 Sep 2023 11:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L4D9CzafAWVVCwAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 13 Sep 2023 11:38:30 +0000
To: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/3] xen: cleanup and fix lazy mode handling
Date: Wed, 13 Sep 2023 13:38:25 +0200
Message-Id: <20230913113828.18421-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Ajay Kaher <akaher@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alexey Makhalov <amakhalov@vmware.com>, xen-devel@lists.xenproject.org,
 Thomas Gleixner <tglx@linutronix.de>,
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

This small series is cleaning up Xen lazy mode handling by removing
unused stuff and moving purely Xen-specific code away from general
kernel code.

The last patch is fixing a regression which was introduced in the
6.6 merge window.

Juergen Gross (3):
  arm/xen: remove lazy mode related definitions
  x86/xen: move paravirt lazy code
  x86/xen: allow nesting of same lazy mode

 arch/x86/include/asm/paravirt_types.h | 15 ------
 arch/x86/include/asm/xen/hypervisor.h | 37 +++++++++++++++
 arch/x86/kernel/paravirt.c            | 67 ---------------------------
 arch/x86/xen/enlighten_pv.c           | 40 +++++++++++++---
 arch/x86/xen/mmu_pv.c                 | 55 ++++++++++++++--------
 arch/x86/xen/multicalls.h             |  4 +-
 include/trace/events/xen.h            | 12 ++---
 include/xen/arm/hypervisor.h          | 12 -----
 8 files changed, 114 insertions(+), 128 deletions(-)

-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
