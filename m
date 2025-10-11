Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893341CF5C6
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168718; cv=none; b=k4cZH7BJQb4FrqjcUmNSnPbt2QYfksPpd6P3I00Hvk9AXSyIGRrGvl7RbkHUR7VQQAYUUM2LbAH15vthyhg9iZZbp0cRYxm9esyZ9z/x9Aj0VRGjqpkIO7nVyTGeI4Q4M2BAw7iF3KJYfdpLYKcSqpGqFrcPAIL9uKwAjQIS5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168718; c=relaxed/simple;
	bh=IRBVhMtnvfXCNw2+CiFz+E5fMH3uE9XUiZrv2bYozgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqLBb99ruNW1ddHL3/0m3CgPYuBTprLGYLkv2MqgkTr0wdovuspoJzafoXhzo10rIejR3IzXSEI8xCpcGc50Lr85jArNr9X5PVg6gjlm9Tr+hMevnrNT+bNZCpQjJbNhoHVbVOs42upErZyN1cZ3+8EW79d8niczLpN8izY5xfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1wUWnln; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1wUWnln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760168715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NxTjQN0BpNlhv5a09n6MH+YC+U2y/tcPRoRk2p3O6Tk=;
	b=I1wUWnlnC8kxwa8JBrZaCYKrk/NCalNcNZSZwK3kkDRsVSVP7yATxUIivkEXFr2bXgDo7X
	kL9r7exYhbU8l8sn+/TFl5vey1QEdyjVaraGeEaGyu7CBIBRsxTsBJ9VPar4sqvIltmfBF
	yarIM13azBlA2KFuUde5PvpRBuM5Hfo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-g8Ito8mnMD-tXfQ2UMFqLA-1; Sat, 11 Oct 2025 03:45:12 -0400
X-MC-Unique: g8Ito8mnMD-tXfQ2UMFqLA-1
X-Mimecast-MFC-AGG-ID: g8Ito8mnMD-tXfQ2UMFqLA_1760168711
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso10516062a91.1
        for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760168711; x=1760773511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxTjQN0BpNlhv5a09n6MH+YC+U2y/tcPRoRk2p3O6Tk=;
        b=twPqrCkG6TTfmZXkZv1I5k4BWJQmyEsGRVoWb5OVtClPUvoAnEwv+7xEwjRHiaarra
         CB6EXzfhqOBZFWGPoQnnBjZmenT+y2//P4sVkpmsU+DQxTIfthBtpV827qcThhanffuj
         SvzAQuEku9e/c1y7hoOXxufVK3i5aaxnUvKBCaJu+feM3JiB3uPFufg1B3aaIj4M2lr5
         vb/OYE4qnAIf50f7CjuYILmf+PqH3tezdWyQ2hCmWAiP5YN2HVdS5DU2yAGEjhDIahCz
         +eITd41ZvTXE4Q1VRLeMEIjx0dEsM/g9Igdlm3Q5u4yeIdGI1Rj8eIvgGblvKd9YC9yr
         As5g==
X-Forwarded-Encrypted: i=1; AJvYcCXk2liKaQ7YbStTZbCIw5DjhqE9uxBXXuMD4wsPhwf3pgQZ6BSiIpvqnSmhwyVaOIPWIiVmtO/XhGXoho3Irg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtyuLurjUI2lyL0YF/BSlGvrA21IjG53r4JvPacYtQB9bMWn/1
	tP88MrmyEVbuE7I+7RkTGsSLbbYsL7LBlDUwwuFXmES9uINqvLwMIlResIpMOBKl/L3myQcKh2S
	E2tfyo2uBi80KH7kwF32XdeLynZq7GCGdjNSzwyCklc9MyhrTKzZr9IBENhX6pyyZFALJ8WTC9K
	aAbRyGI4Vi3xMXMK4uRsyGx1VDpmj0nrpyd2gYFh3wPcM=
X-Gm-Gg: ASbGncvoIOpfKKv5uVH/fL3TQ+enNFyuP73g/zjFPOekdzIQleGuim7wV2ajELrhkX/
	Zfz4GDi1nZlZZkc4EpUaVamfU1bwp4JN2Gn0Lox13fV3mcXNupdBc1lO6XuP3uYuMmj9DgvcZEQ
	WnaxKY8+GSC+st3U4duQ==
X-Received: by 2002:a17:90b:3b86:b0:329:ed5b:ecd5 with SMTP id 98e67ed59e1d1-33b5127bf42mr20371390a91.19.1760168711089;
        Sat, 11 Oct 2025 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGPAupPV9/mFzX/1qNB5oaR43M4dJqgeJ/r/PkgJa/5EI7TRbK3laPSK2RhrFUHnAdF6FOQPBTCE8eV4xl3g0=
X-Received: by 2002:a17:90b:3b86:b0:329:ed5b:ecd5 with SMTP id
 98e67ed59e1d1-33b5127bf42mr20371361a91.19.1760168710623; Sat, 11 Oct 2025
 00:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
In-Reply-To: <20251007130622.144762-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 11 Oct 2025 15:44:57 +0800
X-Gm-Features: AS18NWCJuDEIdQcOLxJka21_V13mq6YSX8QzoVc4a0nUJ7-xdjg7EtcTcqY06a0
Message-ID: <CACGkMEvJwcTFmDTXyXvMM1dP0OginF-FKZsksFO1DamRQJP1TQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: mst@redhat.com, Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxime Coquelin <mcoqueli@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJ0Ylsxmn203sG9mUrdoSXFqAL1Roj45GQyFQSgUtxI_1760168711
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 9:06=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> An userland device implemented through VDUSE could take rtnl forever if
> the virtio-net driver is running on top of virtio_vdpa.  Let's break the
> device if it does not return the buffer in a longer-than-assumible
> timeout.
>
> A less agressive path can be taken to recover the device, like only
> resetting the control virtqueue.  However, the state of the device after
> this action is taken races, as the vq could be reset after the device
> writes the OK.  Leaving TODO anyway.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  drivers/net/virtio_net.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31bd32bdecaf..ed68ad69a019 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3576,6 +3576,7 @@ static bool virtnet_send_command_reply(struct virtn=
et_info *vi, u8 class, u8 cmd
>  {
>         struct scatterlist *sgs[5], hdr, stat;
>         u32 out_num =3D 0, tmp, in_num =3D 0;
> +       unsigned long end_time;
>         bool ok;
>         int ret;
>
> @@ -3614,11 +3615,20 @@ static bool virtnet_send_command_reply(struct vir=
tnet_info *vi, u8 class, u8 cmd
>
>         /* Spin for a response, the kick causes an ioport write, trapping
>          * into the hypervisor, so the request should be handled immediat=
ely.
> +        *
> +        * Long timeout so a malicious device is not able to lock rtnl fo=
rever.
>          */
> +       end_time =3D jiffies + 30 * HZ;

The problem that 30 * HZ is probably long enough to trigger the
warnings like hungtask?


>         while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>                !virtqueue_is_broken(vi->cvq)) {
>                 cond_resched();
>                 cpu_relax();
> +
> +               if (time_after(end_time, jiffies)) {
> +                       /* TODO Reset vq if possible? */
> +                       virtio_break_device(vi->vdev);
> +                       break;
> +               }
>         }
>
>  unlock:
> --
> 2.51.0
>

Thansk

