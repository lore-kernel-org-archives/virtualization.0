Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A990CDB483
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 20:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 911BC400D1;
	Tue, 17 Oct 2023 20:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 911BC400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VHEaqi42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fPkjX6XIeAUP; Tue, 17 Oct 2023 20:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 71B1640128;
	Tue, 17 Oct 2023 20:24:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71B1640128
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4555BC0071;
	Tue, 17 Oct 2023 20:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F9ECC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 20:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AC5D812FD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 20:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3AC5D812FD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VHEaqi42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SYObW-Flf0hR
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 20:24:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38FFF80E96
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 20:24:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38FFF80E96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697574293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtUjdWCB9WMQU/mTfw17tXlwwNnT6x1gJtmkKU4zsR8=;
 b=VHEaqi42my4AxYraXgm3xSmzpX7GLEhUeisWjkQfoA0Ojjhi+pN+yBdTxmAW03srRfqVS3
 BbdOf3sl3tndIHvEySCPkFspWand1r8rpY2jbOXIaSbtXwa1XpuuHXMmCGrTqajJBhGIfA
 637X9yqQ3wZ5DIOmAUBHXQKiZq/Cv/c=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-qbx7NXXiMcazMdLoNoepWA-1; Tue, 17 Oct 2023 16:24:51 -0400
X-MC-Unique: qbx7NXXiMcazMdLoNoepWA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-79fa06105b0so294570439f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 13:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574291; x=1698179091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtUjdWCB9WMQU/mTfw17tXlwwNnT6x1gJtmkKU4zsR8=;
 b=Ys138SqDGoxjmUAgWVDIAnn/QeVNOc1qa1SflxNPfhnEctxa9O0arPQwIhJW/ikEvj
 GJH8YhWOLyd69EhnmJv+7wnAI2+BtB52lcp7Hg504faExWBrGkODWUXuavurTj4mp8oF
 7dNr7GcK9LWB4PG4MzIvxdszvPA5Lp9LOtk/+Sz/VIlSwH5oPsNNU/mARrZRWzNZTyYN
 RUiirvHTjqpMMRo792k52KMvPeygygzKUdomfLPHy3+qyFeUm9E2hXha0tOZxyNRcnCy
 SvEBLAJIglVjQXivbGo2H41bzJa/g2Uu2ag9AWAcM86KxKEddrnqvScal0DbHEE4MWGU
 dyLQ==
X-Gm-Message-State: AOJu0YxVxWHcn9we9992LJ1HuZiDl/jtj8pHDRnN9XByXElcEqjPKWgW
 cNz/859F9kOH9vd/mwk0JhQXEPgU9OsFlxoh2OC5YBbaMgBgjMAQsiuM/CKdVumxTy7nsR/7lSh
 MIlip30g13KKG/GuUUusvZU4CqwuoYw+OBqN741Detg==
X-Received: by 2002:a92:d98e:0:b0:34f:20d9:74a9 with SMTP id
 r14-20020a92d98e000000b0034f20d974a9mr2740340iln.11.1697574290779; 
 Tue, 17 Oct 2023 13:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlyFESvUm/reMsU2KMAu2LePTBp8vzSNdVO5O7BVyyVkEJDRLpPI9geTQERTRpMwuocgfjvA==
X-Received: by 2002:a92:d98e:0:b0:34f:20d9:74a9 with SMTP id
 r14-20020a92d98e000000b0034f20d974a9mr2740328iln.11.1697574290530; 
 Tue, 17 Oct 2023 13:24:50 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 w14-20020a02cf8e000000b0045c79bb28d6sm683968jar.114.2023.10.17.13.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:24:50 -0700 (PDT)
Date: Tue, 17 Oct 2023 14:24:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231017142448.08673cdc.alex.williamson@redhat.com>
In-Reply-To: <20231017134217.82497-10-yishaih@nvidia.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Tue, 17 Oct 2023 16:42:17 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:
> +static int virtiovf_pci_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *id)
> +{
> +	const struct vfio_device_ops *ops = &virtiovf_acc_vfio_pci_ops;
> +	struct virtiovf_pci_core_device *virtvdev;
> +	int ret;
> +
> +	if (pdev->is_virtfn && virtiovf_support_legacy_access(pdev) &&
> +	    !virtiovf_bar0_exists(pdev) && pdev->msix_cap)
> +		ops = &virtiovf_acc_vfio_pci_tran_ops;


This is still an issue for me, it's a very narrow use case where we
have a modern device and want to enable legacy support.  Implementing an
IO BAR and mangling the device ID seems like it should be an opt-in,
not standard behavior for any compatible device.  Users should
generally expect that the device they see in the host is the device
they see in the guest.  They might even rely on that principle.

We can't use the argument that users wanting the default device should
use vfio-pci rather than virtio-vfio-pci because we've already defined
the algorithm by which libvirt should choose a variant driver for a
device.  libvirt will choose this driver for all virtio-net devices.

This driver effectively has the option to expose two different profiles
for the device, native or transitional.  We've discussed profile
support for variant drivers previously as an equivalent functionality
to mdev types, but the only use case for this currently is out-of-tree.
I think this might be the opportunity to define how device profiles are
exposed and selected in a variant driver.

Jason had previously suggested a devlink interface for this, but I
understand that path had been shot down by devlink developers.  Another
obvious option is sysfs, where we might imagine an optional "profiles"
directory, perhaps under vfio-dev.  Attributes of "available" and
"current" could allow discovery and selection of a profile similar to
mdev types.

Is this where we should head with this or are there other options to
confine this transitional behavior?

BTW, what is "acc" in virtiovf_acc_vfio_pci_ops?

> +
> +	virtvdev = vfio_alloc_device(virtiovf_pci_core_device, core_device.vdev,
> +				     &pdev->dev, ops);
> +	if (IS_ERR(virtvdev))
> +		return PTR_ERR(virtvdev);
> +
> +	dev_set_drvdata(&pdev->dev, &virtvdev->core_device);
> +	ret = vfio_pci_core_register_device(&virtvdev->core_device);
> +	if (ret)
> +		goto out;
> +	return 0;
> +out:
> +	vfio_put_device(&virtvdev->core_device.vdev);
> +	return ret;
> +}
> +
> +static void virtiovf_pci_remove(struct pci_dev *pdev)
> +{
> +	struct virtiovf_pci_core_device *virtvdev = dev_get_drvdata(&pdev->dev);
> +
> +	vfio_pci_core_unregister_device(&virtvdev->core_device);
> +	vfio_put_device(&virtvdev->core_device.vdev);
> +}
> +
> +static const struct pci_device_id virtiovf_pci_table[] = {
> +	/* Only virtio-net is supported/tested so far */
> +	{ PCI_DRIVER_OVERRIDE_DEVICE_VFIO(PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1041) },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, virtiovf_pci_table);
> +
> +static struct pci_driver virtiovf_pci_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = virtiovf_pci_table,
> +	.probe = virtiovf_pci_probe,
> +	.remove = virtiovf_pci_remove,
> +	.err_handler = &vfio_pci_core_err_handlers,
> +	.driver_managed_dma = true,
> +};
> +
> +module_pci_driver(virtiovf_pci_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yishai Hadas <yishaih@nvidia.com>");
> +MODULE_DESCRIPTION(
> +	"VIRTIO VFIO PCI - User Level meta-driver for VIRTIO device family");

Not yet "family" per the device table.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
