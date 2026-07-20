Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D73B6362
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571117; cv=pass; b=RtLDKJYIqEbNaTnLzerWhBIojP3dM3t8apHh/85PmcVgcGYl3W4l0xkZAeKx1M+tURgELdK2Z84u/pzh0yfIDv39ZYlNz+1/JU9qKAxzJE90S4ReerbRE+Tpik74Z3M3/FEWGUjNfu75dXg1gFyNblvs+zF0TiRk94CPeULcISY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571117; c=relaxed/simple;
	bh=JAjXHOi+mA5sLbGUiviDveQxxklnyDZVQ4AeXIMFrHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKF1IIYkkM5w+uYocBEqV0wHiIxrotqRut5lPhqUrQdIS9onsFA0VhMRJ6UEueok0l9bVBBvMOmpFQD1llbMDLyIFjetdERI6YF21hrLWx2pEdysF/GwpdaDtEsn5q91BLei7pg1Yq9pPQ9ZjnEqHLP25XTPUvCKZu9T5bzy4V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGhWQtga; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGhWQtga"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso423965ad.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 11:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571116; cv=none;
        d=google.com; s=arc-20260327;
        b=D9VfKfMx4sBGcyc5B9yfjMaSLnxCRyGJQV+kqZdf6ERfUkhKKA98/ZHn18emkATvNN
         OvnIDGG4rGkcaIMfM7WSUnA/9jqEbKJwrhPT0SrUb4fcoQM2u8UtZPwdpm/Lo82fJf5e
         gxgV7FN4Q6klICewRgD+rsBb3KnEzjdCpix6bs/BRJ66fIPBYq5+A7uEoejp91FtItCJ
         5CLdH1uWeEqUmCs5ecKrIqSdWRGtZOHLEnkMXSWoEPUcF5GH7weXsgHWhwO3hxN5LPhP
         0fID0DezX17EAcm/Wu1kPHkPIupgzcMgcSddSB+7vf0586uOyZACb7B2kEqhM/lhee7f
         NbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1CKlYAx3ZqeDb0/tpWFTjgJVt3tNaV59m+Y0rInN34s=;
        fh=5eiXn5qkyOWtBbbJPQdbIfLhReACVLmoq8EmP1rvj7Q=;
        b=JCJ8Kr7y14X5+6dka3QRnDrnanQkeF+062RoMZjpWWEvZHgKF0DAY08qVCOtv5/F2N
         6FzoKrAtR2uxIsibXDenYsMaGiPcuvQ913bqhHY4PA/Z+gW+CnCbm7rBnl9T63iwkHAa
         hTmM05eaotavLCPdL5/aSCFPdl97v/5d4sKiihfjdVZsUdpb5Lh5POtn2GNeFtaouq6p
         SFyzpp+smzENyyF4yHMJEls5yNSDCZtdSdwHKsWrEpSv3u+IrZ6LvFSCMC1v7A4OuAC0
         1V6ppyuTjMnEoyf93ADPU37m/8cr5GMptA6kEAKg3d2NZl9zm75MN7gqrpz6f+UaxQ0W
         GDyg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784571116; x=1785175916; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1CKlYAx3ZqeDb0/tpWFTjgJVt3tNaV59m+Y0rInN34s=;
        b=MGhWQtgad4TsPit+xIIdsfS5FKr92YD78Btw192MaRBiRd3YRUaQr5xJWuKWuYYdXD
         bDqlBM4R6s5u6Sql4qijzUf2nctaXQ5DK6/qcOU+im58/c9fZf8akGRhq7N5QF2gpXj6
         bJSr1vIcczL0HPKxd1S7r0+Q59v8OKlOpquZ8bqD57MFywvxWgTj18VAlQM9EXflIBkt
         JqLlHaDGWGehEFZyMEoKyrWHrzY/T17Crs/0VoMK6rybjJsjv9l5VG4r5qIVlWL+BL4w
         HQ6Y4NqHlKH59w1lKUbuwKnx8O/IYJQzgIqaH+NU5evWifgPQ7SlOT2GZw0PuiGa9F+6
         TQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784571116; x=1785175916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CKlYAx3ZqeDb0/tpWFTjgJVt3tNaV59m+Y0rInN34s=;
        b=luJ7rRLBt7BzTIC1/roCWaM7lma9kYg0BYiGOJKLERSKpNZrFQ9AyecDEaojkRN1tJ
         xfFBF2g0FY2kPcnjfjo7mb6Def6zoXVIcbbUn08dhQJ9M5UPpddwty4SkIRsuRh5BSPz
         QYZdglJD3pppEBxVSRwqYr11Ka52AlEhcgzC2kLWgLAbNcBGgWkso3XoPZ4izp9mPCSU
         wXBsWs6nUFC0D0QmzPT7EtpNUqM59OH+m6pCyYdftv+JKAdUxLxczDDTiperGuVzjkCD
         6tm5pWrpMvkuNf/ohYm4G5zYcAsyNK5RxgQDKjxyfpxAEYM5NBhQsMSw1avP/SvK+Pwz
         SFlA==
X-Forwarded-Encrypted: i=1; AHgh+RqUqsVE3O+3/p5YGQZYr1Vlgaoha51Fx3nQuh6hCl9OFWCJtsMm+ydAFcWd6X8NRjkZ9DJRCqW/f7IqsbIjrA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5Qt2A20z8cvMA8J2/o9J6W+CsVAPBimG5RC51Ke+WodTT4G3Q
	+gsMw91mFwLMM9DYbx12loiah96YF1dAvSO7/wIVznQvocePlSttQ1GJbhaqX3Qa6DNiLSHgFa4
	FhVUwZWszzMvLHdv14ubivlYvsPYlatQE4PwTTf8=
X-Gm-Gg: AR+sD12lB/5WRqhUoosN8ZkDjXq5+VQ5dpSt9yYza8mTp3+CbSkzex2GzgPDPxRtlA5
	8emZsPdkyL9vlJq/hvpHcdeDL2Dhd4LU/eP9kt58asMn7DxX1Wv+Ytme9Jr6lU0FO99qdrvV98u
	7nuR46eOzVRXtoVRL/RKqQRMFq+IuA0g0rJqB3ODbqwIOQMZB4KDQY9ty2NwZm75Wocda7U6XER
	FcGT20LsTbGFGFRyR4R4D+HQll3o2g1sye0RwgjgSxGgG2yEkbo4Bz4PntK
X-Received: by 2002:a17:902:f54c:b0:2ce:7ae6:2a23 with SMTP id
 d9443c01a7336-2cf7b702c3dmr1769225ad.27.1784571115038; Mon, 20 Jul 2026
 11:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
 <20260712091036.5b0f170c@foz.lan> <CADSE00JkzGmN8Hvo1fuAsO1o9TKMrPwpmag-dtcFH1+NvkP6HA@mail.gmail.com>
In-Reply-To: <CADSE00JkzGmN8Hvo1fuAsO1o9TKMrPwpmag-dtcFH1+NvkP6HA@mail.gmail.com>
From: Brian Daniels <briandaniels@google.com>
Date: Mon, 20 Jul 2026 14:11:42 -0400
X-Gm-Features: AUfX_mxjKSfqJr5UYn-MifRznqumqpOeJGfSnFSM3EQHWuVZoKEjfxE2uw5OwrE
Message-ID: <CAD4i_GT7_K8LZea-Pk+LwpWSPiu6TO3WVi2ETxM-ET7f-ubQOg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] media: add virtio-media driver
To: Albert Esteve <aesteve@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, acourbot@google.com, 
	adelva@google.com, changyeon@google.com, daniel.almeida@collabora.com, 
	eperezma@redhat.com, gnurou@gmail.com, gurchetansingh@google.com, 
	hverkuil@xs4all.nl, jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 3:00=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Sun, Jul 12, 2026 at 9:10=E2=80=AFAM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > On Mon, 22 Jun 2026 16:43:35 -0400
> > Brian Daniels <briandaniels@google.com> wrote:
> >
> > > From: Alexandre Courbot <gnurou@gmail.com>
> > >
> > > Add the first version of the virtio-media driver.
> > >
> > > This driver acts roughly as a V4L2 relay between user-space and the
> > > virtio virtual device on the host, so it is relatively simple, yet
> > > unconventional. It doesn't use VB2 or other frameworks typically used=
 in
> > > a V4L2 driver, and most of its complexity resides in correctly and
> > > efficiently building the virtio descriptor chain to pass to the host,
> > > avoiding copies whenever possible. This is done by
> > > scatterlist_builder.[ch].
> > >
> > > This version supports MMAP buffers, while USERPTR buffers can also be
> > > enabled through a driver option. DMABUF support is still pending.
> >
> > In practice, USERPTR was used on several drivers that wanted to
> > share buffers between V4L2 and GPU (so, a previous approach before
> > DMABUF implementation).
> >
> > On my tests with this driver, I was unable use a 1080p camera with
> > V4L2 and GPU on crossvm. Lower resolutions worked. No idea if this
> > was a limitation of crossvm (I only used it to test this driver)
> > or if it is due to a poor MMAP implementation.
> >

I followed these instructions to test with crosvm on my wayland machine:
https://crosvm.dev/book/devices/wayland.html

Note that I built with `cargo build --features "gpu,media"`, not just
`cargo build --features "gpu"` to ensure virtio-media was enabled.

My crosvm command was as follows:

./crosvm/target/release/crosvm run \
  linux_upstream/arch/x86/boot/bzImage \
  --disable-sandbox \
  --block old-debian-12.img \
  -p "root=3D/dev/vda1" \
  --net tap-name=3Dcrosvm_tap \
  -m 8192 \
  -c num-cores=3D16 \
  -s /tmp/crosvm.sock \
  --v4l2-proxy=3D/dev/video0 \
  --gpu=3Dcontext-types=3Dcross-domain \
  --wayland-sock $XDG_RUNTIME_DIR/wayland-0 \
  --serial type=3Dstdout,hardware=3Dvirtio-console,console=3Dtrue,stdin=3Dt=
rue

The path to your kernel, block device image, and /dev/video* device
may be different
depending on your development setup.

In the guest, I launched qv4l2 with the following command:

sommelier --virtgpu-channel qv4l2 -platform wayland

I had to disable OpenGL rendering under the "Capture" menu (otherwise
the rendered
window just showed up as white) but other than that it rendered 1080p
smoothly using
the MJPEG format.

Here's a video showing 1080p working smoothly:

https://www.youtube.com/watch?v=3Daw03pM_-7oA

> >
> > > Compliance Testing
> > >
> > > This was tested using v4l2-compliance. Since virtio-media serves as
> > > a proxy to host devices for the guest VMs, we expect the guest
> > > compliance test to essentially match the host compliance test for the
> > > same device.
> > >
> > > NOTE: v4l2-compliance changes its test behavior depending on the driv=
er
> > > name. In the guest, the driver name for virtio-media proxied-devices =
is
> > > always "virtio-media", even if the actual host device has a driver na=
me
> > > of e.g. "uvcvideo". To ensure the test is consistent between the host
> > > and the guest, I created a patch for the v4l2-compliance tool that
> > > allows you to override the driver name. All test results that follow =
use
> > > this patch:
> > > https://lore.kernel.org/r/20260528163448.4031965-1-briandaniels@googl=
e.com/
> >
> > As mentioned before, please submit this with their rationale in
> > separate as a [PATCH v4l-utils] to linux-media ML.

Sounds good, let's continue the discussion on my existing [PATCH
v4l-utils] thread:
https://lore.kernel.org/all/20260528163448.4031965-1-briandaniels@google.co=
m/

> > >
> > > All tests used a Logitech USB Webcam C925e.
> >
> > Please test it displaying inside crossvm - or even better to QEMU if
> > you manage to add virtio-media support to it.
> >
> > Being at QEMU makes a lot easier for everyone to test it.
>
> Hi,
>
> Regarding the QEMU support mention, I created this series in QEMU to
> add the virtio-media PCI device:
> https://lore.kernel.org/all/20260630112310.552606-1-aesteve@redhat.com/
>
> Testing was done using an older driver version at
> https://github.com/chromeos/virtio-media/tree/main/driver as described
> in the cover letter. But I can try testing it with this series. Either
> way, the procedure for using QEMU is in the cover letter, so anyone
> can try it.

If you'd be able to test again with this series and post your results
that would be great, thanks Albert!

> BR,
> Albert.
>
> >
> >
> > Thanks,
> > Mauro
> >
>
