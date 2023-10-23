Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5660C004C0
	for <virtualization@archiver.kernel.org>; Mon, 23 Oct 2023 16:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55C98612A9;
	Mon, 23 Oct 2023 16:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55C98612A9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jd+Wt/Dd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NM2zNa6guc8y; Mon, 23 Oct 2023 16:45:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B3B3B61209;
	Mon, 23 Oct 2023 16:45:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3B3B61209
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 624E3C0071;
	Mon, 23 Oct 2023 16:45:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34515C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 079A6822D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:45:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 079A6822D2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jd+Wt/Dd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HzwkcE8UlQvX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:45:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2FFE68220E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 16:45:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FFE68220E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698079553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sasvEpHKXFoCs30KM81UDEqwxjrVxOBDKbKNXA3uCdU=;
 b=Jd+Wt/Ddz1Hx8k57U3JEGzdVAP+6dDcZn3VsXadbDsKs9aMGIvwZj56Gz0Y/wFVnZA0uii
 9LxRod3PPNJZlCgfJ4k1CgQTDGrQH8f9w3I7dkadIaFYVQKtKgnHb1fYB8MV3de8YtnUXZ
 OCiGhW8OlRVGtH6KsL6Q4qPTdnmFkOI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ABxD_NP3NxC_vi0xN3N39g-1; Mon, 23 Oct 2023 12:45:51 -0400
X-MC-Unique: ABxD_NP3NxC_vi0xN3N39g-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7a5b1c9ec7aso426945639f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Oct 2023 09:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698079550; x=1698684350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sasvEpHKXFoCs30KM81UDEqwxjrVxOBDKbKNXA3uCdU=;
 b=WPKtThMuI/MGm8ek09ge/xKEBfWcidKfdYJmfqf7Nefk4w8MZFg/wj8wFEVmB0y+I6
 7K2OwwQCtmy60DZDmQFaz2fdlBk7zFg7opOZel9GQDPEI/PwCCOV7DCocrzDsjJ4j5Ux
 A9X7hI54ywRbuG6yD609DHwfih4r3mDxALEXzCSMerIsDTPqeAUJ3fzahICkVT1S+1X4
 Fu9mzoNo/fMNUW7JpDx1V1bb/N0otmgUfacEw/ppC3+53SWQD+a2nKewHrMgpmlUcTMT
 LlAv8pxzOR53Lddq0R2jleQAWr11IpyoKgshSws25yr85Uh81fIg1Xhw0Kyx039HvZ5D
 7e5w==
X-Gm-Message-State: AOJu0YzLw+1IT5Q2hh2rAFzvkzy3gzGsi0pRQ7uivfLASb6Gydt0BdZz
 Fmx2a/2dEgegdra92MdFObwBnQr4y60P1gCY8SUisf6URONIOE71uAKHvFJ9ISYtlkK1S1Bwri/
 SJnqFusymQ1aqj2gi2E4tLozeU8PfV6SGRhaVmQribg==
X-Received: by 2002:a05:6602:2e10:b0:7a9:77ac:5454 with SMTP id
 o16-20020a0566022e1000b007a977ac5454mr1132008iow.18.1698079550446; 
 Mon, 23 Oct 2023 09:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlB5w95pzdyyFq/skony0Xw8FWcM6R9TpGxpduAvW6SMAcXEhPV1NPlwaAbHqxy2xPUHjyQg==
X-Received: by 2002:a05:6602:2e10:b0:7a9:77ac:5454 with SMTP id
 o16-20020a0566022e1000b007a977ac5454mr1131979iow.18.1698079550147; 
 Mon, 23 Oct 2023 09:45:50 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 dx20-20020a0566381d1400b0042b3ad1656bsm2396260jab.45.2023.10.23.09.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:45:49 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:45:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V1 vfio 0/9] Introduce a vfio driver over virtio devices
Message-ID: <20231023104548.07b3aa19.alex.williamson@redhat.com>
In-Reply-To: <20231023162043.GB3952@nvidia.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <6e2c79c2-5d1d-3f3b-163b-29403c669049@nvidia.com>
 <20231023093323.2a20b67c.alex.williamson@redhat.com>
 <20231023154257.GZ3952@nvidia.com>
 <20231023100913.39dcefba.alex.williamson@redhat.com>
 <20231023162043.GB3952@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Mon, 23 Oct 2023 13:20:43 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Oct 23, 2023 at 10:09:13AM -0600, Alex Williamson wrote:
> > On Mon, 23 Oct 2023 12:42:57 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Oct 23, 2023 at 09:33:23AM -0600, Alex Williamson wrote:
> > >   
> > > > > Alex,
> > > > > Are you fine to leave the provisioning of the VF including the control 
> > > > > of its transitional capability in the device hands as was suggested by 
> > > > > Jason ?    
> > > > 
> > > > If this is the standard we're going to follow, ie. profiling of a
> > > > device is expected to occur prior to the probe of the vfio-pci variant
> > > > driver, then we should get the out-of-tree NVIDIA vGPU driver on board
> > > > with this too.    
> > > 
> > > Those GPU drivers are using mdev not vfio-pci..  
> > 
> > The SR-IOV mdev vGPUs rely on the IOMMU backing device support which
> > was removed from upstream.    
> 
> It wasn't, but it changed forms.
> 
> mdev is a sysfs framework for managing lifecycle with GUIDs only.
> 
> The thing using mdev can call vfio_register_emulated_iommu_dev() or
> vfio_register_group_dev(). 
> 
> It doesn't matter to the mdev stuff.
> 
> The thing using mdev is responsible to get the struct device to pass
> to vfio_register_group_dev()

Are we describing what can be done (possibly limited to out-of-tree
drivers) or what should be done and would be accepted upstream?

I'm under the impression that mdev has been redefined to be more
narrowly focused for emulated IOMMU devices and that devices based
around a PCI VF should be making use of a vfio-pci variant driver.

Are you suggesting it's the vendor's choice based on whether they want
the mdev lifecycle support?

We've defined certain aspects of the vfio-mdev interface as only
available for emulated IOMMU devices, ex. page pinning.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
