Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587D17D5
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062382; cv=none; b=ZnysD9fkBV1btxMhnmNgY2pkyYAWyGozQrDzLKWzEL8l9bhs5ow4AOKRVt+AYhOiER6tqyGnODDwNLYDkUSeIqlkkSEupHNCcSRMuy88qxUHjv+WLum779ksFlpMruZ3iI139IqIcIzLfgVslC91nneL4qzPACR4ICTOBGpmqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062382; c=relaxed/simple;
	bh=lFdIGOrsLJDCPMyERIOrFMHqIa0XrdR2y2Y6ka89vkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCDOdt1Rz1KGJuORQKoJiK2wz3c+KULOScWIW0MkRt0rzYRuCwOYyVhLbL1+CXf8sL/jAbGNybDDL5ohnAkt64whdUvzKArG8L16UMKJLebjkiOyz3g4jPqRKUYsC5sqhv9sqQj5AC0uhDNYAOexdnoiKPok6XdaARE6hwTdS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jmx+02C6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jmx+02C6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A075B85087
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A075B85087
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jmx+02C6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ruiRsS392WZn
	for <virtualization@lists.linux-foundation.org>;
	Wed, 24 Jan 2024 02:12:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F1DC8507F
	for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 02:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F1DC8507F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706062378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BcX6ZTJW6jDsbwZncNxHncjf49E26ZAqFDwn/qtQ/ko=;
	b=Jmx+02C6u/XVppohwbvwVgyZQFcT577XdSpZHDjIlCCDWsNGBL9Z7r53I1ABFOFtjAhs14
	iCIw39XrbXhZOAPOTP1ronn74DtIVP/OwbU7lXmlnGeoOuDM8hXOexls956713cVZCIlc3
	dakDH/VxzNHMCtFl1k1LaLPsmMr/0hE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-x5-_ZsOqPcqVnFSUhCZQHw-1; Tue, 23 Jan 2024 21:12:56 -0500
X-MC-Unique: x5-_ZsOqPcqVnFSUhCZQHw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cf52110173so4837897a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jan 2024 18:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706062375; x=1706667175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcX6ZTJW6jDsbwZncNxHncjf49E26ZAqFDwn/qtQ/ko=;
        b=Up77I8E+HoupI7h1kIbr533B1tDA7YD8H/tKGcl7rxm5Xr17BsrjXl22QicbJCdcAp
         TeLDM0zH5FELrOrjdKBpBxItsj8I0yBcVAp4i0tQ7v/+PRi+r9BNtIIfYXHIGUCQkCGF
         FeBPzJ5ehn3J/FxQ39o2TjIwMu1WFWn7Hfn7JARS16+MBxT8rf4xQG58wq86XRVVm7yW
         XJxjCFeHCD2J7sktMhlMkpIZmk8Cdsgmza6cs80uxDb1A5foJTHzEF3fUezRy4A4QAtH
         g8p75peDDHL6jHNiP4tgnbyudCwXrTzeFGuKjbyjCsYYxisAZSIVqq1cTm5U6labB0FW
         T43Q==
X-Gm-Message-State: AOJu0YydYRvZKc6yzWjXw60FzYpcK3QteGKoqiVyafU+dhKQnxUt9fVS
	Uy7huWR+qvzMRehu310j6CfadWJmobH3PN1Xq25mrb9R2w6HArZCXaIsfup9ndgzcjEgPJiM2r7
	Lt7+OX6b8OBYOQMXKaOAcV/v4wh4c/7ArE7iIDAuXMldKHE/M3FnxW77yZgXjRdft4vHWV/8Dfo
	0bN0k2JHAYYDn2A7kEWkak8rJBcrtt5FjPFKlSUlX5jJRKk74oI3Q8Lw==
X-Received: by 2002:a05:6a20:2d0a:b0:19a:834f:3b05 with SMTP id g10-20020a056a202d0a00b0019a834f3b05mr246695pzl.47.1706062374956;
        Tue, 23 Jan 2024 18:12:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNn8l1cx6DZqmpTOXs74y9mH8KWMRbygPjT3c+58HhDNrQpbaQx2ZervZGQULrB6ZouLS1P0uv/AuiVE1ygFA=
X-Received: by 2002:a05:6a20:2d0a:b0:19a:834f:3b05 with SMTP id
 g10-20020a056a202d0a00b0019a834f3b05mr246687pzl.47.1706062374696; Tue, 23 Jan
 2024 18:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240122102256.261374-1-liangchen.linux@gmail.com>
In-Reply-To: <20240122102256.261374-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Jan 2024 10:12:43 +0800
Message-ID: <CACGkMEsS2yAnEc3UAQ8EeBgv6aOFVHnX_D=2kyNp96kZwsU03Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:23=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing XDP
> hints through kfuncs to allow XDP programs to access the RSS hash.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 56 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1011ea..1463a4709e3c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4579,6 +4579,60 @@ static void virtnet_set_big_packets(struct virtnet=
_info *vi, const int mtu)
>         }
>  }
>
> +static int virtnet_xdp_rx_hash(const struct xdp_md *_ctx, u32 *hash,
> +                          enum xdp_rss_hash_type *rss_type)
> +{
> +       const struct xdp_buff *xdp =3D (void *)_ctx;
> +       struct virtio_net_hdr_v1_hash *hdr_hash;
> +       struct virtnet_info *vi;
> +
> +       if (!(xdp->rxq->dev->features & NETIF_F_RXHASH))
> +               return -ENODATA;
> +
> +       vi =3D netdev_priv(xdp->rxq->dev);
> +       hdr_hash =3D (struct virtio_net_hdr_v1_hash *)(xdp->data - vi->hd=
r_len);

Is there a guarantee that the hdr is not modified?

Thanks

