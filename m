Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7885FF03
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836364; cv=none; b=nYWHgo1KXUwVpWQd/qoK+1/OpA4n2cUyPKyosgbmYoxqx7MYFXeY+TeCrooG1xh2O/8RoZHDfUWyZOSmpO+bGTsMwMX7DHYXvONXC6sGGwtgEi8mJo9bBCTqNFWRfK9AEPJHGe7HW9hzHshsa7TPN5tQSK6VYJ6lESQ23YF4ZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836364; c=relaxed/simple;
	bh=lstsHYjspAxYFUqi/F86TsOmqitvcE7bU4snS9ufjxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElFcuLaLpSlPuskRtaJ6kG9JJ2uQm7njWpgCu6gnCX9+58E5rSCKWWz/dtTK5WANjtl8EyJW+eKSO6ww5I6haWOoJPuElBkQUchfSQFhuacZTTENXnamhWOWgdh8dlNA/5qqcy9yqynUd6fVlDgHVmLlRU+uZVSnxR4ARqI4zc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3ADn3+X; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3ADn3+X"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D53860BD0
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZg8LNm16YK7
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 14:59:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 898AA60BCE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 898AA60BCE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f3ADn3+X
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 898AA60BCE
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707836361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wg7XquR0+qsJPak8BqgKQIc4rSbNVnMGjqoiDcYeAqo=;
	b=f3ADn3+Xj7xYlvzkwnkkBb1MNLC1LCIwcSSiu7IYkX57nmGlHXl3onD8BjyhRvEFWiYxew
	eP95okuvA9u3xVaj9GocvlfazD+2jXCvqCu2xU+Ie9y3jRQoJDhP7XF0RlY+1FDfIciBTk
	dS+9XJI0XtgYUtztGTO8J8AOrvFFar8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-Gvcl4hFgNIK8b6A76EvkIQ-1; Tue, 13 Feb 2024 09:59:19 -0500
X-MC-Unique: Gvcl4hFgNIK8b6A76EvkIQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6077ca422d2so20231137b3.1
        for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 06:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836359; x=1708441159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg7XquR0+qsJPak8BqgKQIc4rSbNVnMGjqoiDcYeAqo=;
        b=f2eF6Gsro2DZdbkoHRg3o8z7qPkGJtFB7KjJkg0RHt+cFGKQ2flxKlhGP6DIvdF7KR
         qycGn33k4otpoYq/L3Epqil4RighRDnBmlQDStFUDNym8Lub0USuuvAdJrb+vCRMaSQw
         RnvAUXuX+Kb4HZD2/2uw1D4tgkYx8YHFIWnWGfy3wzEe15dndnj4obBK2tuEdLCy0j4C
         IJS+opYBBsLMAbFp+t/fXDIvNZJUgroPng1f2y0QiWbP6ojwvF/ZNSaFWbNJz1e5nW+z
         KgxsKQQx+CqXB7pl+Fnx3K2UOZpljFa/QJvos44pjsold/o2HQPlSWGgUrEE/HINvZi4
         RZjQ==
X-Gm-Message-State: AOJu0YycsyGNuRd0u8dzqxIxhadgzEGloHQ7H4hU4HQ89KJRdQccTcfa
	oCLH3zeGQiZ/GGPgxJD01mlvUQN3/ognCbZ9nLn5bHQ0v/hLhEjTvesfNsHlEkhHR9ubSrskROI
	tMBFJytKYmpjNiyfiqWAVo3NqNCITx6p7vhGSBnnW5AghQD16UuKrp+BOXuy6pZbbBn+eBtP/1D
	gWUBm5sQmwCHrkeJ58FxA/DozR/6PYtXSQBF7kXL5xS6LBnPRtUsXqTQ==
X-Received: by 2002:a25:10a:0:b0:dcc:7ad6:24df with SMTP id 10-20020a25010a000000b00dcc7ad624dfmr1988623ybb.17.1707836358751;
        Tue, 13 Feb 2024 06:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfGf3AV29voOESHDKbJSTz6HkBRsJzXQrBDiC4qHGQnuFLJUcRf1vHum6cTTK2KvFzGvKHvE5Smhd9Lew0jfg=
X-Received: by 2002:a25:10a:0:b0:dcc:7ad6:24df with SMTP id
 10-20020a25010a000000b00dcc7ad624dfmr1988614ybb.17.1707836358354; Tue, 13 Feb
 2024 06:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1707834358-165470-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1707834358-165470-1-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 15:58:42 +0100
Message-ID: <CAJaqyWeE3hE3Mv29TL8K6CHTncexdOZXgD+BoehRCamiGfeBcA@mail.gmail.com>
Subject: Re: [PATCH V2] vdpa: skip suspend/resume ops if not DRIVER_OK
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:26=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> If a vdpa device is not in state DRIVER_OK, then there is no driver state
> to preserve, so no need to call the suspend and resume driver ops.
>
> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Please include a changelog from previous versions for the next series.

Thanks!

> ---
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..aef92a7c57f3 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -595,6 +595,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
>
> +       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +               return 0;
> +
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> @@ -615,6 +618,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
>
> +       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +               return 0;
> +
>         if (!ops->resume)
>                 return -EOPNOTSUPP;
>
> --
> 2.39.3
>

