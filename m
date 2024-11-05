Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904A1D415B
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730849351; cv=none; b=iFt02K7fDKLpQemgTdvwb6hBRPF7nhQFDkq7GSuAYg9jdq0vhxr0bbn0V6w0Q4ggGDmU+Tq0xVYA2lAHnuqVfne6vjCvTbrtRLMmDNAQmc/rFcDgyYkE8xY7nQhAZ7WF5JnWDCmC5Jcw458x5bJr2c09p3WONtwJS3Ky3bdW4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730849351; c=relaxed/simple;
	bh=c+O1aCV2hHScg23TJ/rGo6MfIEAdK07rMuZqdGFa4ac=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfVBzZhfF8i6nDr6y02alZ3AlW1AMjIcM7JjtFzHRQ6qSG4niBIDKaAXmW1F+sRBMUYpynvLnnqNv2/yRHJk0BVcYN/N4kjK37W33/JfwzQBNr39U7rOY1qW4chqKZ9B82gqwI26z5aeEySsSwDIpolJa3uT5AX40e1zyMxcFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBA6az7X; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBA6az7X"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 493DB60884
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 23:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7EFEirbv7tvp for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 23:29:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 72999606AF
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72999606AF
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QBA6az7X
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72999606AF
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 23:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730849348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NZ0zx9SE1uKHc2bVZ86v1ZGK5me+n6DQA6Bc2mp/i0=;
	b=QBA6az7Xb1Lxi34egKAw3+Zj4XsQnfzR6e9lgvHoX6OGjAvhMyuyxpGIzZVbH0Zg2K5WfC
	NRzAUKLU1i8Xwsn4vH0bwnadMkgqtO619ZqYpVgFtyl7LmO+enn3AhwNDnX3GekCwLzXvc
	l/Q2sIBMZmKBD2BoKUjMYy5NdaiVXkE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-YZQ-gKwXOnKU7XT9z7QJBA-1; Tue, 05 Nov 2024 18:29:06 -0500
X-MC-Unique: YZQ-gKwXOnKU7XT9z7QJBA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6cabd39e9so5972645ab.0
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 15:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730849346; x=1731454146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NZ0zx9SE1uKHc2bVZ86v1ZGK5me+n6DQA6Bc2mp/i0=;
        b=cz8Byev56ssxXNNbZCTLb7c3elL9ayDQsp/WON/tkFLrIPlvDgkbcGcOUZYD87/Up7
         uLWaLNlAkwRRzb7HGEyqSKu2N0SaNUT1jv5ZZ+XNz35oF5qNh0mDsPQR9bch1XbiEcdG
         sTS1EZunJZiJTjF8Gz8t3dLZegKfZyaJBUPDYd24WzCtjput+h+VEsCfE9xcpPt2ST4j
         buqFItw+BqvU03pVc03N7PJoTiguerlGNe+TkdP++uCrzkXaqSXwTlbav08kDt9NbkzN
         /pSmE5Efl9m9ZcZ06MZFpUND1A3AtPyjFCmXK+D8C6jDR5o9Bb4PB7sINAx4YB9oEUyX
         NjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT+PcGUIkCSbw0rDA0pZCGR157qH6avpXrJEsJU74wDa6uEfnNXeDLQ8Lc4dkBJ/NAyKykx63BydPcjpj6FQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy5pDlpf79SSQYDGzdwy1Pyb120L6Nq5KqBWZEBQykpza3kEGGs
	jbEI7idBnreXWt3B9H+PMHmgg322R53Drehtxnwro9Ll3VzBDrc1NTlcKqE9yrcJuEbDthwNoKo
	a0Fh87LSWXVedoPMU9U1Jufys9UsVBy5abGeYl7OMG8SRi9XBL2wS6pu37IxO3XFI31eJwYxZQZ
	S8Djs=
X-Received: by 2002:a05:6e02:1385:b0:3a6:c048:4194 with SMTP id e9e14a558f8ab-3a6c04842aemr32218315ab.1.1730849346014;
        Tue, 05 Nov 2024 15:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3/LzSIQREr27YcRyo458y8lltHd7KixOnzZv+XiAf1/o6pv7/b6gDajkbSPHSdFza38BG9A==
X-Received: by 2002:a05:6e02:1385:b0:3a6:c048:4194 with SMTP id e9e14a558f8ab-3a6c04842aemr32218095ab.1.1730849345459;
        Tue, 05 Nov 2024 15:29:05 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de049a45b8sm2608291173.132.2024.11.05.15.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 15:29:05 -0800 (PST)
Date: Tue, 5 Nov 2024 16:29:04 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
 <parav@nvidia.com>, <feliu@nvidia.com>, <kevin.tian@intel.com>,
 <joao.m.martins@oracle.com>, <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V1 vfio 7/7] vfio/virtio: Enable live migration once
 VIRTIO_PCI was configured
Message-ID: <20241105162904.34b2114d.alex.williamson@redhat.com>
In-Reply-To: <20241104102131.184193-8-yishaih@nvidia.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-8-yishaih@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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

On Mon, 4 Nov 2024 12:21:31 +0200
Yishai Hadas <yishaih@nvidia.com> wrote:

> Now that the driver supports live migration, only the legacy IO
> functionality depends on config VIRTIO_PCI_ADMIN_LEGACY.
> 
> Move the legacy IO into a separate file to be compiled only once
> VIRTIO_PCI_ADMIN_LEGACY was configured and let the live migration
> depends only on VIRTIO_PCI.
> 
> As part of this, modify the default driver operations (i.e.,
> vfio_device_ops) to use the live migration set, and extend it to include
> legacy I/O operations if they are compiled and supported.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> ---
>  drivers/vfio/pci/virtio/Kconfig     |   4 +-
>  drivers/vfio/pci/virtio/Makefile    |   1 +
>  drivers/vfio/pci/virtio/common.h    |  19 ++
>  drivers/vfio/pci/virtio/legacy_io.c | 420 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/virtio/main.c      | 416 ++-------------------------
>  5 files changed, 469 insertions(+), 391 deletions(-)
>  create mode 100644 drivers/vfio/pci/virtio/legacy_io.c
> 
> diff --git a/drivers/vfio/pci/virtio/Kconfig b/drivers/vfio/pci/virtio/Kconfig
> index bd80eca4a196..af1dd9e84a5c 100644
> --- a/drivers/vfio/pci/virtio/Kconfig
> +++ b/drivers/vfio/pci/virtio/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIRTIO_VFIO_PCI
>          tristate "VFIO support for VIRTIO NET PCI devices"
> -        depends on VIRTIO_PCI && VIRTIO_PCI_ADMIN_LEGACY
> +        depends on VIRTIO_PCI
>          select VFIO_PCI_CORE
>          help
>            This provides support for exposing VIRTIO NET VF devices which support
> @@ -11,5 +11,7 @@ config VIRTIO_VFIO_PCI
>            As of that this driver emulates I/O BAR in software to let a VF be
>            seen as a transitional device by its users and let it work with
>            a legacy driver.
> +          In addition, it provides migration support for VIRTIO NET VF devices
> +          using the VFIO framework.

The first half of this now describes something that may or may not be
enabled by this config option and the additional help text for
migration is vague enough relative to PF requirements to get user
reports that the driver doesn't work as intended.

For the former, maybe we still want a separate config item that's
optionally enabled if VIRTIO_VFIO_PCI && VFIO_PCI_ADMIN_LEGACY.

Thanks,
Alex

