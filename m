Return-Path: <SRS0=zhq/=DP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FBDC433DF
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA43422245
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9bqkj8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA43422245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 575A0868B5;
	Thu,  8 Oct 2020 20:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l3ZFQ5SJKC3j; Thu,  8 Oct 2020 20:24:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B229867E5;
	Thu,  8 Oct 2020 20:24:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F988C07FF;
	Thu,  8 Oct 2020 20:24:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63C1FC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4B67186E82
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hQVssmTcVmhb
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4E1686E73
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602188682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=juQFOMH9dE2p8xOLnKEBSnl6iWukaOWDLTPaWnsLC+o=;
 b=K9bqkj8NveP2ZgawZGGSv/N2pR05H8lNYxMq2UpzE5CV5D8fwi9iD8inOfz1GommZDOe5H
 mgOTaPaQQE+e7nDcDSnnO/tZNL1pxw5Ge/IXieVBbDx6zzEuy+M0Ri4W8ZaHFQgvSp7Jwg
 iPF+vHuWeMnA1SMKc4ydRGkWloLGHDE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-FgKXtgrZOe6SbHBuhVNekQ-1; Thu, 08 Oct 2020 16:24:40 -0400
X-MC-Unique: FgKXtgrZOe6SbHBuhVNekQ-1
Received: by mail-wr1-f69.google.com with SMTP id j18so1031920wrc.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Oct 2020 13:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=juQFOMH9dE2p8xOLnKEBSnl6iWukaOWDLTPaWnsLC+o=;
 b=fVIsn20yr3RSifKzmg4OAI782RgZmyRLwYDx9vR6N5iZfV1Kulch+634VRmLqUA4NI
 +6td+gyt+6BCtGR3gNhWYxjhknJWMrD7ijWK2m0LXoMsZMazPdXu4A2E45DIxxWRweqL
 J0lnD8C1FY3aBH/2XCoaXxUWAm3tm2pySId962Cs/o9P6bnvLrE2Ln1az66gbCX7NiDV
 Z+bJgRF4llhWb6F7UrIbrUdzmu7m2qF2Wye67ATQBUNX5lSzI5fJ8ZGFhplKACD3KcST
 BUjkV64QkQXg1Z7QYeJJtTLZP8YUPy0yOFfzSlOFy2/nuKfKxWc0jWSwZA0yDFjGI2LQ
 ckdQ==
X-Gm-Message-State: AOAM532J5B4cg+5myuCoZlzrGvRc7srMyDYifRmIZYEygfG+NBUWKfSC
 HOUkewlxFQN/D3B4lUGvBtx76ZebWRYGnDbwTCv2JMtEui8RRNkB+oVvmo7LgWaQ231xpjpkGJX
 q4SNUScKvqLoqUaovkgmkzDwxfRf+kGdgQkQChl+ZhA==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr11288702wra.339.1602188679373; 
 Thu, 08 Oct 2020 13:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0zutp4sbmwgxVvnc/6mlFYkwIqy4tqWMrqBnp4FuNBBRC6tgWuOZeJwG4AHMnrpjmvfj3JQ==
X-Received: by 2002:adf:b1cb:: with SMTP id r11mr11288685wra.339.1602188679120; 
 Thu, 08 Oct 2020 13:24:39 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id c4sm8699628wrp.85.2020.10.08.13.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:24:38 -0700 (PDT)
Date: Thu, 8 Oct 2020 22:24:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vringh: fix __vringh_iov() when riov and wiov are
 different
Message-ID: <20201008202436.r33jqbbttqynfvhe@steredhat>
References: <20201008161311.114398-1-sgarzare@redhat.com>
 <20201008160035-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201008160035-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Oct 08, 2020 at 04:00:51PM -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 08, 2020 at 06:13:11PM +0200, Stefano Garzarella wrote:
> > If riov and wiov are both defined and they point to different
> > objects, only riov is initialized. If the wiov is not initialized
> > by the caller, the function fails returning -EINVAL and printing
> > "Readable desc 0x... after writable" error message.
> > 
> > Let's replace the 'else if' clause with 'if' to initialize both
> > riov and wiov if they are not NULL.
> > 
> > As checkpatch pointed out, we also avoid crashing the kernel
> > when riov and wiov are both NULL, replacing BUG() with WARN_ON()
> > and returning -EINVAL.
> > 
> > Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Can you add more detail please? when does this trigger?

I'm developing vdpa_sim_blk and I'm using vringh_getdesc_iotlb()
to get readable and writable buffers.

With virtio-blk devices a descriptors has both readable and writable
buffers (eg. virtio_blk_outhdr in the readable buffer and status as last byte
of writable buffer).
So, I'm calling vringh_getdesc_iotlb() one time to get both type of buffer
and put them in 2 iovecs:

	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
				   &vq->head, GFP_ATOMIC);

With this patch applied it works well, without the function fails
returning -EINVAL and printing "Readable desc 0x... after writable".

Am I using vringh_getdesc_iotlb() in the wrong way?

Thanks,
Stefano

> 
> > ---
> >  drivers/vhost/vringh.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index e059a9a47cdf..8bd8b403f087 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -284,13 +284,14 @@ __vringh_iov(struct vringh *vrh, u16 i,
> >  	desc_max = vrh->vring.num;
> >  	up_next = -1;
> >  
> > +	/* You must want something! */
> > +	if (WARN_ON(!riov && !wiov))
> > +		return -EINVAL;
> > +
> >  	if (riov)
> >  		riov->i = riov->used = 0;
> > -	else if (wiov)
> > +	if (wiov)
> >  		wiov->i = wiov->used = 0;
> > -	else
> > -		/* You must want something! */
> > -		BUG();
> >  
> >  	for (;;) {
> >  		void *addr;
> > -- 
> > 2.26.2
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
