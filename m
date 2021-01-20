Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14345C433DB
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 09:57:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3362332A
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 09:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3362332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1FEF78693C;
	Wed, 20 Jan 2021 09:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RpFJ+x1owRpF; Wed, 20 Jan 2021 09:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 31E5D8681C;
	Wed, 20 Jan 2021 09:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24B02C088B;
	Wed, 20 Jan 2021 09:57:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D658C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 317CB203D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q9nnnXqImGSK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 259BA1FEF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611136672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rI/aNUF4iX6rJBo6zJ7zLcisnPIn2Cuehxm+ovurTIg=;
 b=is3fKDHbQnDkrdX8PDRS8bPhuhVW1TUbu8l4c2l+3+ZhDt/rG6DzhaYhC+utbwXh1gVxiB
 TuWzH95lQ3fg9eaJbUkmNPkhFMvvIxIqprGyY3lb08LKQ0kRYLmfAri0E35Q8fHUddX/Ny
 srhcROnTIJZYV+C2S7va+JzQm+MaDok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-vEnLee38MQmQZrhQFrfvTw-1; Wed, 20 Jan 2021 04:57:51 -0500
X-MC-Unique: vEnLee38MQmQZrhQFrfvTw-1
Received: by mail-wr1-f72.google.com with SMTP id v5so11193384wrr.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 01:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rI/aNUF4iX6rJBo6zJ7zLcisnPIn2Cuehxm+ovurTIg=;
 b=k2KF2hwOsPDzF529oHvIdoCdF46wPiMaOySKNSfhb48s1ETlpEogwerQwGU5L2VfdL
 x3gj4IYKY8UDJhuyZFO+awljxTbqop/31cobzo8BSIVWTB5a/FQq76v8nPxR5uEzXyr6
 xNKyCl1FuxFMq8riWjNahYl9IMmBaxwuTvDObATZbAq133KNYx3U72nJ6abWS01+kyNa
 O3/LBrd3akxtLxIeIAwvx3f9kVQB+BqDZ6Q7trTq7+bYIUPkQWoq9eM+P5BKiV+2EGaN
 v73UVQYQd9L1QKq/3f9QEDE4rFsuOWtkGOk9t1F9d9qBzqZbc9MOuJxeiLPPTdD/OCgs
 3/5Q==
X-Gm-Message-State: AOAM532BmSrOdpxlq9zrUD6HGXaBAQShGk/pdHYfMwBv/kQPnMvxv8vQ
 1Vd5rORYZHYGLlDrj8VLDjFdDMDSfnFO6EyAbFmcxIThZa9ex+y4+HME1NAmXSQ9D7ZSnUDeEOh
 pLx3QRUchy9w8syfl9WboObMKVZCLt36A1ytA2rG1fw==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr3522126wmc.67.1611136670202;
 Wed, 20 Jan 2021 01:57:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysojSYIU7BmwnZJ8v236DSByDjL3pHaRMW50WuxQGh9a57i9zHGHQkBa+2n+gsCeWAmYp1Fg==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr3522104wmc.67.1611136670014;
 Wed, 20 Jan 2021 01:57:50 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id q15sm2875475wrw.75.2021.01.20.01.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jan 2021 01:57:49 -0800 (PST)
Date: Wed, 20 Jan 2021 04:57:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
Message-ID: <20210120045736-mutt-send-email-mst@kernel.org>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tian Tao <tiantao6@hisilicon.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
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

On Wed, Jan 20, 2021 at 10:40:37AM +0100, David Hildenbrand wrote:
> On 20.01.21 08:50, Jiapeng Zhong wrote:
> > Fix the following coccicheck warnings:
> > 
> > ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
> > of 0/1 to bool variable.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_mem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> > index 9fc9ec4..85a272c 100644
> > --- a/drivers/virtio/virtio_mem.c
> > +++ b/drivers/virtio/virtio_mem.c
> > @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
> >  	 * actually in use (e.g., trying to reload the driver).
> >  	 */
> >  	if (vm->plugged_size) {
> > -		vm->unplug_all_required = 1;
> > +		vm->unplug_all_required = true;
> >  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
> >  	}
> >  
> > 
> 
> Hi,
> 
> we already had a fix on the list for quite a while:
> 
> https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com

Can't find that one.

> However, looks like Michael queued your patch on the vhost tree instead.
> 
> -- 
> Thanks,
> 
> David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
