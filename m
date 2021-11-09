Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E3C433F5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:11:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6459461105
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6459461105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29E68403C4;
	Tue,  9 Nov 2021 13:11:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gthqQcSSyHZj; Tue,  9 Nov 2021 13:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B717C40362;
	Tue,  9 Nov 2021 13:11:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91F56C0012;
	Tue,  9 Nov 2021 13:11:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83E58C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66AC080F2C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:11:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2FdVz8iZbKg
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:11:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35D4580DAA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636463468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkGOhx5eenLdT0pj0I1U37NyfCFn4kD6anHY0qhKa3Q=;
 b=JOuHuXWdItlQStCyBxwLYIbB2Apic50uNk94oX/l3PNnMNshq55u6FwWbV9fEgF18Zfwe2
 9j49zzocCR+NEn35FuAk2ElCzzE1951C+m55jb1S7quC2h2xVjW+qu1Quz2Y6/I5AFVsae
 CzPJQs/r0JtuPGzR1id7RGZRQuj8nKs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-Afs41zQ9NSOFk7zggTO5_w-1; Tue, 09 Nov 2021 08:11:04 -0500
X-MC-Unique: Afs41zQ9NSOFk7zggTO5_w-1
Received: by mail-ed1-f71.google.com with SMTP id
 g3-20020a056402424300b003e2981e1edbso17973174edb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Nov 2021 05:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FkGOhx5eenLdT0pj0I1U37NyfCFn4kD6anHY0qhKa3Q=;
 b=m8AD24qNHJfipGuIMv6UIiQsjTeJZEBTpmxP8w/4Ml6LCxoj3QFdw68U3AG0Ha9YK/
 DFFFelKURtoZ6FMfI+Btjoams30zVYEHlsBqisWOaaeo4nEIEHbBiQouxMQgHxR1Emsg
 yYEColA7y+9JzFZ8dMn3OxUDS4+30s0Z3Dif9ao4WCAUrblyha/75uetccadWkYLFeVb
 y5GuJjv/jDdjuyvOoErs25EKTDpfvUmxzop4qyWe5qde9Aje7JnWggwDGLiKiaH8emTd
 lL9P+PZd007WQHFzz6zCidM91fbrPhA8Y0ZZagsL16Tliqj0Itz2oO1uXqrcl8msMApX
 0VgQ==
X-Gm-Message-State: AOAM532/QtOqoEfZXdCEdjVKy0KexNq364wBGI8rH2oR1MPvVIqC1YpZ
 J14B+wxTAdsv5o7f0jJ3/7B7aD2lh6pexiO77yg5o1sPSVh3j+7owBgJS4EW289Uzrb83fLN/Xj
 Za1BjRzT/NO15uRFvqOC2YIRChxbVB3FotepGIRmZJg==
X-Received: by 2002:a17:906:b1d8:: with SMTP id
 bv24mr9540238ejb.226.1636463463533; 
 Tue, 09 Nov 2021 05:11:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwafTIpzLlFwfQ4ZdK/4EENOrKMZAfE7ZNrWhQMI9KqiIqGY0UHnciowt7VoXLfn67LOvyDQA==
X-Received: by 2002:a17:906:b1d8:: with SMTP id
 bv24mr9540205ejb.226.1636463463317; 
 Tue, 09 Nov 2021 05:11:03 -0800 (PST)
Received: from redhat.com ([2.55.133.41])
 by smtp.gmail.com with ESMTPSA id t23sm10989515edc.95.2021.11.09.05.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 05:11:01 -0800 (PST)
Date: Tue, 9 Nov 2021 08:10:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <20211109081042-mutt-send-email-mst@kernel.org>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
 <CAGxU2F4NQz74f8sw51Ownm-25Jd7K=B_gK_-nRDKmmYvPx=+=w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGxU2F4NQz74f8sw51Ownm-25Jd7K=B_gK_-nRDKmmYvPx=+=w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

On Mon, Nov 08, 2021 at 06:05:29PM +0100, Stefano Garzarella wrote:
> On Fri, Nov 5, 2021 at 4:01 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >
> > > `driver_override` allows to control which of the vDPA bus drivers
> > > binds to a vDPA device.
> > >
> > > If `driver_override` is not set, the previous behaviour is followed:
> > > devices use the first vDPA bus driver loaded (unless auto binding
> > > is disabled).
> > >
> > > Tested on Fedora 34 with driverctl(8):
> > >   $ modprobe virtio-vdpa
> > >   $ modprobe vhost-vdpa
> > >   $ modprobe vdpa-sim-net
> > >
> > >   $ vdpa dev add mgmtdev vdpasim_net name dev1
> > >
> > >   # dev1 is attached to the first vDPA bus driver loaded
> > >   $ driverctl -b vdpa list-devices
> > >     dev1 virtio_vdpa
> > >
> > >   $ driverctl -b vdpa set-override dev1 vhost_vdpa
> > >
> > >   $ driverctl -b vdpa list-devices
> > >     dev1 vhost_vdpa [*]
> > >
> > >   Note: driverctl(8) integrates with udev so the binding is
> > >   preserved.
> > >
> > > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  include/linux/vdpa.h |  2 ++
> > >  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 76 insertions(+)
> > >
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index c3011ccda430..ae34015b37b7 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
> > >   * struct vdpa_device - representation of a vDPA device
> > >   * @dev: underlying device
> > >   * @dma_dev: the actual device that is performing DMA
> > > + * @driver_override: driver name to force a match
> >
> > This seems useless?
> >
> > >   * @config: the configuration ops for this device.
> > >   * @cf_mutex: Protects get and set access to configuration layout.
> > >   * @index: device index
> > > @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
> > >  struct vdpa_device {
> > >         struct device dev;
> > >         struct device *dma_dev;
> > > +       const char *driver_override;
> > >         const struct vdpa_config_ops *config;
> > >         struct mutex cf_mutex; /* Protects get/set config */
> > >         unsigned int index;
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 7332a74a4b00..659231bbfee8 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
> > >                 drv->remove(vdev);
> > >  }
> > >
> > > +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
> > > +{
> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > > +
> > > +       /* Check override first, and if set, only use the named driver */
> > > +       if (vdev->driver_override)
> > > +               return strcmp(vdev->driver_override, drv->name) == 0;
> > > +
> > > +       /* Currently devices must be supported by all vDPA bus drivers */
> > > +       return 1;
> > > +}
> > > +
> > > +static ssize_t driver_override_store(struct device *dev,
> > > +                                    struct device_attribute *attr,
> > > +                                    const char *buf, size_t count)
> > > +{
> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > > +       const char *driver_override, *old;
> > > +       char *cp;
> > > +
> > > +       /* We need to keep extra room for a newline */
> > > +       if (count >= (PAGE_SIZE - 1))
> > > +               return -EINVAL;
> > > +
> > > +       driver_override = kstrndup(buf, count, GFP_KERNEL);
> > > +       if (!driver_override)
> > > +               return -ENOMEM;
> > > +
> > > +       cp = strchr(driver_override, '\n');
> > > +       if (cp)
> > > +               *cp = '\0';
> > > +
> > > +       device_lock(dev);
> > > +       old = vdev->driver_override;
> > > +       if (strlen(driver_override)) {
> > > +               vdev->driver_override = driver_override;
> > > +       } else {
> > > +               kfree(driver_override);
> > > +               vdev->driver_override = NULL;
> > > +       }
> > > +       device_unlock(dev);
> > > +
> > > +       kfree(old);
> > > +
> > > +       return count;
> > > +}
> > > +
> > > +static ssize_t driver_override_show(struct device *dev,
> > > +                                   struct device_attribute *attr, char *buf)
> > > +{
> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > > +       ssize_t len;
> > > +
> > > +       device_lock(dev);
> > > +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
> > > +       device_unlock(dev);
> > > +
> > > +       return len;
> > > +}
> > > +static DEVICE_ATTR_RW(driver_override);
> > > +
> > > +static struct attribute *vdpa_dev_attrs[] = {
> > > +       &dev_attr_driver_override.attr,
> > > +       NULL,
> > > +};
> > > +
> > > +static const struct attribute_group vdpa_dev_group = {
> > > +       .attrs  = vdpa_dev_attrs,
> > > +};
> > > +__ATTRIBUTE_GROUPS(vdpa_dev);
> > > +
> > >  static struct bus_type vdpa_bus = {
> > >         .name  = "vdpa",
> > > +       .dev_groups = vdpa_dev_groups,
> >
> > This reminds me that we probably need to document the sysfs interface
> > in Documentation/ABI/testing/sysfs-bus-vdpa.
> >
> > But it's not the fault of this patch which look good.
> 
> Michael, Jason, about Documentation/ABI/testing/sysfs-bus-vdpa, do you 
> think is better to send a follow up patch/series, maybe including also 
> others entries (e.g. bind, unbind) or a v2 including the documentation 
> of `driver_ovveride`?
> 
> Thanks,
> Stefano

I'd include it as a patch in series.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
