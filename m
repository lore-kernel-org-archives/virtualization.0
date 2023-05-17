Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7786C77B7F
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 07:46:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AE476FE6F;
	Wed, 17 May 2023 07:46:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AE476FE6F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RqRDIbWT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBsK0mgPLrym; Wed, 17 May 2023 07:46:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E022B60EEF;
	Wed, 17 May 2023 07:46:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E022B60EEF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9A2EC0036;
	Wed, 17 May 2023 07:46:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE565C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B0C14208F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B0C14208F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RqRDIbWT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2dabJyvh0pUJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:46:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A503C42085
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A503C42085
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3af5s8KC0jpxinUkSVGtgdDvRiKlMHerb7s5Uk+tflw=; b=RqRDIbWTl+tBYvV2cZ6eAZpQL/
 bGnVgkBSlpXag2KRy0e5FJub/0mmw+xUEfh5ra/t0xUb9hSwGSN33s0vRyTtssvZi+YzO3P+fMG6h
 MtGw7Fggdfnw4n9dZJ+tXZm+Bbzo9P6npa7T732nj7pCM6W7D2LxJFIn9rlXQR1JduQeO0FgOJufy
 NQbOjC5moKKdA3B6i6RqJZh/fCyfHOAGz2BKyvTxvHly3bTALQFe9CPfVwMtPnF8PDWLWAT1LgXK1
 WkHQjpBXZlR8UTxhgrp4YzJprcZS5BRZ7YF/vJ9Gwp8gUGrjwc6vJjwp9WOHiP6RBfB0WJixCVszq
 mgWQungg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pzBrN-008izE-1K; Wed, 17 May 2023 07:46:09 +0000
Date: Wed, 17 May 2023 00:46:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <ZGSGQWqbtdwGXurf@infradead.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
 <ZGSEq197W8VvOWCc@infradead.org>
 <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9e4702f2-5473-2139-3858-ae58817bc7b5@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com
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

On Wed, May 17, 2023 at 03:43:03PM +0800, zhenwei pi wrote:
> I have a plan to introduce 'Virtio Over Fabrics'(TCP&RDMA) as Virtio
> transport, as mentioned in cover letter of this series:
> 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html

Just don't do it.  Please define your own protocols over RDMA or TCP
for exactly the operations you need (for many they will already exist)
instead of piggyg backing on virtio and making everyone else pay the
price.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
