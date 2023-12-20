Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2B487AF
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1U/fhYu"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B05B54161A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:11:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B05B54161A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b1U/fhYu
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0zR2pMwguA2m
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:11:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0D7EE415E7
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:11:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D7EE415E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703088692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr8MPAJHFdPTjh5Rq/GtMEvXBHCwBjyrhMG94FUnKkw=;
	b=b1U/fhYu66uCQGwBIxKR5dd4lM1bDK8nHBTzpH6CnJ1Axu9GQLGc0EFmHl96qelgym9j9O
	ypG1aVle8c8xbB+zsesiM/ohC0E/Rwc3QT5fGaX8sz4XCGzELpNwa2rsfuLB+pK9jFG4JH
	+4Sp3z7pImnc4HoJ/W68o85kiu3ca/M=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-5eioRWx3MGaabOIEEAV4gA-1; Wed, 20 Dec 2023 11:11:31 -0500
X-MC-Unique: 5eioRWx3MGaabOIEEAV4gA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5e03f0ede64so81271867b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088690; x=1703693490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hr8MPAJHFdPTjh5Rq/GtMEvXBHCwBjyrhMG94FUnKkw=;
        b=ZpPeICUGdARcUl7tKFEj9hQArncEe/pt+ff6wyuCJ8FaGxWGf1+2BKFqTp+OIurSUt
         8jbFJChwlnbqX5C3WC6TGSZqm5ZQRZD93UqDbTjaD0bBmR9o5ZME9hEnIcVQ6LGLRZj3
         pgVsPfO7Jz4dmVhMXnIS0pjDQqUBvByN2AJtTMAKBatrpr79cK6W68jhwv1vz7bkkDP/
         L6IvyzNIggclIDMimFLf/gch+5c7JtTgVvpZJNyY7KrhW8CHSYmDZ4RBSILLM5s2Jn8m
         Xb16eLvpfNsi15mm7umWRZ7LMGT/MSH4dJQSho3Z035HjS70OLqU37Kl2CyNiBWX1VBX
         k8NQ==
X-Gm-Message-State: AOJu0YzC3HpfurrIq9tmM6CLnjdH6AvTj/CKyc8t/GuioSIDBb2QhQbg
	Y9n/NjlE7iV8bOrplvsndnZoG2QpVXTHNk3/e5p+E8IVnWAdSL30ieGm9NGCToBQEeC6bdR7+p6
	hY9pvY1K2cAG2Ug+ZJl0szOkwp76lNpsaNW/9pt2gIImqyfUoddAT7hnhGw==
X-Received: by 2002:a0d:c101:0:b0:5e2:51da:c3c7 with SMTP id c1-20020a0dc101000000b005e251dac3c7mr10305125ywd.21.1703088690315;
        Wed, 20 Dec 2023 08:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1/3P9BihNppwPcI9ZwmYIdbokvO4vu2D8gVryyj+uidHmGZ7fPxQNOeaB6BK51iRQjk9CdAWw+/VME/gOfzI=
X-Received: by 2002:a0d:c101:0:b0:5e2:51da:c3c7 with SMTP id
 c1-20020a0dc101000000b005e251dac3c7mr10305113ywd.21.1703088690077; Wed, 20
 Dec 2023 08:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-4-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:10:54 +0100
Message-ID: <CAJaqyWf7cVQ0VC2uLQPeP1B4XYCCQupKFcRFhpEge40=ci17zQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 03/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND
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
> The virtio spec doesn't allow changing virtqueue state after
> DRIVER_OK. Some devices do support this operation when the device is
> suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND flag
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
> index aacd067afc89..848dadc95ca1 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -196,5 +196,9 @@ struct vhost_vdpa_iova_range {
>   * and is in state DRIVER_OK.
>   */
>  #define VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND  0x9
> +/* Device supports changing virtqueue state when device is suspended
> + * and is in state DRIVER_OK.
> + */
> +#define VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND  0x10

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

It would be great to find a shorter ID but I'm very bad at naming :(.
Maybe it is ok to drop the _BACKEND_ word? I'm ok with carrying the
acked-by if so.

Thanks!

>
>  #endif
> --
> 2.43.0
>

