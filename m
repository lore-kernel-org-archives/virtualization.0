Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08389C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 06:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4FF234051C;
	Tue, 27 Dec 2022 06:58:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4FF234051C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zk1M4/+O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2_9C8Jpi-T28; Tue, 27 Dec 2022 06:58:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4D9A400D1;
	Tue, 27 Dec 2022 06:58:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4D9A400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 956AAC0032;
	Tue, 27 Dec 2022 06:58:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99059C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65FE7403A7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:58:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65FE7403A7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 99TK4GAXCcsq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:58:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 34949400D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34949400D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672124308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mEQnE9PVAxMt3NN5busw/86CF7CMlanPyO97TM74NVQ=;
 b=Zk1M4/+Ot37IzYXK6uaZk7K1ZYQ6Wp9/IN4Tw/6FoqSQpSdAWjl1/dZh7IjNzNvL3C6Maq
 gbH9PV5pbVMvqfp3o8X1gW2kX5g63UE+vgEfx1zzm13s1SBCBIukkaBZJGIVVxZLzWKJOJ
 M6fGO5cYsPgb5BaIX/WNZsrpKslODLg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-wVrn7c2ZNDaOzTxSui0q7g-1; Tue, 27 Dec 2022 01:58:27 -0500
X-MC-Unique: wVrn7c2ZNDaOzTxSui0q7g-1
Received: by mail-wm1-f72.google.com with SMTP id
 fl12-20020a05600c0b8c00b003d96f0a7f36so5100707wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 22:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEQnE9PVAxMt3NN5busw/86CF7CMlanPyO97TM74NVQ=;
 b=E01UmKPxxQx7i/9+gefh872bg4wsMOxVeD2AIC1CnMwj7C6fZj+0+vvJUZaEqpcuNm
 xLi2tC/2tq/ygiy9CsBfXr7NTOOzxzwORlRYOctbNYBCcdAzfDFHtjkZvAaX3GEmby1M
 uUHlFN0ehnmeNul5ivhVxxUKUM2OD3PkGVEHVkr8zHPpc3jgOzhtd9RozV/2TnRIyh7p
 LN8wZegMxW1Pu0x11Q9Xc7k09vnhww1tb8nVH7oxpUbkfptlWcas8gkxbi4AEzD/Os5T
 PprESVN6Ix2L7tFkI24zyrTm2e5/+xNYC7a/vAnzlZSeLBWiYQ68OkG9/Au8JQrJG1BF
 rIRg==
X-Gm-Message-State: AFqh2kroUFb5P8yhx+Ap6yteOoP6xav0K/f57o2n2k8H2RMALv5XStR2
 9VvPzg5rgiEc7fS3Mwcz2ZOCks56SFsw3R6Hn2AVwpMNeQZm566stXb31otNaoqs9lE3jgWgAU9
 ZKGNdGwvzJUbikt5hR+s2dPCgZEg2rVFuxbjwsTp27g==
X-Received: by 2002:a05:6000:408b:b0:242:8404:6b66 with SMTP id
 da11-20020a056000408b00b0024284046b66mr16317871wrb.1.1672124306089; 
 Mon, 26 Dec 2022 22:58:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsQCt0+AaMD4RxNYOoeOnSYvfwzUkVJfqDViHWgn3ChjJ9wRZbivi34ts/r3cP93RBNHKXVag==
X-Received: by 2002:a05:6000:408b:b0:242:8404:6b66 with SMTP id
 da11-20020a056000408b00b0024284046b66mr16317856wrb.1.1672124305675; 
 Mon, 26 Dec 2022 22:58:25 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 p18-20020a056000019200b00279d23574c4sm6850233wrx.13.2022.12.26.22.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 22:58:25 -0800 (PST)
Date: Tue, 27 Dec 2022 01:58:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
Message-ID: <20221227014641-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, kuba@kernel.org, maxime.coquelin@redhat.com,
 pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 27, 2022 at 12:33:53PM +0800, Jason Wang wrote:
> On Tue, Dec 27, 2022 at 10:25 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Mon, 26 Dec 2022 15:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > We used to busy waiting on the cvq command this tends to be
> > > problematic since:
> > >
> > > 1) CPU could wait for ever on a buggy/malicous device
> > > 2) There's no wait to terminate the process that triggers the cvq
> > >    command
> > >
> > > So this patch switch to use virtqueue_wait_for_used() to sleep with a
> > > timeout (1s) instead of busy polling for the cvq command forever. This
> >
> > I don't think that a fixed 1S is a good choice.
> 
> Well, it could be tweaked to be a little bit longer.
> 
> One way, as discussed, is to let the device advertise a timeout then
> the driver can validate if it's valid and use that timeout. But it
> needs extension to the spec.

Controlling timeout from device is a good idea, e.g. hardware devices
would benefit from a shorter timeout, hypervisor devices from a longer
timeout or no timeout.

> 
> > Some of the DPUs are very
> > lazy for cvq handle.
> 
> Such design needs to be revisited, cvq (control path) should have a
> better priority or QOS than datapath.

Spec says nothing about this, so driver can't assume this either.

> > In particular, we will also directly break the device.
> 
> It's kind of hardening for malicious devices.

ATM no amount of hardening can prevent a malicious hypervisor from
blocking the guest. Recovering when a hardware device is broken would be
nice but I think if we do bother then we should try harder to recover,
such as by driving device reset.


Also, does your patch break surprise removal? There's no callback
in this case ATM.

> >
> > I think it is necessary to add a Virtio-Net parameter to allow users to define
> > this timeout by themselves. Although I don't think this is a good way.
> 
> Very hard and unfriendly to the end users.
> 
> Thanks
> 
> >
> > Thanks.
> >
> >
> > > gives the scheduler a breath and can let the process can respond to
> > > asignal. If the device doesn't respond in the timeout, break the
> > > device.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V1:
> > > - break the device when timeout
> > > - get buffer manually since the virtio core check more_used() instead
> > > ---
> > >  drivers/net/virtio_net.c | 24 ++++++++++++++++--------
> > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index efd9dd55828b..6a2ea64cfcb5 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> > >       vi->rx_mode_work_enabled = false;
> > >       spin_unlock_bh(&vi->rx_mode_lock);
> > >
> > > +     virtqueue_wake_up(vi->cvq);
> > >       flush_work(&vi->rx_mode_work);
> > >  }
> > >
> > > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > >       return !oom;
> > >  }
> > >
> > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > +{
> > > +     virtqueue_wake_up(cvq);
> > > +}
> > > +
> > >  static void skb_recv_done(struct virtqueue *rvq)
> > >  {
> > >       struct virtnet_info *vi = rvq->vdev->priv;
> > > @@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> > >       return err;
> > >  }
> > >
> > > +static int virtnet_close(struct net_device *dev);
> > > +
> > >  /*
> > >   * Send command via the control virtqueue and check status.  Commands
> > >   * supported by the hypervisor, as indicated by feature bits, should
> > > @@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > >       if (unlikely(!virtqueue_kick(vi->cvq)))
> > >               return vi->ctrl->status == VIRTIO_NET_OK;
> > >
> > > -     /* Spin for a response, the kick causes an ioport write, trapping
> > > -      * into the hypervisor, so the request should be handled immediately.
> > > -      */
> > > -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > -            !virtqueue_is_broken(vi->cvq))
> > > -             cpu_relax();
> > > +     if (virtqueue_wait_for_used(vi->cvq)) {
> > > +             virtqueue_get_buf(vi->cvq, &tmp);
> > > +             return vi->ctrl->status == VIRTIO_NET_OK;
> > > +     }
> > >
> > > -     return vi->ctrl->status == VIRTIO_NET_OK;
> > > +     netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
> > > +     virtio_break_device(vi->vdev);
> > > +     return VIRTIO_NET_ERR;
> > >  }
> > >
> > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > > @@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > >
> > >       /* Parameters for control virtqueue, if any */
> > >       if (vi->has_cvq) {
> > > -             callbacks[total_vqs - 1] = NULL;
> > > +             callbacks[total_vqs - 1] = virtnet_cvq_done;
> > >               names[total_vqs - 1] = "control";
> > >       }
> > >
> > > --
> > > 2.25.1
> > >
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
