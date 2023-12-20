Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D6847789
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFv9/YSP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FDF04161A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:10:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FDF04161A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jFv9/YSP
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3aGVnx3xU8yS
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:10:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B84B1415E7
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:10:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B84B1415E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703088605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBF/2A/nktRQkyV9wK9FTmKMlXm8fHaSo0cgylBofKE=;
	b=jFv9/YSPHUnsNNv+nuFuSNC3YfAe+68nwAw0IpGU+zVMwWjYY/1sXZnsqMbeYFIU3gnOxB
	A/a16BR2VfsV59NrPS+yadAehwkQPLw3w2DVgIdD60/vYcda4TgQe5M/PKB+xEWQazVkJ7
	IFcVJbgl/JNKIL8s4WtQTOxA+S49Ezw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-YLVUkpnsNPCtpKB3dqe-jQ-1; Wed, 20 Dec 2023 11:10:01 -0500
X-MC-Unique: YLVUkpnsNPCtpKB3dqe-jQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5d12853cb89so79792837b3.3
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088601; x=1703693401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBF/2A/nktRQkyV9wK9FTmKMlXm8fHaSo0cgylBofKE=;
        b=AijRS9lEJmJZAEG3XgPGYc/lNyu8ZRJL/YqNj7WqVI4uMnpeEYOZ/uzqTgx0zE7jJN
         ea89fCc+Fm1ZRK4z/jhoVyL9oUEVo4L8KDqWgtOCeXjCzpwMpBKjAEMmgX3B6WatG+J3
         QyDhnRrdRrPcW5rlpBesf/Uk3FJRMOsEzEbk0s7ueKqyIDGcCHhuv8OeDzLTlGYN4n4u
         IvGhi69mHYyavhlrY3tqcHBu7npfY2/iMU8EQQdqxriU33LQtlPOmXSMAR68C6dRMUna
         yDF34cwUUlEld3Xd8C67BEkcXIwb6Ien1j2mn+3wBVdJurVOkR3MV/RyOADT/UA3kk2t
         W/0w==
X-Gm-Message-State: AOJu0Yzx170WVW8EIb5ZVRq1LjA1S9MdHZZg9hsLJQKDrMqiqmluZoH7
	rYuVQJPLj9XSGGruIo+caB4Wxrn+fafcDwa+CrwdoP9zyIc0yV+IzTK6Q4urh6sIhooJJSvb/As
	saxtzh05zhNkRjZcahneXTNKXcNgYGIgQVZX1XVL7CWRTV9l00ZR9foG63Q==
X-Received: by 2002:a81:4ec9:0:b0:5e5:ebd3:b1dd with SMTP id c192-20020a814ec9000000b005e5ebd3b1ddmr4627324ywb.10.1703088601327;
        Wed, 20 Dec 2023 08:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+IU3w6JnHUfVUtttpnXPZjgZ7nb7xBxPxfi9miRXjvISa+OseECRxvd3Zk1HEe8rGhYPjUps3bz6+ROD1cps=
X-Received: by 2002:a81:4ec9:0:b0:5e5:ebd3:b1dd with SMTP id
 c192-20020a814ec9000000b005e5ebd3b1ddmr4627306ywb.10.1703088601106; Wed, 20
 Dec 2023 08:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-3-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:09:24 +0100
Message-ID: <CAJaqyWeOJSne+qfj1pq_bgzML2Hc49MBCQm735fqrRThkeJAyQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
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

On Tue, Dec 19, 2023 at 7:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> The virtio spec doesn't allow changing virtqueue addresses after
> DRIVER_OK. Some devices do support this operation when the device is
> suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
> advertises this support as a backend features.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  include/uapi/linux/vhost_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index d7656908f730..aacd067afc89 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -192,5 +192,9 @@ struct vhost_vdpa_iova_range {
>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>  /* IOTLB don't flush memory mapping across device reset */
>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
> +/* Device supports changing virtqueue addresses when device is suspended
> + * and is in state DRIVER_OK.
> + */
> +#define VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND  0x9
>

If we go by feature flag,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  #endif
> --
> 2.43.0
>

