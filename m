Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D5AC4332F
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 15:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 447C840128;
	Wed,  4 May 2022 15:57:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srEa2tOu25Ap; Wed,  4 May 2022 15:57:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BFB1840143;
	Wed,  4 May 2022 15:57:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2FC5C007F;
	Wed,  4 May 2022 15:57:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86AF4C007E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61B8F4023E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yr9sOiB9LvTU
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:57:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1083140222
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:57:09 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A53991F74B;
 Wed,  4 May 2022 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1651679826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hG7emcEGn0sS81RKfZEcY3mzY1AE7PXlwENEP7suGv0=;
 b=g4wY94mvZyO+V+p1H2CBHhX6rOIEgjn6VJaUzqhOuZaZX7Z5w3dZMNr2IaH2+kGxfqve9X
 r9KOXvqVpM9FnKRs3k6i4MC+Iqp/CQTkqEI1FyzTVZqXo58XoBlTfaY4/FeC40jLvdkqw2
 cmdfELH/dDTQoTEyFXNI3PahwVKzzWM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04953132C4;
 Wed,  4 May 2022 15:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XfVKO1GicmLWPAAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 04 May 2022 15:57:05 +0000
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v3 0/2] kernel: add new infrastructure for platform_has()
 support
Date: Wed,  4 May 2022 17:57:01 +0200
Message-Id: <20220504155703.13336-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Sven Schnelle <svens@linux.ibm.com>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
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
 arch/x86/mm/mem_encrypt.c              |  7 -------
 arch/x86/mm/mem_encrypt_amd.c          |  4 ++++
 drivers/virtio/Kconfig                 |  6 ------
 drivers/virtio/virtio.c                |  5 ++---
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/platform-feature.h |  8 ++++++++
 include/linux/platform-feature.h       | 19 ++++++++++++++++++
 include/linux/virtio_config.h          |  9 ---------
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 ++++++++++++++++++++++++++
 14 files changed, 73 insertions(+), 38 deletions(-)
 create mode 100644 include/asm-generic/platform-feature.h
 create mode 100644 include/linux/platform-feature.h
 create mode 100644 kernel/platform-feature.c

-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
