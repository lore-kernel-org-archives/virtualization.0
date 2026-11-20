Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190130;
	b=iMqQh++gufv9KFBHZlFapzeAIY8puD8BtLNvym3o2ppHeciYz9PdTLBBZ5OTr/98l5QI
	 0IQFoL/CmS+AYd7TYWA7g5ko94PbJ4Xx7vcIryPm3enkkr6dAKw2BpNy1mVxT5pzkPf9k
	 lnB3HaPAdckSn1yfUxIJ9WLDh96FIfk8s/HHxLQTRuY8FreIdGwmHTOxPH6UIvWZd3thr
	 xc7nQcTGLIXpaeMmRnna5s1aeC5eVPJFaHTfrcQFWbnL1xukyyKyF9i+odz+1vfb1JGhr
	 Tj8CPhpfNBAhwS314PwnABD947/ZuEP2ytog5+jYdx6t/gBhcUjECQT0VL/UanIP4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xEMvHS//qTQsphgkBnYKEtkOJ5QYJfSwsgGzKMsnpKQ=;
	b=zS5FVzTkRcygo3TBWstRlcKkR3o4tZHGwRdA0U7NLY65o5BxPDgQFTOp6ipQ8HWK8e5x
	 My33QHMKItXpocN4GnAtcr0Z1Wu49J0ehL0wVTaSoSxV6GhANNjzfloOlySxVg31V0EiV
	 EhlFk+7e2fFYX6pGYFnvbdNBDA5HSTTZJQz0XiVHCkMldV+zE549p4naW9K7ZfMU0CWtC
	 0lTQOG7jbOAipaMjkeO88QM/w534r3MVCJpm8mXD62Z9Oa3ZXPUHREuJcuGhnnyCJwaqH
	 i1U9CDrBHgA2mxztm9OVZw58ZaOjO77ndXIuYAMG57VEw5xezAelDwFHet9R30t5vqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOUYJkhN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4C606A331
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOUYJkhN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB32C1F000EC;
	Fri, 20 Nov 2026 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795190130;
	bh=xEMvHS//qTQsphgkBnYKEtkOJ5QYJfSwsgGzKMsnpKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOUYJkhNX8IIP0tx6biLFJ87BkZTdVQkrcpGuD/TnpRDtSbBmxVa81GrXFTpb+L+g
	 0lHgGVmtvmez9XdVyLrvCcOkAZYsjfzEroG1c0yeDC6kEpLs8QN+hiA0JhYuXi5bVN
	 Xowam+or2E+2QdRH89N2kJz//4Vp1ZUJQJEnTdv8UgK/s0R37jZ42H84OqsSXLDFiI
	 tIpyrPmcYCdo+pR0yJ717rVp3hlw4k2HhwpyKY9nmX7HzOigDwjSWBrdxThKSMeLVC
	 Rwot7SkM72XEpoWFIUSnBFkMy/Katzazzw2oYXgVej72s3r+cV0DIgnhL0F781Fq2u
	 URKalQ7OgClxw==
Message-ID: <sashiko-outbox-225480@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] vfio: Take the KVM reference only for drivers that
 read device->kvm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120154730.882393-2-andrey.drobyshev@virtuozzo.com>
References: <20261120154730.882393-1-andrey.drobyshev@virtuozzo.com>
 <20261120154730.882393-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:55:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A device takes a reference to the KVM file of its group or device file
> at the first open and drops it at the last close, so that device->kvm
> stays valid for the driver in between.
>=20
> QEMU's cpr-exec and cpr-transfer keep the device open while the VM is
> re-created.  The first VM then stays referenced for as long as the
> device is open: its file is not released, and its vcpus, mm and
> in-kernel PIT thread stay with it.
>=20
> To see it, start QEMU with a vfio-pci device, run cpr-exec and trace
> kvm_create_vm() and kvm_destroy_vm().  The old VM is not destroyed at
> the exec, and two VMs stay alive until QEMU exits.  Without the device
> the old VM is destroyed at the exec.  The new VM also logs
>=20
>   kvm: debugfs: duplicate directory <pid>-<fd>
>=20
> because it gets the pid and fd number of the old one.
>=20
> Only three drivers read device->kvm: KVMGT, vfio_ap and vfio-pci's
> zdev support.  vfio_ap reads it only in open_device(), zdev also at
> close, KVMGT also at close and while the guest runs.  Let them say so
> with needs_kvm_ref.  Without it device->kvm stays NULL and no reference
> is taken, so the device can't keep a VM alive.
>=20
> Fixes: 2b48f52f2bff ("vfio: fix deadlock between group lock and kvm lock")
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120154730.8823=
93-1-andrey.drobyshev@virtuozzo.com?part=3D1

