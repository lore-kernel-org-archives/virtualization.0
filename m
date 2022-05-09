Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6BFC433EF
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 12:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 205A760E88;
	Mon,  9 May 2022 12:00:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlLupqp9fyiq; Mon,  9 May 2022 12:00:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA10E60F34;
	Mon,  9 May 2022 12:00:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96623C0032;
	Mon,  9 May 2022 12:00:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7FC1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7485481C6F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N6Z1NsGCxLdH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:00:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BED5381CFE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 12:00:06 +0000 (UTC)
Received: from [127.0.0.1] (unknown [46.183.103.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56BFE1EC0529;
 Mon,  9 May 2022 13:59:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1652097600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZ0FUxK106JbsF1xbRYLQqCEry+KRNYRswr1LpAp2pE=;
 b=VxzKXdJGegayDkmVXDvQFwrNls2RPi2YfuiEOm93VxrDV7gOSr5Sr6E2eqQXUDudljUWm2
 naM86eaoC/NmDPrzV3lyAs+o3FssqBbS9HxGYrGrmlxM95YCGfpfObKvrMb/fxKltUycds
 KZlVEiMd3cmC5Uyz/n2jiE3kMh2rc2M=
Date: Mon, 09 May 2022 11:59:49 +0000
From: Boris Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/2=5D_virtio=3A_replace_arc?=
 =?US-ASCII?Q?h=5Fhas=5Frestricted=5Fvirtio=5Fmemory=5Faccess=28=29?=
In-Reply-To: <20220504155703.13336-3-jgross@suse.com>
References: <20220504155703.13336-1-jgross@suse.com>
 <20220504155703.13336-3-jgross@suse.com>
Message-ID: <1376936D-E067-430C-A02D-565959F83BE0@alien8.de>
MIME-Version: 1.0
Cc: Oleksandr Tyshchenko <olekstysh@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Vasily Gorbik <gor@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On May 4, 2022 3:57:03 PM UTC, Juergen Gross <jgross@suse.com> wrote:
>Instead of using arch_has_restricted_virtio_memory_access() together
>with CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, replace those
>with platform_has() and a new platform feature
>PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS.
>
>Signed-off-by: Juergen Gross <jgross@suse.com>
>---
>V2:
>- move setting of PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS in SEV case
>  to sev_setup_arch().
>V3:
>- remove Hyper-V chunk (Michael Kelley)
>- remove include virtio_config.h from mem_encrypt.c (Oleksandr Tyshchenko)
>- add comment for PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS (Oleksandr Tyshchenko)
>---
> arch/s390/Kconfig                |  1 -
> arch/s390/mm/init.c              | 13 +++----------
> arch/x86/Kconfig                 |  1 -
> arch/x86/mm/mem_encrypt.c        |  7 -------
> arch/x86/mm/mem_encrypt_amd.c    |  4 ++++
> drivers/virtio/Kconfig           |  6 ------
> drivers/virtio/virtio.c          |  5 ++---
> include/linux/platform-feature.h |  6 +++++-
> include/linux/virtio_config.h    |  9 ---------
> 9 files changed, 14 insertions(+), 38 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>
-- 
Sent from a device which is ok for reading mail but awful for writing. Please excuse any shortcomings.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
