Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AC4645F
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7qAiI6g"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DAC14085E
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DAC14085E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B7qAiI6g
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ccjYJm6ssVEy
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:33:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 85E56408C3
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:33:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85E56408C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703089986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otTibsUCfMz/7ItOEyfiSpPc/e6QlSfHglq36d1YbNk=;
	b=B7qAiI6gbxD7Nc+iYJ30AVcD2rkrOI7WmUiyO0MjXNEBDghEllYS+SIZlk2IHVY6XlfENu
	iWXuRUn46+nHWfPl7hGb44VpXAWISD61KZsXqrjKVpn5JgfenoZK4IYGt/hqS+qo4lwa6x
	wYEZSFISwdqli4mv3RwoLqX1ABtRmeg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-qzlFv0kVNHOwWCfx7zdZpA-1; Wed, 20 Dec 2023 11:33:03 -0500
X-MC-Unique: qzlFv0kVNHOwWCfx7zdZpA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5cf4696e202so80475187b3.2
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703089982; x=1703694782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otTibsUCfMz/7ItOEyfiSpPc/e6QlSfHglq36d1YbNk=;
        b=TkBPLRBYVqmQlWUd6X9bQ73pX3XCmbSzBJMKZU+558+P8LiACSummOVrqEBKhlehTI
         DX4C5TIcM//M/g7O2sLLql59DUEQNSgxgse6lQhJHqstqJwwc4qWH9b0as9u09WeTPOh
         EDzfcoHAh7lm7m4JrDF9WizocHRjhkJC9zGXcKcuxHd0AE4VTRW1yQIsm23cEaE+5Glf
         F2a3rVJeI8Gm0La5hEZCnwYe4t4nAG9zu/oi1Mh0UT1B03IrvGaQxwZz0jHL8hBEaW6i
         O4DCI8kav48cxbsLgDcZ4Wq9VUqMMReB8jcNpszUIrYZ2JlqgmMFFEnH06ipS838GFLR
         V4eA==
X-Gm-Message-State: AOJu0Yy6IoFPQiYZc0BmwZS6pdzeVXyqQiA6tJYp6DhfMg0Y427wswCV
	O+B+axaP8ExcV9kanBby2qWRd4XmounlHHEsrCz3vy3g1qKZIZwijiDtsp0TO6NG/t2MgbaNBzK
	ZugjOeseUN/k+YzA9S3ImH/dXfZy0eUGZRlw0ivsIqluHF8W+EdWzGO32IA==
X-Received: by 2002:a5b:c05:0:b0:dbd:a328:1c2f with SMTP id f5-20020a5b0c05000000b00dbda3281c2fmr1023251ybq.41.1703089982172;
        Wed, 20 Dec 2023 08:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxhOo8JZya50yoD++DuZn2aQCcR+4aKP5ovWmXTbl92nbHy9Oe+57z2KJM2qPl/cwWRbY/iOnjD143LPLkDL8=
X-Received: by 2002:a5b:c05:0:b0:dbd:a328:1c2f with SMTP id
 f5-20020a5b0c05000000b00dbda3281c2fmr1023239ybq.41.1703089981874; Wed, 20 Dec
 2023 08:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-9-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-9-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:32:26 +0100
Message-ID: <CAJaqyWfhO532qW+9eWmJqV3JxvvqnB2QZfi1JqUYXPLuiAsggQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 08/15] vdpa: Block vq state change in DRIVER_OK
 unless device supports it
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 7:10=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Virtqueue state change during DRIVE_OK is not supported by the virtio
> standard. Allow this op in DRIVER_OK only for devices that support
> changing the state during DRIVER_OK if the device is suspended.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 6bfa3391935a..77509440c723 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -641,6 +641,9 @@ static bool vhost_vdpa_vq_config_allowed(struct vhost=
_vdpa *v, unsigned int cmd)
>         case VHOST_SET_VRING_ADDR:
>                 feature =3D VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND=
;
>                 break;
> +       case VHOST_SET_VRING_BASE:
> +               feature =3D VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEN=
D;
> +               break;
>         default:
>                 return false;
>         }
> @@ -737,6 +740,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>                 break;
>
>         case VHOST_SET_VRING_BASE:
> +               if (!vhost_vdpa_vq_config_allowed(v, cmd))
> +                       return -EOPNOTSUPP;
> +
>                 if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED)) {
>                         vq_state.packed.last_avail_idx =3D vq->last_avail=
_idx & 0x7fff;
>                         vq_state.packed.last_avail_counter =3D !!(vq->las=
t_avail_idx & 0x8000);
> --
> 2.43.0
>

