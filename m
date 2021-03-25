Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142AC433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 08:26:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BC561A1A
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 08:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BC561A1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02AA084969;
	Thu, 25 Mar 2021 08:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nYDZbQtxWq48; Thu, 25 Mar 2021 08:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3DCF84950;
	Thu, 25 Mar 2021 08:26:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7180FC000E;
	Thu, 25 Mar 2021 08:26:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFDACC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 08:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDD4D60751
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 08:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7MwBexvQAD7H
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 08:26:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD86060725
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IzwmhOqvIxwQPFK4E3Oa+CaBwei0j7Z1kHs2r0VicEc=; b=XChpT9BvzSkcKTC2L6pglmtqNW
 x+opZ3kV2asW/R1xhMVEPkDGdW6thedfIfn6YoDTFki6MY1t4h896/cTLH1MTjKCmfA4ngqa507b8
 WqI6IhRpwUJDgUk8bEVyxoy3yHed8K1bWqir2Hdk7kV14K5JLpiZnuxtrPTIXiTE/XZiotNkhttx5
 Bnd3Gw61TRDpDX6hpIPKwjWcrQ34+03fV66mFds8Q/u5F4dupsvAB58YKvJlNEZB6pkcFyA+UVw4X
 FwcMMISnV5Wf0bZ0+GVp79yQbVdsIdAZjC+tCJtCXnHuC6c2KiXj4Dq+Aci4HMmLSOVCwCT0r9s1S
 2y9CV1pA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lPLHU-00CXQ9-Os; Thu, 25 Mar 2021 08:24:08 +0000
Date: Thu, 25 Mar 2021 08:23:52 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v5 01/11] file: Export __receive_fd() to modules
Message-ID: <20210325082352.GA2988009@infradead.org>
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-2-xieyongji@bytedance.com>
 <20210315090822.GA4166677@infradead.org>
 <CACycT3vrHOExXj6v8ULvUzdLcRkdzS5=TNK6=g4+RWEdN-nOJw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3vrHOExXj6v8ULvUzdLcRkdzS5=TNK6=g4+RWEdN-nOJw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Bob Liu <bob.liu@oracle.com>,
 bcrl@kvack.org, viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 Mika Penttil?? <mika.penttila@nextfour.com>
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

On Mon, Mar 15, 2021 at 05:46:43PM +0800, Yongji Xie wrote:
> On Mon, Mar 15, 2021 at 5:08 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Mar 15, 2021 at 01:37:11PM +0800, Xie Yongji wrote:
> > > Export __receive_fd() so that some modules can use
> > > it to pass file descriptor between processes.
> >
> > I really don't think any non-core code should do that, especilly not
> > modular mere driver code.
> 
> Do you see any issue? Now I think we're able to do that with the help
> of get_unused_fd_flags() and fd_install() in modules. But we may miss
> some security stuff in this way. So I try to export __receive_fd() and
> use it instead.

The real problem is now what helper to use, but rather that random
drivers should not just mess with the FD table like that.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
