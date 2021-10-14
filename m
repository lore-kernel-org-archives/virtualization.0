Return-Path: <SRS0=Buhk=PC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45285C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:28:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC61E610D0
	for <virtualization@archiver.kernel.org>; Thu, 14 Oct 2021 02:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC61E610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 118F540022;
	Thu, 14 Oct 2021 02:28:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SNsfB4dVgvjR; Thu, 14 Oct 2021 02:28:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ABD5D406F5;
	Thu, 14 Oct 2021 02:28:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93023C000F;
	Thu, 14 Oct 2021 02:28:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63443C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50C3C401C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:28:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yygiztrt9Fcj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:28:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C3C940108
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Oct 2021 02:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634178506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1vAasFCi1yTdsgtadRT4Vzr5q4cOBpL6MRDEc7M/lE=;
 b=BOpNg82mQRRoEi72h8bz7dRQt/ZBxN0Yxi7fBh5FIesGkqWXXlZiaRXOk2cOTOoBsjJrIT
 8y9+KDjaRTqnFlrjgIWLV+5NOSziMEY+yyh+P2Uz8Ym8tRI3Nzc4wcVSELwr2dFH1NpJEI
 3ntEb87Uf6lW35dnIfMb74STyRAVG+s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-ETBQlQo4MfCghNnAAZg-BQ-1; Wed, 13 Oct 2021 22:28:21 -0400
X-MC-Unique: ETBQlQo4MfCghNnAAZg-BQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 s8-20020ac25c48000000b003faf62e104eso3284622lfp.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 19:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P1vAasFCi1yTdsgtadRT4Vzr5q4cOBpL6MRDEc7M/lE=;
 b=tv0CcKGQgBSCmhxflwPl34qZAwoZsjKUsCn/jXzyBigH3zs9kvtbTTXN9nkJCCotA/
 K+vHEk8dj3INY3tNIVxQJim6CtBdMkNqNiuPKLarM8avlecaoOPHU1xLYwB5ncdtTAS3
 tzWRVaAc58b1IOFvJhlGp15Hie1h69STI2whQV3g7DtZ4/OTp8Yucu2EZsI47Jq4CRbx
 4k4fYXbk0XFqjXSfwCZG73GdcfMg4wxyew6pEtmQBqjlOQx0pE/kvtoaICxETu5IY302
 aBlXNnOElqHshwL1fPaJPZoUgftGtE2qyaG9WzSZgaMkp8v92avEsXdvxOg4xYEQqiEp
 uDgQ==
X-Gm-Message-State: AOAM531bd828KULhwAiekLm0DzpgywPDaLXwPHaCDpgUeJbg4kylzn8X
 wMdh4BEFswgFWpn4A9dfJ7/+3/5m02z0K2IB3tdV/Cp4FpqsXDvvJfaP6MQ+Zlzrwf6IOG7KqDs
 P5wvT6JVF2fqGFKZc5BCrhzl4L/3MpCCFiPEzJe4ZfroHAijqt+yJ9hOvBQ==
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2694131lfr.348.1634178500018; 
 Wed, 13 Oct 2021 19:28:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9pxV7x1HBT4oxol3ePyrSgQibEXDD9D8upQ79p3LIv4kV1qwZLq2/dBjeTUeShMCPm/x77qn/0iQhiCSrGDo=
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2694102lfr.348.1634178499672; 
 Wed, 13 Oct 2021 19:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-4-jasowang@redhat.com>
 <20211013054334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013054334-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Oct 2021 10:28:06 +0800
Message-ID: <CACGkMEvYu4rMnhLtQfPo-BKME+cT9Sk1b39++f3BXZm1fTQHMQ@mail.gmail.com>
Subject: Re: [PATCH V2 03/12] virtio-console: switch to use .validate()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Oct 13, 2021 at 5:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:18PM +0800, Jason Wang wrote:
> > This patch switches to use validate() to filter out the features that
> > is not supported by the rproc.
>
> are not supported
>
> >
> > Cc: Amit Shah <amit@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> Does this have anything to do with hardening?
>
> It seems cleaner to not negotiate features we do not use,
> but given we did this for many years ... should we bother
> at this point?

It looks cleaner to do all the validation in one places:

1) check unsupported feature for rproc
2) validate the max_nr_ports (as has been done in patch 4)

>
>
> > ---
> >  drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 7eaf303a7a86..daeed31df622 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
> >
> >       vdev = port->portdev->vdev;
> >
> > -     /* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> > -     if (!is_rproc_serial(vdev) &&
> > -         virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > +     if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> >               hvc_resize(port->cons.hvc, port->cons.ws);
> >  }
> >
> > @@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
> >       kfree(portdev);
> >  }
> >
> > +static int virtcons_validate(struct virtio_device *vdev)
> > +{
> > +     if (is_rproc_serial(vdev)) {
> > +             /* Don't test F_SIZE at all if we're rproc: not a
> > +              * valid feature! */
>
>
> This comment needs to be fixed now. And the format's wrong
> since you made it a multi-line comment.
> Should be
>         /*
>          * like
>          * this
>          */

Ok.

>
> > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
> > +             /* Don't test MULTIPORT at all if we're rproc: not a
> > +              * valid feature! */
> > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> > +     }
> > +
> > +     /* We only need a config space if features are offered */
> > +     if (!vdev->config->get &&
> > +         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > +          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +                     __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Once we're further in boot, we get probed like any other virtio
> >   * device.
>
> This switches the order of tests around, so if an rproc device
> offers VIRTIO_CONSOLE_F_SIZE or VIRTIO_CONSOLE_F_MULTIPORT
> without get it will now try to work instead of failing.

Ok, so we can fail the validation in this case.

Thanks

>
> Which is maybe a worthy goal, but given rproc does not support
> virtio 1.0 it also risks trying to drive something completely
> unreasonable.
>
> Overall does not feel like hardening which is supposed to make
> things more strict, not less.
>
>
> > @@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
> >       bool multiport;
> >       bool early = early_put_chars != NULL;
> >
> > -     /* We only need a config space if features are offered */
> > -     if (!vdev->config->get &&
> > -         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > -          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > -             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > -                     __func__);
> > -             return -EINVAL;
> > -     }
> > -
> >       /* Ensure to read early_put_chars now */
> >       barrier();
> >
> > @@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
> >       multiport = false;
> >       portdev->max_nr_ports = 1;
> >
> > -     /* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> > -     if (!is_rproc_serial(vdev) &&
> > -         virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> > +     if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> >                                struct virtio_console_config, max_nr_ports,
> >                                &portdev->max_nr_ports) == 0) {
> >               multiport = true;
> > @@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
> >       .driver.name =  KBUILD_MODNAME,
> >       .driver.owner = THIS_MODULE,
> >       .id_table =     id_table,
> > +     .validate =     virtcons_validate,
> >       .probe =        virtcons_probe,
> >       .remove =       virtcons_remove,
> >       .config_changed = config_intr,
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
