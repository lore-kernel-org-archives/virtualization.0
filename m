Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4195F1E3
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzRmC8Mq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48BA183A93
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 16:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48BA183A93
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XzRmC8Mq
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U74yrkFokWjA
	for <virtualization@lists.linux-foundation.org>;
	Thu, 14 Dec 2023 16:15:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 694DD838FB
	for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 16:15:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 694DD838FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702570508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elA1LnD+RmkYFXMikRa/+2tlwQiuOdNu17EEpCMxRLA=;
	b=XzRmC8MqCKNUw4pSiWnE7xyq4IiJ3iaqIusLFZfkD8DtwiSw6RnzldnxPaAhJ6bgQ4tB0k
	PCwSWya5uMHk/AKSdRTPn2oFKhQVCzgHNjSMjeKpties7+4ApHb7FjCYWdYPqS3QuDoi4P
	1lW0gF504/iE/jCu/JBDE0+oUjRgVQY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-VGgZkCutP06PfrcJBq7I7g-1; Thu, 14 Dec 2023 11:15:06 -0500
X-MC-Unique: VGgZkCutP06PfrcJBq7I7g-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d9e382c6a3so10307136a34.0
        for <virtualization@lists.linux-foundation.org>; Thu, 14 Dec 2023 08:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570505; x=1703175305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elA1LnD+RmkYFXMikRa/+2tlwQiuOdNu17EEpCMxRLA=;
        b=L1keYMuJcbYja8RMsaFbKT8rf2GU65UQWUh5uTenf3hJBfQA6NSz5Uj/UgaoGDUKo1
         twGHzrNLhvX7Tmni1KfciOIuUM7Sc8F4uIhT2qZyV7RwXXsj1TkdyXd44ellGYnp5grH
         tolvH1L7SlXVnduSf3jUYYblj2t3FyAsNCbjlZjDvLWOYz5hPfH+PVcJrzfk7hhsJ25U
         sZpk9MMdzRGlvsETefYV3jBgqGVN989uJmGjBxfD+i0aLl2dM+qgYjeLcrLAq+zD4Lf6
         28tHBExFgj3zbINTsx6SRMbDKKw6MJ1ePLOjc29dqgPyMTZc/gGM753+tEqgGTw5ySPA
         QuBg==
X-Gm-Message-State: AOJu0YyWj9Xz5am5kzKlWXGFJb9NmyzFhZ8WJHVNqFMy4J8FG+0hYDOy
	qq+6hwduyj3VdLLu3TjOWpGr6eEY+2SzzzKQzzPyoRPXV3b+poz4t0oddKxMBBx3iOOEdXi9ANG
	JFbwwRFDArYm93gmBs/5B2hi20DDIQHt5nFdIadAPkA==
X-Received: by 2002:a05:6830:134b:b0:6d9:cc8c:6a4c with SMTP id r11-20020a056830134b00b006d9cc8c6a4cmr10093714otq.45.1702570505510;
        Thu, 14 Dec 2023 08:15:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLr8ldWaQHK+BF6YbN5bG8mnbtpb6mxA6leqUud6IBj6/QdKu8++ET3bwWLgRbZJ/6Ycawxw==
X-Received: by 2002:a05:6830:134b:b0:6d9:cc8c:6a4c with SMTP id r11-20020a056830134b00b006d9cc8c6a4cmr10093694otq.45.1702570505249;
        Thu, 14 Dec 2023 08:15:05 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id o8-20020a9d6d08000000b006d8017dcda9sm3234646otp.75.2023.12.14.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:04 -0800 (PST)
Date: Thu, 14 Dec 2023 09:15:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <kvm@vger.kernel.org>,
 <virtualization@lists.linux-foundation.org>, <parav@nvidia.com>,
 <feliu@nvidia.com>, <jiri@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <si-wei.liu@oracle.com>, <leonro@nvidia.com>,
 <maorg@nvidia.com>
Subject: Re: [PATCH V7 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231214091501.4f843335.alex.williamson@redhat.com>
In-Reply-To: <5b596e34-aac9-4786-8f13-4d85986803f0@nvidia.com>
References: <20231207102820.74820-1-yishaih@nvidia.com>
	<20231207102820.74820-10-yishaih@nvidia.com>
	<20231214013642-mutt-send-email-mst@kernel.org>
	<ea0cdfc9-35f4-4cc1-b0de-aaef0bebeb51@nvidia.com>
	<20231214041515-mutt-send-email-mst@kernel.org>
	<37bcb2f0-a83d-4806-809c-ec5d004ddb20@nvidia.com>
	<20231214075905.59a4a3ba.alex.williamson@redhat.com>
	<20231214100403-mutt-send-email-mst@kernel.org>
	<5b596e34-aac9-4786-8f13-4d85986803f0@nvidia.com>
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

On Thu, 14 Dec 2023 18:03:30 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 14/12/2023 17:05, Michael S. Tsirkin wrote:
> > On Thu, Dec 14, 2023 at 07:59:05AM -0700, Alex Williamson wrote:  
> >> On Thu, 14 Dec 2023 11:37:10 +0200
> >> Yishai Hadas <yishaih@nvidia.com> wrote:
> >>>>> OK, if so, we can come with the below extra code.
> >>>>> Makes sense ?
> >>>>>
> >>>>> I'll squash it as part of V8 to the relevant patch.
> >>>>>
> >>>>> diff --git a/drivers/virtio/virtio_pci_modern.c
> >>>>> b/drivers/virtio/virtio_pci_modern.c
> >>>>> index 37a0035f8381..b652e91b9df4 100644
> >>>>> --- a/drivers/virtio/virtio_pci_modern.c
> >>>>> +++ b/drivers/virtio/virtio_pci_modern.c
> >>>>> @@ -794,6 +794,9 @@ bool virtio_pci_admin_has_legacy_io(struct pci_dev
> >>>>> *pdev)
> >>>>>           struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
> >>>>>           struct virtio_pci_device *vp_dev;
> >>>>>
> >>>>> +#ifndef CONFIG_X86
> >>>>> +       return false;
> >>>>> +#endif
> >>>>>           if (!virtio_dev)
> >>>>>                   return false;
> >>>>>
> >>>>> Yishai  
> >>>>
> >>>> Isn't there going to be a bunch more dead code that compiler won't be
> >>>> able to elide?
> >>>>      
> >>>
> >>> On my setup the compiler didn't complain about dead-code (I simulated it
> >>> by using ifdef CONFIG_X86 return false).
> >>>
> >>> However, if we suspect that some compiler might complain, we can come
> >>> with the below instead.
> >>>
> >>> Do you prefer that ?
> >>>
> >>> index 37a0035f8381..53e29824d404 100644
> >>> --- a/drivers/virtio/virtio_pci_modern.c
> >>> +++ b/drivers/virtio/virtio_pci_modern.c
> >>> @@ -782,6 +782,7 @@ static void vp_modern_destroy_avq(struct
> >>> virtio_device *vdev)
> >>>            BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ) | \
> >>>            BIT_ULL(VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO))
> >>>
> >>> +#ifdef CONFIG_X86
> >>>    /*
> >>>     * virtio_pci_admin_has_legacy_io - Checks whether the legacy IO
> >>>     * commands are supported
> >>> @@ -807,6 +808,12 @@ bool virtio_pci_admin_has_legacy_io(struct pci_dev
> >>> *pdev)
> >>>                   return true;
> >>>           return false;
> >>>    }
> >>> +#else
> >>> +bool virtio_pci_admin_has_legacy_io(struct pci_dev *pdev)
> >>> +{
> >>> +       return false;
> >>> +}
> >>> +#endif
> >>>    EXPORT_SYMBOL_GPL(virtio_pci_admin_has_legacy_io);  
> >>
> >> Doesn't this also raise the question of the purpose of virtio-vfio-pci
> >> on non-x86?  Without any other features it offers nothing over vfio-pci
> >> and we should likely adjust the Kconfig for x86 or COMPILE_TEST.
> >> Thanks,
> >>
> >> Alex  
> > 
> > Kconfig dependency is what I had in mind, yes. The X86 specific code in
> > virtio_pci_modern.c can be moved to a separate file then use makefile
> > tricks to skip it on other platforms.
> >   
> 
> The next feature for that driver will be the live migration support over 
> virtio, once the specification which is WIP those day will be accepted.
> 
> The migration functionality is not X86 dependent and doesn't have the 
> legacy virtio driver limitations that enforced us to run only on X86.
> 
> So, by that time we may need to enable in VFIO the loading of 
> virtio-vfio-pci driver and put back the ifdef X86 inside VIRTIO, only on 
> the legacy IO API, as I did already in V8.
> 
> So using a KCONFIG solution in VFIO is a short term one, which will be 
> reverted just later on.

I understand the intent, but I don't think that justifies building a
driver that serves no purpose in the interim.  IF and when migration
support becomes a reality, it's trivial to update the depends line.

> In addition, the virtio_pci_admin_has_legacy_io() API can be used in the 
> future not only by VFIO, this was one of the reasons to put it inside 
> VIRTIO.

Maybe this should be governed by a new Kconfig option which would be
selected by drivers like this.  Thanks,

Alex

