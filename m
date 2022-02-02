Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A039C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 11:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36E4B40328;
	Wed,  2 Feb 2022 11:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3fvbZKMGGP4; Wed,  2 Feb 2022 11:24:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8184D40558;
	Wed,  2 Feb 2022 11:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 489B1C0011;
	Wed,  2 Feb 2022 11:24:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAD29C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B764A83F6C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id djL0Ekd0vx3Z
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:24:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D542F83EE3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643801053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVSUqNEz2jDEjuO9vqQ6YiHSzS42/Um2cKAf3ocZuFc=;
 b=cPEM4gdezrn4Z1fk/B8+YiaVYhPDaXgh0/NAsz8+Cv6qvcKuUwH+xbSZXVPQaxE80KHHvZ
 p8BBqyagPVGCpw9pIkG8hMcA6IrvwKZMD175kL65sy2QeZoqk/TrA2KjzacRockVxVMyzL
 N2eDM0CzSQp+4VFigF/CtXt5/XqyZtA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-OqSag7p6MFSh_DD5N6xBUw-1; Wed, 02 Feb 2022 06:24:12 -0500
X-MC-Unique: OqSag7p6MFSh_DD5N6xBUw-1
Received: by mail-wm1-f72.google.com with SMTP id
 w5-20020a1cf605000000b00354d2d83490so842402wmc.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Feb 2022 03:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wVSUqNEz2jDEjuO9vqQ6YiHSzS42/Um2cKAf3ocZuFc=;
 b=qMMdRh+FExz4x77hshy63e6QjTJ89R2oLqyLwlgV5TYTffh9PTILvVQSj74i5sKPH2
 xV0uvmfvMZuoLiJSRzbZsRtVURz0+D+knDTs+58OHzPzyy24E42Pso+XvkqINIToruj+
 wmSIW6Y2t8vWauT/JsHlnaE/51amsZpTQEyouakxc4QWrdfmGizTWNODa1l+EvF1h5Es
 15uzqyCe2wVa5FH1103CCKVaut7gnNADSlHYPq8G7qd4GjY/fYzE2wt3AMfzsIz5dG6R
 ikVwfvWaKcdK5OekzOcOO8x2LxX2qaMdxDLNLF+NZqVedeOSALDvQRoeqtkkEQt/ZC1Y
 6tMg==
X-Gm-Message-State: AOAM530ZcwRw/JCXyqMCocQSLcL69K2I8AEX3YwG35fYWVgE6ebNbxiD
 MjAnK3OHMiBGowch+UVhJtaF/JgVS+qYst0uxn0cr3axdISg3LhiSN74DAmT574SacY48VyfzUC
 Wev8A2OELDg/5l8NPBA8mKtiUeaN4K3XKC0xat0C64w==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr24004833wrn.240.1643801051273; 
 Wed, 02 Feb 2022 03:24:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2Azzg5CZ10Dv4Exq5q/4lmS9rKnBzuf3jhyJbt3gpU5+v7KjQRr2AcoAMrPFvDcBLPf9iag==
X-Received: by 2002:adf:eb83:: with SMTP id t3mr24004815wrn.240.1643801051038; 
 Wed, 02 Feb 2022 03:24:11 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
 by smtp.gmail.com with ESMTPSA id g6sm5047158wmq.3.2022.02.02.03.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Feb 2022 03:24:09 -0800 (PST)
Date: Wed, 2 Feb 2022 06:24:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220202062340-mutt-send-email-mst@kernel.org>
References: <20220128094129.40809-1-sgarzare@redhat.com>
 <Yfpnlv2GudpPFwok@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <Yfpnlv2GudpPFwok@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Feb 02, 2022 at 11:14:30AM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 28, 2022 at 10:41:29AM +0100, Stefano Garzarella wrote:
> > In vhost_enable_notify() we enable the notifications and we read
> > the avail index to check if new buffers have become available in
> > the meantime.
> > 
> > We do not update the cached avail index value, so when the device
> > will call vhost_get_vq_desc(), it will find the old value in the
> > cache and it will read the avail index again.
> > 
> > It would be better to refresh the cache every time we read avail
> > index, so let's change vhost_enable_notify() caching the value in
> > `avail_idx` and compare it with `last_avail_idx` to check if there
> > are new buffers available.
> > 
> > We don't expect a significant performance boost because
> > the above path is not very common, indeed vhost_enable_notify()
> > is often called with unlikely(), expecting that avail index has
> > not been updated.
> > 
> > We ran virtio-test/vhost-test and noticed minimal improvement as
> > expected. To stress the patch more, we modified vhost_test.ko to
> > call vhost_enable_notify()/vhost_disable_notify() on every cycle
> > when calling vhost_get_vq_desc(); in this case we observed a more
> > evident improvement, with a reduction of the test execution time
> > of about 3.7%.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v3
> > - reworded commit description [Stefan]
> > ---
> >  drivers/vhost/vhost.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 59edb5a1ffe2..07363dff559e 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> >  		       &vq->avail->idx, r);
> >  		return false;
> >  	}
> > +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> >  
> > -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
> > +	return vq->avail_idx != vq->last_avail_idx;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_enable_notify);
> 
> This changes behavior (fixes a bug?): previously the function returned
> false when called with avail buffers still pending (vq->last_avail_idx <
> vq->avail_idx). Now it returns true because we compare against
> vq->last_avail_idx and I think that's reasonable.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

I don't see the behaviour change... could you explain the
scanario in more detail pls?

Thanks!

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
