Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF935F8C5
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163402; cv=none; b=kSWkid7ft2CA4lMN1qavIci71yBbkLkdGDrVkIp8j4XJzp0hYg6wjToE9/qTbbd0RywUcU5K1f4jhOkvA52Lw0efRbApdSOIvuJu31ws62ol+2D+3bj/O1a6gPlp4eZmTKGSGEgYDVzdvKo8HOFkTwukB0KDWByhqab9cItTCGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163402; c=relaxed/simple;
	bh=o0uU4mhGXJZO9po7ce2COVrZwBAiTkDLdpFzVPA6lUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TKvvNwOvU0gvlG7OwgIsyF/nQN1xrPwImhPHtvuVykVDxDN+5G4MEs4s7HU5CNBIZGYNVmVl5L2hFy8OYMotOtGk5FmGZnNQYzjGSvb3Sa9J/rXIrG7lTKbfnwIgEydl8RDzl57jxgg/2HDh6gmoeLK9wL4nr1jwdIoAKN98wGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqMJT8t9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqMJT8t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782163399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQ9Ao83GRSB9E8noNCRoGI9ruhwPtjFd8I0Tg7tzcOY=;
	b=VqMJT8t9zSMy5q2jOYVvkZPdyNtEHPyWVIUFQ55Biw1PLFY6I7S9SKSCUtUmtwkdq9pNKo
	SUVQXXmhZnrTt8v5X6/sf6nDntyE5N6pfx4Ez9wCeLdeLBoIHndv9pnknpV53vflSgdt8o
	EUz3sXfs+Q1hnt5yDf/NUFONRI6FpVI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-agMISJDdNHKdKhjO7jPNkA-1; Mon, 22 Jun 2026 17:23:18 -0400
X-MC-Unique: agMISJDdNHKdKhjO7jPNkA-1
X-Mimecast-MFC-AGG-ID: agMISJDdNHKdKhjO7jPNkA_1782163397
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4923411f041so39192165e9.2
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 14:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782163397; x=1782768197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQ9Ao83GRSB9E8noNCRoGI9ruhwPtjFd8I0Tg7tzcOY=;
        b=YZRv5EzY8QUyj2ZrUoJt5MvciRr0CCkuIYR6PQayFIlw1XOURzk0Yrq4k83BtU98gJ
         nTF2pRBRiqg/i7N8tLFcKohFLzNZw1sif6mWbWhZOrLjhRB9bMOjxzwKEqfhsjm6jJYA
         RSrgM86/Y2GQjeZHWXzNPHowHmHoN6H5BlitiP/Ct4mEkNRnca98MIPK2v5XMvuoFQXU
         qkKc3eiv8ScsxtWXgSTDRMsRUS7Q+dfObPWFD58abuaWkvQkXEVsZfxxlI3Vreb3Tg1H
         KIV1P/AnUTjWC/D8I4OmHyzxDPFfbNhqWSlqjIixn3AwKR2wWuJk/AmIoN7rxO45n2W9
         8KBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8C4Ld7KrAeAf8TTO5K9y1SbFoiU8bz6dd5/sYdeRxiKaYfomvqNhVb2S19ureiLVG7gYGHHCSPrDnlwK5h9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqOCAG4WmOwpwMPdT462io+ENEMcrmNYNLI0qKOAP8IR6WxyMp
	pzrbNt367Qqie+HygCwIDnM1t7JHX37bOQBwMV2VzAXOv3v0SIvTbfjfwgaVtoynXOmKZW2BSE+
	nGWSjBS8e7jJcerXymqKGyKkQDwHgubUKPEdmEHt5iiqEEN7L/VDZBkCwGXKCd502xZ4g
X-Gm-Gg: AfdE7clo/N1DQ+aBFfVCr+qPfJC5Y73zVo/c8KRlKX+b4LPcnGjEyiwymrtEGajKjJW
	HoNylfeXn7PylzXi+A3adYVYpCaavdl8PmqjA+OrmpOV3IAByWRs/K+0+Wy5QnnKmfj9gOSOFSJ
	vCHQksV1fu+ceJKEIQoiWCvvkRGr4+QpECIJ+R+cLBg4Lev6/fMfkbuMw2zKuPqlAvDTUsVbTXg
	OiBD9dIYQxZQdb7luMh/gZFZhYaEXhxXc2F+CQE2f6T9my5JGUGTcEErETBtbacqAr1MryK3SMb
	RMwsOUQ5zahZ5W/0KDteusDvTcttNEeF96Ydpad+uKMU4CyjlwmfTUM2NPgzqQCgbysQsrmd4CQ
	yhxK3FzObPKWf+22ItVIqdirKN7d1Y+Yc
X-Received: by 2002:a05:600c:8010:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-4923eeaca70mr262346935e9.0.1782163397075;
        Mon, 22 Jun 2026 14:23:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:490:bad9:de43 with SMTP id 5b1f17b1804b1-4923eeaca70mr262346615e9.0.1782163396611;
        Mon, 22 Jun 2026 14:23:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249455302sm242195865e9.15.2026.06.22.14.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:23:15 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:23:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com,
	adelva@google.com, aesteve@redhat.com, changyeon@google.com,
	daniel.almeida@collabora.com, eperezma@redhat.com, gnurou@gmail.com,
	gurchetansingh@google.com, hverkuil@xs4all.nl, jasowang@redhat.com,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	nicolas.dufresne@collabora.com, virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH v4 8/8] media: virtio: Add MAINTAINERS entry
Message-ID: <20260622172208-mutt-send-email-mst@kernel.org>
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260622204343.1994418-9-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260622204343.1994418-9-briandaniels@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _H4Xwogmd3mi-5lnulZcUnP1wmKADsX7CHGXngKnBnI_1782163397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2026 at 04:43:43PM -0400, Brian Daniels wrote:
> From: Alexandre Courbot <gnurou@gmail.com>
> 
> Add an entry for the new virtio-media driver.
> 
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> Co-developed-by: Brian Daniels <briandaniels@google.com>
> Signed-off-by: Brian Daniels <briandaniels@google.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index efbf80806..af370b787 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28327,6 +28327,12 @@ S:	Maintained
>  F:	drivers/iommu/virtio-iommu.c
>  F:	include/uapi/linux/virtio_iommu.h
>  
> +VIRTIO MEDIA DRIVER
> +M:	Brian Daniels <briandaniels@google.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	drivers/media/virtio/
> +

add to virtio core too pls.


>  VIRTIO MEM DRIVER
>  M:	David Hildenbrand <david@kernel.org>
>  L:	virtualization@lists.linux.dev
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog

