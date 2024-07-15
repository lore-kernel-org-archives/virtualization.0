Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D354C6D
	for <virtualization@lists.linux.dev>; Mon, 15 Jul 2024 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721008476; cv=none; b=baZdUYP0XTvHfnqlv+JJCVb+E0KNHEEA10vYaBY82VJNiukq5lgfVVmjhdDhUk8OgZe7sZzFV5pDdK4BDi1n53XZmYOAVhhmtHwYjHHKch1bNECrWgTEginGEbE4I3ZikIUW7m0Hj/rPGtPiUV4M0buzQ9xcKtxc2q4gROSlGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721008476; c=relaxed/simple;
	bh=PdJcb3igX9JMsq3rnGseO282QWH+Nqt+bo8dY3Ir/84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP/o9EmgHGtWgzCnmi6WXh6qTl3MiuKPrvzukTGvbHldYuLmNC3ywpz4Q6YfXnPu7BqroVY+bqP1wXBqUClX47Lxvlf7e2k9xyfjRnjGxgOgoyTtC89KxLsb51xPPAnUjSCSTcOhVx2U2yUTrnPdtraxjG+A78zMItZyO+dlEpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtLOPlr5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtLOPlr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721008473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyziscBlQ1c0/6ktS+LCg/Ky3aZzCiDK4+QaHxxkrmw=;
	b=XtLOPlr5tsFLBhgWfwBaHNMcdzzva11Lp+XTk6OB01Gs8kzyktcFQkb3HR1Cva6YarmPkj
	/h7cJ4PeURMlsp+VOEt9+xjzU0R7XdqquchD1JBq78W/kl+GFaRvA50jqa5rVXs04rGLq/
	9YYCeDMHlnXqqywKOfKbw9FCqGYxsZc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-q4bQahEUN7eirU8Udf765w-1; Sun, 14 Jul 2024 21:54:31 -0400
X-MC-Unique: q4bQahEUN7eirU8Udf765w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c961f68638so4036430a91.2
        for <virtualization@lists.linux.dev>; Sun, 14 Jul 2024 18:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721008471; x=1721613271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyziscBlQ1c0/6ktS+LCg/Ky3aZzCiDK4+QaHxxkrmw=;
        b=Twbuf0dFwo/IZRO7hrtPaCSOLai/C0OmjDIpq+Yixj2qMMybjSyJrtzQaoTKW9NfxZ
         CcpfK0WYtcBzAeCYhIwXfCc6AXdt+u2ddO3Naj22SuVeuEGN69UlG+DcRfuVUNg6nAim
         sl+sAEQnQkbTPLi/lbx79X6BIrtLdbM9fxfPIxSRlBPrcUSqD7gsO69f1TPoQPjxJL5s
         NPX+lkB8OP2iqKdeFV5KowaOaeEbXl1P3G/XXWa7k88f9GlM1TkZ6XOWJCsx1FQEjfyU
         DHCODPafSh5nKgAE/1JsCVRPk1y1NBVy0x2kQKxvyKpdIWPg05XHotjCJHcA4Td21zSX
         WOMg==
X-Forwarded-Encrypted: i=1; AJvYcCXR6npShRW33faZd2EyFCrz5+8RIfHDu1JR72aZNkPj4/svIX2Sa+50Z8nehlwzYVakL8WiUzXR72Wg+WHNQHAWCFwzF4oYJmYDLs5757Y=
X-Gm-Message-State: AOJu0YxCzQ9NwS2bOyz1l30PFEU6i+t76RSoEbl+rVFyhU5KyXc+J9BD
	7fU28uvMupKwo5GBWJmAkSCa9/zwqrK6X91LCT0kd2VL2WPaf5n9d1xdREeR98BAAPGwF1LmXma
	c0NUWIE3HPqnwuPYNHugGmcZUnAZvnbHcaKtiwGVSay9zHnxNoA1wsP3SbpIBcHeG/cYAKhjVyW
	Rc/yMWybZ+rxrGBYN9hWJ5X2xXy5bsnn5f9icDgGU=
X-Received: by 2002:a17:90a:5ac7:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2ca35c312cdmr15354434a91.14.1721008470745;
        Sun, 14 Jul 2024 18:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsQqLS63Hvq5fYpeQcjjiPgAVcyB+pI69ldGNsmD5W0H1x9xueomtQ2GsZcTQmFkboH3lsYYRff1IdWbUz/UY=
X-Received: by 2002:a17:90a:5ac7:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2ca35c312cdmr15354418a91.14.1721008470209; Sun, 14 Jul 2024
 18:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <623e885b-1a05-479e-ab97-01bcf10bf5b8@stanley.mountain>
In-Reply-To: <623e885b-1a05-479e-ab97-01bcf10bf5b8@stanley.mountain>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 09:54:18 +0800
Message-ID: <CACGkMEusUJvJuk2QLcQNt4kb4TK-dsUwzx1q5zzK1dggx3iDpw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/octeon_ep: Fix error code in octep_process_mbox()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Srujana Challa <schalla@marvell.com>, vattunuru@marvell.com, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 10:06=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Return -EINVAL for invalid signatures.  Don't return success.
>
> Fixes: 8b6c724cdab8 ("virtio: vdpa: vDPA driver for Marvell OCTEON DPU de=
vices")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Nag mode: When we add a new driver, then could we use the patch prefix fo=
r the
> driver not for the subsystem only.
>
>  BAD: net: add driver for abc123
> GOOD: net/abc123: add driver for abc123
>
>  drivers/vdpa/octeon_ep/octep_vdpa_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c b/drivers/vdpa/octeon=
_ep/octep_vdpa_hw.c
> index 7fa0491bb201..11bd76ae18cf 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_hw.c
> @@ -140,7 +140,7 @@ static int octep_process_mbox(struct octep_hw *oct_hw=
, u16 id, u16 qid, void *bu
>         val =3D octep_read_sig(mbox);
>         if ((val & 0xFFFF) !=3D MBOX_RSP_SIG) {
>                 dev_warn(&pdev->dev, "Invalid Signature from mbox : %d re=
sponse\n", id);
> -               return ret;
> +               return -EINVAL;
>         }
>
>         val =3D octep_read_sts(mbox);

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

