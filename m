Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54A022FDF6
	for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845891; cv=none; b=V1eyrrwhNxrl5xsVHxNLvstLIMd7s9RIbLN8MbP1bIa+ETU2cFjPNfUMh3+8RweUu6zRCmOvOML1hnKrF4yqb/TB3/hIVtLzzgqOFb6Qcddkn97CbH88scjASI0dn6kotypa7U3pP+p9P14oEsoX//s5HbtaykMCKsT7diKoj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845891; c=relaxed/simple;
	bh=Ar1hMyO0wyxaPu8Q24vK58601T1l650o4aMs1l59DaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erfcldzhR3+s5+Xky0yPHzteNgZotEIb5cz7AVwXNwTUIrkmrHIqCMHRTkjhigv607EAeTALIhLPXtOFyuYTLYD0eTnvjpJhT9tTiuZB8OENdgfZoTVsO6VET1Ey1YV46BtucwQ4wQidEio2lK2PfFgdcrljzwUtwjWiYxLnF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0z3eQL/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0z3eQL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733845887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar1hMyO0wyxaPu8Q24vK58601T1l650o4aMs1l59DaA=;
	b=S0z3eQL/d9Z9wyFaLCym1JvofYtmzPH3uRVZZAB/750dXx9faTzudiB0wm2oFFVW2H/OaS
	a1IUs7RiEMIgf/uE7KikIO9WmMgItzKZO8ST9Y3AlaVSoQV/Y4U6DSWr4s1HTJfMeiNd4V
	KsMmqJ5TyrYdHjMjBOShhvO7fJ0cU9g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-ALOjKKovNnaVDnvCNDfK6A-1; Tue, 10 Dec 2024 10:51:26 -0500
X-MC-Unique: ALOjKKovNnaVDnvCNDfK6A-1
X-Mimecast-MFC-AGG-ID: ALOjKKovNnaVDnvCNDfK6A
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6ef18fc27f6so73417027b3.0
        for <virtualization@lists.linux.dev>; Tue, 10 Dec 2024 07:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845886; x=1734450686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar1hMyO0wyxaPu8Q24vK58601T1l650o4aMs1l59DaA=;
        b=T43+f5M8RkEqTd2804vO3Q0gxIgkZfeoBRk7bQi++C8UUqkh3gNupGvEi0kIOhIyoY
         j9/lr2zOemLnJqftiZSNDrNe/wP/uIgkFwhMWBcGo2Y5Z5FAx0fQ2RPgU2r+cYjUJlw6
         k2ufPfi495W0iuaD2EKRO7Qwaxr6j/xbvz8iHvdykhgD3IqSOWi33d2W9AV/7DfWmUpp
         hNe3K4fnWDcJg6J0yRtWAvwskEmctQx5nDXzva26/Orw2HSVjF/SZTT3xe5TQAwM9VVz
         AJULOkN2/dbsccYEXcTefHIoF2NMavkdOX6bgVdc/E3bDRKHM+hDdXV03F3mfwn5o81c
         UXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXusNbo4XK/mDzm+fCCAR/+CV5D9CxboAXSeqzktPKesbFErKq30gf81ArJcNiHjZF0maeW+98/uVtHLSUDg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7Ns0bOcsPpZi/v5K2HcRmqF2w4H5/z5r1OWnrVZfa4ALw/8w6
	qIux3xSDebdPAlhGLuxK74shys7am5bZiyZV5YCTUQe23b0kHMRhHsHIAy1JFymmqJiC02oI1WO
	fzfhct5s2r4GHlGrQe5P9EBjgNhu/KypmtAqmcb4a7T7qRxgJl2g0LuPiCYf8vldVvWgWSC6ZCD
	NLhxOjZGGEr8GIkk8t6jd78erm2NrzDESczy0ocy8=
X-Gm-Gg: ASbGncue1+eT6ni8FVUzoUGh6mJI+Jphg3VShSBsEEF+sDevv4BZQZENSuzabNR1FIv
	XH6GqeNdl/xz9lUxhg4AmjoUYyyYMfy7Q7CM=
X-Received: by 2002:a05:690c:45c2:b0:6ef:8e0b:8c63 with SMTP id 00721157ae682-6efe3bfaf08mr164554227b3.14.1733845884761;
        Tue, 10 Dec 2024 07:51:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG93Iqn4vCwDlWoINxZxWF91ItaNdcRuR3eeU1hcdT6Lm/nDvSRopILfRvocx9lUW31iVebaOyj7OLS6zITn5A=
X-Received: by 2002:a05:690c:45c2:b0:6ef:8e0b:8c63 with SMTP id
 00721157ae682-6efe3bfaf08mr164552727b3.14.1733845883042; Tue, 10 Dec 2024
 07:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com> <CACGkMEtPs5O25KVxN3UJX8RD5f0EhNqrqdVqt28FZSMX_W6GTg@mail.gmail.com>
In-Reply-To: <CACGkMEtPs5O25KVxN3UJX8RD5f0EhNqrqdVqt28FZSMX_W6GTg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Dec 2024 16:50:47 +0100
Message-ID: <CAJaqyWe0BHkhJWKw93tTu0iMakMqhix0DOHfhQxxU49vnXQALQ@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL
 for non-virtualized environments
To: Jason Wang <jasowang@redhat.com>
Cc: t.ampelikiotis@virtualopensystems.com, virtio-dev@lists.oasis-open.org, 
	anna@virtualopensystems.com, a.rigo@virtualopensystems.com, 
	m.paolino@virtualopensystems.com, s.raho@virtualopensystems.com, 
	chou.kensou@jp.panasonic.com, wminer@linuxfoundation.org, 
	jsmoeller@linuxfoundation.org, virtualization@lists.linux.dev, 
	stefanha@redhat.com, xuanzhuo@linux.alibaba.com, sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yLOlwUpUhWie53VucPu2C_pLm0dzSNh9X3pZmk2QYlo_1733845886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Adding Eugenio and YongJi.
>
> On Wed, Dec 4, 2024 at 11:38=E2=80=AFPM <t.ampelikiotis@virtualopensystem=
s.com> wrote:
> >
> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> >
> > We would like to share with you an RFC for the Virtio-loopback
> > technology which we have been working on at Virtual Open Systems in
> > the context of the Automotive Grade Linux community (Software defined
> > Vehicles expert group)
> >
> > We previously presented this activity (see [1]) and now we come back
> > to you with latest development and updates.
> >
> > We believe that the technology is more mature today and we would like
> > to assess the community interest in the technology itself and in
> > merging the code.
> >
> > Below we provide a brief description of the technology, recent
> > updates and a short comparison with vDUSE that might be seen as a
> > similar technology.
> >
> > 1. Overview:
> > -------
> >
> > Virtio-loopback is a hardware abstraction layer (HAL) designed for
> > non-virtualized environments based on virtio. The main objective is
> > to enable applications communication with vhost-user devices in a
> > non-virtualized environment.
> >
> > More in details, Virtio-loopback architecture consists of a new
> > transport (Virtio-loopback), a user-space application (Adapter) and
> > the vhost-user devices.
> >
> > The data path has been implemented using the "zero-copy" principle,
>
> [ ... ]
>
> > where vhost-user devices access virtqueues directly in the kernel
> > space.
>
> Eugenio used to work on a POC to bridge vhost-user to vDPA via a
> dedicated userspace application. He might share more thoughts about
> this.
>

Right, it worked well with DPDK and net. It could work as long as
vhost-user device supported iotlb messages.

The current kernel vdpa framework does not send the memory map until
the device asks for it. If we modify the kernel vdpa so it always
sends the memory map, and only waits for the userland device iotlb if
a given feature flag is negotiated, it can be compatible with all the
vhost-user devices.

I can post the code if it is useful for sure.

