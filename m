Return-Path: <SRS0=zhq/=DP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DEDC43467
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:28:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9042122227
	for <virtualization@archiver.kernel.org>; Thu,  8 Oct 2020 20:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8oE1EPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9042122227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D9F3B2E1AA;
	Thu,  8 Oct 2020 20:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EqNuYAVw+80s; Thu,  8 Oct 2020 20:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0892F20396;
	Thu,  8 Oct 2020 20:28:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2598C07FF;
	Thu,  8 Oct 2020 20:28:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDE7AC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C27BA86E82
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5S7wHRsPlFK0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:28:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D41C786AF9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Oct 2020 20:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602188926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=caF6a1MKbmv3Qw+xnDNzTfS/1KBH8aRkP9njZDRX0Fs=;
 b=J8oE1EPdg3hxSXTyznlkmRTKc3XWSFuphP7VrZDtj7aN9K3ponEnn2sR/g3e0IrBC1Os3S
 AVfSRO3Xi5Pw5gkHRoNphf4oVD6tZe2d1rIKK+ijqFvoXngkg2ZXI2XIgC/1xAgAambT5w
 BNYYX61h+KCs4+Q/52Fv/rdAtelj6Nw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-Ix3NI2MKP-O1RIM9OkObeg-1; Thu, 08 Oct 2020 16:28:44 -0400
X-MC-Unique: Ix3NI2MKP-O1RIM9OkObeg-1
Received: by mail-wm1-f71.google.com with SMTP id a25so3530210wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Oct 2020 13:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=caF6a1MKbmv3Qw+xnDNzTfS/1KBH8aRkP9njZDRX0Fs=;
 b=HcPNwmo8TIa/iDEvsoYm97LhAT+PqEUtsVWFci47XoCtasPSLCsAGUmOnQAWCfF6ZH
 /37MCHIlNZkjo6mXVkkvYCuf22zy/gN+pURFT6HGBTWLm6rloJW5d9UgS8njk+MdIgEw
 oP4Qq7x24k5LvH6uAD8We7+AkSjBGHodKzeVkW0tLsp+gI6fulu0626ZSVUa0THg6ASd
 e5aYWCA3DRjlge1wxXFdjUDvnqkUcYp0C6Gho9kBGAJ7g4YXEA7/pupaOgVIYVptU1HN
 INjLkzHoxlx1lcYWI3kkYuizduFK8xoIFY//h0EZyQVH7eB7a4HDpLNOT6GivvCFUuik
 BLOA==
X-Gm-Message-State: AOAM533BiKQ1PjZksgCxhwwrR1y6KBWTzpczg/Gle2dit3U6GlisxERX
 HeXYU8dip+0m/OjqeM0Q7CB3RYMeUpgw1Kbq7O0To/Xk0/tCpI2iUREVME6GrouXE71w3okDra0
 rCVLzm3XZotznCDLAqXcy6EdZCciJJhvMIVNQgEOwtw==
X-Received: by 2002:adf:9124:: with SMTP id j33mr11087555wrj.272.1602188923790; 
 Thu, 08 Oct 2020 13:28:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh5A/5Z709VFadlr4JMrgafEqB5aQH7y0RpPTVbx0qmRWUq9A9IgbF5HNIuV7k7UKGbJOfFw==
X-Received: by 2002:adf:9124:: with SMTP id j33mr11087542wrj.272.1602188923600; 
 Thu, 08 Oct 2020 13:28:43 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id w11sm8605695wrn.27.2020.10.08.13.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 13:28:42 -0700 (PDT)
Date: Thu, 8 Oct 2020 16:28:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vringh: fix __vringh_iov() when riov and wiov are
 different
Message-ID: <20201008162813-mutt-send-email-mst@kernel.org>
References: <20201008161311.114398-1-sgarzare@redhat.com>
 <20201008160035-mutt-send-email-mst@kernel.org>
 <20201008202436.r33jqbbttqynfvhe@steredhat>
MIME-Version: 1.0
In-Reply-To: <20201008202436.r33jqbbttqynfvhe@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

On Thu, Oct 08, 2020 at 10:24:36PM +0200, Stefano Garzarella wrote:
> On Thu, Oct 08, 2020 at 04:00:51PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Oct 08, 2020 at 06:13:11PM +0200, Stefano Garzarella wrote:
> > > If riov and wiov are both defined and they point to different
> > > objects, only riov is initialized. If the wiov is not initialized
> > > by the caller, the function fails returning -EINVAL and printing
> > > "Readable desc 0x... after writable" error message.
> > > 
> > > Let's replace the 'else if' clause with 'if' to initialize both
> > > riov and wiov if they are not NULL.
> > > 
> > > As checkpatch pointed out, we also avoid crashing the kernel
> > > when riov and wiov are both NULL, replacing BUG() with WARN_ON()
> > > and returning -EINVAL.
> > > 
> > > Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > Can you add more detail please? when does this trigger?
> 
> I'm developing vdpa_sim_blk and I'm using vringh_getdesc_iotlb()
> to get readable and writable buffers.
> 
> With virtio-blk devices a descriptors has both readable and writable
> buffers (eg. virtio_blk_outhdr in the readable buffer and status as last byte
> of writable buffer).
> So, I'm calling vringh_getdesc_iotlb() one time to get both type of buffer
> and put them in 2 iovecs:
> 
> 	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
> 				   &vq->head, GFP_ATOMIC);
> 
> With this patch applied it works well, without the function fails
> returning -EINVAL and printing "Readable desc 0x... after writable".
> 
> Am I using vringh_getdesc_iotlb() in the wrong way?
> 
> Thanks,
> Stefano
> 


I think it's ok, this info just needs to be in the commit log ...

> > > ---
> > >  drivers/vhost/vringh.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > > index e059a9a47cdf..8bd8b403f087 100644
> > > --- a/drivers/vhost/vringh.c
> > > +++ b/drivers/vhost/vringh.c
> > > @@ -284,13 +284,14 @@ __vringh_iov(struct vringh *vrh, u16 i,
> > >  	desc_max = vrh->vring.num;
> > >  	up_next = -1;
> > >  
> > > +	/* You must want something! */
> > > +	if (WARN_ON(!riov && !wiov))
> > > +		return -EINVAL;
> > > +
> > >  	if (riov)
> > >  		riov->i = riov->used = 0;
> > > -	else if (wiov)
> > > +	if (wiov)
> > >  		wiov->i = wiov->used = 0;
> > > -	else
> > > -		/* You must want something! */
> > > -		BUG();
> > >  
> > >  	for (;;) {
> > >  		void *addr;
> > > -- 
> > > 2.26.2
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
