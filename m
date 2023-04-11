Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE40C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 05:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A7D961419;
	Tue, 11 Apr 2023 05:14:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A7D961419
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GD7yfjOW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dWYEJEAVciys; Tue, 11 Apr 2023 05:14:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E42E60709;
	Tue, 11 Apr 2023 05:14:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E42E60709
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FAD0C0037;
	Tue, 11 Apr 2023 05:14:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC461C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF0FB60E7B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:14:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BF0FB60E7B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xE_FVNcsnDgR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:14:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0F1F60709
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0F1F60709
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 05:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5Gy51ll6lXYiMjv9VcYxqVPCF/hV1ciVdTO/dnv/8t4=; b=GD7yfjOWmQjIBnhtlWUMkWrwAx
 rL2dOxfFEBBhfEtWCO0lw7OoYw9iorol+OHeJxLcqJyubTJKIOZg3FHiCRUQWjvvVqx9VG6iO1Nmz
 C/lbWk/9qaQx2vwjdb7qWLL7Jh3+zJcX+oKpQA5oey0/pQn+TlJfy13AWVQRBjYH4eSh3co4aCdyX
 umA0eFoWTyaq82yU1CxCvu8bBUgYM8dvRnYeQ2gs6URV9re/LoJyAZfCA8ZUgKW4KHFhNFkr4leCe
 rYP6gphiW9LuPNx7BouOrC2NezvUsoZ0EjJr1BPx9hkXAhHHkuUbfsbtnAMove6KDgoX7zfwcat1k
 NrfLMYKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pm6KO-00GREx-1R; Tue, 11 Apr 2023 05:14:00 +0000
Date: Mon, 10 Apr 2023 22:14:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <ZDTsmC1XL9x3X7t5@infradead.org>
References: <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
 <ZDTUn6TUqzrF06mr@infradead.org>
 <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
 <ZDTdk0K6LO5+0OLA@infradead.org>
 <CACGkMEuZss7m+qC2V+QjMJD3W1JdYAoQs6Amn1WXHYZBrJRUjg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEuZss7m+qC2V+QjMJD3W1JdYAoQs6Amn1WXHYZBrJRUjg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Guenter Roeck <linux@roeck-us.net>
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

On Tue, Apr 11, 2023 at 12:54:46PM +0800, Jason Wang wrote:
> Ok, just to clarify, I meant there could be a case where the virtqueue
> is emulated by software, in this case we need check whether the
> virtqueue has a dma device or not in vring_use_dma_api(). If not we
> need return false.

Well, that's what vring_use_dma_api basically does.  Such devics
just should never have VIRTIO_F_ACCESS_PLATFORM set.  If there is
a really good reason for such a device to have VIRTIO_F_ACCESS_PLATFORM
set we'd need an extra quirk in vring_use_dma_api indeed.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
