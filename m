Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658151FC0EA
	for <virtualization@lists.linux.dev>; Mon,  9 Jun 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749449462; cv=none; b=sLHymNWHVKqV1RvBUo0NFxsmXyTtfboBJi386x/4HWZ5dd0cgckt9mHB3fu4H2ye2W/Fw1f6bEY81/IsBx395tSyDivAq+adNyUaEBItQUZz1+4UTfnDmD2aIpd5Aobd7KQrLcb3yql7sYrMTcl54d3D0QsKAjN5ttFVa43WDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749449462; c=relaxed/simple;
	bh=6B//4am4kf0/sPk4mJgCJJwvxYd2J+xNJ7hXmBZcR0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sp8y917ojeFd38fYuJ4XokmIbw9aYdtQE3xP9pyg22PcKPtzr64sKBJr+l3vjMdrnwCx3Cvr8oFA9b8omaoZHhBYa8kQXmry0uCoMsutn5/YjbUsXgh/audUDd4KVDJnDvIwBducaWpui33oQmRkqqfP97SYcX7znAHsTeaQC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwP97CWY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwP97CWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749449459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fAHnSUgbK0T/Jvj5lZ7rfRDImFhPiFzgFqOeLLWznI=;
	b=NwP97CWYXVxlEIETOV0qPtvl7p1Jkf96AEsk5cDgmkxUIfKWmLUUU/v3BgiFZmxskJ4DVn
	6Q0zJ7/kQ5mbyAfjZNay9R4bcXZUZq2iokBc5EvLLCog/URfswP2BpIywmBmZCUwow8iEB
	UYTOAc6w6EOaVVFbDnrpmx1qRNJ7UU0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-Iay-IQzVNamlhLDtLjwOPg-1; Mon, 09 Jun 2025 02:10:56 -0400
X-MC-Unique: Iay-IQzVNamlhLDtLjwOPg-1
X-Mimecast-MFC-AGG-ID: Iay-IQzVNamlhLDtLjwOPg_1749449455
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b26eec6da92so3917525a12.1
        for <virtualization@lists.linux.dev>; Sun, 08 Jun 2025 23:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749449455; x=1750054255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fAHnSUgbK0T/Jvj5lZ7rfRDImFhPiFzgFqOeLLWznI=;
        b=PVPi0M1mZzomWMcAWxhvvZbO6qwGWpcbOPsbcHZ/DR95Tf9tDOHSLLAm80CbQtdVAR
         MG+pOhWLhw1zxwCLA6Ss2easrfOglxE8y5CKEDxDDoggx7MOsMvd2EQxKInLwDTGOoVq
         CDs3EHLndEpUJwJHgAjyIdCMQWEjuvmhD68vrfoVHGffom2oLDocKnaMdPDGLqMFVEIs
         y1bYaHHUpVboqUnN/Z0ClMLPpbcXz2HThk8k3/5afNHhHwqBXWHvujDhkQyNcMjCOXie
         R/Nz5TnlMYgg4T+ybzC1ZHQsTK7Jt4+GAGUgAzU8WFGPfOZSuy2oirRuap8PGYcBpJpF
         Q6qg==
X-Forwarded-Encrypted: i=1; AJvYcCWflq20yGeKSmjtInuqz62OcGEyVY3ad2yQYvPXGRo4tnZ1Dn1jNcE5Sn4GdE3Ven5YVHkHe0zEQFU2EIbATA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQzeC7dwPZ5gU+Bq3EDd8zp0B6zyBkDl+9ZAwMuE+kp4dO4n4w
	aruXz3T+mgav06qg43Z+mZtd2/AH2NkAvyrW4GhjteyzawLUpP4oGd9oUVXHYmn2WWTx8GO4Znk
	j48crM9O2rqkbrUesGrZe8LJ8hXa2JHxWuPvhfvqQPJxQXmYd4n9auVWhb9lHOoAikmK/DAAuWi
	KhU2iE1eUfiyy3+cov73IKrJve7ejUvrlq0tl3omoyx6k=
X-Gm-Gg: ASbGnctVodQAJAIAr6+Qaw9vOiI7Sx7cowSYQ/KLnvH1F+msQVSyFhjEgLc7v/P0eh0
	b3pS7bBsvAiXJ0kYHBPZF0d8B+0k28z+VdGh4/Lvy5k7q056GLDJWVPBej1vNnkoAh6S6WYO6yE
	pSFA==
X-Received: by 2002:a17:90b:2802:b0:310:8d4a:4a97 with SMTP id 98e67ed59e1d1-313666b18d2mr10246577a91.15.1749449455520;
        Sun, 08 Jun 2025 23:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6/2UHn7/Uo8w2el5l2Rn8LGz769MNneYKHjrmdgTaipoeImVc5NlpqZY+cvQ12Vc/NyTuf6CIGXI035ffYfA=
X-Received: by 2002:a17:90b:2802:b0:310:8d4a:4a97 with SMTP id
 98e67ed59e1d1-313666b18d2mr10246553a91.15.1749449455207; Sun, 08 Jun 2025
 23:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250606115012.1331551-1-eperezma@redhat.com> <20250606115012.1331551-2-eperezma@redhat.com>
 <CACGkMEsw2taXgW11na2CFK6W03c=x=wMn3iwNZPypgPkeSU06Q@mail.gmail.com> <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
In-Reply-To: <CACGkMEvinV7Zd+xddnxcerFbw_c+RZypkeD5HaN8=g6+peZvMQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 9 Jun 2025 08:10:19 +0200
X-Gm-Features: AX0GCFunBg0u2F00zqo-pilSrjGR2wWnYVAnlGyKdS6mvzmpjVUJMCnjdbab8LA
Message-ID: <CAJaqyWeetDsdoDzVrN-n0+jr97MBPeHdTxeM3ttmNUeLK702VA@mail.gmail.com>
Subject: Re: [RFC 1/6] vduse: add v1 API definition
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r2UgE-8pM1IEAzyUu4B8WAlR-MKiFSQN5lCrIsHQ7Ms_1749449455
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:50=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Jun 9, 2025 at 9:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Fri, Jun 6, 2025 at 7:50=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > This allows to define all functions checking the API version set by t=
he
> > > userland device.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >
> > It might be worth clarifying how it works.
> >
> > For example,
> >
> > 1) would VDUSE behave differently or if it's just some new ioctls

I'd like to test more in-depth, but a device can just bump the version
ID and then implement the replies to the vduse messages. No need to
implement new ioctls. If the VDUSE device sets 0 in either number of
ASID or vq groups, the kernel assumes 1.

But you have a very good point here, I think it is wise to evaluate
the shortcut of these messages in the VDUSE kernel module. If a VDUSE
device only has one vq group and one ASID, it can always return group
0 and asid 0 for everything, and fail every try to ser asid !=3D 0. This
way, the update is transparent for the VDUSE device, and future
devices do not need to implement the reply of these. What do you
think?

> > 2) If VDUSE behave differently, do we need a ioctl to set the API
> > version for backward compatibility?
>
> Speak too fast, there's a VDUSE_SET_API_VERSION actually.
>
> I think we need to think if it complicates the migration compatibility or=
 not.
>

Do you mean migration as "increase the VDUSE version number", not "VM
live migration from vduse version 0 to vduse version 1", isn't it? The
second should not have any problem but I haven't tested it.

> > 3) If it means a brunch of new ioctls, could userspace just probe the
> > new ioctls instead?
> >
> > Thanks
>
> Thanks
>
> >
> > > ---
> > >  include/uapi/linux/vduse.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index 68a627d04afa..9a56d0416bfe 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -10,6 +10,10 @@
> > >
> > >  #define VDUSE_API_VERSION      0
> > >
> > > +/* VQ groups and ASID support */
> > > +
> > > +#define VDUSE_API_VERSION_1    1
> > > +
> > >  /*
> > >   * Get the version of VDUSE API that kernel supported (VDUSE_API_VER=
SION).
> > >   * This is used for future extension.
> > > --
> > > 2.49.0
> > >
>

