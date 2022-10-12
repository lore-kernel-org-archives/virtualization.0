Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FD4C4332F
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 06:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E467982AED;
	Wed, 12 Oct 2022 06:21:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E467982AED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=hi74EGX3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ww_MzxVjm01K; Wed, 12 Oct 2022 06:21:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 535A681C67;
	Wed, 12 Oct 2022 06:21:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 535A681C67
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 215DCC0033;
	Wed, 12 Oct 2022 06:21:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 482E3C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14D3E60BDC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:21:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14D3E60BDC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=hi74EGX3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id imLZygeXTSJN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:21:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 754C660AF4
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 754C660AF4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 06:21:35 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4MnMx31PJ1z4wgr;
 Wed, 12 Oct 2022 17:21:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1665555688;
 bh=YzBdtZALMPvevfqLcejSWQcfLQIXVl+Gp0Tn+SPwIqc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hi74EGX3EywL/sADHCKfoPX61U5045pExe4Gpp8z3AbtcA/xv5uAJ6K95LyJ2pWlW
 jkcHE9uN3Nt0MjBgwmLihG8oM7P9FDR3geA8ZOadOMK0o5xep22cTFe8GP7XMQA/NL
 JyHAfz3zsqV5g4QmKSX0bx2Vm4GeuhuW7ONzdTmyVbXqjeW4Ur8YzNCn0sPagdL5eu
 5xnEM6372wNMxbuX0kvDTD5dJC0zkyRW1gMVbDOQTjaVEdd+VprV0C0DMBWXeQPgT0
 SlNvjimItgAL6+wEIx+/ViUGDEpj1ty2GS+dgdkjy3Qt5JJBH8WiTLUdIBbCn8MdX7
 cRZBm1/NS/Mvw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [GIT PULL] virtio: fixes, features
In-Reply-To: <20221010132030-mutt-send-email-mst@kernel.org>
References: <20221010132030-mutt-send-email-mst@kernel.org>
Date: Wed, 12 Oct 2022 17:21:24 +1100
Message-ID: <87r0zdmujf.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, wangdeming@inspur.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>, angus.chen@jaguarmicro.com,
 lingshan.zhu@intel.com, linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:
> The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:
>
>   Linux 6.0 (2022-10-02 14:09:07 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
>
> for you to fetch changes up to 71491c54eafa318fdd24a1f26a1c82b28e1ac21d:
>
>   virtio_pci: don't try to use intxif pin is zero (2022-10-07 20:00:44 -0400)
>
> ----------------------------------------------------------------
> virtio: fixes, features
>
> 9k mtu perf improvements
> vdpa feature provisioning
> virtio blk SECURE ERASE support
>
> Fixes, cleanups all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Alvaro Karsz (1):
>       virtio_blk: add SECURE ERASE command support
>
> Angus Chen (1):
>       virtio_pci: don't try to use intxif pin is zero

This commit breaks virtio_pci for me on powerpc, when running as a qemu
guest.

vp_find_vqs() bails out because pci_dev->pin == 0.

But pci_dev->irq is populated correctly, so vp_find_vqs_intx() would
succeed if we called it - which is what the code used to do.

I think this happens because pci_dev->pin is not populated in
pci_assign_irq().

I would absolutely believe this is bug in our PCI code, but I think it
may also affect other platforms that use of_irq_parse_and_map_pci().

cheers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
