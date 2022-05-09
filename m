Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D27C433F5
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 11:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B68860B20;
	Mon,  9 May 2022 11:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yi7X7Mjp_9RT; Mon,  9 May 2022 11:49:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD27660B06;
	Mon,  9 May 2022 11:49:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACEC4C0032;
	Mon,  9 May 2022 11:49:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D26EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C4224032D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ecfFyGS60Qb4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:48:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92603402EA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 11:48:55 +0000 (UTC)
Received: from [127.0.0.1] (unknown [46.183.103.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 601E71EC0529;
 Mon,  9 May 2022 13:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1652096927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBcNvdGojA+kgezS1jEjzLjyoytYIqi04DLdwTBilBk=;
 b=jS4tFDIHbr7C3Uu/RAAiy+WGqeZJHXRjw/EI6aNobbXRodJ0Tb4PfSNpoOHW+KbqVJeaHw
 cv0CqgBMT/MbupN4iHymfPvSKpYZkSx6O42ICf+XF0of+KIBHBQgjFpRjluZ0Nz7tlLUS1
 0hHrdCu2/GVq2VEhhdnUoA07R5Levug=
Date: Mon, 09 May 2022 13:48:44 +0200
From: Boris Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 1/2] kernel: add platform_has() infrastructure
User-Agent: K-9 Mail for Android
In-Reply-To: <20220504155703.13336-2-jgross@suse.com>
References: <20220504155703.13336-1-jgross@suse.com>
 <20220504155703.13336-2-jgross@suse.com>
Message-ID: <FBBBF0AE-05CD-4DE2-B656-C09C976600DA@alien8.de>
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



On May 4, 2022 5:57:02 PM GMT+02:00, Juergen Gross <jgross@suse.com> wrote:
>Add a simple infrastructure for setting, resetting and querying
>platform feature flags.
>
>Flags can be either global or architecture specific.
>
>Signed-off-by: Juergen Gross <jgross@suse.com>
>---
>V2:
>- rename set/reset functions to platform_[set|clear]() (Boris Petkov,
>  Heiko Carstens)
>- move function implementations to c file (Boris Petkov)
>---
> MAINTAINERS                            |  8 ++++++++
> include/asm-generic/Kbuild             |  1 +
> include/asm-generic/platform-feature.h |  8 ++++++++
> include/linux/platform-feature.h       | 15 ++++++++++++++
> kernel/Makefile                        |  2 +-
> kernel/platform-feature.c              | 27 ++++++++++++++++++++++++++
> 6 files changed, 60 insertions(+), 1 deletion(-)
> create mode 100644 include/asm-generic/platform-feature.h
> create mode 100644 include/linux/platform-feature.h
> create mode 100644 kernel/platform-feature.c

Nice and simple, I like.

Acked-by: Borislav Petkov <bp@suse.de>
-- 
Sent from a device which is good for reading mail but awful for writing. Please excuse any shortcomings.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
