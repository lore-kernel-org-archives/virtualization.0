Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4041DCB2B
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730932214; cv=none; b=LfG6UOL1RaCtU5Gbctyz8Yo4eaL3ztysGw2M8/8BYeB8lZH2LOgQjsmsZFBWoVNk5PWuNlCiPEdqMmpGLVcpq0roduUENGqgQuRlouUfE2IrNlkIewfNhFxUkZSfkU30jgbWqHm3YWLSk6RvaYeCkq7OoPMePvp+33iRypfqLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730932214; c=relaxed/simple;
	bh=G1nKVTJ1PbKp53L74zvhCyWYtrGg9nYIlmRxKxuZp/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsKs/Whvn7MYQtcnYzo3Gyv44da1Wz8+bh4jvyBj628gjY/81Pu5ncMVTqrnhb6aoIjVt+e+/AzIMBurQ4didEW5vpWOLpaD51Fur/LN7BWNnhDmADOpbvF7NZ0JNkC7MNiIozlryHLpvIuSOHN3qwikZCwPtzplYtqWKv/TWKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d72GFRgu; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d72GFRgu"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61D6B405C0
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 22:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQvYXB7CYnWw for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Nov 2024 22:30:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C98A040249
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C98A040249
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d72GFRgu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C98A040249
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Nov 2024 22:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730932208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avBILjDkCtdXu28xvmbb+QgFtssv4StDj6rU4K8LWC0=;
	b=d72GFRgunFPPRWyo26HWf0bETMqkV//vFnGMAembE3R1PZmY5KZkIRiiXLW//7FIsFNBXD
	q3+Fe6QBBf/bqLDAOYFUEx4Xq8zfxwlYHl5NkMhiVeVfuD298pKflhxWQY0WBvjh6GYJDR
	3/4GPmT05lDep15YC0J1hycxYRyv5do=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-dI1elayWMZ-Nh5d4nHOxVg-1; Wed, 06 Nov 2024 17:30:05 -0500
X-MC-Unique: dI1elayWMZ-Nh5d4nHOxVg-1
X-Mimecast-MFC-AGG-ID: dI1elayWMZ-Nh5d4nHOxVg
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac0a1c419so7229139f.2
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Nov 2024 14:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730932205; x=1731537005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NKBJFGsUjRQk1GB5bl4dJj7QuShLoyvXNieDqLMkMY=;
        b=N1A/xAj7bxqB7jzAdGg0Sq2Nj2A22Cbdl2y8NUH58+M9CDT72RxMPze/Kk1s1k7Iyg
         Jl/hk5LFHGSz6pC8JzGOVDNz83BVP+IT3CW+xkKnJpEFjuXqoDHNGAwmfSPz+a2RL13U
         EtDAO0bYKUIbIGPUpBAcWe2EOJxaxHkOkIqh+4GSpCo+/HiXHSS1MT5YID5Y8JMvTteW
         R1L4MCHYzco6D/c2Mz2yKUqywc0DO9wL5dA673EIZkgV4PxOsZF/97T5P7VVP2hMTsak
         Wj5haskOMI0So6wOht5yHwZYenQs6M0rGlkWR/W7VKMovEYfll5pIKtDIrORNJedMrCF
         Imzw==
X-Forwarded-Encrypted: i=1; AJvYcCV4IbvXp1tc/LaI4zjgVaoeK20gWZ1qQUEszsyQ7UmJ1JcG4a1/1FnzLVlib549uso7z703asRRZ2+QTnWjaA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwnmOpXEvR6DxA+e6IcnkrDwVQxpq19luI+LmzCqqqlKJtzRxqN
	EcLw7jxRvESmMPhOX8e4++fP800KPJPoZkoCBqfs5SUJwNWbZVnm/Nw2OcGPekpxPgCM/tM7w42
	rh0naVNID/Bphz4ZSQxc7TpSHX7iqHLYC/t7qf915DbzmHqTlMVK0NyP5yBDtWcmRg8GF1pzPhl
	hLhn4=
X-Received: by 2002:a05:6e02:1a83:b0:3a2:57d2:3489 with SMTP id e9e14a558f8ab-3a6e84cad16mr3997475ab.3.1730932205014;
        Wed, 06 Nov 2024 14:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAI/Zl/vMrMnohgNpLsPUTqLN9PL2prn9a7pI4Vl9z0PshTb81NnGi+aEkQHdikGP4ZBpX9w==
X-Received: by 2002:a05:6e02:1a83:b0:3a2:57d2:3489 with SMTP id e9e14a558f8ab-3a6e84cad16mr3997395ab.3.1730932204529;
        Wed, 06 Nov 2024 14:30:04 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f82e828sm20015173.71.2024.11.06.14.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 14:30:04 -0800 (PST)
Date: Wed, 6 Nov 2024 15:30:03 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, jasowang@redhat.com, jgg@nvidia.com,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 parav@nvidia.com, feliu@nvidia.com, kevin.tian@intel.com,
 joao.m.martins@oracle.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1 vfio 0/7] Enhance the vfio-virtio driver to support
 live migration
Message-ID: <20241106153003.09c501bd.alex.williamson@redhat.com>
In-Reply-To: <20241106043151-mutt-send-email-mst@kernel.org>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241106043151-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ayx9tRzMlv1STSL5qnSYLoTqRlri82WhDnGarc6X238_1730932205
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 04:32:31 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 04, 2024 at 12:21:24PM +0200, Yishai Hadas wrote:
> > This series enhances the vfio-virtio driver to support live migration
> > for virtio-net Virtual Functions (VFs) that are migration-capable.
> > =20
> > This series follows the Virtio 1.4 specification to implement the
> > necessary device parts commands, enabling a device to participate in th=
e
> > live migration process.
> >=20
> > The key VFIO features implemented include: VFIO_MIGRATION_STOP_COPY,
> > VFIO_MIGRATION_P2P, VFIO_MIGRATION_PRE_COPY.
> > =20
> > The implementation integrates with the VFIO subsystem via vfio_pci_core
> > and incorporates Virtio-specific logic to handle the migration process.
> > =20
> > Migration functionality follows the definitions in uapi/vfio.h and uses
> > the Virtio VF-to-PF admin queue command channel for executing the devic=
e
> > parts related commands. =20
>=20
>=20
> virtio things here:
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Alex, your tree I presume? I hope the virtio changes do not
> cause conflicts.

Sure, I can ultimately take it through my tree once we have consensus.

Yishai, please add Michael's ack to 1-4 on the next round.  Thanks,

Alex

> > Patch Overview:
> > The first four patches focus on the Virtio layer and address the
> > following:
> > - Define the layout of the device parts commands required as part of th=
e
> >   migration process.
> > - Provide APIs to enable upper layers (e.g., VFIO, net) to execute the
> >   related device parts commands.
> > =20
> > The last three patches focus on the VFIO layer:
> > - Extend the vfio-virtio driver to support live migration for Virtio-ne=
t
> >   VFs.
> > - Move legacy I/O operations to a separate file, which is compiled only
> >   when VIRTIO_PCI_ADMIN_LEGACY is configured, ensuring that live
> >   migration depends solely on VIRTIO_PCI.
> > =20
> > Additional Notes:
> > - The kernel protocol between the source and target devices includes a
> >   header containing metadata such as record size, tag, and flags.
> >   The record size allows the target to read a complete image from the
> >   source before passing device part data. This follows the Virtio
> >   specification, which mandates that partial device parts are not
> >   supplied. The tag and flags serve as placeholders for future extensio=
ns
> >   to the kernel protocol between the source and target, ensuring backwa=
rd
> >   and forward compatibility.
> > =20
> > - Both the source and target comply with the Virtio specification by
> >   using a device part object with a unique ID during the migration
> >   process. As this resource is limited to a maximum of 255, its lifecyc=
le
> >   is confined to periods when live migration is active.
> >=20
> > - According to the Virtio specification, a device has only two states:
> >   RUNNING and STOPPED. Consequently, certain VFIO transitions (e.g.,
> >   RUNNING_P2P->STOP, STOP->RUNNING_P2P) are treated as no-ops. When
> >   transitioning to RUNNING_P2P, the device state is set to STOP and
> >   remains STOPPED until it transitions back from RUNNING_P2P->RUNNING, =
at
> >   which point it resumes its RUNNING state. During transition to STOP,
> >   the virtio device only stops initiating outgoing requests(e.g. DMA,
> >   MSIx, etc.) but still must accept incoming operations.
> >=20
> > - Furthermore, the Virtio specification does not support reading partia=
l
> >   or incremental device contexts. This means that during the PRE_COPY
> >   state, the vfio-virtio driver reads the full device state. This step =
is
> >   beneficial because it allows the device to send some "initial data"
> >   before moving to the STOP_COPY state, thus reducing downtime by
> >   preparing early and warming-up. As the device state can be changed an=
d
> >   the benefit is highest when the pre copy data closely matches the fin=
al
> >   data we read it in a rate limiter mode and reporting no data availabl=
e
> >   for some time interval after the previous call. With PRE_COPY enabled=
,
> >   we observed a downtime reduction of approximately 70-75% in various
> >   scenarios compared to when PRE_COPY was disabled, while keeping the
> >   total migration time nearly the same.
> >=20
> > - Support for dirty page tracking during migration will be provided via
> >   the IOMMUFD framework.
> > =20
> > - This series has been successfully tested on Virtio-net VF devices.
> >=20
> > Changes from V0:
> > https://lore.kernel.org/kvm/20241101102518.1bf2c6e6.alex.williamson@red=
hat.com/T/
> >=20
> > Vfio:
> > Patch #5:
> > - Enhance the commit log to provide a clearer explanation of P2P
> >   behavior over Virtio devices, as discussed on the mailing list.
> > Patch #6:
> > - Implement the rate limiter mechanism as part of the PRE_COPY state,
> >   following Alex=E2=80=99s suggestion.
> > - Update the commit log to include actual data demonstrating the impact=
 of
> >   PRE_COPY, as requested by Alex.
> > Patch #7:
> > - Update the default driver operations (i.e., vfio_device_ops) to use
> >   the live migration set, and expand it to include the legacy I/O
> >   operations if they are compiled and supported.
> >=20
> > Yishai
> >=20
> > Yishai Hadas (7):
> >   virtio_pci: Introduce device parts access commands
> >   virtio: Extend the admin command to include the result size
> >   virtio: Manage device and driver capabilities via the admin commands
> >   virtio-pci: Introduce APIs to execute device parts admin commands
> >   vfio/virtio: Add support for the basic live migration functionality
> >   vfio/virtio: Add PRE_COPY support for live migration
> >   vfio/virtio: Enable live migration once VIRTIO_PCI was configured
> >=20
> >  drivers/vfio/pci/virtio/Kconfig     |    4 +-
> >  drivers/vfio/pci/virtio/Makefile    |    3 +-
> >  drivers/vfio/pci/virtio/common.h    |  127 +++
> >  drivers/vfio/pci/virtio/legacy_io.c |  420 +++++++++
> >  drivers/vfio/pci/virtio/main.c      |  500 ++--------
> >  drivers/vfio/pci/virtio/migrate.c   | 1336 +++++++++++++++++++++++++++
> >  drivers/virtio/virtio_pci_common.h  |   19 +-
> >  drivers/virtio/virtio_pci_modern.c  |  457 ++++++++-
> >  include/linux/virtio.h              |    1 +
> >  include/linux/virtio_pci_admin.h    |   11 +
> >  include/uapi/linux/virtio_pci.h     |  131 +++
> >  11 files changed, 2594 insertions(+), 415 deletions(-)
> >  create mode 100644 drivers/vfio/pci/virtio/common.h
> >  create mode 100644 drivers/vfio/pci/virtio/legacy_io.c
> >  create mode 100644 drivers/vfio/pci/virtio/migrate.c
> >=20
> > --=20
> > 2.27.0 =20
>=20

