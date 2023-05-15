Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E13C77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 11:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01502404C9;
	Mon, 15 May 2023 11:51:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01502404C9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IkBBAEfM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clarCRJagRWf; Mon, 15 May 2023 11:51:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F35040127;
	Mon, 15 May 2023 11:51:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F35040127
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C765C0036;
	Mon, 15 May 2023 11:51:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC9DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1839D41E17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1839D41E17
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IkBBAEfM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5RL-0LkxkvZa
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFD6341E0E
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFD6341E0E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=PuPfI1ULNn6nKdgBOgNMBtEbGf2urZOQinv9le4S0tg=; b=IkBBAEfMBi3BnwkUH9a+d6WFrp
 IAP6BVB6s9Sl8NqTDNcoPch40oFg+Og/x7m6XkOUE72+xSzl5ZlI98459I4E/du347IDxCTnReoyr
 2oONv2hE1I3etOOnCSY2vH9ouRwvUXHVKKVE+lKyCxDJ7gkQCHtKzqlDKNWUmE1Pr4uvdovJE5O8U
 aFKw5WRtbNE+EPp9q4TeTUEoP0voDGcBEZNG9WfWZqArILRyyFm3+03au5ftDUPZXH3r+YWAxP/6I
 F2qrkp8eHjEgXrfMbulzU3v+q/5Tn/XUKFTFaEw9mWhCAMnwjbBu1x/P/5q4Wok0/BQJDjF1eLR8M
 Iv7zwhgA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pyWis-0022I3-1r; Mon, 15 May 2023 11:50:38 +0000
Date: Mon, 15 May 2023 04:50:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH v5 5/6] mm/gup: remove vmas parameter from pin_user_pages()
Message-ID: <ZGIcjr2I5FDDKdCZ@infradead.org>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <acd4a8c735c9bc1c736e1a52a9a036db5cc7d462.1684097002.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acd4a8c735c9bc1c736e1a52a9a036db5cc7d462.1684097002.git.lstoakes@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Nelson Escobar <neescoba@cisco.com>, kvm@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Eric Dumazet <edumazet@google.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Leon Romanovsky <leon@kernel.org>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bernard Metzler <bmt@zurich.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Nicholas Piggin <npiggin@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, io-uring@vger.kernel.org,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Bjorn Topel <bjorn@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Pavel Begunkov <asml.silence@gmail.com>, Christian Benvenuti <benve@cisco.com>
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

On Sun, May 14, 2023 at 10:26:58PM +0100, Lorenzo Stoakes wrote:
> We are now in a position where no caller of pin_user_pages() requires the
> vmas parameter at all, so eliminate this parameter from the function and
> all callers.
> 
> This clears the way to removing the vmas parameter from GUP altogether.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com> (for qib)
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
