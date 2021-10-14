Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617F3C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:58:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A7A60FF2
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 05:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05A7A60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A78FD607E3;
	Thu, 14 Oct 2021 05:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M1PdKH1TegYk; Thu, 14 Oct 2021 05:58:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2F78C60788;
	Thu, 14 Oct 2021 05:58:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E723DC0011;
	Thu, 14 Oct 2021 05:58:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B16B1C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9457C406BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KNDfdduyMDSI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C25F9406B9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 05:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634191096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z9GNqF7oZ5ZxqDGvug1wa9zV0RT5V0MlCCCE4TEdHgM=;
 b=MfmzOsR3EKmLsXsFVq80JAVzk/wOLqTDLN1o8LoIfhzSer0BayqQA3HMUnj4uGFDMHtmDR
 p3ikiEtP6trIuNbiJTbapz89WJRePGdYd6lLPNYf4ZTLlZNvQMzZUCWFfAFtOG7sS/r8Bb
 fMS0cfRCvxIHnYhRuP6eYCyTK5v+G38=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-L1fMEsSkODSzUdwJ3ANNfQ-1; Thu, 14 Oct 2021 01:58:13 -0400
X-MC-Unique: L1fMEsSkODSzUdwJ3ANNfQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 10-20020a5d47aa000000b001610cbda93dso3648852wrb.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 22:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z9GNqF7oZ5ZxqDGvug1wa9zV0RT5V0MlCCCE4TEdHgM=;
 b=I0iXMkvMWeF0PPuobungkTL+DZ1+VWSg8zc/6xhbK5cPFRno+VkRpv9oTU/z7rfbU7
 oMporduBmELcRKWdSeWqMestKfm1pzCTPMfTFBbESfr4luwaGNdCqD3POyW6uU3dh8cK
 pSbO6/m2UWZRTs8b9AV7uygzHpZkyTi6ojz3jZ5LZz5s63aWh0u63sMMo3XTSfH4IQmK
 0KKv4zjfsMGJBZJTnCg1UGm8ono2wFaKxGCd4OcYFWAHc0bPKIsW2Q2O3+mDUmsqsVAI
 TnnyLKttN/LqmfBFyI5mGs6GAyWxr22x1ff4lBLGouYAfiP6TK8BuB5IqCgYlyeyXmcp
 IrBQ==
X-Gm-Message-State: AOAM5328Ot+AZVM2kT1CkPvjUqMXUjfrD+heqIs2ADQ8HQj9+c+cazXx
 a0/x00V2MPH5ayuocYTLbLiKe6TPMu3oFqR5CHkA+S+s2Jykmvp8cJI0TiGZ3TurqEjxrB0cVXo
 WZwsagPulZWNMzem1rkfbyNxUC3kxAL8Px/lGrHZu/w==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr4220621wrw.407.1634191092124; 
 Wed, 13 Oct 2021 22:58:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRsviF6B6TIbp4oMqx9j5CJVnbpO7qhFbnNiOh8GpPukKSxvqiwcjSFJhahubkVKwwS8mdhQ==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr4220609wrw.407.1634191091908; 
 Wed, 13 Oct 2021 22:58:11 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
 by smtp.gmail.com with ESMTPSA id d9sm1488789wrm.96.2021.10.13.22.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 22:58:11 -0700 (PDT)
Date: Thu, 14 Oct 2021 01:58:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 03/12] virtio-console: switch to use .validate()
Message-ID: <20211014015616-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-4-jasowang@redhat.com>
 <20211013054334-mutt-send-email-mst@kernel.org>
 <CACGkMEvYu4rMnhLtQfPo-BKME+cT9Sk1b39++f3BXZm1fTQHMQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvYu4rMnhLtQfPo-BKME+cT9Sk1b39++f3BXZm1fTQHMQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>, "kaplan,
 david" <david.kaplan@amd.com>, Amit Shah <amit@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Oct 14, 2021 at 10:28:06AM +0800, Jason Wang wrote:
> On Wed, Oct 13, 2021 at 5:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 02:52:18PM +0800, Jason Wang wrote:
> > > This patch switches to use validate() to filter out the features that
> > > is not supported by the rproc.
> >
> > are not supported
> >
> > >
> > > Cc: Amit Shah <amit@kernel.org>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > Does this have anything to do with hardening?
> >
> > It seems cleaner to not negotiate features we do not use,
> > but given we did this for many years ... should we bother
> > at this point?
> 
> It looks cleaner to do all the validation in one places:
> 
> 1) check unsupported feature for rproc
> 2) validate the max_nr_ports (as has been done in patch 4)
> 
> >
> >
> > > ---
> > >  drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
> > >  1 file changed, 26 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 7eaf303a7a86..daeed31df622 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
> > >
> > >       vdev = port->portdev->vdev;
> > >
> > > -     /* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> > > -     if (!is_rproc_serial(vdev) &&
> > > -         virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > > +     if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > >               hvc_resize(port->cons.hvc, port->cons.ws);
> > >  }
> > >
> > > @@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
> > >       kfree(portdev);
> > >  }
> > >
> > > +static int virtcons_validate(struct virtio_device *vdev)
> > > +{
> > > +     if (is_rproc_serial(vdev)) {
> > > +             /* Don't test F_SIZE at all if we're rproc: not a
> > > +              * valid feature! */
> >
> >
> > This comment needs to be fixed now. And the format's wrong
> > since you made it a multi-line comment.
> > Should be
> >         /*
> >          * like
> >          * this
> >          */
> 
> Ok.
> 
> >
> > > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
> > > +             /* Don't test MULTIPORT at all if we're rproc: not a
> > > +              * valid feature! */
> > > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> > > +     }
> > > +
> > > +     /* We only need a config space if features are offered */
> > > +     if (!vdev->config->get &&
> > > +         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > > +          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > > +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > > +                     __func__);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /*
> > >   * Once we're further in boot, we get probed like any other virtio
> > >   * device.
> >
> > This switches the order of tests around, so if an rproc device
> > offers VIRTIO_CONSOLE_F_SIZE or VIRTIO_CONSOLE_F_MULTIPORT
> > without get it will now try to work instead of failing.
> 
> Ok, so we can fail the validation in this case.

We can. But if we are going to, then it's easier to just fail probe.
Or if you want to try and work around this case,
that's also reasonable but pls document in the commit log.


> Thanks
> 
> >
> > Which is maybe a worthy goal, but given rproc does not support
> > virtio 1.0 it also risks trying to drive something completely
> > unreasonable.
> >
> > Overall does not feel like hardening which is supposed to make
> > things more strict, not less.
> >
> >
> > > @@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
> > >       bool multiport;
> > >       bool early = early_put_chars != NULL;
> > >
> > > -     /* We only need a config space if features are offered */
> > > -     if (!vdev->config->get &&
> > > -         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > > -          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > > -             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > > -                     __func__);
> > > -             return -EINVAL;
> > > -     }
> > > -
> > >       /* Ensure to read early_put_chars now */
> > >       barrier();
> > >
> > > @@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
> > >       multiport = false;
> > >       portdev->max_nr_ports = 1;
> > >
> > > -     /* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> > > -     if (!is_rproc_serial(vdev) &&
> > > -         virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> > > +     if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> > >                                struct virtio_console_config, max_nr_ports,
> > >                                &portdev->max_nr_ports) == 0) {
> > >               multiport = true;
> > > @@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
> > >       .driver.name =  KBUILD_MODNAME,
> > >       .driver.owner = THIS_MODULE,
> > >       .id_table =     id_table,
> > > +     .validate =     virtcons_validate,
> > >       .probe =        virtcons_probe,
> > >       .remove =       virtcons_remove,
> > >       .config_changed = config_intr,
> > > --
> > > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
