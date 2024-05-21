Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BBBA53
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716258678; cv=none; b=s/769PuLAVpa5m/t6f/EQFg7y1qIzitZLRR2PN8JTeUeaKJoQm+Z9sgAUkAM54dXHM7tflvD18gjsUt+fG6ytDbNfS9y9OaEJGpumQHmxmXd1l4VuKKokDcSO2FHzbaaQjFvCSGBmom7SeKVzJ5mPyUiXgsN9H0Up6BQQYQvmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716258678; c=relaxed/simple;
	bh=i7+CWO/0II/UI8CKSRz7fLVDbkwJxrROTMfRJ5aptBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OB2C+ujD7c1rxpOew8jP0s2bjkNFJIf7Wki5QGZg0Uewnd6PRy9ddx5sdGzThFDJ2YqC73TnWDOeP6rL5GsfYoV5JtIT1lbyrAp+kCLsanLehYqUWxe+1lRMeS33DP4sAEUJUkU88beOG/lQ444Yls6ZEflErTWTony3Ep17AFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GygLXg+k; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GygLXg+k"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 703E3605D0
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OU2C2l2ocUte for <virtualization@lists.linux-foundation.org>;
 Tue, 21 May 2024 02:31:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A3E54605AA
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3E54605AA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GygLXg+k
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3E54605AA
	for <virtualization@lists.linux-foundation.org>; Tue, 21 May 2024 02:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716258674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snWeVoOnPaLJ29g9hTUZ+NC9NK6zSoMxNiCQ357kDKA=;
	b=GygLXg+k8/WwipvEO346YAGgsqUgS8iJuo00D8ZjTH3C9Ubc++JeBGWvenxTEFnFbjOOGI
	XkOs7At3BVVjBzq5ThtkDfXpbsos7yxI9+Nc4AV40hOnhKKquJ+4BRSDad2WQkOEcZJx+Y
	xKlZgcmrRCmi3SUkRCqj70XJJ2gjMlY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-8yy6tQf4OOWrn8G3g2-5jA-1; Mon, 20 May 2024 22:31:12 -0400
X-MC-Unique: 8yy6tQf4OOWrn8G3g2-5jA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b33fb417f3so10343984a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 19:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716258671; x=1716863471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snWeVoOnPaLJ29g9hTUZ+NC9NK6zSoMxNiCQ357kDKA=;
        b=T8lLrqF0HYJczKHVyYdSFdE1+fgxPNcLozY/slcBs4jmS8ISIp1MzHOVDLEo5gGyEo
         JOUTMaQMOaCqApXV58X5HUz8u/nUOcn+vO3iZTkwN1kIBBKPePSNpdnk1M3jCMGmXN7I
         u4bkFxUQQqCaAkEWqc47acjuRFH8xlNCs2ldZ7iIPFfpAvT3t2uYou0NEuyzwt3vxALq
         pKDB3h6Qtwl+K4vjd5Q7wf8WzeiJOSKNM26vpLsRP9rvk0yCu0lVNGdDE5zbRd0pxyvi
         3PdAtMO2ihOARWKrvHSX/1Bne9S2rPwMCde4hmPLQPsPMUVv2PFIPxPQQ3Sy1biFcFC5
         NEVQ==
X-Gm-Message-State: AOJu0YzXuuq6KYA0J3LE5kP8r+OaUKkIYOXT5L3kMo6gVIhUKeP5Ne4c
	FRS3aVUObaMAzrW24P+4fC97x5gA36p9dQi/ObDVcth0XuP4C764gqcrjHLcjd0kDf1PY9IpFPo
	QhJLqegO1zWrMcSf8BQc3e80h6wbD5PJBDRHfjFeF6tZoj68I36g2Q7Usq/poqsSxf40OjWRQ0z
	LhAOVT9utTKzIHoHLRYKbbYDRT7BXU9vtdfUkWAFOVzjUjT0UgAfhRKQ==
X-Received: by 2002:a17:90b:3882:b0:2bd:7a9a:658 with SMTP id 98e67ed59e1d1-2bd7a9a3896mr4030735a91.41.1716258671405;
        Mon, 20 May 2024 19:31:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAwbDe2Uec41b+43t2LmVdBeOsfakB9vtDjODRX2S0bWBrCE8IcUuNeKzeWpGTZXIf0gukWjH8XSFm8luO0vw=
X-Received: by 2002:a17:90b:3882:b0:2bd:7a9a:658 with SMTP id
 98e67ed59e1d1-2bd7a9a3896mr4030716a91.41.1716258671032; Mon, 20 May 2024
 19:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com> <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 May 2024 10:30:59 +0800
Message-ID: <CACGkMEtfjHzdBBwgUWgRHDc5opekvgTuXp-_z4ku6L5cqOeAJA@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] vduse: suspend
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
> Support the suspend operation.  There is little to do, except flush to
> guarantee no workers are running when suspend returns.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 73c89701fc9d..7dc46f771f12 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -472,6 +472,18 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>         up_write(&dev->rwsem);
>  }
>
> +static void vduse_flush_work(struct vduse_dev *dev)
> +{
> +       flush_work(&dev->inject);
> +
> +       for (int i =3D 0; i < dev->vq_num; i++) {
> +               struct vduse_virtqueue *vq =3D dev->vqs[i];
> +
> +               flush_work(&vq->inject);
> +               flush_work(&vq->kick);
> +       }
> +}
> +
>  static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
>                                 u64 desc_area, u64 driver_area,
>                                 u64 device_area)
> @@ -724,6 +736,17 @@ static int vduse_vdpa_reset(struct vdpa_device *vdpa=
)
>         return ret;
>  }
>
> +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
> +{
> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> +
> +       down_write(&dev->rwsem);
> +       vduse_flush_work(dev);
> +       up_write(&dev->rwsem);

Can this forbid the new work to be scheduled?

static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
                                    struct work_struct *irq_work,
                                    int irq_effective_cpu)
{
        int ret =3D -EINVAL;

        down_read(&dev->rwsem);
        if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
                goto unlock;

        ret =3D 0;
        if (irq_effective_cpu =3D=3D IRQ_UNBOUND)
                queue_work(vduse_irq_wq, irq_work);
        else
                queue_work_on(irq_effective_cpu,
                      vduse_irq_bound_wq, irq_work);
unlock:
        up_read(&dev->rwsem);

        return ret;
}

Thanks

> +
> +       return 0;
> +}
> +
>  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> @@ -806,6 +829,7 @@ static const struct vdpa_config_ops vduse_vdpa_config=
_ops =3D {
>         .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
>         .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
>         .reset                  =3D vduse_vdpa_reset,
> +       .suspend                =3D vduse_vdpa_suspend,
>         .set_map                =3D vduse_vdpa_set_map,
>         .free                   =3D vduse_vdpa_free,
>  };
> --
> 2.39.3
>

