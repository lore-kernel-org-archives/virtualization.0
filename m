Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDDCC4167B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 04:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C150260BD9;
	Tue, 27 Dec 2022 04:34:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C150260BD9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YgDZtzLt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1sSQYyBGpfI4; Tue, 27 Dec 2022 04:34:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FAB360BA1;
	Tue, 27 Dec 2022 04:34:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FAB360BA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC96EC0035;
	Tue, 27 Dec 2022 04:34:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F863C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1231C4081F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1231C4081F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YgDZtzLt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iByD-mNZViUT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:34:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9321E4071E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9321E4071E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 04:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672115646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bLVMwljC7O+CWcnKyQoxnEA4xSzKKq2Chko3D5CrdLA=;
 b=YgDZtzLt5ajyoDfGojb0AzI2JvXKTIsuhCHS+MerBfCoiLQXBRbERcwVPG3XRVbfv1ZgjV
 PnQa/bghuHFduxZvzD2a/ZSqDNeIqxT0gQZlq+6fw/wdGukof1oKR4j4DU7BXrDsuANAyv
 4aQSGTOH/JF2+pmNk5WNRbCDPpdO9Os=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-41-G3HeR6XvMoeMozbe7KjsmQ-1; Mon, 26 Dec 2022 23:34:05 -0500
X-MC-Unique: G3HeR6XvMoeMozbe7KjsmQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-144ea535efbso5854223fac.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 20:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bLVMwljC7O+CWcnKyQoxnEA4xSzKKq2Chko3D5CrdLA=;
 b=2YnqIagTs3Q053W5d0Fu3HlqeWEFK+UNJ/k4jV6ZcsVuk2/O3kfmnzWfzzeLh/I0XA
 Go6i8jHLRYuMoksWb/xFA+C3+o+SE4l5vZnS65ClBtFUAOoetRIiMyDATQHq9QSsVtD2
 l1SLbaShTtnXIbn4M5fgMeiAdqWtybc0EVCXB3/QV6wSW2q1OmEzDHmeEWWzNHJjRdOw
 RDA2IyMaiB+gKVLQ1pSXCBKCMNJionzT1vppDtRoYnml5HEJcDE0TYvXLUK9ds4cLb5/
 gOu81jv2tW7nPCaIm7YwdBoFXcC1QoneJslBknDuCgGxi35ApoBDEBknhvfoIm/PM5+Z
 1kcw==
X-Gm-Message-State: AFqh2kq8MP1sALQ7RktiLdM8sjBVhS+AbGyOYiBljxF1Hh42UNN1Cl26
 FrfxWDehaY1CJxvCXpt1yebm1XBTldhPE43t6EU7EASrZHuFVL8e1OKgNcMi0oEQ6RMGXmohkAk
 WjFogsT1I46lsqZIi3GxTT7aLJPglCLJQnuOgMQjvlX07YmgLFRmEFdUNxA==
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr999928oah.35.1672115644481; 
 Mon, 26 Dec 2022 20:34:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZAN7oKMf0wM3k63DQM44GpupAtM1md6Fw5I1P4sbRhDpAg5v73EA67TgqjKvQwX0A4ZadODRhmJ0ZibTXUNE=
X-Received: by 2002:a05:6870:4413:b0:144:a97b:1ae2 with SMTP id
 u19-20020a056870441300b00144a97b1ae2mr999924oah.35.1672115644270; Mon, 26 Dec
 2022 20:34:04 -0800 (PST)
MIME-Version: 1.0
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Dec 2022 12:33:53 +0800
Message-ID: <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, Dec 27, 2022 at 10:25 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 26 Dec 2022 15:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > We used to busy waiting on the cvq command this tends to be
> > problematic since:
> >
> > 1) CPU could wait for ever on a buggy/malicous device
> > 2) There's no wait to terminate the process that triggers the cvq
> >    command
> >
> > So this patch switch to use virtqueue_wait_for_used() to sleep with a
> > timeout (1s) instead of busy polling for the cvq command forever. This
>
> I don't think that a fixed 1S is a good choice.

Well, it could be tweaked to be a little bit longer.

One way, as discussed, is to let the device advertise a timeout then
the driver can validate if it's valid and use that timeout. But it
needs extension to the spec.

> Some of the DPUs are very
> lazy for cvq handle.

Such design needs to be revisited, cvq (control path) should have a
better priority or QOS than datapath.

> In particular, we will also directly break the device.

It's kind of hardening for malicious devices.

>
> I think it is necessary to add a Virtio-Net parameter to allow users to define
> this timeout by themselves. Although I don't think this is a good way.

Very hard and unfriendly to the end users.

Thanks

>
> Thanks.
>
>
> > gives the scheduler a breath and can let the process can respond to
> > asignal. If the device doesn't respond in the timeout, break the
> > device.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - break the device when timeout
> > - get buffer manually since the virtio core check more_used() instead
> > ---
> >  drivers/net/virtio_net.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index efd9dd55828b..6a2ea64cfcb5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> >       vi->rx_mode_work_enabled = false;
> >       spin_unlock_bh(&vi->rx_mode_lock);
> >
> > +     virtqueue_wake_up(vi->cvq);
> >       flush_work(&vi->rx_mode_work);
> >  }
> >
> > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> >       return !oom;
> >  }
> >
> > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > +{
> > +     virtqueue_wake_up(cvq);
> > +}
> > +
> >  static void skb_recv_done(struct virtqueue *rvq)
> >  {
> >       struct virtnet_info *vi = rvq->vdev->priv;
> > @@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> >       return err;
> >  }
> >
> > +static int virtnet_close(struct net_device *dev);
> > +
> >  /*
> >   * Send command via the control virtqueue and check status.  Commands
> >   * supported by the hypervisor, as indicated by feature bits, should
> > @@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> >       if (unlikely(!virtqueue_kick(vi->cvq)))
> >               return vi->ctrl->status == VIRTIO_NET_OK;
> >
> > -     /* Spin for a response, the kick causes an ioport write, trapping
> > -      * into the hypervisor, so the request should be handled immediately.
> > -      */
> > -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > -            !virtqueue_is_broken(vi->cvq))
> > -             cpu_relax();
> > +     if (virtqueue_wait_for_used(vi->cvq)) {
> > +             virtqueue_get_buf(vi->cvq, &tmp);
> > +             return vi->ctrl->status == VIRTIO_NET_OK;
> > +     }
> >
> > -     return vi->ctrl->status == VIRTIO_NET_OK;
> > +     netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
> > +     virtio_break_device(vi->vdev);
> > +     return VIRTIO_NET_ERR;
> >  }
> >
> >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > @@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> >
> >       /* Parameters for control virtqueue, if any */
> >       if (vi->has_cvq) {
> > -             callbacks[total_vqs - 1] = NULL;
> > +             callbacks[total_vqs - 1] = virtnet_cvq_done;
> >               names[total_vqs - 1] = "control";
> >       }
> >
> > --
> > 2.25.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
