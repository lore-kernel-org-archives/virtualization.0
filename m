Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C241AC433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 17:05:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F6B61406
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 17:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63F6B61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1373240157;
	Mon,  8 Nov 2021 17:05:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWI2oV2qsA_R; Mon,  8 Nov 2021 17:05:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47761400BF;
	Mon,  8 Nov 2021 17:05:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D9EAC0012;
	Mon,  8 Nov 2021 17:05:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DA42C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 17:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1A06606E7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 17:05:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mx9DCAYWgw_Y
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 17:05:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D00466064C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636391135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NPqsXHRTDDOKAO8W4fUMxrj4GjcH6LfmhyAuBTyX3XQ=;
 b=T5aDw8+xNgUWy0lDMrRmwpy0kN/w7AD9dofy2zRgkS0t4vJ2g+olpOzbr8LaiSrRbtBVc6
 DIwyNKrX2T1PyXqMfosSe/9EaEGGVcPIAfUR+jbANpUX82LCxTBFFT8bzbFnpT65aqLii2
 xUoKi7uQlf8FZ5Y56jl4N0q6j2iA+qs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-zy-2JeN4N5OW-1Ypm2I7yQ-1; Mon, 08 Nov 2021 12:05:34 -0500
X-MC-Unique: zy-2JeN4N5OW-1Ypm2I7yQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 q6-20020a056402518600b003e28d92bb85so15415566edd.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 09:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NPqsXHRTDDOKAO8W4fUMxrj4GjcH6LfmhyAuBTyX3XQ=;
 b=EZBks7FColAeAc3Ukc2G7CQsSfP3rRyraFLhElGbPXn6GVlAE8nwPunIJ2R9XsP1QK
 07QslhLdMJP9tjkZDe07xJv+T/H9WdeOGFSWLTjiuvKLdngV5Oq7bRJh/VzE3JqoLRfW
 gV7H2KRsTYiEf1ot9nwMbaaB0SnsDGthK1Qzj+TNbaAmCcmw5iNV7oaMyoFuZ0A8Fyei
 +m5GFev1oNKeaxU7hTPncxrZE7QPI9msbugRJLFr9+eZFsehbySxMoYruhAPpNLDnPmn
 pcKKlrp3NI9RungIhKQJH3ekF6kVDNSHevOLgbzsXwdyiWEysvaO9kkQkBxUwlOVwR/+
 +FwQ==
X-Gm-Message-State: AOAM533IhcCEkpXd4kS9kUhwEA22vuofZ/nm08aQvA6xYr4TAiFEWvd1
 Hl47X3wXBACqgTPIyAUJnip+CDyVXkr83qGytFAkfueKJNBOJutZ4FCLZXWxfpWgi9I9aL2P8pX
 8d2G9U/ntmK2hMfsuYUfavRu8Nb8jDUZs6W+XYYKc9A==
X-Received: by 2002:aa7:c158:: with SMTP id r24mr773678edp.65.1636391133519;
 Mon, 08 Nov 2021 09:05:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdw4FnpJrfj9fDfoGHK7Ece1hu0YLzV6RUjD3WLZnwwX1Kp9CmaEpRsJ1TBVXOx89iy94Nng==
X-Received: by 2002:aa7:c158:: with SMTP id r24mr773644edp.65.1636391133325;
 Mon, 08 Nov 2021 09:05:33 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id h10sm9883575edk.41.2021.11.08.09.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 09:05:32 -0800 (PST)
Date: Mon, 8 Nov 2021 18:05:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <CAGxU2F4NQz74f8sw51Ownm-25Jd7K=B_gK_-nRDKmmYvPx=+=w@mail.gmail.com>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, Nov 5, 2021 at 4:01 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > `driver_override` allows to control which of the vDPA bus drivers
> > binds to a vDPA device.
> >
> > If `driver_override` is not set, the previous behaviour is followed:
> > devices use the first vDPA bus driver loaded (unless auto binding
> > is disabled).
> >
> > Tested on Fedora 34 with driverctl(8):
> >   $ modprobe virtio-vdpa
> >   $ modprobe vhost-vdpa
> >   $ modprobe vdpa-sim-net
> >
> >   $ vdpa dev add mgmtdev vdpasim_net name dev1
> >
> >   # dev1 is attached to the first vDPA bus driver loaded
> >   $ driverctl -b vdpa list-devices
> >     dev1 virtio_vdpa
> >
> >   $ driverctl -b vdpa set-override dev1 vhost_vdpa
> >
> >   $ driverctl -b vdpa list-devices
> >     dev1 vhost_vdpa [*]
> >
> >   Note: driverctl(8) integrates with udev so the binding is
> >   preserved.
> >
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  include/linux/vdpa.h |  2 ++
> >  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 76 insertions(+)
> >
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index c3011ccda430..ae34015b37b7 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
> >   * struct vdpa_device - representation of a vDPA device
> >   * @dev: underlying device
> >   * @dma_dev: the actual device that is performing DMA
> > + * @driver_override: driver name to force a match
>
> This seems useless?
>
> >   * @config: the configuration ops for this device.
> >   * @cf_mutex: Protects get and set access to configuration layout.
> >   * @index: device index
> > @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
> >  struct vdpa_device {
> >         struct device dev;
> >         struct device *dma_dev;
> > +       const char *driver_override;
> >         const struct vdpa_config_ops *config;
> >         struct mutex cf_mutex; /* Protects get/set config */
> >         unsigned int index;
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 7332a74a4b00..659231bbfee8 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
> >                 drv->remove(vdev);
> >  }
> >
> > +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
> > +{
> > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > +
> > +       /* Check override first, and if set, only use the named driver */
> > +       if (vdev->driver_override)
> > +               return strcmp(vdev->driver_override, drv->name) == 0;
> > +
> > +       /* Currently devices must be supported by all vDPA bus drivers */
> > +       return 1;
> > +}
> > +
> > +static ssize_t driver_override_store(struct device *dev,
> > +                                    struct device_attribute *attr,
> > +                                    const char *buf, size_t count)
> > +{
> > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > +       const char *driver_override, *old;
> > +       char *cp;
> > +
> > +       /* We need to keep extra room for a newline */
> > +       if (count >= (PAGE_SIZE - 1))
> > +               return -EINVAL;
> > +
> > +       driver_override = kstrndup(buf, count, GFP_KERNEL);
> > +       if (!driver_override)
> > +               return -ENOMEM;
> > +
> > +       cp = strchr(driver_override, '\n');
> > +       if (cp)
> > +               *cp = '\0';
> > +
> > +       device_lock(dev);
> > +       old = vdev->driver_override;
> > +       if (strlen(driver_override)) {
> > +               vdev->driver_override = driver_override;
> > +       } else {
> > +               kfree(driver_override);
> > +               vdev->driver_override = NULL;
> > +       }
> > +       device_unlock(dev);
> > +
> > +       kfree(old);
> > +
> > +       return count;
> > +}
> > +
> > +static ssize_t driver_override_show(struct device *dev,
> > +                                   struct device_attribute *attr, char *buf)
> > +{
> > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > +       ssize_t len;
> > +
> > +       device_lock(dev);
> > +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
> > +       device_unlock(dev);
> > +
> > +       return len;
> > +}
> > +static DEVICE_ATTR_RW(driver_override);
> > +
> > +static struct attribute *vdpa_dev_attrs[] = {
> > +       &dev_attr_driver_override.attr,
> > +       NULL,
> > +};
> > +
> > +static const struct attribute_group vdpa_dev_group = {
> > +       .attrs  = vdpa_dev_attrs,
> > +};
> > +__ATTRIBUTE_GROUPS(vdpa_dev);
> > +
> >  static struct bus_type vdpa_bus = {
> >         .name  = "vdpa",
> > +       .dev_groups = vdpa_dev_groups,
>
> This reminds me that we probably need to document the sysfs interface
> in Documentation/ABI/testing/sysfs-bus-vdpa.
>
> But it's not the fault of this patch which look good.

Michael, Jason, about Documentation/ABI/testing/sysfs-bus-vdpa, do you 
think is better to send a follow up patch/series, maybe including also 
others entries (e.g. bind, unbind) or a v2 including the documentation 
of `driver_ovveride`?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
