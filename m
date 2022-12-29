Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8571C4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 03:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CE7860C2A;
	Thu, 29 Dec 2022 03:22:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CE7860C2A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ca7uJiqP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sk_0i5ejd4OS; Thu, 29 Dec 2022 03:22:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B0E0A60C31;
	Thu, 29 Dec 2022 03:22:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0E0A60C31
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 771AAC0032;
	Thu, 29 Dec 2022 03:22:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19B2FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 03:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D47068176B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 03:22:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D47068176B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ca7uJiqP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZkPtgLGqy7N
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 03:22:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD57B8176A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD57B8176A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 03:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672284147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9BpqrE0CuCNq8PSJ8RLUJySWEaGLuhrI4cjH6ZXXph4=;
 b=ca7uJiqPxvFbma05EMgglKLbFP9RONv8nqgm3xGoxCq+atWzQKlIUzeyk7iDVhC3zB5FEP
 qqSCWOFxP0TuMGXQXJpYcfEo8MQOA+suEXO5S84B94NRw74aMksJzuRw+5zmX/OX9V8rqJ
 xyFa4G0Sl+UbUIs8GJ3y6mSmm4O0nio=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-L2PJ7ZvXOkaEV33wP867gg-1; Wed, 28 Dec 2022 22:22:25 -0500
X-MC-Unique: L2PJ7ZvXOkaEV33wP867gg-1
Received: by mail-ot1-f70.google.com with SMTP id
 bq2-20020a056830388200b00672e4a07168so9585947otb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 19:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BpqrE0CuCNq8PSJ8RLUJySWEaGLuhrI4cjH6ZXXph4=;
 b=YHnnO4t8nhKef8QloGjbaDlifcofwjQdT2NiM/NXmbDjEwNR4gqQTF8bnjw4TElM3R
 2S///PUgP1vmaWEChV7J9rPxjyTK0iq/GqhA8DS0dd4qP/RiyFjCJ/LaW7WBrY77UVpC
 F2XyEE1wc2lkT3GgMJtOyRyF1dKObH9fpaTgEqcJ6zdelqZeVEtU+4zxeCCp6GRwEjhp
 0DQSFWk5N9XaSlpUj/adMtuda5IFV6bbY9k9y9sj0l42Ip58WzNiRT0qqiHimV4+wEkr
 pqvKP22Q35OtcjhpdhbI4YTr81/uwhup4LwRGb+y2PBbnGQHQuWjT9mZjWSI+Mc397YK
 u0QQ==
X-Gm-Message-State: AFqh2krbnl8GVAZ9+ZBzuSsUegSsMNYUZo1mvEZaTxZcMh9/cURJH/23
 xDOnSW1O9mg8UBhazut4nXbCEHDXgYaiKnnorrsaMRxzv2iiAHWiYhzh23ef9n9pmh9LPjq9g91
 g8Zsif+a5GpBIa1MwODUQRISWVwXPvrA3+hzuBlNlMcEccXByENAMWOhdzg==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr1349912oah.35.1672284144890; 
 Wed, 28 Dec 2022 19:22:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsl9gULWwNmOCV4XIla9Vz7brSNSb7Xq5lIOeH04gCIi128/IiqNQZ2o2MYUjGeX3D9N5CnhUwfAjfW1EE2maU=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr1349904oah.35.1672284144560; Wed, 28
 Dec 2022 19:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
 <1672216298.4455094-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuADspVzge5Q8JdEQssjGg911CaT1u_NQ9s7i-7UMwkhg@mail.gmail.com>
 <1672279792.8628097-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1672279792.8628097-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Dec 2022 11:22:13 +0800
Message-ID: <CACGkMEsET7fKxuKu7NckZX5N8fs+AqZ-adwKFNixJRNNn09GRQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, kuba@kernel.org,
 maxime.coquelin@redhat.com, pabeni@redhat.com, davem@davemloft.net
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

On Thu, Dec 29, 2022 at 10:10 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 28 Dec 2022 19:41:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Dec 28, 2022 at 4:34 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Tue, 27 Dec 2022 01:58:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Dec 27, 2022 at 12:33:53PM +0800, Jason Wang wrote:
> > > > > On Tue, Dec 27, 2022 at 10:25 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >
> > > > > > On Mon, 26 Dec 2022 15:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > We used to busy waiting on the cvq command this tends to be
> > > > > > > problematic since:
> > > > > > >
> > > > > > > 1) CPU could wait for ever on a buggy/malicous device
> > > > > > > 2) There's no wait to terminate the process that triggers the cvq
> > > > > > >    command
> > > > > > >
> > > > > > > So this patch switch to use virtqueue_wait_for_used() to sleep with a
> > > > > > > timeout (1s) instead of busy polling for the cvq command forever. This
> > > > > >
> > > > > > I don't think that a fixed 1S is a good choice.
> > > > >
> > > > > Well, it could be tweaked to be a little bit longer.
> > > > >
> > > > > One way, as discussed, is to let the device advertise a timeout then
> > > > > the driver can validate if it's valid and use that timeout. But it
> > > > > needs extension to the spec.
> > > >
> > > > Controlling timeout from device is a good idea, e.g. hardware devices
> > > > would benefit from a shorter timeout, hypervisor devices from a longer
> > > > timeout or no timeout.
> > >
> > > Yes. That is good.
> > >
> > > Before introducing this feature, I personally like to use "wait", rather than
> > > define a timeout.
> >
> > Note that the driver still needs to validate what device advertises to
> > avoid infinite wait.
>
> Sorry, I didn't understand what you mean.

I meant the interface needs to carefully designed to

1) avoid device to advertise a infinite (or very long) timeout
2) driver need to have its own max timeout regardless what device advertises

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > >
> > > > > > Some of the DPUs are very
> > > > > > lazy for cvq handle.
> > > > >
> > > > > Such design needs to be revisited, cvq (control path) should have a
> > > > > better priority or QOS than datapath.
> > > >
> > > > Spec says nothing about this, so driver can't assume this either.
> > > >
> > > > > > In particular, we will also directly break the device.
> > > > >
> > > > > It's kind of hardening for malicious devices.
> > > >
> > > > ATM no amount of hardening can prevent a malicious hypervisor from
> > > > blocking the guest. Recovering when a hardware device is broken would be
> > > > nice but I think if we do bother then we should try harder to recover,
> > > > such as by driving device reset.
> > > >
> > > >
> > > > Also, does your patch break surprise removal? There's no callback
> > > > in this case ATM.
> > > >
> > > > > >
> > > > > > I think it is necessary to add a Virtio-Net parameter to allow users to define
> > > > > > this timeout by themselves. Although I don't think this is a good way.
> > > > >
> > > > > Very hard and unfriendly to the end users.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > > gives the scheduler a breath and can let the process can respond to
> > > > > > > asignal. If the device doesn't respond in the timeout, break the
> > > > > > > device.
> > > > > > >
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > ---
> > > > > > > Changes since V1:
> > > > > > > - break the device when timeout
> > > > > > > - get buffer manually since the virtio core check more_used() instead
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 24 ++++++++++++++++--------
> > > > > > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > index efd9dd55828b..6a2ea64cfcb5 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> > > > > > >       vi->rx_mode_work_enabled = false;
> > > > > > >       spin_unlock_bh(&vi->rx_mode_lock);
> > > > > > >
> > > > > > > +     virtqueue_wake_up(vi->cvq);
> > > > > > >       flush_work(&vi->rx_mode_work);
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > >       return !oom;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > > > > > +{
> > > > > > > +     virtqueue_wake_up(cvq);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static void skb_recv_done(struct virtqueue *rvq)
> > > > > > >  {
> > > > > > >       struct virtnet_info *vi = rvq->vdev->priv;
> > > > > > > @@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> > > > > > >       return err;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int virtnet_close(struct net_device *dev);
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * Send command via the control virtqueue and check status.  Commands
> > > > > > >   * supported by the hypervisor, as indicated by feature bits, should
> > > > > > > @@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > >       if (unlikely(!virtqueue_kick(vi->cvq)))
> > > > > > >               return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > >
> > > > > > > -     /* Spin for a response, the kick causes an ioport write, trapping
> > > > > > > -      * into the hypervisor, so the request should be handled immediately.
> > > > > > > -      */
> > > > > > > -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > -            !virtqueue_is_broken(vi->cvq))
> > > > > > > -             cpu_relax();
> > > > > > > +     if (virtqueue_wait_for_used(vi->cvq)) {
> > > > > > > +             virtqueue_get_buf(vi->cvq, &tmp);
> > > > > > > +             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > +     }
> > > > > > >
> > > > > > > -     return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > +     netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
> > > > > > > +     virtio_break_device(vi->vdev);
> > > > > > > +     return VIRTIO_NET_ERR;
> > > > > > >  }
> > > > > > >
> > > > > > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > > > > > > @@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > > > >
> > > > > > >       /* Parameters for control virtqueue, if any */
> > > > > > >       if (vi->has_cvq) {
> > > > > > > -             callbacks[total_vqs - 1] = NULL;
> > > > > > > +             callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > > > >               names[total_vqs - 1] = "control";
> > > > > > >       }
> > > > > > >
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > Virtualization mailing list
> > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > >
> > > >
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
