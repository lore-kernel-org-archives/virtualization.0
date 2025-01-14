Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9022FE02
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 02:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821114; cv=none; b=qxtxEdN7gm19JZXNASQ0TIB3XYGJaIMePDPUh9sOtZcOAawdTn+hesHNYqxTwh2winpRNSzw4T1rBZC2FhxWYr8x2zCvs1pvicuGAYGJ+FmWmv9uTQW/oIsI3r8bhREDKd4Xut9lnEsataxz6qrMqLllI+VeJ8TGdJOh5RJ500Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821114; c=relaxed/simple;
	bh=FR1w8DHiNlRfEH0Y9g4o9X9y5C85sJ8mTWqsZ0CrX5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1F0yPsUyH+vlR48sjk6T6Rtu0TLfSS1b4uJ6mweJpzCjJagH0/RPwhnIweuK5vSimy/BtWWWCquqz3xJ7Mt7NJrhqjft4suGAfwH2vNkTHeZfwLBGaMTI2jBc9IFwAB1vmBoafiV3NZXyOD5LVVmuojI47VWE/CfdoKPvbVm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eteUJbbv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eteUJbbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736821112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMiO78zk7MaHUEVJBvuQE73KBuKkV5ITS7yQXGCIoKg=;
	b=eteUJbbvUkWUGL6X4qfhjLOsSHIOzWa+GPJEgQF+29oN681XHz2rvPRJRTvSnETP42U37n
	y/ElaeuEVj8o8Kkh00i1VDVLVRCCE+S4+H56wjn+IxPrj12/qHzp293IPCjRMiP7usGo/L
	/o3G4fpor3DQwPcgXZNyOvJiwk/a93k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-SvNBHfKTPcuZDcQ6HVwyWQ-1; Mon, 13 Jan 2025 21:18:28 -0500
X-MC-Unique: SvNBHfKTPcuZDcQ6HVwyWQ-1
X-Mimecast-MFC-AGG-ID: SvNBHfKTPcuZDcQ6HVwyWQ
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3d9d6293fso4274319a12.0
        for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 18:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821107; x=1737425907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMiO78zk7MaHUEVJBvuQE73KBuKkV5ITS7yQXGCIoKg=;
        b=lgnTap2znBbRjw06XvmuyF4jcd0/mIax1LQppPxRCo8M3OS9L+XqLyFzf8zieSXJ/O
         qZdGF88cBByROFuKY2CD3IoPdU7b/ju/DETMJ81MHXLxjsBkRwcdYfKc7r7GMaN/wQX8
         PLS8aGpAvKqth4DF2FmAsoBLjNrFibPOIzj3Lvq98k0LGbVsfJbjVWMpUcd4DP+WZCft
         Uxi8hFVkLrl05IvfO5sXo9PlQdp8ilEF47AQUole+4cEHWeEW2E3TVDGj1yplz5s19BP
         vSV9w/d+0Hz5rN2h1FOD0s8HwC6CWjnmhwNgsvtloTgpUb9uMqhvEdnKdKNDVOIqDHxe
         IhxA==
X-Forwarded-Encrypted: i=1; AJvYcCXuHuHaEwAljFFgUGri9s/3HfjKC9TWzR6E7WYlJGExfB/rhh+R1d9JvXlsDhHYqCSpLpgeQQ+XFt6wvkXfsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaXgJVeQg5EnBTFahwAMCWZwGAB8KGkVjfvzh0QWEIhvYivRs5
	GS96F3UY1R2IOei28b3rfWDU6LtS2ySR0uB02h12PrRh2BsUYMJmz4dHZOW0T1v0diN3INTWGfz
	NgoBH1Q/JOYBL6XyAl/CJraTO2ew428SJ7MAYut3LP50nQ0K85Il55tyPdtaiLivL1g/GkCWJpj
	pRxKCzVpp/ylq7p1Ux5bdg0mi4gwHccTJqsB9ggOQ=
X-Gm-Gg: ASbGncvPOKB/mkkKv0Qp61xI0UNBE5EkDHYRdttoLix6bh1xlIq5p7DPQmhbskRdM3Z
	GwMNcIk/6WGsIh84Z5yaROaVcE+7B+/d+tab0Mr8=
X-Received: by 2002:a05:6402:274a:b0:5d8:253:b7df with SMTP id 4fb4d7f45d1cf-5d972e48659mr21444185a12.27.1736821107571;
        Mon, 13 Jan 2025 18:18:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwN87+SW/CJ0q5w+fFyKwkjmaOPTvcpYsKJ3Urzea1zeBUktcHwkxUS7fJj9IS1+DiptMQz+3daJxYmSuTs6w=
X-Received: by 2002:a05:6402:274a:b0:5d8:253:b7df with SMTP id
 4fb4d7f45d1cf-5d972e48659mr21444164a12.27.1736821107249; Mon, 13 Jan 2025
 18:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250111033454.26596-1-wh1sper@zju.edu.cn> <bae5ca72-c6ff-4412-a317-4649f2d09cdf@oracle.com>
 <481cd60a-d633-4251-bb53-d3026e005930@oracle.com>
In-Reply-To: <481cd60a-d633-4251-bb53-d3026e005930@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 14 Jan 2025 10:17:50 +0800
X-Gm-Features: AbW1kvYpBkzrOO9_Y543NCMNGVFyPvt5bcHTDPNALBdClEeextvc706FXuGRAh4
Message-ID: <CAPpAL=xC7+f_8V4D==JvZxs5X-CePa_VftOH=KDc8H1vPSNp9w@mail.gmail.com>
Subject: Re: [PATCH] vhost/scsi: Fix improper cleanup in vhost_scsi_set_endpoint()
To: Haoran Zhang <wh1sper@zju.edu.cn>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
	stefanha@redhat.com, eperezma@redhat.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mike Christie <michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GMhBs3aYJdl50C9mdOxy-o49uPDGW3Vuqg7BAMW4dHE_1736821108
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net regression tests, everything works fine=
.

Tested-by: Lei Yang <leiyang@redhat.com>


On Mon, Jan 13, 2025 at 5:20=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 1/12/25 11:35 AM, michael.christie@oracle.com wrote:
> > So I think to fix the issue, we would want to:
> >
> > 1. move the
> >
> > memcpy(vs_tpg, vs->vs_tpg, len);
> >
> > to the end of the function after we do the vhost_scsi_flush. This will
> > be more complicated than the current memcpy though. We will want to
> > merge the local vs_tpg and the vs->vs_tpg like:
> >
> > for (i =3D 0; i < VHOST_SCSI_MAX_TARGET; i++) {
> >       if (vs_tpg[i])
> >               vs->vs_tpg[i] =3D vs_tpg[i])
> > }
>
> I think I wrote that in reverse. We would want:
>
> vhost_scsi_flush(vs);
>
> if (vs->vs_tpg) {
>         for (i =3D 0; i < VHOST_SCSI_MAX_TARGET; i++) {
>                 if (vs->vs_tpg[i])
>                         vs_tpg[i] =3D vs->vs_tpg[i])
>         }
> }
>
> kfree(vs->vs_tpg);
> vs->vs_tpg =3D vs_tpg;
>
> or we could just allocate the vs_tpg with the vhost_scsi like:
>
> struct vhost_scsi {
>         ....
>
>         struct vhost_scsi_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
>
> then when we loop in vhost_scsi_set/clear_endpoint set/clear the
> every vs_tpg entry.
>

