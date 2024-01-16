Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA61D527
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431518; cv=none; b=JVXRicPY9J/afptyPdGEFgEM2E4Qw/e8W+2pER1pebCwMEx1yqijPw6d3V2yXovKCsbAZfNYIBRpj139z6ovomli1zvetYc/M2RH8RKKilG215pIA6bhPlTnMKBOsEelXVH/o0yXhLM4X8q3WDBAltBAYM5HK1kYihysEPhO0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431518; c=relaxed/simple;
	bh=Sh+VUyorUwfwt3DtfokrDMEMXGc/bg5xuZ8tbxNpivs=;
	h=Received:DKIM-Filter:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:
	 X-Spam-Level:X-Spam-Status:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 X-Mimecast-Spam-Score:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding; b=atZU6OPQR8eoUiOTP/kmvJihaFM3Evchwjnmq6RfPJuWABjNOKa7g2XJ1w0Sto1uVFttvrxAkedqVDnGVsn51teTNEM9+BEFcnSlyuLE/iwfi84lop3EDR8Vy9LkKcETlHAyR3HdPv5wXflU4sKwN+7TAYFR6JBhb4KUFQjE8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9CZUOy1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9CZUOy1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8D958183D
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 18:58:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A8D958183D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K9CZUOy1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bGLO0HR_ix_0
	for <virtualization@lists.linux-foundation.org>;
	Tue, 16 Jan 2024 18:58:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02B6E817C0
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 18:58:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02B6E817C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705431514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGtxsaBcIsbwgFk8xTkmWG+OKYIfaAELOe769Qye7L0=;
	b=K9CZUOy1vYW7uqEhB6C0vObZ0NzhUdcL8mJxV7r4c5EJO54q99ewFlps+fKGI4PkstntSy
	JC/64/pUoFV4mkUJsGfpSySctMCl1pqEpoE4OOxyQRRYKG0q0DlOb79Yd6a+EQJdsObnnb
	bNkW0yi0eSCvaQ621AJtGmS5w2kFpfQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-YlLgFwKIMRW4RsJQvDCyiw-1; Tue, 16 Jan 2024 13:58:32 -0500
X-MC-Unique: YlLgFwKIMRW4RsJQvDCyiw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5ff3172c669so38831807b3.3
        for <virtualization@lists.linux-foundation.org>; Tue, 16 Jan 2024 10:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431512; x=1706036312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGtxsaBcIsbwgFk8xTkmWG+OKYIfaAELOe769Qye7L0=;
        b=LNdkEorR2J/JnOJVDOU3V5KbZI8CzDIDx39t4P0Wnv7A56m3Qon2OyQCn6gVlJxOuW
         jibNVXfI2aP+XW/tnE/zrcHdDjZuw7IXXLmImsqBYNawg+5/xNpFJPWMaQSqH8FVwuxb
         rwVJLvctxXb1wAf0TSAgurtmk5/AbO8rSbvtprUSNe01G7AF6tzE2W3wdXjLT6yFxikp
         LidM/OCBMoYfXBh7uhqsFlI1yV98gs9mFaUnLi13TdH3Avt+bj8BIpLG+fOZlYgtRdyb
         b2Y4W6dKgGxyMOeggCtlPEbhnYR7/Db/3IJ3iZNBnDnPXdNksLWHCqS5vsWQRyxV18If
         r0zQ==
X-Gm-Message-State: AOJu0Yw0WOtnGxWodJB4+jSJ5PTpak25+SFU1cvtB1rw7AwhMEw2TWEz
	NPqy6nU6Nl2Fg12OJLsKLT5y4ry76uc7212GdLMagxRPUXCBah2HH7n5ZxWkhEjmJ3V2JuVTyIb
	xq2TR3IcHShVAXq/Esprc6AbtPM8HISUoLbebfan6STI9xfDbi8oObP9czTQ+4xCuvw==
X-Received: by 2002:a81:e60c:0:b0:5f8:1f59:fd02 with SMTP id u12-20020a81e60c000000b005f81f59fd02mr5347972ywl.13.1705431512153;
        Tue, 16 Jan 2024 10:58:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2FPqlLgrZtRGp97ysG2vhyXsVT8O2mzxPiCpvhJ9h+PAjf/LwrYSrPudl/CHkL3IjaTeEoBHWECQld7EHMaw=
X-Received: by 2002:a81:e60c:0:b0:5f8:1f59:fd02 with SMTP id
 u12-20020a81e60c000000b005f81f59fd02mr5347964ywl.13.1705431511935; Tue, 16
 Jan 2024 10:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com> <1704919215-91319-11-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1704919215-91319-11-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jan 2024 19:57:56 +0100
Message-ID: <CAJaqyWdTBexyY-ra=UkUfUU75YS2Zncm5-9iHv-0Rqa3_mD=9A@mail.gmail.com>
Subject: Re: [RFC V1 10/13] vdpa_sim: flush workers on suspend
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Eli Cohen <elic@nvidia.com>, Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 9:40=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> To pass ownership of a live vdpa device to a new process, the user
> suspends the device, calls VHOST_NEW_OWNER to change the mm, and calls
> VHOST_IOTLB_REMAP to change the user virtual addresses to match the new
> mm.  Flush workers in suspend to guarantee that no worker sees the new
> mm and old VA in between.
>

The worker should already be stopped by the end of the suspend ioctl,
so maybe we can consider this a fix?

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdp=
a_sim.c
> index 6304cb0b4770..8734834983cb 100644
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
> +       kthread_queue_work(vdpasim->worker, &work);
> +       kthread_flush_work(&work);

Wouldn't it be better to cancel the work with kthread_cancel_work_sync here=
?

> +}
> +
>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>  {
>         return container_of(vdpa, struct vdpasim, vdpa);
> @@ -512,6 +523,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>         vdpasim->running =3D false;
>         mutex_unlock(&vdpasim->mutex);
>
> +       vdpasim_flush_work(vdpasim);
> +
>         return 0;
>  }
>
> --
> 2.39.3
>

