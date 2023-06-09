Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DA1C7EE25
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 16:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCC596160F;
	Fri,  9 Jun 2023 16:12:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCC596160F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L57/Q6T/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OX1uymv9tG12; Fri,  9 Jun 2023 16:12:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3DAEA60B9D;
	Fri,  9 Jun 2023 16:12:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DAEA60B9D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2004BC0037;
	Fri,  9 Jun 2023 16:12:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F11FC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1431B84265
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:12:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1431B84265
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=L57/Q6T/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uGafhJvJUZvm
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:12:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE70E83D24
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE70E83D24
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686327131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y4bm62kfkkLTnjUJmvlgyp+ign6wrzvvVnxHsSjlw0Y=;
 b=L57/Q6T/MjON98tLl04U/JNeRC0jftZ71dzDJFlLzD+dzJVUil1Zypd0p0Hk73cxZbkThR
 IemHx1bXSQl30SegB9UtNbTX6NLGzBE6WqOCHpG0tCeF1dS5O0wHQOPaFQHDbHiyj6dN+t
 nLUYFAC0gxNlM78xGyowqEEeOPv3+lk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-bzYEhoIFPXW_m9mmbVKgRg-1; Fri, 09 Jun 2023 12:12:10 -0400
X-MC-Unique: bzYEhoIFPXW_m9mmbVKgRg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f7678c74beso12418825e9.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 09:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686327129; x=1688919129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4bm62kfkkLTnjUJmvlgyp+ign6wrzvvVnxHsSjlw0Y=;
 b=ROZdrWdPypZozh+gmIbIuEfyfB9C77d8aOH0JBRPmWFGXV2Xp3Y3OLGsdWybSLBeLb
 AKvE1SZPFfJ8ylOy/+nbQTQfVMErIx3ckK44HFTsf99k8V4mW+dRf96qV6/ujjf0Oibr
 2z0SUi9Q8LLBpx6EZIKXrYL5U+FwZIBTNKQhiveia81kWFtUtZ0eZwGV8gTFRQaLtcn1
 Ked87fs7NtnT5XMjo/trGoM5btXUcF5tgXnoZHKAh2vyv2ovtnxI9h6SqFKmfvm3y7OS
 6i7PqNHfuRE30zCnpBn5nUlS22BuJ4KGL8HO5tsuFrwOxlW6DoucDlZjI69PeKW7hlMK
 APRA==
X-Gm-Message-State: AC+VfDzDHcrHlP7CHP+d2PtDf5Q/9aWkHulNbSLZiwhQabFlRYH7JLK4
 mClZLgmf8MsXJRDfpT4CF6H2NzIxgDB7W3GPxsS0SvslxHMgY8jj/+qtjfeEEwEdVYv8prgOQuO
 baAwmf/MpRoelrDRCCr4RmLVUqxbspZ/9JYP++aDi2A==
X-Received: by 2002:a7b:c84c:0:b0:3f6:76e:604b with SMTP id
 c12-20020a7bc84c000000b003f6076e604bmr1525961wml.0.1686327129332; 
 Fri, 09 Jun 2023 09:12:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xm9yUTrC2OmG8c4yJjmFGfxA7jlxP+M4arKQJPvSSV953T9IiEEH9ysAY86JxwiufCmeo3g==
X-Received: by 2002:a7b:c84c:0:b0:3f6:76e:604b with SMTP id
 c12-20020a7bc84c000000b003f6076e604bmr1525952wml.0.1686327129048; 
 Fri, 09 Jun 2023 09:12:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d650f000000b0030adfa48e1esm4815815wru.29.2023.06.09.09.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:12:08 -0700 (PDT)
Date: Fri, 9 Jun 2023 12:12:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Angus Chen <angus.chen@jaguarmicro.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Message-ID: <20230609120939-mutt-send-email-mst@kernel.org>
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
 <20230608154400-mutt-send-email-mst@kernel.org>
 <TY2PR06MB34248F29ED36A5DBB4FE0E2E8551A@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR06MB34248F29ED36A5DBB4FE0E2E8551A@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Fri, Jun 09, 2023 at 12:42:22AM +0000, Angus Chen wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, June 9, 2023 3:45 AM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: jasowang@redhat.com; virtualization@lists.linux-foundation.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
> > add_config
> > 
> > On Thu, Jun 08, 2023 at 05:01:24PM +0800, Angus Chen wrote:
> > > When add virtio_pci vdpa device,check the vqs number of device cap
> > > and max_vq_pairs from add_config.
> > > Simply starting from failing if the provisioned #qp is not
> > > equal to the one that hardware has.
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > 
> > I am not sure about this one. How does userspace know
> > which values are legal?
> Maybe we can print device cap of device in dev_err?

No one reads these except kernel devs. Surely not userspace.

> > 
> > If there's no way then maybe we should just cap the value
> > to what device can support but otherwise keep the device
> > working.
> We I use max_vqs pair to test vp_vdpa,it doesn't work as expect.
> And there is no any hint of this.

So things don't work either way just differently.
Let's come up with a way for userspace to know what's legal
so things can start working.


> > 
> > > ---
> > > v1: Use max_vqs from add_config
> > > v2: Just return fail if max_vqs from add_config is not same as device
> > > 	cap. Suggested by jason.
> > >
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------------
> > >  1 file changed, 21 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > index 281287fae89f..c1fb6963da12 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct
> > vdpa_mgmt_dev *v_mdev, const char *name,
> > >  	u64 device_features;
> > >  	int ret, i;
> > >
> > > -	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > -				    dev, &vp_vdpa_ops, 1, 1, name, false);
> > > -
> > > -	if (IS_ERR(vp_vdpa)) {
> > > -		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> > > -		return PTR_ERR(vp_vdpa);
> > > +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> > > +		if (add_config->net.max_vq_pairs != (v_mdev->max_supported_vqs /
> > 2)) {
> > > +			dev_err(&pdev->dev, "max vqs 0x%x should be equal to 0x%x
> > which device has\n",
> > > +				add_config->net.max_vq_pairs*2,
> > v_mdev->max_supported_vqs);
> > > +			return -EINVAL;
> > > +		}
> > >  	}
> > >
> > > -	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> > > -
> > > -	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> > > -	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> > > -	vp_vdpa->mdev = mdev;
> > > -
> > >  	device_features = vp_modern_get_features(mdev);
> > >  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > >  		if (add_config->device_features & ~device_features) {
> > > -			ret = -EINVAL;
> > >  			dev_err(&pdev->dev, "Try to provision features "
> > >  				"that are not supported by the device: "
> > >  				"device_features 0x%llx provisioned 0x%llx\n",
> > >  				device_features, add_config->device_features);
> > > -			goto err;
> > > +			return -EINVAL;
> > >  		}
> > >  		device_features = add_config->device_features;
> > >  	}
> > > +
> > > +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> > > +				    dev, &vp_vdpa_ops, 1, 1, name, false);
> > > +
> > > +	if (IS_ERR(vp_vdpa)) {
> > > +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> > > +		return PTR_ERR(vp_vdpa);
> > > +	}
> > > +
> > > +	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> > > +
> > > +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> > > +	vp_vdpa->queues = v_mdev->max_supported_vqs;
> > > +	vp_vdpa->mdev = mdev;
> > >  	vp_vdpa->device_features = device_features;
> > >
> > >  	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> > > --
> > > 2.25.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
