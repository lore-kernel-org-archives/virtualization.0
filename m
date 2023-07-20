Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AEDEB64DA
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 06:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B813E4023F;
	Thu, 20 Jul 2023 06:55:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B813E4023F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sKkUTSTA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EGL4YfyGoCI6; Thu, 20 Jul 2023 06:55:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B454740198;
	Thu, 20 Jul 2023 06:55:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B454740198
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74576C0071;
	Thu, 20 Jul 2023 06:55:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBFC7C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92CCD4023F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:55:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 92CCD4023F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cQ5d-ywt59Pl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:55:19 +0000 (UTC)
X-Greylist: delayed 1986 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Jul 2023 06:55:19 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2989540198
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2989540198
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kMyO5VD0QAGAGdxVmS5onT7pkpxirlZJoxTfWvPS+OI=; b=sKkUTSTAGrySRXrA7yJnSEeKU7
 pwTIPGGAM1fhU3lfi24JND0R05d6AoG9FkgOvASImWO3PiCLUKCsYdeRst/q3uzkblGx7dfPvF8GG
 mxtrpUrzJ9Hqxvp2KVT38+vOXonST6DJ+/o58XnKEDq4UHwfGK9XsHL9GB3HryJdFzxtVwjzy9Q6W
 uh5Fyu96H8RIuNcwpRN1yWf6ywBSNpTC26cezL6zyHH2/G6Ok12ySrRbe2AaXFxgc88i+S3X8/yCx
 E8lq0exbezp9I8NCl4nGEOBWTMGOFqtBTKAjLJeYwbFCbBlHbD76rCXYZJt8GqDkGg/9Zr1Zy4Ovp
 TFH1a/Xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qMN39-009vKi-0L; Thu, 20 Jul 2023 06:22:07 +0000
Date: Wed, 19 Jul 2023 23:22:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <ZLjSj4uSr+pIKSui@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
 <ZK/cpSceLMovhmfR@infradead.org>
 <20230713104542-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230713104542-mutt-send-email-mst@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
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

On Thu, Jul 13, 2023 at 10:47:23AM -0400, Michael S. Tsirkin wrote:
> There are a gazillion virtio drivers and most of them just use the
> virtio API, without bothering with these micro-optimizations.  virtio
> already tracks addresses so mapping/unmapping them for DMA is easier
> done in the core.  It's only networking and only with XDP where the
> difference becomes measureable.

Yes, but now you two differing code paths (which then branch into
another two with the fake DMA mappings).  I'm really worried about
the madness that follows like the USB dma mapping code that is a
constant soure of trouble.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
