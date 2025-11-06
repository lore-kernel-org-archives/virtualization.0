Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE12BEC45
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 04:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402098; cv=none; b=WT1ml96+bVCGSUtip1DfQLLGSspIcPtZP1DLhPc18EoFfmdlr6IJGS7f7lsaIxLUnghm7rnOJV8b59nhjow2DDBdgkc4CW7YIIw2atJR/Rpr39I77GektYki7v6FAUM0X7iO36HqlyZE/XshdbJCfp7EabJHyA0ni73eA6MGAws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402098; c=relaxed/simple;
	bh=/clFG5PxzG9CFjAwwukXLsQUq87vBTuWgGXa+2pm7nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IW/R+3dWEPkoXXOc7QRTfpBXaZhPnj95Lvs/OJGnW+n8D/d61p6CSZgWb390EMYY4BvfcG+Y3aetct/c/yJ3APzzjt26PiS4DXOnPo4fC1xJpZ4+g9pDvpSSEParQdPUGs575w8OgpdOsDSbQyUsVM0ees1S0OlaLL5u16y5G+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QP8C6bzo; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP8C6bzo"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A208E41186
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 04:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40UqfamV_GMw for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Nov 2025 04:08:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C04EA41142
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C04EA41142
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QP8C6bzo
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C04EA41142
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Nov 2025 04:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762402092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ErEHllqGXQa1rX1HuSUsA/o+LeE0c0+S+I56A0yD3w=;
	b=QP8C6bzoZEn7okfiij2nsu84f0dt/vKggNVrdxFrugXL+LGj+4qhpWiF5S9HXfcLcNE0i3
	IYP63WCtf7CPl3KDATjbx9Wj+U0qYXvq0BYUKJKY0ls7l9z/4GGZMk0vC+8U165p9YD/g/
	8/GklBAv6rGqZYED4JxGhqEdrYUl+Zw=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-tUsPBmhoN2CJxLMP4RdRrw-1; Wed, 05 Nov 2025 23:08:10 -0500
X-MC-Unique: tUsPBmhoN2CJxLMP4RdRrw-1
X-Mimecast-MFC-AGG-ID: tUsPBmhoN2CJxLMP4RdRrw_1762402089
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-932cb539eceso297225241.2
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Nov 2025 20:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762402089; x=1763006889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ErEHllqGXQa1rX1HuSUsA/o+LeE0c0+S+I56A0yD3w=;
        b=FFWOxuz281cUgPJQRzmar8aMDHqTljtYqiJTf9q3NtGmztkqXsXaKQkFqn3KD52ZMa
         FEtdbfXBEHeOmeZHqsXyeM7TKRf0udw6w2OhN7hPpbW35nR0oejwzIX+OfqGaCJx9QL7
         AoD1c8oqSs/Pwnn1OiHNP087t2z0oXcAG4U8EsrVpR9H6ouKuI3zL/YfT1YdOZWmxWfb
         HyKuB8SjEEmQPeeWXCce+/iUcQLZ4sEXr8yBZtWnhfQ/nor7V20NY9GgU6yE/jsMek2Z
         8o92I10s7brQ+rkzIw3rcU0sZzFvdlEN7QgdEW7W5GPr0HjED9filCNSUFpTIoQK9+Kf
         YCQw==
X-Forwarded-Encrypted: i=1; AJvYcCWt3AZmriOhGMvn6a0Ob9ETHJIEjwlkvlWqWnkqSJ2jN1Q2fsArRmObk90sjNcTjGDTETn9U/OAmgx4GphpCw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwP6uhI3dNdI9zw8BPPhWOiNCYzPqGy4tZR/DFypgQ0gUSL092o
	mq969hPpFtvOXm7OYTzXHQyhiUJOZT0iCNhcorqaYBKuvZ6hVxzv/JOikKvonwtDgbWhosXgYxb
	53PGmO27IWtOjTziIgIY5XrKfq3v/qkNQO8cywiPNoN6IoXDbmQQM4Dg2vA4MOHp+iM1CWnGenQ
	w1H0sUmWSyoXT7IpgvkFJz0sI3Rc3G6fO9EAn/EtgZlo7Tk338n0MZ7doLqg==
X-Gm-Gg: ASbGnctx6M5dSAQsKILJLjKGmoQdgUtcMl3wliekSRbtAjbF9JMLrYSVe5z0kZAO56r
	3fyNp5b+ZyeiCN5sLgE5B4hksxUcudQQNZaQ+3byKALxCSH53IGk0pq4MWhNWmOd7RRwCLEVWdJ
	SoeD/yICulwzuCgyc+lCUS2/1AQ6PG/xIFN9yx3U2HhdquwaOhLj99iNTG
X-Received: by 2002:a05:6102:2ac2:b0:5db:ca19:f02f with SMTP id ada2fe7eead31-5dd88ef0787mr2077865137.9.1762402089472;
        Wed, 05 Nov 2025 20:08:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsGQZaJVQOEVAkyZ4GeLriyj8SNnSrORtKtMKUrl76u33NNLwRG6BIbywMULZtgOZQKt+9Amf1gB0m2UWnG7g=
X-Received: by 2002:a05:6102:2ac2:b0:5db:ca19:f02f with SMTP id
 ada2fe7eead31-5dd88ef0787mr2077859137.9.1762402089047; Wed, 05 Nov 2025
 20:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com>
In-Reply-To: <20251105080151.1115698-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 12:07:55 +0800
X-Gm-Features: AWmQ_blkjcF91oRQFm8CV6EBB0pbTNMJW4V9b4A10CbddPExXzNM8-bAP5bZeBQ
Message-ID: <CACGkMEvriYoN2XZLmB0KcJmH4hVT3iYj3QV_ypfgHSQNwv296w@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: update mlx_features with driver state check
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lS93WQLnVE2ltIzQKHKl04WWzBFnhxAVKPMhId1zFVQ_1762402089
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> feature bit is properly set only when the device is not yet in
> the DRIVER_OK (running) state.
>
> This makes the MAC address visible in the output of:
>
>  vdpa dev config show -jp
>
> when the device is created without an initial MAC address.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 82034efb74fc..e38aa3a335fc 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -4057,6 +4057,12 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev=
 *v_mdev, struct vdpa_device *
>         ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         mdev =3D mvdev->mdev;
>         config =3D &ndev->config;
> +       if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +               ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_F_MAC);
> +       } else {
> +               mlx5_vdpa_warn(mvdev, "device running, skip updating MAC\=
n");
> +               return err;
> +       }

I don't get the logic here, mgmt risk themselve for such races or what
would happen if we don't do this?

Thanks

>
>         down_write(&ndev->reslock);
>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> --
> 2.45.0
>

