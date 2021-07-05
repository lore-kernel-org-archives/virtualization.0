Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF157C07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:35:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2A0613C8
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 06:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2A0613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EA004046F;
	Mon,  5 Jul 2021 06:35:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJc3cw8qBCpD; Mon,  5 Jul 2021 06:35:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 807E24045A;
	Mon,  5 Jul 2021 06:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E7BFC0010;
	Mon,  5 Jul 2021 06:35:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85B55C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 535FC606B3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NfCqcs32t4lz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:35:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2D0786066B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 06:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625466899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUn2BLJAFkyaHY1ZuaHGYZbVrSRfM4IcVOnAHiEUpR8=;
 b=JXpMHg0eaoemgiv811epzyIMlFrjDRlU2aOhdRHJuYqX0nIWUmG28wb5Mszet2fAAQKL4N
 qcB2FtmQwYYmSSJu2obOSjwdgYmxMVTlkahLdlqdgYGP4sTeviLDxsZMDCwTVhRH4RpoYU
 lJimrkAna1Fu7p2QNZPSrUDPBukYhgU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Z_UKLhoUOOuhjEDirzTxAA-1; Mon, 05 Jul 2021 02:34:57 -0400
X-MC-Unique: Z_UKLhoUOOuhjEDirzTxAA-1
Received: by mail-ed1-f69.google.com with SMTP id
 y17-20020a0564023591b02903951740fab5so8613634edc.23
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 23:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dUn2BLJAFkyaHY1ZuaHGYZbVrSRfM4IcVOnAHiEUpR8=;
 b=ChMXIpCZCalN+SiR4q4Y+CdtaX048SVehW85pXwwLwVThQf6v2YbyE3f/VtK62dfph
 G55YiQ7QohoNKuEQKC8eTN7mR3UlumAoUX/CTqtZyQJKHfJVt4rIB3SOXJDozHv4jmrX
 J8dyHWUAeEDKkgtA1UlBt5oRktVUkExQJoTNIdy8iQdkp2AbHOdHnJCh2giYi2jd1vob
 x5yGtiSJke4SfwdHtzMX0WOLiGVxrIo2v+ia8iwdZedPR6niKXWh3ZfDgixqnCUTfeeQ
 JkE38o1AiswMEUjECMOpD7p1LbMrJWp7XgarGU51bOozViNcWKqoBdyAE+gRL+BuoYLT
 YIkw==
X-Gm-Message-State: AOAM533qzHC2KtPy02/9hPLm3tZdxaNx3Fsr6x16mEQMsQoZtIscidde
 atgaVb+MSINLHvK+8zZfLXPGYkAm1bB91wrtyibE+eIVzil/IgG5NU1F5ORcGmMTe9SGzFeRdcK
 DQXbZo7s6OnJFfDjVStJ672RXl7AQmnhvcBWULfWIFQ==
X-Received: by 2002:a05:6402:1001:: with SMTP id
 c1mr14439022edu.26.1625466896741; 
 Sun, 04 Jul 2021 23:34:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrRq3MRlQH+mGsiMRP8CKAZ/zYD48i3O+gBiuOktjRvq+QwTg+tzV3G5Q/ybjcyomyf2ha9w==
X-Received: by 2002:a05:6402:1001:: with SMTP id
 c1mr14439011edu.26.1625466896604; 
 Sun, 04 Jul 2021 23:34:56 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id ja11sm3945759ejc.62.2021.07.04.23.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 23:34:54 -0700 (PDT)
Date: Mon, 5 Jul 2021 02:34:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/3] vDPA/ifcvf: implement management netlink framework
 for ifcvf
Message-ID: <20210705023354-mutt-send-email-mst@kernel.org>
References: <20210630082145.5729-1-lingshan.zhu@intel.com>
 <20210630082145.5729-3-lingshan.zhu@intel.com>
 <1ebb3dc8-5416-f718-2837-8371e78dd3d0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1ebb3dc8-5416-f718-2837-8371e78dd3d0@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Zhu Lingshan <lingshan.zhu@intel.com>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Mon, Jul 05, 2021 at 01:04:11PM +0800, Jason Wang wrote:
> > +static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > +{
> > +	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
> > +	struct device *dev = &pdev->dev;
> > +	struct ifcvf_adapter *adapter;
> 
> 
> adapter is not used.

It's used in error handling below. It's not *initialized*.

> 
> > +	u32 dev_type;
> > +	int ret;
> > +
> > +	ifcvf_mgmt_dev = kzalloc(sizeof(struct ifcvf_vdpa_mgmt_dev), GFP_KERNEL);
> > +	if (!ifcvf_mgmt_dev) {
> > +		IFCVF_ERR(pdev, "Failed to alloc memory for the vDPA management device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dev_type = get_dev_type(pdev);
> > +	switch (dev_type) {
> > +	case VIRTIO_ID_NET:
> > +		ifcvf_mgmt_dev->mdev.id_table = id_table_net;
> > +		break;
> > +	case VIRTIO_ID_BLOCK:
> > +		ifcvf_mgmt_dev->mdev.id_table = id_table_blk;
> > +		break;
> > +	default:
> > +		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", dev_type);
> > +		ret = -EOPNOTSUPP;
> > +		goto err;
> > +	}
> > +
> > +	ifcvf_mgmt_dev->mdev.ops = &ifcvf_vdpa_mgmt_dev_ops;
> > +	ifcvf_mgmt_dev->mdev.device = dev;
> > +	ifcvf_mgmt_dev->pdev = pdev;
> > +
> > +	ret = pcim_enable_device(pdev);
> > +	if (ret) {
> > +		IFCVF_ERR(pdev, "Failed to enable device\n");
> > +		goto err;
> > +	}
> > +
> > +	ret = pcim_iomap_regions(pdev, BIT(0) | BIT(2) | BIT(4),
> > +				 IFCVF_DRIVER_NAME);
> > +	if (ret) {
> > +		IFCVF_ERR(pdev, "Failed to request MMIO region\n");
> > +		goto err;
> > +	}
> > +
> > +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	if (ret) {
> > +		IFCVF_ERR(pdev, "No usable DMA configuration\n");
> > +		goto err;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(dev, ifcvf_free_irq_vectors, pdev);
> > +	if (ret) {
> > +		IFCVF_ERR(pdev,
> > +			  "Failed for adding devres for freeing irq vectors\n");
> > +		goto err;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +
> > +	ret = vdpa_mgmtdev_register(&ifcvf_mgmt_dev->mdev);
> > +	if (ret) {
> > +		IFCVF_ERR(pdev,
> > +			  "Failed to initialize the management interfaces\n");
> >   		goto err;
> >   	}
> > @@ -533,14 +610,21 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   err:
> >   	put_device(&adapter->vdpa.dev);
> > +	kfree(ifcvf_mgmt_dev);
> >   	return ret;
> >   }

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
