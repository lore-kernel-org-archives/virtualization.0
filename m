Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87157C54EE9
	for <virtualization@archiver.kernel.org>; Tue, 20 Sep 2022 07:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 152C941733;
	Tue, 20 Sep 2022 07:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 152C941733
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aUezXLcV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2v87JjPWJCU; Tue, 20 Sep 2022 07:49:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AD12416A5;
	Tue, 20 Sep 2022 07:49:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4AD12416A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDBBC0032;
	Tue, 20 Sep 2022 07:49:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1624C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 07:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CBA560DCA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 07:49:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7CBA560DCA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aUezXLcV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oGe1IcdEiioh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 07:49:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD58360B19
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD58360B19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Sep 2022 07:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AU0mZCMIx8JARy0byW2BmRzgYXSYzSXxAhWcU08IaqY=; b=aUezXLcVpUDpj+rBGwR2e2Dq+j
 +m8n/y4046APNRMEDTF0ZqaDkAxglTlVUNTJr9E1Z6iC226V1Bog1WEQ2+K4ikDCcQlgIfO79QYEn
 goQtBRPP+NXjgTSijBjOyUanFbCeVbhd0zVD0jL5AzO3eoXRAf7sgibPwBwjIJpBRSuo6MlMOJVkH
 45Z1TPzd/6ND3EgH8tHfjOOybk9MqFcjdvPfa8IIrKATJFRTJJ/ua6OyNsUaM6kt5wiagvMuJ7Cav
 WHJ9MvPeN6mIa0F7Nz1cmXZ0IlQ7xW2U8RmCkN9IPpyqtDS+bJksjLZ3l0EsO/cbt4ePE8hMqOnbn
 EqnTWtdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oaY0H-001Ung-4F; Tue, 20 Sep 2022 07:49:13 +0000
Date: Tue, 20 Sep 2022 00:49:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YylweQAZkIdb5ixo@infradead.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-5-sarthakkukreti@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> sends a hint to (supported) thinly provisioned block devices to
> allocate space for the given range of sectors via REQ_OP_PROVISION.

So, how does that "provisioning" actually work in todays world where
storage is usually doing out of place writes in one or more layers,
including the flash storage everyone is using.  Does it give you one
write?  And unlimited number?  Some undecided number inbetween?  How
is it affected by write zeroes to that range or a discard?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
