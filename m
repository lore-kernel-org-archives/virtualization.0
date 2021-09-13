Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD80C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 09:45:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A9A6108E
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 09:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4A9A6108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E41980EBC;
	Mon, 13 Sep 2021 09:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0I5pm-fQmNfb; Mon, 13 Sep 2021 09:45:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F95E80EB8;
	Mon, 13 Sep 2021 09:45:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4EB8C000F;
	Mon, 13 Sep 2021 09:45:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69957C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5256E80EBC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:45:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SS6A0FzbIP7q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:45:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B47180EB8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631526347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWe98zeJD7s9qLcq/i/RsJ8if8FlWjyR2b/zkGoJBbI=;
 b=i0a5VJgz0EmkLs61QfrH8mkKoffzSoWrpU5h71H9ZT+KPCSprQFOupRvw29FGDJ/Ts5C4H
 CuQix6C7XDEJxoc83BKwkL5X0Wxi2EpclhPNjK0CLAdwoW8mNVXfkiHaUF2AkbsTjQ2YX3
 g5sZrAbygW7h0WJ1x6ictMpsKUlE5Xo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-_l7Bw591NW62sVnauqNSeQ-1; Mon, 13 Sep 2021 05:45:46 -0400
X-MC-Unique: _l7Bw591NW62sVnauqNSeQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 i8-20020a50fc08000000b003d1cb7bebe5so1470580edr.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 02:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XWe98zeJD7s9qLcq/i/RsJ8if8FlWjyR2b/zkGoJBbI=;
 b=JCA9r3MBi6LAKiLVcWL38l8T3Atn2WdykOEufLsRqWfe1yRmB8YNn8EKN8t1Xy1FaB
 JJck/1zaSl60DYQwXjycHtkH718B++FK5oRw9KTIiKDHZab8uJx6nuAQrs2BbirOhXm/
 N0c4grUajI/ZFPeHBpSu2aNcym0Isg4qeo2lwZEfDAN4dm+OPleNPi9WTVqkGQdkwEj+
 ml6697z8fKJYb7Rd0tKb67noTbZp4i/eUUUiBn2WsKWFG+o3ftRd6PgOXEYlDYDJVmKS
 u2xe3tT2LABTBqeWeqw63zv0JsciWJrj1uRauf70BOAqeJx3E5/jO3fHWkIxDvYmggyr
 QOXw==
X-Gm-Message-State: AOAM531sSs0yTWhThhbihBy6c/KxWQz098exeO/gUaUeoFeojezd4nGN
 UZ+0X/5zKe1olQy1X5IQQUbuzdh7lMw4XVjLBjjnSdBKuJ+kmcUdsYGIn2jbl6Hti9SY0n4Jxj+
 u6AECDq3mO+inrF5lAgoSGEgLB0NXMWZ0/vKHgilxBg==
X-Received: by 2002:a17:906:36d6:: with SMTP id
 b22mr11416323ejc.387.1631526345043; 
 Mon, 13 Sep 2021 02:45:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvMXi0jvSRqI7rhgMLRLOVsHiODoTK7Ac8qaJOeVYG3W2Chw606SsKje3cckY4USX/iMLdRQ==
X-Received: by 2002:a17:906:36d6:: with SMTP id
 b22mr11416304ejc.387.1631526344832; 
 Mon, 13 Sep 2021 02:45:44 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207f:418b:5703:fd4e:73dd:1986])
 by smtp.gmail.com with ESMTPSA id c5sm3653619edx.81.2021.09.13.02.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 02:45:44 -0700 (PDT)
Date: Mon, 13 Sep 2021 05:45:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH V3 5/5] virtio: Bind virtio device to device-tree node
Message-ID: <20210913053816-mutt-send-email-mst@kernel.org>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
 <d5f87715-5a3e-1e85-68ba-3e4d35163c68@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <d5f87715-5a3e-1e85-68ba-3e4d35163c68@ozlabs.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Arnd Bergmann <arnd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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

On Mon, Sep 13, 2021 at 07:19:17PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 26/07/2021 14:51, Viresh Kumar wrote:
> > Bind the virtio devices with their of_node. This will help users of the
> > virtio devices to mention their dependencies on the device in the DT
> > itself. Like GPIO pin users can use the phandle of the device node, or
> > the node may contain more subnodes to add i2c or spi eeproms and other
> > users.
> > 
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/virtio/virtio.c | 57 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 54 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 4b15c00c0a0a..d001e84a5b23 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/virtio_config.h>
> >  #include <linux/module.h>
> >  #include <linux/idr.h>
> > +#include <linux/of.h>
> >  #include <uapi/linux/virtio_ids.h>
> >  
> >  /* Unique numbering for virtio devices. */
> > @@ -292,6 +293,9 @@ static int virtio_dev_remove(struct device *_d)
> >  
> >  	/* Acknowledge the device's existence again. */
> >  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> > +
> > +	of_node_put(dev->dev.of_node);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -319,6 +323,43 @@ void unregister_virtio_driver(struct virtio_driver *driver)
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
> >  
> > +static int virtio_device_of_init(struct virtio_device *dev)
> > +{
> > +	struct device_node *np, *pnode = dev_of_node(dev->dev.parent);
> > +	char compat[] = "virtio,XXXXXXXX"; /* Reserve enough space 32-bit id */
> > +	int ret, count;
> > +
> > +	if (!pnode)
> > +		return 0;
> > +
> > +	count = of_get_available_child_count(pnode);
> > +	if (!count)
> > +		return 0;
> > +
> > +	/* There can be only 1 child node */
> > +	if (WARN_ON(count > 1))
> > +		return -EINVAL;
> > +
> > +	np = of_get_next_available_child(pnode, NULL);
> > +	if (WARN_ON(!np))
> > +		return -ENODEV;
> > +
> > +	BUG_ON(snprintf(compat, sizeof(compat), "virtio,%x", dev->id.device) >=
> > +	       sizeof(compat));
> > +
> > +	if (!of_device_is_compatible(np, compat)) {
> 
> 
> This broke powerpc/pseries as there these virtio devices are PCI so
> there is no "compat" - PCI vendor id/device ids play role of "compat".
> Thanks,

Hmm now that you say this I wonder why do we bother
with this check, too. When can this be invoked for something
that is not a virtio device? And is it enough to just
skip of_node initialization then?


> 
> 
> 
> > +		ret = -EINVAL;


So basically ret = 0 above?


> > +		goto out;
> > +	}
> > +
> > +	dev->dev.of_node = np;
> > +	return 0;
> > +
> > +out:
> > +	of_node_put(np);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * register_virtio_device - register virtio device
> >   * @dev        : virtio device to be registered
> > @@ -343,6 +384,10 @@ int register_virtio_device(struct virtio_device *dev)
> >  	dev->index = err;
> >  	dev_set_name(&dev->dev, "virtio%u", dev->index);
> >  
> > +	err = virtio_device_of_init(dev);
> > +	if (err)
> > +		goto out_ida_remove;
> > +
> >  	spin_lock_init(&dev->config_lock);
> >  	dev->config_enabled = false;
> >  	dev->config_change_pending = false;
> > @@ -362,10 +407,16 @@ int register_virtio_device(struct virtio_device *dev)
> >  	 */
> >  	err = device_add(&dev->dev);
> >  	if (err)
> > -		ida_simple_remove(&virtio_index_ida, dev->index);
> > +		goto out_of_node_put;
> > +
> > +	return 0;
> > +
> > +out_of_node_put:
> > +	of_node_put(dev->dev.of_node);
> > +out_ida_remove:
> > +	ida_simple_remove(&virtio_index_ida, dev->index);
> >  out:
> > -	if (err)
> > -		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> > +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> >  	return err;
> >  }
> >  EXPORT_SYMBOL_GPL(register_virtio_device);
> > 
> 
> -- 
> Alexey

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
