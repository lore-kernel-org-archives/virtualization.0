Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3529B233
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694673; cv=none; b=ZxsEtXbRwEvzDhY7zJ2XRnuZ351dUM/+KUpDsz5xW2I8HMR0wPOKaH91FCocg6UxH6h2yhs3KmMEOhF2rM2c9PB1IDdacJb0mwj11//nSOc0WtBRRGMraJ57J18gQirdfSLqtjD8U2bVuNOcAoke27jU3B+j1+r7Dh9yA+QXYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694673; c=relaxed/simple;
	bh=mXFSWInmvF0MbvYWew7YaaBznDQE9EjRqSSCjHVWM0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWUg2zlayRUNhj+SJQ+5YMZqqCFIVuDF5AfLwHTG9io5CrevP+T/+p6KYos+1EXrFgJ0Q1pZvxKYYdKlJR95MxPMv1umwYUtKUYLnehzHJpFBc77/FWSiWwFd6HF0dE4y7WAlsvyr79IqSMkkv40o7gOaAdzqOkb1zwtPx1bRMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXv8zOpV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXv8zOpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A38C2BCB2
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772694672;
	bh=mXFSWInmvF0MbvYWew7YaaBznDQE9EjRqSSCjHVWM0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tXv8zOpVXN9YPp1+Gnn+Uur5+wyjQlYkb1dKDhvI7Nr3rLIP3Rb1tn1ogaoWE7ZFa
	 ovWQ9PQ+YMcp+jZ5/IREtjGw2ROJMI4cegJoLwhy5gZLd2aLRAj0MVZoHapHxEfnGa
	 jlF3FWe05UfLZt7EGUmD5HxmFgGI2wpEuiUnvnHXhbw3Z0b5HOrTofwpg26FBlUWlt
	 s6pkADTZ9ISNRsk3ImAl6tAVpRGfGIjqvy18Sdw2ds+JysYqJWk9p8wsP7+p/bmVId
	 D+Q5SlSjvFEBrvZoYy2V151KtyUApglmvyMguSQrYjcgBnG6Da3dLUpxwbI+3FQTvX
	 4JzsksjB+msNA==
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ab077e3f32so33882995ad.3
        for <virtualization@lists.linux.dev>; Wed, 04 Mar 2026 23:11:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU60PbZ1DCa7BZZTlNkhNKUXa7kX3CZPFh4wHAMFrKGvo0Z52JZWxh4NC2EDTO2X3J01aaRVsd1ImUBPTAmjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZ6xtFyl6MbJM5rTAHnxp1mrX9Pm3s6gXK3IlyhdgsMyTnZq94
	PjDDMacZGZiOudWb0Kp7pf5mjd+fB58CvyLrGYAZ3g/Vph41oW4POn6GTQUpR4UyZdHhCkXeC4P
	J1yldeLVYKSBoCf2uxez2HI5tMsva0QU=
X-Received: by 2002:a17:903:2283:b0:2a9:5f11:3a26 with SMTP id
 d9443c01a7336-2ae6aa05619mr41094335ad.7.1772694672274; Wed, 04 Mar 2026
 23:11:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226152924.38790-1-evg28bur@yandex.ru>
In-Reply-To: <20260226152924.38790-1-evg28bur@yandex.ru>
From: Zhu Lingshan <lingshan.zhu@kernel.org>
Date: Thu, 5 Mar 2026 15:11:00 +0800
X-Gmail-Original-Message-ID: <CAL=tH4Z2Ajz5C4p2WzwxHWKyHtuhqh-jSiJHuP_p430wLZBtxQ@mail.gmail.com>
X-Gm-Features: AaiRm51ucb-BYa-reeQ0TL8MIdBV9RzONVdvI-jo2XUM7rl_PIiph6_qNJcQ1Pc
Message-ID: <CAL=tH4Z2Ajz5C4p2WzwxHWKyHtuhqh-jSiJHuP_p430wLZBtxQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifcvf: handle dev_set_name() failure in ifcvf_vdpa_dev_add()
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 11:31=E2=80=AFPM Evgenii Burenchev <evg28bur@yandex=
.ru> wrote:
>
> dev_set_name() may fail and return an error, but its return value
> is currently ignored and overwritten by _vdpa_register_device().
>
> Abort device creation if dev_set_name() fails and release the
> device reference to avoid continuing with an improperly initialized
> struct device.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_m=
ain.c
> index d46c1606c97a..ab6d6ab3b3d8 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -734,15 +734,22 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev =
*mdev, const char *name,
>                 ret =3D dev_set_name(&vdpa_dev->dev, "%s", name);
>         else
>                 ret =3D dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->=
index);
> +       if (ret) {
> +               IFCVF_ERR(pdev, "Failed to set device name");
> +               goto err;
> +       }
>
>         ret =3D _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
>         if (ret) {
> -               put_device(&adapter->vdpa.dev);
>                 IFCVF_ERR(pdev, "Failed to register to vDPA bus");
> -               return ret;
> +               goto err;
>         }
>
>         return 0;
> +
> +err:
> +       put_device(&adapter->vdpa.dev);
> +       return ret;
>  }
>
>  static void ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_d=
evice *dev)
> --
> 2.43.0
>

Acked-by: Zhu Lingshan <lingshan.zhu@kernel.org>
