Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9F254861
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748498580; cv=none; b=uGC7P1dhYkNbccjm+Je2wuvwLXFQFuwaQdo8SW8jTzKeAVFlVbXUUCC7XBgur7UcuWXk/HTcxAiJmakhSUv55syGSw4asuFu5fB1YSEOGWJaJB01kc0OE8CH3Zjp8WBhg0Ck82W8+f6qH6l5NHdLbZpVLT4I2BK2nDxJ5kglqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748498580; c=relaxed/simple;
	bh=Fkp+IGW7TPGnZNAbAinEElfDl2SRpDjwPauRa8hMm6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPh00NRDz6hPfiqulP04fVCrpXiF+sgSK3S2zCMN9S172/92F1dQRnt2vpseCzwrsugPt35mehsNfl+sP5rNUKav+XJVn97D1xqhwJ6OpClIOOpB40xUWPascmwxntQVXjOElNdNwKFx9yCYMS1L/6Gpuk3qx5REaHw3EvPiMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjWiSFx+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjWiSFx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748498577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ox8p/2RUuwEy8Y6Yrm/mFWz/y7tZxRVqzbJuQ+vAXU0=;
	b=NjWiSFx+itAGDtxbBPbJv46nCvqz1Q2i9x28zwrBN6fA4cKiiJQVoQUrtCdOpzv75dzCHM
	2IhGIwmv4pSIirCgAhANg6gEwbnu/19EEUXW+Zuvdi6ktDLZveUmAO15QouvSMpwCERGBk
	3dRT8EnhJrsoPWxH6hZob4A4btvIrOI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-D3TumRvSPqyWfZ9jxMsChQ-1; Thu, 29 May 2025 02:02:52 -0400
X-MC-Unique: D3TumRvSPqyWfZ9jxMsChQ-1
X-Mimecast-MFC-AGG-ID: D3TumRvSPqyWfZ9jxMsChQ_1748498571
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-af59547f55bso427845a12.0
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 23:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748498571; x=1749103371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox8p/2RUuwEy8Y6Yrm/mFWz/y7tZxRVqzbJuQ+vAXU0=;
        b=L1DMRj8qyTnHbLIxehMsTzechY9DcJlBSUw+i5LFKETf3BCPaoKxCQuyzsjnoovmqZ
         I26zZXUWStk3XRzMP0zcpC6eUPC6dAESQyTTFn7aBdoDL7jwxc6dZSlgdql9cPkNVPlx
         TvE/Tkp2WdXhpZAHw6lfyNbZmvdFMoSSCi9iL9eD2qP7xLGYtKqUSYLBG6LOBfZI+jFo
         xShRlWvRlZawlqu+bmSK4udc+ktTmFev0SYb1vZd+pDa+rTCHZRjxrSqvPoa3zKsE/wb
         zPGtcZtvDHNjdxVR5Mfod9cspUnHVywZjw7mBw94RpYugIi/+uOfSN9zJzeimaxrhr15
         3q6w==
X-Forwarded-Encrypted: i=1; AJvYcCVICqiDJgQKwJgbDZFquZbWq4pwPBZb9+I1LMybYlO9amdAXTlHhiFGlygEKIt9a/e3CARjT/1+E0DjL9M9ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhPPWr54XDMAun8MOMlcndyYJuuBXnh3nVuMNKDgyEH5RjObhA
	29BNMTkbVLHb/70WpIEfwzIVopiIAIj4+TMrODDEgb297/F/Rxc1MZtWaaLNBzYl//mw2/fR7dw
	W+UW9rxrnA4P1we29VrlbY8KkfC9RimsYniSMRBKx9L/RdRkL644V5O37QbjNjHUHMiUuMo9wTF
	jLv3RF9WjUUqIOKQoMZRCOLl3sXtWNKeDuln2hTwtzSJI=
X-Gm-Gg: ASbGncu6U034RjjlKotUFF931N3uYyUT+opkWVDiFOdGxiS4/kQcDDd3r2W8EKpm2qG
	rudZoghh9XU3M6m7G9OJKtkelv+zsrsgqCZCeI7PaaLOjeaXVvAuMILWk2l1Uv7espFgn7g==
X-Received: by 2002:a17:90b:55c3:b0:312:1e41:3a5b with SMTP id 98e67ed59e1d1-3121e413beemr1546585a91.4.1748498571184;
        Wed, 28 May 2025 23:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGseKM57uPSH1yzFvA1sPyp64ebVJHorKWlBt3avCzTNh2XNJWP+T1mUEEHN7w8KQS8+ef/r6g+EcKIjodekn8=
X-Received: by 2002:a17:90b:55c3:b0:312:1e41:3a5b with SMTP id
 98e67ed59e1d1-3121e413beemr1546549a91.4.1748498570780; Wed, 28 May 2025
 23:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250527183407.2093374-1-alok.a.tiwari@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 May 2025 14:02:39 +0800
X-Gm-Features: AX0GCFuDDpVrmW1-K7aWF5F3A4LuqINynrQFLI1IwHM-GXbe0Lza7KjoUEaxLzE
Message-ID: <CACGkMEv-FAbx-TU0Lvi_C=9Tk94EiHmDQzT7Fqn0ZsMcP3BPkQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] virtio: Fix typo in register_virtio_device() doc comment
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: david@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QnWUuFkB4d7grJzSLnlUB8Y1PLLMcEsBS0ztH_dZxYk_1748498571
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:34=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> Corrected "suceess" to "success" in the function documentation
> for clarity.
>
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/virtio/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 95d5d7993e5b..2c022640ec4b 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -506,7 +506,7 @@ static int virtio_device_of_init(struct virtio_device=
 *dev)
>   * On error, the caller must call put_device on &@dev->dev (and not kfre=
e),
>   * as another code path may have obtained a reference to @dev.
>   *
> - * Returns: 0 on suceess, -error on failure
> + * Returns: 0 on success, -error on failure
>   */
>  int register_virtio_device(struct virtio_device *dev)
>  {
> --
> 2.47.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

