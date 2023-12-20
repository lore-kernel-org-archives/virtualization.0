Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DB1F5F5
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMHVnsUt"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D756A4090D
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D756A4090D
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMHVnsUt
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wmAnyWzm_Rgs
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 03:47:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ECAB74011F
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 03:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ECAB74011F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXT8y9tlblfV00CjChE7U+F283GXLav1fpyYasxi31k=;
	b=aMHVnsUt1/bOLudb/os4Mb/68bsPqJ6iTGCmDukE7FnDsJNW9tcY+XsKOirBSOcgP+H7p0
	ZBdqSwusPkXAuZRmh6mOXuNTZmFRqAT7L2k/KlJg7SK7kmTzk1Kf3Gkh/IEjRAo0Jw9AW2
	iSw34WuxUhUmMoSByNozU6nod53Db+I=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-H_oVEG6VO6ahMpvOLITTMA-1; Tue, 19 Dec 2023 22:47:18 -0500
X-MC-Unique: H_oVEG6VO6ahMpvOLITTMA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5919d9e57a3so5289102eaf.1
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Dec 2023 19:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044038; x=1703648838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXT8y9tlblfV00CjChE7U+F283GXLav1fpyYasxi31k=;
        b=MpJR7+qq/W0sxZN70Ijq6CgTfCYo/yKO6oD4baa/HnSyCuIegU0okBkhO5YFk59n0T
         Nb1RW0m8kwSXc1d/lqBIyzatXbMGnUsYoUz5QnnJtSLaHXULYyJmVGFDiMfPRjJC8qTg
         KhoNrqhj2bCu3Ufi5tA/kQg/eLC5ZUA5GF6rSz3FbRUklpJ86jlB8VxMjWh4qrmZMkew
         +3XcPzNsMlMcUA3oeLypyNgifwUQBEdFTnDKk7rOViZ4AKQzCnad97VOH9AEcS26+XkQ
         n5zb2H7+ILrBDa0gEMeHq+SmaJNMW/nrtutf6Y7u5HKlvnryXHism8Ekn0xy5VRnHizY
         Nr5g==
X-Gm-Message-State: AOJu0YwpFyn2nuTMOw/wRZ/aqA3hIzZnBJhK2R835hmQRTqKkB1vN7GT
	bJz8AlS3bLIjxoxYqKvoDJLvZmbODKUValEhtnIr4s+YT2+J2BNVOkV7GTcBKlsvtT0b+zscISv
	/VPWwHlHPDuQ7VfKsdf/gk9iF8G9YcCW4++leEUeZTW81jRU2jwttxeRo8w==
X-Received: by 2002:a05:6359:6a6:b0:170:406d:42e7 with SMTP id ei38-20020a05635906a600b00170406d42e7mr18126797rwb.39.1703044038238;
        Tue, 19 Dec 2023 19:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ0zz4zEAWU43T+4oCW+F/doXzW3xC/zXGOAN1e58DPokWZLVU/waMdMYVR9sY2LCmHpV9lPtvyLyHoo9xicM=
X-Received: by 2002:a05:6359:6a6:b0:170:406d:42e7 with SMTP id
 ei38-20020a05635906a600b00170406d42e7mr18126783rwb.39.1703044037924; Tue, 19
 Dec 2023 19:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-14-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-14-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:47:05 +0800
Message-ID: <CACGkMEtbGurh-HUb3eDcH74y7YDnvd06K8=MvRHj+4NLyaJ3Ag@mail.gmail.com>
Subject: Re: [PATCH vhost v4 13/15] vdpa/mlx5: Use vq suspend/resume during .set_map
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
> Instead of tearing down and setting up vq resources, use vq
> suspend/resume during .set_map to speed things up a bit.
>
> The vq mr is updated with the new mapping while the vqs are suspended.
>
> If the device doesn't support resumable vqs, do the old teardown and
> setup dance.
>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

