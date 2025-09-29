Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15512367D2
	for <virtualization@lists.linux.dev>; Mon, 29 Sep 2025 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125941; cv=none; b=bughb0oGl4eWmYwv7HNuTKIzC/GdOVUBNQNOiQtKU+8b7xvZIA/pMNL6/MOBuE94rVfcWl+WoG3faSdvq8hi3IOjk+owC2+mQhcrKl+fJ8hkJiauUEMA/Hx0dXUEljxRTy5gTAr8uq4v8bYtHd600pmvxEeRQSeD25YCQR4trZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125941; c=relaxed/simple;
	bh=9WPqzjmiWMki4xWlLoYtm9WlKZ743i+2Jltc2U63LGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGfhxepBdV7LAnzt5xWuadjMYJoLnQASasLl7q2IkGO6AfYTnXtvOEJVeI0gADxAB65Ejui55yYFIFTV6M0oLVGGXJC2vBAb6iw4jYHBDz3FeVs4KQyBqyvTebFyNONu0Iq5M9htGKvgyiyN6bHgHHrKIw2sdBbSeoetyRgkQ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cL048wyP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cL048wyP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759125938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEnOtbURDkBn/yuAWcxy2EnBdqVr8YnzLqFxCwWilb8=;
	b=cL048wyPGBB/q1YBW5mK9HYGu2gbx3IO7g+XdSUVl+pr25+3Ll0+z53uMmrlFaf8+TfY+K
	24ck22LhNxhRvAThxSKdIl9bgMvsjEVi42wHLMUPZgRfqjytGx2m/X9vOqXrF+s33sNk/k
	Fhx1403HdWCcfRo69BISzXCoxJ8FEz4=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-F61ZRIi1N6WVzauW4M5O_A-1; Mon, 29 Sep 2025 02:05:37 -0400
X-MC-Unique: F61ZRIi1N6WVzauW4M5O_A-1
X-Mimecast-MFC-AGG-ID: F61ZRIi1N6WVzauW4M5O_A_1759125937
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-63549ed72f0so5620529d50.1
        for <virtualization@lists.linux.dev>; Sun, 28 Sep 2025 23:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759125936; x=1759730736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEnOtbURDkBn/yuAWcxy2EnBdqVr8YnzLqFxCwWilb8=;
        b=bwymR9rrpV/nBi450z8LDaOt7obN9YTVFx1LxU9FdacHZG9lZ8r7bjyNCBCvXV7i7l
         9tidt76o3O12lAiRUGN3iKRCVnvqxqTXgSwZIOVTnGcEy/HUHNgNU+JA4cWZgp43ClON
         ptT/alQy0tbEECU850y/NZobzTUzakKbx+e7wS2wQVNqNNcDsLFo8AMv7EImg6Vl6QSk
         3h6ZblaqjMz/E6KSDxBxbkW7IRiZPbxzl6VoelYwoM/USVC7FnB5gTJVxOq64i0QLfH7
         Pqvu2x22p6Ujtvqe3jPH5dqxwdbpg82Ol5M4WV9UoGl78xOiRWK5UAFk+2iWy1+jmbe6
         ueCA==
X-Forwarded-Encrypted: i=1; AJvYcCXT44gm4nMDaQ6q+oM/246rvIJdYMtAtFEgiafuzAmgq+ayjMaVQA7lOi3GCF6k6DfIKmfIw0nysBhTVZT3zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhDdcnU5E7Ehpczx3t6xixlICpHge4N6qxyDk0F1L9WXbDgNNS
	98C4zFyjRSEbeca9gIUR3hL3m7/VZ/PUAeDNFwTFGgEms/xUUcxFtPMXHFbLJ7SoXZHQQ/5GawK
	iy6txR5ODqBq0mm5AzPFoMPzgLBot6RR4UcjeD2n2cYCIdLqAht0VQkfe7WT3c1NADV7QbnQYSz
	wOw5TT4kVwLLvyDNVTzQqRS5qtcHT//9dQT6AVDdt4W4MXlp8TZQc=
X-Gm-Gg: ASbGncv5zWv6t3gouUCOBsmM3ZhIRDs+M4F+d3UJmCBroGuOl+loOrjDyDJvnoHXPdk
	Vz0aVOTISwd/ZLn86QilXrZk5tKON6RTYf8BXL2jEL+JP6Cfbq/bRQLS9YHUrYWREF70jVEEIkY
	sbNzD1yp1uzutte101IDyaZd5YuqVopH6Nk0BlZvs3UWvmNDMAdpAMR0lVnJRJ2g7c33fyajURq
	oWHXW1m
X-Received: by 2002:a05:690e:2497:b0:62a:38ab:fc31 with SMTP id 956f58d0204a3-6361a70fbaamr12442139d50.14.1759125936014;
        Sun, 28 Sep 2025 23:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPkWT0XTYRzHEmtMC1RyCXLhMmcayEELVp/4odWdM3T+vaRsOTnuGwdr4KePk4Rygkx2XQiQoOU0Uftn//F5c=
X-Received: by 2002:a05:690e:2497:b0:62a:38ab:fc31 with SMTP id
 956f58d0204a3-6361a70fbaamr12442116d50.14.1759125935623; Sun, 28 Sep 2025
 23:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aNfXvrK5EWIL3avR@stanley.mountain> <20250927083043-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250927083043-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 29 Sep 2025 08:04:59 +0200
X-Gm-Features: AS18NWCNnLHKyzg0qEsFQJWCKx1nz3MigsaubwNAQ8KOkZjUMutEQnjkPj3UxJw
Message-ID: <CAJaqyWcdQbt=PUG0GKQ8euXVBZMKEURURuHDijPNpzuf2e9xWg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: Set s.num in GET_VRING_GROUP
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XhDWJH66bxtfaiHCRL1Q1dVElaJBmwMNTX9BDQaIxW4_1759125937
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 2:32=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Sep 27, 2025 at 03:25:34PM +0300, Dan Carpenter wrote:
> > The group is supposed to be copied to the user, but it wasn't assigned
> > until after the copy_to_user().  Move the "s.num =3D group;" earlier.
> >
> > Fixes: ffc3634b6696 ("vduse: add vq group support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This goes through the kvm tree I think.
>
>
> Thanks for the patch!
>
> IIUC this was in my tree for next, but more testing
> and review found issues (like this one) so I dropped it for now.
>

Yes, that's fixed in v5.

> >  drivers/vhost/vdpa.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 6305382eacbb..25ab4d06e559 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -667,9 +667,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdp=
a *v, unsigned int cmd,
> >               group =3D ops->get_vq_group(vdpa, idx);
> >               if (group >=3D vdpa->ngroups || group > U32_MAX || group =
< 0)
> >                       return -EIO;
> > -             else if (copy_to_user(argp, &s, sizeof(s)))
> > -                     return -EFAULT;
> >               s.num =3D group;
> > +             if (copy_to_user(argp, &s, sizeof(s)))
> > +                     return -EFAULT;
> >               return 0;
> >       }
> >       case VHOST_VDPA_GET_VRING_DESC_GROUP:
> > --
> > 2.51.0
>

