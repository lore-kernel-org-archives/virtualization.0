Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F74FC77B73
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 04:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06B43408D4;
	Mon,  1 May 2023 04:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06B43408D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j/O1b7YA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4_EkCGYCi7lG; Mon,  1 May 2023 04:16:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73D6440134;
	Mon,  1 May 2023 04:16:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73D6440134
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5528FC0036;
	Mon,  1 May 2023 04:16:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E329C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:16:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46077408CA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:16:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46077408CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CxKx88Y0u6cd
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:16:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD22240134
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD22240134
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 04:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KYlatN3lOvUn0xnOEQguwWMLvINM1bo5DgY9EGUS/Bw=; b=j/O1b7YAti0705X9w6bDA/2IK3
 TlpZUwCZmwEkVWkw/81Nv3Z7ISgZa8KN4AZjK5nI/tS3DJ4zFtvszBzCwjg67WM4Oc/wfnDAelfyN
 UM4/oL+g6wWL8YkrEj9uCxAuO+a3KR0OtPBJtUgBBvgMt8c5vFrS2qXUstmoBMVZQkfS5jPwxP/pk
 g0iBvGi5xJ1zEpQBacQhyL4HPh4dLhjxqbot9BGMvZAOF4ZBqEnZfSmkrXiEaey0FdQZzCZ+NpLgi
 ysvS2oadw0agfWLvdq+1S/u8MHJ7nzxq6qup32RplZIhb8MpMhXyva+tkrPmJsY5HJsFHXfB8tUXk
 M8/ySh3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1ptKxX-00FDkO-0z; Mon, 01 May 2023 04:16:19 +0000
Date: Sun, 30 Apr 2023 21:16:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Message-ID: <ZE89E+qJgGPNUjT5@infradead.org>
References: <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <20230419094506.2658b73f@kernel.org>
 <ZEDZaitjcX+egzvf@infradead.org>
 <1681981908.9700203-3-xuanzhuo@linux.alibaba.com>
 <ZEFlzdiyu2IAyX7a@infradead.org>
 <20230425035259-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230425035259-mutt-send-email-mst@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Apr 25, 2023 at 04:12:05AM -0400, Michael S. Tsirkin wrote:
> In theory, absolutely. In practice modern virtio devices are ok,
> the reason we are stuck supporting old legacy ones is because legacy
> devices are needed to run old guests. And then people turn
> around and run a new guest on the same device,
> for example because they switch back and forth e.g.
> for data recovery? Or because whoever is selling the
> host wants to opt for maximum compatibility.
> 
> Teaching all of linux to sometimes use dma and sometimes not
> is a lot of work, and for limited benefit of these legacy systems.

It's not like virtio is the only case where blindly assuming
your can use DMA operations in a higher layer is the problem..
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
