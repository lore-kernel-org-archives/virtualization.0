Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E7139579
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041195; cv=none; b=PFKm6gZJ7CrJ2pZ0DS9iTHg4/iAGN+/8QWYteuk8RMVYQkfBDDxJp7DhSGS+/1GVxFGHrZrhUwXMAtJm1gqDS6DMYYAKSbA9dwV4+hZseVmp8CRtVjq2SsAzBT05nJOsA9U3HdDhOv2EVqIc9AkP0Cxxxwa73mHpkh4O8X5J8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041195; c=relaxed/simple;
	bh=qxukRFjgTgtSKS2ohXLJolyK4AYZBRJm1/DcVcnsKh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKER/x8F/o2P6JabTJOYiUQpW3rWnMv7IUXTo90TjwE1Q5oQRB8+n+T+Qoli2//4KppuHgsWvotoy9HRtYQh3dB07JPdx5HMBH3ZHoWhEhT4mP+7PABtxy8NPhofamp/aCYoXUADPHPGxsJDFMgv+3QEqufUCSYbiVfVoHXdFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MFzqnQCj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFzqnQCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717041191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlpc9L3Y02CHMDDZW/B1f1o1c+Ed5Qsk0U33kO+zkjI=;
	b=MFzqnQCje3SNMBsLkkQe3Tcqm3vMAoI0iSDrE/lFYN3Ce8updeXebf+Zh9go8tWWK4dw/g
	suSsqr8SlnGEWB2q/7HN+I6SggJcCiUeQfaN1uKAWSf37bBio2uKfzfIWoSrrk+q3+67XF
	DK020Fko8uYD1koQABcWhzq0bDaYzuo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-z91G_IWWPUSy6ULijBZazA-1; Wed, 29 May 2024 23:53:10 -0400
X-MC-Unique: z91G_IWWPUSy6ULijBZazA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c1a559a0e8so518516a91.1
        for <virtualization@lists.linux.dev>; Wed, 29 May 2024 20:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717041189; x=1717645989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jlpc9L3Y02CHMDDZW/B1f1o1c+Ed5Qsk0U33kO+zkjI=;
        b=Syfi969R4dR0bqLJSWjGVCmSk6iNfbH/ME2QGKHAqnK8bCqaZjq36FvldaA2/8Tm4/
         ScXjbAxnZoK1n9cxNfW3AT/+0JIURvP2jSTXFZ8ydb3WEj7ElVcHhz35CZKUewdHgReS
         /7KDCjY+gjR46IjQc+KEZw9xZy1ts80UgAVQ8/AlBNgY9oZqHevGJHEA59qIW8rbgUj+
         DxMsCPN5DkTT9tSsSk/2RpotRSMKr9nl+BR9oOofG20R/pjc11dh2SAoU+PjsGMeIbX8
         uHx2W44ATEVtwwGUl2/9bxB4ZWPaIDKk71h2xMPUQgLohVHThTqpx9CiUriH/1NxPhce
         cZbw==
X-Forwarded-Encrypted: i=1; AJvYcCWNBaq6IrlevcVeB3e/x4mP/6hYIHXjTcQVBIGR0DzWPm+8Ff+5W77KvOLSiqtllvUKMaadRc+bqY0eVrnDkFuROddV3MUea4A+6fG1Z24=
X-Gm-Message-State: AOJu0YwuSbIMzqHQRO6e9zk806Z+IhyTnXgu7JPFZSE+8psBrTAZp0kI
	g7r2k01DDmqznC1JgPcukjssXogdEifiYxQ3n7AJpxK07322j+/Rys1CQJrL2PU9L9b638KRnJN
	aXdFOQxtV4Lg/Z401IEAkVrcbvCk7lD+l4Sqed6fIc9+vziU7+GpiVLMwC2AI00ifXgjMjo0/Tu
	VB41Wi3NvseCXHt6tDRzd2jQvpe4rfkE/qKrHthfA=
X-Received: by 2002:a17:90a:de08:b0:2b6:214a:71ac with SMTP id 98e67ed59e1d1-2c1acb303aemr1035714a91.3.1717041189277;
        Wed, 29 May 2024 20:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeULtR/FufvAbU74QWlFg+74ajOXPYZR/8xr0yW3xI15uth/YAMmN2biyO6W1EJHRFDVlowveTP7HmqpIZiKk=
X-Received: by 2002:a17:90a:de08:b0:2b6:214a:71ac with SMTP id
 98e67ed59e1d1-2c1acb303aemr1035682a91.3.1717041188693; Wed, 29 May 2024
 20:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240530034143.19579-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240530034143.19579-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:52:57 +0800
Message-ID: <CACGkMEtL43VKTjU0D9bCftCCnv7_DwiSMaALPZnPo3E8btBmVQ@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio_net: fix missing lock protection on
 control_buf access
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Daniel Jurgens <danielj@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 11:41=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
> Refactored the handling of control_buf to be within the cvq_lock
> critical section, mitigating race conditions between reading device
> responses and new command submissions.
>
> Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
> ---
> v1->v2:
>   - Use the ok instead of ret.
>
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..1ea8e6a24286 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi, u8 class, u8 cmd
>  {
>         struct scatterlist *sgs[5], hdr, stat;
>         u32 out_num =3D 0, tmp, in_num =3D 0;
> +       bool ok;
>         int ret;
>
>         /* Caller should know better */
> @@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi, u8 class, u8 cmd
>         }
>
>  unlock:
> +       ok =3D vi->ctrl->status =3D=3D VIRTIO_NET_OK;
>         mutex_unlock(&vi->cvq_lock);
> -       return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> +       return ok;
>  }
>
>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 c=
md,
> --
> 2.32.0.3.g01195cf9f

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

