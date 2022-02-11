Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAC7C4332F
	for <virtualization@archiver.kernel.org>; Fri, 11 Feb 2022 02:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A7B683089;
	Fri, 11 Feb 2022 02:36:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SX52Mw6xtoTO; Fri, 11 Feb 2022 02:36:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1ED7A827C5;
	Fri, 11 Feb 2022 02:36:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5C44C0011;
	Fri, 11 Feb 2022 02:36:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3575AC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 02:36:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1577241609
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 02:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3DweRaJfv_QX
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 02:36:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2403C41607
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 02:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644546969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wUVqFARDBJNnBok2lT0WfqI736phrHJDPkbze9E0f/c=;
 b=TyQmCgEEL+ScYvc9YS+/dNUvFexUKEZHNjP28eYiw61v6Sn7RDYDHId6MjWXAsJL4BdBfb
 g/oKGlO1gOOQu4bM5bko6KSLQTp2jJJTog7GClX+S5XjOb0qbL+5yNyDllUQixm2Mbn9eT
 qnuVxC1DS765KyArJkzmkKy9thq0C2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-oQOwLwdgPe24Kq2cup0Gaw-1; Thu, 10 Feb 2022 21:36:06 -0500
X-MC-Unique: oQOwLwdgPe24Kq2cup0Gaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DA80835B47;
 Fri, 11 Feb 2022 02:36:05 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF608E2E8;
 Fri, 11 Feb 2022 02:35:14 +0000 (UTC)
Date: Fri, 11 Feb 2022 10:35:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] memstick/ms_block: simplify refcounting
Message-ID: <YgXLXcwf8fLK3yti@T590>
References: <20220209082121.2628452-1-hch@lst.de>
 <20220209082121.2628452-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220209082121.2628452-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jens Axboe <axboe@kernel.dk>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-mmc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Feb 09, 2022 at 09:21:17AM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the msb_data structure only once
> the last gendisk reference goes away instead of keeping a local refcount.
> 

The approach looks good, just the error handling needs to be careful,
such as, once driver data is bound to disk->private_data, the previous
error handling code shouldn't touch/free the driver data any more. That
said assigning disk->private_data implies driver data ownership transfer
after this conversion.

Such as, in msb_init_disk(), once blk_cleanup_disk() is done, the code
branch of out_release_id shouldn't be run; msb_probe() has the similar
issue too.

Thanks,
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
