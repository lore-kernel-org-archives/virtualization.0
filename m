Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2466C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 15:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 581D183F10;
	Wed, 27 Apr 2022 15:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Cy2LAqDlWPV; Wed, 27 Apr 2022 15:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C3E7E83EDB;
	Wed, 27 Apr 2022 15:33:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 178ECC0084;
	Wed, 27 Apr 2022 15:33:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC6E8C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC9EA83ED6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0ZbMjHvSZ_3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0BFB83EBD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 15:33:41 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3656210DF;
 Wed, 27 Apr 2022 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1651073619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fVtXdWYhLenHSdj+T0ZdwLpRLd8WonOYcTgrNB+Z3jY=;
 b=Eat1kP2aBHsOlNBIKA1cGV2G+bvXpUau7r9w59sCbR2l7eYN2d7oC8FGmCXase93Nku7bV
 jiZIiZvcRKzblmi9I4rPSOEQOla1OYE2aMjFrhulRY4T6S3hLCVJ+42wSk8CohIluYieBJ
 uzRfCtdqBhKn+/2ondixZrhxHDO3cRg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF7661323E;
 Wed, 27 Apr 2022 15:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 790vOVJiaWIRFwAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 27 Apr 2022 15:33:38 +0000
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org,
 linux-s390@vger.kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/2] kernel: add new infrastructure for platform_has()
 support
Date: Wed, 27 Apr 2022 17:33:34 +0200
Message-Id: <20220427153336.11091-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Dexuan Cui <decui@microsoft.com>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>
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

In another patch series [1] the need has come up to have support for
a generic feature flag infrastructure.

This patch series is introducing that infrastructure and adds the first
use case.

I have decided to use a similar interface as the already known x86
cpu_has() function. As the new infrastructure is meant to be usable for
general and arch-specific feature flags, the flags are being spread
between a general bitmap and an arch specific one.

The bitmaps start all being zero, single features can be set or reset
at any time by using the related platform_[re]set_feature() functions.

The platform_has() function is using a simple test_bit() call for now,
further optimization might be added when needed.

[1]: https://lore.kernel.org/lkml/1650646263-22047-1-git-send-email-olekstysh@gmail.com/T/#t

Juergen Gross (2):
  kernel: add platform_has() infrastructure
  virtio: replace arch_has_restricted_virtio_memory_access()

 MAINTAINERS                            |  8 ++++++++
 arch/s390/Kconfig                      |  1 -
 arch/s390/mm/init.c                    | 13 +++----------
 arch/x86/Kconfig                       |  1 -
 arch/x86/kernel/cpu/mshyperv.c         |  5 ++++-
 arch/x86/mm/mem_encrypt.c              |  6 ------
 arch/x86/mm/mem_encrypt_amd.c          |  4 ++++
 drivers/virtio/Kconfig                 |  6 ------
 drivers/virtio/virtio.c                |  5 ++---
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/platform-feature.h |  8 ++++++++
 include/linux/platform-feature.h       | 16 +++++++++++++++
 include/linux/virtio_config.h          |  9 ---------
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 ++++++++++++++++++++++++++
 15 files changed, 74 insertions(+), 38 deletions(-)
 create mode 100644 include/asm-generic/platform-feature.h
 create mode 100644 include/linux/platform-feature.h
 create mode 100644 kernel/platform-feature.c

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
