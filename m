Return-Path: <SRS0=i4sF=I4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B4DC433E0
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 12:59:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389E760200
	for <virtualization@archiver.kernel.org>; Tue, 30 Mar 2021 12:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389E760200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 010FE402C0;
	Tue, 30 Mar 2021 12:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AjavmmWimUeG; Tue, 30 Mar 2021 12:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BA034031D;
	Tue, 30 Mar 2021 12:59:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9E48C0015;
	Tue, 30 Mar 2021 12:58:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34539C000A;
 Tue, 30 Mar 2021 12:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22BA960782;
 Tue, 30 Mar 2021 12:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c4ONfP-DfkjF; Tue, 30 Mar 2021 12:58:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B5356074D;
 Tue, 30 Mar 2021 12:58:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB5160200;
 Tue, 30 Mar 2021 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617109137;
 bh=XD13IlVE5uT31vxwz23Jmf3sYXSwPZBETQyhziZVg1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o5qO9v1/5yE7DNsd35X75e1Llwq33tg4kigypRa3ZhYgV00jzvR9GlwBCVFsbNk0v
 oMnKd3KVAbRmQ1sjqyQ92YOZncHMmpKCLiTh4dPeiztw7uFlbD1bJ05GHujP9ADwJh
 6ZdZRkEYDQ60hyfQYFS0uVB/yMEOtRvgq9X3SLO1pV+/bJJYUFfoLZAvysDjxUL3D8
 S9JfwoBK5zGUZ0DMA6urCc6Z+xnlM/C3/f7EhVPixFnTWgP93un8Lru5r6WBRTfU9d
 K13Y0M6X1NZ37mnWnoGFNOuQLte4Qkf53UBYgWPq/EeMtt2wYORmDVKx07mNQTLBYB
 NswLspENY0LWg==
Date: Tue, 30 Mar 2021 13:58:51 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/18] iommu: remove DOMAIN_ATTR_PAGING
Message-ID: <20210330125851.GL5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-13-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-13-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Joerg Roedel <joro@8bytes.org>,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>
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

On Tue, Mar 16, 2021 at 04:38:18PM +0100, Christoph Hellwig wrote:
> DOMAIN_ATTR_PAGING is never used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/iommu.c | 5 -----
>  include/linux/iommu.h | 1 -
>  2 files changed, 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
