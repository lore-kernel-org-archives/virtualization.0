Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A532E8E0C
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758783319; cv=none; b=Wu4ImuD0xXQwI5/mRjnWlsMgMA+/rCi0+vSmkrRqh4XoskA94xqkNSvE6p0NDCCUJFdp6bpeyvOHHbIk6X85lXsiYLyqrRmtQIDed/N8Gcup6M+qmJqY1g/pQzXsrpD+4jYolNKTAdcJrPRXcqgpArrGKSzNiGEZMClAteqvrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758783319; c=relaxed/simple;
	bh=r2JUlSD7rhwj15a/cE+EKqtmJLQxqexQyH6N87v6L0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjBZ4CXo20KJE8dmvdolmgvBnVSt5LzBK/7Qelgxc878y4xPVDVhcPbsxrmSdMdIig0EvMv0B6aGuhDoUdruc0Ac9Qpck2D9pDzvXVnaPhwYZIF1a1PZ5kfPpmGa6i/I87fY/kMcSXUOA/hUgyB0d/LFGuDx+Cw/J8x07AsTdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XI83y7cR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XI83y7cR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758783313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1afco+OLcbUkuderEKCSHGmDr+kLzLlD2qRO3PXw0Hg=;
	b=XI83y7cRTLyfVAryzm6naT1fTuezs0BSLxaURtvDxlV5vm0bhQXpUSN1q0ZTevma1tCYUS
	55WCpDc/IN4es8WcwFW80dNLmKnws6Fzjm182bsuHYSFQbwoM8vBhJzZnHi6o4hh4efWsG
	bnCki27hpVjqlvKMqgLl9hXawUVg75o=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-KpAEjs7vPIm0W2gHbgpXwQ-1; Thu, 25 Sep 2025 02:55:10 -0400
X-MC-Unique: KpAEjs7vPIm0W2gHbgpXwQ-1
X-Mimecast-MFC-AGG-ID: KpAEjs7vPIm0W2gHbgpXwQ_1758783310
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-ea7d6690854so762940276.0
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 23:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758783310; x=1759388110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1afco+OLcbUkuderEKCSHGmDr+kLzLlD2qRO3PXw0Hg=;
        b=tcP3673dTfev5VL8XY0j2xKVDPrWaw/6UNUr+ZkgDTLrTvbW6KzkpLlyqcX2H7lktW
         lTQGdQLjxP/qmkrdCXu3Eb0RzuwnyAC9tO+RhsD/REh3CLcjeLeJHoDZjm3bEiZpfiWR
         XqXiRSgUiVp3wbNVyxXaSiDsGEKZjIDSSLqofjk3Pb5oc8hZ3QRdckJifHoZre4vp1iI
         zlWb84eCwIfEmK2wXKqysnHDnj7Bhp5YmZOe+VqrzqzXvjBPhlgYJDFHrfAbcsTE+NsA
         5e0QYEbk2QLgKntPY0Q9tvd1/CwKxXasYBqrxTjkqB2fwx2CCZzIoxkX8Q4tmOhXH9Tl
         jU4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwxeWonrs6ylWKBrVQ8xpGcBnvy28eilQ7qR/bQOEQaHhS0s4wgtF6eW3ZMWp6VyI0aG4WhJsvO++3BqHpTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5CsUzEExFSrKR9M0A8vI1VPkNKyxrwSJ4UNMCim1aH2znDGF4
	RdXR14JE/UytinuzNfqlpB36WgkCMTAqNAxBCb9qsqXoxCyUMY6h5LNRtoVPI7WSxZ0aneRzbKI
	Azhb0hMPynVzw8P9EV0sUD5QOPgr05iuLG6W9eFPfrdlaXx6Q0OyfHKBH3xTeCTuiFzJNWSJH0o
	h9BXWoft+nh4DR14slIRdwW8lHFa+pPgaLmT+MpfJhrME=
X-Gm-Gg: ASbGncsF9td9pp1Zo7CvoY8Gw23CGr1saFyuKW3BiFPDVr3m4iY1HnL0fEyK3BPddsp
	rG6tXMTndaOJ36ZjYl0vPbsdTnQUErPSxOaEVH02h3ZL/M1APVFW5po/tHv4h/4lNGQPMU6UPrN
	n9eWGs+IMrprmRr+3ZDk7G6PfXZjKhvYXAynD+j9ajg45cUR6XRN34vorWpbCpfzFQHnMo6O3vz
	1FufwUd
X-Received: by 2002:a05:6902:f87:b0:ead:eaa:52c1 with SMTP id 3f1490d57ef6-eb37fcae0f8mr2372340276.37.1758783309740;
        Wed, 24 Sep 2025 23:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9NYmeNltTeYeivvoYJcWlBhCn4pWsqGDG8RQXH5hutKO64/reoO9IYAJVGBXg9Ri3EtS5/Y2BLzKbK6bc5pY=
X-Received: by 2002:a05:6902:f87:b0:ead:eaa:52c1 with SMTP id
 3f1490d57ef6-eb37fcae0f8mr2372335276.37.1758783309434; Wed, 24 Sep 2025
 23:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250924070045.10361-1-jasowang@redhat.com>
In-Reply-To: <20250924070045.10361-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Sep 2025 08:54:32 +0200
X-Gm-Features: AS18NWDcmdLS-q3ZMtWMmmlfI8XF52ncqudb7kTpWmxj8SH51wcxc4jnfKIa7nY
Message-ID: <CAJaqyWdAP=G=3yqs6CCQJOX6zue6RVieGGTLHt2cQrnxhL1AhA@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] Use virtio map API for VDUSE
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fOHUYBhFS8iKfSnkXEhXt69rYY3n9gRi2MV0U8mj9Xg_1758783310
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 9:00=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Hi all:
>
> With the introduction of the virtio map API, there's no need for VDUSE
> to be hacked with DMA API to work. So this series switches to use
> virtio map API for VDUSE so VDUSE can get rid of the DMA API
> completely.
>
> Please review.
>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>


Thanks!

> Thanks
>
> Changes since V6:
>
> - Typo fixes
>
> Jason Wang (2):
>   vdpa: introduce map ops
>   vduse: switch to use virtio map API instead of DMA API
>
>  drivers/vdpa/Kconfig                     |  8 +--
>  drivers/vdpa/alibaba/eni_vdpa.c          |  3 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c          |  3 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 +-
>  drivers/vdpa/pds/vdpa_dev.c              |  3 +-
>  drivers/vdpa/solidrun/snet_main.c        |  4 +-
>  drivers/vdpa/vdpa.c                      |  3 +
>  drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.c     |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h     |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c       | 79 ++++++++++++------------
>  drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 +-
>  drivers/virtio/virtio_vdpa.c             |  4 +-
>  include/linux/vdpa.h                     | 10 ++-
>  include/linux/virtio.h                   |  4 ++
>  16 files changed, 74 insertions(+), 62 deletions(-)
>
> --
> 2.31.1
>

