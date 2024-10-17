Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24B194A4B
	for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 07:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149714; cv=none; b=VYlCXwYTk3k0ce9c24tl6pafZ4nm5FPmyPnSuMMgUZN1SK1zfn9/5n4Rn5ZD6zHjMzNs4TT2HkjkewNbbukfxtxX41mxWmpN+IwpFZL/IHY8nklvrFV5XqbaO4pY3K77qw0+FtppJZQQHzkaPnTF+3YP4VJ8tEqeujf7+0yLxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149714; c=relaxed/simple;
	bh=Z6zHfgJld0xU1iCfxUaWD/oJ3UVGD3DyuRRvY5ltBJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWjrSPkK9GerRUDwpQc/wtcuANLxu1IehOhUiZ4BTurdhc+QQCP0F6ny4SCRRNW6BVZJJDTJqtfrRpWZ7T2w3H9P3PIemNm7huK41JfWZFoGUAyycBXDZakDPm26shpFzOD6VtBLD65CVX5DUSFjlRPNBhN5r9YfWsijjIAebf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzCktZo2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzCktZo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF26C4CEC3
	for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729149714;
	bh=Z6zHfgJld0xU1iCfxUaWD/oJ3UVGD3DyuRRvY5ltBJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JzCktZo2t4BOPbjEdfYXHOm5os/1lYZ90OB10FLfXDLFnjPOtV6MUBvfPG176bjRn
	 +wzZyht56kbUO/m+jgydzhQhdF/or0yanMriLJ878ugeVacD2DmqzK5xa+f6/SI00T
	 YHQ1qdMMpw9wT7XAJJaJPvEl3qQsaA/qWgD/63BZbePbeCWjHLaAz1QijFXYkwYOgY
	 XnZKCoS2GqlXe0+VkCUCfbqIl5kteVBXFUjvOew6JlScs/vdnXEt71M1viF6ro4128
	 BFm6yjeQZBwMgAPzmBurcD1Ci8tOnpR7uerep3XdXuJD1YAJytQgueMIQ57nm2krHe
	 LyMQA1GoZUXrA==
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582cf8so388389b3a.2
        for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 00:21:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJfwWtwfbbfCZms4CZHPpHXBPUyzEIE0QIkwcgvUraYv1S1RMC/KiiQ/sLnzIIzDoTf7UQfPkZSE2F2RO7uQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYc+MMbCsZOJ26qsktnYVnJ2RQDNIvSu8nROJ/PH014gH/C4NW
	7cbof5iG6D8lC5Od4O8NNEXyMG4t5LGpm5lnggGOER7hQEcAJYuXAyN4b5oWMacBQJeqLR2y//E
	u2fDphoWmrJwsZrf1xKvWIMF0J4M=
X-Google-Smtp-Source: AGHT+IHEfgKL4XN+dW0ytWupM7+mdtcvg2YRTyzLvXUraQCVKOZpIO4rJ2GdVCpbbBFmcldM1Km7J3vMNvOplF8rM6Y=
X-Received: by 2002:a05:6a00:2e97:b0:71e:cc7:c507 with SMTP id
 d2e1a72fcca58-71e4c1cf183mr31892726b3a.23.1729149713658; Thu, 17 Oct 2024
 00:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241017013812.129952-1-yuancan@huawei.com>
In-Reply-To: <20241017013812.129952-1-yuancan@huawei.com>
From: Zhu Lingshan <lingshan.zhu@kernel.org>
Date: Thu, 17 Oct 2024 15:21:42 +0800
X-Gmail-Original-Message-ID: <CAL=tH4acr1SkjcJrhwW3Qx2yJtydsvRHsvYNOv8k_dcQbPXbsw@mail.gmail.com>
Message-ID: <CAL=tH4acr1SkjcJrhwW3Qx2yJtydsvRHsvYNOv8k_dcQbPXbsw@mail.gmail.com>
Subject: Re: [PATCH] vDPA/ifcvf: Fix pci_read_config_byte() return code handling
To: Yuan Can <yuancan@huawei.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, xiao.w.wang@intel.com, tiwei.bie@intel.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Zhu Lingshan <lingshan.zhu@kernel.org>

Yuan Can <yuancan@huawei.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8817=E6=97=A5=
=E5=91=A8=E5=9B=9B 09:42=E5=86=99=E9=81=93=EF=BC=9A
>
> ifcvf_init_hw() uses pci_read_config_byte() that returns
> PCIBIOS_* codes. The error handling, however, assumes the codes are
> normal errnos because it checks for < 0.
> Convert the error check to plain non-zero check.
>
> Fixes: 5a2414bc454e ("virtio: Intel IFC VF driver for VDPA")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_b=
ase.c
> index 472daa588a9d..d5507b63b6cd 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -108,7 +108,7 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev=
 *pdev)
>         u32 i;
>
>         ret =3D pci_read_config_byte(pdev, PCI_CAPABILITY_LIST, &pos);
> -       if (ret < 0) {
> +       if (ret) {
>                 IFCVF_ERR(pdev, "Failed to read PCI capability list\n");
>                 return -EIO;
>         }
> --
> 2.17.1
>
