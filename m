Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345122A1D5
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789620; cv=none; b=RjKgy7tQ8siSWuV5WJVrYML1OXxNZ1f2+nA3s397Y+odYmG0eVE50rjHuPtp3RLNH5QX2VvPFof9TdfOF1MOiD/ZaEeoPXj6N+nWAPoNDQDUlCrYgYFV7RQtT1hTv2Q2GcdsZ55lltXQmAFb+m5hAABlSF9V0pZ1yZLGOUOoPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789620; c=relaxed/simple;
	bh=Woiis248jlZyFcV6c0KJ2XRceoaJiE3r8gMR3OmXAq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSb2dSet82BAQgpcKWI1IdwIG+stcI8FQWUGowt30Dn55STudsaKclnOITK3lKfCTFphenGVDGtTSzL1FZYOMItB3lZYuyNQC9/993g3+1+yslpfGiKz+TYavR65pGJU3mi2+W4oaASpw9HN/FJzR4MIZrlyVrK9EurWGnZ2GEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlBnJ4A8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlBnJ4A8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744789617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uuzpXIRkdIf9HgwyCsnLAQ1Zty68iXHOJ7gPJ3rwGI=;
	b=GlBnJ4A82S2FEJ+0jM23oiVDR9vJvrPTaapV2htlUObIhbPTRXyo4wbEFBFsWUBU9rcbWh
	bwSOWFJaUe0HEGPpiAXiGthuY7J5KuKyG50x0SktoBz/R/qZi/pypa0fQPHtqaArpzNZ14
	6I86jF9NUk1XhSyyZS5FHnMbfVpmRgo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-FW6jmniaPzqz-Yimd7DTYw-1; Wed, 16 Apr 2025 03:46:55 -0400
X-MC-Unique: FW6jmniaPzqz-Yimd7DTYw-1
X-Mimecast-MFC-AGG-ID: FW6jmniaPzqz-Yimd7DTYw_1744789615
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2254bdd4982so85812995ad.1
        for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 00:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744789615; x=1745394415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uuzpXIRkdIf9HgwyCsnLAQ1Zty68iXHOJ7gPJ3rwGI=;
        b=XXd0BLnUGILjEtRDvgtML9+v2hziJYhKqTO6Kq61oj+1lTL+JS7YjMpq6KTxMs4pJi
         sZNTvLOzcfnBnt8uEtd6WXyXlcqiuS2ljVx8GZzIe9rSjYJWnysRvxXdofD/F/XOLWyW
         /klD5s7sP4el4ViGq38K1Nah2NIgaCk0G22HGzjfCPDek6YPLXIGc64s4O8MA4O/DmRC
         XBN+L7r2ode0ivphMRz8QF9/ehNISgNI7cMfvdcF+625LNrjwEphILdj1bxw8cyetJ6t
         Q0QRh3SWmz25yvjpjYfAlxy6QSPxS7v+S1qVYXN165k85c95W0XVNNHn1vOu94qOqYpy
         rffg==
X-Forwarded-Encrypted: i=1; AJvYcCWrVv+1POwHuSYMWelUNJe3CrejNdK2W4//nc+zBXubnfxdRSEoW+kTgM6OmUswO6uOTcS+501K5P83rkSnJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOAcXZXs2ERPL0wdjwqXQp7yMRuf9Vwz8E29yXyazI8Dkr5/DG
	K5anRefpo+Oqw9kK1NP+g3Bv71jGB+7My8q8qLSOmXoD8dYTQmBs8EFH4Fcmc7tpe62cjqkFA9d
	fnEwIvXP08fuzw6P5EfT8+vZ05bgjrdg7av9SgoN9GCx5rf95YDeghZ5m2R6dq3lvfBeCJGi3fJ
	eOEIxjHBUGHtFM2H8hHnS9lJXtVnG19MFuQTDSJNM=
X-Gm-Gg: ASbGncv1+EzUD2U1Lf1lCaphlylZ69Wwj03efy8CWXLF2RWyFPGrq/aTHuEmKiOTMhF
	/2dBgYjjG7dyoB6Xva1brmK+V33uH4wmZiQ9RszuVWuPnc787GDWv4/mgkBi+FstbRY9b
X-Received: by 2002:a17:903:32c9:b0:21f:52e:939e with SMTP id d9443c01a7336-22c35912212mr15797745ad.28.1744789614845;
        Wed, 16 Apr 2025 00:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErjgPg3L39vqGFFK6Rdj2WvOpVA1dDcQP124r0ZOZ4IRpEvlOKOgz7Fujmr5sSexyffpGWZnI6AM2k2Ni2zcE=
X-Received: by 2002:a17:903:32c9:b0:21f:52e:939e with SMTP id
 d9443c01a7336-22c35912212mr15797285ad.28.1744789614412; Wed, 16 Apr 2025
 00:46:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-4-minhquangbui99@gmail.com> <20250415212709.39eafdb5@kernel.org>
 <1603c373-024d-4ec2-b655-b9e7fb942bba@gmail.com>
In-Reply-To: <1603c373-024d-4ec2-b655-b9e7fb942bba@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Apr 2025 15:46:42 +0800
X-Gm-Features: ATxdqUHhk7SJXf3iQ5yHeMNHj2FuWUp_PAPo48ZoR1bRo43UlB38GKCpvPtEiUA
Message-ID: <CACGkMEvceXT+=HJRRe6D3Zk3k40E2ADJiXNb4qqAYm=PZnxNpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock selftest
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jANdA0JTgXo8YGQdaV62hZ2zx9sC2uN0A137C9ER2Lw_1744789615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:54=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 4/16/25 11:27, Jakub Kicinski wrote:
> > On Tue, 15 Apr 2025 14:43:41 +0700 Bui Quang Minh wrote:
> >> +def setup_xsk(cfg, xdp_queue_id =3D 0) -> bkg:
> >> +    # Probe for support
> >> +    xdp =3D cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=3DFalse=
)
> >> +    if xdp.ret =3D=3D 255:
> >> +        raise KsftSkipEx('AF_XDP unsupported')
> >> +    elif xdp.ret > 0:
> >> +        raise KsftFailEx('unable to create AF_XDP socket')
> >> +
> >> +    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_=
queue_id}',
> >> +               ksft_wait=3D3)
> >> +
> >> +def check_xdp_bind(cfg):
> >> +    ip(f"link set dev %s xdp obj %s sec xdp" %
> >> +       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
> >> +    ip(f"link set dev %s xdp off" % cfg.ifname)
> >> +
> >> +def check_rx_resize(cfg, queue_size =3D 128):
> >> +    rx_ring =3D _get_rx_ring_entries(cfg)
> >> +    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
> >> +    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
> > Unfortunately this doesn't work on a basic QEMU setup:
> >
> > # ethtool -G eth0 rx 128
> > [   15.680655][  T287] virtio_net virtio2 eth0: resize rx fail: rx queu=
e index: 0 err: -2
> > netlink error: No such file or directory
> >
> > Is there a way to enable more capable virtio_net with QEMU?

What's the qemu command line and version?

Resize depends on queue_reset which should be supported from Qemu 7.2

>
> I guess that virtio-pci-legacy is used in your setup.

Note that modern devices are used by default.

>
> Here is how I setup virtio-net with Qemu
>
>      -netdev tap,id=3Dhostnet1,vhost=3Don,script=3D$NETWORK_SCRIPT,downsc=
ript=3Dno \
>      -device
> virtio-net-pci,netdev=3Dhostnet1,iommu_platform=3Don,disable-legacy=3Don =
\
>
> The iommu_platform=3Don is necessary to make vring use dma API which is a
> requirement to enable xsk_pool in virtio-net (XDP socket will be in
> zerocopy mode for this case). Otherwise, the XDP socket will fallback to
> copy mode, xsk_pool is not enabled in virtio-net that makes the
> probability to reproduce bug to be very small. Currently, when you don't
> have iommu_platform=3Don, you can pass the test even before the fix, so I
> think I will try to harden the selftest to make it return skip in this ca=
se.

I would like to keep the resize test as it doesn't require iommu_platform.

Thanks

>
> Thanks,
> Quang Minh.
>

