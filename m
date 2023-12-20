Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A0200BE
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoVBXp1a"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4520783260
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4520783260
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BoVBXp1a
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bUApE6xlIZKg
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 03:47:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8671682C61
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8671682C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeRKaaUGMF/rV1Pw2tqp6lNgEKTL5KPcCr8EDMoKMeM=;
	b=BoVBXp1aSRuYG6C7ze3k3Yd3ctOJK2iBDudvgG7XHsgESZ+SRzWqki6ANfZuOSGlfdmjLQ
	MYSmgshA0XmnkBM7WA821on6m8z9qpLuUZXSZWilWv/jALwuctlZY5iUfp+PgmCfs8lIm1
	FWpZ5eviBUjrsI0bOU0IaVcUoKLPZWI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-WSoySObPMiO6REJ6O3o4ig-1; Tue, 19 Dec 2023 22:47:20 -0500
X-MC-Unique: WSoySObPMiO6REJ6O3o4ig-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77fb91da85cso761788185a.2
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:47:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044040; x=1703648840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeRKaaUGMF/rV1Pw2tqp6lNgEKTL5KPcCr8EDMoKMeM=;
        b=E4eOGFGuWWjyIiUWjvj2fmmz3LB32hM/D4BsrlpMPW7EJYfgLxAAf4QBa7XlvUYw/f
         bQIVl/oQPLaJA/NzH5ikqcm8vhWZ7VA+eFrgp51ucL5BjsFf4SM3g3byCH4Ez5CiHIS3
         ZozCyRQDA3Ea/ilwCGbJQbZTIkl4b3CTHlhhc2egE7gk9jwe6nFEOHkZguRIVXmLZtpr
         NF2sBz3bexEGsV+coSRnG+K55ev48+s5OzaTIY2wzECBW3o4dR42w27ZirWJuAexFCoH
         0kPyEYT3N6y49f0YBLOs/w1bHjRzg7vjbJ6hDi/JxqdlAjZu829GZkmBqebbZoRnbeRb
         BVWg==
X-Gm-Message-State: AOJu0YwbykniTLOBX8kGBxDe/jo1ERA8GAHYsYY2DmiiyKMpF7g2xLKS
	NonIzhAeF7VYa6bbuoftysThj9pxoWjVVOFGsc9tB+at343h9DEN/r0Fywa57Iur1l/8QorLcl+
	y5EMT17C9sDWoRVnv1R9ySN08ASlaOvJyPGfaFtXBhrieqZdkgAvR/2R6ZA==
X-Received: by 2002:a05:620a:1025:b0:781:2e4:a333 with SMTP id a5-20020a05620a102500b0078102e4a333mr1851796qkk.101.1703044040366;
        Tue, 19 Dec 2023 19:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2eu48vysOQiZNwVknIUUkOGzk8lLz1dfUfotvXOLhv6Vyvhvaja8sHuwdb2gwij5dOp0VLjJ8belHFZFJh4k=
X-Received: by 2002:a05:620a:1025:b0:781:2e4:a333 with SMTP id
 a5-20020a05620a102500b0078102e4a333mr1851780qkk.101.1703044040147; Tue, 19
 Dec 2023 19:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-15-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-15-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:47:08 +0800
Message-ID: <CACGkMEtMkjORddUC4x+O9JsDevQBpo0KiJu1XCcvxgKgqfXuGQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 14/15] vdpa/mlx5: Introduce reference counting to mrs
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

On Wed, Dec 20, 2023 at 2:10=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Deleting the old mr during mr update (.set_map) and then modifying the
> vqs with the new mr is not a good flow for firmware. The firmware
> expects that mkeys are deleted after there are no more vqs referencing
> them.
>
> Introduce reference counting for mrs to fix this. It is the only way to
> make sure that mkeys are not in use by vqs.
>
> An mr reference is taken when the mr is associated to the mr asid table
> and when the mr is linked to the vq on create/modify. The reference is
> released when the mkey is unlinked from the vq (trough modify/destroy)
> and from the mr asid table.
>
> To make things consistent, get rid of mlx5_vdpa_destroy_mr and use
> get/put semantics everywhere.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

