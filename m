Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9106CC433FE
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 21:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 362DF83388;
	Fri, 14 Jan 2022 21:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NngHy4xaXYTW; Fri, 14 Jan 2022 21:49:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4F5083332;
	Fri, 14 Jan 2022 21:49:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 968E7C002F;
	Fri, 14 Jan 2022 21:49:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 570BEC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CA454089B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yb5WJ6CrlO6f
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:49:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7D5B40883
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 21:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642196946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GUR+by35RD9Gl4oaWlStDXiPFR6+v6HcjEvlAlzL5kY=;
 b=KVnBGfdAkvpWFcYvcEuSy+FtQcHOy2N63nS1YOStdoBkPfPK4eW4T9wzXiuLYoQt5HXsh+
 UU1mfPsAC651VF9YPQwtjQ0f1MwYE9bocTSErlo/M+bqCMKI6wQllswrUnPmHUe70zmktH
 AXPQXD8Vyhvm+5RhjTgjymxgCfE59z8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-FzbCFFUIP8iN2-ufivqLJw-1; Fri, 14 Jan 2022 16:49:05 -0500
X-MC-Unique: FzbCFFUIP8iN2-ufivqLJw-1
Received: by mail-ed1-f72.google.com with SMTP id
 y18-20020a056402271200b003fa16a5debcso9258815edd.14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 13:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GUR+by35RD9Gl4oaWlStDXiPFR6+v6HcjEvlAlzL5kY=;
 b=O/5FxXYRVMsOnMQkeRzPE0DtVils8qT84vb4AQBd1vPBwneHmuxPqqD9jY38p6fgvd
 UQcFHIramElupNjFlzWO9QvMcP3f6qta2956UOI2LI5RdhYYUJyVwk+R52FABlyZ6bNu
 LV93cDXXFMHxmZMGBqhfyNayy8y9wVoSO9iQnRSgQ2l7/u5wMlFYZD/GtQ3JgVtex2UF
 cv1KiJvM5mMEUJtErP/xM8PIG5LpWZPkG8YCqcXM+OYdvKwcWbGG92IeoEAjW0MRG/D1
 XiVWFvMcqNAxqI35K3EXP0bwETWNdRcrA0g6VqFu1AWH3eZlq/mCDPwvh9dYimeiDP0v
 HMhA==
X-Gm-Message-State: AOAM533XSWFPFdi182RmxzV7t+SIG9RkEgj9pVUacd7V/1F+rgFuA2B2
 sIYLVUt0sVJ7ddT7fmDa8s+ucWFn1Jlz5aehYXyACEKMHL9rBSqSgS7ZsQt5zbJHYg+5EnqSABa
 CpXx/K/pIiVZ+X/dPnuERSmygD158xy3OLUhX7pKl7A==
X-Received: by 2002:a17:906:2bc3:: with SMTP id
 n3mr9000681ejg.332.1642196944329; 
 Fri, 14 Jan 2022 13:49:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+EhfKm9kr1Il/CwTLU+uemQRS1JNWhcH3W2jEzws+nrb27dmZUKUHTPk9Vhb37jnhOTC5gQ==
X-Received: by 2002:a17:906:2bc3:: with SMTP id
 n3mr9000665ejg.332.1642196944084; 
 Fri, 14 Jan 2022 13:49:04 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id i16sm2770595edu.29.2022.01.14.13.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 13:49:02 -0800 (PST)
Date: Fri, 14 Jan 2022 16:48:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] virtio_console: break out of buf poll on remove
Message-ID: <20220114164549-mutt-send-email-mst@kernel.org>
References: <20211005070354.265164-1-mst@redhat.com>
 <YVxUNudHGxURHH/4@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YVxUNudHGxURHH/4@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>
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

On Tue, Oct 05, 2021 at 03:33:42PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 05, 2021 at 03:04:07AM -0400, Michael S. Tsirkin wrote:
> > A common pattern for device reset is currently:
> > vdev->config->reset(vdev);
> > .. cleanup ..
> > 
> > reset prevents new interrupts from arriving and waits for interrupt
> > handlers to finish.
> > 
> > However if - as is common - the handler queues a work request which is
> > flushed during the cleanup stage, we have code adding buffers / trying
> > to get buffers while device is reset. Not good.
> > 
> > This was reproduced by running
> > 	modprobe virtio_console
> > 	modprobe -r virtio_console
> > in a loop.
> 
> That's a pathological case that is not "in the field" except by people
> who want to abuse the system as root.  And they can do much worse things
> than that.
> 
> > Fixing this comprehensively needs some thought, and new APIs.
> > Let's at least handle the specific case of virtio_console
> > removal that was reported in the field.
> 
> Let's fix this correctly, don't just hack it up now.

Well I poked at it some more, and things are not as bad
as I thought. It's mostly just console and possibly virtio-mem.
Well and virtio-bt has a completely borken cleanup that
does not even bother to reset the device, but that's
a separate issue, discussing it with the maintainer.

So I wrote some patches to document the requirements better, added a
wrapper for reset and generally cleaned the API up a bit, and added a
patch for mem, but generally I no longer think we need a major API
change.


> > Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/char/virtio_console.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 7eaf303a7a86..c852ce0b4d56 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1956,6 +1956,12 @@ static void virtcons_remove(struct virtio_device *vdev)
> >  	list_del(&portdev->list);
> >  	spin_unlock_irq(&pdrvdata_lock);
> >  
> > +	/* Device is going away, exit any polling for buffers */
> > +	virtio_break_device(vdev);
> > +	if (use_multiport(portdev))
> > +		flush_work(&portdev->control_work);
> > +	else
> > +		flush_work(&portdev->config_work);
> >  	/* Disable interrupts for vqs */
> 
> newline before comment?

sure

> thanks,
> 
> greg k-h

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
