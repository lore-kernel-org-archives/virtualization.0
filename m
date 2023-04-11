Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F9FC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 06:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB81B81F80;
	Tue, 11 Apr 2023 06:47:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB81B81F80
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oCXLjsgW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d5b5N-WNJ8tq; Tue, 11 Apr 2023 06:47:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 77C0281F6E;
	Tue, 11 Apr 2023 06:47:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 77C0281F6E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E12DC0037;
	Tue, 11 Apr 2023 06:47:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB7E0C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D379A81F6E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:46:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D379A81F6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hgcKJmr7sJQK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:46:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 538CD81F23
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 538CD81F23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=E/IfFzrazzI1AivGYuqki931BR+fZFBuW65J+7GiuhU=; b=oCXLjsgWmhqvggeCettSfFo3RL
 gzHKrPz58t3vcRzQm/aNKoKKnVfgwZeRuGWBRuznCG30oFbkGfbbZiQ32ao4FhVBV1eobZ8AE8p6C
 uZ2aybf0T+oBicPH7LUcIDZamP1kK2/7h+E1O+edHzX2HWzAkdRbNermlJoTAce2XZnXZliQXfk91
 h9N6WSTNFjK67syo/JepkWEeug35xpOtZDlSakzblJZjlLs08akFIUJP9u4mD5D2Zmc5tRQCQ1zcS
 9DFGkXRJxSat5eQLE1xjjBYRrQLC6WsekT0+9VmGvpcdb1u7CY335fBDXuYX/SOz2nE+DH1B6zJZx
 lDYr7Kxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pm7mK-00GcFc-0h; Tue, 11 Apr 2023 06:46:56 +0000
Date: Mon, 10 Apr 2023 23:46:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <ZDUCYKcyNh7u/tHc@infradead.org>
References: <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
 <ZDTUn6TUqzrF06mr@infradead.org>
 <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
 <1681193477.0633929-1-xuanzhuo@linux.alibaba.com>
 <ZDT8S6Q9mzNa5dRh@infradead.org>
 <1681194480.146465-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1681194480.146465-3-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Tue, Apr 11, 2023 at 02:28:00PM +0800, Xuan Zhuo wrote:
> > That is just completely broken, virtio or not.  Highlevel code like
> > sockets must never do dma mappings themselves.
> 
> AF_XDP provides some API for net driver. This API will do dma map or dma sync.
> 
> cc AF_XDP maintainers.

So in that case AF_XDP doesn't actually require a dma device as you
claimed early and gets the layering right after all.  Just don't use that
API from a network driver that doesn't need to do dma mappings like
virtio for the !platform_access case then.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
