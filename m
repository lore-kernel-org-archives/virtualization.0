Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571EC433EF
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:27:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0723661131
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0723661131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD50281C56;
	Fri,  5 Nov 2021 08:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2B5SJX5ay6O1; Fri,  5 Nov 2021 08:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61F2E81C46;
	Fri,  5 Nov 2021 08:27:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36DF6C0019;
	Fri,  5 Nov 2021 08:27:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2DD1C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB3414051D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v135eeEVOEst
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:26:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8843E40518
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636100818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2czTQm0QJ9/x8jcZdwvnH7f3nSKUf/6fHpMFPR3kC4Y=;
 b=ElR8d9TPgSGaNBniMTu7escfvDltEG7jr5+hR2ApzDDokaTQm9eO1wjUw8GtpQhxD5MSle
 ggexr5g9+oLjxR+sA/CBFNoB71inP17q+iHYkEOe/2e7tEw6oCfNgmLo2Xmb9eThZQZEQh
 WPjbSw/td4qtTKidPXCZFNaeeLU+dA8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-SYORedzpPOyVHyIP89w8jQ-1; Fri, 05 Nov 2021 04:26:57 -0400
X-MC-Unique: SYORedzpPOyVHyIP89w8jQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 br22-20020a056512401600b004017a0f5cc6so3086123lfb.16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Nov 2021 01:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2czTQm0QJ9/x8jcZdwvnH7f3nSKUf/6fHpMFPR3kC4Y=;
 b=wcKcdOsFGP4KqosSMi/mmHkJ21VmQKXMQOAPOBe+VXJz6GRSqlzCW6efM/Lar4vyQg
 8m8uh5+Ontn0YmwtCAB2M4IZgfArrQt/ok83nLsVbVWPxVODWiGZ3pDs1pidBbt76DDz
 oEmLlKohlR31rflGPO0mtg5085DjEenyBvH7u5dRcMXlJLvvjfGMwhOqJsF4mnXXrLJ3
 2c03WdMJE7PSnQRxHGdhT5oeDvurQfWZIo+1Xl/bgDbrBNkdQwclxZ7y/OKg42QzkfWn
 4yt485yKzLoKtN/CnK2hFXg7H27qJPB3qUymI5VmmVf9w3oSp8lKLnfIEYDCGcDl0PI8
 fHoQ==
X-Gm-Message-State: AOAM530QJ9PDa1+Mo6guFrED2JDNx0Erk3smfwZGTOrKNp1VxJLbYGoN
 88fs/SjOLlJJm7WeVhE2RkZtVcGbph06B/BKoYJnwxNuwWOsxm7O/23uNX7RQu4E+dqGWM1uGDi
 xu/I9CKJ4CHv1FN0LxUtrpaQ+Y8KtsXh/iUfEdwWCYmnLLryw7gOkGRfKpw==
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr2602787lfv.481.1636100815382; 
 Fri, 05 Nov 2021 01:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1lk1IHmZF2VRD4tIl/fiY97kCzG9s/LGGkReF2P00eY1fmJoXffMV1n/dg4MqV0azD1df40tTorEe1M3GYYE=
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr2602770lfv.481.1636100815144; 
 Fri, 05 Nov 2021 01:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
 <20211105080454.wpvtwa7el45kayem@steredhat>
In-Reply-To: <20211105080454.wpvtwa7el45kayem@steredhat>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Nov 2021 16:26:44 +0800
Message-ID: <CACGkMEvNZKc2K_bdKxiUmbLzoZL-Vdbc14+uw9Ro-2jzdFMRRw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: add driver_override support
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Fri, Nov 5, 2021 at 4:05 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Nov 05, 2021 at 11:01:30AM +0800, Jason Wang wrote:
> >On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> `driver_override` allows to control which of the vDPA bus drivers
> >> binds to a vDPA device.
> >>
> >> If `driver_override` is not set, the previous behaviour is followed:
> >> devices use the first vDPA bus driver loaded (unless auto binding
> >> is disabled).
> >>
> >> Tested on Fedora 34 with driverctl(8):
> >>   $ modprobe virtio-vdpa
> >>   $ modprobe vhost-vdpa
> >>   $ modprobe vdpa-sim-net
> >>
> >>   $ vdpa dev add mgmtdev vdpasim_net name dev1
> >>
> >>   # dev1 is attached to the first vDPA bus driver loaded
> >>   $ driverctl -b vdpa list-devices
> >>     dev1 virtio_vdpa
> >>
> >>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
> >>
> >>   $ driverctl -b vdpa list-devices
> >>     dev1 vhost_vdpa [*]
> >>
> >>   Note: driverctl(8) integrates with udev so the binding is
> >>   preserved.
> >>
> >> Suggested-by: Jason Wang <jasowang@redhat.com>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >>  include/linux/vdpa.h |  2 ++
> >>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 76 insertions(+)
> >>
> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >> index c3011ccda430..ae34015b37b7 100644
> >> --- a/include/linux/vdpa.h
> >> +++ b/include/linux/vdpa.h
> >> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
> >>   * struct vdpa_device - representation of a vDPA device
> >>   * @dev: underlying device
> >>   * @dma_dev: the actual device that is performing DMA
> >> + * @driver_override: driver name to force a match
> >
> >This seems useless?
>
> I'm a bit lost, do you mean we should remove the documentation of
> `driver_override`?

I misread the code which was misled by vdpa_mgmt_dev above:(

The code should be fine.

So:

Acked-by: Jason Wang <jasowang@redhat.com>

>
> >
> >>   * @config: the configuration ops for this device.
> >>   * @cf_mutex: Protects get and set access to configuration layout.
> >>   * @index: device index
> >> @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
> >>  struct vdpa_device {
> >>         struct device dev;
> >>         struct device *dma_dev;
> >> +       const char *driver_override;
> >>         const struct vdpa_config_ops *config;
> >>         struct mutex cf_mutex; /* Protects get/set config */
> >>         unsigned int index;
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index 7332a74a4b00..659231bbfee8 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
> >>                 drv->remove(vdev);
> >>  }
> >>
> >> +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
> >> +{
> >> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> >> +
> >> +       /* Check override first, and if set, only use the named driver */
> >> +       if (vdev->driver_override)
> >> +               return strcmp(vdev->driver_override, drv->name) == 0;
> >> +
> >> +       /* Currently devices must be supported by all vDPA bus
> >> drivers */
> >> +       return 1;
> >> +}
> >> +
> >> +static ssize_t driver_override_store(struct device *dev,
> >> +                                    struct device_attribute *attr,
> >> +                                    const char *buf, size_t count)
> >> +{
> >> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> >> +       const char *driver_override, *old;
> >> +       char *cp;
> >> +
> >> +       /* We need to keep extra room for a newline */
> >> +       if (count >= (PAGE_SIZE - 1))
> >> +               return -EINVAL;
> >> +
> >> +       driver_override = kstrndup(buf, count, GFP_KERNEL);
> >> +       if (!driver_override)
> >> +               return -ENOMEM;
> >> +
> >> +       cp = strchr(driver_override, '\n');
> >> +       if (cp)
> >> +               *cp = '\0';
> >> +
> >> +       device_lock(dev);
> >> +       old = vdev->driver_override;
> >> +       if (strlen(driver_override)) {
> >> +               vdev->driver_override = driver_override;
> >> +       } else {
> >> +               kfree(driver_override);
> >> +               vdev->driver_override = NULL;
> >> +       }
> >> +       device_unlock(dev);
> >> +
> >> +       kfree(old);
> >> +
> >> +       return count;
> >> +}
> >> +
> >> +static ssize_t driver_override_show(struct device *dev,
> >> +                                   struct device_attribute *attr, char *buf)
> >> +{
> >> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> >> +       ssize_t len;
> >> +
> >> +       device_lock(dev);
> >> +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
> >> +       device_unlock(dev);
> >> +
> >> +       return len;
> >> +}
> >> +static DEVICE_ATTR_RW(driver_override);
> >> +
> >> +static struct attribute *vdpa_dev_attrs[] = {
> >> +       &dev_attr_driver_override.attr,
> >> +       NULL,
> >> +};
> >> +
> >> +static const struct attribute_group vdpa_dev_group = {
> >> +       .attrs  = vdpa_dev_attrs,
> >> +};
> >> +__ATTRIBUTE_GROUPS(vdpa_dev);
> >> +
> >>  static struct bus_type vdpa_bus = {
> >>         .name  = "vdpa",
> >> +       .dev_groups = vdpa_dev_groups,
> >
> >This reminds me that we probably need to document the sysfs interface
> >in Documentation/ABI/testing/sysfs-bus-vdpa.
> >
>
> Yeah, I'd like to add more documentation. We should also document the
> device life cycle and management API.
>
> It's on my to-do list, I'm prioritizing it!
>
> >But it's not the fault of this patch which look good.
>
> Thanks,
> Stefano
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
