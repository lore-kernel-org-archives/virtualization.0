Return-Path: <SRS0=JY8S=IR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4640AC433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 13:50:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E401664EE1
	for <virtualization@archiver.kernel.org>; Fri, 19 Mar 2021 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E401664EE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 456A36072A;
	Fri, 19 Mar 2021 13:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1d8ZEc9fqRvr; Fri, 19 Mar 2021 13:50:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ACBE60615;
	Fri, 19 Mar 2021 13:50:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62139C000A;
	Fri, 19 Mar 2021 13:50:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA21C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 004324ED9D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:50:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gtXGqYEpyGct
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:50:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEA634ED49
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616161806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQRUYlPssr7tEQfrFmciIthl3TwcqXqF65U6ThZOyFw=;
 b=PqQfAi4cTEzsyNPPJ3MS0o9jmRDTJwLdF1Mdcl53v12nliSMn26zQINXJOUCz8zxwcvlVy
 RC34dhv/cp7p6pSFRmna4KZH1+EqZ9PwZz+b5S7DorJPBlTtnLreJgzWPwN6x2d0vof0da
 Ze3ryxm826ggtgasqF0RtzEdkXvxPnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-ET1b4oiTMxSPbZv3iVMPwA-1; Fri, 19 Mar 2021 09:50:02 -0400
X-MC-Unique: ET1b4oiTMxSPbZv3iVMPwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456C318C89E4;
 Fri, 19 Mar 2021 13:50:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-114.rdu2.redhat.com [10.10.114.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BAAF5C1D1;
 Fri, 19 Mar 2021 13:49:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 16CDD220BCF; Fri, 19 Mar 2021 09:49:48 -0400 (EDT)
Date: Fri, 19 Mar 2021 09:49:48 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
Message-ID: <20210319134948.GA402287@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318135223.1342795-3-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: miklos@szeredi.hu, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org
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

On Thu, Mar 18, 2021 at 08:52:22AM -0500, Connor Kuehl wrote:
> If an incoming FUSE request can't fit on the virtqueue, the request is
> placed onto a workqueue so a worker can try to resubmit it later where
> there will (hopefully) be space for it next time.
> 
> This is fine for requests that aren't larger than a virtqueue's maximum
> capacity. However, if a request's size exceeds the maximum capacity of
> the virtqueue (even if the virtqueue is empty), it will be doomed to a
> life of being placed on the workqueue, removed, discovered it won't fit,
> and placed on the workqueue yet again.
> 
> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> Descriptors) of the virtio spec:
> 
>   "A driver MUST NOT create a descriptor chain longer than the Queue
>   Size of the device."
> 
> To fix this, limit the number of pages FUSE will use for an overall
> request. This way, each request can realistically fit on the virtqueue
> when it is decomposed into a scattergather list and avoid violating
> section 2.6.5.3.1 of the virtio spec.

Hi Connor,

So as of now if a request is bigger than what virtqueue can support,
it never gets dispatched and caller waits infinitely? So this patch
will fix it by forcing fuse to split the request. That sounds good.


[..]
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8868ac31a3c0..a6ffba85d59a 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -18,6 +18,12 @@
>  #include <linux/uio.h>
>  #include "fuse_i.h"
>  
> +/* Used to help calculate the FUSE connection's max_pages limit for a request's
> + * size. Parts of the struct fuse_req are sliced into scattergather lists in
> + * addition to the pages used, so this can help account for that overhead.
> + */
> +#define FUSE_HEADER_OVERHEAD    4

How did yo arrive at this overhead. Is it following.

- One sg element for fuse_in_header.
- One sg element for input arguments.
- One sg element for fuse_out_header.
- One sg element for output args.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
