Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB03BC433F5
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 07:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48A748411B;
	Fri, 15 Apr 2022 07:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8iAkV2ND8t8y; Fri, 15 Apr 2022 07:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A4C684102;
	Fri, 15 Apr 2022 07:41:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1008C0033;
	Fri, 15 Apr 2022 07:41:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60545C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 07:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3856840126
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 07:41:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YLve3QsV_w29
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 07:41:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B824C40103
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xanSGgJ3nmtzvbbdp9vVuGDNU57I0ihEAXyIecrf4bA=; b=lps71QQUamaHvR3jlBRw+n3uyM
 JFgM5Skqngi7JHyRil4qKMmAEM5LFTvcWctJCRRUKTHITWjByEaRjFXlI1QFwKwfDznzrnq/lmskY
 ehCLULfMu+QaORULxHxFRPom6cawrtOvL6VeWCdLRS1vsaXUEDq/mTvEhVnvx0flpxmqzBiwKSAX3
 LmQI65ZSeNYRW47jHR4TI91hvxdPBP9a+ni/rg4MKnyPzCdRkLG2CLrX55JwN8keJFvMvbjNu1uEU
 DrvFdR6Ne1c+TOm7uYaONr2V++soK+q3+FnvCW2LW7BjSo6SkR3egrhx72Jv82FoBDGRaXaU2ABV7
 CtfGLRrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nfGaG-009Cis-7P; Fri, 15 Apr 2022 07:41:36 +0000
Date: Fri, 15 Apr 2022 00:41:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [RFC PATCH 0/6] virtio: Solution to restrict memory access under
 Xen using xen-virtio DMA ops layer
Message-ID: <YlkhsH4zqly/BykB@infradead.org>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649963973-22879-1-git-send-email-olekstysh@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Juergen Gross <jgross@suse.com>, Kaly Xin <Kaly.Xin@arm.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Wei Chen <Wei.Chen@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Henry Wang <Henry.Wang@arm.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jiamei Xie <Jiamei.Xie@arm.com>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Bertrand Marquis <bertrand.marquis@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

I can only see three out of 6 patches on the linux-arm-kernel list,
which makes reviewing this impossible.  Also please Cc me directly
on any series doing crazy things with dma ops.  Thanks!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
