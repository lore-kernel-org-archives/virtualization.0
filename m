Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB7736920F
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285520; cv=none; b=S6Sc1P5uWWIU98VVO26P5APTPcufhj1kUP+QVz46NFkJ52KZDP8dxdbH/DV+XhHagqE7uZDWn0TBj50fkFTnfIyba4IOe23kQs0GwQ+d0pUXp5GMfonizyY50VNz8My4cQXiVqx8u/OzccvKkBwv5fZbOk6V9I4a00H5ff9vrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285520; c=relaxed/simple;
	bh=jbfNmujyJRIgSp87JEHr+v6171xWk8W3A3ztwmIGB9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFigOmaSTQaLvi37bET0ofye52/s46BT0pbYNZLTxLwgEF0bNFxN6mtY/TcYPIhm94bctUC9qL4l68oeVXzjH6Meh1Zc1Cs25C98QSTGoJRdFWd+pUDM/9obOvUkZmoIlgzl/JMchUODPZgly+EKFjJcOOYpphZ1D5n8H/72J08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zx7/9WNy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx7/9WNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768285517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZX0ael+fRD6kaegNEKH4CmtzpVEmDB1ZIT4Ud4Ve+28=;
	b=Zx7/9WNyDu/gboKCUWSEAQUeDZ/Zq8/nfHAZPmncn3XgA890lQhBB490RSq7xUQOnek3wS
	3QRYXdSMSzegEBNGFgxSj5lwLK0t6yq61aM5oabjsiI4qM0DVeM+D/0jU1rRN2M3yepox5
	dofIyJ6WRVqJaYwe29EbF3d6yypnSI4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-I3QmHg4nOcele7jRgkzKQw-1; Tue, 13 Jan 2026 01:25:15 -0500
X-MC-Unique: I3QmHg4nOcele7jRgkzKQw-1
X-Mimecast-MFC-AGG-ID: I3QmHg4nOcele7jRgkzKQw_1768285515
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c2f670a06so7758688a91.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 22:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285515; x=1768890315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZX0ael+fRD6kaegNEKH4CmtzpVEmDB1ZIT4Ud4Ve+28=;
        b=HsZyZQHtLziuGUxykCJ3e6Uij4i9S6arHRk1uX5jYsiQWzNLZfcXCvSnBvBkECHmoM
         VG+6502OUIbRh7hk73Fx8J6dsJsYsT+xu9uKgbVLlczRQq9isa9d5M3imfDd239fRuZu
         xT09u9SgyMGKbfl48+nlzm74gSbO236LeXsq+7jq0YFf4Bx1Jd+YLCTqqjj/wcXyG1kT
         cT+VTZiUaxelT64Qt/GbGFtEllqLsmurf7YLLD5Oz9xSgUZyAwaaEx8hviYVJP/4cZoZ
         11jRcqLiGNpk7yjoLyQcbQn7wfxDxwt8RlqNu4SfYDzuMFE8+7lwtCf9fk/Vp1yjK4+i
         LaFw==
X-Forwarded-Encrypted: i=1; AJvYcCU3OM9tnVIv4XkJ2vCRZX2WwxUZDSyH87xH/ltRrztII2tDvaTpG5waGV8Xsa5+Yf39Vsjtb+TbK2CXOooE3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0DAh0Eu5SrcfHdmC3Y6BEEhxltIZLlse1Rm/YJLG2Hik2QD3d
	MmKsmt8KOuQxwHE6apvn8wlCcjJ4SG39cnEtiJg2A36xIf6uww1rd1vj5r1W+92Wpc/k4fNRrn2
	ZNxITlb7tgD8ZeHbbZBQbvINGGIREf4+QloI7isOthBvNUU6HunPJkfP5gCsCkyZiaw9Hwlg01Z
	PftwnaRCs0VXffH7DcyTcn7iO+A0c+d6PZQ0CBRvMg+mo=
X-Gm-Gg: AY/fxX7g7nlatlqMMrw1/SNVtJyhoJacHi5mXnOlJUEEKAB1IXOwi2VVDjilXbHzfnw
	l2w63H3MlOyV4jSccOdQel3F4S5MquOznesEVOZ1Q+LzZZ2RGZMgunRZ53QTGC25LMoVeLKWD3y
	uy5ODKrH0lceOteA1PDzYyiNCI6dRTu5zbAaWAxLeWN14wf6yYLGyavKq/wqCiHLtJQIA=
X-Received: by 2002:a05:6a20:e290:b0:366:1fc2:684 with SMTP id adf61e73a8af0-3898f8ddca5mr20252064637.8.1768285514886;
        Mon, 12 Jan 2026 22:25:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGf5a1ZRsjJ6TDLiXqyPuXxVORtghTwI+cn1aDhpN1NZEdbIixJJjh9VCAwP89rA4646MGzkiPNBvDkb0w3D4=
X-Received: by 2002:a05:6a20:e290:b0:366:1fc2:684 with SMTP id
 adf61e73a8af0-3898f8ddca5mr20252044637.8.1768285514488; Mon, 12 Jan 2026
 22:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260109152430.512923-1-eperezma@redhat.com> <20260109152430.512923-13-eperezma@redhat.com>
In-Reply-To: <20260109152430.512923-13-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Jan 2026 14:25:01 +0800
X-Gm-Features: AZwV_QjeX6dwlEv4hFLixCtenq8GpBek-srpREXaf-pM9fUUlaZvvB80RwgXwkI
Message-ID: <CACGkMEvt4bK3ihn1QBn-ax7GprH91c-6-muv7jJ1-bR4fkG6=g@mail.gmail.com>
Subject: Re: [PATCH v11 12/12] vduse: bump version number
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Maxime Coquelin <mcoqueli@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5I_6mMJD7fAjjzi6XWiklJf5LyCeUCzEE0Wh0K8F9IQ_1768285515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 11:25=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Finalize the series by advertising VDUSE API v1 support to userspace.
>
> Now that all required infrastructure for v1 (ASIDs, VQ groups,
> update_iotlb_v2) is in place, VDUSE devices can opt in to the new
> features.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 8227b5e9f3f6..5ad0ba1392f3 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -2201,7 +2201,7 @@ static long vduse_ioctl(struct file *file, unsigned=
 int cmd,
>                         break;
>
>                 ret =3D -EINVAL;
> -               if (api_version > VDUSE_API_VERSION)
> +               if (api_version > VDUSE_API_VERSION_1)
>                         break;
>
>                 ret =3D 0;
> @@ -2268,7 +2268,7 @@ static int vduse_open(struct inode *inode, struct f=
ile *file)
>         if (!control)
>                 return -ENOMEM;
>
> -       control->api_version =3D VDUSE_API_VERSION;
> +       control->api_version =3D VDUSE_API_VERSION_1;

This can break the "legacy" userspace that doesn't call VDUSE_SET_API_VERSI=
ON?

Thanks

>         file->private_data =3D control;
>
>         return 0;
> --
> 2.52.0
>

