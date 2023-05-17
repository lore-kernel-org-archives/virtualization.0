Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37F4C77B7F
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 07:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 280C0429D5;
	Wed, 17 May 2023 07:39:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 280C0429D5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j8Oc/5Af
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yy6KOiQMoqQJ; Wed, 17 May 2023 07:39:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B7F6340124;
	Wed, 17 May 2023 07:39:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7F6340124
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99069C0036;
	Wed, 17 May 2023 07:39:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC95C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F3FB41F0E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:39:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F3FB41F0E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j8Oc/5Af
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igH5KDTPoXvg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:39:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7EF6541F06
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7EF6541F06
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BXLZ+yEa82RxkW3QXxkSn4CuUde79k4TvT+xYUt2yR0=; b=j8Oc/5AfxoC4ZTxrm8OxtCPW89
 AGSE8ZI/sITlQVr3lH/MGL+wGFdkBbVkgxdzJ0SN09+8RXlto0WaU/tdqa9qfwmcFrq5nmSmhU5mA
 3xTrWuRO8IQ9rZFUFxzv9fP0H9fxAPQODjDNvWZd7oFhsZ5rTviRzIFpk1juA38sdWRID68YhEJUV
 W5ph04GCfXSLlEjH6FNTVeQs4+IBnLFqRmoQw4B9sH5DCtqTblh/k6m0y4PFLzxzJ2AE7Vbx3r1rx
 NRaLxkgtltk9/yf5rfYQGndxwT/GFIRF0jsjdpQqg5DVuXFd0jxfU5MgBmvT0o6T1rVAdVNxLkc+D
 Z4JmZD5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pzBkp-008hYG-1F; Wed, 17 May 2023 07:39:23 +0000
Date: Wed, 17 May 2023 00:39:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH v2 1/2] virtio: abstract virtqueue related methods
Message-ID: <ZGSEq197W8VvOWCc@infradead.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230517025424.601141-2-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230517025424.601141-2-pizhenwei@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Wed, May 17, 2023 at 10:54:23AM +0800, zhenwei pi wrote:
> All the vring based virtqueue methods could be abstratct in theory,
> MST suggested that add/get bufs and kick functions are quite perfmance
> sensitive, so export these functions from virtio_ring.ko, drivers
> still call them in a fast path.

Who is going to use this?  And why do you think every virtio users
would want to pay for indirect calls just for your shiny new feature?

This seems like an amazingly bad idea to me.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
