Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB305F54F
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839977; cv=none; b=NmVOgEdIj+TGVU2g1V9k7ZMC0JWcFKFJfEZ6krgQlnR7U3HbTBX8+Jd3QdE+NnQkyt7GYfT23qwFczj6tVZZBsS1w0JnWmj9WK+34dZbNzqAB+ajHwD5vk98PEnTtUp2iRyhX7SgfX29n7rPlc2Y0/x76AxdCmpU78pMC7Iv14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839977; c=relaxed/simple;
	bh=gRbVmUln/eRZrMgBtMOu95Son0kYgWZtjC+yBqqnV8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYQN0u1L7YvC6jN1eP0YePLCPsC+HIIjR8YGxV6ZbcTVIMgZ0q/8ayxpvUywnl0aM56iUHUHghzdizIA2dOsJUEuvItAaRI1nbmQVLLB3Kamfarpg3fjKUlvP29PHRkr96MEoMR2Vh+4vn7S+BzmjA8u0dhS9A3VoDZAlmv6dAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giEF4iZh; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giEF4iZh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7DAB605DB
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 15:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kh7A5Yt8nP0q
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 15:59:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 43FDE605D2
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43FDE605D2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=giEF4iZh
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 43FDE605D2
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707839974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq4cGykM54m1GUbpNCYw0KR4tzCwjD4fijC17ReJiPw=;
	b=giEF4iZh/LgVDrgQ7Ifl0Z6lRbkUX6AfLsS9h6WhKcmjmC3KQWJwzvhKIDsHLxqE91SifC
	VYieby4EIi9pZU46PsUKYa1cjKbGSRne4MafBN9x1cM947yBjX7P3UtxOioWeRngWGADSQ
	7RiGUoK/DWXDR4rJQgHBZ9H3F3TJWoY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-LjbKtIv7PaiC30CI_nG5hw-1; Tue, 13 Feb 2024 10:59:30 -0500
X-MC-Unique: LjbKtIv7PaiC30CI_nG5hw-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso8769850276.1
        for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 07:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839970; x=1708444770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zq4cGykM54m1GUbpNCYw0KR4tzCwjD4fijC17ReJiPw=;
        b=uSSuLCLRyExkMPC+VjQ/syBJZAFBje7w75psHTStkdiBgHHXY38krC6CmcxKBGyAbz
         ++bcqV3Lcq61HtAKh/C/IwY4zvx/KutRkkyXFmVfql2M5839jy9PLw5efCOa4mliCMQ+
         JRUfZysKhrqhfzMYAYJqpaA3oW/w1Sscb5VWiAaSjVu66PmUvzKoqnzQ/AJ5OtIA/YsU
         UAE9JoJI/CcC18Sz31RXz0upAOOM2C3/P19o7iZjp97GySRJJ1C942bQ6XbNm95i/PUC
         mi+r//1FJe0bqlMvTyvcGag0wW0llmpMnU2mgEkUtu58iYMX84Pmwj/oDBjavBZ1AFhA
         bxKA==
X-Gm-Message-State: AOJu0Yw6gBozayfQCOO7cmvHQG6b3ekdwbIRYWqvUNDEMb47j/25xK+w
	Zl8MtnlTv0pRyJ5xr3RznxRMmrb6q6wBugPljmUoA4hKcCcf0d+D1B0sq2534C0JfUcighLtsqC
	ewpt1bLuaie0/46YkKc/lWMWbiJ/Ebv1VLK3JFdq/3YGep+N4fyeNRW0uM/2PDslZvQa0hNC+sD
	F/9Rycsz0oPuPs9pKiIqu3vgNKOJS8Q2V1VyNs0WIiGeIdDyUuSPawLg==
X-Received: by 2002:a25:aba3:0:b0:dcb:d0cb:651e with SMTP id v32-20020a25aba3000000b00dcbd0cb651emr3678759ybi.28.1707839970278;
        Tue, 13 Feb 2024 07:59:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5Y9tRkT/w76lYOCEDhwuuKmO/porv8bn7dSnKt/eWOytIXYIHSKWZ8ZDNwQxpijSKYEbz5UVnSKlp6/P0++k=
X-Received: by 2002:a25:aba3:0:b0:dcb:d0cb:651e with SMTP id
 v32-20020a25aba3000000b00dcbd0cb651emr3678746ybi.28.1707839970035; Tue, 13
 Feb 2024 07:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com> <1707758174-142161-2-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1707758174-142161-2-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 16:58:54 +0100
Message-ID: <CAJaqyWdOYHA21A2JUwnTmWfSro7H0ZTTTkkH7Ot9F8hwK+TKXw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] vhost-vdpa: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xie Yongji <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Flush to guarantee no workers are running when suspend returns.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Should this have a Fixes tag?

> ---
>  drivers/vhost/vdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..a3b986c24805 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -594,10 +594,13 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v=
)
>         struct vdpa_device *vdpa =3D v->vdpa;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
> +       struct vhost_dev *vdev =3D &v->vdev;
>
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> +       vhost_dev_flush(vdev);
> +
>         ret =3D ops->suspend(vdpa);
>         if (!ret)
>                 v->suspended =3D true;
> --
> 2.39.3
>

