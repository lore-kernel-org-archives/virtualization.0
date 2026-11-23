Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450129;
	b=PdYkmjXi+R7hf9j9RcZp9CM6pz9zwrwVTdouhDjiT4ZbFwnLQ/sQyqYk2tbj0SP4jri8
	 IUf7sd5Ff9DtPt6NrqPa7o3LlfiHWgl1da5F6dKP/XkZc3x/beMIJrqRciWCyA3kcuuPn
	 dCA9lgHTw8JzNLIexSieTTGawBLJCphi/p8Z+6UpsjE7az8Pnz0JXSvRxmSRl3oG+QdlF
	 vBNoPzw7DDLRR4/dccDUrnNTYERFKQZflyCsLOHdLGETvmkz0W/K5upFZ9qZKWgPNzh6Z
	 U/o7HicCRL2gWt4r4jxZziynDgZqX0IxIYhBloCUGDASWJ7KWkJdAeLICdd7vm9za8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450129;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
	b=IZsjW4ZbNkKwJxnvZ/1KMO6cZfTh2XIBqqCMTQeHZ4+a8QOmBuqWiuOADrcJG/vWU+FP
	 Pddi3gMCvesjmdhLCRjzBwz+QVi2mi4tMGS9GLFqSvylfub4iQwburLz6o98YNhbG2kDu
	 K63UjHte7MffhHi+3LwCJPliOpE5eQMJuumQiRTLiKwOV5P+3cGTeeA2HZdsmbbCkOGPE
	 uA7RVR9FWHzn1lRDbeIxP2LmqmK1fMA368Q4ANQDVrLrf2TzN317F7PjO88onAIwLPzIg
	 81+bjKhAE/syqjt8EOcKa/jNLsYiPUsiQ0pF2ZxBDyhxWWyMXIApdxr5B54DKeJWOyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5nucsP5;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AB606A31A
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 16:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 463AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C5nucsP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795450128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
	b=C5nucsP50WObmK5Q7uRc+TveRbQ433qzGh7y2uyYQKa3lu8VBblMI/jfSafsNlAU5bzqM3
	2Oof31kKa1N1IDRagkxQGSOfEn7xcPfxwBTeYUwTJmOllC7W87Xmt98CG4KzUEqxzOoPdu
	PXhmAJmsmsCBRCvg+AyMrINooTjHRUA=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-JM_pdWGsNTeD0ou_QjuXMQ-1; Mon, 23 Nov 2026 16:08:46 +0000
X-MC-Unique: JM_pdWGsNTeD0ou_QjuXMQ-1
X-Mimecast-MFC-AGG-ID: JM_pdWGsNTeD0ou_QjuXMQ_1795450126
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67bda487981so4861069d50.2
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 08:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450126; x=1796054926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lzGh06KvbW29kTdCwqSFpXTG7Ti9DVLUu53y+m7EPw8=;
        b=1Fg+Q7Jl0+Akf6JTJpo5HMLoyIapPwEtqoFV664IEpBjT2tCeWhG+pU+cFX9NOq8wh
         aCMLTkGfFAT9JH986sS8iIihga9a3G8ua8FQB4BtVmn7Yhn0ppyKKUsFc9y46nkXnusw
         csrMl4spuor5Wme0mnWKXIwvxlMlNJGxyJ7+8HV+t714rZqRZzz1nuR77iKMOswU+eNc
         KD56EFRhLgr3BXrNZF+/UE3jbMuNHGrsDoI66/hHIx2XkFh20WVonUpj62zSdqL3zg+8
         XY3kC7vfYCtJGC6jxEmGBWCkOV5T1DtzYMIzZq0Uu0OQSGQ4QP/ItunjwUEKo3dVPEkT
         wz+Q==
X-Forwarded-Encrypted: i=1; AL+hErEt4UvK/oLZ1lFgr3ycSfeAHz1rSedWJfp47Fvn2BqSe9wzPn9x4br+d9VqTAHj+Hze4GIYiAMtkxvoUa9UeQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+c91hdz1fffI2d/zaUMDLWmvEMDNTcAFyMZkFU9XwAeKCYm/FP
	gNYsvScvMAHw9w+HMNBhxBDDTZ8LN8jRvlIYPNOrwaozBldL0DKGpIHjigK+VCxksGP1B3VHMTA
	dyrNiYOhyU0YgbBdB7LG8jmjAAZNbZqjGALcsmCrQqBMHvOScrggOL30P+Aw7bnHihK6w+C0T+6
	yuwCOfbnajYTX0CXlmJMy+glPSOKBg9unPrCfa+/u5do8=
X-Gm-Gg: AZFdTZeuFTGQo/bXIGh+kw+b43OreHtEDV9RPNZ+/oh/CYS6uRT3aLsmoGofHKt2etq
	wrx0680GVz5c+UdtClYSc4FxyFCWwf2rPEfrTC7KC/J0+/wd8TqmOkDabMXU6FhlRh/3Udf6uEx
	DJbJl6RGfYxodCOT+mD3zo6kSDek1iNqvPj7Lj71B4pWFgOd6vbmAq80Cf9uFSV2ksw1havaivM
	WjYX4fYvu/H9eA9ylyOlKIyH7QAsj/ALiIw1+UpDX1edAvRlgWIcQuFG8Y=
X-Received: by 2002:a05:690e:4883:10b0:677:d5bd:8349 with SMTP id 956f58d0204a3-67df445d5bfmr2252246d50.63.1795450125522;
        Mon, 23 Nov 2026 08:08:45 -0800 (PST)
X-Received: by 2002:a05:690e:4883:10b0:677:d5bd:8349 with SMTP id
 956f58d0204a3-67df445d5bfmr2252240d50.63.1795450125014; Mon, 23 Nov 2026
 08:08:45 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261123135646.3962652-2-dtatulea@nvidia.com> <20261123135646.3962652-3-dtatulea@nvidia.com>
In-Reply-To: <20261123135646.3962652-3-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Nov 2026 17:08:08 +0100
X-Gm-Features: Aa3M54pR7ZVMpPP5oNO1OCA7GwyP-se96UdMP4VNO94DAWt_5DL7ZGYCWayniuk
Message-ID: <CAJaqyWedvj6htnM4rJyrbynW3u1k=6uLHrfuK05YvM5z8v1Hjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] vdpa/mlx5: Fix error cleanup when VQ setup fails in .dev_add
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BFGuw6NJIx-vwgaClEX11XLEiP4cqqE5_eyMwQB1eLY_1795450126
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> When setup_vq_resources() fails in mlx5_vdpa_dev_add(), e.g. because the
> firmware rejects the provisioned features (HOST_TSO4/6 without CSUM),
> the error path unregisters the vdpa device first and then keeps using
> it:
>
> - _vdpa_unregister_device() drops the last reference to the device, so
>   mlx5_vdpa_free() runs and ndev is freed.
> - destroy_workqueue(mvdev->wq) then reads the freed ndev.
> - put_device() on the freed device underflows the refcount:
>
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>   Call Trace:
>    mlx5_vdpa_dev_add+0x3e0/0x760 [mlx5_vdpa]
>    vdpa_nl_cmd_dev_add_set_doit+0x362/0x440 [vdpa]
>    ...
>
> - mgtdev->ndev is left pointing to the freed ndev, so every following
>   "vdpa dev add" on this management device fails with -ENOSPC.
>
> mlx5_vdpa_dev_del() already does the cleanup properly so use that. Just
> make sure that an extra reference is taken during the call to avoid
> _vdpa_unregister_device() from freeing the device under us.
>
> Fixes: ffb1aae43ed5 ("vdpa/mlx5: Pre-create hardware VQs at vdpa .dev_add=
 time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 6830a80e8543..7a39b0bbbee3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -161,6 +161,8 @@ static void mvqs_set_defaults(struct mlx5_vdpa_net *n=
dev);
>  static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
>  static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
>  static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu=
eue *mvq);
> +static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
> +                             struct vdpa_device *dev);
>
>  static bool mlx5_vdpa_debug;
>
> @@ -4043,7 +4045,10 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev =
*v_mdev, const char *name,
>         return 0;
>
>  err_setup_vq_res:
> -       _vdpa_unregister_device(&mvdev->vdev);
> +       get_device(&mvdev->vdev.dev);
> +       mlx5_vdpa_dev_del(&mgtdev->mgtdev, &mvdev->vdev);
> +       put_device(&mvdev->vdev.dev);
> +       return err;

As a suggestion, the cleanup could be more symmetric if
mlx5_vdpa_dev_del checks for NULLs.

But I'm ok if you prefer this way,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>  err_reg:
>         destroy_workqueue(mvdev->wq);
>  err_alloc:
> --
> 2.54.0
>
>

