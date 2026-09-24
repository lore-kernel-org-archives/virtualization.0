Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F6473C67
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254079; cv=none; b=ff9qvc/jzLCeZBp0/Dg31vdR2VUvEoAgMly3spGoeoMY9weeA4WXqm1WmYVFZ8+pURU08ZemFitwHNgiaCG4dMUWHz3gd+fku8BPOVNbXSGEbdgjo9a0QX6XZjJ2JNbUKvYotJMEKgi2h2PE+gGAUXxe4u0NlRuqP3Y8jZQ/7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254079; c=relaxed/simple;
	bh=K0ZcZrW9KSkpdlIoI/w2jaJjAzRvCqf+eyvsv0oXefo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fwo5mxKQioWxYyHdrML9hnN10kpyyohKe94V/lEMpWsUlVrOpiBq98rewUZNkzZgB8sYFJLRrxRtGLVBNOvcW6cU+5Cj2yhvv+oDtgmuw2xq1M/Pzhzgu8BFg6gGg7IT7cIgkvtJjVafN5mvFpieVr+nJh/oqNV3uxVOr7Y8esY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOpPNhu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOpPNhu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B511F000FF;
	Thu, 24 Sep 2026 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254077;
	bh=Uo4K0i/gBEUW1Q+qAYIun3zP3kctoFJRwk+eY02oYxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OOpPNhu6nRCzH9NPWhMEw4lOwWgGt2U7hgenhl8jecBDWyYD2WZ1kXX3cQgTYtXDY
	 AxDtHsF/dnyG/ds3BIN2VDHzjfXLAYKyBaFMUfpIbSAnH3zD6rHCnMpY34kKfyds/T
	 +AFwU1KQM1Bn33NY4dG8SrRR16x9WaTFZnAOWSuGIeath2TwOoDr/roEyStm8soo4n
	 G915S1yfqtKTcav60zVWETVX7rnph4jCjotcCZNoif7kPom3VEYgWSAf1i63bJ3JiX
	 57hbEPpxEEPKLxBQqtBKGEmTRrvjoAPKbsfy6ZCT/xHf/6Sy1izAsmW1y1Ium7GBWw
	 sLTc/6hn180XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: validate client monitor index before access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiale Yao" <yaojiale02@163.com>
Cc: dri-devel@lists.freedesktop.org, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260924123731.803007-1-yaojiale02@163.com>
References: <20260924123731.803007-1-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 12:47:57 +0000
Message-Id: <20260924124757.86B511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> client_monitors_config is allocated with space for count heads, while QXL
> creates qxl_num_crtc outputs whose indexes range from zero to
> qxl_num_crtc - 1.  The monitor count may be smaller than qxl_num_crtc, but
> qxl_update_offset_props() and qxl_conn_get_modes() use the output index to
> access heads[] without checking it against count.
>=20
> Starting QEMU with "-device qxl-vga,xres=3D1024,yres=3D768" provides one
> client monitor while the driver creates four outputs by default.  KASAN
> reported the first out-of-bounds access during probe, with
> qxl_update_offset_props() inlined into its caller:
>=20
>   BUG: KASAN: slab-out-of-bounds in
>   qxl_display_read_client_monitors_config+0x2379/0x2e30
>   Read of size 4 at addr ffff88810403e170 by task swapper/0/1
>   Call Trace:
>    qxl_display_read_client_monitors_config+0x2379/0x2e30
>    qxl_modeset_init+0x6a6/0x7b0
>    qxl_pci_probe+0x150/0x2d0
>=20
> The same configuration reaches the unchecked access in
> qxl_conn_get_modes() when userspace enumerates connectors.
>=20
> Skip offset updates for outputs that have no corresponding client head,
> and retain the default preferred mode dimensions in qxl_conn_get_modes()
> when its output index is outside the client head array.
>=20
> Fixes: 7dea0941f880 ("drm/qxl: use suggested x/y offset properties to pas=
s guest prefs")
> Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924123731.8030=
07-1-yaojiale02@163.com?part=3D1

