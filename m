Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A003033EC
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118733; cv=none; b=uXJt2O7f3EfqnvL1XVUhDlL77OUBF5jSV79MyYXIBxrrWNq/9DsNT1brplU8vPcUNv7RDAF2jyTH86ShxfVCh1GsNGV7Lp6tGVMqlSDEhRn5mnLEAmBhIu5KfxzK9JfRPaTPC0DlKbryILMsDQ4oWMKvM3xi2An2BpZant1cZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118733; c=relaxed/simple;
	bh=TQiRn6Ud79vAlC6vPCWceV836d64lyGk6PcfS7ybMWY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NQZl92T1Yg2iYGdPeyhWsdtv5qbI5/hUFO2uue0vW5TPimZFz6Kv4hUKZljSc9Z3KX2f01grkm3xnbY9K4JYqEVCBm6W5Ai+UWsHLNx4cvmhpxXPEoIuUPVsOvmCoNXwDgQASwIp2y7aSFUhCWw0iRqVJDe9+N4y44iFTz+txgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcJk4p/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcJk4p/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CEB1F000C4;
	Fri, 16 Oct 2026 02:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118731;
	bh=18VoGvoj0FD5jz/k5jdnASUV9uFLwiSIEtJRZKXlwB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UcJk4p/K7t58ez2eTL7TjNTPClROBjJrVPDDNM66RI1b6BpKurbY+v129Ol4q6xH/
	 pKMiviHUgrDpJIuuazKmxwtu6WAoBXPrZyRcwKfiRHyIguzxPssuP6k6JRWxXl2KiQ
	 H4vaJkiag+ejKIRBALIsfXhOmHskPjhmOmz/SklF/0UoXKrvMGGW86SUcKhOVY9G+d
	 LTJ+Jsi9zoB/9yzCdIh50DeeivjUPTlU26aytLIF0ddYPxqnO1oTajWBRKhqJc4ju+
	 b1lFH0+llGvYIEsbOCUV1QL3uHG6iKXmcUrd2Ar25o7j/f3w6TBJAEEjMOtBn/rSLN
	 FwGMd9IuiGrIQ==
Message-ID: <sashiko-outbox-173638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] virtio-mem: only mark the device ready in kdump mode
 with vmcore support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016023521.747447-1-oss.patchbox@gmail.com>
References: <20261016023521.747447-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 02:45:31 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> virtio_mem_init_kdump() marks the device DRIVER_OK before it checks for
> CONFIG_PROC_VMCORE.  Without vmcore support it then fails with -EBUSY,
> and virtio_mem_probe() deletes the virtqueue on that error path without
> resetting the device first, so the device is left believing the driver
> is ready while its queue points at memory that has been freed.
>=20
> Before commit a9403425b3cf ("virtio-mem: mark device ready before
> registering callbacks in kdump mode"), virtio_mem_probe() called
> virtio_device_ready() only after virtio_mem_init() had succeeded, so this
> path never exposed a ready device.
>=20
> Move virtio_device_ready() into the CONFIG_PROC_VMCORE branch, right
> before the vmcore callbacks that need it are registered, so the -EBUSY
> path never sets DRIVER_OK.
>=20
> Fixes: a9403425b3cf ("virtio-mem: mark device ready before registering ca=
llbacks in kdump mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016023521.7474=
47-1-oss.patchbox@gmail.com?part=3D1

