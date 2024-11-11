Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D31ACDE7
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731360465; cv=none; b=sTpI+kH+k7WC+B2zEtcnmdgDIq/FWSFWeScylOISajgmrY2l2jImAP9DQ/+vqy1VK2Ud23aAtuhbOIm/5W1+ZjegUw7N3c6+nq0r/fzJWamirOhdofIxOe9RgbMO5hKu7n9f6LIP/KKdDDNDadXp8HoINe+kRsIK8vrPndSfrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731360465; c=relaxed/simple;
	bh=dCjvvpoZuKr3HG0YGTsN4kczVvH3tCg4BNEIObpZ/ao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDom7MuOaVTv/DKzJ6uQ6N9szGlZhpMnjjx8r2aifsdpOTdxAnodsUc8kt4yrb0OJnVBcO9JOVdbik4HP455S8takzrDAnDLI53KEhe3Kt3itwFcIr+N1Va+Hrj2qZ6dBRyWi6ceSH2ICAPjGvaqcA4cek5lO3D5b2miwNNbTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dz/uEl5K; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz/uEl5K"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B75AF80F8D
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 21:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BG6qmFieR7_H for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Nov 2024 21:27:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8F7D480F8B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F7D480F8B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dz/uEl5K
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F7D480F8B
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 21:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731360460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmzMVlrJTwqk/8otnxxCgCHDv0WIQfJvwgSEHSmLVsc=;
	b=dz/uEl5KQ1Zdu6QSI26dg1qmIFjjUrMeEdMTlhjrKr4btZUpkd53KVOi+f5fMDH3PGYseT
	nYqNfr64b0gUleZvZF39hHeDfmmE+/8Kjt5CVqkhyfYa2fk9DOhjMp4zBsYmSPWXjIgQEy
	UZX10OWJIaj62vhIolfAlLfhUo6lBik=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-C4GCc_StO7mm8x55LJjhyg-1; Mon, 11 Nov 2024 16:27:39 -0500
X-MC-Unique: C4GCc_StO7mm8x55LJjhyg-1
X-Mimecast-MFC-AGG-ID: C4GCc_StO7mm8x55LJjhyg
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aa8c7edb7so24027839f.3
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Nov 2024 13:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731360458; x=1731965258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKTzfUrxnVHXdTB3XXfquz3VdrDTYaHm0nfSYpXbJms=;
        b=UdjGhOXjbxajz2Mlfb/cbk3c5Nco+PonW3DNMoEvJG62PEHwXArrulLLLe74/Tnwm3
         KwMvrgu5c9BkIwmCHcEbhhshqYuMh9dzVqlgTl/eDN7eqe+L9xq6BbasSn2b9IDKgp9Z
         +dZ/jmGHQv/+ojrZdaxx8J60b43qS5Qg8ISi0/9w9GNkZQ0x+RQBH1as/b5WgtlC7/FG
         6RdmQ3qxsOruEeJvn8FXkJkht913fWR9JGP1fNz0tMA+QYdbOvQus9vrGqvMNLyONXg4
         u6G2bI693USfGo2OcL8MzCDMjIjSa5MoVrx4VVtnC1fr0zsLxe4Coe5o8AnAamdBdkRS
         g01g==
X-Forwarded-Encrypted: i=1; AJvYcCUdRE40caqpJuluDWiVg1Bm+/LsKVUzDXHiinc6kLgY8uW0eZQiLA5UxGMT4zMfl6LgCOt79IRzEo6yGckmRw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxowHmEqIbwW6kekySiXxvnIK6+YMUjFcG/iLo6vDAk7VGLVegA
	jWH/HZd5BW5ysa5kroMCRxWGTYR7i69p+0FWTAuXb6IVmwHqIgGXAvI7CIa7gqWhTJeRKopuGNl
	kqyF+rmutMXdYtV2q6mjHCS1DFT0a11xiTy35/RZCZWgLoFQNeI7esrD2uUy0XFERyuH/S0608+
	Fu3+4=
X-Received: by 2002:a05:6602:1355:b0:82a:249e:bdfd with SMTP id ca18e2360f4ac-83e0336c2d5mr389587639f.3.1731360458556;
        Mon, 11 Nov 2024 13:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX/Ggt58ehkyFsCDSKKtU9X8zNWVnKRm0joN8z3lTyNEVbcXKQvdETM55lD1avBOWaFa37pA==
X-Received: by 2002:a05:6602:1355:b0:82a:249e:bdfd with SMTP id ca18e2360f4ac-83e0336c2d5mr389586139f.3.1731360458143;
        Mon, 11 Nov 2024 13:27:38 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d6278sm1574968173.88.2024.11.11.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 13:27:37 -0800 (PST)
Date: Mon, 11 Nov 2024 14:27:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, parav@nvidia.com,
 feliu@nvidia.com, kevin.tian@intel.com, leonro@nvidia.com, maorg@nvidia.com
Subject: Re: [PATCH V1 vfio 7/7] vfio/virtio: Enable live migration once
 VIRTIO_PCI was configured
Message-ID: <20241111142736.18a625df.alex.williamson@redhat.com>
In-Reply-To: <112ebe08-06f3-4cb5-8cf0-8b49c56eac89@oracle.com>
References: <20241104102131.184193-1-yishaih@nvidia.com>
	<20241104102131.184193-8-yishaih@nvidia.com>
	<20241105162904.34b2114d.alex.williamson@redhat.com>
	<20241106135909.GO458827@nvidia.com>
	<20241106152732.16ac48d3.alex.williamson@redhat.com>
	<af8886fd-ec75-45fa-b627-2cd3c2ce905c@nvidia.com>
	<20241107142554.1c38f347.alex.williamson@redhat.com>
	<4ea48b12-03d0-40df-8c9c-96a78343f8c6@nvidia.com>
	<d2b83eef-4f39-4583-86d8-fc5bf83dd47a@oracle.com>
	<ba487f4f-b8d9-4e42-9aef-300a8ed3648a@nvidia.com>
	<112ebe08-06f3-4cb5-8cf0-8b49c56eac89@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T4v6bkXuV9PQUnfW3k5OhyjoZHD9WoqKMVbVPGJt19o_1731360459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 15:30:47 +0000
Joao Martins <joao.m.martins@oracle.com> wrote:

> On 11/11/2024 14:17, Yishai Hadas wrote:
> > On 11/11/2024 12:32, Joao Martins wrote: =20
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depend=
s on VIRTIO_PCI
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select=
 VFIO_PCI_CORE
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select=
 IOMMUFD_DRIVER =20
> >>>>
> >>>> IIUC, this is not a dependency, the device will just lack dirty page
> >>>> tracking with either the type1 backend or when using iommufd when th=
e
> >>>> IOMMU hardware doesn't have dirty page tracking, therefore all VM
> >>>> memory is perpetually dirty.=C2=A0 Do I have that right? =20
> >>>
> >>> IOMMUFD_DRIVER is selected to utilize the dirty tracking functionalit=
y of IOMMU.
> >>> Therefore, this is a select option rather than a dependency, similar =
to how the
> >>> pds and mlx5 VFIO drivers handle it in their Kconfig files.
> >>> =20
> >>
> >> Yishai, I think Alex is right here.
> >>
> >> 'select IOMMUFD_DRIVER' is more for VF dirty trackers where it uses th=
e same
> >> helpers as IOMMUFD does for dirty tracking. But it's definitely not si=
gnaling
> >> intent for 'IOMMU dirty tracking' but rather 'VF dirty tracking' =20
> >=20
> > I see, please see below.
> >  =20
> I should have said that in the context of VFIO drivers selecting it, not =
broadly
> across all drivers that select it.
>=20
> >>
> >> If you want to tie in to IOMMU dirty tracking you probably want to do:
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0'select IOMMUFD'
> >> =20
> >=20
> > Looking at the below Kconfig(s) for AMD/INTEL_IOMMU [1], we can see tha=
t if
> > IOMMUFD is set IOMMFD_DRIVER is selected.
> >  =20
> Correct.
>=20
> > From that we can assume that to have 'IOMMU dirty tracking' the IOMMFD_=
DRIVER is
> > finally needed/selected, right ?
> >  =20
>=20
> Right, if you have CONFIG_IOMMUFD then the IOMMU will in the end auto-sel=
ect
> IOMMU_DRIVER. But standalone at best you can assume that 'something does =
dirty
> tracking'. The context (i.e. who selects it) is what tells you if it's VF=
 or IOMMU.
>=20
> In your example above, that option is meant to be selected by *a* dirty t=
racker,
> and it's because AMD/Intel was selecting that you would have IOMMU dirty
> tracking. The option essentially selects IOVA bitmaps helpers (zerocopy s=
cheme
> to set bits in a bitmap) which is both used by VF dirty trackers and IOMM=
U dirty
> trackers. Originally this started in VFIO and later got moved into IOMMUF=
D which
> is why we have this kconfig to allow independent use.

Yeah, I agree.  IOMMUFD_DRIVER is only configuring in iova_bitmap
support independent of IOMMUFD, which mlx5 requires, but this does not.

> > So you are saying that it's redundant in the vfio/virtio driver as it w=
ill be
> > selected down the road once needed ?
> >  =20
> Right.
>=20
> Of course, it will always depend on user enabling the right kconfigs and =
such.
> But that would be no different than the other drivers than don't support =
VF
> dirty tracking.
>=20
> > [1]
> > https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/iommu/intel/K=
config#L17
> > https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/iommu/amd/Kco=
nfig#L16
> >  =20
> >> But that is a big hammer, as you also need the VFIO_DEVICE_CDEV kconfi=
g selected
> >> as well and probably more. =20
> >=20
> > I agree, we didn't plan to add those dependencies.
> >  =20
> >>
> >> Perhaps best to do like qat/hisilicon drivers and letting the user opt=
ionally
> >> pick it. Migration is anyways disabled when using type1 (unless you fo=
rce it,
> >> and it then it does the perpectual dirty trick). =20

Yes, at least for QEMU, unless the user forces the device to support
migration we'll add a migration blocker rather than use the perpetually
dirty trick.  Ultimately the support depends on the underlying IOMMU
capabilities where we're running anyway, so it makes sense to me to
leave this to the user rather than trying to force a kernel config that
can support IOMMU dirty page tracking.  Thanks,

Alex

