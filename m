Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE102DC779
	for <virtualization@lists.linux-foundation.org>; Wed, 30 Apr 2025 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984108; cv=none; b=WXvbdmpgY2+9u8phR9n5i2HV0BSk8CpGZR1ilUOoeBI6ZLAlNDn7XnkShCF+STaSlfK3IskP1Lk0qr92TVkfY8Xn8i5X4Z3k7sIwX/iHomWeuRxpaWpMJgMzyDMYCUVfy1Aeb5W8C4Xvk/2a7wYpKI9+mO+abEIZCI9lcBHv1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984108; c=relaxed/simple;
	bh=8CP1/l95AAIu2RBu8lBb5i+OSNRKCka5XvJ9McWKyls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3VAx4V6CVfzaMucqm+LpjlAGYEGxcLhNXDSgSaIpU2/Rc8hKo0ijd5RBdyp0wLE8Ipj89xal4+CuMKnPE8ExqF8b3KeBUPUWJsbDdRmD26Sm6ZF3ZaLBcwJXgLvJg0IiMU+YW25NSKLDbZ7RhEcS6+ZKkx9zCUZkSD7bKlqm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FieXGz9m; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FieXGz9m"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9116940C1E
	for <virtualization@lists.linux-foundation.org>; Wed, 30 Apr 2025 03:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uO63N0lFDGCn for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Apr 2025 03:35:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BDCCD40284
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDCCD40284
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FieXGz9m
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BDCCD40284
	for <virtualization@lists.linux-foundation.org>; Wed, 30 Apr 2025 03:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745984104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8CP1/l95AAIu2RBu8lBb5i+OSNRKCka5XvJ9McWKyls=;
	b=FieXGz9mx24aDJurQtnn+1aPc8U2A0WJD36kt3NDdO04fDFviNLmMdplsj8BeLx7nbsR9f
	NelsIKgldj48cY1oE+lKtonvDXrU6eTmfx3ljoCjDDXfSo+qCfVJJOX0fYbVabe3G6lb62
	IwnMxb6fzUWsjfWeN+KItcRaEkwP7WM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-6kM6QWFYPZWtn_r8R-7i6A-1; Tue, 29 Apr 2025 23:35:02 -0400
X-MC-Unique: 6kM6QWFYPZWtn_r8R-7i6A-1
X-Mimecast-MFC-AGG-ID: 6kM6QWFYPZWtn_r8R-7i6A_1745984101
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3085f5855c4so5908977a91.1
        for <virtualization@lists.linux-foundation.org>; Tue, 29 Apr 2025 20:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745984101; x=1746588901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CP1/l95AAIu2RBu8lBb5i+OSNRKCka5XvJ9McWKyls=;
        b=o4JiGVFd63IRa018pogmtnl+Ds7n1CmlCaaPD5vUIsLQovu5BbVRNXKPmUWV+BlGHd
         KPjm7bk0LeVlLJmFdnkQAdL5rWNuEgdxzmOg2bvYHxMgBvssgULILFwi8ZJcVv60drzF
         NV5BO5Ocz9A1pyZJuI2bMspWy/GqQdFGT3oyB+R4UXoWDZUQgCoksCJe1FgMAl5yd9Il
         xPfatawKgNYbYKE+cvaEM4YUIWfoqSLSLbTc6z0KpIlKQLtoVldZycRcSHqTBSpBjcIw
         1vdM4qDkDaOJkOsYJ0CZdVUXewkju5S804QzytXu/AmZY1dBKSzMNKkUw2RFPp12aR5w
         odTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhCKSaCH7I4Ezl0njUlNWR4EizJBnRoGMEddvIXj9ztUuqD78IjlP8HmOExDAITBy6e0QfuKpRbZvHE3yJfQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwusBxmwexT84lnJhZ4d5p2Zn7ZyEEzCShTZcokkNBNxnkJHThj
	rqRPcXSOVa3jjzFsna3QP7JjvT+oYze/MhUrrMBaSv9yqTJfceqmYLVQh/w1/C3tDlcCbk+xfq/
	4bAaiyn8e9mZRVmsGbs9JBwVY9PY8qUhqhar/xs1k9MCMLfZ7lwK4IQ6PjDE1+JKVA6dlzBUuSK
	VQgXGGILGdMTuWKBpenH478WvLdSwAcXRZcdQF24XQklGwFwjgQPhV8A==
X-Gm-Gg: ASbGncual59BPeAjT1Msbwwm8RmEY8XR+GjugAsXkZcl0/dTVMvIinqU5HWX4Tit2Q0
	CKtKONjxyM7v7MooXyZdX6NwR837pZyvixf9ySI/5O9HaUpqE1YUIugwMaPZD1q0XAJsg
X-Received: by 2002:a17:90a:d883:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-30a3331ef58mr1953076a91.19.1745984101055;
        Tue, 29 Apr 2025 20:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSS7dOdgP7A+HNpiMxiMx5KPQzzq0FQebByqw2CgDOWtoUxx+JmBHparnOyVfe7iSSZKWz7P4f0WwnDi967iI=
X-Received: by 2002:a17:90a:d883:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-30a3331ef58mr1953058a91.19.1745984100613; Tue, 29 Apr 2025
 20:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com> <20250429065044-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250429065044-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Apr 2025 11:34:49 +0800
X-Gm-Features: ATxdqUHqfIZKZZ7USbEVYrV7yi8BrNiRLgIgSnFckLR6vC0VClLgTNwjOGLKeT4
Message-ID: <CACGkMEteBReoezvqp0za98z7W3k_gHOeSpALBxRMhjvj_oXcOw@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tbNL5gq1CX8HS7su136ri8HvQxj1Jft-OIF1e_y0VHw_1745984101
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 6:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> > On Mon, Apr 21, 2025 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > >
> > > > On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com>=
 wrote:
> > > > >
> > > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL=
`,
> > > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > > is disabled, and any attempt to use it will result in failure.
> > > >
> > > > I think we need to describe why the default value was chosen to be =
false.
> > > >
> > > > What's more, should we document the implications here?
> > > >
> > > > inherit_owner was set to false: this means "legacy" userspace may
> > >
> > > I meant "true" actually.
> >
> > MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> > applications need to be modified in order to get the behaviour
> > recovered which is an impossible taks.
> >
> > Any idea on this?
> >
> > Thanks
>
> At this point, as we changed the behaviour, we have two types of legacy a=
pplications
> - ones expecting inherit_owner false
> - ones expecting inherit_owner true

Considering vhost has been used for more than a decade, I would expect
more will expect inhert_owner to be false.

>
> Whatever we do, some of these will have to be changed.

If we must choose one to break, I'd expect to break less.

> Given current
> kernel has it as true, and given it is a cleaner behaviour that will
> keep working when we disable CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL in 10
> years, I think it's the better default.

The problem is, if we set it to true and only an ioctl will bring the
old behavior back. Who will use this ioctl? We can't modify all legacy
applications.

> If you want to change it transparently, look for ways to
> distinguish between the two types.
>
> The application in question is qemu, is it not?

Looks not, it's the application or management layer that tries to set
the affinity to the owner of the vhost.

For example, if I start a testpmd + vhost_net and pinn testpmd runs on
cpu0. I will get half of the performance since vhost will contend with
cpu with testpmd.

> I do not see how sticking an ioctl call into its source is such
> a big deal, if this is what we want to do.
> A bit of short term pain but we get clear maintainable semantics.

What's more important, the way that introduces new fork behaviors
without a new uAPI is a bug. We need to fix that by introducing new
uAPI for the behaviour. This seems to be the short term pain instead
of introducing new uAPI for the old behaviour.

Thanks

>
> --
> MST
>

