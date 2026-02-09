Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48283311967
	for <virtualization@lists.linux.dev>; Mon,  9 Feb 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619334; cv=none; b=iPe4O/JXV/n9XwugGO5bHQW0MpZVuiSMlHrU3/FqGdGf6gGERew5Ki1sNBhgSgmqU4fb9orwp9cHL4slp3tgRY8x0FjCJ492CS+pQ5XQaWUjC8rtw2RyN4sKzb9BgJ4A8NCDzPqMV1BFiAmJblKZZkWTT5fsM5YJZ1TsHwzzaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619334; c=relaxed/simple;
	bh=O8cJ6Kj90NvIyQjjqT95QHWqU8SDK+V3+SP8mwmcVYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWUxSol2E5EII+6SUVODClwbvzCmWbIPdpyUoM5tbZrWABdyPcJknFLCUL+Afj0/uJKND2Bm++p734fe6h/LE/JTtJeHphCASOmhlkuDxoL2527yP/+3H0TMXXz1XCU9JvMprlJaD5fuHtkqMF2XKYYCB70FFH5FMTf5Dls7pD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcIp51Zd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcIp51Zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770619333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rAEkP/ENKOKGthOaBA1iQpwk+zp5uugkrzm6gZ8wcU=;
	b=AcIp51ZdvrrSeSz2lLcTJPB35s38Mze4+WmTjAMRhySO8xZ+l4KGYThx8QzW3nQD/5QlcR
	0lO+Zscqy0VOUAo5xrz7uVji6R8Z4XQr1YaTx1VI6Sc5r6Sq1w3kUzzNq9YMljXZNO4i5u
	swUIRdua0OsCSywz7wqLDbURzq8OgR8=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-1NefJ9oiPcCZr-Y30DqL6w-1; Mon, 09 Feb 2026 01:42:11 -0500
X-MC-Unique: 1NefJ9oiPcCZr-Y30DqL6w-1
X-Mimecast-MFC-AGG-ID: 1NefJ9oiPcCZr-Y30DqL6w_1770619331
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-94ad0ada31bso2502287241.0
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 22:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770619331; x=1771224131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+rAEkP/ENKOKGthOaBA1iQpwk+zp5uugkrzm6gZ8wcU=;
        b=lV6kwz53IkzLupMGUCSKUhvktuULa8AkVQaiE9Qy2/37tO56jLW9Xs5eZQISY17c6O
         SapT+9IC0vFT2X//g71icaoOXr/7B9zzfpzqutnsGrJipAhoOkJM2RRRb1ALNj5rRqy3
         CJEy/2nVT42ReTpRXS2dQ2yLUrJtCbpUav3EHye5Wr9QWmPj4t94sfdhWhL614sPTtPR
         nBHAes5tdmeHXytr7w0rBaSEjVobbiDbiGXcepnA6wMRHBWOM9TdpRy/LDY6oO+lvkwG
         xrVkrWmEOA632uChpLNcUEAc825mRzp0u13HkmKgi2hyQop6vCKSNsnGhLCiNi/9J/w+
         3Fog==
X-Forwarded-Encrypted: i=1; AJvYcCVRGDmTMyI+Xo4NYRPsDPkSavEEB3r0jOgt/ac34pZLaTo8JCxY49xiZGvBRKZwJeyFlB24n3n3vpWPPT5qAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJN8EFJz2V+UmCbM+dH68sKIRK7xlC6pXAnyWGxUMk+6TN4knI
	uCpmyBOdIYeT2LV3P44WJNo4E8ddjsMfDYo4RRbumqFe4050d0K7RUexTOVnEaAkl3HtK+sirkj
	M/ngJFHc542/90mUglXwggdtpoFQkQa2I7lPTkhQ1WfaS+k+JeU8WVztrouzHg0w4XqZV4RKbpf
	PybdLmR4s9tLdwOuWawd46NV/ClgI51wumYnPZ3ekRN/E=
X-Gm-Gg: AZuq6aLxof5na9CdVuzXefC2pvr26o+htbqeg2EcsCku6Ga77POVd5naCTfl9V+MYgh
	DmnqI88/+FG3fJx44MutvtpWGH9LAlrVKSI2Nx9Rzr/dOOuY0UXYbgMi5t+yI6OuAYMBbVtNGJq
	LKXiX336NQoAjItRyqwmiKZkTbMNefB0lgENJzcLFutZf00OUrkQ/yUj+cwZOZyorWPK4=
X-Received: by 2002:a05:6102:5108:b0:5ef:af68:e6bd with SMTP id ada2fe7eead31-5fae76bedd7mr2971617137.2.1770619331278;
        Sun, 08 Feb 2026 22:42:11 -0800 (PST)
X-Received: by 2002:a05:6102:5108:b0:5ef:af68:e6bd with SMTP id
 ada2fe7eead31-5fae76bedd7mr2971613137.2.1770619330991; Sun, 08 Feb 2026
 22:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260208143441.2177372-1-lulu@redhat.com> <20260208143441.2177372-2-lulu@redhat.com>
 <20260208123029-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260208123029-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 9 Feb 2026 14:41:27 +0800
X-Gm-Features: AZwV_Qiz8bHINy5XI2QvLVezbxk6iTbCBvt72uLxPgwE6Zaly7hURPFi-VGLC_8
Message-ID: <CACLfguX6o5Uj4SKsPAsX53wjuNtvCxsCgK5AzfffHpdt1NrZNQ@mail.gmail.com>
Subject: Re: [RFC 1/3] uapi: vhost: add vhost-net netfilter offload API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DT7fbhTsNW-qnXwW-IaIcOZWrdvjn72F-kH2U0dxGpg_1770619331
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

s

On Mon, Feb 9, 2026 at 1:32=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sun, Feb 08, 2026 at 10:32:22PM +0800, Cindy Lu wrote:
> > Add VHOST_NET_SET_FILTER ioctl and the filter socket protocol used for
> > vhost-net filter offload.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  include/uapi/linux/vhost.h | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index c57674a6aa0d..d9a0ca7a3df0 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -131,6 +131,26 @@
> >   * device.  This can be used to stop the ring (e.g. for migration). */
> >  #define VHOST_NET_SET_BACKEND _IOW(VHOST_VIRTIO, 0x30, struct vhost_vr=
ing_file)
> >
> > +/* VHOST_NET filter offload (kernel vhost-net dataplane through QEMU n=
etfilter) */
> > +struct vhost_net_filter {
> > +     __s32 fd;
> > +};
> > +
> > +enum {
> > +     VHOST_NET_FILTER_MSG_REQUEST =3D 1,
> > +};
> > +
> > +#define VHOST_NET_FILTER_DIRECTION_TX 1
> > +
> > +struct vhost_net_filter_msg {
> > +     __u16 type;
> > +     __u16 direction;
> > +     __u32 len;
> > +};
> > +
> > +
> > +#define VHOST_NET_SET_FILTER _IOW(VHOST_VIRTIO, 0x31, struct vhost_net=
_filter)
> > +
> >  /* VHOST_SCSI specific defines */
>
> can we get some info on what this is supposed to be doing, pls?
> it belongs here where userspace devs can find it, not hidden
> in code.
>
Hi Michael
We plan to add a new feature to support zero packet loss during live
migration, so we=E2=80=99re introducing this new UAPI. Thanks, I'll add mor=
e
information here.
Thanks
Cindy
>
> >
> >  #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_=
scsi_target)
> > --
> > 2.52.0
>

