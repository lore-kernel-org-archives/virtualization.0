Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30075C433DF
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 12:59:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2AC206C3
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 12:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYYGdOD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2AC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B84AA86B67;
	Tue, 11 Aug 2020 12:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVFFvTRC64b8; Tue, 11 Aug 2020 12:59:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C399B87758;
	Tue, 11 Aug 2020 12:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A88C4C07FF;
	Tue, 11 Aug 2020 12:59:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA189C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9F0D887C9C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9TNVvzV8JDLc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:59:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B047287824
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597150741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XY6Krjx9fNxb2tYLQci1GnykiFY2uJIiO6IhhjYHzy4=;
 b=AYYGdOD20HAlyhWo5WxAlDTii48Kd+mZZoolW13ShcnWExnJe8YiN0CuVVhom/YxkI59dF
 Ces0dAktaNZNDx1xAW18SYRDZgkDd65mNrmGHy/5usdqilw/ERBKgjoaoXe6YCQ4+JP8f+
 /2e1HHKZ2qGU3fJdWzWvOU1vkQGFO7c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-sgKLNupmPVGzEo-ykx8BRw-1; Tue, 11 Aug 2020 08:58:59 -0400
X-MC-Unique: sgKLNupmPVGzEo-ykx8BRw-1
Received: by mail-ed1-f71.google.com with SMTP id da13so4603695edb.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 05:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XY6Krjx9fNxb2tYLQci1GnykiFY2uJIiO6IhhjYHzy4=;
 b=d1OpY7UA244uxEzn3h8Movp6y7nhR9FpVXdiceH2Gi/cqtWBFVxWWrnpzKvT8gBkBl
 hDRJYbwqaxMiKdPcVIHKYTPOLAWo+ZRgH5vtWsajU1LHe6LsBKT4BldpOtt2pUUDnWBi
 0jmG+RWHcecGpM7vAkHgfRLFaL6JPT3yBCp2ZIU2Oflv/OvsNdcVCiDhD10yvjy5u3wS
 06kiRuJIwYsL5bBqX+dOO8A7Q52vPoT8YjvIWlzekUUzMD5hL/5CBB7Jvs1dR7Coj09S
 5DzM132UQvYNF+8Y5w4lzX58zzpkX2OBWByMLnc0Ny8twuVRBvHPQK0EQX1sTqOQxtiG
 Goiw==
X-Gm-Message-State: AOAM532xxn+gvHBPfBKiuOAEezqi07SssypEuEMoppoqiqec2ZuSa+We
 iU0ienRJP3YlslBQaKnidVOYRk3bhZptZCHd9OKJBH3IhjZbp4Wl9rkRs1f8kDSlQvPNkqywjqC
 HDo/tWLcDJ+ncS7GQnKDLpmfNyrqqgQD+kmDV10Hm/A==
X-Received: by 2002:a50:fc82:: with SMTP id f2mr25547282edq.53.1597150738490; 
 Tue, 11 Aug 2020 05:58:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu507B2txHo7qll2eVfkDWwWhsXTijvB8coAcYpqYfqn7X/fo1vbqOSlKjJ1YbZ8pIOcBhyw==
X-Received: by 2002:a50:fc82:: with SMTP id f2mr25547275edq.53.1597150738260; 
 Tue, 11 Aug 2020 05:58:58 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
 by smtp.gmail.com with ESMTPSA id b9sm15115760ejz.57.2020.08.11.05.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 05:58:56 -0700 (PDT)
Date: Tue, 11 Aug 2020 08:58:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
Message-ID: <20200811084616-mutt-send-email-mst@kernel.org>
References: <20200715133255.10526-1-mwilck@suse.com>
 <20200811071726-mutt-send-email-mst@kernel.org>
 <e75b3cd527bae4c6762af17a0a32f57c61191274.camel@suse.com>
MIME-Version: 1.0
In-Reply-To: <e75b3cd527bae4c6762af17a0a32f57c61191274.camel@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
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

On Tue, Aug 11, 2020 at 02:07:23PM +0200, Martin Wilck wrote:
> On Tue, 2020-08-11 at 07:26 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2020 at 03:32:55PM +0200, mwilck@suse.com wrote:
> > >  drivers/char/hw_random/virtio-rng.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/drivers/char/hw_random/virtio-rng.c
> > > b/drivers/char/hw_random/virtio-rng.c
> > > index 79a6e47b5fbc..984713b35892 100644
> > > --- a/drivers/char/hw_random/virtio-rng.c
> > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > @@ -59,6 +59,20 @@ static int virtio_read(struct hwrng *rng, void
> > > *buf, size_t size, bool wait)
> > >  	if (vi->hwrng_removed)
> > >  		return -ENODEV;
> > >  
> > > +	/*
> > > +	 * If the previous call was non-blocking, we may have got some
> > > +	 * randomness already.
> > > +	 */
> > > +	if (vi->busy && completion_done(&vi->have_data)) {
> > > +		unsigned int len;
> > > +
> > > +		vi->busy = false;
> > > +		len = vi->data_avail > size ? size : vi->data_avail;
> > > +		vi->data_avail -= len;
> > 
> > I wonder what purpose does this line serve: busy is false
> > which basically means data_avail is invalid, right?
> > A following non blocking call will not enter here.
> 
> Well, I thought this is just how reading data normally works. But
> you're right, the remainder will not be used. I can remove the line, or
> reset data_avail to 0 at this point. What do you prefer?
> 
> Regards,
> Martin

Removing seems cleaner.

But looking at it, it is using the API in a very strange way:
a buffer is placed in the ring by one call, and *assumed*
to still be there in the next call.

which it might not be if one call is from userspace and the
next one is from fill kthread.

I guess this is why it's returning 0: yes it knows there's
data, but it does not know where it is.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
