Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC325F54F
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840697; cv=none; b=lRPAvxbPVumjqm3eZbY7tiO0CaywYzEzfhsU+9i2dxxaF5t0RKqz+7JFHSvhIgmbnZVJuYOGchDaVkWdTVsV5IDAvXQ/tinZfsEH3p6oRCfc/u9pUAJDgfIL3ilwI/C+GKdHFPeUaobkPvmb5IIR0eN45heXHWryD9IibgWXwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840697; c=relaxed/simple;
	bh=VoOeDgSa64KkhnhvOm5mPt1ULNJKW9NflDqchznUV1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWgh4HhSAzk5Yol7bR25QfCGDaZnr7Az3ZeZI+gVgd9+hsDKqP0goZPJEzwAYzDhzz1uwxVPtd+rIWxNl8Bbx97r9J1k95eZPb2vAELWk0y3RTFVJ8cVMlBw4/Rm6zwQ5YJv7Gc4f6PMsfTR/MigEFLGVEz0QokZ/Crr0NHrnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVdQOYNB; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVdQOYNB"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8954660BCC
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 16:11:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O6Xc_TtXO2_S
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 16:11:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31D7C60BC9
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31D7C60BC9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TVdQOYNB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 31D7C60BC9
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707840693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XOO48zwMIpqvH6d2VO+rX4+pzNniWF/xW4lFJmdRjuY=;
	b=TVdQOYNB/4R9c0PcDz4mjanHa3fVxWfX0pXyDkZDcLBOPNZSi2pZWTIhOjkHtzeDSejLRn
	JDdXBydl5+aaVSRtfFPuXWZoKCkmFNEzl7OHvteBjZRQyFp2sY1TVVKMCrvgvb5nYDKMFa
	FRSphkYvXQcoD3a0XNjO8naDnI1LlHk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-2ut5j1BoNZma6bYlfJI6pw-1; Tue, 13 Feb 2024 11:11:31 -0500
X-MC-Unique: 2ut5j1BoNZma6bYlfJI6pw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-60790eb0f8fso8827637b3.1
        for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 08:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840691; x=1708445491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOO48zwMIpqvH6d2VO+rX4+pzNniWF/xW4lFJmdRjuY=;
        b=dSL2a/bsCmrJbz28inNVKEHqMqnKb0UGulC/gyvLVvg6BZwtxsd4m1lyDgb6Oc1daK
         XFqxvZtXC1QDPdZOzFB09x2VlRcy38KWNSnWwFQYRvIFF99vG0jfbyx+SlO9f+fPmHMr
         DJvX2wzSeJXN6EURht3POK9vUohHpW165FSctLnMxI2WS2IIDo0d397dT8i5kGmkcLs9
         2h7exIEnzO+OitLGHKi//lsRCFBRhZp9CSSqeGm08TLYEirZ4kBf+udSR4tpyeno9Qdj
         h7odDhrrtZBdDA4R1w5De0m+w3DZlEApe/lcDQfbhtpCNrNdAmExKMQbjd1qazRXfgkb
         R8hA==
X-Gm-Message-State: AOJu0Ywao82fow/mPjnzG3+1bAsMYjrtKgXpSFwsrjXT7AmUdj0TZGoA
	3csDtrMjtLG0Gdp1pzwYCAU2BjVRIUteMzeJcZVlMuhdBISisHcPjA4VHgU+tcGMjkyYRA0g259
	KNubauPipTSLPYG0XhuSoBxG5YZO1XoJL6wZLrFIdYOKE09ZT0rwR1A9gRq83WFEdUjH0IlsmoV
	+cDzlDN4HRY1ilSqFE36sSEdW7DZmZ8a8n+fhUL21gNa5g+ysrrbIf2w==
X-Received: by 2002:a25:bd6:0:b0:dcc:9dcc:a433 with SMTP id 205-20020a250bd6000000b00dcc9dcca433mr1677716ybl.54.1707840690930;
        Tue, 13 Feb 2024 08:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtEOPL7MgovsHCMvEwZ4Qv6yCwv5MrDUiGRYjX+jOxtdnpt5umBWg0M4QrhM0gY/KgJHeUZZAxtThzuTs6nnQ=
X-Received: by 2002:a25:bd6:0:b0:dcc:9dcc:a433 with SMTP id
 205-20020a250bd6000000b00dcc9dcca433mr1677699ybl.54.1707840690691; Tue, 13
 Feb 2024 08:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com> <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 17:10:54 +0100
Message-ID: <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
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
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index be2925d0d283..a662b90357c3 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpas=
im *vdpasim,
>         kthread_flush_work(work);
>  }
>
> +static void flush_work_fn(struct kthread_work *work) {}
> +
> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
> +{
> +       struct kthread_work work;
> +
> +       kthread_init_work(&work, flush_work_fn);

If the work is already queued, doesn't it break the linked list
because of the memset in kthread_init_work?

> +       kthread_queue_work(vdpasim->worker, &work);
> +       kthread_flush_work(&work);
> +}
> +
>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>  {
>         return container_of(vdpa, struct vdpasim, vdpa);
> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         vdpasim->running =3D false;
>         mutex_unlock(&vdpasim->mutex);
>
> +       vdpasim_flush_work(vdpasim);

Do we need to protect the case where vdpasim_kick_vq and
vdpasim_suspend are called "at the same time"? Correct userland should
not be doing it but buggy or mailious could be. Just calling
vdpasim_flush_work with the mutex acquired would solve the issue,
doesn't it?

Thanks!

> +
>         return 0;
>  }
>
> --
> 2.39.3
>

