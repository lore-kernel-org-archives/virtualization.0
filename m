Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED94C7C
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721010391; cv=none; b=dlzZ6eb2axVnU+v2h/dykljjN87ZnImHy1MMXqe3Q6U3GJLxy2BE0q1Yturz3sVO4CCOXMS6ufhBQWYngQLzGGLnU6wVqE3TAI5DdbhXPjkDCznBpf/EYBipO3UL4wogMBvhXfxd3aFJ/IVv0Yqo5RMOKfg81p00F45yOAYyyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721010391; c=relaxed/simple;
	bh=SGA3prCIJJ3llNRdzo4QP/2bUfApjHDjg1r3KYXgOC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYidm6ryzbGDGtHjF8osXyMQNrR18RqSSyX2v5qJ+wKeJ8JoTUJ9RGCOD5OWaL91oNBjvIr/BATCaqk1SmCcYoodKNzCtwLugRjHHnM0y3SEIosDLSx0Mpd1XxhOS6TQ+iBT3CmK1qAdn8dO3biIMLyad5t9isTGhs86Xxn/Vo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeYibA4K; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeYibA4K"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDE4540169
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSEGBV74UAOP for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Jul 2024 02:26:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AC2B940474
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC2B940474
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SeYibA4K
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC2B940474
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Jul 2024 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721010387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGz2AvnYlX/OuYWFp42oY62WHdDe8oCr+x16py/fxm0=;
	b=SeYibA4K3KonzJ7k6iP38FHqnzwSU/vm8dPEwEX/7JQtuRUKedFGSwjj1/VlBtUFlpT03q
	tlYA/apIqAZEkh0IPXA1Vu9sjPHHyV95GBlyCvtKZxl42wg9eR6gGV/JXICGdAnaHWwBVn
	MDBXRJ9TIT6S76kvulbu3U7LVw34+eg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-dnIMCNJlP5KujLIzg_hdTg-1; Sun, 14 Jul 2024 22:26:25 -0400
X-MC-Unique: dnIMCNJlP5KujLIzg_hdTg-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5c7b088f063so2847457eaf.2
        for <virtualization@lists.linux-foundation.org>; Sun, 14 Jul 2024 19:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721010385; x=1721615185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGz2AvnYlX/OuYWFp42oY62WHdDe8oCr+x16py/fxm0=;
        b=DctNoSBJhRx0FJe722n4Aq233UdGQrBmRhdyRGZYTiV3vuVMbDpa/GrRoQTQXACYHa
         nlY6Q3voiSr4/L8VNl4TDx9LYsGSZAB/LEaCtGORLAJq1O2pVbNUJP7XN4HSYKGJDupQ
         6XzdzAMA3dH0SB6coGqdrgOO3e19TsHIlTaBnSEvzB1Lsi5oa+aC9Mrh7rhexcI23iFR
         zoqWJHjcJnv1OlsMbHCAlKSbc48RnKVvWekmCcdYGbs6GD2kfwcFMRjUbUg2WjZNNDZi
         Rb33bWdGR27Lo/RJrDTzxHFE0SMksIG0EYJBzh4Zm+yRl59uKQwqG0JPEaUY43Z1RWNG
         sMlw==
X-Gm-Message-State: AOJu0Yxr6srvfKQgtG5FQBHIsM0JmdqlvIS/xtePRQdKPu/07Y/rFLZQ
	LaCzt6FG2D/Ns9lkjETaRN5MyK/lZPveIDwPyXBVJ2m1PJ1JYug9b3G2lWrGcTuVMjXMDV7MTJ/
	epvAsPRpo0vv2Z3VUp17GFQjKeouNKlhz/HduETgJhaOBbFQtFOG+xOhc/TXh58xJLsszE9/iXe
	eErSeS/piPeuL6/OgAl5k/J6pXuFJWvD34sL9vjvPH6aKh72mIHZMXSA==
X-Received: by 2002:a05:6358:71c8:b0:19f:1644:d45e with SMTP id e5c5f4694b2df-1aade0a6299mr1900877055d.8.1721010384909;
        Sun, 14 Jul 2024 19:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrFW06pmuoNN0Sc+c5vkbGajGRrCBhFYgVDbJHm25Mox95wsQfYrdPmBV25g65b3NPEHi7agQZ/xuwxNOAtfk=
X-Received: by 2002:a05:6358:71c8:b0:19f:1644:d45e with SMTP id
 e5c5f4694b2df-1aade0a6299mr1900875355d.8.1721010384479; Sun, 14 Jul 2024
 19:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com> <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1720790333-456232-4-git-send-email-steven.sistare@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jul 2024 10:26:13 +0800
Message-ID: <CACGkMEu0sNx=saZOaVRbuV7Gz7+_GD-v42i+Bdk-NCp6syABbw@mail.gmail.com>
Subject: Re: [PATCH V2 3/7] vhost-vdpa: VHOST_NEW_OWNER
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 9:19=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> Add an ioctl to transfer file descriptor ownership and pinned memory
> accounting from one process to another.
>
> This is more efficient than VHOST_RESET_OWNER followed by VHOST_SET_OWNER=
,
> as that would unpin all physical pages, requiring them to be repinned in
> the new process.  That would cost multiple seconds for large memories, an=
d
> be incurred during a virtual machine's pause time during live update.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/vhost/vdpa.c       | 41 ++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.c      | 15 ++++++++++++++
>  drivers/vhost/vhost.h      |  1 +
>  include/uapi/linux/vhost.h | 10 ++++++++++
>  4 files changed, 67 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b49e5831b3f0..5cf55ca4ec02 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -632,6 +632,44 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>         return ret;
>  }
>
> +static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
> +{
> +       int r;
> +       struct vhost_dev *vdev =3D &v->vdev;
> +       struct mm_struct *mm_old =3D vdev->mm;
> +       struct mm_struct *mm_new =3D current->mm;
> +       long pinned_vm =3D v->pinned_vm;
> +       unsigned long lock_limit =3D PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> +
> +       if (!mm_old)
> +               return -EINVAL;
> +       mmgrab(mm_old);
> +
> +       if (!v->vdpa->use_va &&
> +           pinned_vm + atomic64_read(&mm_new->pinned_vm) > lock_limit) {
> +               r =3D -ENOMEM;
> +               goto out;
> +       }

So this seems to allow an arbitrary process to execute this. Seems to be un=
safe.

I wonder if we need to add some checks here, maybe PID or other stuff
to only allow the owner process to do this.

> +       r =3D vhost_vdpa_bind_mm(v, mm_new);
> +       if (r)
> +               goto out;
> +
> +       r =3D vhost_dev_new_owner(vdev);
> +       if (r) {
> +               vhost_vdpa_bind_mm(v, mm_old);
> +               goto out;
> +       }
> +
> +       if (!v->vdpa->use_va) {
> +               atomic64_sub(pinned_vm, &mm_old->pinned_vm);
> +               atomic64_add(pinned_vm, &mm_new->pinned_vm);
> +       }
> +
> +out:
> +       mmdrop(mm_old);
> +       return r;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cm=
d,
>                                    void __user *argp)
>  {
> @@ -876,6 +914,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>         case VHOST_VDPA_RESUME:
>                 r =3D vhost_vdpa_resume(v);
>                 break;
> +       case VHOST_NEW_OWNER:
> +               r =3D vhost_vdpa_new_owner(v);
> +               break;
>         default:
>                 r =3D vhost_dev_ioctl(&v->vdev, cmd, argp);
>                 if (r =3D=3D -ENOIOCTLCMD)
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b60955682474..ab40ae50552f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -963,6 +963,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_set_owner);
>
> +/* Caller should have device mutex */
> +long vhost_dev_new_owner(struct vhost_dev *dev)
> +{
> +       if (dev->mm =3D=3D current->mm)
> +               return -EBUSY;
> +
> +       if (!vhost_dev_has_owner(dev))
> +               return -EINVAL;
> +
> +       vhost_detach_mm(dev);
> +       vhost_attach_mm(dev);

This seems to do nothing unless I miss something.

Thanks

