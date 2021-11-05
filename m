Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972FEC433EF
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 03:01:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E2E6120F
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 03:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19E2E6120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA82960BA0;
	Fri,  5 Nov 2021 03:01:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJhSB7gNg8Vj; Fri,  5 Nov 2021 03:01:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A9EC6086D;
	Fri,  5 Nov 2021 03:01:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08438C0012;
	Fri,  5 Nov 2021 03:01:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFC19C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B87C4401FC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oaRdOonOaOgU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:01:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80CAD400DE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 03:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636081306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OcVO00wDG3/7AXHkZK3miwrP0gG7cy3EGjc+undENaY=;
 b=SgpEzgIrZ1m5lXgFqt3zQBegswZxoMnmVw+tS8X3YNVmQSIjpbUX1d01xluufJE39mpScg
 HE/fP8yDsHkDxpWNhW8W718xKp+EnEhNLkVXIk//DetKf9JwNWWheR7mSvEQGXetCbqHo0
 DX24yVDMC/AEtDUmd4xvDYqYJe+DwT8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-A9-aWyGyOWu9ICofBpZRNg-1; Thu, 04 Nov 2021 23:01:43 -0400
X-MC-Unique: A9-aWyGyOWu9ICofBpZRNg-1
Received: by mail-lf1-f71.google.com with SMTP id
 h40-20020a0565123ca800b00402514d959fso1496014lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Nov 2021 20:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OcVO00wDG3/7AXHkZK3miwrP0gG7cy3EGjc+undENaY=;
 b=iMzddKWTLH3ZknccZ9M0eEWxPjGXXvvkR5sr1XtV14jIrLZiulcvsC3X6wtTeVfwj5
 IMu51ZFxRea8XBPuZQAW6fnHidjU88IV7IOfNEqTiEgDURd/v3GrpK4AF6aarzVppH1Z
 Jd2IaxKZOepcm8FIADAkyZWxlDlKncJdyw4aMH03o+FbtdqKbraScG+iwNe7XATDBWhl
 AVBvGm0c8mb3WPzGhgAV5M2AFU2IyHdXydVC3+GJ2PXoRBP8wQGXXg+GxcMpJui96YSH
 p/pE0lmLsrk9e3S5DjBL6dtaSiZBXvR87lCDEkeUgAw1FDwZkiSh9QZo5MsZaHCjQl3c
 VHCQ==
X-Gm-Message-State: AOAM530HCx4IkI2owTwMtxG6nOmkKvRT9TZbTDLIO+CodhO3tUo7T085
 r8KwuJFhWP/WlHxYISPscMndWJn9STaXJZSPEHbiL8u5jfVdQeUdD9Z0ga1Nv+HE573h453kDot
 Oec+wSuTgpq/h2IlDD0KC7XZf3MbuHgz0f5PqqGbxTm4A5aW6u6wjqvR6tw==
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr1340975lfv.481.1636081301367; 
 Thu, 04 Nov 2021 20:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwezlMuIYNRg+i0rnCYAaH8TrP3L2Sehq7N5kofOgk9vnvg0RBzhfss1WoHy/9cYyAadcV9heoPm4Q4BfWNPe0=
X-Received: by 2002:a05:6512:3d09:: with SMTP id
 d9mr1340957lfv.481.1636081301154; 
 Thu, 04 Nov 2021 20:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211104161729.258294-1-sgarzare@redhat.com>
In-Reply-To: <20211104161729.258294-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Nov 2021 11:01:30 +0800
Message-ID: <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
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

On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> `driver_override` allows to control which of the vDPA bus drivers
> binds to a vDPA device.
>
> If `driver_override` is not set, the previous behaviour is followed:
> devices use the first vDPA bus driver loaded (unless auto binding
> is disabled).
>
> Tested on Fedora 34 with driverctl(8):
>   $ modprobe virtio-vdpa
>   $ modprobe vhost-vdpa
>   $ modprobe vdpa-sim-net
>
>   $ vdpa dev add mgmtdev vdpasim_net name dev1
>
>   # dev1 is attached to the first vDPA bus driver loaded
>   $ driverctl -b vdpa list-devices
>     dev1 virtio_vdpa
>
>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>
>   $ driverctl -b vdpa list-devices
>     dev1 vhost_vdpa [*]
>
>   Note: driverctl(8) integrates with udev so the binding is
>   preserved.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/vdpa.h |  2 ++
>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index c3011ccda430..ae34015b37b7 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
>   * @dma_dev: the actual device that is performing DMA
> + * @driver_override: driver name to force a match

This seems useless?

>   * @config: the configuration ops for this device.
>   * @cf_mutex: Protects get and set access to configuration layout.
>   * @index: device index
> @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
>  struct vdpa_device {
>         struct device dev;
>         struct device *dma_dev;
> +       const char *driver_override;
>         const struct vdpa_config_ops *config;
>         struct mutex cf_mutex; /* Protects get/set config */
>         unsigned int index;
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..659231bbfee8 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
>                 drv->remove(vdev);
>  }
>
> +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
> +{
> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> +
> +       /* Check override first, and if set, only use the named driver */
> +       if (vdev->driver_override)
> +               return strcmp(vdev->driver_override, drv->name) == 0;
> +
> +       /* Currently devices must be supported by all vDPA bus drivers */
> +       return 1;
> +}
> +
> +static ssize_t driver_override_store(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t count)
> +{
> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> +       const char *driver_override, *old;
> +       char *cp;
> +
> +       /* We need to keep extra room for a newline */
> +       if (count >= (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       driver_override = kstrndup(buf, count, GFP_KERNEL);
> +       if (!driver_override)
> +               return -ENOMEM;
> +
> +       cp = strchr(driver_override, '\n');
> +       if (cp)
> +               *cp = '\0';
> +
> +       device_lock(dev);
> +       old = vdev->driver_override;
> +       if (strlen(driver_override)) {
> +               vdev->driver_override = driver_override;
> +       } else {
> +               kfree(driver_override);
> +               vdev->driver_override = NULL;
> +       }
> +       device_unlock(dev);
> +
> +       kfree(old);
> +
> +       return count;
> +}
> +
> +static ssize_t driver_override_show(struct device *dev,
> +                                   struct device_attribute *attr, char *buf)
> +{
> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> +       ssize_t len;
> +
> +       device_lock(dev);
> +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
> +       device_unlock(dev);
> +
> +       return len;
> +}
> +static DEVICE_ATTR_RW(driver_override);
> +
> +static struct attribute *vdpa_dev_attrs[] = {
> +       &dev_attr_driver_override.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group vdpa_dev_group = {
> +       .attrs  = vdpa_dev_attrs,
> +};
> +__ATTRIBUTE_GROUPS(vdpa_dev);
> +
>  static struct bus_type vdpa_bus = {
>         .name  = "vdpa",
> +       .dev_groups = vdpa_dev_groups,

This reminds me that we probably need to document the sysfs interface
in Documentation/ABI/testing/sysfs-bus-vdpa.

But it's not the fault of this patch which look good.

Thanks

> +       .match = vdpa_dev_match,
>         .probe = vdpa_dev_probe,
>         .remove = vdpa_dev_remove,
>  };
> @@ -68,6 +141,7 @@ static void vdpa_release_dev(struct device *d)
>
>         ida_simple_remove(&vdpa_index_ida, vdev->index);
>         mutex_destroy(&vdev->cf_mutex);
> +       kfree(vdev->driver_override);
>         kfree(vdev);
>  }
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
