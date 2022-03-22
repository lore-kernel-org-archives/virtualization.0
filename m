Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EECC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 14:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 549E240B3D;
	Tue, 22 Mar 2022 14:09:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 965fLQdjGu_K; Tue, 22 Mar 2022 14:09:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1D82140B37;
	Tue, 22 Mar 2022 14:09:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 898A5C0088;
	Tue, 22 Mar 2022 14:09:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FF61C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B022D40B17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:09:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ilSpiLWjzZfa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6E8940AFC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647958154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XjrS+i8ux47oEqISC/xAzvVvrtglGui4NIu7mtB3Zfk=;
 b=dRCk5HozTd2BTjVC1ifS7Ak05l6jUoZPE7HGYNU6vcvDYkEyJZLqLCUgaLpVxTy1/LVWkb
 /qyAFjfah7NhTmZwZo99XuMXP2tEJroEQeJzZh84dK8p+gnccnIKxizt8tmrqLNRcggJ9E
 2fVSFRshKPztyKfVEUpFXDgirZm0Ctk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-CjH2qO73NHWN0zapTroaDg-1; Tue, 22 Mar 2022 10:09:12 -0400
X-MC-Unique: CjH2qO73NHWN0zapTroaDg-1
Received: by mail-wm1-f72.google.com with SMTP id
 r9-20020a1c4409000000b0038c15a1ed8cso1357554wma.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 07:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XjrS+i8ux47oEqISC/xAzvVvrtglGui4NIu7mtB3Zfk=;
 b=w8ShDYuV8220f21damZrjxnyTf96HAh32Dcu+apjcnS9c0jnCf1ALjgTuUgKxUQ4O0
 9nXdVrwqsRuyx4S3ZUu3huu86WtB36t2qypq70nE7n2BOYfrINBPc8RzkZHN+LQqr2tJ
 e11zZCRSx+lD8IalxeWKhnvGXZ33iPk2YsyqilSMSHWKjjg4pX4zJ0GWe02MhU8W1FU8
 jDRmgi7mFPqH3bBM26z19Oo9nICxmKsRduKM2Jwf8rKQTfkSJNfmhEw8A4chRZw9CsW9
 4XWt4eaHOsnahQoi/6wawej4KMjDNIgBJs2K7uS3Ov/TQhfpqNhGeN00x3hKC3/C4Jlf
 /2/Q==
X-Gm-Message-State: AOAM532f65AckTJ7BOrsnd+5kLgCb8yfLNBUltGnB0zXEDUadJSWkirh
 tVSV5X87mHTJq5TZSw640mYaMlZqOHu+CphNJpWOIfxDSzFNtxb/EJ+1S+44vL37FUmMOuC5jts
 IJip9FTuq/R7gyqikhXXWvyDLIasTndhY/FJQThpmcg==
X-Received: by 2002:a05:6000:1ace:b0:203:d45b:fbce with SMTP id
 i14-20020a0560001ace00b00203d45bfbcemr21853210wry.673.1647958151073; 
 Tue, 22 Mar 2022 07:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwthJ2YR6qum+rIdVwv5c7F+YfWcOGMnm3G5bxJSaXDIMo7k9XlQ8+7FNG7SNMTkGwYmHNl7g==
X-Received: by 2002:a05:6000:1ace:b0:203:d45b:fbce with SMTP id
 i14-20020a0560001ace00b00203d45bfbcemr21853185wry.673.1647958150834; 
 Tue, 22 Mar 2022 07:09:10 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c020600b0038cbb21fb00sm1106899wmi.39.2022.03.22.07.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 07:09:10 -0700 (PDT)
Date: Tue, 22 Mar 2022 10:09:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: enable VQs early on probe
Message-ID: <20220322100835-mutt-send-email-mst@kernel.org>
References: <20220322103823.83411-1-sgarzare@redhat.com>
 <20220322092723-mutt-send-email-mst@kernel.org>
 <20220322140500.bn5yrqj5ljckhcdb@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220322140500.bn5yrqj5ljckhcdb@sgarzare-redhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Tue, Mar 22, 2022 at 03:05:00PM +0100, Stefano Garzarella wrote:
> On Tue, Mar 22, 2022 at 09:36:14AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Mar 22, 2022 at 11:38:23AM +0100, Stefano Garzarella wrote:
> > > virtio spec requires drivers to set DRIVER_OK before using VQs.
> > > This is set automatically after probe returns, but virtio-vsock
> > > driver uses VQs in the probe function to fill rx and event VQs
> > > with new buffers.
> > 
> > 
> > So this is a spec violation. absolutely.
> > 
> > > Let's fix this, calling virtio_device_ready() before using VQs
> > > in the probe function.
> > > 
> > > Fixes: 0ea9e1d3a9e3 ("VSOCK: Introduce virtio_transport.ko")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > index 5afc194a58bb..b1962f8cd502 100644
> > > --- a/net/vmw_vsock/virtio_transport.c
> > > +++ b/net/vmw_vsock/virtio_transport.c
> > > @@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> > >  	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
> > >  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
> > > 
> > > +	virtio_device_ready(vdev);
> > > +
> > >  	mutex_lock(&vsock->tx_lock);
> > >  	vsock->tx_run = true;
> > >  	mutex_unlock(&vsock->tx_lock);
> > 
> > Here's the whole code snippet:
> > 
> > 
> >        mutex_lock(&vsock->tx_lock);
> >        vsock->tx_run = true;
> >        mutex_unlock(&vsock->tx_lock);
> > 
> >        mutex_lock(&vsock->rx_lock);
> >        virtio_vsock_rx_fill(vsock);
> >        vsock->rx_run = true;
> >        mutex_unlock(&vsock->rx_lock);
> > 
> >        mutex_lock(&vsock->event_lock);
> >        virtio_vsock_event_fill(vsock);
> >        vsock->event_run = true;
> >        mutex_unlock(&vsock->event_lock);
> > 
> >        if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
> >                vsock->seqpacket_allow = true;
> > 
> >        vdev->priv = vsock;
> >        rcu_assign_pointer(the_virtio_vsock, vsock);
> > 
> >        mutex_unlock(&the_virtio_vsock_mutex);
> > 
> > 
> > I worry that this is not the only problem here:
> > seqpacket_allow and setting of vdev->priv at least after
> > device is active look suspicious.
> 
> Right, so if you agree I'll move these before virtio_device_ready().
> 
> > E.g.:
> > 
> > static void virtio_vsock_event_done(struct virtqueue *vq)
> > {
> >        struct virtio_vsock *vsock = vq->vdev->priv;
> > 
> >        if (!vsock)
> >                return;
> >        queue_work(virtio_vsock_workqueue, &vsock->event_work);
> > }
> > 
> > looks like it will miss events now they will be reported earlier.
> > One might say that since vq has been kicked it might send
> > interrupts earlier too so not a new problem, but
> > there's a chance device actually waits until DRIVER_OK
> > to start operating.
> 
> Yes I see, should I break into 2 patches (one where I move the code already
> present and this one)?
> 
> Maybe a single patch is fine since it's the complete solution.
> 
> Thank you for the detailed explanation,
> Stefano

Two I think since movement can be backported to before the hardening
effort.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
