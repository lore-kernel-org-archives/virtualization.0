Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE323C9
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 04:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjbHFGn6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65C9E4159C
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 04:11:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65C9E4159C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MjbHFGn6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJssQS5G0OWv
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 04:11:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6B3D941587
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 04:11:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B3D941587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703477501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PR0rFCSyUG2eR88FaJw5eC09XvCgcCbfqIX9eF5hqEQ=;
	b=MjbHFGn6nofgXPb3/zpZoiwj5JKObtrZpopQ3992Ad5BRsKBczqBFuv572U4g7eOt4HtAU
	mB0NGxK8pSuxtCEodKCUMm9DD6YQxIYzRBxGrnAosO22QHMuuxtaxf0qnA7gdz/cJhkNu6
	dEw09UHy9ENZb57wrVpUgo4z6frbc10=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-kMvcVdkFOFSwoMaR4t-zvw-1; Sun, 24 Dec 2023 23:11:40 -0500
X-MC-Unique: kMvcVdkFOFSwoMaR4t-zvw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28b8f963816so3961577a91.1
        for <virtualization@lists.linux-foundation.org>; Sun, 24 Dec 2023 20:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703477499; x=1704082299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR0rFCSyUG2eR88FaJw5eC09XvCgcCbfqIX9eF5hqEQ=;
        b=GRfXpz0EHS1W4a29++BNm8CYhEZshAx7AvrEjVGLiz1m6CqgSA5eD1Hx/aDSUMmW3M
         QfcZzng7NlEqCg3j5uPrBGuu5lXL09GCM1De4y6yjAUWZ0sUQZwBDJj0gwn+NwcgOWuF
         1jme3rEgY2uitX+/iNt1yLMEvmXnmVQeU20Inwaqwhtek8BIz2rmHmDMN4M6twBOOyrZ
         sLzT4Jre4Sx8BQks6pGmf5lJMM+jABio9lIZeQtv3XyaX4HSRQXJvLZ2C7Dkl2Dmx99u
         NpRmacVS2BllqqNjg1714Q1jiBk4MPs3yXvX+sJNrLgRMgxM7R+UtoCfbKrmN+G06B8M
         25Nw==
X-Gm-Message-State: AOJu0YzrB9PKPqOJkOEt6F8gX1Y+z9Y/H9Y6LeBzWuHzzGAD2pnDhAYu
	hV0T0ZKEgiNwC5UJkyDcNoyzudLVrt4k+MHmX9yZQyAxi95ZtF35+P1KWkPbBYzOiMqtVsRXb5z
	9n7BGfeXA+n1XAvKJwkS2SM6FvI2VyQ16Tco+uXqr+7I/IJPI9oYEEaVRKW9oIpOiLw==
X-Received: by 2002:a17:90a:428c:b0:28b:dc75:bef8 with SMTP id p12-20020a17090a428c00b0028bdc75bef8mr2579972pjg.22.1703477499386;
        Sun, 24 Dec 2023 20:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtxp8ucWx5dROZrp5JvDri52KPchZd12v9x5kEJ0UPnd0L9ZR0+MGTL1LiOJ9Z1GS7ksafL6q7Xk0IKUseXt0=
X-Received: by 2002:a17:90a:428c:b0:28b:dc75:bef8 with SMTP id
 p12-20020a17090a428c00b0028bdc75bef8mr2579959pjg.22.1703477499127; Sun, 24
 Dec 2023 20:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-7-dtatulea@nvidia.com>
 <CACGkMEs_kf2y9Khr==zY3RRHffaPRwS51XK33Lgv1eeanQdRpg@mail.gmail.com>
 <65064744954829b844d8a7b23bb09792cb6c2760.camel@nvidia.com> <f54a1037b515d15b24193d96d574b775eb743099.camel@nvidia.com>
In-Reply-To: <f54a1037b515d15b24193d96d574b775eb743099.camel@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Dec 2023 12:11:27 +0800
Message-ID: <CACGkMEsCrYY1bYDwOYD=XMPi0b1naJj5dGe8FXH9uMqpsf1b2A@mail.gmail.com>
Subject: Re: [PATCH vhost v4 06/15] vdpa: Track device suspended state
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Parav Pandit <parav@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"mst@redhat.com" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:22=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> On Wed, 2023-12-20 at 13:55 +0100, Dragos Tatulea wrote:
> > On Wed, 2023-12-20 at 11:46 +0800, Jason Wang wrote:
> > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvid=
ia.com> wrote:
> > > >
> > > > Set vdpa device suspended state on successful suspend. Clear it on
> > > > successful resume and reset.
> > > >
> > > > The state will be locked by the vhost_vdpa mutex. The mutex is take=
n
> > > > during suspend, resume and reset in vhost_vdpa_unlocked_ioctl. The
> > > > exception is vhost_vdpa_open which does a device reset but that sho=
uld
> > > > be safe because it can only happen before the other ops.
> > > >
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  drivers/vhost/vdpa.c | 17 +++++++++++++++--
> > > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > index b4e8ddf86485..00b4fa8e89f2 100644
> > > > --- a/drivers/vhost/vdpa.c
> > > > +++ b/drivers/vhost/vdpa.c
> > > > @@ -59,6 +59,7 @@ struct vhost_vdpa {
> > > >         int in_batch;
> > > >         struct vdpa_iova_range range;
> > > >         u32 batch_asid;
> > > > +       bool suspended;
> > >
> > > Any reason why we don't do it in the core vDPA device but here?
> > >
> > Not really. I wanted to be safe and not expose it in a header due to lo=
cking.
> >
> A few clearer answers for why the state is not added in struct vdpa_devic=
e:
> - All the suspend infrastructure is currently only for vhost.
> - If the state would be moved to struct vdpa_device then the cf_lock woul=
d have
> to be used. This adds more complexity to the code.
>
> Thanks,
> Dragos

Ok, I'm fine with that.

Thanks

