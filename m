Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E41CCA47A
	for <virtualization@archiver.kernel.org>; Wed, 22 Jun 2022 06:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 318F884655;
	Wed, 22 Jun 2022 06:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 318F884655
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=F2GAX4tg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csRY8lPH8-k3; Wed, 22 Jun 2022 06:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6131845D0;
	Wed, 22 Jun 2022 06:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6131845D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8121AC0039;
	Wed, 22 Jun 2022 06:38:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7E13C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 06:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2119584640
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 06:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2119584640
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0SGS8HgLaQad
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 06:38:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AD9A845D0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1AD9A845D0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 06:38:44 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E416D1FA12;
 Wed, 22 Jun 2022 06:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1655879922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QMRrUcaW7noQ1pULOfC6DTDxjpRydqT5qx5KdCmqN2s=;
 b=F2GAX4tgcaaJK09IKfBFeDbtHvOq+IkDEU7l7PrA3RhoibYo+uttdFz2t+qPZAaQOwDw3A
 fHEDcSKePj6ww5nUqqNiqcxwleIRpxn45rgsUtNEvK5o15XMISBUcJfW8fMTMeto1TiYz1
 6avqbbonITmQT2qBICWookqie0msOhY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31A45134A9;
 Wed, 22 Jun 2022 06:38:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gMq2CvK4smKNUAAAMHmgww
 (envelope-from <jgross@suse.com>); Wed, 22 Jun 2022 06:38:42 +0000
To: xen-devel@lists.xenproject.org, x86@kernel.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-arch@vger.kernel.org
Subject: [PATCH v3 0/3] virtio: support requiring restricted access per device
Date: Wed, 22 Jun 2022 08:38:35 +0200
Message-Id: <20220622063838.8854-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Vasily Gorbik <gor@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Russell King <linux@armlinux.org.uk>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
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

Instead of an all or nothing approach add support for requiring
restricted memory access per device.

Changes in V3:
- new patches 1 + 2
- basically complete rework of patch 3

Juergen Gross (3):
  virtio: replace restricted mem access flag with callback
  kernel: remove platform_has() infrastructure
  xen: don't require virtio with grants for non-PV guests

 MAINTAINERS                            |  8 --------
 arch/arm/xen/enlighten.c               |  4 +++-
 arch/s390/mm/init.c                    |  4 ++--
 arch/x86/mm/mem_encrypt_amd.c          |  4 ++--
 arch/x86/xen/enlighten_hvm.c           |  4 +++-
 arch/x86/xen/enlighten_pv.c            |  5 ++++-
 drivers/virtio/Kconfig                 |  4 ++++
 drivers/virtio/Makefile                |  1 +
 drivers/virtio/virtio.c                |  4 ++--
 drivers/virtio/virtio_anchor.c         | 18 +++++++++++++++++
 drivers/xen/Kconfig                    |  9 +++++++++
 drivers/xen/grant-dma-ops.c            | 10 ++++++++++
 include/asm-generic/Kbuild             |  1 -
 include/asm-generic/platform-feature.h |  8 --------
 include/linux/platform-feature.h       | 19 ------------------
 include/linux/virtio_anchor.h          | 19 ++++++++++++++++++
 include/xen/xen-ops.h                  |  6 ++++++
 include/xen/xen.h                      |  8 --------
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 --------------------------
 20 files changed, 84 insertions(+), 81 deletions(-)
 create mode 100644 drivers/virtio/virtio_anchor.c
 delete mode 100644 include/asm-generic/platform-feature.h
 delete mode 100644 include/linux/platform-feature.h
 create mode 100644 include/linux/virtio_anchor.h
 delete mode 100644 kernel/platform-feature.c

-- 
2.35.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
