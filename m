Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850814AA4
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fGzs/JmH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8463660E1B
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8463660E1B
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fGzs/JmH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tqUhuNzKE9wS
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 03:47:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 57D6460DFF
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57D6460DFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9w+rATDkUtjVeCwGcF601wo/RABwY+YM2dZRh5W8pOM=;
	b=fGzs/JmHb4VQNOWJF8CtyexwLFIWZhHq21jGKhW9Tpmf2u0Bv0CjK2nq/dy19VZ1mvRGU+
	swUh0T/hEqy1k0yH9KM72MuoBzkmjWMSCloGI0zBfp3JRhrPFZcHKXMW5tLFuZhJEVSYU+
	BbSNhT0aF8aVCSF/VFcGx2OjIAmbveI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-X0oTZAluMW6DrHxYSszvow-1; Tue, 19 Dec 2023 22:47:06 -0500
X-MC-Unique: X0oTZAluMW6DrHxYSszvow-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9f0dce5bfso7242301b6e.3
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044026; x=1703648826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9w+rATDkUtjVeCwGcF601wo/RABwY+YM2dZRh5W8pOM=;
        b=ZziefWtxmmHFQK/IlQRN2bgbETykjuCz7Kgsc9nnJDtecscgjPRHP5GYy0pQcuijtL
         dL8s/q/GBBA2SjdfI3f8dVxXXzfhs+9xC1/JIZ3AuVwg35w9zS+VG4yUntAXCe3HBUQ8
         qz/XIWjSBQvlPPsNXP5XEiFVVQaDPaQy4xdUHjPBsl3piHudLlAIwOIV2RwVHNjcxlA/
         xRhuv2g7bsSMaytxJRr+xYVytQQ3DxtRMbz6V8FuGJhb5FwnkembChlMBT2i3d0/GjTQ
         5kgen7JSVXykAx0VE5I9trX0ikEPrYEXJK1YQk9VW6s8tWoDUbdIPyJReylK1RpZsKlP
         WGwg==
X-Gm-Message-State: AOJu0Ywa+ouUpwyJfoqZyRpDbVFn0FutjglTRU0/aBx0t3siwf9LDhIe
	BLC6zutc+uNMJyGCq8n83CQIuop9G1AAVN/TwSXhFFrs2K511yDQfKBdbUNMAQ1lZP0k6muRC2H
	hBk/MmdkN73qN/Ysp8zksxJQRvc8Ek6UMVXQUAiuU2QG+qWpq/bnKzXhjeQ==
X-Received: by 2002:a05:6808:f91:b0:3b8:b20d:cecd with SMTP id o17-20020a0568080f9100b003b8b20dcecdmr25104414oiw.32.1703044026078;
        Tue, 19 Dec 2023 19:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN31V4IDc9YdM/jG9vbcC5ujWxgZW0OEmEotp+PSSsAUbfJELk/1CFnUoFJlwk0MWCN004qTKhi5PhO5Y4oo0=
X-Received: by 2002:a05:6808:f91:b0:3b8:b20d:cecd with SMTP id
 o17-20020a0568080f9100b003b8b20dcecdmr25104401oiw.32.1703044025883; Tue, 19
 Dec 2023 19:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-7-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-7-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:46:53 +0800
Message-ID: <CACGkMEs_kf2y9Khr==zY3RRHffaPRwS51XK33Lgv1eeanQdRpg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 06/15] vdpa: Track device suspended state
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
> Set vdpa device suspended state on successful suspend. Clear it on
> successful resume and reset.
>
> The state will be locked by the vhost_vdpa mutex. The mutex is taken
> during suspend, resume and reset in vhost_vdpa_unlocked_ioctl. The
> exception is vhost_vdpa_open which does a device reset but that should
> be safe because it can only happen before the other ops.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b4e8ddf86485..00b4fa8e89f2 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -59,6 +59,7 @@ struct vhost_vdpa {
>         int in_batch;
>         struct vdpa_iova_range range;
>         u32 batch_asid;
> +       bool suspended;

Any reason why we don't do it in the core vDPA device but here?

Thanks

