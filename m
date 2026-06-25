Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8423451C6
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395747; cv=none; b=GJcDeEw2G5EPp1CuWvTbcCGewT+eQhSxoU3KKme8+jr01R7ZyFrPj1l9yHBronzXjYqzG7yvdDiPazaridls4G/hcPoeyH0ACRPiaUrk3hz2SMi0439RPRiGz9G1B1WnR+/xRJ6RjJKQG6K04wj+N+0R+044jHRkZ+4ML9PcqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395747; c=relaxed/simple;
	bh=aNfW+A9k36/gRA+Tgh6RG57Eu1yW774BDygQ/qvn+Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgjK0D6Uy/CX5h1ZEPf/PavdAwKBQGts+mih9OA8TGVg9lNMvjsqEqcLDkSqRH+pNycl5w6xeFZMPUgYCrnZqgsx7TN1pxbs5CkVMcp9jy3a4NgMgfUdEKZx/SS6Q82q9a+FMROtEDVP03ixgpX4y0nWtst5Qb/LxBcrFkUJGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2QlUMsg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2QlUMsg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPkvny65f42eFjCHdDbukDV95N0h7MS0joXJqLipwG8=;
	b=D2QlUMsgxzV9t7mZXW3UGfvMh8pkvFQC5+RS+OqNlfDVOz6PvFiwwhrKekDhkf4BGanUpp
	JT7xKBtGCNF+eB/OZ9cYfhOuWvPoCwNv17Y+gRcK/OBe0+x2LeD9VmdZbIx7fXwiT3lBG4
	9sL55lMv3xYxceQQFfsRyao/CetU1CY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-4i_SDLSuPs24s2aImW53rw-1; Thu, 25 Jun 2026 09:55:44 -0400
X-MC-Unique: 4i_SDLSuPs24s2aImW53rw-1
X-Mimecast-MFC-AGG-ID: 4i_SDLSuPs24s2aImW53rw_1782395743
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7feee03ead4so46009177b3.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 06:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395743; x=1783000543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nPkvny65f42eFjCHdDbukDV95N0h7MS0joXJqLipwG8=;
        b=Xl9+H97gwWkqP3L8YwMnqfLPG8vw74XHdrsSfKNgNLNPkoc/ymcLu6fbihKcCIgOBc
         Mytn7U6qk4yKawFDbBPLOOnnr5UbJlZ0y8/TRtao32yFnThMl2dSuCo5h5WjCWu8cvFk
         hJCmhA9rwOxSwCdPxKKpqFquI0gllTQiYgZAbUmaNs9yvLbLq/YcTdLA+UkflOJAQ8zt
         PgKbvq//YUxPcmJa/9AT4+u04VfnKOsP8xQTZ5ciJSHX4PuIPruGQw+7Io8TLRUPJW8e
         WzZN4wSIyTvXlXadSrvyDitUAnPGu918FYyQwrYVJnp3r7sB244zmUafHu+5z5Oaafrf
         gXoA==
X-Forwarded-Encrypted: i=1; AHgh+RrudNtn9MpFaVSixDfY+dc5kdLpSck+1cvgbgVCCgqze+c72kFEyrSIkVTLoNryBOY86xhp9ZR9tYPi5VS0kw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVQHV4hjPOzgDA88RbCWauxnHu2+97Xg2dC0bWxZeTa/I1Guro
	+iNL9Drky/4GQeQFIIelZV3YZqIh/O5jSFxetscXTU8GiRUg6TNWpJoz2kikRlc+bi9lTFDwESP
	OPYkT+2yHcG3tjh8DqbkMkAosmvsWwEdNLX+mWEjEkiAdwHXs2HGs+HFhD0jOBSKkOojihDJKl6
	9FePKHaHDv6NRkxvJLygoipCRjZJ9996HamLt55crLm6A=
X-Gm-Gg: AfdE7cnPHRuYe8fmd3+MgemT8mmLdIPi9kV9Nc7ULee6XVo/uX5mhKWVSN1oIIGM+LY
	MIN7zeE1PMMAOqbh+KMo1rHdA07xoVmsxPfFskkod7b1BnQP84KGHavh+MvOjw0INxsUVMHVSWD
	WoTgc5fFmZw8ALAHhIovq/eZtbsjMZFCEcjveCvoMRCJAeQgcyxTfE8iLkrmH981F8rGg=
X-Received: by 2002:a05:690e:43d7:b0:662:da40:c989 with SMTP id 956f58d0204a3-66487e23681mr1467897d50.44.1782395743319;
        Thu, 25 Jun 2026 06:55:43 -0700 (PDT)
X-Received: by 2002:a05:690e:43d7:b0:662:da40:c989 with SMTP id
 956f58d0204a3-66487e23681mr1467886d50.44.1782395742840; Thu, 25 Jun 2026
 06:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <E091F15D8FBE8F16+20260618100254.513806-1-chenyichong@uniontech.com>
In-Reply-To: <E091F15D8FBE8F16+20260618100254.513806-1-chenyichong@uniontech.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 15:55:05 +0200
X-Gm-Features: AVVi8CdHlE3KdOXYPcrSXvIdHywLTQfOtV4EMPa67YWu5gafATfppLkSRXgCrpg
Message-ID: <CAJaqyWe4jeTLuW73Bj279Mf6g+3A0nsOToBFc3otMeEM+0hp2w@mail.gmail.com>
Subject: Re: [PATCH] tools/virtio: Remove unsupported --batch option from vhost_net_test
To: Yichong Chen <chenyichong@uniontech.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l26HUFWeyc19Gpsk7q1a592Fbkl8df6cKXAlFpkq4c0_1782395743
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 12:03=E2=80=AFPM Yichong Chen <chenyichong@uniontec=
h.com> wrote:
>
> vhost_net_test has --batch in longopts, but not in help.
>
> The parser never handles 'b', so --batch hits assert(0).
>
> Remove the unsupported option.
>
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  tools/virtio/vhost_net_test.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/virtio/vhost_net_test.c b/tools/virtio/vhost_net_test.=
c
> index 389d99a6d7c7..566e15420bb6 100644
> --- a/tools/virtio/vhost_net_test.c
> +++ b/tools/virtio/vhost_net_test.c
> @@ -450,11 +450,6 @@ static const struct option longopts[] =3D {
>                 .val =3D 'n',
>                 .has_arg =3D required_argument,
>         },
> -       {
> -               .name =3D "batch",
> -               .val =3D 'b',
> -               .has_arg =3D required_argument,
> -       },
>         {
>         }
>  };
> --
> 2.51.0
>

