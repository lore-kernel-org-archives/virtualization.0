Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B5FC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:02:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FEC60E97
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1FEC60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98EBD80F01;
	Mon, 25 Oct 2021 17:02:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lx2L2V9f_vfq; Mon, 25 Oct 2021 17:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 389D380EF0;
	Mon, 25 Oct 2021 17:02:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B8EBC0019;
	Mon, 25 Oct 2021 17:02:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95FF0C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 773EE403B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7G_RlIYptMDI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66677403B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635181317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOqztots9uZKwSQu0h1UICZOLJs0OYqyRoPLyAIfYPU=;
 b=M/TmRo0EJnQcNtwYgRQb/90sZExbbrSKF3jmIBzaBpl/kh/pw2at5F55TUksn8/UGA8NWa
 TRIDkfk/i8eA+v89pvqae4TDgWLxA5FwT0pEaDg0FK6DC2HRd0rPfGYkf8FsQ3XhMngpDO
 vbTOaSFknbaG3VxzEII7yXB/BzuBBZE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-X2Yz3B33PUSsOviFKQRiGg-1; Mon, 25 Oct 2021 13:01:56 -0400
X-MC-Unique: X2Yz3B33PUSsOviFKQRiGg-1
Received: by mail-wr1-f69.google.com with SMTP id
 k2-20020adfc702000000b0016006b2da9bso3387568wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 10:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iOqztots9uZKwSQu0h1UICZOLJs0OYqyRoPLyAIfYPU=;
 b=5RcNn3Txxj5/SofaUpzRnNR8357tmYR8EFx1kL+nmpDQy6AAdUoHbhFacv5usto2A3
 796s44W/gbnTXa6zcFVoZeXKflspL59OBleh2FnJf/GfScutM6Yic+wb6lUd0XTNYNz9
 tGklXn9iREVNBWoUujUdLnuEESVCWscory6oPcoaiSN1bmjOqnqmh4EE/crx6uHFwSS2
 BSo7FWflOUUIirGXKoj12M/r0NXRCrwVxRm+3ewd5JKYohVxvxQJ300nmCAE+Z2WcwY+
 ptPqzKj2uKITgSbIFXBlQmraGa7yzH+8F5aT/y+J8D8T+rDAz6gMGkE7DVs37er4AFm5
 ebbw==
X-Gm-Message-State: AOAM531Zu7uZIgI4e8pdMrLRkTsFIcSODMvXiJDy1ZQxLj8JF+iUPzjY
 W5iziNKGUkLb50x7GCbGbtU0p12Ugfjv5Uq3QHLnuDAgcZXINUKaCyDVnZFaXqG/K7FctJEPdaN
 ZGflmO1XnUXWyVJ+tZ2EJn01+BvImKj5nOT6ls8mSiQ==
X-Received: by 2002:a05:600c:3511:: with SMTP id
 h17mr49729783wmq.144.1635181314595; 
 Mon, 25 Oct 2021 10:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykMYYstKXiUf9n35P0ddmilxiuNYzTQRX70Dq1rRxHPfALd75DbAun/bZEPwwCibGSmSEIjA==
X-Received: by 2002:a05:600c:3511:: with SMTP id
 h17mr49729761wmq.144.1635181314388; 
 Mon, 25 Oct 2021 10:01:54 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
 by smtp.gmail.com with ESMTPSA id u6sm11411331wmc.29.2021.10.25.10.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 10:01:53 -0700 (PDT)
Date: Mon, 25 Oct 2021 13:01:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 0/4] Add blk_validate_block_size() helper for drivers
 to validate block size
Message-ID: <20211025130130-mutt-send-email-mst@kernel.org>
References: <20211025142506.167-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20211025142506.167-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, josef@toxicpanda.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org, hch@lst.de
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

On Mon, Oct 25, 2021 at 10:25:02PM +0800, Xie Yongji wrote:
> The block layer can't support the block size larger than
> page size yet, so driver needs to validate the block size
> before setting it. Now this validation is done in device drivers
> with some duplicated codes. This series tries to add a block
> layer helper for it and makes loop driver, nbd driver and
> virtio-blk driver use it.
> 
> V1 to V2:
> - Return and print error if validation fails in virtio-blk driver

Please document how all this was tested.

> Xie Yongji (4):
>   block: Add a helper to validate the block size
>   nbd: Use blk_validate_block_size() to validate block size
>   loop: Use blk_validate_block_size() to validate block size
>   virtio-blk: Use blk_validate_block_size() to validate block size
> 
>  drivers/block/loop.c       | 17 ++---------------
>  drivers/block/nbd.c        |  3 ++-
>  drivers/block/virtio_blk.c | 11 +++++++++--
>  include/linux/blkdev.h     |  8 ++++++++
>  4 files changed, 21 insertions(+), 18 deletions(-)
> 
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
