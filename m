Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF74182D0
	for <virtualization@lists.linux.dev>; Thu, 12 Jun 2025 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749688395; cv=none; b=o11FAzwx4u70i/hoX2Y7fYGE52eWVXrC7S+zJTEqeYZzMKp8M41tnsMjYuYcdWpqJAjBtOapiXrROs4va+fRq5q3fRvOU70TtEWn6d7o7VwwM7xKr49NCM8IBeGU3NfkeY5T4sNDE7uYi9XYzKEbNbW2MyD8wASR5ukExLPevXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749688395; c=relaxed/simple;
	bh=aKcZlk81D6jYjElCnOb0NSRjMfS+dLmya0lsVF4OKRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmqOHXl4P9mMlbUSDAvtpqsF+fkks+FfAURkBAy0OS494rGyzzCjuFHBYiO0fjK9rI+okR6JPrpwb28xl5+StB69NLUUEAr8k7WLNHqzlYDT63L0k89NsXkusqk1FXM1GO7WxCuH08q9vxp+797z3BQImLcDERPTDnz5bp3geFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccN+0MLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccN+0MLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749688392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TS6xeWOYbwuk0JPVdBkaR1TmrwKUhB4JF9sI+e4AYoA=;
	b=ccN+0MLB1TfNC2oH3RlGisMA3AAFUo+QWGXcWr48owvGuv6kLRDHVDpo48Jo9n7+pML766
	nLnhWd2KppZPnYS6GoFc9r0cHupr4M/1N6IUMcMA00XeSOvg6bFX955u5LBk6StM3s6ffp
	MWmL1FffKScFC+iWUv1j6TjaJe8kpxY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-4JFclQiQNc-zsntXx5wkuw-1; Wed, 11 Jun 2025 20:33:11 -0400
X-MC-Unique: 4JFclQiQNc-zsntXx5wkuw-1
X-Mimecast-MFC-AGG-ID: 4JFclQiQNc-zsntXx5wkuw_1749688390
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-313b0a63c41so533124a91.0
        for <virtualization@lists.linux.dev>; Wed, 11 Jun 2025 17:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749688390; x=1750293190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TS6xeWOYbwuk0JPVdBkaR1TmrwKUhB4JF9sI+e4AYoA=;
        b=Ux5mXThyDLgKTp8SREJowsJE4NZBqX1VDayO9vLFgTuauGF7Me4W+bIxDpx0LtAwJ0
         OjVbZ6z5mjiSvoV4AIRpcUYHwWhhNmj2em+MHeaydCI50MSotI33VMJXp1UsIgstHKls
         TseG/DYOYu//L3XBsUfle/zatQXw4Pv3QrfiYnC08n6dzF9JQbsN6ug1VQygVFhJgFXO
         E4Arilko1DedfPoAQ5ZwyyMDGPaQcFBrCg2iG1BZZ/KIpl6Scpmismm5nv14Bn+9z2QE
         VHY+SukhlXOmUe7qovBwZQ3689QGLfSGt0NMzj5Ctx3oJkzKF0GTTF0uqoZo7gi44fUm
         nD6w==
X-Forwarded-Encrypted: i=1; AJvYcCWHsCkcXLOZno9+hjtrwCF7+zce0ES/STCRxLMqpiX8DBWSNaNX20um2HTdCBx233lWRbTLdV228jy5q/EGzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzN5OD0WXE+47NRbPjsSkHXbwC899kwBXJChaPMFBnKDsvbVWBh
	RoZ03hT2tKaSr/sEmsTUwDsMiUBrlHGAbv4U5BJXK5ns/omtrsU6LfSeJGKXQvTziFiyH6ffRdY
	XGS68SBWa0PcD4uO/8GlGHuJThxV7yXhQpTeURFIOKNE88FCGa4m7XSM9k8n3NponsQQMIfGmIl
	y323CuRgD7doLrTiWT7G9QM4OGSrJT3spQGs+q62IPRr0=
X-Gm-Gg: ASbGncsXD+iHUsri5sPu/wmM0ev2tYM2MSXlBp3yHJvYHgX8UDkLP6zZ+AY4fQieAUQ
	mJPgq3QkaoBjFBfVwKHI1vIZV/BpdJ5Nl4M74F9l/CcQiPsQVvvG1JY1roZ37IDtEeJ0Fl4TNkL
	R+acU=
X-Received: by 2002:a17:90b:1f8f:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-313af13d310mr6918756a91.15.1749688390154;
        Wed, 11 Jun 2025 17:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyTRqaFYPvWVQTqrpEOkluJxidkvOIKGHZ1MkJaShZvIRpabjEj4Tf1il19yGArLA+fgk6YXwQIeTjVMDmEzQ=
X-Received: by 2002:a17:90b:1f8f:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-313af13d310mr6918736a91.15.1749688389856; Wed, 11 Jun 2025
 17:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-6-eperezma@redhat.com>
In-Reply-To: <20250606115012.1331551-6-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jun 2025 08:32:58 +0800
X-Gm-Features: AX0GCFsr2F7qsKMnXy1FAK1w50k70g_-gMZWuqSAzDDQbugOoplGT_Ab_pzYiUo
Message-ID: <CACGkMEsoC9g5j+GDaQGaRdGZXaCorfgP7mdhsk3cOg4BFnCcpA@mail.gmail.com>
Subject: Re: [RFC 5/6] vduse: reset group asid in reset
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OlE14BrXmkrr2ijQWTYPTRSF6Jc3_2i7p7xweaKDXN8_1749688390
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Is the expected behavior with vdpa_sim and mlx.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>

Should we squash this into patch 3?

Thanks

