Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF07E562
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3hi+Mbo"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA09A416DA
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 20:23:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA09A416DA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S3hi+Mbo
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3oI5GfZxPoZt
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 20:23:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D5B72416C9
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 20:23:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5B72416C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702499035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5C/keDxF1/pt3LjYpoXehfsM1EqRnMNHBvxaU+Hjdwg=;
	b=S3hi+MboDUrdHQJqBzkeOIQFwyWda4sG/QH8lMDmu1hcuFK64MNlC7ZK8ZLszrUzzGOtlr
	4Iyvxhd2T1QD4rvrdp5VWe2KDDhtwa32Bpc9pM1ulq2POyqTBKVlaGOs/2dG7nfysW/8vn
	KKtN/+KGgpMmx4wWd2KC8rdrl0EXASc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-R0UNphLTPtaHUU9mGVayWA-1; Wed, 13 Dec 2023 15:23:53 -0500
X-MC-Unique: R0UNphLTPtaHUU9mGVayWA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b71f9e33easo319249539f.0
        for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 12:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702499033; x=1703103833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5C/keDxF1/pt3LjYpoXehfsM1EqRnMNHBvxaU+Hjdwg=;
        b=dt+7blULMg1f1ma/0NRXaRSZ+NyzfeqUI7TH0NGVSLcJusZqsp5bF5y6av3GrZw/JV
         rTdWdbmwTK0sUWcAY36TRLgkoKzp8peb3b21j4iqPp52Oka+5PgGaVeI63EYf74DJMcg
         CXdnh6Cr4W5XFvyJqrERWBkujuPiQI23FTHuNKZoMygJVgplAh1BYB+p9tlqdAlP1G3+
         OwaLhlJwnL+Svl4EL3vNiz/Ugtri17jx5vw6nTVyiccCd/XgPY90pqhwjJlztXA3W7c8
         R8q03oL4wnLHVZPI8+BBOBvZNABaeuuwspPrZ+35WqyrWDQeB+ZLxi+piQNyax+TAoP4
         6bPA==
X-Gm-Message-State: AOJu0YwtTMgKhbALHPy/4h7libj8SU0uRnVJolUlUiMexLMmyixtnl/A
	7QvsMpJlt8lWjZwE8yGQ0jAqvcOHaoHJClz9leaW0wD1XLuU/V5HSnN5IkDcYlNgVspxWfGqD1f
	1u+5z8GCaPnrhoksd9E1uwgiYvQ/h6FW92WS6viOi1A==
X-Received: by 2002:a6b:7009:0:b0:7b7:430e:b6d3 with SMTP id l9-20020a6b7009000000b007b7430eb6d3mr4887265ioc.19.1702499033007;
        Wed, 13 Dec 2023 12:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVH/Wa4FgSzR7V+CcfM/i9gA7Z0wWs/QWlnrtIE7JmYOrHsB69O/zXT6ljBY0amDk6CkU7pw==
X-Received: by 2002:a6b:7009:0:b0:7b7:430e:b6d3 with SMTP id l9-20020a6b7009000000b007b7430eb6d3mr4887249ioc.19.1702499032741;
        Wed, 13 Dec 2023 12:23:52 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id p8-20020a0566380e8800b0046926dafa32sm3041580jas.135.2023.12.13.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 12:23:52 -0800 (PST)
Date: Wed, 13 Dec 2023 13:23:40 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "mst@redhat.com" <mst@redhat.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "parav@nvidia.com"
 <parav@nvidia.com>, "feliu@nvidia.com" <feliu@nvidia.com>,
 "jiri@nvidia.com" <jiri@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "si-wei.liu@oracle.com"
 <si-wei.liu@oracle.com>, "leonro@nvidia.com" <leonro@nvidia.com>,
 "maorg@nvidia.com" <maorg@nvidia.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: Re: [PATCH V7 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231213132340.4f692bd0.alex.williamson@redhat.com>
In-Reply-To: <fc4a3133-0233-4843-a4e4-ad86e5b91b3d@nvidia.com>
References: <20231207102820.74820-1-yishaih@nvidia.com>
	<20231207102820.74820-10-yishaih@nvidia.com>
	<BN9PR11MB5276C9276E78C66B0C5DA9088C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
	<fc4a3133-0233-4843-a4e4-ad86e5b91b3d@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Dec 2023 14:25:10 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 13/12/2023 10:23, Tian, Kevin wrote:
 
> >> +
> >> +static int virtiovf_pci_probe(struct pci_dev *pdev,
> >> +			      const struct pci_device_id *id)
> >> +{
> >> +	const struct vfio_device_ops *ops = &virtiovf_vfio_pci_ops;
> >> +	struct virtiovf_pci_core_device *virtvdev;
> >> +	int ret;
> >> +
> >> +	if (pdev->is_virtfn && virtio_pci_admin_has_legacy_io(pdev) &&
> >> +	    !virtiovf_bar0_exists(pdev))
> >> +		ops = &virtiovf_vfio_pci_tran_ops;  
> > 
> > I have a confusion here.
> > 
> > why do we want to allow this driver binding to non-matching VF or
> > even PF?  
> 
> The intention is to allow the binding of any virtio-net device (i.e. PF, 
> VF which is not transitional capable) to have a single driver over VFIO 
> for all virtio-net devices.
> 
> This enables any user space application to bind and use any virtio-net 
> device without the need to care.
> 
> In case the device is not transitional capable, it will simply use the 
> generic vfio functionality.

The algorithm we've suggested for finding the most appropriate variant
driver for the device doesn't include a step of moving on to another
driver if the binding fails.  We lose determinism at that point.
Therefore this driver needs to handle all devices matching the id table.
The fact that virtio dictates various config space fields limits our
ability to refine the match from the id table. Thanks,

Alex

