Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D72F28E5
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089255; cv=none; b=u8R5Gup6q4w6WAE99xMMmHmg+bwBXpYEjK29TeMf/gbOOhBE946HNrrQoGG8cqC5EzwlnyIzLtYn8c59bdViul8ouUKr/Zlk9ustkBpMxJrl1eMBSo+BCDL89lpZnZ/00jdRGo48pWQ9Dl3ENG76meEGnDhov1IzFkGRIkfk9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089255; c=relaxed/simple;
	bh=bqV1HCkMw7DPpKkuYjfIWhuCizBWLcm2EGFb73XZkxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYXomPs55wWjuZZxMga/wQYRMcg7tm5fI70HylFaMFKFrxHJ2uizOFw/9nAb5r9XYpl4QkcEZ4atQjtPHnqhbH4cWCzEHxVzmtzUDS+eBMdRwEzzgpkKD6g7AHzbFW+SQWpgRxaNm8pMZAEFVcN0iNkWxgdeqi8casIjJgGDV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5jhRDzu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5jhRDzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770089252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2quDjTQjJ7BxLhnVltyHuyk8k/++sE68ucbkbgciiU=;
	b=i5jhRDzu2UQBBVF2OJtlZr6ORftM3r3BtcYn9p+8kXY6NOVlBP19508q5TCEETFbEh8vZu
	+JeXaJrdcX1jV4D/9n+NyrFCovt7tPNrWQ0InPt+/NHThFQXHB9zUs6lLPXq1zFWmnljAc
	VZdsR+S7AGwhDI6u8OGtvWKaNWA3K+Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-z2Qt_Zq4P8uTUsroQMGzCA-1; Mon, 02 Feb 2026 22:27:29 -0500
X-MC-Unique: z2Qt_Zq4P8uTUsroQMGzCA-1
X-Mimecast-MFC-AGG-ID: z2Qt_Zq4P8uTUsroQMGzCA_1770089249
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so3937444a91.3
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 19:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770089248; x=1770694048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2quDjTQjJ7BxLhnVltyHuyk8k/++sE68ucbkbgciiU=;
        b=Rcw8VNoItLGuadHTG1n4dLSnmWVIwk+514goBmz0eXj3WkOr12oJRM17PTHY6EosvX
         O9ihOGdgrl8XLk2Xj3uHvXcbnsCIuEWyL5BtDeEgGx73JN/SfkIM6/HS533BHH0Fjbqe
         LRPF3DWnh24qtspbTGjHN/vn3F9jRNuG56XUTzHQyHC0h304bt08LG0JZBOsNf1Vrqyo
         UShY+dnrIheD4+qY+WXlU7Fkw35/xmww/pGhVvPZDtxWZFMMvyxOtr5L0jGQnFwIV7zW
         TPYxqafYl5mFvkcoykz7T6QRlOnIrOSai0OJzFfSuKpQR+Zvc8nADyK+PkQG2rxgczUB
         C00A==
X-Forwarded-Encrypted: i=1; AJvYcCUyE7ZKjU6SRDgwife73ZMl36AFLUVvU1u3xV8/K8HwEA1u2QcuKHyJNJ6Drw8iM6sL6LTPSQz98cHbYkmpDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwU0JvlYTTeZeoTXv0Dr5eD8klcs1D4TQmf4gp4vfXpfaVcgJOl
	TX5aOSvEk9UrxhorjAT6KrjlbWhQWfz9KiCub3FAz/RRkUcWLWmK/4/DqdWosCk+xfj68vordoH
	HFz42e+sOGHbd+XjnH2JdbocHUT9kzeXAmuUpp9WCUNHy8oHJXaX6fKQhK7Fc5UwVgv2/N+jWGp
	SyN8xWR9XSJQsoH7zKLOAnWD/g8usRXDfgBCYPtl87M84=
X-Gm-Gg: AZuq6aIA8QKix2Xz6PfrLHHS0OW875nCH35RorBHZo/U5z/zTRIZ5xuNvFVZ9CuoqDu
	yo1aUdbcAhn6ZDU9prlFEqSCfNF4cdBHyt16UZDFaq9T0OB3Lft8oCQJOee8fY4qcCinhEPmzok
	I38Auji51UUYAN9gYafPWbt1VnTWaJ9YQ6B3mh1ZTItLZGeR88Azfxdab4aAOuYQjsOuE=
X-Received: by 2002:a17:90b:4a8b:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-3543b2ebe3fmr15675339a91.6.1770089248485;
        Mon, 02 Feb 2026 19:27:28 -0800 (PST)
X-Received: by 2002:a17:90b:4a8b:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-3543b2ebe3fmr15675320a91.6.1770089248079; Mon, 02 Feb 2026
 19:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202031212.26871-1-zhangtianci.1997@bytedance.com> <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
In-Reply-To: <CACGkMEvrMC6Lh42aX=4D3yZVWx6mxpHZAw+Z6djPBw2yrLEOrw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 11:27:17 +0800
X-Gm-Features: AZwV_QiKKY-5UkTSgbJkQAvhtHyGWUXcQKc1MXlJ_r2iGovgZKzRic-YeJ64iDg
Message-ID: <CACGkMEtKZE2NQMoY8quO=Y+g=b0fMrkzg64AZ3O5w901yU9bFQ@mail.gmail.com>
Subject: Re: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9apbwdTxpRRWzuRHBdkJSLphyWh202qKSWQoZdRwn88_1770089249
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 11:23=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Feb 2, 2026 at 11:13=E2=80=AFAM Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:
> >
> > vduse_dev_read_iter():
> >     lock(msg_lock);
> >     dequeue_msg(send_list);
> >     unlock(msg_lock);
> > vduse_dev_msg_sync():
> >     wait_timeout() finish
> >     lock(msg_lock);
> >     check msg->complete is false
> >         list_del(msg);   <- double list_del() crash!
> >
> > To fix this case, we shall ensure vduse_msg is on send_list or recv_lis=
t
> > outside the msg_lock critical section.
> >
> > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> > Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> > v2:
> >  - Rewrite commit message.                        [Michael]
> >  - Add Fixes tag and cc stable email list.        [Eugenio]
> >  - Rewrite one comment.                           [Michael]
> >
> > v1: https://lkml.org/lkml/2026/1/30/323
> >
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
> >  1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index ae357d014564c..a70d0580d54e8 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
> >         struct file *file =3D iocb->ki_filp;
> >         struct vduse_dev *dev =3D file->private_data;
> >         struct vduse_dev_msg *msg;
> > +       struct vduse_dev_request req;
> >         int size =3D sizeof(struct vduse_dev_request);
> >         ssize_t ret;
> >
> > @@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *io=
cb, struct iov_iter *to)
> >
> >                 ret =3D -EAGAIN;
> >                 if (file->f_flags & O_NONBLOCK)
> > -                       goto unlock;
> > +                       break;
> >
> >                 spin_unlock(&dev->msg_lock);
> >                 ret =3D wait_event_interruptible_exclusive(dev->waitq,
> > @@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *=
iocb, struct iov_iter *to)
> >
> >                 spin_lock(&dev->msg_lock);
> >         }
> > +       if (!msg) {
> > +               spin_unlock(&dev->msg_lock);
> > +               return ret;
> > +       }
>
> Nit: this check seems to be redundant, I'd suggest to
>
> 1) move the spin_unlock() before the check of file->f_flags & O_NONBLOCK
> 2) then we can simply do "return ret" when it's a nonblocking read.
>
> > +
> > +       memcpy(&req, &msg->req, sizeof(req));
> > +       /*
> > +        * We must ensure vduse_msg is on send_list or recv_list before=
 unlock
> > +        * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout w=
hen we
> > +        * copy data to userspace, and will call list_del() for this ms=
g.
> > +        */
> > +       vduse_enqueue_msg(&dev->recv_list, msg);
> >         spin_unlock(&dev->msg_lock);
> > -       ret =3D copy_to_iter(&msg->req, size, to);
> > -       spin_lock(&dev->msg_lock);
> > +
> > +       ret =3D copy_to_iter(&req, size, to);
> >         if (ret !=3D size) {

Btw, I would like to explain why it's still safe if a (malicious)
userspace writes in this window in either commit log or here.

> > +               spin_lock(&dev->msg_lock);
> > +               /* Roll back: move msg back to send_list if still pendi=
ng. */
> > +               msg =3D vduse_find_msg(&dev->recv_list, req.request_id)=
;
> > +               if (msg)
> > +                       vduse_enqueue_msg(&dev->send_list, msg);
> > +               spin_unlock(&dev->msg_lock);
> >                 ret =3D -EFAULT;
> > -               vduse_enqueue_msg(&dev->send_list, msg);
> > -               goto unlock;
> >         }
> > -       vduse_enqueue_msg(&dev->recv_list, msg);
> > -unlock:
> > -       spin_unlock(&dev->msg_lock);
> >
> >         return ret;
> >  }
> > --
> > 2.39.5
> >
>
> Thanks

Thanks

