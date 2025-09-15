Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449E2D47E7
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 22:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976151; cv=none; b=Of1dIGp18AREcy1vj3HPgt92t04KFr2btP3gkityHNnpijLzmO9ZTuCxjhQsztonR9msBm0PT/3EksXhIanBAfhTEv+7rCPCuRlaz8YSS6X+KRZvqJ+AfBAsM7RwqvaSbY21NevjJSxYp+8gMddfj5p2xDeZ9gSirEFUyt7Yq38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976151; c=relaxed/simple;
	bh=uWZzkc6KfMh3P5KwlcvOQ1lRN9uYRLNsJBJpDl3qmvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CW9Nt9INLG8HW5jpVODQFI+AG/AogMrdHBjjR2GLmDANFottZkH7mSujpDdhgYLszm9zZ47sOPM77wZaXsPozk4LCKtOQY4PZXnFI2pPV9CaxUgclqPIuqtkzLx1xUSVjLq1NuG19H58t/n8btSs7MChK33pt88pvYhUds4X5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAydDBPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAydDBPF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757976148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TD9xXEoOjhY9JOq8zHaIaE9mZQfwZx//cSo5EYITbOQ=;
	b=XAydDBPFPvBOj+wAX7iKslehdbWscBMyXGxan1Vyr0rlho09NjmPuzq8r2TBKFbGPBA6nm
	2VWEdsIVjNHs89T/eyvGRJlcqkK/DRXWx6fYeHEkLUSefMrDG/FsgDVWsnjTf8/OjQlzYk
	8MK/k8sivYoBIALRRQOxEvaSrM/m7tg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-OTxqm9VGOh2am3ZnHnlvvA-1; Mon, 15 Sep 2025 18:42:25 -0400
X-MC-Unique: OTxqm9VGOh2am3ZnHnlvvA-1
X-Mimecast-MFC-AGG-ID: OTxqm9VGOh2am3ZnHnlvvA_1757976144
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b07c28f2a71so342439866b.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 15:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976144; x=1758580944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD9xXEoOjhY9JOq8zHaIaE9mZQfwZx//cSo5EYITbOQ=;
        b=rufXG6lberYs8ft/AV9Y5quBkV73xh93kLG6IBMAONcc5gHruJHdtvIFdpoh9ZUfm0
         tOgc397QXThFKuuN3m1AMmmdftEnbXiCo+/keASF62GJTgcB1wUCKyIMGRu0wKOFzzyr
         49TL76bwKZRtnC4i/FCu9joELesbxUhQDFvmk504lIk68ncyWEu2fnxpQsPuxaZaQ7Cd
         FhS56sTwJ9N2ftH9zWg/RV/Galj4akYSbCBaY41FWvFeBaNsDGcOAcLbJb7HyLq6fXHt
         Wm+yCEbp0WLYksDRuueed8q3GiAmwUM367zWgpB5SVyPRmtIXyiXBUI4GAbtlzF6IFcO
         QgCg==
X-Forwarded-Encrypted: i=1; AJvYcCU7gJd58oVxGlwzsjHB5T1A29Xtd6lsfEog1gwwPfQs1gQrEOyUGKLf4/rM243TeKhuc9gs9xET9SakLXrEpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc40Jm20T+/i5oyRH3kqYQmQOjoxvCVgKFQNSFd94yoVGs1wIq
	C6OM6ecUtwG29nWRYFU6DTvBfo7PyQXmDMY+Y/ZzG/C55joJ0IoTbr6GwyTkjAaPnUC4fLiRtSS
	rb09tw2f32LxTzcclp9P8v+/1dG97Gzqvw+0GrPqZge/Oa9iV85zdH5uhDbmtQUm7/gne
X-Gm-Gg: ASbGncvTEcwBxPstUlBKXTg/+Mh9hJEb9ZtbZtS4SCDHVbmzH5sSa0so5sjL+OIabom
	55UPGnKmqGHoFz6Z1GMv2IHkHjwZTqrt/1yF6SDF0I4XWXAb/LvY7F58c/sk8+kyubJEHYrlLhc
	dn3Uql2LbzMJexQTcwKyu1PbvIo09aCYoV2tvATl1dsZ7aizd8kbTW1eMyA8x3FXNObUWEGgeRM
	i0XxvPm+K8Lxi+JL3uM2apCY4b7cg1mUFJRjuRqFuE5QwePkFYNiX9nPcC2W/49IqSlK098V0hV
	dS5EUDQTDZmzdpwdD7xe/7S2d8Jw
X-Received: by 2002:a17:907:3fa1:b0:b04:5a68:8688 with SMTP id a640c23a62f3a-b07c3841eaemr1518860766b.44.1757976143947;
        Mon, 15 Sep 2025 15:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0OLXvGo01RET3Nk5EfQmv0CzoPaU5goKcY2bHHS3dKGO+eN/buDrqyh62FQQSZJp+pH8LPg==
X-Received: by 2002:a17:907:3fa1:b0:b04:5a68:8688 with SMTP id a640c23a62f3a-b07c3841eaemr1518858266b.44.1757976143583;
        Mon, 15 Sep 2025 15:42:23 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e602sm1026338666b.105.2025.09.15.15.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:42:23 -0700 (PDT)
Date: Mon, 15 Sep 2025 18:42:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: Re: [PATCH 0/6] Add multiple address spaces support to VDUSE
Message-ID: <20250915184200-mutt-send-email-mst@kernel.org>
References: <20250826112709.1051172-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250826112709.1051172-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TVeYR6MwJLBiTzUT5HiIAF8oBq_KNaXAQMTvpYxm9I8_1757976144
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Aug 26, 2025 at 01:27:03PM +0200, Eugenio Pérez wrote:
> When used by vhost-vDPA bus driver for VM, the control virtqueue
> should be shadowed via userspace VMM (QEMU) instead of being assigned
> directly to Guest. This is because QEMU needs to know the device state
> in order to start and stop device correctly (e.g for Live Migration).
> 
> This requies to isolate the memory mapping for control virtqueue
> presented by vhost-vDPA to prevent guest from accessing it directly.
> 
> This series add support to multiple address spaces in VDUSE device
> allowing selective virtqueue isolation through address space IDs (ASID).


There hasn't been a new version of this yet, has there?

> The VDUSE device needs to report:
> * Number of virtqueue groups
> * Association of each vq group with each virtqueue
> * Number of address spaces supported.
> 
> Then, the vDPA driver can modify the ASID assigned to each VQ group to
> isolate the memory AS.  This aligns VDUSE with gq}vdpa_sim and nvidia
> mlx5 devices which already support ASID.
> 
> This helps to isolate the environments for the virtqueues that will not
> be assigned directly. E.g in the case of virtio-net, the control
> virtqueue will not be assigned directly to guest.
> 
> This series depends on the series that reworks the virtio mapping API:
> https://lore.kernel.org/all/20250821064641.5025-1-jasowang@redhat.com/
> 
> Also, to be able to test this patch, the user needs to manually revert
> 56e71885b034 ("vduse: Temporarily fail if control queue feature requested").
> 
> PATCH v1:
> * Fix: Remove BIT_ULL(VIRTIO_S_*), as _S_ is already the bit (Maxime)
> * Using vduse_vq_group_int directly instead of an empty struct in union
>   virtio_map.
> 
> RFC v3:
> * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
>   value to reduce memory consumption, but vqs are already limited to
>   that value and userspace VDUSE is able to allocate that many vqs.  Also, it's
>   a dynamic array now.  Same with ASID.
> * Move the valid vq groups range check to vduse_validate_config.
> * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> * Use of array_index_nospec in VDUSE device ioctls.
> * Move the umem mutex to asid struct so there is no contention between
>   ASIDs.
> * Remove the descs vq group capability as it will not be used and we can
>   add it on top.
> * Do not ask for vq groups in number of vq groups < 2.
> * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
>   VDUSE_IOTLB_GET_INFO.
> 
> RFC v2:
> * Cache group information in kernel, as we need to provide the vq map
>   tokens properly.
> * Add descs vq group to optimize SVQ forwarding and support indirect
>   descriptors out of the box.
> * Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
>   part of the struct is the same.
> * Fixes detected testing with OVS+VDUSE.
> 
> Eugenio Pérez (6):
>   vduse: add v1 API definition
>   vduse: add vq group support
>   vduse: return internal vq group struct as map token
>   vduse: create vduse_as to make it an array
>   vduse: add vq group asid support
>   vduse: bump version number
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 385 ++++++++++++++++++++++-------
>  include/linux/virtio.h             |   6 +-
>  include/uapi/linux/vduse.h         |  73 +++++-
>  3 files changed, 373 insertions(+), 91 deletions(-)
> 
> -- 
> 2.51.0

