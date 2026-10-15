Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E8B315D49
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071036; cv=none; b=eBCobGLyUA7WaOUfVe8aPkeMk+uutgStJffpws4rrXCZO0q36wXl8YRuFW34Cbd3mMeB3g5JjbOYC0om5HCbLPrqSs1EIbnU5CSxJIo5KUK6aw+9T9s0cfZUvYH1Zm2MnfGDWEgwu6r+n1YaJaGgLY5/swBvOnmM5tUiqqYYqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071036; c=relaxed/simple;
	bh=cwW617JewnF8m+D1Vc8i8JYYQvrKn3pSl1v+w1CVZhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jGAU9MFBpR5aHVR+zfVwT36+HN1QWsi65NUZP7+zoqs5yLLF3UH8ibCDla5de/2YYpGvi4DaHD8DaKEP2GGJoJ5rc+d74ZlXvDnmoX+oDDMQz2mAJq+1XFXm7gruXxz4IuR8hPPtDNBQqZBORfTD3WWiUp1+X3iOl7dBgFJ67a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlNitezl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlNitezl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792071032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoo2tu2S9XmQrr+C0lJWQJpw+2qkSB2NHh3Sjnut3aY=;
	b=QlNitezl5pAtgfIHKboPjGqZ6liKlqvzl4IA9OUlM3LSj9epvjz7+SfxUwnbiMp3TQjvHI
	KIXO6mzHi1iVIQ2eknz8WXvDa2D+I+F/PvU+gK+pYhRZLPdKaa6Zp2ekw6VhAWPHvEvS77
	Rg9V7CasTmgkgjt/QByompjv7LDvc/k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-jZhKT_TkPcymFKzakdTIBw-1; Thu, 15 Oct 2026 13:30:30 +0000
X-MC-Unique: jZhKT_TkPcymFKzakdTIBw-1
X-Mimecast-MFC-AGG-ID: jZhKT_TkPcymFKzakdTIBw_1792071029
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4887e5afd67so4058212f8f.3
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 06:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792071029; x=1792675829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uoo2tu2S9XmQrr+C0lJWQJpw+2qkSB2NHh3Sjnut3aY=;
        b=1vcu7unpo/n3wFwDJkKL32jfEzUsuf9ouz5b+SccRjzcwwlQpDrVd41jkOBa96wNbN
         mB7vKTYRXpJgUN7hg41FdhTuyr0POs29qmL5lIQzKFW89clRWhAfwbPqKW9c2CX9ZIp2
         tnnOLprFfAaL6ALJ9pLs/YNwplHRDIIXbjoMgRZtlV9b+9qL99w8tmOC5OjaxGrkDlzv
         j5NI8Zy/dSLy+aW3ZO/S9dp1nqYcu6FRQXTzY0XCCQknEKH5VlUZGAA0mH+0vj2Ap0/X
         VhVUaljM2gCDKtRrQlvAySXvcRAR6baldvNsZioWbjGF/o/MJMWzSvAas9LPLXVIYh9D
         tcMQ==
X-Forwarded-Encrypted: i=1; AKwUvBynnCf/ECJnHxRg/zB7RfbVO9GkA3GX3SQbwdaxLtB4Psq1Q7IIonkP53D8NYZhf6w2LeX4H/Uvi0omFPcyCQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLEqGqNaXfjbtLQYWLVc3HjuQ4khPtzXW+3dUz6Ki1VcjwLOkDw
	hj8P+m/3CcJryIEKm9NgqPyJwONXgQSWYHez6sFa8cGHvu21T2Iz/0ikZuKK4MpuvCcBhxqT/qk
	A6s3vjQlidK8905amq70FtewPUhbOYl8mbvxI543ylEJMGFKbkNfQpjspsOg/1aY56MXw
X-Gm-Gg: AYBFou0XQHqTjS4Js/vlt3uy3NMZQbN2sGYG6mzREv4Jl/j83/T8o9a4qBpCLK9ewEf
	RkY315Drunclp7fzXFI9x071AS9eqoOvGGqw60jpDOGfRgNixDT2nKQaHRatxqIGvyGuvvRouws
	Tp+jhqPBiQMBFG3buU2Ekk0zqFrYREP+NAntS8+S/b9n5E8OkFUx5XD90brbQ5OuW3NOUo3XQzf
	X1kP30Vn9ETnqpAt6oocIdf2SVx7GcLnf3RIRcvX8rkeb20SybGGIl+lQcK1MhjaA/9fONWEk9B
	irKUnO9IXendDkxBzM6PiZ58cWIsvVnFYaV9hL4mYJFKrDJjF45aa63F5+M0CjwgxT4TAf4WBci
	YXRJQRg==
X-Received: by 2002:a05:6000:984:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48dc29e4118mr32903762f8f.33.1792071028978;
        Thu, 15 Oct 2026 06:30:28 -0700 (PDT)
X-Received: by 2002:a05:6000:984:b0:48d:c29e:40c3 with SMTP id ffacd0b85a97d-48dc29e4118mr32903697f8f.33.1792071028315;
        Thu, 15 Oct 2026 06:30:28 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaa9f9sm18997598f8f.19.2026.10.15.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:30:26 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:30:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add missing virtio/vdpa/vduse/vhost headers
Message-ID: <atDSrbtSsWL_3JDp@sgarzare-redhat>
References: <20261015094049.107999-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261015094049.107999-1-eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b_az0AiAVe6J7tAckUCSsHP37JE0yLsyKZam1LYpQIY_1792071029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 15, 2026 at 11:40:49AM +0200, Eugenio Pérez wrote:
>Several headers related to virtio, vDPA, VDUSE and vhost were not
>covered by any specific MAINTAINERS entry and fell through to the
>catch-all THE REST section:
>
>- include/linux/device-id/virtio.h: not matched by the existing
>  "include/linux/virtio*.h" glob, which only matches files directly
>  under include/linux/ and does not recurse into subdirectories.
>
>- include/uapi/linux/vdpa.h: the in-kernel include/linux/vdpa.h was
>  listed under VIRTIO CORE but its UAPI companion was missing; the
>  "include/uapi/linux/virtio_*.h" pattern does not match it because
>  the filename lacks the "virtio_" prefix.
>

Maybe we should tell to the agent to avoid useless info in the commit 
message, I mean it's pretty clear that "include/uapi/linux/virtio_*.h" 
will not match include/uapi/linux/vdpa.h ...

>- include/uapi/linux/vduse.h: there is no dedicated VDUSE section in
>  MAINTAINERS; the driver lives under drivers/vdpa/ which is already
>  covered by VIRTIO CORE, so the UAPI header belongs there too.
>
>- include/uapi/linux/vhost_types.h: the VIRTIO HOST (VHOST) section
>  explicitly lists include/uapi/linux/vhost.h but omits its companion
>  types header.
>
>Assisted-by: claude-sonnet 4.6

nit: the suggested tag in Documentation/process/coding-assistants.rst is
Assisted-by: LLM [TOOL1] [TOOL2]

>Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>---
> MAINTAINERS | 4 ++++
> 1 file changed, 4 insertions(+)

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


Maybe to be fixed in another patch, LLM here found also others files 
related to virtio/vhost/vdpa uncovered:

Other virtio-related files not covered by any virtio/vhost/vdpa
MAINTAINERS entry:

- Documentation/ABI/testing/sysfs-fs-virtiofs
   Current:   no section (THE REST only)
   Suggested: VIRTIO FILE SYSTEM

- Documentation/userspace-api/vduse.rst
   Current:   DOCUMENTATION only
   Suggested: VIRTIO CORE (already lists sysfs-class-vduse)

- include/trace/events/vsock_virtio_transport_common.h
   Current:   TRACING only
   Suggested: VIRTIO AND VHOST VSOCK DRIVER
              (next to virtio_transport_common.c)

- drivers/nvdimm/virtio_pmem.h
   Current:   LIBNVDIMM only
   Suggested: VIRTIO PMEM DRIVER (lists virtio_pmem.c and
              nd_virtio.c, but not the header)

- Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
   Current:   GPIO + DT bindings
   Suggested: VIRTIO GPIO DRIVER

- Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
   Current:   I2C + DT bindings
   Suggested: VIRTIO I2C DRIVER

- Documentation/networking/device_drivers/ethernet/amd/pds_vdpa.rst
   Current:   NETWORKING + DOCUMENTATION
   Suggested: PDS DSC VIRTIO DATA PATH ACCELERATOR
              (only lists drivers/vdpa/pds/)

- include/linux/mlx5/mlx5_ifc_vdpa.h
   Current:   MLX5 core/IB only
   Suggested: possibly MELLANOX MLX5 VDPA DRIVER (debatable, it's an
              mlx5 interface header)


I'll send a fix for the vsock events.

Thanks,
Stefano

