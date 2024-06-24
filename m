Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FC12F360
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227262; cv=none; b=ouD2Jx3ySC+wGGJtrQbUaA6U8tde4jZfnpxBCvGc0+r8HZ+U5k36dNXTRcYCWsSG20m0JL5CTU+v8iE651N8tRTzmNiqoT7hllV70miyQOYCemI1RetoZLnoxlJZfrfiwsbQTaSiQOxpRihSjN0YlnExVT/kLCzAo3OeZRc+76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227262; c=relaxed/simple;
	bh=lA57TUnv88ubOPDxYqrAeNecX9XrPBVbC2Lxk/KAOOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RXutWAmP1/4ZESitkX2Vy8ohsRGUCeOkFjKQ5h0YxO6gNu/Uqqn/XLgBH9L0CrraPxI1UYJTEXesRQlU5IghhZ47T8SdG2PH3J+QbGYRuNidqFNd4z7Zc5iguq2h9E36PvNwojtE3xNauHZIgZyjoD/hqkjKB07ImyhduL/KtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GltSIQ/z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GltSIQ/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719227254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s939IsDQZ73ja7AFGFUbGu9fXrMx3zw40x9hE3QJSAU=;
	b=GltSIQ/zKFf0OOCzLzXrpGlWNmjPy4DljGJ68w+bS/aNIQcaWj4a4migRQLREx2HRlVUJB
	s6rYkW54qxFdGs2ESgZ3NcM3mn1/I1JjkocvMOgGsZwhEaXJgvQjfs9ZoGIMXSLjOD1pN5
	2VodRBtyAKrQkWqjb8FUEEaNNFo2h9w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-TQRbUvwEOYijAcFh1dhdZg-1; Mon, 24 Jun 2024 07:07:30 -0400
X-MC-Unique: TQRbUvwEOYijAcFh1dhdZg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52cdea53043so1230242e87.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 04:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719227249; x=1719832049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s939IsDQZ73ja7AFGFUbGu9fXrMx3zw40x9hE3QJSAU=;
        b=GXmQvPMAD9stm7vVJRxt6WmtoLcQ4sve4Cf9Sx6X2r63g9N1rkzA4pVWpDVrCBZCd3
         Bp6iC/R9ABkXemDovR4HEkRri/ZlSZaZ73wP9M7TmoV6UdRXhEtS5DVO2htnTTRM+OGE
         Od71o9stGQlYhhX+waBXekFAwSKefRX5dmmoDi3sB1/6MCD9D+ZsbPemtZw963eOxLsk
         7eryGfF6Q3Ww6/0bSnPqvoJiIsa+LnXDCC6exvektiHsBpm1NPZy/GU5i4x1HZ1E4Wjf
         a++ezFkiEyD1sxdcyNRuE+YFMegZ1hpydCA6c6/65/+l/jCuNYivLKHbHU1kIyWjElmG
         +kzA==
X-Gm-Message-State: AOJu0Ywlu4WHfzh0fMFby2eld+OX6SSQrwlCfIFamwYgv2WDSHagtHu9
	7Pwrrofk+ORRW2mn3L4TGNBl3J85R5wiWWJBdKtQDjSum752aqmA+NnFunnoLj9aHQ+ogSuaFFc
	K4SqTLXicieoeUsweWF1OtS9F4a2qFk6Hhooyt3O03XnsEyi0NvqdQ+JQIpnQwyC9
X-Received: by 2002:ac2:558a:0:b0:52c:dd2d:811d with SMTP id 2adb3069b0e04-52ce1862823mr2376045e87.63.1719227248735;
        Mon, 24 Jun 2024 04:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgt19WvlJ/plLkRSCScXeNYqa/J1YPERPDPNp0vuHONf677U7nYY4rMASxdsUmreZKzL/FPg==
X-Received: by 2002:ac2:558a:0:b0:52c:dd2d:811d with SMTP id 2adb3069b0e04-52ce1862823mr2376023e87.63.1719227247983;
        Mon, 24 Jun 2024 04:07:27 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm9745455f8f.95.2024.06.24.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:07:27 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:07:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240624070412-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 11:04:43AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently the admin queue command execution is serialized by a lock.
> This patchsets lifts this limitation allowing to execute admin queue
> commands in parallel. To do that, admin queue processing needs to be
> converted from polling to interrupt based completion.
> 
> Patches #1-#6 are preparations, making things a bit smoother as well.
> Patch #7 implements interrupt based completion for admin queue.
> Patch #8 finally removes the admin queue serialization lock.

Okay ... I assume this is infrastructure for some other need?
I'll review, but I'd like to see this actually used.


> Jiri Pirko (8):
>   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>   virtio: push out code to vp_avq_index()
>   virtio: create admin queues alongside other virtqueues
>   virtio_pci_modern: create admin queue of queried size
>   virtio_pci_modern: pass cmd as an identification token
>   virtio_pci_modern: use completion instead of busy loop to wait on
>     admin cmd result
>   virtio_pci_modern: remove admin queue serialization lock
> 
>  drivers/virtio/virtio.c            |  28 +----
>  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>  drivers/virtio/virtio_pci_common.h |   9 +-
>  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>  include/linux/virtio.h             |   2 +
>  include/linux/virtio_config.h      |   2 -
>  6 files changed, 150 insertions(+), 160 deletions(-)
> 
> -- 
> 2.45.1

