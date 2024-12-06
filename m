Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457501553A7
	for <virtualization@lists.linux.dev>; Fri,  6 Dec 2024 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451682; cv=none; b=QCYW6jp3cOieSUwBS8POnr5lB1cZZRPt3qJqm6ZytLHvytQ5KxJlC221MDVXShrDkFi6AJlKgtFeq1oEIGLVZIRLMfSEBJZ6TS1x39Wzzs8rLN6Y8iKCCEajgoX6DD08RnP6f3ecrgXp7eM8oe+nPSygEMbLyXpqvqvv4+dcFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451682; c=relaxed/simple;
	bh=vLk2hzOOvDlMEBh2Gzo2cdgEyGdDlfjKgTthl08JpAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkXs9KxXXSXwyqlAwr113b9B2pCiM3BzXU1XSqUcBlAVAvPxUCArT9GmkHNkIEDNeHZkIIukV2G7tXECru/7JyMUjH/qsN3mK5+CV5JUm5Ymv1alkv/jMMkFMWM7GFZRF6iKK7vrzc1uKscr+jxLWaFOKiUqnnr++9/leM7dQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEY6M3Cw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEY6M3Cw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733451679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pboZ3VnmcTTj8kP2f77So4+NcnFeGWKwtfiLi6aYhnU=;
	b=dEY6M3CwTimFsbzcoTjlIeGDjXdw1XAY5MYTqbKe8WBE6HlT/v5PB4DQaNBAxCjVu915NP
	uw7Ti1ArdBpuWf7T7kTjbygxZKbNX48c8Jnim58+XOqKvBdSIbHPxg4ULyUdxJnrSbjrh0
	wQ43pgRwzZAYs3CgzvREyfdrac4VmGQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-1-CBAnOoPI2vI6AgF31YIw-1; Thu, 05 Dec 2024 21:21:17 -0500
X-MC-Unique: 1-CBAnOoPI2vI6AgF31YIw-1
X-Mimecast-MFC-AGG-ID: 1-CBAnOoPI2vI6AgF31YIw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6dccd3c9so1540393a91.3
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 18:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733451677; x=1734056477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pboZ3VnmcTTj8kP2f77So4+NcnFeGWKwtfiLi6aYhnU=;
        b=kOzn58l9785G52hruuvqEpwK3PwVOvb65gaHXdP/lA4pSuNKoPYstnw5679B/8GP93
         OSLUnvX2wULBlI18FFjFV3ROKO9Pli10vkUhT1hXB050YQk1HQVlhb20dyvP62F0mIY/
         d7d0r1QVZfjaUH7c1BpBsgbgpg5Zkv+wV0wG7h8AKOIwCQifhDBcX+Rx89ZqFTeKvYsa
         gxnQe1ubWr5B3giAlEE84dyBlgAmgnvFvWuYrAj/i31hwAsvjQ5M4eGCgIFnvy0RBPMn
         dweCN7D6Ep37AiIeJTZ0doI13uFcfgsS3ONzeXapZplcepCuyxdWALV5FFF55D/mOJ31
         q+5w==
X-Gm-Message-State: AOJu0YyEsd+MU+U+ogA18df00IMOgwT2Hg68kLOlcE8vEw6t8aUqRBau
	ZrAw8Pnl0HZkbLJn0Rk1L89Lt1RQkdjmo0UWf2kMlU7wlAxLWTUN8LxTwEibvu4jfzUsqa8jZzp
	gO4x/PVjiaIDZhg3JLrKlBGlM2Z4uwFTvai/3Pq0khZeRauD3/C1qFE+fzO2EM3lpK9xipOWY2/
	eFau+qMotxY0BP7Ee0mhZRmW9nXUvnBR3og14QmlA=
X-Gm-Gg: ASbGncu3Zki8oeoVX5cvMg3BWJ6sJOhKyKsMRpj1+g3u0btoPofGSCvnv+Zny4bQHG6
	hP9m5a6a+d8JgyLBBKdzKrG1O9PgLnrs9Xg==
X-Received: by 2002:a17:90b:2685:b0:2ee:a76a:820 with SMTP id 98e67ed59e1d1-2ef6a6bd306mr2214631a91.18.1733451676820;
        Thu, 05 Dec 2024 18:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH1dl+mby1r2n+lqlFAVV9PyOHv14lvCGqbyM5ufLkebaJNAcXZtoHC509zXOU/tKgOZdkjx6jxpTQ+/2YkYE=
X-Received: by 2002:a17:90b:2685:b0:2ee:a76a:820 with SMTP id
 98e67ed59e1d1-2ef6a6bd306mr2214594a91.18.1733451676402; Thu, 05 Dec 2024
 18:21:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com> <20241121134002.990285-3-sthotton@marvell.com>
In-Reply-To: <20241121134002.990285-3-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:21:05 +0800
Message-ID: <CACGkMEt_wUm7GEZ6zxUUO=JSRLYfj8ah9pwYbT0ZhO9-pnD+Ew@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vdpa/octeon_ep: read vendor-specific PCI capability
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ahsOQHHDHA7NDBEd9VtpSUg5Pu-inyHDItUmfhTucFs_1733451677
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:43=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Added support to read the vendor-specific PCI capability to identify the
> type of device being emulated.
>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa.h      | 24 +++++++++++++++++
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 34 +++++++++++++++++++++++-
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++-
>  3 files changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa.h b/drivers/vdpa/octeon_ep=
/octep_vdpa.h
> index 2d4bb07f91b3..0f83a1eca408 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa.h
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa.h
> @@ -8,6 +8,7 @@
>  #include <linux/pci_regs.h>
>  #include <linux/vdpa.h>
>  #include <linux/virtio_pci_modern.h>
> +#include <uapi/linux/virtio_crypto.h>
>  #include <uapi/linux/virtio_net.h>
>  #include <uapi/linux/virtio_blk.h>
>  #include <uapi/linux/virtio_config.h>
> @@ -52,6 +53,28 @@ struct octep_vring_info {
>         phys_addr_t notify_pa;
>  };
>
> +enum octep_pci_vndr_cfg_type {
> +       OCTEP_PCI_VNDR_CFG_TYPE_VIRTIO_ID,
> +       OCTEP_PCI_VNDR_CFG_TYPE_MAX,
> +};
> +
> +struct octep_pci_vndr_data {
> +       u8 cap_vndr;
> +       u8 cap_next;
> +       u8 cap_len;
> +       u8 cfg_type;
> +       u16 vendor_id;

Is this better to define the above in uapi/linux/virtio_pci.h?

Others look good.

Thanks

