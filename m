Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1721C29
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J65KTxUr"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09F0343791
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:09:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09F0343791
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J65KTxUr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shxZ9Cqy934T
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 03:09:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A88C43666
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 03:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A88C43666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704942575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sC5e9WRB2cisP0/PxP21NqudRB4e9ferLpZ3ANHXECg=;
	b=J65KTxUrnIDeApy2MKucoyjaQYXQigoihm0jsPvHRrg8phIgf6xLcvgDHFoNr0Hv4DLeNm
	R7At/iULwHdVCLRLmdvy2fwyc/+v3B0arcqbZT8sv/RNj11YHJQtL3FCKxoSAwuLi6fSO8
	Xk1iLBMFt277qsAaDGTOZyDhEPmieo8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-7Zj_f7PgOFaACR3mHXSNKA-1; Wed, 10 Jan 2024 22:09:32 -0500
X-MC-Unique: 7Zj_f7PgOFaACR3mHXSNKA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dde701a6ccso2543320a34.3
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 19:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704942571; x=1705547371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC5e9WRB2cisP0/PxP21NqudRB4e9ferLpZ3ANHXECg=;
        b=DaQzb7tdxshiDzMKlOQ0N/R07JuqShsu/NVgpvhcQqewY5Jf9iyByuPrwTc5y6L02N
         7oBkRncr/8ldFjHz0WiQorTSeoNxOuMrk30imREhcjLpHA2dPTAcbVPYKOps8JvTqtNH
         pHwoGJz2CyXyBz9bAquYU/HCdd4lLfNBe86hD66nV9WbZJ1age1Ag2klAYtrJvc2cazV
         1zZDynUlFNEkuxxUzhomYk/8AIODY/XsoEJvyB+ywuPCS6xTf7K4Da9rmvuYZ+bS9sNH
         kWMPHkUQ4RuBltPV/qIcLBpJR84KLOMzTlHSoZg7hty9+0jjQAO6XIuU9hiL1tAH/sIr
         1N/w==
X-Gm-Message-State: AOJu0YxTrITKlIKhDuJvs58ePDgd6CRuUShBNjL1IaHRBjPmZY63jGjR
	jry9wW18PWwu9bIpD9NzxA3cMc8nYPXECigLPCZ9pGCVoMnR7ybq1cRy34ZJTDL/J1aMaeRss/H
	sk8Uqr2DYKNz+tdDeL+jb7a2Q2+edHoWGiNTIdxcyTMNaw6/ilaC702Wc8gV5gqpYPA==
X-Received: by 2002:a9d:7f82:0:b0:6df:2c26:c5e with SMTP id t2-20020a9d7f82000000b006df2c260c5emr179203otp.31.1704942571527;
        Wed, 10 Jan 2024 19:09:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFrnXhh1+r1aWEfuOYbZcJQnI9BifUyc1+kAgcYl0a9OJPFVe8flUkKOSFk4S22VkfZnW1C8f7ecuVkPK1LjM=
X-Received: by 2002:a9d:7f82:0:b0:6df:2c26:c5e with SMTP id
 t2-20020a9d7f82000000b006df2c260c5emr179189otp.31.1704942571315; Wed, 10 Jan
 2024 19:09:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-8-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-8-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:09:20 +0800
Message-ID: <CACGkMEv8TXXTrCW=hf1sJ+V2a0eD3w1b1Yub4FnGZ0=Du-RbtQ@mail.gmail.com>
Subject: Re: [RFC V1 07/13] vhost-vdpa: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>, 
	Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:40=E2=80=AFAM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> To pass ownership of a live vdpa device to a new process, the user
> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
> mm.  Flush workers in suspend to guarantee that no worker sees the new
> mm and old VA in between.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vhost/vdpa.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 8fe1562d24af..9673e8e20d11 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -591,10 +591,14 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v=
)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> +       struct vhost_dev *vdev =3D &v->vdev;
>
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> +       if (vdev->use_worker)
> +               vhost_dev_flush(vdev);

It looks to me like it's better to check use_woker in vhost_dev_flush.

Thanks


> +
>         return ops->suspend(vdpa);
>  }
>
> --
> 2.39.3
>

