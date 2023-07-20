Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B132BEB64DA
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 06:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43F124192B;
	Thu, 20 Jul 2023 06:57:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43F124192B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vB2sfpF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPAsEci7WuoB; Thu, 20 Jul 2023 06:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91291414E5;
	Thu, 20 Jul 2023 06:57:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91291414E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70F20C0071;
	Thu, 20 Jul 2023 06:57:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD4C9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:57:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AACB481464
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:57:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AACB481464
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vB2sfpF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gx5ISPNY-mj7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:57:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21E8D81431
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:57:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21E8D81431
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tpFZ9x/guiUwHSLCuwqhF00CriObkSLCrgFFWuig6CE=; b=vB2sfpF99Y6Hfs52IwYhy9ldql
 ERLNEp2xxsdUaVRoJT10S6gTAPE5tnR+qAB7f7VfX0oX3cOvJqF8fo6g4mLDnd2PfYTu5xml5wpBL
 iLd5oZCQhLBDRU1MM+/3xNT+ybh/tfavVoX8x9yRLTvtQCc0T+1YPbdWgG4AKB5pPD0xBiW5OseL1
 /zQX9OQWGDorBtGNe64ykoJ5nN5nJnCXu0CXEEpu3OJ0vh3QZeCmjqqBdd2u9lp80cpW9EWIXxZmy
 ZHJvBWVZHCkBYssiD6i2zCYMydZaLn0q9H/9vql01rlU702eUQirQH8MkQa+KhiTVGWXM1wZ3PRUf
 qcvSFVfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qMNbj-00A1hF-06; Thu, 20 Jul 2023 06:57:51 +0000
Date: Wed, 19 Jul 2023 23:57:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <ZLja73TJ1Ow19xdr@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1689835514.217712-8-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Jul 20, 2023 at 02:45:14PM +0800, Xuan Zhuo wrote:
>  virtqueue_dma_dev() return the device that working with the DMA APIs.
>  Then that can be used like other devices. So what is the problem.
> 
>  I always think the code path without the DMA APIs is the trouble for you.

Because we now have an API where the upper level drivers sometimes
see the dma device and sometimes not.  This will be abused and cause
trouble sooner than you can say "layering".
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
