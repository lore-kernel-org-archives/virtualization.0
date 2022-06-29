Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8545BC43334
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 00:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDA9440598;
	Wed, 29 Jun 2022 00:58:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDA9440598
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hiakdTfX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NKhXGq6qUb7I; Wed, 29 Jun 2022 00:58:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 384E9405A6;
	Wed, 29 Jun 2022 00:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 384E9405A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D52D0C0039;
	Wed, 29 Jun 2022 00:58:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C853EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C57F827CE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C57F827CE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hiakdTfX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ihg80GiOwqi7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:58:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8208D827CA
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8208D827CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 00:58:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2F3B261AFE;
 Wed, 29 Jun 2022 00:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E470C341C8;
 Wed, 29 Jun 2022 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656464299;
 bh=qzXzyU3Yxwkc5XoKYIl4dSB/mDLg7UqRnK4AC6snhZQ=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=hiakdTfXzYVHnt8rotaaK4/4vf9Jm1h+sYAUrz+zMLPSM5E4rWUFyo8rGX5PESKLl
 SY2grO9EbqiR2Nh8X1DlSWeFnUzx1cg+HuylAwTsj3sr/+ORIBdOpNsXMOnWmuN6ka
 e2KJOMM1+ScuOsUPDAC1TZ/o0/sRKF5JLy0VULpTw8abuMurRFrQ2sdxT5B5uo3PDr
 DXaHPlaEBpEPp5jGAs1Zib5nV/ajkGe5CzC/WOwT8Mrm5V0CYmaFpYEomoQw4Cf14U
 D6FpTXAQNTrIUIZxZWmpBkwKNqx6a/kMQOdKaXi3gnqvGIHJkYKlz1LMjrtMKpRGng
 Lgc0rh6qy+uLA==
Date: Tue, 28 Jun 2022 17:58:17 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 0/3] virtio: support requiring restricted access per
 device
In-Reply-To: <20220622063838.8854-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2206281758050.4389@ubuntu-linux-20-04-desktop>
References: <20220622063838.8854-1-jgross@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 22 Jun 2022, Juergen Gross wrote:
> Instead of an all or nothing approach add support for requiring
> restricted memory access per device.
> 
> Changes in V3:
> - new patches 1 + 2
> - basically complete rework of patch 3
> 
> Juergen Gross (3):
>   virtio: replace restricted mem access flag with callback
>   kernel: remove platform_has() infrastructure
>   xen: don't require virtio with grants for non-PV guests


On the whole series:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


>  MAINTAINERS                            |  8 --------
>  arch/arm/xen/enlighten.c               |  4 +++-
>  arch/s390/mm/init.c                    |  4 ++--
>  arch/x86/mm/mem_encrypt_amd.c          |  4 ++--
>  arch/x86/xen/enlighten_hvm.c           |  4 +++-
>  arch/x86/xen/enlighten_pv.c            |  5 ++++-
>  drivers/virtio/Kconfig                 |  4 ++++
>  drivers/virtio/Makefile                |  1 +
>  drivers/virtio/virtio.c                |  4 ++--
>  drivers/virtio/virtio_anchor.c         | 18 +++++++++++++++++
>  drivers/xen/Kconfig                    |  9 +++++++++
>  drivers/xen/grant-dma-ops.c            | 10 ++++++++++
>  include/asm-generic/Kbuild             |  1 -
>  include/asm-generic/platform-feature.h |  8 --------
>  include/linux/platform-feature.h       | 19 ------------------
>  include/linux/virtio_anchor.h          | 19 ++++++++++++++++++
>  include/xen/xen-ops.h                  |  6 ++++++
>  include/xen/xen.h                      |  8 --------
>  kernel/Makefile                        |  2 +-
>  kernel/platform-feature.c              | 27 --------------------------
>  20 files changed, 84 insertions(+), 81 deletions(-)
>  create mode 100644 drivers/virtio/virtio_anchor.c
>  delete mode 100644 include/asm-generic/platform-feature.h
>  delete mode 100644 include/linux/platform-feature.h
>  create mode 100644 include/linux/virtio_anchor.h
>  delete mode 100644 kernel/platform-feature.c
> 
> -- 
> 2.35.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
