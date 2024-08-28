Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5517C9BA
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849992; cv=none; b=Z5R+zu2UFH/R8sMRCa01kKMiFk/bpxPTfy3NqDT6e5GCVgwhu6w9lPrQ2Plg9b+o77W+OsqtScoVddaQBBI0qe6xptsFZ2maPyv59NPQk9lRxxJSL+M/t2Kk0iSoVVRzZuy4nVMOMAfse1LvJpxKNFfbxXuOlBlpjXcC27483/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849992; c=relaxed/simple;
	bh=ymupMNvwNJBaMEUU8F78IdNvFql9A3Vo9I6iMpInMlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeOBn4MAjHSn64xf3NLPo9JmIE04NP2FMEEmSmr+C296Imanu4nxOrpJpClFRNDdz/eE/92mdrNHXMGSpkhrT2uq58CK8AGGwEHRHrGy6fTmjH/gUGOxoZuTIPblwmQmbSsTxz2LAwwwmaEVuWbVQB/0dA8TX394kFjlqNZqSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWuDo7Jh; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWuDo7Jh"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F74E406E1
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2V4cEpQue3Ac for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 12:59:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 60239406C4
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60239406C4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OWuDo7Jh
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 60239406C4
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724849988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3TUrO5dpGA8rfdSv1PfPK5BcATBwgN+tBNwuxtVK/c=;
	b=OWuDo7JhX2wL5qLAOc5ZxCKurL8wH2INEyYB7pRr7GHbFtS6TrcWXcM4OAk04RVUric9IZ
	MOGBNcKi4zeMGoPZTR/ZxbNY240aWbBmSLGalVUvGUaAY6JISyJ1bSpliazV/ozoQ39Aof
	oGlmyeyoabfqQgtRkSQ4j4P67CSJLa8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-xjJsE5d5OESPNy9Ota_fbQ-1; Wed, 28 Aug 2024 08:59:43 -0400
X-MC-Unique: xjJsE5d5OESPNy9Ota_fbQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6b3fec974e5so126756427b3.1
        for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 05:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724849983; x=1725454783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3TUrO5dpGA8rfdSv1PfPK5BcATBwgN+tBNwuxtVK/c=;
        b=DF+HHAZcLSAkeTMV1kwSAG5AvBIwOethw5StpMxI6JxueMzsM6g/Kj/S9fs4pMlfWl
         XtVl+2S/TDknebJbEEqZNRtmLulz6t+4Ph6Cp/r+gZ1RUxV64zi0v8jUVc54EdMgtS4T
         yJDPHWHnBDvQZZzpTEl7dMhLbewn47xJHoFdN8JG2ywdI3xNmhp5UvMKHb744UIkW5ut
         UF/sjhJ7xp3RkxhdTPb+bBSq7Scw+Fg6WgqYCY0lLjuatS6GuZC8lDgHILXnO5tUC85l
         VBiFHkytOcQgHwEm3L2gUwbOZpCa5767ah7yAqeqnyipF3imfN05NGprJyLtIK/LIPlc
         wapw==
X-Forwarded-Encrypted: i=1; AJvYcCVqd/5jKOtMmHOZNch+MYtVLeh174ZZZCD3zsYGnGYVwNLfnv1sZV50aWa3fXJv1xG2QivpGiIegIkSS0fLKQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz84bMW1NKUxH46JhU57aXYeGb/srhM5IlSReYpbA2v1U/yJmti
	Q7v1Ct9JbDEFm9TY9hxpk0bNmkn6V+BdeByiCpVf6MQ/4sZbp6Soa06rgd1cT8o77UrG3YnyNdM
	LereY1fjf3hPfWlqepogA0M7mWXctbRVwGAia/QQ4UWd0YywwsKlaKeT8TgiwwY0orB1xBQhbnY
	G0CzpYe9EwLGH7YfCoAwzR4z3K+y679gG/ropOGs9aqbdo8lv4NXYpLg==
X-Received: by 2002:a05:690c:f81:b0:6cf:8d6f:2c17 with SMTP id 00721157ae682-6cf8d6f330bmr82005047b3.8.1724849982820;
        Wed, 28 Aug 2024 05:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgcU387IxWPo4yekqWXqtNg5KIt51AsXE5T6bzQ+TasCLXcyqT2oXqmZTLQUlKNBz+CaTjn6pYNY9IaOgUuYc=
X-Received: by 2002:a05:690c:f81:b0:6cf:8d6f:2c17 with SMTP id
 00721157ae682-6cf8d6f330bmr82004837b3.8.1724849982531; Wed, 28 Aug 2024
 05:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <20240816090159.1967650-11-dtatulea@nvidia.com>
In-Reply-To: <20240816090159.1967650-11-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 28 Aug 2024 14:59:05 +0200
Message-ID: <CAJaqyWd0Gwap1253WegSHSADw2ymZ81vvwuTgVMCTSH5-gddbg@mail.gmail.com>
Subject: Re: [PATCH vhost v2 10/10] vdpa/mlx5: Parallelize VQ suspend/resume
 for CVQ MQ command
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Tariq Toukan <tariqt@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:03=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> change_num_qps() is still suspending/resuming VQs one by one.
> This change switches to parallel suspend/resume.
>
> When increasing the number of queues the flow has changed a bit for
> simplicity: the setup_vq() function will always be called before
> resume_vqs(). If the VQ is initialized, setup_vq() will exit early. If
> the VQ is not initialized, setup_vq() will create it and resume_vqs()
> will resume it.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index d1a01c229110..822092eccb32 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2229,25 +2229,27 @@ static int change_num_qps(struct mlx5_vdpa_dev *m=
vdev, int newqps)
>                 if (err)
>                         return err;
>
> -               for (i =3D cur_vqs - 1; i >=3D new_vqs; i--) {
> -                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
> -
> -                       if (is_resumable(ndev))
> -                               suspend_vq(ndev, mvq);
> -                       else
> -                               teardown_vq(ndev, mvq);
> +               if (is_resumable(ndev)) {
> +                       suspend_vqs(ndev, new_vqs, cur_vqs - new_vqs);
> +               } else {
> +                       for (i =3D new_vqs; i < cur_vqs; i++)
> +                               teardown_vq(ndev, &ndev->vqs[i]);
>                 }
>
>                 ndev->cur_num_vqs =3D new_vqs;
>         } else {
>                 ndev->cur_num_vqs =3D new_vqs;
> -               for (i =3D cur_vqs; i < new_vqs; i++) {
> -                       struct mlx5_vdpa_virtqueue *mvq =3D &ndev->vqs[i]=
;
>
> -                       err =3D mvq->initialized ? resume_vq(ndev, mvq) :=
 setup_vq(ndev, mvq, true);
> +               for (i =3D cur_vqs; i < new_vqs; i++) {
> +                       err =3D setup_vq(ndev, &ndev->vqs[i], false);
>                         if (err)
>                                 goto clean_added;
>                 }
> +
> +               err =3D resume_vqs(ndev, cur_vqs, new_vqs - cur_vqs);
> +               if (err)
> +                       goto clean_added;
> +
>                 err =3D modify_rqt(ndev, new_vqs);
>                 if (err)
>                         goto clean_added;
> --
> 2.45.1
>

