Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1172C43334
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 08:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4330A830A7;
	Wed,  8 Jun 2022 08:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 78_Hh46EFgeQ; Wed,  8 Jun 2022 08:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF9B08300C;
	Wed,  8 Jun 2022 08:10:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE8B4C0039;
	Wed,  8 Jun 2022 08:10:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B606CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E80C418F0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:10:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VzEDmT_bLji3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:09:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84A86418DD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=QCgoXq5iyQhTALtdEeT03gus84
 /SZt2KmN/kbkkznD8mxt4fn0Z8dlxKGrNIU6z9Tq0FFIuAm+b+fcHh5xBPcmZW5rP48bfJx70ovz+
 Td2Iggqp6r0UTr8qhNb83MALf8XIIi8vGd7tH+ajIGkQrUqXnmE5Gxa/sozhjuge09+X0FHB+kxfZ
 h+w8V1KO/i9H0jFi+rQYS8ZfFcWqM0iUavuBA48bsfJEc1Ac2u26IYQVsTEogpcES4L2lZaukHbs9
 tV6tFilWwqfJzX1XIwt3St+XZlrqYsXtxhfaE6WvS2uxDP092sWqRNdEPUfjUj7dTfeGSyFCuMdre
 T1EzGpuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyqlC-00Bppr-Jn; Wed, 08 Jun 2022 08:09:50 +0000
Date: Wed, 8 Jun 2022 01:09:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 01/20] fs: Add aops->migrate_folio
Message-ID: <YqBZTpzF/B6kduqm@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
