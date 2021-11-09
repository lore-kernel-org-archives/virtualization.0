Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72285C433EF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:32:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B35860F90
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B35860F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9A6F60820;
	Tue,  9 Nov 2021 13:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wi9bQTocGP7f; Tue,  9 Nov 2021 13:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6F37C607C7;
	Tue,  9 Nov 2021 13:32:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 406B6C0019;
	Tue,  9 Nov 2021 13:32:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F041CC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D247080D66
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQ2CG-2Dp8jZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:32:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F38780D3F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636464724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xi/depsgTJUGfIh8T6IcJPvCD2eD2wiILUV+a1Lv1R8=;
 b=EGZWvT8uEAT0FqPccH6sIWASKFHbyBYcJxeFEwRhI783CCAOe0jmi41yfMeydPy9K3ofC+
 KnzLdSuN/wO7nR5fH/qp+wiaaT17E/e/v4Lg4GKlNY0eAm7EHedjfk61KZX6gsqob+TxBw
 Nh9J5zcdRtaEfA2chcaJE2Wo5zTjPCA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-Q_o_4f36O7OrYPTR_AzUuw-1; Tue, 09 Nov 2021 08:32:02 -0500
X-MC-Unique: Q_o_4f36O7OrYPTR_AzUuw-1
Received: by mail-ed1-f70.google.com with SMTP id
 v9-20020a50d849000000b003dcb31eabaaso17984601edj.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Nov 2021 05:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xi/depsgTJUGfIh8T6IcJPvCD2eD2wiILUV+a1Lv1R8=;
 b=MMP3RpK9CMxIG/gquRVpHgY5CRHI2E6lv61g/L3dKmrXc+utmbg1pP7QAxE2bcjQfL
 adxBUQIhoC6+Q5MdZjzo59ASar2pH4f/MoLMqSnUBulxS3RNBDl3TYnJFCT/cUN19402
 BQRvVm2pqxXGLFJ/BoAlDZWS8QCmQPLMZD1ZUPda7Y78wKS1q4pjxz07ePfFBv6FVpwI
 CcN+CnX5YMnw7VfPVgLTn97vc/Z+BT0xtbQGa+5HQkA974Tyijo4jdHksrKJBlEuEsc5
 9wGfPOa8aJ10FDe2MiVUARS5FEzAO18is56Yh0UoHrln77pXpkIiqiYQlQUwrNO/qv1z
 90XA==
X-Gm-Message-State: AOAM5338sZX+33Hx5lAkl1gVW0cxZXA+eTbV0XWuUvQSe9XFDanGFwsV
 ppksDwIHUz5jtqmpa/uNodevx6vjBvhvD0a7J1w/TIaxFphNeoAIXRY4sN2pWpqpo3ayczfoFjj
 3xTt/m8YZidUH8q9kW08SUf2rNY8A3/PsvlDBtDX3uA==
X-Received: by 2002:a17:906:dc91:: with SMTP id
 cs17mr9797710ejc.461.1636464721445; 
 Tue, 09 Nov 2021 05:32:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSkw/5polRto4zRzObbvs88GZHehaeUwO1dovVj2zF7aswVXR/RIJcrS7mrkuWA1iEOzCQJw==
X-Received: by 2002:a17:906:dc91:: with SMTP id
 cs17mr9797675ejc.461.1636464721226; 
 Tue, 09 Nov 2021 05:32:01 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id s12sm11032987edc.48.2021.11.09.05.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 05:32:00 -0800 (PST)
Date: Tue, 9 Nov 2021 14:31:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <20211109133159.vfw3gyjwlw6xryy7@steredhat>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
 <CAGxU2F4NQz74f8sw51Ownm-25Jd7K=B_gK_-nRDKmmYvPx=+=w@mail.gmail.com>
 <20211109081042-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211109081042-mutt-send-email-mst@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 09, 2021 at 08:10:58AM -0500, Michael S. Tsirkin wrote:
>On Mon, Nov 08, 2021 at 06:05:29PM +0100, Stefano Garzarella wrote:
>> On Fri, Nov 5, 2021 at 4:01 AM Jason Wang <jasowang@redhat.com> wrote:
>> >
>> > On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > `driver_override` allows to control which of the vDPA bus drivers
>> > > binds to a vDPA device.
>> > >
>> > > If `driver_override` is not set, the previous behaviour is followed:
>> > > devices use the first vDPA bus driver loaded (unless auto binding
>> > > is disabled).
>> > >
>> > > Tested on Fedora 34 with driverctl(8):
>> > >   $ modprobe virtio-vdpa
>> > >   $ modprobe vhost-vdpa
>> > >   $ modprobe vdpa-sim-net
>> > >
>> > >   $ vdpa dev add mgmtdev vdpasim_net name dev1
>> > >
>> > >   # dev1 is attached to the first vDPA bus driver loaded
>> > >   $ driverctl -b vdpa list-devices
>> > >     dev1 virtio_vdpa
>> > >
>> > >   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>> > >
>> > >   $ driverctl -b vdpa list-devices
>> > >     dev1 vhost_vdpa [*]
>> > >
>> > >   Note: driverctl(8) integrates with udev so the binding is
>> > >   preserved.
>> > >
>> > > Suggested-by: Jason Wang <jasowang@redhat.com>
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >  include/linux/vdpa.h |  2 ++
>> > >  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>> > >  2 files changed, 76 insertions(+)
>> > >
>> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> > > index c3011ccda430..ae34015b37b7 100644
>> > > --- a/include/linux/vdpa.h
>> > > +++ b/include/linux/vdpa.h
>> > > @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>> > >   * struct vdpa_device - representation of a vDPA device
>> > >   * @dev: underlying device
>> > >   * @dma_dev: the actual device that is performing DMA
>> > > + * @driver_override: driver name to force a match
>> >
>> > This seems useless?
>> >
>> > >   * @config: the configuration ops for this device.
>> > >   * @cf_mutex: Protects get and set access to configuration layout.
>> > >   * @index: device index
>> > > @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
>> > >  struct vdpa_device {
>> > >         struct device dev;
>> > >         struct device *dma_dev;
>> > > +       const char *driver_override;
>> > >         const struct vdpa_config_ops *config;
>> > >         struct mutex cf_mutex; /* Protects get/set config */
>> > >         unsigned int index;
>> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> > > index 7332a74a4b00..659231bbfee8 100644
>> > > --- a/drivers/vdpa/vdpa.c
>> > > +++ b/drivers/vdpa/vdpa.c
>> > > @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
>> > >                 drv->remove(vdev);
>> > >  }
>> > >
>> > > +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
>> > > +{
>> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> > > +
>> > > +       /* Check override first, and if set, only use the named driver */
>> > > +       if (vdev->driver_override)
>> > > +               return strcmp(vdev->driver_override, drv->name) == 0;
>> > > +
>> > > +       /* Currently devices must be supported by all vDPA bus drivers */
>> > > +       return 1;
>> > > +}
>> > > +
>> > > +static ssize_t driver_override_store(struct device *dev,
>> > > +                                    struct device_attribute *attr,
>> > > +                                    const char *buf, size_t count)
>> > > +{
>> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> > > +       const char *driver_override, *old;
>> > > +       char *cp;
>> > > +
>> > > +       /* We need to keep extra room for a newline */
>> > > +       if (count >= (PAGE_SIZE - 1))
>> > > +               return -EINVAL;
>> > > +
>> > > +       driver_override = kstrndup(buf, count, GFP_KERNEL);
>> > > +       if (!driver_override)
>> > > +               return -ENOMEM;
>> > > +
>> > > +       cp = strchr(driver_override, '\n');
>> > > +       if (cp)
>> > > +               *cp = '\0';
>> > > +
>> > > +       device_lock(dev);
>> > > +       old = vdev->driver_override;
>> > > +       if (strlen(driver_override)) {
>> > > +               vdev->driver_override = driver_override;
>> > > +       } else {
>> > > +               kfree(driver_override);
>> > > +               vdev->driver_override = NULL;
>> > > +       }
>> > > +       device_unlock(dev);
>> > > +
>> > > +       kfree(old);
>> > > +
>> > > +       return count;
>> > > +}
>> > > +
>> > > +static ssize_t driver_override_show(struct device *dev,
>> > > +                                   struct device_attribute *attr, char *buf)
>> > > +{
>> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> > > +       ssize_t len;
>> > > +
>> > > +       device_lock(dev);
>> > > +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
>> > > +       device_unlock(dev);
>> > > +
>> > > +       return len;
>> > > +}
>> > > +static DEVICE_ATTR_RW(driver_override);
>> > > +
>> > > +static struct attribute *vdpa_dev_attrs[] = {
>> > > +       &dev_attr_driver_override.attr,
>> > > +       NULL,
>> > > +};
>> > > +
>> > > +static const struct attribute_group vdpa_dev_group = {
>> > > +       .attrs  = vdpa_dev_attrs,
>> > > +};
>> > > +__ATTRIBUTE_GROUPS(vdpa_dev);
>> > > +
>> > >  static struct bus_type vdpa_bus = {
>> > >         .name  = "vdpa",
>> > > +       .dev_groups = vdpa_dev_groups,
>> >
>> > This reminds me that we probably need to document the sysfs interface
>> > in Documentation/ABI/testing/sysfs-bus-vdpa.
>> >
>> > But it's not the fault of this patch which look good.
>>
>> Michael, Jason, about Documentation/ABI/testing/sysfs-bus-vdpa, do you
>> think is better to send a follow up patch/series, maybe including also
>> others entries (e.g. bind, unbind) or a v2 including the documentation
>> of `driver_ovveride`?
>>
>> Thanks,
>> Stefano
>
>I'd include it as a patch in series.
>

Okay, so I'll send the documentation in a followup series.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
