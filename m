Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E084E4316
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057518; cv=none; b=TDbPzYAaEVqNGUAFuqHs/deFdTBUp2+uL49I0CNYbLGGw4vS+TIn5UBytQUtc4hjAKa7da8QVj9whfHQuXYCVw1ENyX31lXbyq5Ai18GRDyvdcodWAgDIwZJWxT7msqM4WWgRMEDQ74M1Nx2V6VfidUs9EcF6pNDqTa/glOmXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057518; c=relaxed/simple;
	bh=hQ/O1jXrg7vtXtaXIgXlSw0Yo6Wdunyn/TqAF45Oh2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwnjSTvqRPEUQCijwucqMBTsplqco+QC/4q7/D0XAvfSUWMhVgEA2gidUvZndgBVcFm+L8M1f4P9DHk6mcu2usCLFKOqr/Jpw6rBL2XebtFLSMHVTaW6uQF3jDj49qDiquGZQ7MPodODMfBQhS94js3RaydvpKfqNJmYjz9kDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YY/2NJg8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YY/2NJg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792057516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/+KZUJjxU9hKUHG/eUaO/FcCKTpYENEUj2QT3nk9hY=;
	b=YY/2NJg8jBFdNqaeZ0Nz2MWRF9gyovOOeoqcDvgo9zBH946eBgZ0HNLS4/SOWw839DkO8k
	Sp9V5SAoBBY9N1QbME1SPSU1AU0LGlz8W8rYVo2QJk9flXq/xNlBmck7PwSpRpDB7TXKDI
	SEciSkAZGwap0T+aTdW276jzclH+EEI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-V6HzIbo-NrKikOU0N9cciQ-1; Thu, 15 Oct 2026 09:45:15 +0000
X-MC-Unique: V6HzIbo-NrKikOU0N9cciQ-1
X-Mimecast-MFC-AGG-ID: V6HzIbo-NrKikOU0N9cciQ_1792057514
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-837aaa9a3f6so58819377b3.0
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 02:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057514; x=1792662314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/+KZUJjxU9hKUHG/eUaO/FcCKTpYENEUj2QT3nk9hY=;
        b=rbCB0NJHDcwvDxLi6mboYN7ZYcBZeLCTGpqy0TS0dSjIZ0/m3zq+tJLlC+c5aa8oBA
         Na54KvH6GJJQY2xvylyW6fcEKKhkG4LGOcOkpafqujwiIuLWM2+QcFCEbK7qA0AjSZuN
         PGGiQflWY3XJNYUa9PFY1ErrQCmJPnyBv/KDC9cMWiB6BxfVwqao9KLhJsfCdpC+UiJN
         sI5yBRDge/gdjSXzTvGMAGnwhvW+BHI/x/J2YgbxA9Iutyg+IfcO8jR9fylxSRSHe0NF
         EQo2EFGn+wmtmZvJv2Az+0Vds1zm0XVk7XT5eiD5bKGXx5/aU3TR6iuQf8yjmEVlRaG5
         F3pA==
X-Forwarded-Encrypted: i=1; AKwUvBwrB+EZMGwKOup25+00na2iCEh7Qit6RrAdVXgW1azHvWmLc7Ed/Alwpz8Ueeo9kI1kKe6V7yISEWDfQaTDaw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLMeXOnDEsW0PT81wHQZDQ1qet7B2OE635Y3iT7x4oj5/Gu+ELA
	qXOU+O0GFu+cH7zIYlEEbITlcDWwy2mpEbnbyYyg+HBLLiZYaDF+06vErZYtGmcinQR56LwpVK+
	+8VWJyoFBX2EwEzuOtCAktO5yK5LzQs9vjmkOFPBmXFNKOh8QkfKamISrBhc4ZadcUCcFRdtuPy
	xGoyP09ffqen0Z0gKvTW4NTvuB+h9cSTknOY6IRtxMGyo=
X-Gm-Gg: AYBFou3aJswZ2NQ0xi63k1wlH+e1McHYondZ39+G96Em9gqwq88r0uxqcDmL9Pa2Ydd
	s64eEjRfeImZ3uHTsfgF4N5KCIZlhc6h3csFNCh+9C9UhDuPtc4ukgvm9Wnvx8UN4lokxFbtcC3
	TrnlDGOu7is0PUjg7IbeYTh5k3O3gOcqt7bvdBNiS3u4DJasp8QWxZQ5Np6UuWQ5/+jgbubaZXX
	TuTn7nfjpneTd+NZHdWw5ej5f4G3h6CCowFMhQHEZhzwY37SlfYBfTcFsU=
X-Received: by 2002:a05:690c:e3c8:b0:8b0:a352:f99b with SMTP id 00721157ae682-8b0a352fd39mr45441677b3.5.1792057514223;
        Thu, 15 Oct 2026 02:45:14 -0700 (PDT)
X-Received: by 2002:a05:690c:e3c8:b0:8b0:a352:f99b with SMTP id
 00721157ae682-8b0a352fd39mr45441587b3.5.1792057513796; Thu, 15 Oct 2026
 02:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261015094049.107999-1-eperezma@redhat.com>
In-Reply-To: <20261015094049.107999-1-eperezma@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Oct 2026 11:44:37 +0200
X-Gm-Features: AclHuK-LzQXrraKcjrq2gn14rhkXoC0CRIcZZIDODKUQmzqbCXSFbFDTcemdS_k
Message-ID: <CAJaqyWeozDb=fgxNvcN7-ZYGBmAMZ1pABj=h_nv9T=4GAaSNGw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add missing virtio/vdpa/vduse/vhost headers
To: mst@redhat.com
Cc: Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Jason Wang <jasowangio@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UPIDbwBRHwuBtmZeV_c91m6-PlVD6w4ouNHHUyzGmEo_1792057514
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 11:40=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Several headers related to virtio, vDPA, VDUSE and vhost were not
> covered by any specific MAINTAINERS entry and fell through to the
> catch-all THE REST section:
>
> - include/linux/device-id/virtio.h: not matched by the existing
>   "include/linux/virtio*.h" glob, which only matches files directly
>   under include/linux/ and does not recurse into subdirectories.
>
> - include/uapi/linux/vdpa.h: the in-kernel include/linux/vdpa.h was
>   listed under VIRTIO CORE but its UAPI companion was missing; the
>   "include/uapi/linux/virtio_*.h" pattern does not match it because
>   the filename lacks the "virtio_" prefix.
>
> - include/uapi/linux/vduse.h: there is no dedicated VDUSE section in
>   MAINTAINERS; the driver lives under drivers/vdpa/ which is already
>   covered by VIRTIO CORE, so the UAPI header belongs there too.
>
> - include/uapi/linux/vhost_types.h: the VIRTIO HOST (VHOST) section
>   explicitly lists include/uapi/linux/vhost.h but omits its companion
>   types header.
>
> Assisted-by: claude-sonnet 4.6

I forgot:
Suggested-by: Michael S. Tsirkin <mst@redhat.com>

Also, in case it is useful, the model looked for all the potentially
missed files.

> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..9f85882f307e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28903,9 +28903,12 @@ F:     drivers/block/virtio_blk.c
>  F:     drivers/crypto/virtio/
>  F:     drivers/vdpa/
>  F:     drivers/virtio/
> +F:     include/linux/device-id/virtio.h
>  F:     include/linux/vdpa.h
>  F:     include/linux/virtio*.h
>  F:     include/linux/vringh.h
> +F:     include/uapi/linux/vdpa.h
> +F:     include/uapi/linux/vduse.h
>  F:     include/uapi/linux/virtio_*.h
>  F:     net/vmw_vsock/virtio*
>  F:     tools/virtio/
> @@ -28979,6 +28982,7 @@ F:      drivers/vhost/
>  F:     include/linux/sched/vhost_task.h
>  F:     include/linux/vhost_iotlb.h
>  F:     include/uapi/linux/vhost.h
> +F:     include/uapi/linux/vhost_types.h
>  F:     kernel/vhost_task.c
>
>  VIRTIO HOST (VHOST-SCSI)
> --
> 2.56.0
>

