Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7D4C433EF
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:05:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D04160F36
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 08:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D04160F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14B2C81C67;
	Fri,  5 Nov 2021 08:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fHATq-nNlFH9; Fri,  5 Nov 2021 08:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A7EA18190B;
	Fri,  5 Nov 2021 08:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82FC8C0012;
	Fri,  5 Nov 2021 08:05:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4DBCC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C2F4B40431
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YF0gmbWbtb9b
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:05:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3544740439
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636099503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCMVMpxrIHYy5glS6Ql48RFNndwZCFbpRRPCZXnVaeE=;
 b=SuXFw2uXd2j466jAjSE1LEVLoaqxLvBQzS+2bBvvtC3JSooT3mAJCdfBaLYlVvp8tlUdWS
 WogbuJqhIXaxZmItSl+jqQ/VBn2ESZEnt6Po0dT3/geSenN8QwabXN9vF/0Yc2KbvQ/JYn
 qH7PR863sI4J2VVAaPhmmauggAUfc2Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-cT6vJic1Mx-IiqHsr5goeg-1; Fri, 05 Nov 2021 04:04:59 -0400
X-MC-Unique: cT6vJic1Mx-IiqHsr5goeg-1
Received: by mail-ed1-f72.google.com with SMTP id
 i22-20020a05640242d600b003e28aecc0afso8168670edc.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Nov 2021 01:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XCMVMpxrIHYy5glS6Ql48RFNndwZCFbpRRPCZXnVaeE=;
 b=oIe8wWyUUxrhIGSPDNdwSRFMEUf6D6Cq1JutEruv6AFkkr07Q98KOUkIvaQ/biAud2
 S3JDRL4J2A6GOcolL/h7P6oIs4OULGL1ztt2idiVnCbef+vfcTxRpFhS6+eLtMTlKCIw
 oxGdMc8IeKl5rRG//ZAIZNdigxBWfcLcDdpWn+U+d9gPEpixqlgr2CUiksuS2e4xzqS/
 Kf3OOyw6wgZGkLba1cux2JVcza4jPYXWtPxPyGB8u5Y7kQo+Mowa9aGhOvyszb+p2heg
 +k6YPaRZTOT5NFBH4w+plw0UZ2ve+j436dFrHQCBVPtFJQJOs3HEZYMhgHBmkbH2NTGb
 HUkA==
X-Gm-Message-State: AOAM533gfbQoAdx6OaXHSf6RzpOJzEH9ZdfEmO83ajk1pPDCoqPgWaFz
 TZ+Tq/9VxoIy5Ii7Y8ai8xqEhxHt0uEGLSvb634zgm2FFq+3eitGIGs9mf2+qgNTfhXQYy7IKBX
 c+vH4DcRMiGyUp8qOTQ9/4gsxM0VqT3IPpxlNIYGwsw==
X-Received: by 2002:a17:906:a182:: with SMTP id
 s2mr70153845ejy.176.1636099498559; 
 Fri, 05 Nov 2021 01:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSTcJO6+jWKa3gHLxkTXZen/dGH+uiq5xtfJ9LgobdkY8UNBy/j2NC/TfFpcHFa9el2YpYmA==
X-Received: by 2002:a17:906:a182:: with SMTP id
 s2mr70153817ejy.176.1636099498327; 
 Fri, 05 Nov 2021 01:04:58 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it.
 [87.10.72.39])
 by smtp.gmail.com with ESMTPSA id gn26sm418635ejc.14.2021.11.05.01.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Nov 2021 01:04:57 -0700 (PDT)
Date: Fri, 5 Nov 2021 09:04:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <20211105080454.wpvtwa7el45kayem@steredhat>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Nov 05, 2021 at 11:01:30AM +0800, Jason Wang wrote:
>On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> `driver_override` allows to control which of the vDPA bus drivers
>> binds to a vDPA device.
>>
>> If `driver_override` is not set, the previous behaviour is followed:
>> devices use the first vDPA bus driver loaded (unless auto binding
>> is disabled).
>>
>> Tested on Fedora 34 with driverctl(8):
>>   $ modprobe virtio-vdpa
>>   $ modprobe vhost-vdpa
>>   $ modprobe vdpa-sim-net
>>
>>   $ vdpa dev add mgmtdev vdpasim_net name dev1
>>
>>   # dev1 is attached to the first vDPA bus driver loaded
>>   $ driverctl -b vdpa list-devices
>>     dev1 virtio_vdpa
>>
>>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>>
>>   $ driverctl -b vdpa list-devices
>>     dev1 vhost_vdpa [*]
>>
>>   Note: driverctl(8) integrates with udev so the binding is
>>   preserved.
>>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/linux/vdpa.h |  2 ++
>>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index c3011ccda430..ae34015b37b7 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>>   * struct vdpa_device - representation of a vDPA device
>>   * @dev: underlying device
>>   * @dma_dev: the actual device that is performing DMA
>> + * @driver_override: driver name to force a match
>
>This seems useless?

I'm a bit lost, do you mean we should remove the documentation of 
`driver_override`?

>
>>   * @config: the configuration ops for this device.
>>   * @cf_mutex: Protects get and set access to configuration layout.
>>   * @index: device index
>> @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
>>  struct vdpa_device {
>>         struct device dev;
>>         struct device *dma_dev;
>> +       const char *driver_override;
>>         const struct vdpa_config_ops *config;
>>         struct mutex cf_mutex; /* Protects get/set config */
>>         unsigned int index;
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 7332a74a4b00..659231bbfee8 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
>>                 drv->remove(vdev);
>>  }
>>
>> +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
>> +{
>> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> +
>> +       /* Check override first, and if set, only use the named driver */
>> +       if (vdev->driver_override)
>> +               return strcmp(vdev->driver_override, drv->name) == 0;
>> +
>> +       /* Currently devices must be supported by all vDPA bus 
>> drivers */
>> +       return 1;
>> +}
>> +
>> +static ssize_t driver_override_store(struct device *dev,
>> +                                    struct device_attribute *attr,
>> +                                    const char *buf, size_t count)
>> +{
>> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> +       const char *driver_override, *old;
>> +       char *cp;
>> +
>> +       /* We need to keep extra room for a newline */
>> +       if (count >= (PAGE_SIZE - 1))
>> +               return -EINVAL;
>> +
>> +       driver_override = kstrndup(buf, count, GFP_KERNEL);
>> +       if (!driver_override)
>> +               return -ENOMEM;
>> +
>> +       cp = strchr(driver_override, '\n');
>> +       if (cp)
>> +               *cp = '\0';
>> +
>> +       device_lock(dev);
>> +       old = vdev->driver_override;
>> +       if (strlen(driver_override)) {
>> +               vdev->driver_override = driver_override;
>> +       } else {
>> +               kfree(driver_override);
>> +               vdev->driver_override = NULL;
>> +       }
>> +       device_unlock(dev);
>> +
>> +       kfree(old);
>> +
>> +       return count;
>> +}
>> +
>> +static ssize_t driver_override_show(struct device *dev,
>> +                                   struct device_attribute *attr, char *buf)
>> +{
>> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> +       ssize_t len;
>> +
>> +       device_lock(dev);
>> +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
>> +       device_unlock(dev);
>> +
>> +       return len;
>> +}
>> +static DEVICE_ATTR_RW(driver_override);
>> +
>> +static struct attribute *vdpa_dev_attrs[] = {
>> +       &dev_attr_driver_override.attr,
>> +       NULL,
>> +};
>> +
>> +static const struct attribute_group vdpa_dev_group = {
>> +       .attrs  = vdpa_dev_attrs,
>> +};
>> +__ATTRIBUTE_GROUPS(vdpa_dev);
>> +
>>  static struct bus_type vdpa_bus = {
>>         .name  = "vdpa",
>> +       .dev_groups = vdpa_dev_groups,
>
>This reminds me that we probably need to document the sysfs interface
>in Documentation/ABI/testing/sysfs-bus-vdpa.
>

Yeah, I'd like to add more documentation. We should also document the 
device life cycle and management API.

It's on my to-do list, I'm prioritizing it!

>But it's not the fault of this patch which look good.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
