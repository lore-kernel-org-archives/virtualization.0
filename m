Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0EA1D9663
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885563; cv=none; b=d8qxWWe9/tYHxVjtr/Vpf4DYXl/pEipQ9T6pb7AsT+KM0LvFXAMrCfA4BErSoOgdkCNzP8pdEuaziZ93LcHWDA4NuJQ9sf79qgn/dCxGp6Azm2pw/nqbrx07zSQxf7Ot72cvBqryI12X7oHDr+LqrgFV/NKrUnHNKeOVQ2mjlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885563; c=relaxed/simple;
	bh=zLZtrbOm3tQO4cPR6OaXWHUBAUHtdy+WeL4yJVZKFZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uKazogPE1zA2TBx+kwwE97cZ3/q9CBxIw1Pnhhpsf6T//D/YRr8xRRQQJENN/xHxQlmTRw+tM/cQbvbpRR/g3v0CwJMwmf5x05aY9Yk4zJQQpLwTzCGCX7gYdKTV2ZeS8XSI1dNv7ELu86wTI6qQG94IU2/shj+eBX7eBnEAOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h88ZiNiH; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h88ZiNiH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B40E607DC
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 09:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tTg92_mT6dpW for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 09:32:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1248060612
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1248060612
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h88ZiNiH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1248060612
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730885558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YQCOzaaqSacr7sTCquGBzU/j66yk4mLPH1LOn1N3AI=;
	b=h88ZiNiHJYxu7sojYH4425RK4mfRUTQWa6EaiI7BFYkYk5H+b/N7prW9Cz2NxOdWDVhKfD
	6RJd8db2uT6OrTxbKVdMJq3helayhn+bcgueHJhaDi56rX/EqS4HKlYxw7sm3gJkMwgoIz
	NQ8KmGmP4R9drWXb1wZsCk/29LYF1i4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-gT4qjIuWMcefZjJ44Jyonw-1; Wed, 06 Nov 2024 04:32:37 -0500
X-MC-Unique: gT4qjIuWMcefZjJ44Jyonw-1
X-Mimecast-MFC-AGG-ID: gT4qjIuWMcefZjJ44Jyonw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d603515cfso3302588f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Nov 2024 01:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885556; x=1731490356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YQCOzaaqSacr7sTCquGBzU/j66yk4mLPH1LOn1N3AI=;
        b=reH+J26afWr14UWMioCdlbZFFJipHsDdU2RZePLrgYdi1u+i+XXgKO6kvV4KeXa/+/
         JYQSuX2cse1UTlT/VhdDD4z64L0vDfw43qmwcJVeT5HR1NTHDgI4bbg0EMPoC8nWC4N+
         upkZA4ofxIWOMOVkXerU5anTnKMydwTpR9+Dg3wwth4pEQ1I0JVpzuSYsoOG1xc1k4kM
         4/Y737VZ2T3xu0x51cP6QwJttqoCBoYQGw9fy7z7VgoeVkA+2IkOCXcITrFGRR4orKmk
         v1GbvVglpoQggPffzCxHtl5OralhdP9hrMufDmd7ZcSrz9D6dLmz3oKoN9OB7ZxfAsVS
         2W5g==
X-Forwarded-Encrypted: i=1; AJvYcCXXlR4klUjsYr8it3ChRYCiiCImF6WNxhTFRodLYvg1hd9jVFZ1G6o06ngnlk1+O+/j7hIdvMtlepUkMIUcLA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yy+82ycsv1XlV/Z35L7LNuWoWQWQNZG8fRP9/xjMFm8S5Fn5DNd
	dqbg8gp5mzzizyO8EEgx4u2qeAHfgiKbivDXBtumOPA2aulWopnMSX3XAKQmfz3c5CLtKvdBYJL
	abVE+p1usnFMOfxWduXpzPBjJNvB3DYTbQJUFZPH2lEO7+jnkf5yfQa4HUyjn9D/yJ8jH+vXHQ7
	dRIFg=
X-Received: by 2002:a5d:64c5:0:b0:37d:37b2:385d with SMTP id ffacd0b85a97d-381c7a47416mr16606930f8f.12.1730885556278;
        Wed, 06 Nov 2024 01:32:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi1IM4BOoEQNw8UW9f+P1oxQf6UCUsiEK4Wx2gCs9qwZs3LuTdRj7XQ0sMEcPYmbuf2blZGA==
X-Received: by 2002:a5d:64c5:0:b0:37d:37b2:385d with SMTP id ffacd0b85a97d-381c7a47416mr16606899f8f.12.1730885555823;
        Wed, 06 Nov 2024 01:32:35 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4983sm18419369f8f.33.2024.11.06.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:32:35 -0800 (PST)
Date: Wed, 6 Nov 2024 04:32:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: alex.williamson@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	parav@nvidia.com, feliu@nvidia.com, kevin.tian@intel.com,
	joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1 vfio 0/7] Enhance the vfio-virtio driver to support
 live migration
Message-ID: <20241106043151-mutt-send-email-mst@kernel.org>
References: <20241104102131.184193-1-yishaih@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241104102131.184193-1-yishaih@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L3REMagLRoQvvpKhHYi7PhaCJI7qFe8NgdbrUjuwFO0_1730885556
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 04, 2024 at 12:21:24PM +0200, Yishai Hadas wrote:
> This series enhances the vfio-virtio driver to support live migration
> for virtio-net Virtual Functions (VFs) that are migration-capable.
>  
> This series follows the Virtio 1.4 specification to implement the
> necessary device parts commands, enabling a device to participate in the
> live migration process.
> 
> The key VFIO features implemented include: VFIO_MIGRATION_STOP_COPY,
> VFIO_MIGRATION_P2P, VFIO_MIGRATION_PRE_COPY.
>  
> The implementation integrates with the VFIO subsystem via vfio_pci_core
> and incorporates Virtio-specific logic to handle the migration process.
>  
> Migration functionality follows the definitions in uapi/vfio.h and uses
> the Virtio VF-to-PF admin queue command channel for executing the device
> parts related commands.


virtio things here:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Alex, your tree I presume? I hope the virtio changes do not
cause conflicts.


> Patch Overview:
> The first four patches focus on the Virtio layer and address the
> following:
> - Define the layout of the device parts commands required as part of the
>   migration process.
> - Provide APIs to enable upper layers (e.g., VFIO, net) to execute the
>   related device parts commands.
>  
> The last three patches focus on the VFIO layer:
> - Extend the vfio-virtio driver to support live migration for Virtio-net
>   VFs.
> - Move legacy I/O operations to a separate file, which is compiled only
>   when VIRTIO_PCI_ADMIN_LEGACY is configured, ensuring that live
>   migration depends solely on VIRTIO_PCI.
>  
> Additional Notes:
> - The kernel protocol between the source and target devices includes a
>   header containing metadata such as record size, tag, and flags.
>   The record size allows the target to read a complete image from the
>   source before passing device part data. This follows the Virtio
>   specification, which mandates that partial device parts are not
>   supplied. The tag and flags serve as placeholders for future extensions
>   to the kernel protocol between the source and target, ensuring backward
>   and forward compatibility.
>  
> - Both the source and target comply with the Virtio specification by
>   using a device part object with a unique ID during the migration
>   process. As this resource is limited to a maximum of 255, its lifecycle
>   is confined to periods when live migration is active.
> 
> - According to the Virtio specification, a device has only two states:
>   RUNNING and STOPPED. Consequently, certain VFIO transitions (e.g.,
>   RUNNING_P2P->STOP, STOP->RUNNING_P2P) are treated as no-ops. When
>   transitioning to RUNNING_P2P, the device state is set to STOP and
>   remains STOPPED until it transitions back from RUNNING_P2P->RUNNING, at
>   which point it resumes its RUNNING state. During transition to STOP,
>   the virtio device only stops initiating outgoing requests(e.g. DMA,
>   MSIx, etc.) but still must accept incoming operations.
> 
> - Furthermore, the Virtio specification does not support reading partial
>   or incremental device contexts. This means that during the PRE_COPY
>   state, the vfio-virtio driver reads the full device state. This step is
>   beneficial because it allows the device to send some "initial data"
>   before moving to the STOP_COPY state, thus reducing downtime by
>   preparing early and warming-up. As the device state can be changed and
>   the benefit is highest when the pre copy data closely matches the final
>   data we read it in a rate limiter mode and reporting no data available
>   for some time interval after the previous call. With PRE_COPY enabled,
>   we observed a downtime reduction of approximately 70-75% in various
>   scenarios compared to when PRE_COPY was disabled, while keeping the
>   total migration time nearly the same.
> 
> - Support for dirty page tracking during migration will be provided via
>   the IOMMUFD framework.
>  
> - This series has been successfully tested on Virtio-net VF devices.
> 
> Changes from V0:
> https://lore.kernel.org/kvm/20241101102518.1bf2c6e6.alex.williamson@redhat.com/T/
> 
> Vfio:
> Patch #5:
> - Enhance the commit log to provide a clearer explanation of P2P
>   behavior over Virtio devices, as discussed on the mailing list.
> Patch #6:
> - Implement the rate limiter mechanism as part of the PRE_COPY state,
>   following Alex’s suggestion.
> - Update the commit log to include actual data demonstrating the impact of
>   PRE_COPY, as requested by Alex.
> Patch #7:
> - Update the default driver operations (i.e., vfio_device_ops) to use
>   the live migration set, and expand it to include the legacy I/O
>   operations if they are compiled and supported.
> 
> Yishai
> 
> Yishai Hadas (7):
>   virtio_pci: Introduce device parts access commands
>   virtio: Extend the admin command to include the result size
>   virtio: Manage device and driver capabilities via the admin commands
>   virtio-pci: Introduce APIs to execute device parts admin commands
>   vfio/virtio: Add support for the basic live migration functionality
>   vfio/virtio: Add PRE_COPY support for live migration
>   vfio/virtio: Enable live migration once VIRTIO_PCI was configured
> 
>  drivers/vfio/pci/virtio/Kconfig     |    4 +-
>  drivers/vfio/pci/virtio/Makefile    |    3 +-
>  drivers/vfio/pci/virtio/common.h    |  127 +++
>  drivers/vfio/pci/virtio/legacy_io.c |  420 +++++++++
>  drivers/vfio/pci/virtio/main.c      |  500 ++--------
>  drivers/vfio/pci/virtio/migrate.c   | 1336 +++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_common.h  |   19 +-
>  drivers/virtio/virtio_pci_modern.c  |  457 ++++++++-
>  include/linux/virtio.h              |    1 +
>  include/linux/virtio_pci_admin.h    |   11 +
>  include/uapi/linux/virtio_pci.h     |  131 +++
>  11 files changed, 2594 insertions(+), 415 deletions(-)
>  create mode 100644 drivers/vfio/pci/virtio/common.h
>  create mode 100644 drivers/vfio/pci/virtio/legacy_io.c
>  create mode 100644 drivers/vfio/pci/virtio/migrate.c
> 
> -- 
> 2.27.0

