Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEE8F6D
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FclPiHBj"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 383F882A4E
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 383F882A4E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FclPiHBj
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BZEIVOFwF4ae
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 03:47:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 66EAE8293D
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66EAE8293D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=napYJyADeTJdk0SxBNP2ImYtRBQl1hD0AXWYIiJNkmk=;
	b=FclPiHBj69HD9TYYjbhu+XqN/6ExkSlQj6yqK8jSXSy5RtyIOY5U7r11AFqLKQwhzf/WYu
	rQjy5c7Tj99JJExZCozXNUpcISclpZlrjrb2EU5LW+uL9yYihv0NRFTPYZOw1OA+lAb0T4
	GSCKAY2QWV9qxpfEIbEAQJEn/Q4DQLY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-KLRQL1w3PBahj-4ZYqvwQw-1; Tue, 19 Dec 2023 22:46:59 -0500
X-MC-Unique: KLRQL1w3PBahj-4ZYqvwQw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3ba2072052cso6577787b6e.2
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044019; x=1703648819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=napYJyADeTJdk0SxBNP2ImYtRBQl1hD0AXWYIiJNkmk=;
        b=umfAn4lqYRJBZdhOGyNPz/M1O2PgGu6YCb8RzYakCWjeBOxiDPR2hl4p/NHdFzOixs
         EMoXVxVBxNzu9nKmzgychMlIRCQnEPClKzJAkThIP2CYls4wCxOXhTYHWFP3IGF6wlPa
         KxzcoCk/sLth9c7003dQN32RHQn0TwencogSdsZ6a8H4KsYCDcG6xo8jHi1oL6t4l4gw
         wNWWBoL6wHXrryxmdWCQwJw1TxnWeVh58r7ccWm3KsIpMjdK69cvOQY75Y4GLkV5XZ6Y
         +aKruC9POC0MDvKBnu14UXukfgC3syYBxz3+nGSTTKuDk9Ro9g1YbJW9X0knqg/X3ZYQ
         jgBw==
X-Gm-Message-State: AOJu0YwngxpIf19enM6imiEif6qiFbvRRdusbVJOlAv6iXRFFiqF/wTS
	JfG1R8eTVUCDJEaZ6vDQs4t5sNTncMNewqMGHwxM6tQfwO50J1S7Gw9c8QmRAr4epmThDQMV8+F
	9CvrZrgfeNI+zrFzSnFn0wcLHwEEuLXA4D6XS50/r2WOAA47g/27NBrbbKg==
X-Received: by 2002:a05:6808:16a4:b0:3b8:b063:6bae with SMTP id bb36-20020a05680816a400b003b8b0636baemr22969511oib.93.1703044019103;
        Tue, 19 Dec 2023 19:46:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElhpIIeE3pYkItfjqsfaUqAiQoIkyVM1KCSOfw1aDXcSf/lBVZVSmNNga9y+gVgQFxuT/583tXyxQqET5EN58=
X-Received: by 2002:a05:6808:16a4:b0:3b8:b063:6bae with SMTP id
 bb36-20020a05680816a400b003b8b0636baemr22969495oib.93.1703044018850; Tue, 19
 Dec 2023 19:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-2-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:46:47 +0800
Message-ID: <CACGkMEsQSJT2ZLZanavwTR668XjHQDoYSz8fH5HnwDmeH5rZgQ@mail.gmail.com>
Subject: Re: [PATCH mlx5-vhost v4 01/15] vdpa/mlx5: Expose resumable vq capability
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Necessary for checking if resumable vqs are supported by the hardware.
> Actual support will be added in a downstream patch.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  include/linux/mlx5/mlx5_ifc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.=
h
> index 6f3631425f38..9eaceaf6bcb0 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -1236,7 +1236,8 @@ struct mlx5_ifc_virtio_emulation_cap_bits {
>
>         u8         reserved_at_c0[0x13];
>         u8         desc_group_mkey_supported[0x1];
> -       u8         reserved_at_d4[0xc];
> +       u8         freeze_to_rdy_supported[0x1];
> +       u8         reserved_at_d5[0xb];
>
>         u8         reserved_at_e0[0x20];
>
> --
> 2.43.0
>

