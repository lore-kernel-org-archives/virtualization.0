Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011343F7892
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194917; cv=none; b=aRsVa8djMLDlfTr8DmwH8Z2EMqxbahZcanizbyRfe5hFjoZQoN2isSohS9GkEMRvPAxLqSwrzYnyIZJ8X0fUrBpJY2TWbiJY6AxfY+MDbGxrN/OVSkid9NUqhBCa+O8GF01VrqsmjIN5l8y9GkQxBAHhWiCnAJzZ41QVidUx8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194917; c=relaxed/simple;
	bh=LqqsdM1x0Zd6TudpeBiM7tPh+032sxPHxb49LL/o6kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWfJbivUTEbJAG80D8PCCgbX1kFhEWQdLdtTGIlxHo4R9LmKE4Q8OP2yuMF49eufZ5GYX+OTb/Z0adjNRromSnVJHadZKSKFh0kqBVY2xvmuoRgslHbCNilgYskfMquFP8IOqQhuEgiTrSpPhQCgiAfGRMA92VU6yPvM1HhPcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1f9jGbM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1f9jGbM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784194912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
	b=G1f9jGbMcwFJ0tDY9Df77AdUu0mrCFca2RyaslpcWANFnOTI7eXgBB+bNLXiG6fkGYKvcP
	PB1An7YaqVkVZmCznOIRqGnu8gBhtDTjX8WE0JiwWDDXgxvhNkgomJR8gG6uPPtPWVqjss
	IxFcn34Oj/sOIh7m0veu/Sz/oThzbJU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-F8tV9FAmOhubterrVlFiAw-1; Thu, 16 Jul 2026 05:41:51 -0400
X-MC-Unique: F8tV9FAmOhubterrVlFiAw-1
X-Mimecast-MFC-AGG-ID: F8tV9FAmOhubterrVlFiAw_1784194910
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e92ddc199so139241517b3.0
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 02:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194910; x=1784799710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXu8rj/Lq4zKxTkQDISmUqipyXnuZss0b7jMIW5OWBE=;
        b=PdrE2Q9CIaNVPuWgKheMTpoNAHZMtnBZhiY79bveiG++NT3lRWMYQe+cRF6w5vgj+7
         i1nLJR/FxTXLsoTtO80qwF5Q7FEpwvOfoPH6x72gaI0oMIA4KY6qiSITEcf4sGl6lIC+
         LEZ2s61LTlKK5OZOMBkiusbpyaS14I9Oe1B7mj9w95xmqB7ZKz91GcwwS8/Vx8TrWWMe
         0HgLb8i9/EWAlr4fLTGtNJy6j2oLGV1GtCeWV2xxlSJ76aBdrPJlcUGA9Ue1h1za+byP
         PguHM8FOv7AbIw/bM+rv3DnQ6S1LQvAHfVwEBzd3LYJzGtTL1GMO3Q9gdHapA2htWJgi
         0AQA==
X-Gm-Message-State: AOJu0YwzWGUXI38aViiycgTKgJWho1nWW8LfUb50/CdXtSR5gLe1wmP9
	PgOUeB96OYVkWmS8enuUKE+722jg+G0/ErSVn167K7j5L4Gi/WwWG9gJjNbR30Azj7qCxyA8jaA
	6fJmq9qMS7hyI1Pja0b+FAAK24tpmFJXux74q7m8tD13R+2GwR4XbfGsJGYFLXRuuE2IRKzSHRA
	pnyyMDwztQvxTrA6hdq7rFgxvXMw2wl1hLZJzy+9RFshk=
X-Gm-Gg: AfdE7cnMicP40QSGzR3tDYSeEFSOteHXHGSmzdwwlMENTpRKbrLaYe+j/9jD6KJThW4
	eZ6j6dfNM9VHwBA7XZprWHaIQvuUyyzosAvX8vgvDsWy8h7rK1SzNSTO/SlbzkdE0ZHMRybXpCm
	HMsHawyJngGrQRihxUrRmX6CKgbKe/74Dungzt0HOMxqQSm1cEQbgJB1EXp+Yc/HY5KpnhuPNVp
	/IoaWnvKikxrNre0H7u2ZlNoHkHLSBE8ipueljIBlq3SmDWJ9AV6IUiSV3x15y4Q7QBkChhHs1p
	ieoZr3yyX1F69PI=
X-Received: by 2002:a05:690c:6a12:b0:809:fd83:a88b with SMTP id 00721157ae682-81ebfda0fedmr73234467b3.3.1784194910347;
        Thu, 16 Jul 2026 02:41:50 -0700 (PDT)
X-Received: by 2002:a05:690c:6a12:b0:809:fd83:a88b with SMTP id
 00721157ae682-81ebfda0fedmr73234217b3.3.1784194909834; Thu, 16 Jul 2026
 02:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260716030236.124322-1-xiongwm2026@163.com>
In-Reply-To: <20260716030236.124322-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 11:41:13 +0200
X-Gm-Features: AUfX_myzajePn8mltUINphDNuq-00hOZMHHFFuGnRbdhRoWqlQATXfpqP4mVDnA
Message-ID: <CAJaqyWfW9n5o+ojrEjK-m+6cwH_TSxWckjkvEXowZA8r=vDmdQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: reject zero-size IOTLB INVALIDATE
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	xiongweimin <xiongweimin@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qWCNGttuKP5jPhlE2efwnBSXwS6NTXcA7OfLkcSi9rQ_1784194910
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:02=E2=80=AFAM Weimin Xiong <xiongwm2026@163.com> =
wrote:
>
> From: xiongweimin <xiongweimin@kylinos.cn>
>
> Reject VHOST_IOTLB_INVALIDATE messages with size =3D=3D 0 to prevent
> iova + size - 1 from underflowing to U64_MAX, which would
> incorrectly delete the entire IOTLB.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3c080c454e374cabd7321416ed92c5f7d3135254..xxxxxxxxxx 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1656,6 +1656,10 @@ static int vhost_process_iotlb_msg(struct vhost_de=
v *dev, u32 asid,
>                 if (!dev->iotlb) {
>                         ret =3D -EFAULT;
>                         break;
> +               }
> +               if (!msg->size) {
> +                       ret =3D -EINVAL;
> +                       break;
>                 }

I think the issue is real, but how about adding the condition to the
caller vhost_chr_write_iter? It is already the

if (msg.type =3D=3D VHOST_IOTLB_UPDATE && msg.size =3D=3D 0) {
        ret =3D -EINVAL;
        goto done;
}

So it should be somthing in the line of:

if ((msg.type =3D=3D VHOST_IOTLB_UPDATE || msg.type =3D=3D
VHOST_IOTLB_INVALIDATE) && msg.size =3D=3D 0) {
        ret =3D -EINVAL;
        goto done;
}

With that, please add my acked-by.

>                 vhost_vq_meta_reset(dev);
>                 vhost_iotlb_del_range(dev->iotlb, msg->iova,
> --
> 2.39.3
>

