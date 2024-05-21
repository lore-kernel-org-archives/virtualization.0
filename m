Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C212E71
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258771; cv=none; b=Z5QXXYQuILX+Y3ckmV1PO50MxsvlNzOvyEzPFszP2B7l6gXF8f0LrYEHlp2M36ybgXXb9LQ7UugdqrKzXyIfr6SJybjOapHJoKJZSg2OqUSB3q8J3+6ZrIG9zP0ckmlHen9PwJBbyHfkSug9bvKcRHImLuVgsWJycPBAVhOIsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258771; c=relaxed/simple;
	bh=dhRjjEcWzIW5IuAVkeI6OtRR/mPN6j0nB2JMIXUDHl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+lMOjcpVghFSDseQmwhN9Mb93YShn1Xb43bsBu8IbKiuOfCtsc1vDFz7RLs+FGEH25QF1oMNtjHjy54nnKgzSlhe9zKGelH1aRXvAAzx+xXeExWYRD58al9vvBWG/TE12Ay1/zp5S2UceEgx9SjF3tWSOmKLZj/Rn8y4S6VFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ga2oW15x; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga2oW15x"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4B9F404C5
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:32:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHnel-144gnx for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 02:32:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 838F04035D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 838F04035D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ga2oW15x
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 838F04035D
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZYyiqrniwdjP/E0uFE4XEuFX95Nzf5hidJoaA2dd3w=;
	b=Ga2oW15xQNDZ+hEQdmA6xbqC9HsHBY/L50TuZpeZxrYpkJEcRpExq4s3gb9WnqinHkY+Q5
	LsNG4f9RWSE7u/RmWqiq4SXIiSqf2qDSEe56O781x8WoEXNgsGp8c4g5cnmWoMXlPc3yWI
	MIaiVwx4BkkZWeII75CJugpu9p3HEhk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-mvqkD2ZwP-yE6xr2431r6w-1; Mon, 20 May 2024 22:32:45 -0400
X-MC-Unique: mvqkD2ZwP-yE6xr2431r6w-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f449ea6804so13031956b3a.2
        for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 19:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716258764; x=1716863564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZYyiqrniwdjP/E0uFE4XEuFX95Nzf5hidJoaA2dd3w=;
        b=qf2kNYYxu6NwPSSBNu1k2xBEIytFgk8QODJ261/BVqYEFXkagS6DHpyQRbg0cvMpOY
         HTzweO3zL779YPi6ugNlNjO7kgMo2ox8lncDfzp8VXbcFxUgqj2oO7dMp7XMFe9mIgrZ
         Ps6rWPXJ9DTSF23QKuTtLCDjTc9JjAEtsvRwalGEjibdcbzc14TArcOBAcn6tJwgpemM
         CbYZf/1dgphvJYtLruJGXl2jSIs2T1lc9CtLEFnKNNEC53fEAbdx4ylsAyvUVp7NPF6m
         hIa7wfShu5pIiliUbEf1w/vGQjoJtzFE+uUJZnJOTNkBeGchUPwvOs339omnP+OsQU/J
         hVqQ==
X-Gm-Message-State: AOJu0Yz6grG+udVTNb9vPlI9PuY6ger4neY3QlQJ+OiiHsN1Bd+19r9Z
	uG6GgNSEEU1zETfVVYQ1WExVNy6Ozgsu4N1tXPSutz78mFIG16wP5KaCrXqV5unyXKHRFkXkpxo
	gCc3PjVyPeoMq9VFoYNO4mhEwt7riAlJbS9CfqGkMAP4qA1tmhrqw62mxDKUwE4VyU6FP9bqF1M
	ZIpUE4Kim6lzT3G80pNbcEi5aLFhlzmiXUu+t3aMj5I+wD55Uh+PQlSg==
X-Received: by 2002:a05:6a20:9195:b0:1a3:b155:1cd2 with SMTP id adf61e73a8af0-1afde0a9c56mr36384180637.10.1716258763751;
        Mon, 20 May 2024 19:32:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr2sWk1bvHi3YU4qBFQlqFEE+X7oAHBNjrFbrHBEoUDoyA4HuyxRx/H6KHE2tjsD8R1nCScvMy8Rvhc1xYJy0=
X-Received: by 2002:a05:6a20:9195:b0:1a3:b155:1cd2 with SMTP id
 adf61e73a8af0-1afde0a9c56mr36384160637.10.1716258763309; Mon, 20 May 2024
 19:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com> <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:32:32 +0800
Message-ID: <CACGkMEur=CoU1GgxNdweu-SfuutSN-a+LaHLkdtoWYJMnE+LOg@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] vdpa_sim: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
<steven.sistare@oracle.com> wrote:
>
> Flush to guarantee no workers are running when suspend returns.
> Add a lock to enforce ordering between clearing running, flushing,
> and posting new work in vdpasim_kick_vq.  It must be a spin lock
> because vdpasim_kick_vq may be reached va eventfd_write.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 16 ++++++++++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 8ffea8430f95..67ed49d95bf0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -322,7 +322,7 @@ static u16 vdpasim_get_vq_size(struct vdpa_device *vd=
pa, u16 idx)
>                 return VDPASIM_QUEUE_MAX;
>  }
>
> -static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> +static void vdpasim_do_kick_vq(struct vdpa_device *vdpa, u16 idx)
>  {
>         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> @@ -337,6 +337,15 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa=
, u16 idx)
>                 vdpasim_schedule_work(vdpasim);
>  }
>
> +static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> +
> +       spin_lock(&vdpasim->kick_lock);
> +       vdpasim_do_kick_vq(vdpa, idx);
> +       spin_unlock(&vdpasim->kick_lock);
> +}
> +
>  static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
>                               struct vdpa_callback *cb)
>  {
> @@ -520,8 +529,11 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
>
>         mutex_lock(&vdpasim->mutex);
> +       spin_lock(&vdpasim->kick_lock);
>         vdpasim->running =3D false;
> +       spin_unlock(&vdpasim->kick_lock);
>         mutex_unlock(&vdpasim->mutex);
> +       kthread_flush_work(&vdpasim->work);
>
>         return 0;
>  }
> @@ -537,7 +549,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
>         if (vdpasim->pending_kick) {
>                 /* Process pending descriptors */
>                 for (i =3D 0; i < vdpasim->dev_attr.nvqs; ++i)
> -                       vdpasim_kick_vq(vdpa, i);
> +                       vdpasim_do_kick_vq(vdpa, i);
>
>                 vdpasim->pending_kick =3D false;
>         }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdp=
a_sim.h
> index bb137e479763..5eb6ca9c5ec5 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -75,6 +75,7 @@ struct vdpasim {
>         bool pending_kick;
>         /* spinlock to synchronize iommu table */
>         spinlock_t iommu_lock;
> +       spinlock_t kick_lock;

It looks to me this is not initialized?

Thanks

>  };
>
>  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> --
> 2.39.3
>

