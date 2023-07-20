Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213B7EB64DA
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 06:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A1E980FB8;
	Thu, 20 Jul 2023 06:56:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A1E980FB8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AqSaRvK0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UhOhsIRNte7Y; Thu, 20 Jul 2023 06:56:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 37BC880F53;
	Thu, 20 Jul 2023 06:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37BC880F53
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E024EC0071;
	Thu, 20 Jul 2023 06:56:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22925C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2E1D4167B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2E1D4167B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AqSaRvK0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7zpKz4uCc91U
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30460414E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:56:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30460414E5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/QvVdhn5LHQNczKlivYbrTWjk8x34Zhu2grRA8NWy1s=; b=AqSaRvK0xTUrt3RAYmXQVISJNF
 9fpaZHhtQPK35TmTHM694ZKj5Mv5poxHf93oJ0wgkHh9vLBM6+g1KSIeXewLheB1mOgC7VlpjYULy
 OvlGox3Oq14nNFTGcn0isyoM0WPWTGaQVLOrzdOm6pSFVOSEpCfiBLRWSO4jO1GbQcjynxdkCo93i
 yR/g+TI8On5I+zW8no3+K71NZa4w59b176DmSyltc+0/ThU+WkRawesYEqLP+5eV4uhwqs3KJ3UKZ
 Rts+zegC4dyjTWH1/eok0G1U2KYo4JmfP/UoVlQbBaIeUYf21p6UAElCJZjGMPd8ctG+UwzB2umo6
 Rpi5Kcuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qMN4S-009vVW-38; Thu, 20 Jul 2023 06:23:28 +0000
Date: Wed, 19 Jul 2023 23:23:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost v11 10/10] virtio_net: merge dma operation for one
 page
Message-ID: <ZLjS4D7urgIK1MxV@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-11-xuanzhuo@linux.alibaba.com>
 <CACGkMEtoiHXese1sNJELeidmFc6nFR8rE1aA8MooaEKKUSw_eg@mail.gmail.com>
 <1689231087.0744615-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEsf4+56veqem1HMWiqYhiW5LVw-1CbWX-cQSN6Z0zYMRQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
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

Hi Jason,

can you please resend your reply with proper quoting?  I had to give
up after multiple pages of scrolling without finding anything that
you added to the full quote.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
